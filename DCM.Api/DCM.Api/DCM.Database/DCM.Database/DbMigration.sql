-- Table to store session information
CREATE TABLE Sessions (
    SessionId INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(255) NOT NULL,       -- Title of the session
    Location NVARCHAR(255),            -- Location of the session
    StartDate DATETIME NOT NULL,       -- Start date and time of the session
    EndDate DATETIME NOT NULL,         -- End date and time of the session
    Description NVARCHAR(MAX),         -- Description of the session
    SpeakerCount INT DEFAULT 0,        -- Number of speakers in the session
    MaxCapacity INT,                   -- Maximum number of participants
    CurrentEnrollment INT DEFAULT 0,   -- Current number of enrolled participants
    CreatedAt DATETIME DEFAULT GETDATE(), -- Timestamp when the row was created
    CreatedBy NVARCHAR(255)  NULL,  -- User who created the row
    UpdatedAt DATETIME DEFAULT GETDATE(), -- Timestamp when the row was last updated
    UpdatedBy NVARCHAR(255)  NULL   -- User who last updated the row
);

-- Table to store speaker information
CREATE TABLE Speakers (
    SpeakerId INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,       -- Name of the speaker
    Email NVARCHAR(255),               -- Email address of the speaker
    Phone NVARCHAR(20),                -- Phone number of the speaker
    Bio NVARCHAR(MAX),                 -- Biography of the speaker
    ProfilePicture NVARCHAR(512),      -- Profile picture URL of the speaker
    CreatedAt DATETIME DEFAULT GETDATE(), -- Timestamp when the row was created
    CreatedBy NVARCHAR(255)  NULL,  -- User who created the row
    UpdatedAt DATETIME DEFAULT GETDATE(), -- Timestamp when the row was last updated
    UpdatedBy NVARCHAR(255)  NULL   -- User who last updated the row
);

-- Many-to-Many relationship between Sessions and Speakers
CREATE TABLE R_SessionSpeakers (
    RSessionSpeakerId INT IDENTITY(1,1),
    SessionId INT NOT NULL,            -- Foreign key referencing Sessions
    SpeakerId INT NOT NULL,            -- Foreign key referencing Speakers
    PRIMARY KEY (SessionId, SpeakerId),
    --FOREIGN KEY (SessionId) REFERENCES Sessions(SessionId) ON DELETE CASCADE,
    --FOREIGN KEY (SpeakerId) REFERENCES Speakers(SpeakerId) ON DELETE CASCADE,
    CreatedAt DATETIME DEFAULT GETDATE(), -- Timestamp when the row was created
    CreatedBy NVARCHAR(255)  NULL,  -- User who created the row
    UpdatedAt DATETIME DEFAULT GETDATE(), -- Timestamp when the row was last updated
    UpdatedBy NVARCHAR(255)  NULL   -- User who last updated the row
);

-- Table to store tag definitions
CREATE TABLE Tags (
    TagId INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL UNIQUE, -- Name of the tag
    CreatedAt DATETIME DEFAULT GETDATE(), -- Timestamp when the row was created
    CreatedBy NVARCHAR(255)  NULL,  -- User who created the row
    UpdatedAt DATETIME DEFAULT GETDATE(), -- Timestamp when the row was last updated
    UpdatedBy NVARCHAR(255)  NULL   -- User who last updated the row
);

-- Many-to-Many relationship between Sessions and Tags
CREATE TABLE R_SessionTags (
    RSessionTagId INT IDENTITY(1,1),
    SessionId INT NOT NULL,            -- Foreign key referencing Sessions
    TagId INT NOT NULL,                -- Foreign key referencing Tags
    PRIMARY KEY (SessionId, TagId),
    --FOREIGN KEY (SessionId) REFERENCES Sessions(SessionId) ON DELETE CASCADE,
    --FOREIGN KEY (TagId) REFERENCES Tags(TagId) ON DELETE CASCADE,
    CreatedAt DATETIME DEFAULT GETDATE(), -- Timestamp when the row was created
    CreatedBy NVARCHAR(255)  NULL,  -- User who created the row
    UpdatedAt DATETIME DEFAULT GETDATE(), -- Timestamp when the row was last updated
    UpdatedBy NVARCHAR(255)  NULL   -- User who last updated the row
);

