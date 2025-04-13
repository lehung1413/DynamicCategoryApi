CREATE TABLE [dbo].[R_SessionSpeakers]
( 
    SessionId INT NOT NULL,
    SpeakerId INT NOT NULL,
    PRIMARY KEY (SessionId, SpeakerId),
    FOREIGN KEY (SessionId) REFERENCES Sessions(Id),
    FOREIGN KEY (SpeakerId) REFERENCES Speakers(Id)
)
