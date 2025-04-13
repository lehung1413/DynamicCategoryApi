CREATE PROCEDURE [dbo].[Usp_Category_AddOrUpdateCategoryConditions]
	
    @JsonData NVARCHAR(MAX) -- JSON string containing the list of CategoryConditions
AS
BEGIN
    SET NOCOUNT ON;

    -- Parse JSON data into a table format using OPENJSON
    WITH ParsedData AS (
        SELECT
            JSON_VALUE([value], '$.CategoryConditionId') AS CategoryConditionId,
            JSON_VALUE([value], '$.CategoryId') AS CategoryId,
            JSON_VALUE([value], '$.GroupId') AS GroupId,
            JSON_VALUE([value], '$.ParentGroupId') AS ParentGroupId,
            JSON_VALUE([value], '$.OrderIndex') AS OrderIndex,
            JSON_VALUE([value], '$.LogicalOperator') AS LogicalOperator,
            JSON_VALUE([value], '$.FieldOrOperatorId') AS FieldOrOperatorId,
            JSON_VALUE([value], '$.Value_String') AS Value_String,
            JSON_VALUE([value], '$.Value_Number') AS Value_Number,
            JSON_VALUE([value], '$.Value_DateTime_From') AS Value_DateTime_From,
            JSON_VALUE([value], '$.Value_DateTime_To') AS Value_DateTime_To,
            JSON_VALUE([value], '$.UpdatedBy') AS UpdatedBy
        FROM OPENJSON(@JsonData)
    )
    -- Insert new rows or update existing rows
    MERGE INTO CategoryConditions AS Target
    USING ParsedData AS Source
    ON Target.CategoryConditionId = CAST(Source.CategoryConditionId AS INT)
    WHEN MATCHED THEN
        UPDATE SET
            CategoryId = CAST(Source.CategoryId AS INT),
            GroupId = CAST(Source.GroupId AS INT),
            ParentGroupId = CAST(Source.ParentGroupId AS INT),
            OrderIndex = CAST(Source.OrderIndex AS INT),
            LogicalOperator = Source.LogicalOperator,
            FieldOrOperatorId = CAST(Source.FieldOrOperatorId AS INT),
            Value_String = Source.Value_String,
            Value_Number = CAST(Source.Value_Number AS DECIMAL(18, 2)),
            Value_DateTime_From = CAST(Source.Value_DateTime_From AS DATETIME),
            Value_DateTime_To = CAST(Source.Value_DateTime_To AS DATETIME),
            UpdatedAt = GETDATE(),
            UpdatedBy = Source.UpdatedBy
    WHEN NOT MATCHED BY TARGET THEN
        INSERT (
            CategoryId, GroupId, ParentGroupId, OrderIndex, LogicalOperator,
            FieldOrOperatorId, Value_String, Value_Number, Value_DateTime_From,
            Value_DateTime_To, CreatedAt, CreatedBy, UpdatedAt, UpdatedBy
        )
        VALUES (
            CAST(Source.CategoryId AS INT), CAST(Source.GroupId AS INT), CAST(Source.ParentGroupId AS INT), 
            CAST(Source.OrderIndex AS INT), Source.LogicalOperator, CAST(Source.FieldOrOperatorId AS INT), 
            Source.Value_String, CAST(Source.Value_Number AS DECIMAL(18, 2)), 
            CAST(Source.Value_DateTime_From AS DATETIME), CAST(Source.Value_DateTime_To AS DATETIME), 
            GETDATE(), Source.UpdatedBy, GETDATE(), Source.UpdatedBy
        );

    -- Return the IDs of all affected rows (optional)
    SELECT CategoryConditionId
    FROM CategoryConditions
    WHERE CategoryConditionId IN (
        SELECT CAST(CategoryConditionId AS INT)
        FROM ParsedData
    );
END;
