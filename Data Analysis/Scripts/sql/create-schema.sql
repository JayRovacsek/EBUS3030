USE [master]
GO
/****** Object:  Database [EBUS3030]    Script Date: 26/08/2018 4:11:38 PM ******/
CREATE DATABASE [EBUS3030]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EBUS3030', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\EBUS3030.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EBUS3030_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\EBUS3030_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [EBUS3030] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EBUS3030].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EBUS3030] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EBUS3030] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EBUS3030] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EBUS3030] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EBUS3030] SET ARITHABORT OFF 
GO
ALTER DATABASE [EBUS3030] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EBUS3030] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EBUS3030] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EBUS3030] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EBUS3030] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EBUS3030] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EBUS3030] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EBUS3030] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EBUS3030] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EBUS3030] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EBUS3030] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EBUS3030] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EBUS3030] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EBUS3030] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EBUS3030] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EBUS3030] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EBUS3030] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EBUS3030] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EBUS3030] SET  MULTI_USER 
GO
ALTER DATABASE [EBUS3030] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EBUS3030] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EBUS3030] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EBUS3030] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EBUS3030] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [EBUS3030] SET QUERY_STORE = OFF
GO
USE [EBUS3030]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [EBUS3030]
GO
/****** Object:  Table [dbo].[Assignment1Data]    Script Date: 26/08/2018 4:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assignment1Data](
	[Sale_Date] [datetime2](7) NOT NULL,
	[Reciept_Id] [int] NOT NULL,
	[Customer_ID] [nvarchar](50) NOT NULL,
	[Customer_First_Name] [nvarchar](50) NOT NULL,
	[Customer_Surname] [nvarchar](50) NOT NULL,
	[Staff_ID] [nvarchar](50) NOT NULL,
	[Staff_First_Name] [nvarchar](50) NOT NULL,
	[Staff_Surname] [nvarchar](50) NOT NULL,
	[Staff_office] [int] NOT NULL,
	[Office_Location] [nvarchar](50) NOT NULL,
	[Reciept_Transaction_Row_ID] [int] NOT NULL,
	[Item_ID] [int] NOT NULL,
	[Item_Description] [nvarchar](50) NOT NULL,
	[Item_Quantity] [int] NOT NULL,
	[Item_Price] [float] NOT NULL,
	[Row_Total] [float] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 26/08/2018 4:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerId] [int] NOT NULL,
	[CustomerFirstName] [varchar](255) NOT NULL,
	[CustomerSurname] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Item]    Script Date: 26/08/2018 4:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Item](
	[ItemId] [int] NOT NULL,
	[ItemDescription] [varchar](255) NOT NULL,
	[ItemPrice] [decimal](19, 5) NOT NULL,
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Office]    Script Date: 26/08/2018 4:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Office](
	[OfficeId] [tinyint] NOT NULL,
	[OfficeLocation] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Office] PRIMARY KEY CLUSTERED 
(
	[OfficeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Receipt]    Script Date: 26/08/2018 4:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Receipt](
	[ReceiptId] [int] NOT NULL,
	[ReceiptCustomerId] [int] NOT NULL,
	[ReceiptStaffId] [varchar](4) NOT NULL,
 CONSTRAINT [PK_Receipt] PRIMARY KEY CLUSTERED 
(
	[ReceiptId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReceiptItem]    Script Date: 26/08/2018 4:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReceiptItem](
	[ReceiptId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[ReceiptItemQuantity] [smallint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 26/08/2018 4:11:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[StaffId] [varchar](4) NOT NULL,
	[StaffFirstName] [varchar](255) NOT NULL,
	[StaffSurname] [varchar](255) NOT NULL,
	[StaffOfficeId] [tinyint] NOT NULL,
 CONSTRAINT [PK_Staff] PRIMARY KEY CLUSTERED 
(
	[StaffId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Receipt]  WITH CHECK ADD  CONSTRAINT [FK_Receipt_Staff] FOREIGN KEY([ReceiptStaffId])
REFERENCES [dbo].[Staff] ([StaffId])
GO
ALTER TABLE [dbo].[Receipt] CHECK CONSTRAINT [FK_Receipt_Staff]
GO
ALTER TABLE [dbo].[Receipt]  WITH CHECK ADD  CONSTRAINT [FK_ReceiptCustomer] FOREIGN KEY([ReceiptCustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[Receipt] CHECK CONSTRAINT [FK_ReceiptCustomer]
GO
ALTER TABLE [dbo].[ReceiptItem]  WITH CHECK ADD  CONSTRAINT [FK_ReceiptId] FOREIGN KEY([ReceiptId])
REFERENCES [dbo].[Receipt] ([ReceiptId])
GO
ALTER TABLE [dbo].[ReceiptItem] CHECK CONSTRAINT [FK_ReceiptId]
GO
ALTER TABLE [dbo].[ReceiptItem]  WITH CHECK ADD  CONSTRAINT [FK_ReceiptItemId] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Item] ([ItemId])
GO
ALTER TABLE [dbo].[ReceiptItem] CHECK CONSTRAINT [FK_ReceiptItemId]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_StaffOffice] FOREIGN KEY([StaffOfficeId])
REFERENCES [dbo].[Office] ([OfficeId])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK_StaffOffice]
GO
USE [master]
GO
ALTER DATABASE [EBUS3030] SET  READ_WRITE 
GO