-- Table to store category metadata
CREATE TABLE Categories (
    CategoryId INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,       -- Name of the category
    Description NVARCHAR(MAX),         -- Description of the category
    CreatedAt DATETIME DEFAULT GETDATE(), -- Timestamp when the row was created
    CreatedBy NVARCHAR(255)  NULL,  -- User who created the row
    UpdatedAt DATETIME DEFAULT GETDATE(), -- Timestamp when the row was last updated
    UpdatedBy NVARCHAR(255)  NULL   -- User who last updated the row
);

-- Many-to-Many relationship between Sessions and Tags
CREATE TABLE R_SpeakerTags (
    RSpeakerTagId INT IDENTITY(1,1),
    SpeakerId INT NOT NULL,            -- Foreign key referencing Speakers
    TagId INT NOT NULL,                -- Foreign key referencing Tags
    PRIMARY KEY (SpeakerId, TagId),
    FOREIGN KEY (SpeakerId) REFERENCES Sessions(SessionId) ON DELETE CASCADE,
    FOREIGN KEY (TagId) REFERENCES Tags(TagId) ON DELETE CASCADE,
    CreatedAt DATETIME DEFAULT GETDATE(), -- Timestamp when the row was created
    CreatedBy NVARCHAR(255) NULL,  -- User who created the row
    UpdatedAt DATETIME DEFAULT GETDATE(), -- Timestamp when the row was last updated
    UpdatedBy NVARCHAR(255) NULL   -- User who last updated the row
);


-- Unified master table to store available fields and operators
CREATE TABLE MasterData (
    MasterDataId INT PRIMARY KEY IDENTITY(1,1),
    Type NVARCHAR(50) NOT NULL CHECK (Type IN ('Field', 'Operator')), -- Type of the entry (Field or Operator)
    DataId INT NOT NULL,
    Name NVARCHAR(100) NOT NULL UNIQUE,   -- Name of the field or operator
    Description NVARCHAR(MAX),            -- Description of the field or operator
    CreatedAt DATETIME DEFAULT GETDATE(), -- Timestamp when the row was created
    CreatedBy NVARCHAR(255) NULL,  -- User who created the row
    UpdatedAt DATETIME DEFAULT GETDATE(), -- Timestamp when the row was last updated
    UpdatedBy NVARCHAR(255) NULL   -- User who last updated the row
);

-- Table to store filter conditions for categories
CREATE TABLE CategoryConditions (
    ConditionId INT PRIMARY KEY IDENTITY(1,1),
    CategoryId INT NOT NULL,                 -- Foreign key referencing Categories
    --GroupId INT NOT NULL,                    -- Group identifier for the condition
    --ParentGroupId INT NULL,                  -- Parent group identifier (if nested)
    FieldName NVARCHAR(20) NOT NULL,       
    OrderIndex INT NOT NULL DEFAULT 0,       -- Order of the condition within the group
    ConditionOperator NVARCHAR(10) NULL,       -- Logical operator (AND, OR)
    OperatorId INT NOT NULL,                -- Foreign key referencing MasterData (Field or Operator)
    Value_String NVARCHAR(MAX) NULL,         -- String value for the condition (e.g., Tags, Location)
    Value_Number DECIMAL(18, 2) NULL,        -- Numeric value for the condition
    Value_DateTime_From DATETIME NULL,       -- Start date for conditions like time range
    Value_DateTime_To DATETIME NULL,         -- End date for conditions like time range
    CreatedAt DATETIME DEFAULT GETDATE(), -- Timestamp when the row was created
    CreatedBy NVARCHAR(255) NULL,  -- User who created the row
    UpdatedAt DATETIME DEFAULT GETDATE(), -- Timestamp when the row was last updated
    UpdatedBy NVARCHAR(255) NULL   -- User who last updated the row
    --FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId) ON DELETE CASCADE,
    --FOREIGN KEY (FieldOrOperatorId) REFERENCES MasterData(MasterDataId) ON DELETE NO ACTION
);

