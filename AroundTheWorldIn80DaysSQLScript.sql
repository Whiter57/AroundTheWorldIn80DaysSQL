USE [master]
GO
/****** Object:  Database [AroundTheWorldIn80Days] ******/
CREATE DATABASE [AroundTheWorldIn80Days]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AroundTheWorldIn80Days', FILENAME = N'-----------' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AroundTheWorldIn80Days_log', FILENAME = N'-----------' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AroundTheWorldIn80Days].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET ARITHABORT OFF 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET  ENABLE_BROKER 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET  MULTI_USER 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET QUERY_STORE = ON
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [AroundTheWorldIn80Days]
GO
/****** Object:  User [ReadAccessUser]    Script Date: 03.01.2024 16:38:07 ******/
CREATE USER [ReadAccessUser] FOR LOGIN [ReadAccessUser] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [OtherUser]    Script Date: 03.01.2024 16:38:07 ******/
CREATE USER [OtherUser] FOR LOGIN [OtherUser] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [AgencyDirector]    Script Date: 03.01.2024 16:38:07 ******/
CREATE USER [AgencyDirector] FOR LOGIN [AgencyDirector] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[CalculateAge]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CalculateAge]
    (@DOB DATE)
RETURNS INT
BEGIN
    DECLARE @Age INT
    SELECT @Age = DATEDIFF(YEAR, @DOB, GETDATE())
    IF (MONTH(@DOB) > MONTH(GETDATE()) OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE())))
    BEGIN
        SELECT @Age = @Age - 1
    END
    RETURN @Age
