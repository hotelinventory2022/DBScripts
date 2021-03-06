USE [master]
GO
/****** Object:  Database [Hotel_Inventory]    Script Date: 14-03-2022 01:55:50 ******/
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
/****** Object:  Table [dbo].[LookUp]    Script Date: 14-03-2022 01:55:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LookUp](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LookupTypeId] [int] NOT NULL,
	[LookupName] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastUpdatedBy] [int] NOT NULL,
	[LastUpdatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK__LookUp__3214EC07C22BA4A6] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LookUpType]    Script Date: 14-03-2022 01:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LookUpType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LookupTypeName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](1000) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastUpdatedBy] [int] NOT NULL,
	[LastUpdatedOn] [datetime] NOT NULL,
	[LookupTypeParentId] [int] NULL,
 CONSTRAINT [PK__LookUpTy__3214EC078C111FDE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_LookupDetails]    Script Date: 14-03-2022 01:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vw_LookupDetails]
as
select lt.LookupTypeParentId, lpt.LookupTypeName as LookupTypeParentName, lt.Id as LookupTypeId, lt.LookupTypeName as LookupType, l.Id as LookupId, l.LookupName as Lookup, l.Description as LookUpDescription
from LookUpType lt
join LookUp l on lt.Id = l.LookupTypeId
left join LookUpType lpt on lt.LookupTypeParentId = lpt.Id
where lt.IsActive=1 and lt.IsDeleted=0 and l.IsActive=1 and l.IsDeleted=0
GO
/****** Object:  Table [dbo].[Address]    Script Date: 14-03-2022 01:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[GoogleMapId] [bigint] NOT NULL,
	[AddressLine1] [nvarchar](max) NOT NULL,
	[AddressLine2] [nvarchar](max) NULL,
	[Pincode] [int] NOT NULL,
	[PostOffice] [nvarchar](100) NULL,
	[Landmark] [nvarchar](max) NULL,
	[Country_State_City_Area_Ids] [nvarchar](max) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastUpdatedBy] [int] NOT NULL,
	[LastUpdatedOn] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Availibilty_Rate]    Script Date: 14-03-2022 01:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Availibilty_Rate](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RoomId] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[IsFullDayRate] [bit] NOT NULL,
	[Duration_hrs] [int] NULL,
	[No_Of_Guests] [int] NOT NULL,
	[Tariff] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastUpdatedBy] [int] NOT NULL,
	[LastUpdatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK__Availibi__3214EC071D07126E] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Booking]    Script Date: 14-03-2022 01:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RoomId] [int] NOT NULL,
	[BookingType] [int] NOT NULL,
	[Check_In_Date] [datetime] NOT NULL,
	[Check_Out_Date] [datetime] NOT NULL,
	[Check_In_Time] [nvarchar](10) NOT NULL,
	[Check_Out_Time] [nvarchar](10) NOT NULL,
	[No_Of_Guests] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastUpdatedBy] [int] NOT NULL,
	[LastUpdatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK__Booking__3214EC07371DB947] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Country_State_City_Area]    Script Date: 14-03-2022 01:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country_State_City_Area](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CountryId] [int] NOT NULL,
	[CountryName] [nvarchar](max) NOT NULL,
	[StateId] [int] NOT NULL,
	[StateName] [nvarchar](max) NOT NULL,
	[CityId] [int] NOT NULL,
	[CityName] [nvarchar](max) NOT NULL,
	[AreaId] [int] NOT NULL,
	[AreaName] [nvarchar](max) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastUpdatedBy] [int] NOT NULL,
	[LastUpdatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK__Country___3214EC07771AD319] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GoogleMapDetails]    Script Date: 14-03-2022 01:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GoogleMapDetails](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Latitude] [decimal](18, 0) NOT NULL,
	[Longitude] [decimal](18, 0) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastUpdatedBy] [int] NOT NULL,
	[LastUpdatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK__GoogleMa__3214EC07FDFA5DB7] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GuestBookingMapping]    Script Date: 14-03-2022 01:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GuestBookingMapping](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[GuestId] [int] NOT NULL,
	[BookingId] [bigint] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastUpdatedBy] [int] NOT NULL,
	[LastUpdatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK__GuestBoo__3214EC07A30240AB] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Guests]    Script Date: 14-03-2022 01:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Guests](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Gender] [char](2) NOT NULL,
	[Phone#] [nvarchar](20) NULL,
	[Email] [nvarchar](200) NOT NULL,
	[DOB] [datetime] NOT NULL,
	[IdType] [int] NULL,
	[IdUrl] [nvarchar](max) NULL,
	[IsIdProvided] [bit] NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastUpdatedBy] [int] NOT NULL,
	[LastUpdatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK__Guests__3214EC07B1A1B604] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 14-03-2022 01:55:51 ******/
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
/****** Object:  Table [dbo].[Property]    Script Date: 14-03-2022 01:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Property](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[OwnerId] [int] NOT NULL,
	[ContactPersonName] [nvarchar](50) NOT NULL,
	[ContactEmail] [nvarchar](200) NOT NULL,
	[ContactPhoneNo] [nvarchar](20) NOT NULL,
	[ContactAlternatePhoneNo] [nvarchar](20) NOT NULL,
	[PropertyTypeId] [int] NOT NULL,
	[PropertySubTypeId] [int] NULL,
	[No_Of_Rooms] [int] NOT NULL,
	[AddressId] [bigint] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Rating] [nvarchar](20) NOT NULL,
	[GSTInNo] [nvarchar](50) NULL,
	[IsTerms_ConditionAccepted] [bit] NOT NULL,
	[PublishedOn] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastUpdatedBy] [int] NOT NULL,
	[LastUpdatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK__Property__3214EC073F992BEC] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PropertyFacilityMapping]    Script Date: 14-03-2022 01:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropertyFacilityMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PropertyId] [int] NOT NULL,
	[FaciltiyId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastUpdatedBy] [int] NOT NULL,
	[LastUpdatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK__Property__3214EC07495FA394] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PropertyImageMapping]    Script Date: 14-03-2022 01:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropertyImageMapping](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[PropertyId] [int] NOT NULL,
	[RoomId] [int] NULL,
	[ImageUrl] [nvarchar](max) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastUpdatedBy] [int] NOT NULL,
	[LastUpdatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK__Property__3214EC076C395CAE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PropertyPolicyMapping]    Script Date: 14-03-2022 01:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropertyPolicyMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PropertyId] [int] NOT NULL,
	[HouseRules] [nvarchar](max) NOT NULL,
	[CancellationPolicy] [nvarchar](max) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastUpdatedBy] [int] NOT NULL,
	[LastUpdatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK__Property__3214EC072449D2AA] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Refund]    Script Date: 14-03-2022 01:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Refund](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[PaymentId] [bigint] NOT NULL,
	[RefundStatusId] [int] NOT NULL,
	[RefundRefNo] [nvarchar](50) NOT NULL,
	[RefundReasonId] [int] NOT NULL,
	[TransactionId] [nvarchar](50) NOT NULL,
	[Amount] [nvarchar](10) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastUpdatedBy] [int] NOT NULL,
	[LastUpdatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK__Refund__3214EC0799ED93F1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 14-03-2022 01:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](1000) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastUpdatedBy] [int] NOT NULL,
	[LastUpdatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK__Roles__3214EC0703C18B0B] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoomFacilityMapping]    Script Date: 14-03-2022 01:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomFacilityMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoomId] [int] NOT NULL,
	[FaciltiyId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastUpdatedBy] [int] NOT NULL,
	[LastUpdatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK__RoomFaci__3214EC07B86325E6] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rooms]    Script Date: 14-03-2022 01:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rooms](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[PropertyId] [int] NOT NULL,
	[RoomTypeId] [int] NOT NULL,
	[RoomSubTypeId] [int] NULL,
	[RoomSize] [nvarchar](20) NULL,
	[Check_In_Time] [nvarchar](10) NOT NULL,
	[Check_Out_Time] [nvarchar](10) NOT NULL,
	[IsSlotBookingEnabled] [bit] NOT NULL,
	[Max_No_Of_Adults] [int] NOT NULL,
	[Max_No_Of_Child] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastUpdatedBy] [int] NOT NULL,
	[LastUpdatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK__Rooms__3214EC07932DB31C] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoleMapping]    Script Date: 14-03-2022 01:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoleMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastUpdatedBy] [int] NOT NULL,
	[LastUpdatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK__UserRole__3214EC073FE3740A] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 14-03-2022 01:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Gender] [char](2) NOT NULL,
	[Phone] [nvarchar](20) NOT NULL,
	[Email] [nvarchar](200) NOT NULL,
	[Password] [nvarchar](15) NOT NULL,
	[DOB] [datetime] NULL,
	[IsEmailVerified] [bit] NULL,
	[IsPhoneVerified] [bit] NOT NULL,
	[IsSubscribedForNewsletter] [bit] NOT NULL,
	[IsSubscribedForPpromotion] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[LastUpdatedBy] [int] NOT NULL,
	[LastUpdatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK__Users__3214EC0786096506] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Address] ON 

INSERT [dbo].[Address] ([Id], [GoogleMapId], [AddressLine1], [AddressLine2], [Pincode], [PostOffice], [Landmark], [Country_State_City_Area_Ids], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (1, 2, N'd/5 sahapur', N'sitala road', 700038, N'New ALipur PO', N'Triangular park', N'50;51', 1, 0, 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime), 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime))
SET IDENTITY_INSERT [dbo].[Address] OFF
GO
SET IDENTITY_INSERT [dbo].[GoogleMapDetails] ON 

INSERT [dbo].[GoogleMapDetails] ([Id], [Latitude], [Longitude], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (1, CAST(23 AS Decimal(18, 0)), CAST(88 AS Decimal(18, 0)), 1, 0, 2, CAST(N'2022-03-08T00:23:53.830' AS DateTime), 2, CAST(N'2022-03-08T00:23:53.830' AS DateTime))
INSERT [dbo].[GoogleMapDetails] ([Id], [Latitude], [Longitude], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (2, CAST(23 AS Decimal(18, 0)), CAST(88 AS Decimal(18, 0)), 1, 0, 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime), 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime))
INSERT [dbo].[GoogleMapDetails] ([Id], [Latitude], [Longitude], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (3, CAST(23 AS Decimal(18, 0)), CAST(88 AS Decimal(18, 0)), 1, 0, 2, CAST(N'2022-03-14T01:40:40.953' AS DateTime), 2, CAST(N'2022-03-14T01:40:40.953' AS DateTime))
INSERT [dbo].[GoogleMapDetails] ([Id], [Latitude], [Longitude], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (4, CAST(23 AS Decimal(18, 0)), CAST(88 AS Decimal(18, 0)), 1, 0, 2, CAST(N'2022-03-14T01:44:15.660' AS DateTime), 2, CAST(N'2022-03-14T01:44:15.660' AS DateTime))
INSERT [dbo].[GoogleMapDetails] ([Id], [Latitude], [Longitude], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (5, CAST(23 AS Decimal(18, 0)), CAST(88 AS Decimal(18, 0)), 1, 0, 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime), 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime))
SET IDENTITY_INSERT [dbo].[GoogleMapDetails] OFF
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

INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn], [LookupTypeParentId]) VALUES (1, N'IdentityProof', N'Identity Proofs for Guests', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), NULL)
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn], [LookupTypeParentId]) VALUES (2, N'PropertyType', N'Property Types', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), NULL)
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn], [LookupTypeParentId]) VALUES (3, N'PropertySubType', N'Property Sub Types', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), NULL)
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn], [LookupTypeParentId]) VALUES (4, N'RoomType', N'Room Types', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), NULL)
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn], [LookupTypeParentId]) VALUES (5, N'RoomSubType', N'Room Sub Types', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), NULL)
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn], [LookupTypeParentId]) VALUES (6, N'PaymentType', N'Payment Types', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), NULL)
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn], [LookupTypeParentId]) VALUES (7, N'PaymentOption', N'Payment Options', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), NULL)
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn], [LookupTypeParentId]) VALUES (8, N'PaymentStatus', N'Payment Status', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), NULL)
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn], [LookupTypeParentId]) VALUES (9, N'RefundStatus', N'Refund Status', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), NULL)
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn], [LookupTypeParentId]) VALUES (10, N'RefundReason', N'Reason for Refund', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), NULL)
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn], [LookupTypeParentId]) VALUES (11, N'PropertyFacilities', N'Facilities and Features and Amenities for Property', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), NULL)
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn], [LookupTypeParentId]) VALUES (12, N'RoomFacilities', N'Facilities and Features and Amenities for Room', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), NULL)
INSERT [dbo].[LookUpType] ([Id], [LookupTypeName], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn], [LookupTypeParentId]) VALUES (13, N'BookingType', N'Booking Types', 1, 0, 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), 1, CAST(N'2022-02-27T13:37:35.670' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[LookUpType] OFF
GO
SET IDENTITY_INSERT [dbo].[Property] ON 

INSERT [dbo].[Property] ([Id], [Name], [OwnerId], [ContactPersonName], [ContactEmail], [ContactPhoneNo], [ContactAlternatePhoneNo], [PropertyTypeId], [PropertySubTypeId], [No_Of_Rooms], [AddressId], [Description], [Rating], [GSTInNo], [IsTerms_ConditionAccepted], [PublishedOn], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (1, N'My First Property', 2, N'My Contact', N'test@test.com', N'1234567890', N'9876543210', 8, 18, 2, 1, N'My First Property Description', N'3 ***', N'', 1, CAST(N'2022-03-01T19:54:42.210' AS DateTime), 1, 0, 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime), 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime))
INSERT [dbo].[Property] ([Id], [Name], [OwnerId], [ContactPersonName], [ContactEmail], [ContactPhoneNo], [ContactAlternatePhoneNo], [PropertyTypeId], [PropertySubTypeId], [No_Of_Rooms], [AddressId], [Description], [Rating], [GSTInNo], [IsTerms_ConditionAccepted], [PublishedOn], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (2, N'My First Property', 1, N'My Contact', N'test@test.com', N'1234567890', N'9876543210', 8, 18, 2, 1, N'My First Property Description', N'3 ***', N'', 1, CAST(N'2022-03-01T19:54:42.210' AS DateTime), 1, 0, 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime), 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime))
SET IDENTITY_INSERT [dbo].[Property] OFF
GO
SET IDENTITY_INSERT [dbo].[PropertyFacilityMapping] ON 

INSERT [dbo].[PropertyFacilityMapping] ([Id], [PropertyId], [FaciltiyId], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (1, 1, 19, 1, 0, 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime), 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime))
INSERT [dbo].[PropertyFacilityMapping] ([Id], [PropertyId], [FaciltiyId], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (2, 1, 20, 1, 0, 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime), 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime))
INSERT [dbo].[PropertyFacilityMapping] ([Id], [PropertyId], [FaciltiyId], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (3, 2, 19, 1, 0, 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime), 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime))
INSERT [dbo].[PropertyFacilityMapping] ([Id], [PropertyId], [FaciltiyId], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (4, 2, 20, 1, 0, 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime), 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime))
SET IDENTITY_INSERT [dbo].[PropertyFacilityMapping] OFF
GO
SET IDENTITY_INSERT [dbo].[PropertyImageMapping] ON 

INSERT [dbo].[PropertyImageMapping] ([Id], [PropertyId], [RoomId], [ImageUrl], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (1, 1, 0, N'https://www.google.com', 1, 0, 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime), 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime))
INSERT [dbo].[PropertyImageMapping] ([Id], [PropertyId], [RoomId], [ImageUrl], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (2, 1, 1, N'https://www.google.com', 1, 0, 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime), 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime))
INSERT [dbo].[PropertyImageMapping] ([Id], [PropertyId], [RoomId], [ImageUrl], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (3, 1, 2, N'https://www.google.com', 1, 0, 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime), 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime))
INSERT [dbo].[PropertyImageMapping] ([Id], [PropertyId], [RoomId], [ImageUrl], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (4, 2, 0, N'https://www.google.com', 1, 0, 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime), 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime))
INSERT [dbo].[PropertyImageMapping] ([Id], [PropertyId], [RoomId], [ImageUrl], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (5, 2, 3, N'https://www.google.com', 1, 0, 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime), 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime))
INSERT [dbo].[PropertyImageMapping] ([Id], [PropertyId], [RoomId], [ImageUrl], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (6, 2, 4, N'https://www.google.com', 1, 0, 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime), 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime))
SET IDENTITY_INSERT [dbo].[PropertyImageMapping] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([Id], [Name], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (1, N'Admin', N'System Administrators', 1, 0, 1, CAST(N'2022-02-25T00:09:06.010' AS DateTime), 1, CAST(N'2022-02-25T00:09:06.010' AS DateTime))
INSERT [dbo].[Roles] ([Id], [Name], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (2, N'User', N'End users', 1, 0, 1, CAST(N'2022-02-22T01:10:31.627' AS DateTime), 1, CAST(N'2022-02-22T01:10:31.627' AS DateTime))
INSERT [dbo].[Roles] ([Id], [Name], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (3, N'Owner', N'Property owners', 1, 0, 1, CAST(N'2022-02-22T01:10:31.627' AS DateTime), 1, CAST(N'2022-02-22T01:10:31.627' AS DateTime))
INSERT [dbo].[Roles] ([Id], [Name], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (4, N'Agent', N'Users doing booking for commision', 1, 0, 1, CAST(N'2022-02-22T01:10:31.627' AS DateTime), 1, CAST(N'2022-02-22T01:10:31.627' AS DateTime))
INSERT [dbo].[Roles] ([Id], [Name], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (5, N'Delegate', N'Owners delegating booking to other properties', 1, 0, 1, CAST(N'2022-02-22T01:10:31.627' AS DateTime), 1, CAST(N'2022-02-22T01:10:31.627' AS DateTime))
INSERT [dbo].[Roles] ([Id], [Name], [Description], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (6, N'new test role', N'new test role', 1, 1, 1, CAST(N'2022-03-01T19:09:40.983' AS DateTime), 1, CAST(N'2022-03-01T19:09:40.983' AS DateTime))
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[RoomFacilityMapping] ON 

INSERT [dbo].[RoomFacilityMapping] ([Id], [RoomId], [FaciltiyId], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (1, 1, 23, 1, 0, 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime), 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime))
INSERT [dbo].[RoomFacilityMapping] ([Id], [RoomId], [FaciltiyId], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (2, 1, 24, 1, 0, 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime), 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime))
INSERT [dbo].[RoomFacilityMapping] ([Id], [RoomId], [FaciltiyId], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (3, 2, 27, 1, 0, 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime), 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime))
INSERT [dbo].[RoomFacilityMapping] ([Id], [RoomId], [FaciltiyId], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (4, 2, 28, 1, 0, 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime), 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime))
INSERT [dbo].[RoomFacilityMapping] ([Id], [RoomId], [FaciltiyId], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (5, 3, 23, 1, 0, 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime), 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime))
INSERT [dbo].[RoomFacilityMapping] ([Id], [RoomId], [FaciltiyId], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (6, 3, 24, 1, 0, 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime), 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime))
INSERT [dbo].[RoomFacilityMapping] ([Id], [RoomId], [FaciltiyId], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (7, 4, 27, 1, 0, 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime), 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime))
INSERT [dbo].[RoomFacilityMapping] ([Id], [RoomId], [FaciltiyId], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (8, 4, 28, 1, 0, 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime), 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime))
SET IDENTITY_INSERT [dbo].[RoomFacilityMapping] OFF
GO
SET IDENTITY_INSERT [dbo].[Rooms] ON 

INSERT [dbo].[Rooms] ([Id], [Name], [PropertyId], [RoomTypeId], [RoomSubTypeId], [RoomSize], [Check_In_Time], [Check_Out_Time], [IsSlotBookingEnabled], [Max_No_Of_Adults], [Max_No_Of_Child], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (1, N'Delux Room', 1, 21, 22, N'100 sq ft', N'12:00 PM', N'11:00 AM', 0, 2, 1, 1, 0, 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime), 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime))
INSERT [dbo].[Rooms] ([Id], [Name], [PropertyId], [RoomTypeId], [RoomSubTypeId], [RoomSize], [Check_In_Time], [Check_Out_Time], [IsSlotBookingEnabled], [Max_No_Of_Adults], [Max_No_Of_Child], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (2, N'Double Room', 1, 25, 26, N'100 sq ft', N'12:00 PM', N'11:00 AM', 0, 2, 1, 1, 0, 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime), 2, CAST(N'2022-03-14T01:38:54.383' AS DateTime))
INSERT [dbo].[Rooms] ([Id], [Name], [PropertyId], [RoomTypeId], [RoomSubTypeId], [RoomSize], [Check_In_Time], [Check_Out_Time], [IsSlotBookingEnabled], [Max_No_Of_Adults], [Max_No_Of_Child], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (3, N'Delux Room', 2, 21, 22, N'100 sq ft', N'12:00 PM', N'11:00 AM', 0, 2, 1, 1, 0, 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime), 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime))
INSERT [dbo].[Rooms] ([Id], [Name], [PropertyId], [RoomTypeId], [RoomSubTypeId], [RoomSize], [Check_In_Time], [Check_Out_Time], [IsSlotBookingEnabled], [Max_No_Of_Adults], [Max_No_Of_Child], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (4, N'Double Room', 2, 25, 26, N'100 sq ft', N'12:00 PM', N'11:00 AM', 0, 2, 1, 1, 0, 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime), 2, CAST(N'2022-03-14T01:50:34.667' AS DateTime))
SET IDENTITY_INSERT [dbo].[Rooms] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRoleMapping] ON 

INSERT [dbo].[UserRoleMapping] ([Id], [UserId], [RoleId], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (1, 1, 1, 1, 0, 1, CAST(N'2022-02-22T01:12:02.853' AS DateTime), 1, CAST(N'2022-02-22T01:12:02.853' AS DateTime))
SET IDENTITY_INSERT [dbo].[UserRoleMapping] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [Name], [Gender], [Phone], [Email], [Password], [DOB], [IsEmailVerified], [IsPhoneVerified], [IsSubscribedForNewsletter], [IsSubscribedForPpromotion], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (1, N'System', N'NA', N'918272909096', N'hotelinventory2022@gmail.com', N'test', CAST(N'2022-02-22T01:04:59.590' AS DateTime), 1, 1, 0, 0, 1, 0, 1, CAST(N'2022-02-22T01:04:59.590' AS DateTime), 1, CAST(N'2022-02-22T01:04:59.590' AS DateTime))
INSERT [dbo].[Users] ([Id], [Name], [Gender], [Phone], [Email], [Password], [DOB], [IsEmailVerified], [IsPhoneVerified], [IsSubscribedForNewsletter], [IsSubscribedForPpromotion], [IsActive], [IsDeleted], [CreatedBy], [CreatedOn], [LastUpdatedBy], [LastUpdatedOn]) VALUES (2, N'new test', N'M ', N'1234567890', N'test@test.com', N'test pwd 1234', CAST(N'2022-02-28T20:45:31.453' AS DateTime), 1, 1, 1, 1, 1, 0, 1, CAST(N'2022-03-01T02:16:26.750' AS DateTime), 1, CAST(N'2022-03-01T02:16:26.750' AS DateTime))
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
USE [master]
GO
ALTER DATABASE [Hotel_Inventory] SET  READ_WRITE 
GO
