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

        -- Create temporary tables for Include and Exclude Tags
        IF OBJECT_ID('tempdb..#IncludeTags') IS NULL
            CREATE TABLE #IncludeTags (
                TagId INT PRIMARY KEY
            );
            
        IF OBJECT_ID('tempdb..#ExcludeTags') IS NULL
            CREATE TABLE #ExcludeTags (
                TagId INT PRIMARY KEY
            );

        -- Populate IncludeTags
        INSERT INTO #IncludeTags (TagId)
        SELECT DISTINCT VALUE AS TagId
        FROM CategoryConditions CC
        CROSS APPLY STRING_SPLIT(CC.Value_String, ',')
        WHERE CC.CategoryId = @CategoryId
          AND CC.FieldOrOperatorId = (SELECT MasterDataId FROM MasterData WHERE Name = 'Tags' AND Type = 'Field')
          AND CC.LogicalOperator = 'Include';

        -- Populate ExcludeTags
        INSERT INTO #ExcludeTags (TagId)
        SELECT DISTINCT VALUE AS TagId
        FROM CategoryConditions CC
        CROSS APPLY STRING_SPLIT(CC.Value_String, ',')
        WHERE CC.CategoryId = @CategoryId
          AND CC.FieldOrOperatorId = (SELECT MasterDataId FROM MasterData WHERE Name = 'Tags' AND Type = 'Field')
          AND CC.LogicalOperator = 'Exclude';

        -- Filter sessions based on Include/Exclude Tags
        SELECT DISTINCT
            S.SessionId,
            S.Title,
            S.Location,
            S.StartDate,
            S.EndDate,
            S.Description
        FROM Sessions S
        LEFT JOIN SessionTags ST ON S.SessionId = ST.SessionId
        WHERE
            -- Match all Include Tags
            NOT EXISTS (
                SELECT 1
                FROM #IncludeTags IT
                WHERE NOT EXISTS (
                    SELECT 1
                    FROM SessionTags ST2
                    WHERE ST2.SessionId = S.SessionId AND ST2.TagId = IT.TagId
                )
            )
            AND
            -- Exclude sessions with any Exclude Tags
            NOT EXISTS (
                SELECT 1
                FROM #ExcludeTags ET
                WHERE EXISTS (
                    SELECT 1
                    FROM SessionTags ST3
                    WHERE ST3.SessionId = S.SessionId AND ST3.TagId = ET.TagId
                )
            );

        -- Step 4: Cleanup temporary tables
        DROP TABLE #IncludeTags;
        DROP TABLE #ExcludeTags;

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
            'SearchSessionsByCategory',
            SYSTEM_USER,
            CONCAT('Error occurred in SearchSessionsByCategory for CategoryId: ', @CategoryId, '. Error: ', ERROR_MESSAGE())
        );

        -- Cleanup temporary tables in case of error
        IF OBJECT_ID('tempdb..#IncludeTags') IS NOT NULL
            DROP TABLE #IncludeTags;

        IF OBJECT_ID('tempdb..#ExcludeTags') IS NOT NULL
            DROP TABLE #ExcludeTags;

        -- Re-throw the error to ensure it's not silently ignored
        THROW;
    END CATCH
END;