END
GO
/****** Object:  UserDefinedFunction [dbo].[CalculateTourPrice]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------1-----------

--CREATE VIEW [CurrentTours] AS
--SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
--FROM [Tours]
--JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
--WHERE [Tours].[EndDate] >= GETDATE();

-----------2-----------

--CREATE PROCEDURE [ToursByDateRange] 
--    @StartDate DATE,
--    @EndDate DATE
--AS
--BEGIN
--    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
--    FROM [Tours]
--    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
--    WHERE [Tours].[StartDate] BETWEEN @StartDate AND @EndDate
--END

-----------3-----------

--CREATE PROCEDURE [ToursByCountry]
--    @Country NVARCHAR(50)
--AS
--BEGIN
--    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
--    FROM [Tours]
--    JOIN [TourCities] ON [Tours].[TourID] = [TourCities].[TourID]
--    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
--    WHERE [TourCities].[Country] = @Country
--END

-----------4-----------

--CREATE VIEW [MostPopularTourCountry] AS
--SELECT TOP 1 [TourCities].[Country], COUNT(*) AS [TourCount]
--FROM [TourCities]
--GROUP BY [TourCities].[Country]
--ORDER BY [TourCount] DESC;

-----------5-----------

--CREATE VIEW [MostPopularUpToDateTour]
--AS
--SELECT TOP 1
--    T.TourID,
--    T.TourName,
--    COUNT(*) AS NumPurchasedTours
--FROM
--    Tours AS T
--    INNER JOIN PastTours AS PT ON T.TourID = PT.TourID
--WHERE
--    T.EndDate >= GETDATE()
--GROUP BY
--    T.TourID,
--    T.TourName
--ORDER BY
--    NumPurchasedTours DESC;

-----------6-----------

CREATE FUNCTION [dbo].[CalculateTourPrice]
    (@TourID INT, @NumTourists INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalPrice DECIMAL(10, 2)

    SELECT @TotalPrice = [Price] * @NumTourists
    FROM [Tours]
    WHERE [TourID] = @TourID

    SELECT @TotalPrice = @TotalPrice + SUM(
        CASE [IncludedInPrice]
            WHEN 1 THEN 0
            ELSE [ExtraCost]
        END
    )
    FROM [PointsOfInterest]
    WHERE [TourID] = @TourID

    RETURN @TotalPrice
END
GO
/****** Object:  Table [dbo].[Tours]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tours](
	[TourID] [int] IDENTITY(1,1) NOT NULL,
	[TourName] [nvarchar](100) NOT NULL,
	[Price] [decimal](10, 2) NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[TravelModes] [nvarchar](100) NOT NULL,
	[MaxTourists] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TourID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TourCities]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TourCities](
	[TourID] [int] NOT NULL,
	[Country] [nvarchar](50) NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[VisitDate] [date] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tourists]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tourists](
	[TouristID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[ContactPhone] [nvarchar](20) NOT NULL,
	[ContactEmail] [nvarchar](100) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TouristID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[TouristLocation]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------1-----------

--CREATE VIEW [CurrentTours] AS
--SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
--FROM [Tours]
--JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
--WHERE [Tours].[EndDate] >= GETDATE();

-----------2-----------

--CREATE PROCEDURE [ToursByDateRange] 
--    @StartDate DATE,
--    @EndDate DATE
--AS
--BEGIN
--    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
--    FROM [Tours]
--    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
--    WHERE [Tours].[StartDate] BETWEEN @StartDate AND @EndDate
--END

-----------3-----------

--CREATE PROCEDURE [ToursByCountry]
--    @Country NVARCHAR(50)
--AS
--BEGIN
--    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
--    FROM [Tours]
--    JOIN [TourCities] ON [Tours].[TourID] = [TourCities].[TourID]
--    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
--    WHERE [TourCities].[Country] = @Country
--END

-----------4-----------

--CREATE VIEW [MostPopularTourCountry] AS
--SELECT TOP 1 [TourCities].[Country], COUNT(*) AS [TourCount]
--FROM [TourCities]
--GROUP BY [TourCities].[Country]
--ORDER BY [TourCount] DESC;

-----------5-----------

--CREATE VIEW [MostPopularUpToDateTour]
--AS
--SELECT TOP 1
--    T.TourID,
--    T.TourName,
--    COUNT(*) AS NumPurchasedTours
--FROM
--    Tours AS T
--    INNER JOIN PastTours AS PT ON T.TourID = PT.TourID
--WHERE
--    T.EndDate >= GETDATE()
--GROUP BY
--    T.TourID,
--    T.TourName
--ORDER BY
--    NumPurchasedTours DESC;

-----------6-----------

--CREATE VIEW [MostPopularArchiveTour] AS
--SELECT t.TourID, t.TourName, COUNT(pt.TouristID) AS PurchasedVouchers
--FROM Tours t
--JOIN PastTours pt ON t.TourID = pt.TourID
--GROUP BY t.TourID, t.TourName
--ORDER BY PurchasedVouchers DESC
--OFFSET 0 ROWS
--FETCH NEXT 1 ROWS ONLY;

-----------7-----------

--CREATE VIEW [TouristTours] AS
--SELECT [Tours].[TourName], [Tours].[StartDate], [Tours].[EndDate]
--FROM [Tours]
--JOIN [Tourists] ON [Tours].[TourID] = [Tourists].[TouristID]
--WHERE [Tourists].[FullName] = 'Sarah Lee';

-----------9-----------

CREATE VIEW [dbo].[TouristLocation] AS
SELECT [Tours].[TourName], [TourCities].[Country], [TourCities].[City], [Tourists].[FullName] AS [TouristName]
FROM [Tours]
JOIN [TourCities] ON [Tours].[TourID] = [TourCities].[TourID]
JOIN [Tourists] ON [TourCities].[TourID] = [Tourists].[TouristID]
WHERE [Tourists].[FullName] = 'Emily Davis' AND [Tours].[StartDate] <= GETDATE() AND [Tours].[EndDate] >= GETDATE();
GO
/****** Object:  View [dbo].[UnpopularTours]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------1-----------

--CREATE VIEW [CurrentTours] AS
--SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
--FROM [Tours]
--JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
--WHERE [Tours].[EndDate] >= GETDATE();

-----------2-----------

--CREATE PROCEDURE [ToursByDateRange] 
--    @StartDate DATE,
--    @EndDate DATE
--AS
--BEGIN
--    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
--    FROM [Tours]
--    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
--    WHERE [Tours].[StartDate] BETWEEN @StartDate AND @EndDate
--END

-----------3-----------

--CREATE PROCEDURE [ToursByCountry]
--    @Country NVARCHAR(50)
--AS
--BEGIN
--    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
--    FROM [Tours]
--    JOIN [TourCities] ON [Tours].[TourID] = [TourCities].[TourID]
--    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
--    WHERE [TourCities].[Country] = @Country
--END

-----------4-----------

--CREATE VIEW [MostPopularTourCountry] AS
--SELECT TOP 1 [TourCities].[Country], COUNT(*) AS [TourCount]
--FROM [TourCities]
--GROUP BY [TourCities].[Country]
--ORDER BY [TourCount] DESC;

-----------5-----------

--CREATE VIEW [MostPopularUpToDateTour]
--AS
--SELECT TOP 1
--    T.TourID,
--    T.TourName,
--    COUNT(*) AS NumPurchasedTours
--FROM
--    Tours AS T
--    INNER JOIN PastTours AS PT ON T.TourID = PT.TourID
--WHERE
--    T.EndDate >= GETDATE()
--GROUP BY
--    T.TourID,
--    T.TourName
--ORDER BY
--    NumPurchasedTours DESC;

-----------6-----------

--CREATE VIEW [MostPopularArchiveTour] AS
--SELECT t.TourID, t.TourName, COUNT(pt.TouristID) AS PurchasedVouchers
--FROM Tours t
--JOIN PastTours pt ON t.TourID = pt.TourID
--GROUP BY t.TourID, t.TourName
--ORDER BY PurchasedVouchers DESC
--OFFSET 0 ROWS
--FETCH NEXT 1 ROWS ONLY;

-----------7-----------

CREATE VIEW [dbo].[UnpopularTours] AS
SELECT [Tours].[TourID], [Tours].[TourName], COUNT([Tourists].[TouristID]) AS [NumTourists]
FROM [Tours]
LEFT JOIN [Tourists] ON [Tours].[TourID] = [Tourists].[TouristID]
WHERE [Tours].[EndDate] >= GETDATE()
GROUP BY [Tours].[TourID], [Tours].[TourName]

-----------8-----------

--CREATE VIEW [TouristTours] AS
--SELECT [Tours].[TourName], [Tours].[StartDate], [Tours].[EndDate]
--FROM [Tours]
--JOIN [Tourists] ON [Tours].[TourID] = [Tourists].[TouristID]
--WHERE [Tourists].[FullName] = 'Sarah Lee';

-----------10-----------

GO
/****** Object:  View [dbo].[PopularTours]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------1-----------

--CREATE VIEW [CurrentTours] AS
--SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
--FROM [Tours]
--JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
--WHERE [Tours].[EndDate] >= GETDATE();

-----------2-----------

--CREATE PROCEDURE [ToursByDateRange] 
--    @StartDate DATE,
--    @EndDate DATE
--AS
--BEGIN
--    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
--    FROM [Tours]
--    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
--    WHERE [Tours].[StartDate] BETWEEN @StartDate AND @EndDate
--END

-----------3-----------

--CREATE PROCEDURE [ToursByCountry]
--    @Country NVARCHAR(50)
--AS
--BEGIN
--    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
--    FROM [Tours]
--    JOIN [TourCities] ON [Tours].[TourID] = [TourCities].[TourID]
--    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
--    WHERE [TourCities].[Country] = @Country
--END

-----------4-----------

--CREATE VIEW [MostPopularTourCountry] AS
--SELECT TOP 1 [TourCities].[Country], COUNT(*) AS [TourCount]
--FROM [TourCities]
--GROUP BY [TourCities].[Country]
--ORDER BY [TourCount] DESC;

-----------5-----------

--CREATE VIEW [PopularTours] AS
--SELECT [Tours].[TourID], [Tours].[TourName], [NumTourists]
--FROM [Tours]
--JOIN (
--SELECT [TouristID], COUNT(*) AS [NumTourists]
--FROM [Tourists]
--GROUP BY [TouristID]
--) AS [TouristCounts] ON [Tours].[TourID] = [TouristCounts].[TouristID]
--WHERE [Tours].[EndDate] >= GETDATE()

-----------6-----------

--CREATE VIEW [MostPopularArchiveTour] AS
--SELECT t.TourID, t.TourName, COUNT(pt.TouristID) AS PurchasedVouchers
--FROM Tours t
--JOIN PastTours pt ON t.TourID = pt.TourID
--GROUP BY t.TourID, t.TourName
--ORDER BY PurchasedVouchers DESC
--OFFSET 0 ROWS
--FETCH NEXT 1 ROWS ONLY;

-----------7-----------

--CREATE VIEW [UnpopularTours] AS
--SELECT [Tours].[TourID], [Tours].[TourName], COUNT([Tourists].[TouristID]) AS [NumTourists]
--FROM [Tours]
--LEFT JOIN [Tourists] ON [Tours].[TourID] = [Tourists].[TouristID]
--WHERE [Tours].[EndDate] >= GETDATE()
--GROUP BY [Tours].[TourID], [Tours].[TourName]

-----------8-----------

--CREATE VIEW [TouristTours] AS
--SELECT [Tours].[TourName], [Tours].[StartDate], [Tours].[EndDate]
--FROM [Tours]
--JOIN [Tourists] ON [Tours].[TourID] = [Tourists].[TouristID]
--WHERE [Tourists].[FullName] = 'Sarah Lee';

-----------11-----------
CREATE VIEW [dbo].[PopularTours] AS
SELECT TOP 1 WITH TIES [Tours].[TourID], [Tours].[TourName], COUNT([Tourists].[TouristID]) AS [NumTourists]
FROM [Tours]
JOIN [Tourists] ON [Tours].[TourID] = [Tourists].[TouristID]
WHERE [Tours].[EndDate] >= GETDATE()
GROUP BY [Tours].[TourID], [Tours].[TourName]
ORDER BY COUNT([Tourists].[TouristID]) DESC;
GO
/****** Object:  Table [dbo].[PastTours]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PastTours](
	[ClientID] [int] NOT NULL,
	[TourID] [int] NOT NULL,
	[TouristID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC,
	[TourID] ASC,
	[TouristID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[MostActiveTourist]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------1-----------

----CREATE VIEW [CurrentTours] AS
----SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
----FROM [Tours]
----JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
----WHERE [Tours].[EndDate] >= GETDATE();

-------------2-----------

----CREATE PROCEDURE [ToursByDateRange] 
----    @StartDate DATE,
----    @EndDate DATE
----AS
----BEGIN
----    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
----    FROM [Tours]
----    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
----    WHERE [Tours].[StartDate] BETWEEN @StartDate AND @EndDate
----END

-------------3-----------

----CREATE PROCEDURE [ToursByCountry]
----    @Country NVARCHAR(50)
----AS
----BEGIN
----    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
----    FROM [Tours]
----    JOIN [TourCities] ON [Tours].[TourID] = [TourCities].[TourID]
----    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
----    WHERE [TourCities].[Country] = @Country
----END

-------------4-----------

----CREATE VIEW [MostPopularTourCountry] AS
----SELECT TOP 1 [TourCities].[Country], COUNT(*) AS [TourCount]
----FROM [TourCities]
----GROUP BY [TourCities].[Country]
----ORDER BY [TourCount] DESC;

-------------5-----------

--CREATE VIEW [PopularTours] AS
--SELECT TOP 1 WITH TIES [Tours].[TourID], [Tours].[TourName], COUNT([Tourists].[TouristID]) AS [NumTourists]
--FROM [Tours]
--JOIN [Tourists] ON [Tours].[TourID] = [Tourists].[TouristID]
--WHERE [Tours].[EndDate] >= GETDATE()
--GROUP BY [Tours].[TourID], [Tours].[TourName]
--ORDER BY COUNT([Tourists].[TouristID]) DESC;

-------------6-----------

----CREATE VIEW [MostPopularArchiveTour] AS
----SELECT t.TourID, t.TourName, COUNT(pt.TouristID) AS PurchasedVouchers
----FROM Tours t
----JOIN PastTours pt ON t.TourID = pt.TourID
----GROUP BY t.TourID, t.TourName
----ORDER BY PurchasedVouchers DESC
----OFFSET 0 ROWS
----FETCH NEXT 1 ROWS ONLY;

-------------7-----------

----CREATE VIEW [UnpopularTours] AS
----SELECT [Tours].[TourID], [Tours].[TourName], COUNT([Tourists].[TouristID]) AS [NumTourists]
----FROM [Tours]
----LEFT JOIN [Tourists] ON [Tours].[TourID] = [Tourists].[TouristID]
----WHERE [Tours].[EndDate] >= GETDATE()
----GROUP BY [Tours].[TourID], [Tours].[TourName]

-------------8-----------

----CREATE VIEW [TouristTours] AS
----SELECT [Tours].[TourName], [Tours].[StartDate], [Tours].[EndDate]
----FROM [Tours]
----JOIN [Tourists] ON [Tours].[TourID] = [Tourists].[TouristID]
----WHERE [Tourists].[FullName] = 'Sarah Lee';

-------------11-----------

CREATE VIEW [dbo].[MostActiveTourist] AS
SELECT [Tourists].[TouristID], [Tourists].[FullName], [Tourists].[ContactPhone], [Tourists].[ContactEmail], [Tourists].[DateOfBirth], COUNT(*) AS [TourCount]
FROM [Tourists]
JOIN [PastTours] ON [Tourists].[TouristID] = [PastTours].[TouristID]
GROUP BY [Tourists].[TouristID], [Tourists].[FullName], [Tourists].[ContactPhone], [Tourists].[ContactEmail], [Tourists].[DateOfBirth];
GO
/****** Object:  Table [dbo].[Hotels]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hotels](
	[TourID] [int] NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[HotelName] [nvarchar](100) NOT NULL,
	[HotelImage] [varbinary](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[ToursByTravelMode]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------1-----------

----CREATE VIEW [CurrentTours] AS
----SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
----FROM [Tours]
----JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
----WHERE [Tours].[EndDate] >= GETDATE();

-------------2-----------

----CREATE PROCEDURE [ToursByDateRange] 
----    @StartDate DATE,
----    @EndDate DATE
----AS
----BEGIN
----    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
----    FROM [Tours]
----    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
----    WHERE [Tours].[StartDate] BETWEEN @StartDate AND @EndDate
----END

-------------3-----------

----CREATE PROCEDURE [ToursByCountry]
----    @Country NVARCHAR(50)
----AS
----BEGIN
----    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
----    FROM [Tours]
----    JOIN [TourCities] ON [Tours].[TourID] = [TourCities].[TourID]
----    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
----    WHERE [TourCities].[Country] = @Country
----END

-------------4-----------

----CREATE VIEW [MostPopularTourCountry] AS
----SELECT TOP 1 [TourCities].[Country], COUNT(*) AS [TourCount]
----FROM [TourCities]
----GROUP BY [TourCities].[Country]
----ORDER BY [TourCount] DESC;

-------------5-----------

--CREATE VIEW [PopularTours] AS
--SELECT TOP 1 WITH TIES [Tours].[TourID], [Tours].[TourName], COUNT([Tourists].[TouristID]) AS [NumTourists]
--FROM [Tours]
--JOIN [Tourists] ON [Tours].[TourID] = [Tourists].[TouristID]
--WHERE [Tours].[EndDate] >= GETDATE()
--GROUP BY [Tours].[TourID], [Tours].[TourName]
--ORDER BY COUNT([Tourists].[TouristID]) DESC;

-------------6-----------

----CREATE VIEW [MostPopularArchiveTour] AS
----SELECT t.TourID, t.TourName, COUNT(pt.TouristID) AS PurchasedVouchers
----FROM Tours t
----JOIN PastTours pt ON t.TourID = pt.TourID
----GROUP BY t.TourID, t.TourName
----ORDER BY PurchasedVouchers DESC
----OFFSET 0 ROWS
----FETCH NEXT 1 ROWS ONLY;

-------------7-----------

----CREATE VIEW [UnpopularTours] AS
----SELECT [Tours].[TourID], [Tours].[TourName], COUNT([Tourists].[TouristID]) AS [NumTourists]
----FROM [Tours]
----LEFT JOIN [Tourists] ON [Tours].[TourID] = [Tourists].[TouristID]
----WHERE [Tours].[EndDate] >= GETDATE()
----GROUP BY [Tours].[TourID], [Tours].[TourName]

-------------8-----------

----CREATE VIEW [TouristTours] AS
----SELECT [Tours].[TourName], [Tours].[StartDate], [Tours].[EndDate]
----FROM [Tours]
----JOIN [Tourists] ON [Tours].[TourID] = [Tourists].[TouristID]
----WHERE [Tourists].[FullName] = 'Sarah Lee';

-------------11-----------

--CREATE VIEW [MostActiveTourist] AS
--SELECT [Tourists].[TouristID], [Tourists].[FullName], [Tourists].[ContactPhone], [Tourists].[ContactEmail], [Tourists].[DateOfBirth], COUNT(*) AS [TourCount]
--FROM [Tourists]
--JOIN [PastTours] ON [Tourists].[TouristID] = [PastTours].[TouristID]
--GROUP BY [Tourists].[TouristID], [Tourists].[FullName], [Tourists].[ContactPhone], [Tourists].[ContactEmail], [Tourists].[DateOfBirth];

CREATE VIEW [dbo].[ToursByTravelMode] AS
SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [TourCities].[Country], [TourCities].[City], [TourCities].[VisitDate], [Hotels].[HotelName]
FROM [Tours]
JOIN [TourCities] ON [Tours].[TourID] = [TourCities].[TourID]
JOIN [Hotels] ON [TourCities].[City] = [Hotels].[City] AND [Tours].[TourID] = [Hotels].[TourID]
WHERE [Tours].[TravelModes] LIKE '%' + 'Car' + '%';
GO
/****** Object:  View [dbo].[MostPopularHotel]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------1-------------

----CREATE VIEW [CurrentTours] AS
----SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
----FROM [Tours]
----JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
----WHERE [Tours].[EndDate] >= GETDATE();

-------------2-------------

----CREATE PROCEDURE [ToursByDateRange] 
----    @StartDate DATE,
----    @EndDate DATE
----AS
----BEGIN
----    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
----    FROM [Tours]
----    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
----    WHERE [Tours].[StartDate] BETWEEN @StartDate AND @EndDate
----END

-------------3-------------

----CREATE PROCEDURE [ToursByCountry]
----    @Country NVARCHAR(50)
----AS
----BEGIN
----    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
----    FROM [Tours]
----    JOIN [TourCities] ON [Tours].[TourID] = [TourCities].[TourID]
----    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
----    WHERE [TourCities].[Country] = @Country
----END

-------------4-------------

----CREATE VIEW [MostPopularTourCountry] AS
----SELECT TOP 1 [TourCities].[Country], COUNT(*) AS [TourCount]
----FROM [TourCities]
----GROUP BY [TourCities].[Country]
----ORDER BY [TourCount] DESC;

-------------5-------------

--CREATE VIEW [PopularTours] AS
--SELECT TOP 1 WITH TIES [Tours].[TourID], [Tours].[TourName], COUNT([Tourists].[TouristID]) AS [NumTourists]
--FROM [Tours]
--JOIN [Tourists] ON [Tours].[TourID] = [Tourists].[TouristID]
--WHERE [Tours].[EndDate] >= GETDATE()
--GROUP BY [Tours].[TourID], [Tours].[TourName]
--ORDER BY COUNT([Tourists].[TouristID]) DESC;

-------------6-------------

----CREATE VIEW [MostPopularArchiveTour] AS
----SELECT t.TourID, t.TourName, COUNT(pt.TouristID) AS PurchasedVouchers
----FROM Tours t
----JOIN PastTours pt ON t.TourID = pt.TourID
----GROUP BY t.TourID, t.TourName
----ORDER BY PurchasedVouchers DESC
----OFFSET 0 ROWS
----FETCH NEXT 1 ROWS ONLY;

-------------7-------------

----CREATE VIEW [UnpopularTours] AS
----SELECT [Tours].[TourID], [Tours].[TourName], COUNT([Tourists].[TouristID]) AS [NumTourists]
----FROM [Tours]
----LEFT JOIN [Tourists] ON [Tours].[TourID] = [Tourists].[TouristID]
----WHERE [Tours].[EndDate] >= GETDATE()
----GROUP BY [Tours].[TourID], [Tours].[TourName]

-------------8-------------

----CREATE VIEW [TouristTours] AS
----SELECT [Tours].[TourName], [Tours].[StartDate], [Tours].[EndDate]
----FROM [Tours]
----JOIN [Tourists] ON [Tours].[TourID] = [Tourists].[TouristID]
----WHERE [Tourists].[FullName] = 'Sarah Lee';

-------------11-------------

--CREATE VIEW [MostActiveTourist] AS
--SELECT [Tourists].[TouristID], [Tourists].[FullName], [Tourists].[ContactPhone], [Tourists].[ContactEmail], [Tourists].[DateOfBirth], COUNT(*) AS [TourCount]
--FROM [Tourists]
--JOIN [PastTours] ON [Tourists].[TouristID] = [PastTours].[TouristID]
--GROUP BY [Tourists].[TouristID], [Tourists].[FullName], [Tourists].[ContactPhone], [Tourists].[ContactEmail], [Tourists].[DateOfBirth];

-------------12-------------

--CREATE VIEW [ToursByTravelMode] AS
--SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [TourCities].[Country], [TourCities].[City], [TourCities].[VisitDate], [Hotels].[HotelName]
--FROM [Tours]
--JOIN [TourCities] ON [Tours].[TourID] = [TourCities].[TourID]
--JOIN [Hotels] ON [TourCities].[City] = [Hotels].[City] AND [Tours].[TourID] = [Hotels].[TourID]
--WHERE [Tours].[TravelModes] LIKE '%' + 'Car' + '%';

-------------13-------------

--CREATE TRIGGER [dbo].[CheckClientExists]
--ON [dbo].[Clients]
--FOR INSERT
--AS
--BEGIN
--    IF EXISTS (
--        SELECT 1 FROM [dbo].[Clients] c
--        INNER JOIN inserted i ON c.[FullName] = i.[FullName]
--        WHERE c.[ContactPhone] = i.[ContactPhone] AND c.[ContactEmail] = i.[ContactEmail] AND c.[DateOfBirth] = i.[DateOfBirth]
--    )
--    BEGIN
--        RAISERROR ('Client already exists in the database', 16, 1)
--        ROLLBACK TRANSACTION
--    END
--END

-------------14-------------

--CREATE PROCEDURE [dbo].[MovePastToursToArchive]
--AS
--BEGIN
--    SET NOCOUNT ON;

--    DECLARE @TourID INT, @ClientID INT, @TouristID INT;

--    DECLARE cur CURSOR FOR
--    SELECT [TourID], [ClientID], [TouristID] FROM [dbo].[PastTours];

--    OPEN cur;

--    FETCH NEXT FROM cur INTO @TourID, @ClientID, @TouristID;

--    WHILE @@FETCH_STATUS = 0
--    BEGIN
--        INSERT INTO [dbo].[TourArchive] ([TourID], [ClientID], [TouristID])
--        VALUES (@TourID, @ClientID, @TouristID);

--        DELETE FROM [dbo].[PastTours]
--        WHERE [TourID] = @TourID AND [ClientID] = @ClientID AND [TouristID] = @TouristID;

--        FETCH NEXT FROM cur INTO @TourID, @ClientID, @TouristID;
--    END;

--    CLOSE cur;
--    DEALLOCATE cur;
--END

-------------15-------------

CREATE VIEW [dbo].[MostPopularHotel] AS
SELECT TOP 1
    h.[HotelName],
    COUNT(*) AS [NumTourists]
FROM
    [dbo].[Hotels] h
    INNER JOIN [dbo].[TourCities] tc ON h.[TourID] = tc.[TourID]
    INNER JOIN [dbo].[Tourists] t ON t.[TouristID] = t.[TouristID]
GROUP BY
    h.[HotelName]
ORDER BY
    COUNT(*) DESC;
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[Position] [nvarchar](50) NOT NULL,
	[ContactPhone] [nvarchar](20) NOT NULL,
	[ContactEmail] [nvarchar](100) NOT NULL,
	[DateEmployed] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CurrentTours]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CurrentTours] AS
SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
FROM [Tours]
JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
WHERE [Tours].[EndDate] >= GETDATE();
GO
/****** Object:  View [dbo].[MostPopularTourCountry]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MostPopularTourCountry] AS
SELECT TOP 1 [TourCities].[Country], COUNT(*) AS [TourCount]
FROM [TourCities]
GROUP BY [TourCities].[Country]
ORDER BY [TourCount] DESC;
GO
/****** Object:  View [dbo].[MostPopularArchiveTour]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------1-----------

--CREATE VIEW [CurrentTours] AS
--SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
--FROM [Tours]
--JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
--WHERE [Tours].[EndDate] >= GETDATE();

-----------2-----------

--CREATE PROCEDURE [ToursByDateRange] 
--    @StartDate DATE,
--    @EndDate DATE
--AS
--BEGIN
--    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
--    FROM [Tours]
--    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
--    WHERE [Tours].[StartDate] BETWEEN @StartDate AND @EndDate
--END

-----------3-----------

--CREATE PROCEDURE [ToursByCountry]
--    @Country NVARCHAR(50)
--AS
--BEGIN
--    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
--    FROM [Tours]
--    JOIN [TourCities] ON [Tours].[TourID] = [TourCities].[TourID]
--    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
--    WHERE [TourCities].[Country] = @Country
--END

-----------4-----------

--CREATE VIEW [MostPopularTourCountry] AS
--SELECT TOP 1 [TourCities].[Country], COUNT(*) AS [TourCount]
--FROM [TourCities]
--GROUP BY [TourCities].[Country]
--ORDER BY [TourCount] DESC;

-----------5-----------

--CREATE VIEW [MostPopularUpToDateTour]
--AS
--SELECT TOP 1
--    T.TourID,
--    T.TourName,
--    COUNT(*) AS NumPurchasedTours
--FROM
--    Tours AS T
--    INNER JOIN PastTours AS PT ON T.TourID = PT.TourID
--WHERE
--    T.EndDate >= GETDATE()
--GROUP BY
--    T.TourID,
--    T.TourName
--ORDER BY
--    NumPurchasedTours DESC;

-----------6-----------

CREATE VIEW [dbo].[MostPopularArchiveTour] AS
SELECT t.TourID, t.TourName, COUNT(pt.TouristID) AS PurchasedVouchers
FROM Tours t
JOIN PastTours pt ON t.TourID = pt.TourID
GROUP BY t.TourID, t.TourName
ORDER BY PurchasedVouchers DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;
GO
/****** Object:  View [dbo].[TouristTours]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------1-----------

--CREATE VIEW [CurrentTours] AS
--SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
--FROM [Tours]
--JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
--WHERE [Tours].[EndDate] >= GETDATE();

-----------2-----------

--CREATE PROCEDURE [ToursByDateRange] 
--    @StartDate DATE,
--    @EndDate DATE
--AS
--BEGIN
--    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
--    FROM [Tours]
--    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
--    WHERE [Tours].[StartDate] BETWEEN @StartDate AND @EndDate
--END

-----------3-----------

--CREATE PROCEDURE [ToursByCountry]
--    @Country NVARCHAR(50)
--AS
--BEGIN
--    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
--    FROM [Tours]
--    JOIN [TourCities] ON [Tours].[TourID] = [TourCities].[TourID]
--    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
--    WHERE [TourCities].[Country] = @Country
--END

-----------4-----------

--CREATE VIEW [MostPopularTourCountry] AS
--SELECT TOP 1 [TourCities].[Country], COUNT(*) AS [TourCount]
--FROM [TourCities]
--GROUP BY [TourCities].[Country]
--ORDER BY [TourCount] DESC;

-----------5-----------

--CREATE VIEW [MostPopularUpToDateTour]
--AS
--SELECT TOP 1
--    T.TourID,
--    T.TourName,
--    COUNT(*) AS NumPurchasedTours
--FROM
--    Tours AS T
--    INNER JOIN PastTours AS PT ON T.TourID = PT.TourID
--WHERE
--    T.EndDate >= GETDATE()
--GROUP BY
--    T.TourID,
--    T.TourName
--ORDER BY
--    NumPurchasedTours DESC;

-----------6-----------

--CREATE VIEW [MostPopularArchiveTour] AS
--SELECT t.TourID, t.TourName, COUNT(pt.TouristID) AS PurchasedVouchers
--FROM Tours t
--JOIN PastTours pt ON t.TourID = pt.TourID
--GROUP BY t.TourID, t.TourName
--ORDER BY PurchasedVouchers DESC
--OFFSET 0 ROWS
--FETCH NEXT 1 ROWS ONLY;

-----------7-----------

CREATE VIEW [dbo].[TouristTours] AS
SELECT [Tours].[TourName], [Tours].[StartDate], [Tours].[EndDate]
FROM [Tours]
JOIN [Tourists] ON [Tours].[TourID] = [Tourists].[TouristID]
WHERE [Tourists].[FullName] = 'Sarah Lee';

-----------8-----------
GO
/****** Object:  Table [dbo].[Clients]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clients](
	[ClientID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[ContactPhone] [nvarchar](20) NOT NULL,
	[ContactEmail] [nvarchar](100) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FutureTours]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FutureTours](
	[ClientID] [int] NOT NULL,
	[TourID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC,
	[TourID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PointsOfInterest]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PointsOfInterest](
	[TourID] [int] NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[PointOfInterest] [nvarchar](100) NOT NULL,
	[IncludedInPrice] [bit] NOT NULL,
	[ExtraCost] [decimal](10, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PotentialTourists]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PotentialTourists](
	[TourID] [int] NOT NULL,
	[TouristID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TourID] ASC,
	[TouristID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SightImages]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SightImages](
	[TourID] [int] NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[SightImage] [varbinary](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TourArchive]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TourArchive](
	[TourID] [int] NOT NULL,
	[ClientID] [int] NOT NULL,
	[TouristID] [int] NOT NULL,
	[ArchivedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TourEmployees]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TourEmployees](
	[EmployeeID] [int] NOT NULL,
	[Country] [nvarchar](50) NOT NULL,
	[TourName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_FutureTours_ClientID]    Script Date: 03.01.2024 16:38:07 ******/
