CREATE DATABASE MSPLATFORMS
USE MSPLATFORMS




CREATE TABLE Users(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(25) NOT NULL,
Surname NVARCHAR(35) NOT NULL,
Username NVARCHAR(40) NOT NULL UNIQUE,
Password NVARCHAR(10) NOT NULL UNIQUE,
Gender NVARCHAR(10) NOT NULL CHECK (Gender IN ('Male', 'Female'))
);

CREATE TABLE Artists (
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(40) NOT NULL,
Surname NVARCHAR(70) NOT NULL,
Birthday DATE NOT NULL,
Gender NVARCHAR(10) NOT NULL CHECK  (Gender IN ('Male','Female')) 
);

CREATE TABLE Categories (
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(50) NOT NULL
);

CREATE TABLE Musics (
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(55) NOT NULL,
Duration TIME,
CategoryId INT,
ArtistId INT,
FOREIGN KEY (CategoryId) REFERENCES Categories(Id),
FOREIGN KEY (ArtistId) REFERENCES Artists(Id)
);

--Isifadecinin yaratdigi playlisti saxlamaq ucun
CREATE TABLE Playlists(
PlaylistId INT PRIMARY KEY IDENTITY,
UserId INT,
Name NVARCHAR(100),
FOREIGN KEY (UserId) REFERENCES Users(Id),
CONSTRAINT UQ_UserId_Name UNIQUE (UserId, Name)
);

CREATE TABLE PlaylistMusics (
PlaylistId INT,
MusicId INT,
FOREIGN KEY (PlaylistId) REFERENCES Playlists(PlaylistId),
FOREIGN KEY (MusicId) REFERENCES Musics(Id),
PRIMARY KEY (PlaylistId, MusicId)
);


---Insert into...
INSERT INTO Users(Name, Surname, Username, Password, Gender) VALUES 
('Nazrin','Aliyeva', 'NazrinAli1', '18367k', 'Female'),
('Nicat','Aliyev', 'Nicat134@', '34669g', 'Male'),
('Sefa','Mikayilova', 'SefaMikayil1.', '89677h', 'Female'),
('Ali','Aliyev', 'AliyevAli999', '99988C', 'Male')

INSERT INTO Artists(Name, Surname, Gender, Birthday) VALUES
('Freddie', 'Mercury', 'Male', '1946-09-05'),
('Madonna', '', 'Female', '1958-08-16'),
('Elvis', 'Presley', 'Male', '1935-01-08'),
('Whitney', 'Houston', 'Female', '1963-08-09')

INSERT INTO Categories(Name) VALUES
('Pop'),
('Rock'),
('Hip Hop'),
('Jazz'),
('Classical'),
('Folk')

INSERT INTO Musics(Name) VALUES
('Thriller'),
('Smells Like Teen Spirit'),
('Rolling in the Deep'),
('I Will Always Love You'),
('Imagine'),
('No Woman, No Cry'),
('Bohemian Rhapsody')


--Sorgular
--1. Mahnını adını, uzunluğunu, kateqoriyasını, 
--hansı ifaçı tərəfindən oxunulduğunu bildirən 
--sorğunu özündə saxlayan uptadeable view:
CREATE VIEW MusicDetails AS 
SELECT m.Name AS Music_Name, m.Duration, c.Name AS Category_Name, CONCAT(a.Name, ' ', a.Surname) AS Artist_Name
FROM Musics m
JOIN Categories c ON m.CategoryId=c.Id
JOIN Artists a ON m.ArtistId = a.Id;

--2. Verilmiş istifadəçinin playlistinə əlavə etdiyi mahnıların siyahısını çıxar:
SELECT p.Name AS Playlist_Name, m.Name AS Music_Name
FROM Playlists p
JOIN PlaylistMusics pm ON p.PlaylistId=pm.PlaylistId
JOIN Musics m ON pm.MusicId=m.Id
WHERE p.UserId = 2;

--3. Mahnıları uzunluğuna görə sıra(Order by):

SELECT Name, Duration
FROM Musics
ORDER BY Duration;

--4. Saytda ən çox mahnı çıxaran ifaçı(lar):
SELECT TOP 1 CONCAT(a.Name, ' ', a.Surname) AS Artist_Name, COUNT(*) AS Song_Count
FROM Musics m
JOIN Artists a ON m.ArtistID = a.Id
GROUP BY CONCAT(a.Name, ' ', a.Surname)
ORDER BY Song_Count DESC;