-- Table to store audit logs
CREATE TABLE AuditLogs (
    AuditId INT PRIMARY KEY IDENTITY(1,1),   -- Unique identifier for each audit log
    Event NVARCHAR(255) NOT NULL,           -- Event type (e.g., INSERT, UPDATE, DELETE, ERROR)
    TableName NVARCHAR(255),                -- Name of the table affected
    RecordId INT NULL,                      -- ID of the record affected (if applicable)
    ActionBy NVARCHAR(255) NOT NULL,        -- User who performed the action
    ActionAt DATETIME DEFAULT GETDATE(),    -- Timestamp when the action occurred
    Details NVARCHAR(MAX) NULL              -- Additional details about the action or error
);

-- Fields
INSERT INTO MasterData (Type,DataId, Name, Description) VALUES ('Field',1, 'SessionName', 'Name of the session');
INSERT INTO MasterData (Type,DataId, Name, Description) VALUES ('Field', 2,'Tags', 'Tags associated with the session');
INSERT INTO MasterData (Type,DataId, Name, Description) VALUES ('Field', 3,'Location', 'Location of the session');
INSERT INTO MasterData (Type,DataId, Name, Description) VALUES ('Field', 4,'StartDate', 'Time range of the session');
INSERT INTO MasterData (Type,DataId, Name, Description) VALUES ('Field', 5,'EndDate', 'Time range of the session');

-- Operators
INSERT INTO MasterData (Type,DataId, Name, Description) VALUES ('Operator',1, 'Include', 'Includes the specified values');
INSERT INTO MasterData (Type,DataId, Name, Description) VALUES ('Operator',2, 'Exclude', 'Excludes the specified values');
INSERT INTO MasterData (Type,DataId, Name, Description) VALUES ('Operator',3, '>=', 'Greater than or equal to');
INSERT INTO MasterData (Type,DataId, Name, Description) VALUES ('Operator',4, '<=', 'Less than or equal to');
INSERT INTO MasterData (Type,DataId, Name, Description) VALUES ('Operator',5, 'CONTAINS', 'Contains the specified string');

/*=======================SEED data===============================*/
-- Insert sample Tags
INSERT INTO Tags (Name, CreatedAt, CreatedBy, UpdatedAt, UpdatedBy)
VALUES 
('Cloud', GETDATE(), 'admin', GETDATE(), 'admin'),
('AI', GETDATE(), 'admin', GETDATE(), 'admin'),
('Big Data', GETDATE(), 'admin', GETDATE(), 'admin'),
('DevOps', GETDATE(), 'admin', GETDATE(), 'admin'),
('Azure', GETDATE(), 'admin', GETDATE(), 'admin'),
('AWS', GETDATE(), 'admin', GETDATE(), 'admin');

-- Insert sample Speakers
INSERT INTO Speakers (Name, Email, Phone, Bio, ProfilePicture, CreatedAt, CreatedBy, UpdatedAt, UpdatedBy)
VALUES
('John Doe', 'john.doe@example.com', '123-456-7890', 'Expert in Cloud and AI.', '/images/john_doe.jpg', GETDATE(), 'admin', GETDATE(), 'admin'),
('Jane Smith', 'jane.smith@example.com', '987-654-3210', 'Specialist in Big Data and DevOps.', '/images/jane_smith.jpg', GETDATE(), 'admin', GETDATE(), 'admin'),
('Alice Johnson', 'alice.johnson@example.com', '555-123-4567', 'Azure and AWS evangelist.', '/images/alice_johnson.jpg', GETDATE(), 'admin', GETDATE(), 'admin');

