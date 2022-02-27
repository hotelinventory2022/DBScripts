USE [master]
GO
/****** Object:  Database [Hotel_Inventory]    Script Date: 27-02-2022 13:49:07 ******/
CREATE DATABASE [Hotel_Inventory]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Hotel_Inventory', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Hotel_Inventory.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Hotel_Inventory_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Hotel_Inventory_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Hotel_Inventory] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Hotel_Inventory].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Hotel_Inventory] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Hotel_Inventory] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Hotel_Inventory] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Hotel_Inventory] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Hotel_Inventory] SET ARITHABORT OFF 
GO
ALTER DATABASE [Hotel_Inventory] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Hotel_Inventory] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Hotel_Inventory] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Hotel_Inventory] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Hotel_Inventory] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Hotel_Inventory] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Hotel_Inventory] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Hotel_Inventory] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Hotel_Inventory] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Hotel_Inventory] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Hotel_Inventory] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Hotel_Inventory] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Hotel_Inventory] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Hotel_Inventory] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Hotel_Inventory] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Hotel_Inventory] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Hotel_Inventory] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Hotel_Inventory] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Hotel_Inventory] SET  MULTI_USER 
GO
ALTER DATABASE [Hotel_Inventory] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Hotel_Inventory] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Hotel_Inventory] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Hotel_Inventory] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Hotel_Inventory] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Hotel_Inventory] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Hotel_Inventory] SET QUERY_STORE = OFF
GO
USE [Hotel_Inventory]
GO
/****** Object:  Table [dbo].[LookUp]    Script Date: 27-02-2022 13:49:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LookUp](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LookupTypeId] [int] NULL,
	[LookupName] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastUpdatedBy] [int] NULL,
	[LastUpdatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LookUpType]    Script Date: 27-02-2022 13:49:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LookUpType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LookupTypeName] [nvarchar](100) NULL,
	[Description] [nvarchar](1000) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastUpdatedBy] [int] NULL,
	[LastUpdatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_LookupDetails]    Script Date: 27-02-2022 13:49:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[vw_LookupDetails]
as
select lt.Id as LookupTypeId, lt.LookupTypeName as LookupType, l.Id as LookupId, l.LookupName as Lookup, l.Description as LookUpDescription
from LookUpType lt
join LookUp l on lt.Id = l.LookupTypeId
where lt.IsActive=1 and lt.IsDeleted=0 and l.IsActive=1 and l.IsDeleted=0
GO
/****** Object:  Table [dbo].[Address]    Script Date: 27-02-2022 13:49:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[Id] [bigint] NULL,
	[GoogleMapId] [int] NULL,
	[AddressLine1] [nvarchar](max) NULL,
	[AddressLine2] [nvarchar](max) NULL,
	[Pincode] [int] NULL,
	[PostOffice] [nvarchar](100) NULL,
	[Landmark] [nvarchar](max) NULL,
	[Country_State_City_Area_Ids] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastUpdatedBy] [int] NULL,
	[LastUpdatedOn] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Availibilty_Rate]    Script Date: 27-02-2022 13:49:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Availibilty_Rate](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RoomId] [int] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[IsFullDayRate] [bit] NULL,
	[Duration_hrs] [int] NULL,
	[No_Of_Guests] [int] NULL,
	[Tariff] [int] NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastUpdatedBy] [int] NULL,
	[LastUpdatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Booking]    Script Date: 27-02-2022 13:49:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RoomId] [int] NULL,
	[BookingType] [int] NULL,
	[Check_In_Date] [datetime] NULL,
	[Check_Out_Date] [datetime] NULL,
	[Check_In_Time] [nvarchar](10) NULL,
	[Check_Out_Time] [nvarchar](10) NULL,
	[No_Of_Guests] [int] NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastUpdatedBy] [int] NULL,
	[LastUpdatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Country_State_City_Area]    Script Date: 27-02-2022 13:49:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country_State_City_Area](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CountryId] [int] NULL,
	[CountryName] [nvarchar](max) NULL,
	[StateId] [int] NULL,
	[StateName] [nvarchar](max) NULL,
	[CityId] [int] NULL,
	[CityName] [nvarchar](max) NULL,
	[AreaId] [int] NULL,
	[AreaName] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastUpdatedBy] [int] NULL,
	[LastUpdatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GoogleMapDetails]    Script Date: 27-02-2022 13:49:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GoogleMapDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Latitude] [decimal](18, 0) NULL,
	[Longitude] [decimal](18, 0) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastUpdatedBy] [int] NULL,
	[LastUpdatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GuestBookingMapping]    Script Date: 27-02-2022 13:49:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GuestBookingMapping](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[GuestId] [int] NULL,
	[BookingId] [bigint] NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastUpdatedBy] [int] NULL,
	[LastUpdatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Guests]    Script Date: 27-02-2022 13:49:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Guests](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Gender] [char](2) NULL,
	[Phone#] [nvarchar](20) NULL,
	[Email] [nvarchar](200) NULL,
	[DOB] [datetime] NULL,
	[IdType] [int] NULL,
	[IdUrl] [nvarchar](max) NULL,
	[IsIdProvided] [bit] NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastUpdatedBy] [int] NULL,
	[LastUpdatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 27-02-2022 13:49:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[BookingId] [bigint] NULL,
	[PaymentOptionId] [int] NULL,
	[PaymentStatusId] [int] NULL,
	[PaymentTypeId] [int] NULL,
	[PaymentRefNo] [nvarchar](50) NULL,
	[TransactionId] [nvarchar](50) NULL,
	[Discount] [decimal](18, 0) NULL,
	[DiscountCode] [nvarchar](20) NULL,
	[Amount_incl_tax] [nvarchar](10) NULL,
	[Amount_excl_tax] [nvarchar](10) NULL,
	[TaxSlabId] [int] NULL,
	[AdvanceAmount] [decimal](18, 0) NULL,
	[RemainingAmount] [decimal](18, 0) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastUpdatedBy] [int] NULL,
	[LastUpdatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Property]    Script Date: 27-02-2022 13:49:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Property](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NULL,
	[OwnerId] [int] NULL,
	[ContactPersonName] [nvarchar](50) NULL,
	[ContactEmail] [nvarchar](200) NULL,
	[ContactPhone#] [nvarchar](20) NULL,
	[PropertyType] [int] NULL,
	[PropertySubType] [int] NULL,
	[No_Of_Rooms] [int] NULL,
	[AddressId] [bigint] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[GoogleMapId] [int] NULL,
	[GSTInNo] [bigint] NULL,
	[IsTerms_ConditionAccepted] [bit] NULL,
	[PublishedOn] [datetime] NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastUpdatedBy] [int] NULL,
	[LastUpdatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PropertyFacilityMapping]    Script Date: 27-02-2022 13:49:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropertyFacilityMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PropertyId] [int] NULL,
	[FaciltiyId] [int] NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastUpdatedBy] [int] NULL,
	[LastUpdatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PropertyImageMapping]    Script Date: 27-02-2022 13:49:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropertyImageMapping](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[PropertyId] [int] NULL,
	[RoomId] [int] NULL,
	[ImageUrl] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastUpdatedBy] [int] NULL,
	[LastUpdatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PropertyPolicyMapping]    Script Date: 27-02-2022 13:49:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropertyPolicyMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PropertyId] [int] NULL,
	[HouseRules] [nvarchar](max) NULL,
	[CancellationPolicy] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastUpdatedBy] [int] NULL,
	[LastUpdatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Refund]    Script Date: 27-02-2022 13:49:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Refund](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[PaymentId] [bigint] NULL,
	[RefundStatusId] [int] NULL,
	[RefundRefNo] [nvarchar](50) NULL,
	[RefundReasonId] [int] NULL,
	[TransactionId] [nvarchar](50) NULL,
	[Amount] [nvarchar](10) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastUpdatedBy] [int] NULL,
	[LastUpdatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 27-02-2022 13:49:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [nvarchar](1000) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastUpdatedBy] [int] NULL,
	[LastUpdatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoomFacilityMapping]    Script Date: 27-02-2022 13:49:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomFacilityMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoomId] [int] NULL,
	[FaciltiyId] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastUpdatedBy] [int] NULL,
	[LastUpdatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rooms]    Script Date: 27-02-2022 13:49:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rooms](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NULL,
	[PropertyId] [int] NULL,
	[RoomTypeId] [int] NULL,
	[RoomSubTypeId] [int] NULL,
	[RoomSize_sq_ft] [decimal](18, 0) NULL,
	[Check_In_Time] [nvarchar](10) NULL,
	[Check_Out_Time] [nvarchar](10) NULL,
	[IsSlotBookingEnabled] [bit] NULL,
	[Max_No_Of_Adults] [int] NULL,
	[Max_No_Of_Child] [int] NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastUpdatedBy] [int] NULL,
	[LastUpdatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoleMapping]    Script Date: 27-02-2022 13:49:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoleMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[RoleId] [int] NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastUpdatedBy] [int] NULL,
	[LastUpdatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 27-02-2022 13:49:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Gender] [char](2) NULL,
	[Phone#] [nvarchar](20) NULL,
	[Email] [nvarchar](200) NULL,
	[DOB] [datetime] NULL,
	[IsEmailVerified] [bit] NULL,
	[IsPhoneVerified] [bit] NULL,
	[IsSubscribedForNewsletter] [bit] NULL,
	[IsSubscribedForPpromotion] [bit] NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastUpdatedBy] [int] NULL,
	[LastUpdatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[LookUp] ON 

INSERT [dbo].[LookUp] ([Id], [LookupTypeId], [LookupName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (1, 1, N'Voter Card', N'Voter Card', 1, 0, 1, CAST(N'2022-02-27T13:40:20.830' AS DateTime), 1, CAST(N'2022-02-27T13:40:20.830' AS DateTime))
INSERT [dbo].[LookUp] ([Id], [LookupTypeId], [LookupName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (2, 1, N'Aadhar Card', N'Aadhar Card', 1, 0, 1, CAST(N'2022-02-27T13:40:20.830' AS DateTime), 1, CAST(N'2022-02-27T13:40:20.830' AS DateTime))
INSERT [dbo].[LookUp] ([Id], [LookupTypeId], [LookupName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (3, 1, N'Passport', N'Passport', 1, 0, 1, CAST(N'2022-02-27T13:40:20.830' AS DateTime), 1, CAST(N'2022-02-27T13:40:20.830' AS DateTime))
INSERT [dbo].[LookUp] ([Id], [LookupTypeId], [LookupName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (4, 1, N'Driving License', N'Driving License', 1, 0, 1, CAST(N'2022-02-27T13:40:20.830' AS DateTime), 1, CAST(N'2022-02-27T13:40:20.830' AS DateTime))
INSERT [dbo].[LookUp] ([Id], [LookupTypeId], [LookupName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (5, 2, N'House Rental', N'House for Rent, preferable longer stays', 1, 0, 1, CAST(N'2022-02-27T13:44:13.220' AS DateTime), 1, CAST(N'2022-02-27T13:44:13.220' AS DateTime))
INSERT [dbo].[LookUp] ([Id], [LookupTypeId], [LookupName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (6, 2, N'Apartment', N'Entire Apartments', 1, 0, 1, CAST(N'2022-02-27T13:44:13.220' AS DateTime), 1, CAST(N'2022-02-27T13:44:13.220' AS DateTime))
INSERT [dbo].[LookUp] ([Id], [LookupTypeId], [LookupName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (7, 2, N'BnB', N'Bed and Breakfast', 1, 0, 1, CAST(N'2022-02-27T13:44:13.220' AS DateTime), 1, CAST(N'2022-02-27T13:44:13.220' AS DateTime))
INSERT [dbo].[LookUp] ([Id], [LookupTypeId], [LookupName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (8, 2, N'Hotel', N'Hotel', 1, 0, 1, CAST(N'2022-02-27T13:44:13.220' AS DateTime), 1, CAST(N'2022-02-27T13:44:13.220' AS DateTime))
INSERT [dbo].[LookUp] ([Id], [LookupTypeId], [LookupName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (9, 2, N'Homestay', N'Homestay', 1, 0, 1, CAST(N'2022-02-27T13:44:13.220' AS DateTime), 1, CAST(N'2022-02-27T13:44:13.220' AS DateTime))
INSERT [dbo].[LookUp] ([Id], [LookupTypeId], [LookupName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (10, 2, N'Lodge', N'Lodge', 1, 0, 1, CAST(N'2022-02-27T13:44:13.220' AS DateTime), 1, CAST(N'2022-02-27T13:44:13.220' AS DateTime))
INSERT [dbo].[LookUp] ([Id], [LookupTypeId], [LookupName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (11, 7, N'RazorPay', N'Online payment using RazorPay', 1, 0, 1, CAST(N'2022-02-27T13:45:23.383' AS DateTime), 1, CAST(N'2022-02-27T13:45:23.383' AS DateTime))
INSERT [dbo].[LookUp] ([Id], [LookupTypeId], [LookupName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (12, 7, N'Cash', N'Pay at Property using cash', 1, 0, 1, CAST(N'2022-02-27T13:45:23.383' AS DateTime), 1, CAST(N'2022-02-27T13:45:23.383' AS DateTime))
INSERT [dbo].[LookUp] ([Id], [LookupTypeId], [LookupName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (13, 6, N'Full', N'Full payment via website', 1, 0, 1, CAST(N'2022-02-27T13:46:56.810' AS DateTime), 1, CAST(N'2022-02-27T13:46:56.810' AS DateTime))
INSERT [dbo].[LookUp] ([Id], [LookupTypeId], [LookupName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (14, 6, N'PayAtProperty', N'Pay at Property', 1, 0, 1, CAST(N'2022-02-27T13:46:56.810' AS DateTime), 1, CAST(N'2022-02-27T13:46:56.810' AS DateTime))
INSERT [dbo].[LookUp] ([Id], [LookupTypeId], [LookupName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (15, 6, N'Advance', N'Advance payment via website', 1, 0, 1, CAST(N'2022-02-27T13:46:56.810' AS DateTime), 1, CAST(N'2022-02-27T13:46:56.810' AS DateTime))
INSERT [dbo].[LookUp] ([Id], [LookupTypeId], [LookupName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (16, 13, N'FullDay', N'24 hrs booking', 1, 0, 1, CAST(N'2022-02-27T13:48:08.123' AS DateTime), 1, CAST(N'2022-02-27T13:48:08.123' AS DateTime))
INSERT [dbo].[LookUp] ([Id], [LookupTypeId], [LookupName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (17, 13, N'Slot', N'Slot booking as per convenience', 1, 0, 1, CAST(N'2022-02-27T13:48:08.123' AS DateTime), 1, CAST(N'2022-02-27T13:48:08.123' AS DateTime))
SET IDENTITY_INSERT [dbo].[LookUp] OFF
GO
SET IDENTITY_INSERT [dbo].[LookUpType] ON 

INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (1, N'IdentityProof', N'Identity Proofs for Guests', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime))
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (2, N'PropertyType', N'Property Types', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime))
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (3, N'PropertySubType', N'Property Sub Types', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime))
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (4, N'RoomType', N'Room Types', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime))
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (5, N'RoomSubType', N'Room Sub Types', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime))
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (6, N'PaymentType', N'Payment Types', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime))
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (7, N'PaymentOption', N'Payment Options', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime))
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (8, N'PaymentStatus', N'Payment Status', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime))
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (9, N'RefundStatus', N'Refund Status', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime))
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (10, N'RefundReason', N'Reason for Refund', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime))
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (11, N'PropertyFacilities', N'Facilities and Features and Amenities for Property', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime))
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (12, N'RoomFacilities', N'Facilities and Features and Amenities for Room', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime))
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (13, N'BookingType', N'Booking Types', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime))
SET IDENTITY_INSERT [dbo].[LookUpType] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([Id], [Name], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (1, N'Admin', N'System Administrators', 1, 0, 1, CAST(N'2022-02-25T00:09:06.010' AS DateTime), 1, CAST(N'2022-02-25T00:09:06.010' AS DateTime))
INSERT [dbo].[Roles] ([Id], [Name], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (2, N'User', N'End users', 1, 0, 1, CAST(N'2022-02-22T01:10:31.627' AS DateTime), 1, CAST(N'2022-02-22T01:10:31.627' AS DateTime))
INSERT [dbo].[Roles] ([Id], [Name], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (3, N'Owner', N'Property owners', 1, 0, 1, CAST(N'2022-02-22T01:10:31.627' AS DateTime), 1, CAST(N'2022-02-22T01:10:31.627' AS DateTime))
INSERT [dbo].[Roles] ([Id], [Name], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (4, N'Agent', N'Users doing booking for commision', 1, 0, 1, CAST(N'2022-02-22T01:10:31.627' AS DateTime), 1, CAST(N'2022-02-22T01:10:31.627' AS DateTime))
INSERT [dbo].[Roles] ([Id], [Name], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (5, N'Delegate', N'Owners delegating booking to other properties', 1, 0, 1, CAST(N'2022-02-22T01:10:31.627' AS DateTime), 1, CAST(N'2022-02-22T01:10:31.627' AS DateTime))
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRoleMapping] ON 

INSERT [dbo].[UserRoleMapping] ([Id], [UserId], [RoleId], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (1, 1, 1, 1, 0, 1, CAST(N'2022-02-22T01:12:02.853' AS DateTime), 1, CAST(N'2022-02-22T01:12:02.853' AS DateTime))
SET IDENTITY_INSERT [dbo].[UserRoleMapping] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [Name], [Gender], [Phone#], [Email], [DOB], [IsEmailVerified], [IsPhoneVerified], [IsSubscribedForNewsletter], [IsSubscribedForPpromotion], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (1, N'System', N'NA', N'918272909096', N'hotelinventory2022@gmail.com', CAST(N'2022-02-22T01:04:59.590' AS DateTime), 1, 1, 0, 0, 1, 0, 1, CAST(N'2022-02-22T01:04:59.590' AS DateTime), 1, CAST(N'2022-02-22T01:04:59.590' AS DateTime))
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
USE [master]
GO
ALTER DATABASE [Hotel_Inventory] SET  READ_WRITE 
GO
