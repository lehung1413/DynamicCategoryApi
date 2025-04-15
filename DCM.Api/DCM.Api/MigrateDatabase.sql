USE [master]
GO
/****** Object:  Database [DCM]    Script Date: 4/15/2025 12:55:15 AM ******/
CREATE DATABASE [DCM]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DCM', FILENAME = N'C:\Users\lehun\DCM.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DCM_log', FILENAME = N'C:\Users\lehun\DCM_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DCM] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DCM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DCM] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DCM] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DCM] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DCM] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DCM] SET ARITHABORT OFF 
GO
ALTER DATABASE [DCM] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DCM] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DCM] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DCM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DCM] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DCM] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DCM] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DCM] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DCM] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DCM] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DCM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DCM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DCM] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DCM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DCM] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DCM] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DCM] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DCM] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DCM] SET  MULTI_USER 
GO
ALTER DATABASE [DCM] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DCM] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DCM] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DCM] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DCM] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DCM] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [DCM] SET QUERY_STORE = OFF
GO
USE [DCM]
GO
/****** Object:  Table [dbo].[AuditLogs]    Script Date: 4/15/2025 12:55:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditLogs](
	[AuditId] [int] IDENTITY(1,1) NOT NULL,
	[Event] [nvarchar](255) NOT NULL,
	[TableName] [nvarchar](255) NULL,
	[RecordId] [int] NULL,
	[ActionBy] [nvarchar](255) NOT NULL,
	[ActionAt] [datetime] NULL,
	[Details] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[AuditId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 4/15/2025 12:55:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoryConditions]    Script Date: 4/15/2025 12:55:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryConditions](
	[CategoryConditionId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[FieldName] [nvarchar](20) NOT NULL,
	[OrderIndex] [int] NOT NULL,
	[ConditionOperator] [nvarchar](10) NULL,
	[OperatorId] [int] NOT NULL,
	[Value_String] [nvarchar](max) NULL,
	[Value_Number] [decimal](18, 2) NULL,
	[Value_DateTime_From] [datetime] NULL,
	[Value_DateTime_To] [datetime] NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryConditionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MasterData]    Script Date: 4/15/2025 12:55:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MasterData](
	[MasterDataId] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[DataId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[MasterDataId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_SessionSpeakers]    Script Date: 4/15/2025 12:55:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_SessionSpeakers](
	[RSessionSpeakerId] [int] IDENTITY(1,1) NOT NULL,
	[SessionId] [int] NOT NULL,
	[SpeakerId] [int] NOT NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[SessionId] ASC,
	[SpeakerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_SessionTags]    Script Date: 4/15/2025 12:55:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_SessionTags](
	[RSessionTagId] [int] IDENTITY(1,1) NOT NULL,
	[SessionId] [int] NOT NULL,
	[TagId] [int] NOT NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[SessionId] ASC,
	[TagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_SpeakerTags]    Script Date: 4/15/2025 12:55:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_SpeakerTags](
	[RSpeakerTagId] [int] IDENTITY(1,1) NOT NULL,
	[SpeakerId] [int] NOT NULL,
	[TagId] [int] NOT NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[SpeakerId] ASC,
	[TagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sessions]    Script Date: 4/15/2025 12:55:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sessions](
	[SessionId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Location] [nvarchar](255) NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[SpeakerCount] [int] NULL,
	[MaxCapacity] [int] NULL,
	[CurrentEnrollment] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[SessionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Speakers]    Script Date: 4/15/2025 12:55:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Speakers](
	[SpeakerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Email] [nvarchar](255) NULL,
	[Phone] [nvarchar](20) NULL,
	[Bio] [nvarchar](max) NULL,
	[ProfilePicture] [nvarchar](512) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[SpeakerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tags]    Script Date: 4/15/2025 12:55:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tags](
	[TagId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [nvarchar](255) NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[TagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AuditLogs] ADD  DEFAULT (getdate()) FOR [ActionAt]
GO
ALTER TABLE [dbo].[Categories] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Categories] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[CategoryConditions] ADD  DEFAULT ((0)) FOR [OrderIndex]
GO
ALTER TABLE [dbo].[CategoryConditions] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[CategoryConditions] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[MasterData] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[MasterData] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[R_SessionSpeakers] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[R_SessionSpeakers] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[R_SessionTags] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[R_SessionTags] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[R_SpeakerTags] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[R_SpeakerTags] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[Sessions] ADD  DEFAULT ((0)) FOR [SpeakerCount]
GO
ALTER TABLE [dbo].[Sessions] ADD  DEFAULT ((0)) FOR [CurrentEnrollment]
GO
ALTER TABLE [dbo].[Sessions] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Sessions] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[Speakers] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Speakers] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[Tags] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Tags] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
--ALTER TABLE [dbo].[R_SpeakerTags]  WITH CHECK ADD FOREIGN KEY([SpeakerId])
--REFERENCES [dbo].[Sessions] ([SessionId])
--ON DELETE CASCADE
--GO
--ALTER TABLE [dbo].[R_SpeakerTags]  WITH CHECK ADD FOREIGN KEY([TagId])
--REFERENCES [dbo].[Tags] ([TagId])
--ON DELETE CASCADE
--GO
-- Add Foreign Key for CategoryConditions (CategoryId → Categories)
ALTER TABLE [dbo].[CategoryConditions]
ADD CONSTRAINT FK_CategoryConditions_Categories
FOREIGN KEY (CategoryId) REFERENCES [dbo].[Categories](CategoryId)
ON DELETE CASCADE;

-- Add Foreign Key for R_SessionSpeakers (SessionId → Sessions)
ALTER TABLE [dbo].[R_SessionSpeakers]
ADD CONSTRAINT FK_R_SessionSpeakers_Sessions
FOREIGN KEY (SessionId) REFERENCES [dbo].[Sessions](SessionId)
ON DELETE CASCADE;

-- Add Foreign Key for R_SessionSpeakers (SpeakerId → Speakers)
ALTER TABLE [dbo].[R_SessionSpeakers]
ADD CONSTRAINT FK_R_SessionSpeakers_Speakers
FOREIGN KEY (SpeakerId) REFERENCES [dbo].[Speakers](SpeakerId)
ON DELETE CASCADE;

-- Add Foreign Key for R_SessionTags (SessionId → Sessions)
ALTER TABLE [dbo].[R_SessionTags]
ADD CONSTRAINT FK_R_SessionTags_Sessions
FOREIGN KEY (SessionId) REFERENCES [dbo].[Sessions](SessionId)
ON DELETE CASCADE;

-- Add Foreign Key for R_SessionTags (TagId → Tags)
ALTER TABLE [dbo].[R_SessionTags]
ADD CONSTRAINT FK_R_SessionTags_Tags
FOREIGN KEY (TagId) REFERENCES [dbo].[Tags](TagId)
ON DELETE CASCADE;

-- Add Foreign Key for R_SpeakerTags (SpeakerId → Speakers)
ALTER TABLE [dbo].[R_SpeakerTags]
ADD CONSTRAINT FK_R_SpeakerTags_Speakers
FOREIGN KEY (SpeakerId) REFERENCES [dbo].[Speakers](SpeakerId)
ON DELETE CASCADE;

-- Add Foreign Key for R_SpeakerTags (TagId → Tags)
ALTER TABLE [dbo].[R_SpeakerTags]
ADD CONSTRAINT FK_R_SpeakerTags_Tags
FOREIGN KEY (TagId) REFERENCES [dbo].[Tags](TagId)
ON DELETE CASCADE;

--ALTER TABLE [dbo].[MasterData]  WITH CHECK ADD CHECK  (([Type]='Operator' OR [Type]='Field'))
GO
/****** Object:  StoredProcedure [dbo].[Usp_Category_AddOrUpdateCategory]    Script Date: 4/15/2025 12:55:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Usp_Category_AddOrUpdateCategory]
	@CategoryId INT NULL,
	@CategoryName NVARCHAR(255) NULL,
	@CategoryDescription NVARCHAR(255) NULL,
    @JsonData NVARCHAR(MAX) -- JSON string containing the list of CategoryConditions
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	/*=================== Variables ====================*/
	

	SET NOCOUNT ON;
	BEGIN TRY
		
		-- Parse JSON data into a table format using OPENJSON
		SELECT
			CategoryConditionId,
			CategoryId,
			FieldName,
			OrderIndex,
			ConditionOperator,
			OperatorId,
			Value_String,
			Value_Number,
			Value_DateTime_From,
			Value_DateTime_To,
			CreatedBy,
			UpdatedBy
		INTO #ParsedData
		FROM OPENJSON(@JsonData)
		WITH (
			CategoryConditionId INT '$.CategoryConditionId',
			CategoryId INT '$.CategoryId',
			FieldName NVARCHAR(50) '$.FieldName',
			OrderIndex INT '$.OrderIndex',
			ConditionOperator NVARCHAR(10) '$.ConditionOperator',
			OperatorId INT '$.OperatorId',
			Value_String NVARCHAR(MAX) '$.ValueString',
			Value_Number DECIMAL(18, 2) '$.ValueNumber',
			Value_DateTime_From DATETIME '$.ValueDateTimeFrom',
			Value_DateTime_To DATETIME '$.ValueDateTimeTo',
			CreatedBy NVARCHAR(255) '$.CreatedBy',
			UpdatedBy NVARCHAR(255) '$.UpdatedBy'
		)

		IF NOT EXISTS (SELECT TOP 1 1 FROM Categories WHERE CategoryId = @CategoryId)
		BEGIN
			INSERT INTO Categories (Name, Description) VALUES(@CategoryName, @CategoryDescription)
			SET @CategoryId = SCOPE_IDENTITY();
		END
		ELSE
		BEGIN
			UPDATE Categories SET Name = @CategoryName, Description = @CategoryDescription WHERE CategoryId = @CategoryId

			-- Delete CategoryConditions
			DELETE		CategoryConditions
			FROM		Categories C
			INNER JOIN	CategoryConditions CC
				ON		CC.CategoryId = C.CategoryId
			LEFT JOIN	#ParsedData P
				ON		CC.CategoryId = P.CategoryId
				AND		CC.CategoryConditionId = P.CategoryConditionId
			WHERE		P.CategoryConditionId IS NULL
				AND		C.CategoryId = @CategoryId
		END
		
		-- Insert new rows or update existing rows CategoryConditions
		MERGE INTO CategoryConditions AS Target
		USING #ParsedData AS Source
		ON Target.CategoryConditionId = Source.CategoryConditionId 
		WHEN MATCHED THEN
			UPDATE SET
				CategoryId = @CategoryId,
				FieldName = Source.FieldName,
				OrderIndex = Source.OrderIndex,
				ConditionOperator = Source.ConditionOperator,
				OperatorId = Source.OperatorId,
				Value_String = Source.Value_String,
				Value_Number = Source.Value_Number,
				Value_DateTime_From = Source.Value_DateTime_From,
				Value_DateTime_To = Source.Value_DateTime_To,
				UpdatedAt = GETDATE(),
				UpdatedBy = Source.UpdatedBy
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (
				CategoryId, FieldName, OrderIndex, ConditionOperator, OperatorId,
				Value_String, Value_Number, Value_DateTime_From, Value_DateTime_To,
				CreatedAt, CreatedBy, UpdatedAt, UpdatedBy
			)
			VALUES (
				@CategoryId, Source.FieldName, Source.OrderIndex, Source.ConditionOperator, Source.OperatorId,
				Source.Value_String, Source.Value_Number, Source.Value_DateTime_From, Source.Value_DateTime_To,
				GETDATE(), Source.CreatedBy, GETDATE(), Source.UpdatedBy
			);

		-- Return the IDs of all affected rows (optional)
		SELECT @CategoryId
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
			'[Usp_Category_AddOrUpdateCategory]',
			SYSTEM_USER,
			CONCAT('Error occurred in [Usp_Category_AddOrUpdateCategory] for CategoryId: ', @CategoryId, '. Error: ', ERROR_MESSAGE())
		);

		-- Cleanup temporary tables in case of error
		IF OBJECT_ID('tempdb..#IncludeTags') IS NOT NULL
			DROP TABLE #IncludeTags;

		IF OBJECT_ID('tempdb..#ExcludeTags') IS NOT NULL
			DROP TABLE #ExcludeTags;

		-- Re-throw the error to ensure it's not silently ignored
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_Category_DeleteById]    Script Date: 4/15/2025 12:55:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Usp_Category_DeleteById]
	@CategoryId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE Categories WHERE CategoryId = @CategoryId
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_Category_GetAll]    Script Date: 4/15/2025 12:55:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Usp_Category_GetAll]
AS
BEGIN
	SELECT		DISTINCT
				C.CategoryId,
				C.Name
	FROM		Categories AS C
	INNER JOIN	CategoryConditions AS CC
		ON		CC.CategoryId = C.CategoryId
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_Category_GetById]    Script Date: 4/15/2025 12:55:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Usp_Category_GetById]
	@CategoryId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT		C.CategoryId
				, C.Name					AS CategoryName
				, C.Description				AS CategoryDescription
				, CC.CategoryConditionId
				, CC.ConditionOperator	
				, CC.FieldName
				, CC.OperatorId
				, CC.Value_String			AS ValueString
				, CC.Value_Number			AS ValueNumber
				, CC.Value_DateTime_To		AS ValueDateTimeTo
				, CC.Value_DateTime_From	AS ValueDateTimeFrom
				, CC.OrderIndex
				, CC.CreatedAt
				, CC.UpdatedAt
	FROM		Categories AS C
	INNER JOIN	CategoryConditions AS CC
		ON		CC.CategoryId = C.CategoryId
	WHERE		C.CategoryId = @CategoryId
	ORDER BY	CC.OrderIndex
