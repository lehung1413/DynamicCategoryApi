CREATE TABLE [dbo].[R_CategoryFilterConditions]
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CategoryId BIGINT NOT NULL,
    IncludeTagIds NVARCHAR(200),   -- comma-separated: '1,2,3'
    ExcludeTagIds NVARCHAR(200),
    Location NVARCHAR(100),
    StartTime DATETIME2,
    EndTime DATETIME2,
    CreatedAt DATETIME2 DEFAULT GETDATE(),
    ModifiedAt DATETIME2 DEFAULT GETDATE(),
    CreatedBy NVARCHAR(50),
    ModifiedBy NVARCHAR(50),
)
