CREATE PROCEDURE [dbo].[Usp_Category_SearchById]
    @CategoryId INT                      -- ID of the category
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Validate the CategoryId
        IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryId = @CategoryId)
        BEGIN
            RAISERROR('CategoryId not found.', 16, 1);
            RETURN;
        END;

		/*==================== Declare Variables ======================*/
        DECLARE @ContainOperatorId INT;
        DECLARE @GreateThanOperatorId INT;
        DECLARE @LessThanOperatorId INT;
        DECLARE @IncludeOperatorId INT;
        DECLARE @ExcludeOperatorId INT;
        -- Process additional conditions
        DECLARE @ConditionSql NVARCHAR(MAX) = N' WHERE 1 = 1';
		
		/*==================== Set Variables ======================*/
		SET @ContainOperatorId = (SELECT MasterDataId FROM MasterData WHERE Name = 'Contain' AND Type = 'Operator')
		SET @GreateThanOperatorId = (SELECT MasterDataId FROM MasterData WHERE Name = 'GreaterThan' AND Type = 'Operator')
		SET @LessThanOperatorId = (SELECT MasterDataId FROM MasterData WHERE Name = 'LessThan' AND Type = 'Operator')
		SET @ExcludeOperatorId = (SELECT MasterDataId FROM MasterData WHERE Name = 'Exclude' AND Type = 'Operator')
		SET @IncludeOperatorId = (SELECT MasterDataId FROM MasterData WHERE Name = 'Include' AND Type = 'Operator')

        -- Create temporary tables for Include/Exclude Tags and Filtered Sessions
        CREATE TABLE #IncludeTags (TagId INT PRIMARY KEY);
        CREATE TABLE #ExcludeTags (TagId INT PRIMARY KEY);
        CREATE TABLE #FilteredSessions (SessionId INT PRIMARY KEY);

        -- Populate IncludeTags
        INSERT INTO #IncludeTags (TagId)
        SELECT DISTINCT CAST(VALUE AS INT) AS TagId
        FROM CategoryConditions CC
        CROSS APPLY STRING_SPLIT(CC.Value_String, ',')
        WHERE CC.CategoryId = @CategoryId
          AND CC.FieldName = 'Tag'
          --AND CC.ConditionOperator = 'AND'
          AND CC.OperatorId = @IncludeOperatorId;

        -- Populate ExcludeTags
        INSERT INTO #ExcludeTags (TagId)
        SELECT DISTINCT CAST(VALUE AS INT) AS TagId
        FROM CategoryConditions CC
        CROSS APPLY STRING_SPLIT(CC.Value_String, ',')
        WHERE CC.CategoryId = @CategoryId
          AND CC.FieldName = 'Tag'
          --AND CC.ConditionOperator = 'AND'
          AND CC.OperatorId = @ExcludeOperatorId;

        -- Pre-filter Sessions based on Exclude Tags
        INSERT INTO #FilteredSessions (SessionId)
        SELECT DISTINCT S.SessionId
        FROM Sessions S
        LEFT JOIN [dbo].[R_SessionTags] ST ON S.SessionId = ST.SessionId
        LEFT JOIN #ExcludeTags ET ON ST.TagId = ET.TagId
        WHERE ET.TagId IS NULL; -- Exclude sessions that match Exclude Tags

		 
        -- Step 6: Apply Include Tags filter
        IF EXISTS (SELECT 1 FROM #IncludeTags)
        BEGIN
            DELETE FROM #FilteredSessions
            WHERE SessionId NOT IN (
                SELECT S.SessionId
                FROM Sessions S
                JOIN [dbo].[R_SessionTags] ST ON S.SessionId = ST.SessionId
                JOIN #IncludeTags IT ON ST.TagId = IT.TagId
                GROUP BY S.SessionId
                HAVING COUNT(DISTINCT IT.TagId) = (SELECT COUNT(*) FROM #IncludeTags)
            );
        END;


        -- Step 7: Build dynamic SQL for additional conditions (e.g., Location, Date)
        DECLARE @Sql NVARCHAR(MAX) = N'
            SELECT DISTINCT
                S.SessionId,
                S.Title,
                S.Location,
                S.StartDate,
                S.EndDate,
                S.Description
            FROM Sessions S
        ';

		IF EXISTS (SELECT TOP 1 1 FROM #IncludeTags) AND EXISTS (SELECT TOP 1 1 FROM #ExcludeTags)
		BEGIN
			SET @Sql = @Sql + ' INNER JOIN [dbo].[R_SessionTags] ST ON S.SessionId = ST.SessionId ';
			--@ConditionSql = ' AND '

			IF EXISTS (SELECT TOP 1 1 FROM #IncludeTags)
			BEGIN
				SET @Sql = @Sql + ' INNER JOIN #IncludeTags IT ON IT.TagID = ST.TagId';
			END

			IF EXISTS (SELECT TOP 1 1 FROM #ExcludeTags)
			BEGIN
				SET @Sql = @Sql + ' LEFT JOIN #ExcludeTags ET ON ET.TagID = ST.TagId';
				SET @ConditionSql = @ConditionSql + ' AND ET.TagId IS NULL '
			END
		END
		
        -- Location Conditions
        SELECT @ConditionSql = @ConditionSql + STRING_AGG(
            CASE 
                WHEN OperatorId = @ContainOperatorId THEN 
                    CONCAT(ConditionOperator, ' S.Location LIKE ''%', Value_String, '%''')
                ELSE ''
            END, ' ')
        FROM	CategoryConditions
        WHERE	CategoryId = @CategoryId 
			AND FieldName = 'Location';


        -- Date Conditions
        SELECT @ConditionSql = @ConditionSql + STRING_AGG(
            CASE 
                WHEN OperatorId = @GreateThanOperatorId AND FieldName = 'StartDate' THEN 
                    CONCAT(ConditionOperator, ' S.StartDate >= ''', CONVERT(NVARCHAR, Value_DateTime_From, 120), ''' ')
                WHEN OperatorId = @LessThanOperatorId AND FieldName = 'EndDate' THEN 
                    CONCAT(ConditionOperator, ' S.EndDate < ''', CONVERT(NVARCHAR, Value_DateTime_To, 120), ''' ')
                ELSE ''
            END, ' ')
        FROM CategoryConditions

        -- Append Additional Conditions
        IF LEN(@ConditionSql) > 0
        BEGIN
            SET @Sql = @Sql + @ConditionSql;
        END;
		
        -- Execute the dynamic SQL
        EXEC sp_executesql @Sql;

        -- Cleanup Temporary Tables
        DROP TABLE #IncludeTags;
        DROP TABLE #ExcludeTags;
        DROP TABLE #FilteredSessions;

    END TRY
    BEGIN CATCH
        -- Log error details into AuditLogs
        INSERT INTO AuditLogs (
            Event,
            TableName,
            ActionBy,
            Details
        )
        VALUES (
            'ERROR',
            '[Usp_Category_SearchById]',
            SYSTEM_USER,
            CONCAT('Error occurred in [Usp_Category_SearchById] for CategoryId: ', @CategoryId, '. Error: ', ERROR_MESSAGE())
        );

        -- Cleanup temporary tables in case of error
        IF OBJECT_ID('tempdb..#IncludeTags') IS NOT NULL
            DROP TABLE #IncludeTags;

        IF OBJECT_ID('tempdb..#ExcludeTags') IS NOT NULL
            DROP TABLE #ExcludeTags;
			
        IF OBJECT_ID('tempdb..#FilteredSessions') IS NOT NULL
            DROP TABLE #FilteredSessions;
        -- Re-throw the error to ensure it's not silently ignored
        THROW;
    END CATCH
END
