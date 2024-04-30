create database Blogs
use Blogs

Create table Catagories(
Id int Primary Key Identity,
[Name] nvarchar(50) Not null Unique
)

select* from Catagories

Create table Tags(
Id int Primary Key Identity,
[Name] nvarchar(50) Not null Unique
)

select* from Tags

Create table Users(
Id int Primary Key Identity,
UserName nvarchar not null Unique,
FullName nvarchar not null,
Age int 
)


select* from Users

Create table Comments (
Id int PRIMARY KEY IDENTITY,
Content NVARCHAR(250) NOT NULL,
UserId INT NOT NULL,
BlogId INT NOT NULL
)

select* from Comments

Create table Blogs (
Id int Primary key IDENTITY,
Title nvarchar(50) NOT NULL,
[Description] nvarchar(50) NOT NULL,
UserId int NOT NULL,
CategoryId int NOT NULL
)

select* from Blogs

Create table BlogTags (
BlogId int, 
TagId int,
Primary key (BlogId, TagId),
FOREIGN KEY (BlogId) REFERENCES Blogs(Id),
FOREIGN KEY (TagId) REFERENCES Tags(Id)
)
select* from BlogTags

Create view VW_Title 
AS
SELECT 
    Blogs.Title,  
    Users.UserName, 
    Users.FullName 
FROM 
    Blogs
JOIN 
    Users 
ON 
    Blogs.UserId = Users.Id


select* from VW_Title


CREATE VIEW VW_Blogs_Categories
AS
SELECT 
    Blogs.Title,
    Catagories.[Name]
FROM 
    Blogs
JOIN 
    Catagories 
ON 
    Blogs.CategoryId = Catagories.Id

	select* from VW_Blogs_Categories

CREATE PROCEDURE SP_GetUserComments
    @userId INT
AS
BEGIN
    SELECT 
        Comments.Id,
        Comments.Content,
        Comments.BlogId 
    FROM 
        Comments
    WHERE 
        Comments.UserId = @userId
END

select* from SP_GetUserComments

CREATE PROCEDURE SP_GetUserBlogs
    @userId INT
AS
BEGIN
    SELECT 
        Blogs.Id, 
        Blogs.Title,
        Blogs.Description
    FROM 
        Blogs
    WHERE 
        Blogs.UserId = @userId
END



CREATE FUNCTION dbo.GetBlogCountByCategory
(
    @categoryId INT 
)
RETURNS INT 
AS
BEGIN
    DECLARE @blogCount INT

    SELECT 
        @blogCount = COUNT(*)
    FROM 
        Blogs
    WHERE 
        Blogs.CategoryId = @categoryId

    RETURN @blogCount
END




CREATE FUNCTION dbo.GetUserBlogs
(
    @userId INT 
)
RETURNS TABLE 
AS
RETURN
(
    SELECT 
        Blogs.Id,  
        Blogs.Title,
        Blogs.Description
    FROM 
        Blogs
    WHERE 
        Blogs.UserId = @userId
)