CREATE NONCLUSTERED INDEX [IX_FutureTours_ClientID] ON [dbo].[FutureTours]
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_FutureTours_TourID]    Script Date: 03.01.2024 16:38:07 ******/
CREATE NONCLUSTERED INDEX [IX_FutureTours_TourID] ON [dbo].[FutureTours]
(
	[TourID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Hotels_TourID]    Script Date: 03.01.2024 16:38:07 ******/
CREATE NONCLUSTERED INDEX [IX_Hotels_TourID] ON [dbo].[Hotels]
(
	[TourID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PastTours_ClientID]    Script Date: 03.01.2024 16:38:07 ******/
CREATE NONCLUSTERED INDEX [IX_PastTours_ClientID] ON [dbo].[PastTours]
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PastTours_TourID]    Script Date: 03.01.2024 16:38:07 ******/
CREATE NONCLUSTERED INDEX [IX_PastTours_TourID] ON [dbo].[PastTours]
(
	[TourID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PastTours_TouristID]    Script Date: 03.01.2024 16:38:07 ******/
CREATE NONCLUSTERED INDEX [IX_PastTours_TouristID] ON [dbo].[PastTours]
(
	[TouristID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PointsOfInterest_TourID]    Script Date: 03.01.2024 16:38:07 ******/
CREATE NONCLUSTERED INDEX [IX_PointsOfInterest_TourID] ON [dbo].[PointsOfInterest]
(
	[TourID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PotentialTourists_TourID]    Script Date: 03.01.2024 16:38:07 ******/
CREATE NONCLUSTERED INDEX [IX_PotentialTourists_TourID] ON [dbo].[PotentialTourists]
(
	[TourID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_TourCities_TourID]    Script Date: 03.01.2024 16:38:07 ******/
CREATE NONCLUSTERED INDEX [IX_TourCities_TourID] ON [dbo].[TourCities]
(
	[TourID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Tours_EmployeeID]    Script Date: 03.01.2024 16:38:07 ******/
CREATE NONCLUSTERED INDEX [IX_Tours_EmployeeID] ON [dbo].[Tours]
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TourArchive] ADD  CONSTRAINT [DF_TourArchive_ArchivedDate]  DEFAULT (getdate()) FOR [ArchivedDate]
GO
ALTER TABLE [dbo].[FutureTours]  WITH CHECK ADD FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ClientID])
GO
ALTER TABLE [dbo].[FutureTours]  WITH CHECK ADD FOREIGN KEY([TourID])
REFERENCES [dbo].[Tours] ([TourID])
GO
ALTER TABLE [dbo].[Hotels]  WITH CHECK ADD FOREIGN KEY([TourID])
REFERENCES [dbo].[Tours] ([TourID])
GO
ALTER TABLE [dbo].[PastTours]  WITH CHECK ADD FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ClientID])
GO
ALTER TABLE [dbo].[PastTours]  WITH CHECK ADD FOREIGN KEY([TourID])
REFERENCES [dbo].[Tours] ([TourID])
GO
ALTER TABLE [dbo].[PastTours]  WITH CHECK ADD FOREIGN KEY([TouristID])
REFERENCES [dbo].[Tourists] ([TouristID])
GO
ALTER TABLE [dbo].[PointsOfInterest]  WITH CHECK ADD FOREIGN KEY([TourID])
REFERENCES [dbo].[Tours] ([TourID])
GO
ALTER TABLE [dbo].[PotentialTourists]  WITH CHECK ADD FOREIGN KEY([TourID])
REFERENCES [dbo].[Tours] ([TourID])
GO
ALTER TABLE [dbo].[PotentialTourists]  WITH CHECK ADD FOREIGN KEY([TouristID])
REFERENCES [dbo].[Tourists] ([TouristID])
GO
ALTER TABLE [dbo].[SightImages]  WITH CHECK ADD FOREIGN KEY([TourID])
REFERENCES [dbo].[Tours] ([TourID])
GO
ALTER TABLE [dbo].[TourCities]  WITH CHECK ADD FOREIGN KEY([TourID])
REFERENCES [dbo].[Tours] ([TourID])
GO
ALTER TABLE [dbo].[TourEmployees]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Tours]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
/****** Object:  StoredProcedure [dbo].[AddTouristToTour]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------1-------------

----CREATE VIEW [CurrentTours] AS
----SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
----FROM [Tours]
----JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
----WHERE [Tours].[EndDate] >= GETDATE();

-------------2-------------

----CREATE PROCEDURE [ToursByDateRange] 
----    @StartDate DATE,
----    @EndDate DATE
----AS
----BEGIN
----    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
----    FROM [Tours]
----    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
----    WHERE [Tours].[StartDate] BETWEEN @StartDate AND @EndDate
----END

-------------3-------------

----CREATE PROCEDURE [ToursByCountry]
----    @Country NVARCHAR(50)
----AS
----BEGIN
----    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
----    FROM [Tours]
----    JOIN [TourCities] ON [Tours].[TourID] = [TourCities].[TourID]
----    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
----    WHERE [TourCities].[Country] = @Country
----END

-------------4-------------

----CREATE VIEW [MostPopularTourCountry] AS
----SELECT TOP 1 [TourCities].[Country], COUNT(*) AS [TourCount]
----FROM [TourCities]
----GROUP BY [TourCities].[Country]
----ORDER BY [TourCount] DESC;

-------------5-------------

--CREATE VIEW [PopularTours] AS
--SELECT TOP 1 WITH TIES [Tours].[TourID], [Tours].[TourName], COUNT([Tourists].[TouristID]) AS [NumTourists]
--FROM [Tours]
--JOIN [Tourists] ON [Tours].[TourID] = [Tourists].[TouristID]
--WHERE [Tours].[EndDate] >= GETDATE()
--GROUP BY [Tours].[TourID], [Tours].[TourName]
--ORDER BY COUNT([Tourists].[TouristID]) DESC;

-------------6-------------

----CREATE VIEW [MostPopularArchiveTour] AS
----SELECT t.TourID, t.TourName, COUNT(pt.TouristID) AS PurchasedVouchers
----FROM Tours t
----JOIN PastTours pt ON t.TourID = pt.TourID
----GROUP BY t.TourID, t.TourName
----ORDER BY PurchasedVouchers DESC
----OFFSET 0 ROWS
----FETCH NEXT 1 ROWS ONLY;

-------------7-------------

----CREATE VIEW [UnpopularTours] AS
----SELECT [Tours].[TourID], [Tours].[TourName], COUNT([Tourists].[TouristID]) AS [NumTourists]
----FROM [Tours]
----LEFT JOIN [Tourists] ON [Tours].[TourID] = [Tourists].[TouristID]
----WHERE [Tours].[EndDate] >= GETDATE()
----GROUP BY [Tours].[TourID], [Tours].[TourName]

-------------8-------------

----CREATE VIEW [TouristTours] AS
----SELECT [Tours].[TourName], [Tours].[StartDate], [Tours].[EndDate]
----FROM [Tours]
----JOIN [Tourists] ON [Tours].[TourID] = [Tourists].[TouristID]
----WHERE [Tourists].[FullName] = 'Sarah Lee';

-------------11-------------

--CREATE VIEW [MostActiveTourist] AS
--SELECT [Tourists].[TouristID], [Tourists].[FullName], [Tourists].[ContactPhone], [Tourists].[ContactEmail], [Tourists].[DateOfBirth], COUNT(*) AS [TourCount]
--FROM [Tourists]
--JOIN [PastTours] ON [Tourists].[TouristID] = [PastTours].[TouristID]
--GROUP BY [Tourists].[TouristID], [Tourists].[FullName], [Tourists].[ContactPhone], [Tourists].[ContactEmail], [Tourists].[DateOfBirth];

-------------12-------------

--CREATE VIEW [ToursByTravelMode] AS
--SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [TourCities].[Country], [TourCities].[City], [TourCities].[VisitDate], [Hotels].[HotelName]
--FROM [Tours]
--JOIN [TourCities] ON [Tours].[TourID] = [TourCities].[TourID]
--JOIN [Hotels] ON [TourCities].[City] = [Hotels].[City] AND [Tours].[TourID] = [Hotels].[TourID]
--WHERE [Tours].[TravelModes] LIKE '%' + 'Car' + '%';

-------------13-------------

--CREATE TRIGGER [dbo].[CheckClientExists]
--ON [dbo].[Clients]
--FOR INSERT
--AS
--BEGIN
--    IF EXISTS (
--        SELECT 1 FROM [dbo].[Clients] c
--        INNER JOIN inserted i ON c.[FullName] = i.[FullName]
--        WHERE c.[ContactPhone] = i.[ContactPhone] AND c.[ContactEmail] = i.[ContactEmail] AND c.[DateOfBirth] = i.[DateOfBirth]
--    )
--    BEGIN
--        RAISERROR ('Client already exists in the database', 16, 1)
--        ROLLBACK TRANSACTION
--    END
--END

-------------14-------------

--CREATE PROCEDURE [dbo].[MovePastToursToArchive]
--AS
--BEGIN
--    SET NOCOUNT ON;

--    DECLARE @TourID INT, @ClientID INT, @TouristID INT;

--    DECLARE cur CURSOR FOR
--    SELECT [TourID], [ClientID], [TouristID] FROM [dbo].[PastTours];

--    OPEN cur;

--    FETCH NEXT FROM cur INTO @TourID, @ClientID, @TouristID;

--    WHILE @@FETCH_STATUS = 0
--    BEGIN
--        INSERT INTO [dbo].[TourArchive] ([TourID], [ClientID], [TouristID])
--        VALUES (@TourID, @ClientID, @TouristID);

--        DELETE FROM [dbo].[PastTours]
--        WHERE [TourID] = @TourID AND [ClientID] = @ClientID AND [TouristID] = @TouristID;

--        FETCH NEXT FROM cur INTO @TourID, @ClientID, @TouristID;
--    END;

--    CLOSE cur;
--    DEALLOCATE cur;
--END

-------------15-------------

--CREATE VIEW [dbo].[MostPopularHotel] AS
--SELECT TOP 1
--    h.[HotelName],
--    COUNT(*) AS [NumTourists]
--FROM
--    [dbo].[Hotels] h
--    INNER JOIN [dbo].[TourCities] tc ON h.[TourID] = tc.[TourID]
--    INNER JOIN [dbo].[Tourists] t ON t.[TouristID] = t.[TouristID]
--GROUP BY
--    h.[HotelName]
--ORDER BY
--    COUNT(*) DESC;

-------------16-------------

CREATE PROCEDURE [dbo].[AddTouristToTour]
    @TourID INT,
    @ClientID INT,
    @TouristName NVARCHAR(50),
    @TouristEmail NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @MaxTourists INT;

    SELECT @MaxTourists = [MaxTourists] FROM [dbo].[Tours] WHERE [TourID] = @TourID;

    IF (SELECT COUNT(*) FROM [dbo].[PastTours] WHERE [TourID] = @TourID AND [ClientID] = @ClientID) >= @MaxTourists
    BEGIN
        RAISERROR('Maximum number of tourists for this tour has been reached.', 16, 1);
        RETURN;
    END

    DECLARE @TouristID INT;

    INSERT INTO [dbo].[Tourists] ([FullName], [ContactEmail])
    VALUES (@TouristName, @TouristEmail);

    SET @TouristID = SCOPE_IDENTITY();

    INSERT INTO [dbo].[PastTours] ([TourID], [ClientID], [TouristID])
    VALUES (@TourID, @ClientID, @TouristID);
END
GO
/****** Object:  StoredProcedure [dbo].[MovePastToursToArchive]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------1-----------

----CREATE VIEW [CurrentTours] AS
----SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
----FROM [Tours]
----JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
----WHERE [Tours].[EndDate] >= GETDATE();

-------------2-----------

----CREATE PROCEDURE [ToursByDateRange] 
----    @StartDate DATE,
----    @EndDate DATE
----AS
----BEGIN
----    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
----    FROM [Tours]
----    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
----    WHERE [Tours].[StartDate] BETWEEN @StartDate AND @EndDate
----END

-------------3-----------

----CREATE PROCEDURE [ToursByCountry]
----    @Country NVARCHAR(50)
----AS
----BEGIN
----    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
----    FROM [Tours]
----    JOIN [TourCities] ON [Tours].[TourID] = [TourCities].[TourID]
----    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
----    WHERE [TourCities].[Country] = @Country
----END

-------------4-----------

----CREATE VIEW [MostPopularTourCountry] AS
----SELECT TOP 1 [TourCities].[Country], COUNT(*) AS [TourCount]
----FROM [TourCities]
----GROUP BY [TourCities].[Country]
----ORDER BY [TourCount] DESC;

-------------5-----------

--CREATE VIEW [PopularTours] AS
--SELECT TOP 1 WITH TIES [Tours].[TourID], [Tours].[TourName], COUNT([Tourists].[TouristID]) AS [NumTourists]
--FROM [Tours]
--JOIN [Tourists] ON [Tours].[TourID] = [Tourists].[TouristID]
--WHERE [Tours].[EndDate] >= GETDATE()
--GROUP BY [Tours].[TourID], [Tours].[TourName]
--ORDER BY COUNT([Tourists].[TouristID]) DESC;

-------------6-----------

----CREATE VIEW [MostPopularArchiveTour] AS
----SELECT t.TourID, t.TourName, COUNT(pt.TouristID) AS PurchasedVouchers
----FROM Tours t
----JOIN PastTours pt ON t.TourID = pt.TourID
----GROUP BY t.TourID, t.TourName
----ORDER BY PurchasedVouchers DESC
----OFFSET 0 ROWS
----FETCH NEXT 1 ROWS ONLY;

-------------7-----------

----CREATE VIEW [UnpopularTours] AS
----SELECT [Tours].[TourID], [Tours].[TourName], COUNT([Tourists].[TouristID]) AS [NumTourists]
----FROM [Tours]
----LEFT JOIN [Tourists] ON [Tours].[TourID] = [Tourists].[TouristID]
----WHERE [Tours].[EndDate] >= GETDATE()
----GROUP BY [Tours].[TourID], [Tours].[TourName]

-------------8-----------

----CREATE VIEW [TouristTours] AS
----SELECT [Tours].[TourName], [Tours].[StartDate], [Tours].[EndDate]
----FROM [Tours]
----JOIN [Tourists] ON [Tours].[TourID] = [Tourists].[TouristID]
----WHERE [Tourists].[FullName] = 'Sarah Lee';

-------------11-----------

--CREATE VIEW [MostActiveTourist] AS
--SELECT [Tourists].[TouristID], [Tourists].[FullName], [Tourists].[ContactPhone], [Tourists].[ContactEmail], [Tourists].[DateOfBirth], COUNT(*) AS [TourCount]
--FROM [Tourists]
--JOIN [PastTours] ON [Tourists].[TouristID] = [PastTours].[TouristID]
--GROUP BY [Tourists].[TouristID], [Tourists].[FullName], [Tourists].[ContactPhone], [Tourists].[ContactEmail], [Tourists].[DateOfBirth];

-------------12-----------

--CREATE VIEW [ToursByTravelMode] AS
--SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [TourCities].[Country], [TourCities].[City], [TourCities].[VisitDate], [Hotels].[HotelName]
--FROM [Tours]
--JOIN [TourCities] ON [Tours].[TourID] = [TourCities].[TourID]
--JOIN [Hotels] ON [TourCities].[City] = [Hotels].[City] AND [Tours].[TourID] = [Hotels].[TourID]
--WHERE [Tours].[TravelModes] LIKE '%' + 'Car' + '%';

-------------13-----------

--CREATE TRIGGER [dbo].[CheckClientExists]
--ON [dbo].[Clients]
--FOR INSERT
--AS
--BEGIN
--    IF EXISTS (
--        SELECT 1 FROM [dbo].[Clients] c
--        INNER JOIN inserted i ON c.[FullName] = i.[FullName]
--        WHERE c.[ContactPhone] = i.[ContactPhone] AND c.[ContactEmail] = i.[ContactEmail] AND c.[DateOfBirth] = i.[DateOfBirth]
--    )
--    BEGIN
--        RAISERROR ('Client already exists in the database', 16, 1)
--        ROLLBACK TRANSACTION
--    END
--END

-------------14-----------

CREATE PROCEDURE [dbo].[MovePastToursToArchive]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @TourID INT, @ClientID INT, @TouristID INT;

    DECLARE cur CURSOR FOR
    SELECT [TourID], [ClientID], [TouristID] FROM [dbo].[PastTours];

    OPEN cur;

    FETCH NEXT FROM cur INTO @TourID, @ClientID, @TouristID;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT INTO [dbo].[TourArchive] ([TourID], [ClientID], [TouristID])
        VALUES (@TourID, @ClientID, @TouristID);

        DELETE FROM [dbo].[PastTours]
        WHERE [TourID] = @TourID AND [ClientID] = @ClientID AND [TouristID] = @TouristID;

        FETCH NEXT FROM cur INTO @TourID, @ClientID, @TouristID;
    END;

    CLOSE cur;
    DEALLOCATE cur;
END
GO
/****** Object:  StoredProcedure [dbo].[TouristTrips]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE VIEW [CurrentTours] AS
--SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
--FROM [Tours]
--JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
--WHERE [Tours].[EndDate] >= GETDATE();

--CREATE PROCEDURE [ToursByDateRange] 
--    @StartDate DATE,
--    @EndDate DATE
--AS
--BEGIN
--    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
--    FROM [Tours]
--    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
--    WHERE [Tours].[StartDate] BETWEEN @StartDate AND @EndDate
--END

--CREATE PROCEDURE [ToursByCountry]
--    @Country NVARCHAR(50)
--AS
--BEGIN
--    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
--    FROM [Tours]
--    JOIN [TourCities] ON [Tours].[TourID] = [TourCities].[TourID]
--    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
--    WHERE [TourCities].[Country] = @Country
--END

--CREATE VIEW [MostPopularTourCountry] AS
--SELECT TOP 1 [TourCities].[Country], COUNT(*) AS [TourCount]
--FROM [TourCities]
--GROUP BY [TourCities].[Country]
--ORDER BY [TourCount] DESC;

--CREATE VIEW [MostPopularActualTour] AS
--SELECT TOP 1 [Tours].[TourID], [Tours].[TourName], COUNT(*) AS [PurchasedCount]
--FROM [Tours]
--JOIN [PastTours] ON [Tours].[TourID] = [PastTours].[TourID]
--GROUP BY [Tours].[TourID], [Tours].[TourName]
--ORDER BY [PurchasedCount] DESC;

--CREATE VIEW [MostPopularArchiveTour] AS
--SELECT TOP 1 [Tours].[TourID], [Tours].[TourName], COUNT(*) AS [PurchasedCount]
--FROM [Tours]
--JOIN [PastTours] ON [Tours].[TourID] = [PastTours].[TourID]
--WHERE [Tours].[EndDate] < GETDATE()
--GROUP BY [Tours].[TourID], [Tours].[TourName]
--ORDER BY [PurchasedCount] DESC;

--CREATE VIEW [MostUnpopularNewsletter] AS
--SELECT TOP 1 [Tourists].[ContactEmail], COUNT(*) AS [PurchasedCount]
--FROM [Tourists]
--JOIN [PastTours] ON [Tourists].[TouristID] = [PastTours].[TouristID]
--GROUP BY [Tourists].[ContactEmail]
--ORDER BY [PurchasedCount] ASC;

CREATE PROCEDURE [dbo].[TouristTrips]
    @TouristName NVARCHAR(100)
AS
BEGIN
    SELECT [Tourists].[FullName], [Tours].[TourName], [TourCities].[City], [TourCities].[Country], [TourCities].[VisitDate]
    FROM [Tourists]
    JOIN [PastTours] ON [Tourists].[TouristID] = [PastTours].[TouristID]
    JOIN [Tours] ON [PastTours].[TourID] = [Tours].[TourID]
    JOIN [TourCities] ON [Tours].[TourID] = [TourCities].[TourID]
    WHERE [Tourists].[FullName] = @TouristName
END

--CREATE TRIGGER [MaxTouristsCheck] ON [PastTours]
--FOR INSERT
--AS
--BEGIN
--    DECLARE @TourID INT
--    DECLARE @TouristCount INT
--    DECLARE @MaxTourists INT

--    SELECT @TourID =INSERTED.TourID FROM INSERTED

--    SELECT @TouristCount = COUNT(*) FROM INSERTED WHERE TourID = @TourID

--    SELECT @MaxTourists = MaxTourists FROM Tours WHERE TourID = @TourID

--    IF (@TouristCount > @MaxTourists)
--    BEGIN
--        RAISERROR('Maximum number of tourists exceeded for this tour!', 16, 1)
--        ROLLBACK TRANSACTION
--    END
--END

--CREATE FUNCTION [CalculateAge]
--    (@DOB DATE)
--RETURNS INT
--BEGIN
--    DECLARE @Age INT
--    SELECT @Age = DATEDIFF(YEAR, @DOB, GETDATE())
--    IF (MONTH(@DOB) > MONTH(GETDATE()) OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE())))
--    BEGIN
--        SELECT @Age = @Age - 1
--    END
--    RETURN @Age
--END
GO
/****** Object:  StoredProcedure [dbo].[ToursByCountry]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE VIEW [CurrentTours] AS
--SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
--FROM [Tours]
--JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
--WHERE [Tours].[EndDate] >= GETDATE();

--CREATE PROCEDURE [ToursByDateRange] 
--    @StartDate DATE,
--    @EndDate DATE
--AS
--BEGIN
--    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
--    FROM [Tours]
--    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
--    WHERE [Tours].[StartDate] BETWEEN @StartDate AND @EndDate
--END

CREATE PROCEDURE [dbo].[ToursByCountry]
    @Country NVARCHAR(50)
AS
BEGIN
    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
    FROM [Tours]
    JOIN [TourCities] ON [Tours].[TourID] = [TourCities].[TourID]
    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
    WHERE [TourCities].[Country] = @Country
END
GO
/****** Object:  StoredProcedure [dbo].[ToursByDateRange]    Script Date: 03.01.2024 16:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*CREATE VIEW [CurrentTours] AS
SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
FROM [Tours]
JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
WHERE [Tours].[EndDate] >= GETDATE();*/

CREATE PROCEDURE [dbo].[ToursByDateRange] 
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT [Tours].[TourID], [Tours].[TourName], [Tours].[Price], [Tours].[StartDate], [Tours].[EndDate], [Tours].[TravelModes], [Tours].[MaxTourists], [Employees].[FullName] AS [EmployeeName]
    FROM [Tours]
    JOIN [Employees] ON [Tours].[EmployeeID] = [Employees].[EmployeeID]
    WHERE [Tours].[StartDate] BETWEEN @StartDate AND @EndDate
END
GO
USE [master]
GO
ALTER DATABASE [AroundTheWorldIn80Days] SET  READ_WRITE 
GO