END
GO
/****** Object:  StoredProcedure [dbo].[Usp_Category_SearchById]    Script Date: 4/15/2025 12:55:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
		
		/*==================== Declare Tables ======================*/
        IF OBJECT_ID('tempdb..#SessionId') IS NOT NULL
            DROP TABLE #SessionId;
		CREATE TABLE #SessionId(
			SessionId INT PRIMARY KEY
		)
		
        -- Create temporary tables for Include/Exclude Tags and Filtered Sessions
        CREATE TABLE #IncludeTags (TagId INT PRIMARY KEY);
        CREATE TABLE #ExcludeTags (TagId INT PRIMARY KEY);
        CREATE TABLE #FilteredSessions (SessionId INT PRIMARY KEY);

		/*==================== Declare Variables ======================*/
        DECLARE @ContainOperatorId INT;
        DECLARE @GreateThanOperatorId INT;
        DECLARE @LessThanOperatorId INT;
        DECLARE @BetweenOperatorId INT;
        DECLARE @IncludeOperatorId INT;
        DECLARE @ExcludeOperatorId INT;
        -- Process additional conditions
        DECLARE @ConditionSql NVARCHAR(MAX) = N' WHERE 1 = 1';
		
		/*==================== Set Variables ======================*/
		SET @ContainOperatorId = (SELECT DataId FROM MasterData WHERE Name = 'Contain' AND Type = 'Operator')
		SET @GreateThanOperatorId = (SELECT DataId FROM MasterData WHERE Name = 'GreaterThan' AND Type = 'Operator')
		SET @LessThanOperatorId = (SELECT DataId FROM MasterData WHERE Name = 'LessThan' AND Type = 'Operator')
		SET @BetweenOperatorId = (SELECT DataId FROM MasterData WHERE Name = 'Between' AND Type = 'Operator')
		SET @ExcludeOperatorId = (SELECT DataId FROM MasterData WHERE Name = 'Exclude' AND Type = 'Operator')
		SET @IncludeOperatorId = (SELECT DataId FROM MasterData WHERE Name = 'Include' AND Type = 'Operator')

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
		
        -- Build dynamic SQL for additional conditions (e.g., Location, Date)
        DECLARE @Sql NVARCHAR(MAX) = N'
			INSERT INTO #SessionId(SessionId)
            SELECT DISTINCT
                S.SessionId
            FROM		Sessions					S
        ';

		IF EXISTS (SELECT TOP 1 1 FROM #IncludeTags) -- OR EXISTS (SELECT TOP 1 1 FROM #ExcludeTags)
		BEGIN
			SET @Sql = @Sql + ' INNER JOIN [dbo].[R_SessionTags] ST ON S.SessionId = ST.SessionId ';
			--@ConditionSql = ' AND '
			SET @Sql = @Sql + ' INNER JOIN #IncludeTags IT ON IT.TagID = ST.TagId';
			--IF EXISTS (SELECT TOP 1 1 FROM #IncludeTags)
			--BEGIN
			--	SET @Sql = @Sql + ' INNER JOIN #IncludeTags IT ON IT.TagID = ST.TagId';
			--END

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
                WHEN OperatorId = @BetweenOperatorId AND FieldName = 'StartDate' AND Value_DateTime_To IS NOT NULL AND Value_DateTime_From IS NULL THEN 
                    CONCAT(ConditionOperator, ' S.StartDate <= ''', CONVERT(NVARCHAR, Value_DateTime_To, 120), ''' ')
				WHEN OperatorId = @BetweenOperatorId AND FieldName = 'EndDate' AND Value_DateTime_To IS NULL AND Value_DateTime_From IS NOT NULL THEN 
                    CONCAT(ConditionOperator, ' S.StartDate >= ''', CONVERT(NVARCHAR, Value_DateTime_From, 120), ''' ')
				WHEN OperatorId = @BetweenOperatorId AND FieldName = 'EndDate' AND Value_DateTime_To IS NOT NULL AND Value_DateTime_From IS NOT NULL THEN 
                    CONCAT(ConditionOperator, ' S.StartDate <= ''', CONVERT(NVARCHAR, Value_DateTime_To, 120), ''' ', 'AND S.StartDate >= ''', CONVERT(NVARCHAR, Value_DateTime_From, 120), ''' ')

                WHEN OperatorId = @BetweenOperatorId AND FieldName = 'EndDate' AND Value_DateTime_To IS NOT NULL AND Value_DateTime_From IS NULL THEN 
                    CONCAT(ConditionOperator, ' S.EndDate <= ''', CONVERT(NVARCHAR, Value_DateTime_To, 120), ''' ')
				WHEN OperatorId = @BetweenOperatorId AND FieldName = 'EndDate' AND Value_DateTime_To IS NULL AND Value_DateTime_From IS NOT NULL THEN 
                    CONCAT(ConditionOperator, ' S.EndDate >= ''', CONVERT(NVARCHAR, Value_DateTime_From, 120), ''' ')
				WHEN OperatorId = @BetweenOperatorId AND FieldName = 'EndDate' AND Value_DateTime_To IS NOT NULL AND Value_DateTime_From IS NOT NULL THEN 
                    CONCAT(ConditionOperator, ' S.EndDate <= ''', CONVERT(NVARCHAR, Value_DateTime_To, 120), ''' ', 'AND S.EndDate >= ''', CONVERT(NVARCHAR, Value_DateTime_From, 120), ''' ')
                ELSE ''
            END, ' ')
        FROM CategoryConditions

        -- Append Additional Conditions
        IF LEN(@ConditionSql) > 0
        BEGIN
            SET @Sql = @Sql + @ConditionSql;
        END;
		
		PRINT @Sql
        -- Execute the dynamic SQL To get list Session Id
        EXEC sp_executesql @Sql;
		
		-- Filter out Exclude tags
		IF EXISTS (SELECT TOP 1 1 FROM #ExcludeTags)
		BEGIN
			--SET @Sql = @Sql + ' LEFT JOIN #ExcludeTags ET ON ET.TagID = ST.TagId';
			--SET @ConditionSql = @ConditionSql + ' AND ET.TagId IS NULL '
			DELETE #SessionId
			FROM		#SessionId S
			INNER JOIN	R_SessionTags				RST
				ON		RST.SessionId = S.SessionId
			INNER JOIN	#ExcludeTags ET
				ON		ET.TagId	= RST.TagId
		END

		;WITH cteTag AS(
			SELECT		SI.SessionId	
						, STRING_AGG(T.Name, ', ')		AS Tags
			FROM		#SessionId					SI
			INNER JOIN	Sessions					S	
				ON		S.SessionId = SI.SessionId
			INNER JOIN	R_SessionTags				RST
				ON		RST.SessionId = S.SessionId
			INNER JOIN	Tags						T
				ON		T.TagId = RST.TagId
			GROUP BY	SI.SessionId
		)
		SELECT DISTINCT
            S.SessionId,
            S.Title,
            S.Location,
            S.StartDate,
            S.EndDate,
            S.Description,
			SP.Name			AS SpeakerName,
			CT.Tags
        FROM		cteTag					CT
		INNER JOIN	Sessions					S	
			ON		S.SessionId = CT.SessionId
		LEFT JOIN	[dbo].[R_SessionTags]		RST
			ON		RST.SessionId = RST.SessionId
		LEFT JOIN	[dbo].[Tags]				T
			ON		T.TagId = RST.TagId
		LEFT JOIN	[dbo].[R_SessionSpeakers]	RSS
			ON		RSS.SessionId	= S.SessionId
		LEFT JOIN	Speakers SP
			ON		SP.SpeakerId	= RSS.SpeakerId

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
GO
/****** Object:  StoredProcedure [dbo].[Usp_Session_PreviewSession]    Script Date: 4/15/2025 12:55:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Usp_Session_PreviewSession]
    @JsonData NVARCHAR(MAX) -- JSON string containing the list of CategoryConditions
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
		/*==================== Declare Variables ======================*/
        DECLARE @ContainOperatorId INT;
        DECLARE @GreateThanOperatorId INT;
        DECLARE @LessThanOperatorId INT;
        DECLARE @BetweenOperatorId INT;
        DECLARE @IncludeOperatorId INT;
        DECLARE @ExcludeOperatorId INT;
        -- Process additional conditions
        DECLARE @ConditionSql NVARCHAR(MAX) = N' WHERE 1 = 1';
		
		/*==================== Set Variables ======================*/
		SET @ContainOperatorId = (SELECT DataId FROM MasterData WHERE Name = 'Contain' AND Type = 'Operator')
		SET @GreateThanOperatorId = (SELECT DataId FROM MasterData WHERE Name = 'GreaterThan' AND Type = 'Operator')
		SET @LessThanOperatorId = (SELECT DataId FROM MasterData WHERE Name = 'LessThan' AND Type = 'Operator')
		SET @BetweenOperatorId = (SELECT DataId FROM MasterData WHERE Name = 'Between' AND Type = 'Operator')
		SET @ExcludeOperatorId = (SELECT DataId FROM MasterData WHERE Name = 'Exclude' AND Type = 'Operator')
		SET @IncludeOperatorId = (SELECT DataId FROM MasterData WHERE Name = 'Include' AND Type = 'Operator')

        -- Create temporary tables for Include/Exclude Tags and Filtered Sessions
        CREATE TABLE #IncludeTags (TagId INT PRIMARY KEY);
        CREATE TABLE #ExcludeTags (TagId INT PRIMARY KEY);
        CREATE TABLE #FilteredSessions (SessionId INT PRIMARY KEY);
		SELECT
			CategoryConditionId,
			CategoryId,
			FieldName,
			OrderIndex,
			ConditionOperator,
			OperatorId,
			Value_String,
			Value_Number,
			Value_DateTime_From,
			Value_DateTime_To,
			CreatedBy,
			UpdatedBy
		INTO #ParsedData
		FROM OPENJSON(@JsonData)
		WITH (
			CategoryConditionId INT '$.CategoryConditionId',
			CategoryId INT '$.CategoryId',
			FieldName NVARCHAR(50) '$.FieldName',
			OrderIndex INT '$.OrderIndex',
			ConditionOperator NVARCHAR(10) '$.ConditionOperator',
			OperatorId INT '$.OperatorId',
			Value_String NVARCHAR(MAX) '$.ValueString',
			Value_Number DECIMAL(18, 2) '$.ValueNumber',
			Value_DateTime_From DATETIME '$.ValueDateTimeFrom',
			Value_DateTime_To DATETIME '$.ValueDateTimeTo',
			CreatedBy NVARCHAR(255) '$.CreatedBy',
			UpdatedBy NVARCHAR(255) '$.UpdatedBy'
		)

        -- Populate IncludeTags
        INSERT INTO #IncludeTags (TagId)
        SELECT DISTINCT CAST(VALUE AS INT) AS TagId
        FROM		#ParsedData CC
        CROSS APPLY STRING_SPLIT(CC.Value_String, ',')
        WHERE		CC.FieldName = 'Tag'
          AND		CC.OperatorId = @IncludeOperatorId;

        -- Populate ExcludeTags
        INSERT INTO #ExcludeTags (TagId)
        SELECT DISTINCT CAST(VALUE AS INT) AS TagId
        FROM		#ParsedData CC
        CROSS APPLY STRING_SPLIT(CC.Value_String, ',')
        WHERE		CC.FieldName = 'Tag'
          AND		CC.OperatorId = @ExcludeOperatorId;

        IF OBJECT_ID('tempdb..#SessionId') IS NOT NULL
            DROP TABLE #SessionId;
		CREATE TABLE #SessionId(
			SessionId INT PRIMARY KEY
		)

        -- Build dynamic SQL for additional conditions (e.g., Location, Date)
        DECLARE @Sql NVARCHAR(MAX) = N'
			INSERT INTO #SessionId(SessionId)
            SELECT DISTINCT
                S.SessionId
            FROM		Sessions					S
			LEFT JOIN	[dbo].[R_SessionTags]		RST
				ON		RST.SessionId = RST.SessionId
			LEFT JOIN	[dbo].[Tags]				T
				ON		T.TagId = RST.TagId
			LEFT JOIN	[dbo].[R_SessionSpeakers]	RSS
				ON		RSS.SessionId	= S.SessionId
			LEFT JOIN	Speakers SP
				ON		SP.SpeakerId	= RSS.SpeakerId
        ';

		IF EXISTS (SELECT TOP 1 1 FROM #IncludeTags) --AND EXISTS (SELECT TOP 1 1 FROM #ExcludeTags)
		BEGIN
			SET @Sql = @Sql + ' INNER JOIN [dbo].[R_SessionTags] ST ON S.SessionId = ST.SessionId ';
			--@ConditionSql = ' AND '
			SET @Sql = @Sql + ' INNER JOIN #IncludeTags IT ON IT.TagID = ST.TagId';
			--IF EXISTS (SELECT TOP 1 1 FROM #IncludeTags)
			--BEGIN
			--	SET @Sql = @Sql + ' INNER JOIN #IncludeTags IT ON IT.TagID = ST.TagId';
			--END

			--IF EXISTS (SELECT TOP 1 1 FROM #ExcludeTags)
			--BEGIN
			--	SET @Sql = @Sql + ' LEFT JOIN #ExcludeTags ET ON ET.TagID = ST.TagId';
			--	SET @ConditionSql = @ConditionSql + ' AND ET.TagId IS NULL '
			--END
		END
		
        -- Location Conditions
        SELECT @ConditionSql = @ConditionSql + STRING_AGG(
            CASE 
                WHEN OperatorId = @ContainOperatorId THEN 
                    CONCAT(ConditionOperator, ' S.Location LIKE ''%', Value_String, '%''')
                ELSE ''
            END, ' ')
        FROM	#ParsedData
        WHERE	FieldName = 'Location';


        -- Date Conditions
        SELECT @ConditionSql = @ConditionSql + STRING_AGG(
            CASE 
                WHEN OperatorId = @GreateThanOperatorId AND FieldName = 'StartDate' THEN 
                    CONCAT(ConditionOperator, ' S.StartDate >= ''', CONVERT(NVARCHAR, Value_DateTime_From, 120), ''' ')
                WHEN OperatorId = @LessThanOperatorId AND FieldName = 'EndDate' THEN 
                    CONCAT(ConditionOperator, ' S.EndDate < ''', CONVERT(NVARCHAR, Value_DateTime_To, 120), ''' ')
                ELSE ''
            END, ' ')
        FROM #ParsedData

        -- Append Additional Conditions
        IF LEN(@ConditionSql) > 0
        BEGIN
            SET @Sql = @Sql + @ConditionSql;
        END;

		PRINT @Sql
        -- Execute the dynamic SQL
        EXEC sp_executesql @Sql;
		
		-- Filter out Exclude tags
		IF EXISTS (SELECT TOP 1 1 FROM #ExcludeTags)
		BEGIN
			--SET @Sql = @Sql + ' LEFT JOIN #ExcludeTags ET ON ET.TagID = ST.TagId';
			--SET @ConditionSql = @ConditionSql + ' AND ET.TagId IS NULL '
			DELETE #SessionId
			FROM		#SessionId S
			INNER JOIN	R_SessionTags				RST
				ON		RST.SessionId = S.SessionId
			INNER JOIN	#ExcludeTags ET
				ON		ET.TagId	= RST.TagId
		END
		
		;WITH cteTag AS(
			SELECT		SI.SessionId	
						, STRING_AGG(T.Name, ', ')		AS Tags
			FROM		#SessionId					SI
			INNER JOIN	Sessions					S	
				ON		S.SessionId = SI.SessionId
			INNER JOIN	R_SessionTags				RST
				ON		RST.SessionId = S.SessionId
			INNER JOIN	Tags						T
				ON		T.TagId = RST.TagId
			GROUP BY	SI.SessionId
		)
		SELECT DISTINCT
            S.SessionId,
            S.Title,
            S.Location,
            S.StartDate,
            S.EndDate,
            S.Description,
			SP.Name			AS SpeakerName,
			CT.Tags
        FROM		cteTag					CT
		INNER JOIN	Sessions					S	
			ON		S.SessionId = CT.SessionId
		LEFT JOIN	[dbo].[R_SessionSpeakers]	RSS
			ON		RSS.SessionId	= S.SessionId
		LEFT JOIN	Speakers SP
			ON		SP.SpeakerId	= RSS.SpeakerId

        -- Cleanup Temporary Tables
        DROP TABLE #IncludeTags;
        DROP TABLE #ExcludeTags;
        DROP TABLE #FilteredSessions;

    END TRY
    BEGIN CATCH
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
GO
/****** Object:  StoredProcedure [dbo].[Usp_Tag_GetAll]    Script Date: 4/15/2025 12:55:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Usp_Tag_GetAll]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT 
			TagId AS Id,
			[Name] AS Title
	FROM	Tags
END
GO

-- Seed data for MasterData (Operators and Fields)
INSERT INTO MasterData ([Type], [DataId], [Name], [Description])
VALUES 
    ('Operator', 1, 'Contain', 'Field contains value'),
    ('Operator', 2, 'Between', 'Field between two values'),
    ('Operator', 3, 'Include', 'Include tags'),
    ('Operator', 4, 'Exclude', 'Exclude tags'),
    ('Field', 1, 'Tag', 'Tag field for filtering'),
    ('Field', 2, 'Location', 'Location field for filtering'),
    ('Field', 3, 'StartDate', 'Start date of session'),
    ('Field', 4, 'EndDate', 'End date of session');

-- Seed data for Tags
INSERT INTO Tags ([Name], [CreatedBy])
VALUES 
    ('AWS', 'system'), 
    ('Azure', 'system'), 
    ('Beginner', 'system'), 
    ('Advanced', 'system');

-- Seed data for Speakers
INSERT INTO Speakers ([Name], [Email], [Phone], [Bio], [ProfilePicture], [CreatedBy])
VALUES 
    ('John Doe', 'john@example.com', '123456789', 'Expert in cloud computing.', 'https://example.com/john.jpg', 'system'),
    ('Jane Smith', 'jane@example.com', '987654321', 'Specialist in DevOps.', 'https://example.com/jane.jpg', 'system');

-- Seed data for Sessions
INSERT INTO Sessions ([Title], [Location], [StartDate], [EndDate], [Description], [SpeakerCount], [MaxCapacity], [CurrentEnrollment], [CreatedBy])
VALUES 
    ('AWS Cloud Basics', 'Online', '2025-05-01', '2025-05-02', 'Introduction to AWS cloud.', 1, 100, 50, 'system'),
    ('Azure for Beginners', 'Online', '2025-05-10', '2025-05-11', 'Learn the basics of Azure.', 1, 100, 30, 'system'),
    ('Advanced AWS Techniques', 'New York', '2025-06-01', '2025-06-02', 'Deep dive into AWS.', 1, 50, 20, 'system');

-- Seed data for R_SessionSpeakers
INSERT INTO R_SessionSpeakers ([SessionId], [SpeakerId], [CreatedBy])
VALUES 
    (1, 1, 'system'), 
    (2, 2, 'system'), 
    (3, 1, 'system');

-- Seed data for R_SessionTags
INSERT INTO R_SessionTags ([SessionId], [TagId], [CreatedBy])
VALUES 
    (1, 1, 'system'), 
    (1, 3, 'system'), 
    (2, 2, 'system'), 
    (2, 3, 'system'), 
    (3, 1, 'system'), 
    (3, 4, 'system');

-- Seed data for Categories
INSERT INTO Categories ([Name], [Description], [CreatedBy])
VALUES 
    ('Cloud Learning (May)', 'Sessions about cloud in May.', 'system');

-- Seed data for CategoryConditions
INSERT INTO CategoryConditions ([CategoryId], [FieldName], [OrderIndex], [ConditionOperator], [OperatorId], [Value_String], [Value_DateTime_From], [Value_DateTime_To], [CreatedBy])
VALUES 
    (1, 'Tag', 1, 'AND', 3, '1,2', NULL, NULL, 'system'), -- Include Tags: AWS, Azure
    (1, 'Tag', 2, 'AND', 4, '3', NULL, NULL, 'system'), -- Exclude Tags: Beginner
    (1, 'Location', 3, 'AND', 1, 'Online', NULL, NULL, 'system'), -- Location: Online
    (1, 'StartDate', 4, 'AND', 2, NULL, '2025-05-01', NULL, 'system'), -- StartDate >= 2025-05-01
    (1, 'EndDate', 5, 'AND', 2, NULL, NULL, '2025-05-31', 'system'); -- EndDate < 2025-05-31

USE [master]
GO
ALTER DATABASE [DCM] SET  READ_WRITE 
GO
