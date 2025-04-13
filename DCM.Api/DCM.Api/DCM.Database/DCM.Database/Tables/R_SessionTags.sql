CREATE TABLE [dbo].[R_SessionTags]
(
    SessionId BIGINT NOT NULL,
    TagId BIGINT NOT NULL,
    PRIMARY KEY (SessionId, TagId)
)