-- Insert sample Sessions
INSERT INTO Sessions (Title, Location, StartDate, EndDate, Description, SpeakerCount, MaxCapacity, CurrentEnrollment, CreatedAt, CreatedBy, UpdatedAt, UpdatedBy)
VALUES
('Cloud in 2025', 'New York', '2025-06-01 09:00:00', '2025-06-01 12:00:00', 'Exploring the latest trends in cloud computing for 2025.', 2, 100, 50, GETDATE(), 'admin', GETDATE(), 'admin'),
('AI Revolution', 'San Francisco', '2025-07-15 14:00:00', '2025-07-15 17:00:00', 'How AI is transforming industries.', 1, 200, 120, GETDATE(), 'admin', GETDATE(), 'admin'),
('Big Data and DevOps', 'Chicago', '2025-08-10 10:00:00', '2025-08-10 13:00:00', 'Integrating Big Data analytics with DevOps practices.', 1, 150, 80, GETDATE(), 'admin', GETDATE(), 'admin');

-- Insert sample Session-Speaker relationships
INSERT INTO R_SessionSpeakers (SessionId, SpeakerId, CreatedAt, CreatedBy, UpdatedAt, UpdatedBy)
VALUES
(1, 1, GETDATE(), 'admin', GETDATE(), 'admin'), -- John Doe -> Cloud in 2025
(1, 3, GETDATE(), 'admin', GETDATE(), 'admin'), -- Alice Johnson -> Cloud in 2025
(2, 1, GETDATE(), 'admin', GETDATE(), 'admin'), -- John Doe -> AI Revolution
(3, 2, GETDATE(), 'admin', GETDATE(), 'admin'); -- Jane Smith -> Big Data and DevOps

-- Insert sample Session-Tag relationships
INSERT INTO R_SessionTags (SessionId, TagId, CreatedAt, CreatedBy, UpdatedAt, UpdatedBy)
VALUES
(1, (SELECT TagId FROM Tags WHERE Name = 'Cloud'), GETDATE(), 'admin', GETDATE(), 'admin'),
(1, (SELECT TagId FROM Tags WHERE Name = 'Azure'), GETDATE(), 'admin', GETDATE(), 'admin'),
(2, (SELECT TagId FROM Tags WHERE Name = 'AI'), GETDATE(), 'admin', GETDATE(), 'admin'),
(3, (SELECT TagId FROM Tags WHERE Name = 'Big Data'), GETDATE(), 'admin', GETDATE(), 'admin'),
(3, (SELECT TagId FROM Tags WHERE Name = 'DevOps'), GETDATE(), 'admin', GETDATE(), 'admin');

-- Insert sample Speaker-Tag relationships
INSERT INTO R_SpeakerTags (SpeakerId, TagId, CreatedAt, CreatedBy, UpdatedAt, UpdatedBy)
VALUES
(1, (SELECT TagId FROM Tags WHERE Name = 'Cloud'), GETDATE(), 'admin', GETDATE(), 'admin'),
(1, (SELECT TagId FROM Tags WHERE Name = 'AI'), GETDATE(), 'admin', GETDATE(), 'admin'),
(2, (SELECT TagId FROM Tags WHERE Name = 'Big Data'), GETDATE(), 'admin', GETDATE(), 'admin'),
(2, (SELECT TagId FROM Tags WHERE Name = 'DevOps'), GETDATE(), 'admin', GETDATE(), 'admin'),
(3, (SELECT TagId FROM Tags WHERE Name = 'Azure'), GETDATE(), 'admin', GETDATE(), 'admin'),
(3, (SELECT TagId FROM Tags WHERE Name = 'AWS'), GETDATE(), 'admin', GETDATE(), 'admin');


