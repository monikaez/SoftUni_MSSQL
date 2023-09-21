
CREATE TABLE Users(
Id  BIGINT PRIMARY KEY IDENTITY,
[Username] VARCHAR(30) NOT NULL,
[Password] VARCHAR(26) NOT NULL,
ProfilePicture VARBINARY(MAX),
LastLoginTime DATETIME2,
IsDeleted BIT
);

INSERT INTO Users
VALUES
('Pesho','123456',NUll,'10-10-2021',0),
('Pepi','123446',NUll,'9-10-2021',0),
('Pepino','1234566',NUll,'2-10-2021',0),
('Petrush','65894',NUll,'1-10-2021',0),
('Petar','1234544',NUll,'3-31-2021',0)