--Testing the GIT Change tracking

USE [master]
GO
/****** Object:  Database [PBI_ALM_WIP]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE DATABASE [PBI_ALM_WIP]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PBI_ALM', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.PBI_EXPRESS\MSSQL\DATA\PBI_ALM_WIP.mdf' , SIZE = 4691456KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PBI_ALM_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.PBI_EXPRESS\MSSQL\DATA\PBI_ALM_WIP_log.ldf' , SIZE = 1008000KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [PBI_ALM_WIP] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PBI_ALM_WIP].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PBI_ALM_WIP] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PBI_ALM_WIP] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PBI_ALM_WIP] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PBI_ALM_WIP] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PBI_ALM_WIP] SET ARITHABORT OFF 
GO
ALTER DATABASE [PBI_ALM_WIP] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PBI_ALM_WIP] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PBI_ALM_WIP] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PBI_ALM_WIP] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PBI_ALM_WIP] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PBI_ALM_WIP] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PBI_ALM_WIP] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PBI_ALM_WIP] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PBI_ALM_WIP] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PBI_ALM_WIP] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PBI_ALM_WIP] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PBI_ALM_WIP] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PBI_ALM_WIP] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PBI_ALM_WIP] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PBI_ALM_WIP] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PBI_ALM_WIP] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PBI_ALM_WIP] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PBI_ALM_WIP] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PBI_ALM_WIP] SET  MULTI_USER 
GO
ALTER DATABASE [PBI_ALM_WIP] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PBI_ALM_WIP] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PBI_ALM_WIP] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PBI_ALM_WIP] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [PBI_ALM_WIP] SET DELAYED_DURABILITY = DISABLED 
GO
USE [PBI_ALM_WIP]
GO
/****** Object:  User [PAC\justin.saw]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE USER [PAC\justin.saw] FOR LOGIN [PAC\justin.saw] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [PAC\charles.manty]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE USER [PAC\charles.manty] FOR LOGIN [PAC\charles.manty] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [PAC\justin.saw]
GO
ALTER ROLE [db_datareader] ADD MEMBER [PAC\justin.saw]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [PAC\justin.saw]
GO
ALTER ROLE [db_owner] ADD MEMBER [PAC\charles.manty]
GO
/****** Object:  Schema [tmp]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE SCHEMA [tmp]
GO
/****** Object:  Schema [trl]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE SCHEMA [trl]
GO
/****** Object:  UserDefinedFunction [dbo].[FV_Schedule]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019-01-24>
-- Description:	<Calculate the upliftment factor for variable interest rate future values>
-- =============================================
CREATE FUNCTION [dbo].[FV_Schedule](@t as int, @n as int, @AssumptionSetNo as int)

RETURNS float
AS
BEGIN
	
	declare @FV_Schedule as float

	;WITH calc_cte 
	as (
		SELECT AssumptionSetNo, (1 + ROUND(nvc.NC_FS_Change, 15)) One_Plus_Rate
		from  ALM_I_NC_FS_Change nvc
		WHERE t < @t and n = @n and AssumptionSetNo = @AssumptionSetNo
	)
	SELECT @FV_Schedule = 
		ISNULL(CASE
		   WHEN MinVal = 0 THEN 0
		   WHEN Neg % 2 = 1 THEN -1 * EXP(ABSMult)
		   ELSE EXP(ABSMult)
		END, 1)
	FROM
		(
		SELECT
		   AssumptionSetNo, 
		   --log of +ve row values
		   SUM(LOG(ABS(NULLIF(One_Plus_Rate, 0)))) AS ABSMult,
		   --count of -ve values. Even = +ve result.
		   SUM(SIGN(CASE WHEN One_Plus_Rate < 0 THEN 1 ELSE 0 END)) AS Neg,
		   --anything * zero = zero
		   MIN(ABS(One_Plus_Rate)) AS MinVal
		FROM
		   calc_cte 
		GROUP BY
		   AssumptionSetNo
		) foo

	return @FV_Schedule

	--select ISNULL(dbo.FV_Schedule(6, 2, 1),1)

END


GO
/****** Object:  UserDefinedFunction [dbo].[FV_Schedule_AlternativeMixes]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019-01-24>
-- Description:	<Calculate the upliftment factor for variable interest rate future values>
-- =============================================
CREATE FUNCTION [dbo].[FV_Schedule_AlternativeMixes](@t as int, @n as int, @ResultSetNo as int)

RETURNS float
AS
BEGIN
	
	declare @FV_Schedule as float

	;WITH calc_cte 
	as (
		SELECT ResultSetNo, (1 + ROUND(am.ProjectedReturns, 15)) One_Plus_Rate
		from  AlternativeMixes am
		WHERE t <= @t and n = @n and ResultSetNo = @ResultSetNo
	)
	SELECT @FV_Schedule = 
		ISNULL(CASE
		   WHEN MinVal = 0 THEN 0
		   WHEN Neg % 2 = 1 THEN -1 * EXP(ABSMult)
		   ELSE EXP(ABSMult)
		END, 1)
	FROM
		(
		SELECT
		   ResultSetNo, 
		   --log of +ve row values
		   SUM(LOG(ABS(NULLIF(One_Plus_Rate, 0)))) AS ABSMult,
		   --count of -ve values. Even = +ve result.
		   SUM(SIGN(CASE WHEN One_Plus_Rate < 0 THEN 1 ELSE 0 END)) AS Neg,
		   --anything * zero = zero
		   MIN(ABS(One_Plus_Rate)) AS MinVal
		FROM
		   calc_cte 
		GROUP BY
		   ResultSetNo
		) foo

	return @FV_Schedule

	--select ISNULL(dbo.FV_Schedule_AlternativeMixes(5, 1, 1),1)

END

--select am.*, ISNULL(dbo.FV_Schedule_AlternativeMixes(t, n, ResultSetNo),1)
--from AlternativeMixes am


GO
/****** Object:  UserDefinedFunction [dbo].[FV_Schedule_AssetClass]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019-01-24>
-- Description:	<Calculate the upliftment factor for variable interest rate future values>
-- =============================================
CREATE FUNCTION [dbo].[FV_Schedule_AssetClass](@t as int, @n as int, @AssetClass as varchar(255), @AssumptionSetNo as int)

RETURNS float
AS
BEGIN
	
	declare @FV_Schedule_AssetClass as float

	;WITH calc_cte 
	as (
		SELECT AssumptionSetNo, (1 + ROUND(am.Combined, 15)) One_Plus_Rate
		from  AssetClassReturn am
		WHERE t <= @t and n = @n and AssumptionSetNo = @AssumptionSetNo and am.[AssetClass] = @AssetClass
	)
	SELECT @FV_Schedule_AssetClass = 
		ISNULL(CASE
		   WHEN MinVal = 0 THEN 0
		   WHEN Neg % 2 = 1 THEN -1 * EXP(ABSMult)
		   ELSE EXP(ABSMult)
		END, 1)
	FROM
		(
		SELECT
		   AssumptionSetNo, 
		   --log of +ve row values
		   SUM(LOG(ABS(NULLIF(One_Plus_Rate, 0)))) AS ABSMult,
		   --count of -ve values. Even = +ve result.
		   SUM(SIGN(CASE WHEN One_Plus_Rate < 0 THEN 1 ELSE 0 END)) AS Neg,
		   --anything * zero = zero
		   MIN(ABS(One_Plus_Rate)) AS MinVal
		FROM
		   calc_cte 
		GROUP BY
		  AssumptionSetNo
		) foo

	return @FV_Schedule_AssetClass

	--select ISNULL(dbo.FV_Schedule_AssetClass(5, 1,'Universe Bonds', 1),1)

END
GO
/****** Object:  UserDefinedFunction [dbo].[FV_Schedule_Inflation]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019-01-24>
-- Description:	<Calculate the upliftment factor for variable interest rate future values>
-- =============================================
CREATE FUNCTION [dbo].[FV_Schedule_Inflation](@t as int, @n as int, @AssumptionSetNo as int)

RETURNS float
AS
BEGIN
	
	declare @FV_Schedule as float

	;WITH calc_cte 
	as (
		SELECT AssumptionSetNo, (1 + ROUND(inf.Inflation, 15)) One_Plus_Rate
		from  FI_I_Infl inf
		WHERE t < @t and n = @n and AssumptionSetNo = @AssumptionSetNo
	)
	SELECT @FV_Schedule = 
		ISNULL(CASE
		   WHEN MinVal = 0 THEN 0
		   WHEN Neg % 2 = 1 THEN -1 * EXP(ABSMult)
		   ELSE EXP(ABSMult)
		END, 1)
	FROM
		(
		SELECT
		   AssumptionSetNo, 
		   --log of +ve row values
		   SUM(LOG(ABS(NULLIF(One_Plus_Rate, 0)))) AS ABSMult,
		   --count of -ve values. Even = +ve result.
		   SUM(SIGN(CASE WHEN One_Plus_Rate < 0 THEN 1 ELSE 0 END)) AS Neg,
		   --anything * zero = zero
		   MIN(ABS(One_Plus_Rate)) AS MinVal
		FROM
		   calc_cte 
		GROUP BY
		   AssumptionSetNo
		) foo

	return @FV_Schedule

	--select ISNULL(dbo.FV_Schedule_Inflation(1, 1, 1),1)

END


GO
/****** Object:  UserDefinedFunction [dbo].[PV_Normal_Cost]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019-01-29>
-- Description:	<Calculate the upliftment factor for variable interest rate future values>
-- =============================================
CREATE FUNCTION [dbo].[PV_Normal_Cost](@t as int, @n as int, @ResultSetNo as int, @RateType as varchar(25), @CalcType as varchar(255) = 'CF')

RETURNS float
AS
BEGIN
	declare @PV_Normal_Cost as float

	/*
	declare @t as int = 5
	declare @n as int = 2
	declare @AssumptionSetNo as int = 1
	*/
	declare @AssumptionSetNo as int = (select AssumptionSetNo from ResultSet where ResultSetNo = @ResultSetNo)

	declare @j as int = 1
	declare @i as int = @t
	
	declare @CashFlowForYear table(n int, t int, cf_t int, Value float)

	declare @DiscountRate as float = (select DiscountRate from ALM_I_L_DiscountRate dr where t = @t and n = @n and RateType = @RateType and ResultSetNo = @ResultSetNo)
	
	If @CalcType = 'CF'
	Begin
		set @j = 2

		While @i > 0 
		Begin 
			;with FV_Schedule_CTE
			as (
				select n, t, AssumptionSetNo, FV_Schedule_NC_FS FV_Schedule
				from tmp.FV_Schedule_NC_FS dr 
				where t > 0 and t <= @t and n = @n and AssumptionSetNo = @AssumptionSetNo
			),
			work_cte
			as (
				select fv.n, fv.t, cf.t cf_t, cf.NormalCost, ISNULL(fv.FV_Schedule * cf.NormalCost, 0) Adjusted
				from FV_Schedule_CTE fv
				inner join ALM_I_L_CashFlow cf on 1 = 1
			) 
			insert into @CashFlowForYear (n, t, cf_t, Value)
			select @j, w.t, w.cf_t, Adjusted
			from work_cte w
			where cf_t = (@j + (@t - @i)) and t = @i
			order by w.cf_t, w.t
		
			set @i = @i - 1

		End
	End
	Else
	Begin
		While @j <= 120
		Begin

			While @i > 0 
			Begin 
				;with FV_Schedule_CTE
				as (
					select n, t, AssumptionSetNo, FV_Schedule_NC_FS FV_Schedule
					from tmp.FV_Schedule_NC_FS dr 
					where t > 0 and t <= @t and n = @n and AssumptionSetNo = @AssumptionSetNo
				),
				work_cte
				as (
					select fv.n, fv.t, cf.t cf_t, cf.NormalCost, ISNULL(fv.FV_Schedule * cf.NormalCost, 0) Adjusted
					from FV_Schedule_CTE fv
					inner join ALM_I_L_CashFlow cf on 1 = 1
				) 
				insert into @CashFlowForYear (n, t, cf_t, Value)
				select @j, w.t, w.cf_t, Adjusted
				from work_cte w
				where cf_t = (@j + (@t - @i)) and t = @i
				order by w.cf_t, w.t
		
				set @i = @i - 1

			End

			set @j = @j + 1
			set @i = @t
		End
	End
		
	set @PV_Normal_Cost = (
							select (CASE WHEN  @CalcType = 'CF' THEN SUM(sq.UndiscountedValue) ELSE SUM(sq.DiscountedValue) END)
							from (select SUM(Value) * POWER((1 + @DiscountRate), -n) DiscountedValue, SUM(Value) UndiscountedValue
								from @CashFlowForYear
								group by n) sq
							)

	return @PV_Normal_Cost

	--test
	--select [dbo].[PV_Normal_Cost](5, 2, 1,'GC','PV')

END
GO
/****** Object:  UserDefinedFunction [dbo].[PV_Normal_Cost_New]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019-01-29>
-- Description:	<Calculate the upliftment factor for variable interest rate future values>
-- =============================================
CREATE FUNCTION [dbo].[PV_Normal_Cost_New](@t as int, @n as int, @ResultSetNo as int, @RateType as varchar(25), @CalcType as varchar(255) = 'CF')

RETURNS float
AS
BEGIN
	declare @PV_Normal_Cost as float

	/*
	declare @t as int = 5
	declare @n as int = 2
	declare @AssumptionSetNo as int = 1
	*/
	declare @AssumptionSetNo as int = (select AssumptionSetNo from ResultSet where ResultSetNo = @ResultSetNo)

	--declare @j as int = 1
	--declare @i as int = @t
	
	declare @CashFlowForYear table(n int, t int, cf_t int, Value float)

	declare @DiscountRate as float = (select DiscountRate from ALM_I_L_DiscountRate dr where t = @t and n = @n and RateType = @RateType and ResultSetNo = @ResultSetNo)
	
	
	If @CalcType = 'CF'
	Begin

		insert into @CashFlowForYear (n, t, cf_t, Value)
		select j.N, w.t, w.cf_t, Adjusted
		from tmp.FV_Schedule_CF w
			inner join Tally i on i.N between 1 and @t
			inner join Tally j on j.N = 2
		where cf_t = (j.N + (@t - i.N)) and t = i.N
			and w.t <= @t and w.n = @n
	End
	Else
	Begin

		insert into @CashFlowForYear (n, t, cf_t, Value)
		select j.N, w.t, w.cf_t, Adjusted
		from tmp.FV_Schedule_CF w
			inner join Tally i on i.N between 1 and @t
			inner join Tally j on j.N between 1 and 120
		where cf_t = (j.N + (@t - i.N)) and t = i.N
			and w.t <= @t and w.n = @n
		order by w.cf_t, w.t

	End
		
	set @PV_Normal_Cost = (
							select (CASE WHEN  @CalcType = 'CF' THEN SUM(sq.UndiscountedValue) ELSE SUM(sq.DiscountedValue) END)
							from (select SUM(Value) * POWER((1 + @DiscountRate), -n) DiscountedValue, SUM(Value) UndiscountedValue
								from @CashFlowForYear
								group by n) sq
							)

	return @PV_Normal_Cost

	--test
	--select [dbo].[PV_Normal_Cost](5, 2, 1,'GC','PV')

END

GO
/****** Object:  Table [dbo].[ALM_I_COLA]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ALM_I_COLA](
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[COLA] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ALM_I_L_CashFlow]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALM_I_L_CashFlow](
	[Key] [int] IDENTITY(1,1) NOT NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[Accrued] [float] NOT NULL,
	[NormalCost] [float] NOT NULL,
	[FutureService] [float] NOT NULL,
	[Contributions] [float] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ALM_I_L_DiscountRate]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ALM_I_L_DiscountRate](
	[DRKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[DiscountRate] [float] NOT NULL,
	[ResultSetNo] [int] NULL,
	[RateType] [varchar](10) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ALM_I_NC_FS_Change]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ALM_I_NC_FS_Change](
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[NC_FS_Change] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ALM_R_A_ProjectedBenefitPayments]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALM_R_A_ProjectedBenefitPayments](
	[BPKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[BenefitPayment] [float] NULL,
	[ResultSetNo] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](4000) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ALM_R_A_ProjectedCashFlow]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ALM_R_A_ProjectedCashFlow](
	[CFKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[ExpectedCashFlow] [float] NULL,
	[ResultSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](255) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ALM_R_A_ProjectedContributions]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALM_R_A_ProjectedContributions](
	[PCKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Contributions] [float] NULL,
	[CumContributions] [float] NULL,
	[ResultSetNo] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](4000) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ALM_R_A_ProjectedMVA]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ALM_R_A_ProjectedMVA](
	[MVAKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[MVA] [float] NULL,
	[ResultSetNo] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](255) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ALM_R_FR_Volatility]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ALM_R_FR_Volatility](
	[SigmaFRKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[ResultSetNo] [int] NOT NULL,
	[ProjectedMVA] [float] NULL,
	[ProjectedLiability] [float] NULL,
	[ProjectedFundedRatio] [float] NULL,
	[DeltaFundedRatio] [float] NULL,
	[RateType] [varchar](255) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](255) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ALM_R_L_ProjectedLiability]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ALM_R_L_ProjectedLiability](
	[PLKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[ResultSetNo] [int] NOT NULL,
	[AccruedLiability] [float] NULL,
	[NormalCosts] [float] NULL,
	[ServiceCosts] [float] NULL,
	[RateType] [varchar](255) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](255) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ALM_Salary_Increase]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ALM_Salary_Increase](
	[SalaryIncreaseKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Inflation] [float] NOT NULL,
	[Salary_Increase] [float] NOT NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AlternativeMixes]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AlternativeMixes](
	[AMKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[ProjectedReturns] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[ResultSetNo] [int] NULL,
	[MixName] [varchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AssetClassReturn]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AssetClassReturn](
	[AssetClassReturnKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[AssetClass] [varchar](100) NOT NULL,
	[AssetGroup] [varchar](100) NOT NULL,
	[Cumulative] [float] NULL,
	[CumulativeAnnualized] [float] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AssumptionSet]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AssumptionSet](
	[AssumptionSetKey] [int] IDENTITY(1,1) NOT NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[AssumptionSetDescript] [varchar](255) NOT NULL,
	[CreatedDate] [date] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dmRefCodes]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dmRefCodes](
	[RefDomain] [varchar](100) NOT NULL,
	[RefCd] [varchar](30) NOT NULL,
	[RefDescript] [varchar](200) NOT NULL,
	[RefGroup] [varchar](50) NULL,
	[RefSeq] [int] NULL,
 CONSTRAINT [PK_dmRefCodes] PRIMARY KEY CLUSTERED 
(
	[RefDomain] ASC,
	[RefCd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FI_AC_BorrowCst]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FI_AC_BorrowCst](
	[BorrowCstKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FI_AC_Corp]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FI_AC_Corp](
	[CorpKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FI_AC_Float]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FI_AC_Float](
	[FloatKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FI_AC_LTBond]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FI_AC_LTBond](
	[LTBondKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FI_AC_Mort]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FI_AC_Mort](
	[MortKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FI_AC_PrDebt]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FI_AC_PrDebt](
	[PrDebtKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FI_AC_STCr]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FI_AC_STCr](
	[STCrKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FI_AC_UBond]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FI_AC_UBond](
	[UBondKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FI_I_CreditSpread]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FI_I_CreditSpread](
	[CreditSpreadKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[CreditSpread] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FI_I_Infl]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FI_I_Infl](
	[InflKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Inflation] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FI_I_LongTermReturn]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FI_I_LongTermReturn](
	[LTReturnKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[LT] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FI_I_RealReturn]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FI_I_RealReturn](
	[RealReturnKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[RealReturn] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FI_I_ShortTermReturn]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FI_I_ShortTermReturn](
	[STReturnKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[ST] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FI_I_TermPremium]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FI_I_TermPremium](
	[TermPremiumKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[TermPremium] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FI_R_CredPrem]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FI_R_CredPrem](
	[n] [int] NOT NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[1] [float] NOT NULL,
	[2] [float] NOT NULL,
	[3] [float] NOT NULL,
	[4] [float] NOT NULL,
	[5] [float] NOT NULL,
	[6] [float] NOT NULL,
	[7] [float] NOT NULL,
	[8] [float] NOT NULL,
	[9] [float] NOT NULL,
	[10] [float] NOT NULL,
	[11] [float] NOT NULL,
	[12] [float] NOT NULL,
	[13] [float] NOT NULL,
	[14] [float] NOT NULL,
	[15] [float] NOT NULL,
	[16] [float] NOT NULL,
	[17] [float] NOT NULL,
	[18] [float] NOT NULL,
	[19] [float] NOT NULL,
	[20] [float] NOT NULL,
	[21] [float] NOT NULL,
	[22] [float] NOT NULL,
	[23] [float] NOT NULL,
	[24] [float] NOT NULL,
	[25] [float] NOT NULL,
	[26] [float] NOT NULL,
	[27] [float] NOT NULL,
	[28] [float] NOT NULL,
	[29] [float] NOT NULL,
	[30] [float] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FI_R_Infl]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FI_R_Infl](
	[n] [int] NOT NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[1] [float] NOT NULL,
	[2] [float] NOT NULL,
	[3] [float] NOT NULL,
	[4] [float] NOT NULL,
	[5] [float] NOT NULL,
	[6] [float] NOT NULL,
	[7] [float] NOT NULL,
	[8] [float] NOT NULL,
	[9] [float] NOT NULL,
	[10] [float] NOT NULL,
	[11] [float] NOT NULL,
	[12] [float] NOT NULL,
	[13] [float] NOT NULL,
	[14] [float] NOT NULL,
	[15] [float] NOT NULL,
	[16] [float] NOT NULL,
	[17] [float] NOT NULL,
	[18] [float] NOT NULL,
	[19] [float] NOT NULL,
	[20] [float] NOT NULL,
	[21] [float] NOT NULL,
	[22] [float] NOT NULL,
	[23] [float] NOT NULL,
	[24] [float] NOT NULL,
	[25] [float] NOT NULL,
	[26] [float] NOT NULL,
	[27] [float] NOT NULL,
	[28] [float] NOT NULL,
	[29] [float] NOT NULL,
	[30] [float] NOT NULL,
 CONSTRAINT [PK_R_Infl] PRIMARY KEY CLUSTERED 
(
	[n] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FI_R_RealReturn]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FI_R_RealReturn](
	[n] [int] NOT NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[1] [float] NOT NULL,
	[2] [float] NOT NULL,
	[3] [float] NOT NULL,
	[4] [float] NOT NULL,
	[5] [float] NOT NULL,
	[6] [float] NOT NULL,
	[7] [float] NOT NULL,
	[8] [float] NOT NULL,
	[9] [float] NOT NULL,
	[10] [float] NOT NULL,
	[11] [float] NOT NULL,
	[12] [float] NOT NULL,
	[13] [float] NOT NULL,
	[14] [float] NOT NULL,
	[15] [float] NOT NULL,
	[16] [float] NOT NULL,
	[17] [float] NOT NULL,
	[18] [float] NOT NULL,
	[19] [float] NOT NULL,
	[20] [float] NOT NULL,
	[21] [float] NOT NULL,
	[22] [float] NOT NULL,
	[23] [float] NOT NULL,
	[24] [float] NOT NULL,
	[25] [float] NOT NULL,
	[26] [float] NOT NULL,
	[27] [float] NOT NULL,
	[28] [float] NOT NULL,
	[29] [float] NOT NULL,
	[30] [float] NOT NULL,
 CONSTRAINT [PK_R_RR] PRIMARY KEY CLUSTERED 
(
	[n] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FI_R_StressReg]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FI_R_StressReg](
	[n] [int] NOT NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[1] [float] NOT NULL,
	[2] [float] NOT NULL,
	[3] [float] NOT NULL,
	[4] [float] NOT NULL,
	[5] [float] NOT NULL,
	[6] [float] NOT NULL,
	[7] [float] NOT NULL,
	[8] [float] NOT NULL,
	[9] [float] NOT NULL,
	[10] [float] NOT NULL,
	[11] [float] NOT NULL,
	[12] [float] NOT NULL,
	[13] [float] NOT NULL,
	[14] [float] NOT NULL,
	[15] [float] NOT NULL,
	[16] [float] NOT NULL,
	[17] [float] NOT NULL,
	[18] [float] NOT NULL,
	[19] [float] NOT NULL,
	[20] [float] NOT NULL,
	[21] [float] NOT NULL,
	[22] [float] NOT NULL,
	[23] [float] NOT NULL,
	[24] [float] NOT NULL,
	[25] [float] NOT NULL,
	[26] [float] NOT NULL,
	[27] [float] NOT NULL,
	[28] [float] NOT NULL,
	[29] [float] NOT NULL,
	[30] [float] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FI_R_TermPremium]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FI_R_TermPremium](
	[n] [int] NOT NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[1] [float] NOT NULL,
	[2] [float] NOT NULL,
	[3] [float] NOT NULL,
	[4] [float] NOT NULL,
	[5] [float] NOT NULL,
	[6] [float] NOT NULL,
	[7] [float] NOT NULL,
	[8] [float] NOT NULL,
	[9] [float] NOT NULL,
	[10] [float] NOT NULL,
	[11] [float] NOT NULL,
	[12] [float] NOT NULL,
	[13] [float] NOT NULL,
	[14] [float] NOT NULL,
	[15] [float] NOT NULL,
	[16] [float] NOT NULL,
	[17] [float] NOT NULL,
	[18] [float] NOT NULL,
	[19] [float] NOT NULL,
	[20] [float] NOT NULL,
	[21] [float] NOT NULL,
	[22] [float] NOT NULL,
	[23] [float] NOT NULL,
	[24] [float] NOT NULL,
	[25] [float] NOT NULL,
	[26] [float] NOT NULL,
	[27] [float] NOT NULL,
	[28] [float] NOT NULL,
	[29] [float] NOT NULL,
	[30] [float] NOT NULL,
 CONSTRAINT [PK_R_TermPremium] PRIMARY KEY CLUSTERED 
(
	[n] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NFI_AC_CdnEq]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NFI_AC_CdnEq](
	[CdnEqKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NFI_AC_CdnLVEq]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NFI_AC_CdnLVEq](
	[CdnLVEqKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NFI_AC_EMEq]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NFI_AC_EMEq](
	[EMEqKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NFI_AC_Float]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NFI_AC_Float](
	[NFIFloatKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NFI_AC_GloEq]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NFI_AC_GloEq](
	[GloEqKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NFI_AC_GloLVEq]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NFI_AC_GloLVEq](
	[GloLVEqKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NFI_AC_IE]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NFI_AC_IE](
	[IEKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NFI_AC_PE]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NFI_AC_PE](
	[PEKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NFI_AC_RE]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NFI_AC_RE](
	[REKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NFI_I_TriangleDistribution]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NFI_I_TriangleDistribution](
	[TriangleDistributionKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[ReturnType] [varchar](100) NOT NULL,
	[TriangleDistValue] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NFI_R_Corr]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NFI_R_Corr](
	[Key] [int] NOT NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[n] [float] NOT NULL,
	[t] [float] NOT NULL,
	[CdnEq] [float] NOT NULL,
	[GloEq] [float] NOT NULL,
	[EMEq] [float] NOT NULL,
	[CdnLVEq] [float] NOT NULL,
	[GloLVEq] [float] NOT NULL,
	[PE] [float] NOT NULL,
	[IE] [float] NOT NULL,
	[RE] [float] NOT NULL,
 CONSTRAINT [PK_NFI_R_Corr] PRIMARY KEY CLUSTERED 
(
	[Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NFI_R_Corr_Final]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NFI_R_Corr_Final](
	[RKey] [int] IDENTITY(1,1) NOT NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[n] [float] NOT NULL,
	[t] [float] NOT NULL,
	[CdnEq] [float] NOT NULL,
	[GloEq] [float] NOT NULL,
	[EMEq] [float] NOT NULL,
	[CdnLVEq] [float] NOT NULL,
	[GloLVEq] [float] NOT NULL,
	[PE] [float] NOT NULL,
	[IE] [float] NOT NULL,
	[RE] [float] NOT NULL,
 CONSTRAINT [PK_NFI_R_Corr_Final] PRIMARY KEY CLUSTERED 
(
	[RKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NFI_R_NCorr]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NFI_R_NCorr](
	[RKey] [int] NOT NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[n] [float] NOT NULL,
	[t] [float] NOT NULL,
	[CdnEq] [float] NOT NULL,
	[GloEq] [float] NOT NULL,
	[EMEq] [float] NOT NULL,
	[CdnLVEq] [float] NOT NULL,
	[GloLVEq] [float] NOT NULL,
	[PE] [float] NOT NULL,
	[IE] [float] NOT NULL,
	[RE] [float] NOT NULL,
 CONSTRAINT [PK_NFI_R_NCorr] PRIMARY KEY CLUSTERED 
(
	[RKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ParameterHistory]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ParameterHistory](
	[ParameterHistoryKey] [int] IDENTITY(1,1) NOT NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[ParameterProc] [varchar](255) NOT NULL,
	[ParameterName] [varchar](255) NOT NULL,
	[ParameterValue] [varchar](255) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ResultSet]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ResultSet](
	[ResultSetKey] [int] IDENTITY(1,1) NOT NULL,
	[ResultSetNo] [int] NOT NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[MixName] [varchar](255) NOT NULL,
	[ResultSetDescript] [varchar](255) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ResultSetLink]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ResultSetLink](
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[ResultSetNo] [int] NOT NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[MixName] [varchar](255) NOT NULL,
	[RateType] [varchar](4) NOT NULL,
	[BasisType] [varchar](13) NOT NULL,
	[ResultType] [varchar](260) NOT NULL,
	[LinkKey] [varchar](92) NULL,
	[ResultLinkKey] [varchar](128) NULL,
	[ResultLinkKey2] [varchar](123) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tally]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tally](
	[n] [int] NOT NULL,
 CONSTRAINT [PK_Tally] PRIMARY KEY CLUSTERED 
(
	[n] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [tmp].[ALM_R_CF_NormalCost]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [tmp].[ALM_R_CF_NormalCost](
	[n] [int] NOT NULL,
	[t] [int] NULL,
	[NormalCost] [float] NULL,
	[RateType] [varchar](25) NULL,
	[ResultSetNo] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](4000) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [tmp].[ALM_R_CF_SF_DefPmt]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [tmp].[ALM_R_CF_SF_DefPmt](
	[n] [int] NOT NULL,
	[t] [int] NULL,
	[ShortFall] [float] NULL,
	[DefPmt] [float] NULL,
	[CumDefPmt] [float] NULL,
	[RateType] [varchar](10) NULL,
	[ResultSetNo] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](255) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [tmp].[ALM_R_L_AdjustedLiability]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [tmp].[ALM_R_L_AdjustedLiability](
	[t] [int] NOT NULL,
	[n] [int] NOT NULL,
	[prj_t] [int] NOT NULL,
	[NondiscountedValue] [float] NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](4000) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [tmp].[FV_Schedule_CF]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [tmp].[FV_Schedule_CF](
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[cf_t] [int] NULL,
	[NormalCost] [float] NOT NULL,
	[Adjusted] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [tmp].[FV_Schedule_NC_FS]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [tmp].[FV_Schedule_NC_FS](
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[FV_Schedule_NC_FS] [float] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](4000) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [trl].[ALM_R_A_ProjectedBenefitPayments]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trl].[ALM_R_A_ProjectedBenefitPayments](
	[BPKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[BenefitPayment] [float] NOT NULL,
	[ResultSetNo] [int] NULL,
	[OriginalCreatedDate] [datetime] NULL,
	[OriginalCreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [trl].[ALM_R_A_ProjectedCashFlow]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trl].[ALM_R_A_ProjectedCashFlow](
	[CFKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[ExpectedCashFlow] [float] NOT NULL,
	[ResultSetNo] [int] NULL,
	[OriginalCreatedDate] [datetime] NULL,
	[OriginalCreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [trl].[ALM_R_A_ProjectedContributions]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trl].[ALM_R_A_ProjectedContributions](
	[PCKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Contributions] [float] NOT NULL,
	[ResultSetNo] [int] NULL,
	[OriginalCreatedDate] [datetime] NULL,
	[OriginalCreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [trl].[ALM_R_A_ProjectedMVA]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trl].[ALM_R_A_ProjectedMVA](
	[MVAKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[MVA] [float] NOT NULL,
	[ResultSetNo] [int] NULL,
	[OriginalCreatedDate] [datetime] NULL,
	[OriginalCreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [trl].[AlternativeMixes]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trl].[AlternativeMixes](
	[AMKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[ProjectedReturns] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[MixName] [varchar](255) NULL,
	[OriginalCreatedDate] [datetime] NULL,
	[OriginalCreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [trl].[FI_AC_BorrowCst]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trl].[FI_AC_BorrowCst](
	[BorrowCstKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[OriginalCreatedDate] [datetime] NULL,
	[OriginalCreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [trl].[FI_AC_Corp]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trl].[FI_AC_Corp](
	[CorpKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[OriginalCreatedDate] [datetime] NULL,
	[OriginalCreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [trl].[FI_AC_Float]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trl].[FI_AC_Float](
	[FloatKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[OriginalCreatedDate] [datetime] NULL,
	[OriginalCreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [trl].[FI_AC_LTBond]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trl].[FI_AC_LTBond](
	[LTBondKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[OriginalCreatedDate] [datetime] NULL,
	[OriginalCreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [trl].[FI_AC_Mort]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trl].[FI_AC_Mort](
	[Mort] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[OriginalCreatedDate] [datetime] NULL,
	[OriginalCreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [trl].[FI_AC_PrDebt]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trl].[FI_AC_PrDebt](
	[PrDebt] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[OriginalCreatedDate] [datetime] NULL,
	[OriginalCreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [trl].[FI_AC_STCr]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trl].[FI_AC_STCr](
	[STCr] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[OriginalCreatedDate] [datetime] NULL,
	[OriginalCreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [trl].[FI_AC_UBond]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trl].[FI_AC_UBond](
	[UBond] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[OriginalCreatedDate] [datetime] NULL,
	[OriginalCreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [trl].[NFI_AC_CdnEq]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trl].[NFI_AC_CdnEq](
	[CdnEqKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[OriginalCreatedDate] [datetime] NULL,
	[OriginalCreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [trl].[NFI_AC_CdnLVEq]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trl].[NFI_AC_CdnLVEq](
	[CdnLVEqKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[OriginalCreatedDate] [datetime] NULL,
	[OriginalCreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [trl].[NFI_AC_EMEq]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trl].[NFI_AC_EMEq](
	[EMEqKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[OriginalCreatedDate] [datetime] NULL,
	[OriginalCreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [trl].[NFI_AC_GloEq]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trl].[NFI_AC_GloEq](
	[GloEqKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[OriginalCreatedDate] [datetime] NULL,
	[OriginalCreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [trl].[NFI_AC_GloLVEq]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trl].[NFI_AC_GloLVEq](
	[GloLVEqKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[OriginalCreatedDate] [datetime] NULL,
	[OriginalCreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [trl].[NFI_AC_IE]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trl].[NFI_AC_IE](
	[IE] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[OriginalCreatedDate] [datetime] NULL,
	[OriginalCreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [trl].[NFI_AC_PE]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trl].[NFI_AC_PE](
	[PE] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[OriginalCreatedDate] [datetime] NULL,
	[OriginalCreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [trl].[NFI_AC_RE]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trl].[NFI_AC_RE](
	[RE] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Normal] [float] NOT NULL,
	[Stressed] [float] NOT NULL,
	[Combined] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[OriginalCreatedDate] [datetime] NULL,
	[OriginalCreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [trl].[NFI_I_TriangleDistribution]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trl].[NFI_I_TriangleDistribution](
	[TriangleDistributionKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[ReturnType] [varchar](100) NOT NULL,
	[TriangleDistValue] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[OriginalCreatedDate] [datetime] NULL,
	[OriginalCreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [trl].[ParameterHistory]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trl].[ParameterHistory](
	[ParameterHistoryKey] [int] IDENTITY(1,1) NOT NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[ParameterProc] [varchar](255) NOT NULL,
	[ParameterName] [varchar](255) NOT NULL,
	[ParameterValue] [varchar](255) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[vw_AC_Inputs]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vw_AC_Inputs]
WITH SCHEMABINDING  
AS
	
	select sq.n, sq.t, sq.InputValue, sq.[Input Type], sq.AssumptionSetno, 
		CAST(t as varchar) + '#' + CAST(n as varchar) + '#' + CAST(AssumptionSetNo as varchar)  [LinkKey],
		sq.ParameterProc + '#' +  CAST(AssumptionSetNo as varchar)  [ParameterLinkKey]
	from (
		select n, t, Inflation [InputValue], AssumptionSetNo, 'Inflation' [Input Type], 'GenerateProjectedInflation' [ParameterProc]
		from [dbo].[FI_I_Infl]
			union
		select n, t, RealReturn [InputValue], AssumptionSetNo, 'Real Return' [Input Type], 'GenerateProjectedRealReturn'
		from [dbo].[FI_I_RealReturn]
			union
		select n, t, ST [InputValue], AssumptionSetNo, 'Short-Term Return' [Input Type], NULL
		from [dbo].[FI_I_ShortTermReturn]
			union
		select n, t, TermPremium [InputValue], AssumptionSetNo, 'Term Premium' [Input Type], 'GenerateProjectedTermPremium'
		from [dbo].[FI_I_TermPremium]
			union
		select n, t, LT [InputValue], AssumptionSetNo, 'Long-Term Return' [Input Type], NULL
		from [dbo].[FI_I_LongTermReturn]
			union
		select n, t, CreditSpread [InputValue], AssumptionSetNo, 'Credit Spread' [Input Type], 'GenerateProjectedCreditSpread'
		from [dbo].[FI_I_CreditSpread]
			union
		select n, t, Salary_Increase [InputValue], AssumptionSetNo, 'Salary Increase' [Input Type], NULL
		from [dbo].[ALM_Salary_Increase]

	) sq

--Create an index on all the tables that support the view
/*
CREATE NONCLUSTERED INDEX idx_FI_I_Infl on [dbo].[FI_I_Infl](n, t, AssumptionSetNo)
CREATE NONCLUSTERED INDEX idx_FI_I_RealReturn on [dbo].[FI_I_RealReturn](n, t, AssumptionSetNo)
CREATE NONCLUSTERED INDEX idx_FI_I_ShortTermReturn on [dbo].[FI_I_ShortTermReturn](n, t, AssumptionSetNo)
CREATE NONCLUSTERED INDEX idx_FI_I_TermPremium on [dbo].[FI_I_TermPremium](n, t, AssumptionSetNo)
CREATE NONCLUSTERED INDEX idx_FI_I_LongTermReturn on [dbo].[FI_I_LongTermReturn](n, t, AssumptionSetNo)
*/



GO
/****** Object:  View [dbo].[vw_AC_Returns]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [dbo].[vw_AC_Returns]
WITH SCHEMABINDING  
AS
	
	select sq.n, sq.t, sq.Normal, sq.Stressed, sq.Combined, sq.[Asset Class], sq.[Asset Group], sq.AssumptionSetno, CreatedDate, CreatedBy,
		CAST(t as varchar) + '#' + CAST(n as varchar) + '#' + CAST(AssumptionSetNo as varchar)  [LinkKey],
		sq.ParameterProc + '#' +  CAST(AssumptionSetNo as varchar)  [ParameterLinkKey]
	from (
		select n, t, Normal, Stressed, Combined, AssumptionSetNo, CreatedDate, CreatedBy, 
			'Fixed Income' [Asset Group], 'AA Bonds' [Asset Class], 'GenerateProjectedFIReturn:UBond' [ParameterProc] 
		from [dbo].[FI_AC_UBond]
			union 
		select n, t, Normal, Stressed, Combined, AssumptionSetNo, CreatedDate, CreatedBy, 
			'Fixed Income' [Asset Group], 'Long Term Bonds' [Asset Class], 'GenerateProjectedFIReturn:LTBond' [ParameterProc] 
		from [dbo].[FI_AC_LTBond]
			union 
		select n, t, Normal, Stressed, Combined, AssumptionSetNo, CreatedDate, CreatedBy, 
			'Fixed Income' [Asset Group], 'Mortgages' [Asset Class], 'GenerateProjectedFIReturn:Mort' [ParameterProc] 
		from [dbo].[FI_AC_Mort]
			union 
		select n, t, Normal, Stressed, Combined, AssumptionSetNo, CreatedDate, CreatedBy, 
			'Fixed Income' [Asset Group], 'Corporate Debt' [Asset Class], 'GenerateProjectedFIReturn:Corp' [ParameterProc] 
		from [dbo].[FI_AC_Corp]
			union 
		select n, t, Normal, Stressed, Combined, AssumptionSetNo, CreatedDate, CreatedBy, 
			'Fixed Income' [Asset Group], 'Private Debt' [Asset Class], 'GenerateProjectedFIReturn:PrDebt' [ParameterProc] 
		from [dbo].[FI_AC_PrDebt]
			union 
		select n, t, Normal, Stressed, Combined, AssumptionSetNo, CreatedDate, CreatedBy, 
			'Fixed Income' [Asset Group], 'Short-term Credit' [Asset Class], 'GenerateProjectedFIReturn:STCr' [ParameterProc] 
		from [dbo].[FI_AC_STCr]
			union  
		select n, t, Normal, Stressed, Combined, AssumptionSetNo, CreatedDate, CreatedBy,
			'Fixed Income' [Asset Group], 'Borrowing Cost' [Asset Class], 'GenerateProjectedFIReturn:BorrowCst' [ParameterProc] 
		from [dbo].[FI_AC_BorrowCst]
			union 
		select n, t, Normal, Stressed, Combined, AssumptionSetNo, CreatedDate, CreatedBy, 
			'Non-Fixed Income' [Asset Group], 'Canadian Equity' [Asset Class], 'GenerateProjectedNFIReturn:CdnEq' [ParameterProc] 
		from [dbo].[NFI_AC_CdnEq]
			union 
		select n, t, Normal, Stressed, Combined, AssumptionSetNo, CreatedDate, CreatedBy, 
			'Non-Fixed Income' [Asset Group], 'Global Equity' [Asset Class], 'GenerateProjectedNFIReturn:GloEq' [ParameterProc] 
		from [dbo].[NFI_AC_GloEq]
			union 
		select n, t, Normal, Stressed, Combined, AssumptionSetNo, CreatedDate, CreatedBy, 
			'Non-Fixed Income' [Asset Group], 'Emerging Market Equity' [Asset Class], 'GenerateProjectedNFIReturn:EMEq' [ParameterProc] 
		from [dbo].[NFI_AC_EMEq]
			union 
		select n, t, Normal, Stressed, Combined, AssumptionSetNo, CreatedDate, CreatedBy, 
			'Non-Fixed Income' [Asset Group], 'Canadian Low Volatility Equity' [Asset Class], 'GenerateProjectedNFIReturn:CdnLVEq' [ParameterProc] 
		from [dbo].[NFI_AC_CdnLVEq]
			union 
		select n, t, Normal, Stressed, Combined, AssumptionSetNo, CreatedDate, CreatedBy, 
			'Non-Fixed Income' [Asset Group], 'Global Low Volatility Equity' [Asset Class], 'GenerateProjectedNFIReturn:GloLVEq' [ParameterProc] 
		from [dbo].[NFI_AC_GloLVEq]
			union 
		select n, t, Normal, Stressed, Combined, AssumptionSetNo, CreatedDate, CreatedBy, 
			'Non-Fixed Income' [Asset Group], 'Private Equity' [Asset Class], 'GenerateProjectedNFIReturn:PE' [ParameterProc] 
		from [dbo].[NFI_AC_PE]
			union 
		select n, t, Normal, Stressed, Combined, AssumptionSetNo, CreatedDate, CreatedBy, 
			'Non-Fixed Income' [Asset Group], 'Infrastructure Equity' [Asset Class], 'GenerateProjectedNFIReturn:IE' [ParameterProc] 
		from [dbo].[NFI_AC_IE]
			union 
		select n, t, Normal, Stressed, Combined, AssumptionSetNo, CreatedDate, CreatedBy, 
			'Non-Fixed Income' [Asset Group], 'Real Estate' [Asset Class], 'GenerateProjectedNFIReturn:RE' [ParameterProc] 
		from [dbo].[NFI_AC_RE]
		--floating asset classes
			union 
		select n, t, Normal, Stressed, Combined, AssumptionSetNo, CreatedDate, CreatedBy, 
			'Fixed Income' [Asset Group], 'Liability Driven Investment (LDI)' [Asset Class], 'GenerateProjectedFIReturn:Float' [ParameterProc] 
		from [dbo].[FI_AC_Float]
			union 
		select n, t, Normal, Stressed, Combined, AssumptionSetNo, CreatedDate, CreatedBy, 
			'Non-Fixed Income' [Asset Group], 'Infrastructure Equity (VA)' [Asset Class], 'GenerateProjectedNFIReturn:Float' [ParameterProc] 
		from [dbo].[NFI_AC_Float]

	) sq

--Create an index on all the tables that support the view
/*
CREATE NONCLUSTERED INDEX idx_FI_AC_PrDebt on [dbo].[FI_AC_PrDebt](n, t, AssumptionSetNo)
CREATE NONCLUSTERED INDEX idx_FI_AC_Mort on [dbo].[FI_AC_Mort](n, t, AssumptionSetNo)
CREATE NONCLUSTERED INDEX idx_FI_AC_LTBond on [dbo].[FI_AC_LTBond](n, t, AssumptionSetNo)
CREATE NONCLUSTERED INDEX idx_FI_AC_Corp on [dbo].[FI_AC_Corp](n, t, AssumptionSetNo)
CREATE NONCLUSTERED INDEX idx_FI_AC_STCr on [dbo].[FI_AC_STCr](n, t, AssumptionSetNo)
CREATE NONCLUSTERED INDEX idx_FI_AC_UBond on [dbo].[FI_AC_UBond](n, t, AssumptionSetNo)
CREATE NONCLUSTERED INDEX idx_FI_AC_BorrowCst on [dbo].[FI_AC_BorrowCst](n, t, AssumptionSetNo)
CREATE NONCLUSTERED INDEX idx_NFI_AC_CdnEq on [dbo].[NFI_AC_CdnEq](n, t, AssumptionSetNo)
CREATE NONCLUSTERED INDEX idx_NFI_AC_GloEq on [dbo].[NFI_AC_GloEq](n, t, AssumptionSetNo)
CREATE NONCLUSTERED INDEX idx_NFI_AC_EMEq on [dbo].[NFI_AC_EMEq](n, t, AssumptionSetNo)
CREATE NONCLUSTERED INDEX idx_NFI_AC_CdnLVEq on [dbo].[NFI_AC_CdnLVEq](n, t, AssumptionSetNo)
CREATE NONCLUSTERED INDEX idx_NFI_AC_GloLVEq on [dbo].[NFI_AC_GloLVEq](n, t, AssumptionSetNo)
CREATE NONCLUSTERED INDEX idx_NFI_AC_PE on [dbo].[NFI_AC_PE](n, t, AssumptionSetNo)
CREATE NONCLUSTERED INDEX idx_NFI_AC_IE on [dbo].[NFI_AC_IE](n, t, AssumptionSetNo)
CREATE NONCLUSTERED INDEX idx_NFI_AC_RE on [dbo].[NFI_AC_RE](n, t, AssumptionSetNo)
*/










GO
/****** Object:  View [dbo].[vw_ALM_ResultLink]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vw_ALM_ResultLink]
   
AS
	
	select t1.n, t2.n [t], ResultSetNo, AssumptionSetNo, MixName, 'GC' RateType, 'Going Concern' BasisType,
	MixName + ':GC' ResultType, 
	 CAST(t2.n as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar)  [LinkKey],
     CAST(t2.n as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar) + '#' +  CAST(ResultSetNo as varchar) + '#' + 'GC' [ResultLinkKey],
     CAST(t2.n as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar) + '#' +  CAST(ResultSetNo as varchar) [ResultLinkKey2]
	from dbo.Tally t1
	inner join dbo.Tally t2 on 1 = 1 
	inner join dbo.ResultSet t on 1 = 1
	where t1.n <= 2000 and t2.n < 30
		union
	select t1.n, t2.n [t], ResultSetNo, AssumptionSetNo, MixName, 'SOLV' RateType, 'Solvency' BasisType,
		MixName + ':SOLV' ResultType, 
		 CAST(t2.n as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar)  [LinkKey],
		 CAST(t2.n as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar) + '#' +  CAST(ResultSetNo as varchar) + '#' + 'SOLV' [ResultLinkKey],
		 CAST(t2.n as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar) + '#' +  CAST(ResultSetNo as varchar) [ResultLinkKey2]
	from dbo.Tally t1
	inner join dbo.Tally t2 on 1 = 1 
	inner join dbo.ResultSet t on 1 = 1
	where t1.n <= 2000 and t2.n < 30

	/*
	CREATE UNIQUE CLUSTERED INDEX IDX_vw_ALM_ResultLink 
    ON vw_ALM_ResultLink (n,t,ResultSetNo,RateType,MixName);  
	GO  
	*/





GO
/****** Object:  View [dbo].[vw_FI_Infl]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vw_FI_Infl]
AS

	SELECT AssumptionSetNo, n,   
		[1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
		[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
		[21], [22], [23], [24], [25], [26], [27], [28], [29], [30]
	FROM  
	(
	 SELECT n, t, AssumptionSetNo, Inflation
	 FROM FI_I_Infl
	 ) AS SourceTable  
	PIVOT  
		(
		MAX(Inflation)  
		FOR t IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
				  [11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
				  [21], [22], [23], [24], [25], [26], [27], [28], [29], [30])  
		) AS PivotTable

	/*
	select * 
	from vw_Infl
	where AssumptionSetNo = 1
	order by n asc
	*/
	



GO
/****** Object:  View [dbo].[vw_FI_LongTermReturn]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[vw_FI_LongTermReturn]
AS

	SELECT AssumptionSetNo, n,   
		[1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
		[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
		[21], [22], [23], [24], [25], [26], [27], [28], [29], [30]
	FROM  
	(
	 SELECT n, t, AssumptionSetNo, LT
	 FROM FI_I_LongTermReturn
	 ) AS SourceTable  
	PIVOT  
		(
		MAX(LT)  
		FOR t IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
				  [11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
				  [21], [22], [23], [24], [25], [26], [27], [28], [29], [30])  
		) AS PivotTable

	/*
	select * 
	from vw_LongTermReturn
	where AssumptionSetNo = 1
	order by n asc
	*/
	





GO
/****** Object:  View [dbo].[vw_FI_R_CredPrem_Unpvt]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vw_FI_R_CredPrem_Unpvt]
AS

	select n, AssumptionSetNo, t, R_CredPrem
	from   
	   (select * from FI_R_CredPrem) p  
	UNPIVOT  
	   (R_CredPrem for t IN   
		  ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
		   [11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
		   [21], [22], [23], [24], [25], [26], [27], [28], [29], [30])  
		)as unpvt


GO
/****** Object:  View [dbo].[vw_FI_R_StressReg_Unpvt]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




Create VIEW [dbo].[vw_FI_R_StressReg_Unpvt]
AS

	select n, AssumptionSetNo, t, StressReg
	from   
	   (select * from FI_R_StressReg) p  
	UNPIVOT  
	   (StressReg for t IN   
		  ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
		   [11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
		   [21], [22], [23], [24], [25], [26], [27], [28], [29], [30])  
		)as unpvt



GO
/****** Object:  View [dbo].[vw_FI_R_StressRegCdnEq_Unpvt]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_FI_R_StressRegCdnEq_Unpvt]
AS
	/*
	Previous version of code used an imported table for this - this was duplicate from information already available in the model after the
	non-fixed income random numbers have been generated, correlated and updated

	select n, AssumptionSetNo, t, CdnEq
	from   
	   (select * from FI_R_StressRegCdnEq) p  
	UNPIVOT  
	   (CdnEq for t IN   
		  ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
		   [11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
		   [21], [22], [23], [24], [25], [26], [27], [28], [29], [30])  
		)as unpvt
	*/

  select rco.n, rco.t, rco.AssumptionSetNo, CdnEq
  from NFI_R_Corr_Final rco
  


GO
/****** Object:  View [dbo].[vw_FI_RealReturn]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vw_FI_RealReturn]
AS

	SELECT AssumptionSetNo, n,   
		[1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
		[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
		[21], [22], [23], [24], [25], [26], [27], [28], [29], [30]
	FROM  
	(
	 SELECT n, t, AssumptionSetNo, RealReturn
	 FROM FI_I_RealReturn
	 ) AS SourceTable  
	PIVOT  
		(
		MAX(RealReturn)  
		FOR t IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
				  [11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
				  [21], [22], [23], [24], [25], [26], [27], [28], [29], [30])  
		) AS PivotTable

	/*
	select * 
	from vw_RealReturn
	where AssumptionSetNo = 1
	order by n asc
	*/
	



GO
/****** Object:  View [dbo].[vw_FI_ShortTermReturn]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vw_FI_ShortTermReturn]
AS

	SELECT AssumptionSetNo, n,   
		[1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
		[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
		[21], [22], [23], [24], [25], [26], [27], [28], [29], [30]
	FROM  
	(
	 SELECT n, t, AssumptionSetNo, ST
	 FROM FI_I_ShortTermReturn
	 ) AS SourceTable  
	PIVOT  
		(
		MAX(ST)  
		FOR t IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
				  [11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
				  [21], [22], [23], [24], [25], [26], [27], [28], [29], [30])  
		) AS PivotTable

	/*
	select * 
	from vw_ShortTermReturn
	where AssumptionSetNo = 1
	order by n asc
	*/
	




GO
/****** Object:  View [dbo].[vw_FI_TermPremium]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vw_FI_TermPremium]
AS

	SELECT AssumptionSetNo, n,   
		[1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
		[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
		[21], [22], [23], [24], [25], [26], [27], [28], [29], [30]
	FROM  
	(
	 SELECT n, t, AssumptionSetNo, TermPremium
	 FROM FI_TermPremium
	 ) AS SourceTable  
	PIVOT  
		(
		MAX(TermPremium)  
		FOR t IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
				  [11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
				  [21], [22], [23], [24], [25], [26], [27], [28], [29], [30])  
		) AS PivotTable

	/*
	select * 
	from vw_TermPremium
	where AssumptionSetNo = 1
	order by n asc
	*/
	



GO
/****** Object:  View [dbo].[vw_NFI_CdnEq]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[vw_NFI_CdnEq]
AS

	SELECT AssumptionSetNo, n,   
		[1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
		[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
		[21], [22], [23], [24], [25], [26], [27], [28], [29], [30]
	FROM  
	(
	 SELECT n, t, AssumptionSetNo, Combined 
	 FROM NFI_AC_CdnEq
	 ) AS SourceTable  
	PIVOT  
		(
		MAX(Combined)  
		FOR t IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
				  [11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
				  [21], [22], [23], [24], [25], [26], [27], [28], [29], [30])  
		) AS PivotTable

	/*
	select * 
	from vw_Infl
	where AssumptionSetNo = 1
	order by n asc
	*/
	



GO
/****** Object:  View [dbo].[vw_NFI_CdnLVEq]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [dbo].[vw_NFI_CdnLVEq]
AS

	SELECT AssumptionSetNo, n,   
		[1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
		[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
		[21], [22], [23], [24], [25], [26], [27], [28], [29], [30]
	FROM  
	(
	 SELECT n, t, AssumptionSetNo, Combined 
	 FROM NFI_AC_CdnLVEq
	 ) AS SourceTable  
	PIVOT  
		(
		MAX(Combined)  
		FOR t IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
				  [11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
				  [21], [22], [23], [24], [25], [26], [27], [28], [29], [30])  
		) AS PivotTable



GO
/****** Object:  View [dbo].[vw_NFI_EMEq]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[vw_NFI_EMEq]
AS

	SELECT AssumptionSetNo, n,   
		[1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
		[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
		[21], [22], [23], [24], [25], [26], [27], [28], [29], [30]
	FROM  
	(
	 SELECT n, t, AssumptionSetNo, Combined 
	 FROM NFI_AC_EMEq
	 ) AS SourceTable  
	PIVOT  
		(
		MAX(Combined)  
		FOR t IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
				  [11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
				  [21], [22], [23], [24], [25], [26], [27], [28], [29], [30])  
		) AS PivotTable



GO
/****** Object:  View [dbo].[vw_NFI_GloEq]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [dbo].[vw_NFI_GloEq]
AS

	SELECT AssumptionSetNo, n,   
		[1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
		[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
		[21], [22], [23], [24], [25], [26], [27], [28], [29], [30]
	FROM  
	(
	 SELECT n, t, AssumptionSetNo, Combined 
	 FROM NFI_AC_GloEq
	 ) AS SourceTable  
	PIVOT  
		(
		MAX(Combined)  
		FOR t IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
				  [11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
				  [21], [22], [23], [24], [25], [26], [27], [28], [29], [30])  
		) AS PivotTable



GO
/****** Object:  View [dbo].[vw_NFI_GloLVEq]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [dbo].[vw_NFI_GloLVEq]
AS

	SELECT AssumptionSetNo, n,   
		[1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
		[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
		[21], [22], [23], [24], [25], [26], [27], [28], [29], [30]
	FROM  
	(
	 SELECT n, t, AssumptionSetNo, Combined 
	 FROM NFI_AC_GloLVEq
	 ) AS SourceTable  
	PIVOT  
		(
		MAX(Combined)  
		FOR t IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
				  [11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
				  [21], [22], [23], [24], [25], [26], [27], [28], [29], [30])  
		) AS PivotTable



GO
/****** Object:  View [dbo].[vw_NFI_IE]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE VIEW [dbo].[vw_NFI_IE]
AS

	SELECT AssumptionSetNo, n,   
		[1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
		[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
		[21], [22], [23], [24], [25], [26], [27], [28], [29], [30]
	FROM  
	(
	 SELECT n, t, AssumptionSetNo, Combined 
	 FROM NFI_AC_IE
	 ) AS SourceTable  
	PIVOT  
		(
		MAX(Combined)  
		FOR t IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
				  [11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
				  [21], [22], [23], [24], [25], [26], [27], [28], [29], [30])  
		) AS PivotTable



GO
/****** Object:  View [dbo].[vw_NFI_R_Corr_Final_Unpvt]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vw_NFI_R_Corr_Final_Unpvt]
AS

	select n, AssumptionSetNo, t, ReturnType, CorrValue
	from   
	   (select * from NFI_R_Corr_Final) p  
	UNPIVOT  
	   (CorrValue for ReturnType IN   
		  ([CdnEq], [GloEq], [EMEq], [CdnLVEq], [GloLVEq], [PE], [IE], [RE])  
		)as unpvt



GO
/****** Object:  View [dbo].[vw_NFI_RE]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE VIEW [dbo].[vw_NFI_RE]
AS

	SELECT AssumptionSetNo, n,   
		[1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
		[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
		[21], [22], [23], [24], [25], [26], [27], [28], [29], [30]
	FROM  
	(
	 SELECT n, t, AssumptionSetNo, Combined 
	 FROM NFI_AC_RE
	 ) AS SourceTable  
	PIVOT  
		(
		MAX(Combined)  
		FOR t IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
				  [11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
				  [21], [22], [23], [24], [25], [26], [27], [28], [29], [30])  
		) AS PivotTable



GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_ALM_I_L_DiscountRate]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_ALM_I_L_DiscountRate] ON [dbo].[ALM_I_L_DiscountRate]
(
	[n] ASC,
	[t] ASC,
	[ResultSetNo] ASC,
	[RateType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_ALM_NC_FS_Change]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_ALM_NC_FS_Change] ON [dbo].[ALM_I_NC_FS_Change]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_ALM_R_A_ProjectedBenefitPayments]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_ALM_R_A_ProjectedBenefitPayments] ON [dbo].[ALM_R_A_ProjectedBenefitPayments]
(
	[n] ASC,
	[t] ASC,
	[ResultSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_ALM_R_A_ProjectedCashFlow]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_ALM_R_A_ProjectedCashFlow] ON [dbo].[ALM_R_A_ProjectedCashFlow]
(
	[n] ASC,
	[t] ASC,
	[ResultSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_ALM_R_A_ProjectedContributions]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_ALM_R_A_ProjectedContributions] ON [dbo].[ALM_R_A_ProjectedContributions]
(
	[n] ASC,
	[t] ASC,
	[ResultSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_ALM_R_A_ProjectedMVA]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_ALM_R_A_ProjectedMVA] ON [dbo].[ALM_R_A_ProjectedMVA]
(
	[n] ASC,
	[t] ASC,
	[ResultSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_ALM_R_FR_Volatility]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_ALM_R_FR_Volatility] ON [dbo].[ALM_R_FR_Volatility]
(
	[n] ASC,
	[t] ASC,
	[ResultSetNo] ASC,
	[RateType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_ALM_R_L_ProjectedLiability]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_ALM_R_L_ProjectedLiability] ON [dbo].[ALM_R_L_ProjectedLiability]
(
	[n] ASC,
	[t] ASC,
	[ResultSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_AlternativeMixes]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_AlternativeMixes] ON [dbo].[AlternativeMixes]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC,
	[ResultSetNo] ASC,
	[MixName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_AssetClassReturn]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_AssetClassReturn] ON [dbo].[AssetClassReturn]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC,
	[AssetClass] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_FI_AC_Corp]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_FI_AC_Corp] ON [dbo].[FI_AC_Corp]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_FI_AC_LTBond]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_FI_AC_LTBond] ON [dbo].[FI_AC_LTBond]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_FI_AC_Mort]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_FI_AC_Mort] ON [dbo].[FI_AC_Mort]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_FI_AC_PrDebt]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_FI_AC_PrDebt] ON [dbo].[FI_AC_PrDebt]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_FI_AC_STCr]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_FI_AC_STCr] ON [dbo].[FI_AC_STCr]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_FI_AC_UBond]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_FI_AC_UBond] ON [dbo].[FI_AC_UBond]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_FI_I_Infl]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_FI_I_Infl] ON [dbo].[FI_I_Infl]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_FI_I_LongTermReturn]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_FI_I_LongTermReturn] ON [dbo].[FI_I_LongTermReturn]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_FI_I_RealReturn]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_FI_I_RealReturn] ON [dbo].[FI_I_RealReturn]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_FI_I_ShortTermReturn]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_FI_I_ShortTermReturn] ON [dbo].[FI_I_ShortTermReturn]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_FI_I_TermPremium]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_FI_I_TermPremium] ON [dbo].[FI_I_TermPremium]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_NFI_AC_CdnEq]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_NFI_AC_CdnEq] ON [dbo].[NFI_AC_CdnEq]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_NFI_AC_CdnLVEq]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_NFI_AC_CdnLVEq] ON [dbo].[NFI_AC_CdnLVEq]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_NFI_AC_EMEq]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_NFI_AC_EMEq] ON [dbo].[NFI_AC_EMEq]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_NFI_AC_GloEq]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_NFI_AC_GloEq] ON [dbo].[NFI_AC_GloEq]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_NFI_AC_GloLVEq]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_NFI_AC_GloLVEq] ON [dbo].[NFI_AC_GloLVEq]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_NFI_AC_IE]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_NFI_AC_IE] ON [dbo].[NFI_AC_IE]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_NFI_AC_PE]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_NFI_AC_PE] ON [dbo].[NFI_AC_PE]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_NFI_AC_RE]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_NFI_AC_RE] ON [dbo].[NFI_AC_RE]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_ALM_R_CF_NormalCost]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_ALM_R_CF_NormalCost] ON [tmp].[ALM_R_CF_NormalCost]
(
	[n] ASC,
	[t] ASC,
	[ResultSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_ALM_R_CF_SF_DefPmt]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_ALM_R_CF_SF_DefPmt] ON [tmp].[ALM_R_CF_SF_DefPmt]
(
	[n] ASC,
	[t] ASC,
	[ResultSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_ALM_R_L_AdjustedLiability]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_ALM_R_L_AdjustedLiability] ON [tmp].[ALM_R_L_AdjustedLiability]
(
	[n] ASC,
	[t] ASC,
	[prj_t] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_FV_Schedule_CF]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_FV_Schedule_CF] ON [tmp].[FV_Schedule_CF]
(
	[n] ASC,
	[t] ASC,
	[cf_t] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_FV_Schedule_NC_FS]    Script Date: 2019-04-15 09:51:47 AM ******/
CREATE NONCLUSTERED INDEX [idx_FV_Schedule_NC_FS] ON [tmp].[FV_Schedule_NC_FS]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[_1_Create_Economic_Indicators]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/01/03>
-- Description:	<Stored procedure for creating FI (fixed-interest) assumptions>
-- =============================================
CREATE PROCEDURE [dbo].[_1_Create_Economic_Indicators] (@AssumptionDescription as varchar(1000), @INF_tmin1 as varchar(1000), @INF_w as varchar(1000), @INF_LT as varchar(1000),
														@INF_sd_e as varchar(1000), @INF_mu_e as varchar(1000), @RR_tmin1 as varchar(1000),
														@RR_w as varchar(1000), @RR_LT as varchar(1000), @RR_sd_e as varchar(1000), @RR_mu_e as varchar(1000), 
														@TP_tmin1 as varchar(1000), @TP_w as varchar(1000), @TP_LT as varchar(1000), @TP_sd_e as varchar(1000), 
														@TP_mu_e as varchar(1000))
AS
BEGIN

	SET NOCOUNT ON;

    exec Create_AssumptionSet @AssumptionDescription

	declare @UserAssumptionSetNo as int = ( select max(AssumptionSetNo) from AssumptionSet )

	exec GenerateProjectedInflation @INF_tmin1, @INF_w, @INF_LT, @INF_sd_e, @INF_mu_e, @UserAssumptionSetNo
	exec GenerateProjectedRealReturn @RR_tmin1, @RR_w, @RR_LT, @RR_sd_e, @RR_mu_e, @UserAssumptionSetNo
	exec GenerateProjectedTermPremium @TP_tmin1, @TP_w, @TP_LT, @TP_sd_e, @TP_mu_e, @UserAssumptionSetNo
	exec GenerateProjectedShortTermReturn @UserAssumptionSetNo
	exec GenerateProjectedLongTermReturn @UserAssumptionSetNo

/*
	--Testing
	--exec _1_Create_Economic_Indicators @AssumptionSetNo
	  exec _1_Create_Economic_Indicators JUSTIN, '0.019', '0.85', '0.02', '0.005', '0', '0.0082', '0.9', '0.0122', '0.002', '0', '0.0046', '0.9', '0.0034', '0.002',0
*/
END


GO
/****** Object:  StoredProcedure [dbo].[_2_GenerateAllProjectedFIReturn]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/01/04>
-- Description:	<Stored procedure for creating projected future Long-term Bond returns>
-- =============================================
CREATE PROCEDURE [dbo].[_2_GenerateAllProjectedFIReturn] (@AssumptionSetNo as int, @prob_sr as varchar(255), 
														@UBond_ST as varchar(1000), @UBond_LT as varchar(1000), @UBond_ST_Dur as varchar(1000),@UBond_LT_Dur as varchar(1000), @UBond_E_alpha as varchar(1000), @UBond_sd_e as varchar(1000), @UBond_max_loss as varchar(255), 
														@LTBond_ST as varchar(1000), @LTBond_LT as varchar(1000), @LTBond_ST_Dur as varchar(1000),@LTBond_LT_Dur as varchar(1000), @LTBond_E_alpha as varchar(1000), @LTBond_sd_e as varchar(1000), @LTBond_max_loss as varchar(255), 
														@Mort_ST as varchar(1000), @Mort_LT as varchar(1000), @Mort_ST_Dur as varchar(1000),@Mort_LT_Dur as varchar(1000), @Mort_E_alpha as varchar(1000), @Mort_sd_e as varchar(1000), @Mort_max_loss as varchar(255), 
														@Corp_ST as varchar(1000), @Corp_LT as varchar(1000), @Corp_ST_Dur as varchar(1000),@Corp_LT_Dur as varchar(1000), @Corp_E_alpha as varchar(1000), @Corp_sd_e as varchar(1000), @Corp_max_loss as varchar(255), 
														@PrDebt_ST as varchar(1000), @PrDebt_LT as varchar(1000), @PrDebt_ST_Dur as varchar(1000),@PrDebt_LT_Dur as varchar(1000), @PrDebt_E_alpha as varchar(1000), @PrDebt_sd_e as varchar(1000), @PrDebt_max_loss as varchar(255), 
														@STCr_ST as varchar(1000), @STCr_LT as varchar(1000), @STCr_ST_Dur as varchar(1000),@STCr_LT_Dur as varchar(1000), @STCr_E_alpha as varchar(1000), @STCr_sd_e as varchar(1000), @STCr_max_loss as varchar(255), 
														@BorrowCst_ST as varchar(1000), @BorrowCst_LT as varchar(1000), @BorrowCst_ST_Dur as varchar(1000),@BorrowCst_LT_Dur as varchar(1000), @BorrowCst_E_alpha as varchar(1000), @BorrowCst_sd_e as varchar(1000), @BorrowCst_max_loss as varchar(255))

AS
BEGIN

	SET NOCOUNT ON;


	--exec GenerateProjectedFIReturn @ST, @LT, @ST_Dur, @LT_Dur, @E_alpha, @sd_e, @max_loss, @prob_sr, @ReturnType, @AssumptionSetNo
	exec GenerateProjectedFIReturn @UBond_ST , @UBond_LT , @UBond_ST_Dur ,@UBond_LT_Dur , @UBond_E_alpha , @UBond_sd_e , @UBond_max_loss , @prob_sr , 'UBond', @AssumptionSetNo
	exec GenerateProjectedFIReturn @LTBond_ST , @LTBond_LT , @LTBond_ST_Dur ,@LTBond_LT_Dur , @LTBond_E_alpha , @LTBond_sd_e , @LTBond_max_loss , @prob_sr , 'LTBond', @AssumptionSetNo
	exec GenerateProjectedFIReturn @Mort_ST , @Mort_LT , @Mort_ST_Dur ,@Mort_LT_Dur , @Mort_E_alpha , @Mort_sd_e , @Mort_max_loss , @prob_sr , 'Mort', @AssumptionSetNo
	exec GenerateProjectedFIReturn @Corp_ST , @Corp_LT , @Corp_ST_Dur ,@Corp_LT_Dur , @Corp_E_alpha , @Corp_sd_e , @Corp_max_loss , @prob_sr , 'Corp', @AssumptionSetNo
	exec GenerateProjectedFIReturn @PrDebt_ST , @PrDebt_LT , @PrDebt_ST_Dur ,@PrDebt_LT_Dur , @PrDebt_E_alpha , @PrDebt_sd_e , @PrDebt_max_loss , @prob_sr , 'PrDebt', @AssumptionSetNo
	exec GenerateProjectedFIReturn @STCr_ST , @STCr_LT , @STCr_ST_Dur ,@STCr_LT_Dur , @STCr_E_alpha , @STCr_sd_e , @STCr_max_loss , @prob_sr , 'STCr', @AssumptionSetNo
	exec GenerateProjectedFIReturn @BorrowCst_ST , @BorrowCst_LT , @BorrowCst_ST_Dur ,@BorrowCst_LT_Dur , @BorrowCst_E_alpha , @BorrowCst_sd_e , @BorrowCst_max_loss , @prob_sr , 'BorrowCst', @AssumptionSetNo
/*
	--Testing
	--exec _2_GenerateAllProjectedFIReturn @AssumptionSetNo, @prob_sr , 
														@UBond_ST , @UBond_LT , @UBond_ST_Dur ,@UBond_LT_Dur , @UBond_E_alpha , @UBond_sd_e , @UBond_max_loss , 
														@LTBond_ST , @LTBond_LT , @LTBond_ST_Dur ,@LTBond_LT_Dur , @LTBond_E_alpha , @LTBond_sd_e , @LTBond_max_loss , 
														@Mort_ST , @Mort_LT , @Mort_ST_Dur ,@Mort_LT_Dur , @Mort_E_alpha , @Mort_sd_e , @Mort_max_loss , 
														@Corp_ST , @Corp_LT , @Corp_ST_Dur ,@Corp_LT_Dur , @Corp_E_alpha , @Corp_sd_e , @Corp_max_loss , 
														@PrDebt_ST , @PrDebt_LT , @PrDebt_ST_Dur ,@PrDebt_LT_Dur , @PrDebt_E_alpha , @PrDebt_sd_e , @PrDebt_max_loss , 
														@STCr_ST , @STCr_LT , @STCr_ST_Dur ,@STCr_LT_Dur , @STCr_E_alpha , @STCr_sd_e , @STCr_max_loss , 
														@BorrowCst_ST , @BorrowCst_LT , @BorrowCst_ST_Dur ,@BorrowCst_LT_Dur , @BorrowCst_E_alpha , @BorrowCst_sd_e , @BorrowCst_max_loss 

	  exec _2_GenerateAllProjectedFIReturn 1, '0.075',
												 '0', '0', '0', '0', '0', '0', '0',
												 '0', '1', '7.5', '28', '0.0065', '0.0075', ' 0.1',
												 '0.6', '0.4', '7.5', '14.5', '0.0235', '0.015', ' 0.25',
												 '0.2', '0', '7.5', '14.5', '0.082', '0.005', ' 0.35',
												 '0.3', '0', '7.5', '14.5', '0.0075', '0.004', ' 0.05',
												 '0.5', '0', '7.5', '14.5', '0.031', '0.024', ' 0.1',
												 '0.5', '0', '2', '14.5', '0.0075', '0.005', ' 0.1'
*/
END

GO
/****** Object:  StoredProcedure [dbo].[_3_GenerateAllProjectedNFIReturn]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/01/04>
-- Description:	<Stored procedure for creating projected future Non-Fixed Income Returns>
-- =============================================
CREATE PROCEDURE [dbo].[_3_GenerateAllProjectedNFIReturn] (@AssumptionSetNo as int, @prob_sr as varchar(255), @CalcType as varchar(255),
														@CdnEq_max as float, @CdnEq_min as float, @CdnEq_breakpoint as float, 
															@CdnEq_ST_Weight as varchar(1000), @CdnEq_LT_Weight as varchar(1000), @CdnEq_mu_rp as varchar(1000), @CdnEq_sd_rp as varchar(1000),
														@GloEq_max as float, @GloEq_min as float, @GloEq_breakpoint as float,	
															@GloEq_ST_Weight as varchar(1000), @GloEq_LT_Weight as varchar(1000), @GloEq_mu_rp as varchar(1000), @GloEq_sd_rp as varchar(1000),
														@EMEq_max as float, @EMEq_min as float, @EMEq_breakpoint as float,	
															@EMEq_ST_Weight as varchar(1000), @EMEq_LT_Weight as varchar(1000), @EMEq_mu_rp as varchar(1000), @EMEq_sd_rp as varchar(1000),
														@CdnLVEq_max as float, @CdnLVEq_min as float, @CdnLVEq_breakpoint as float,	
															@CdnLVEq_ST_Weight as varchar(1000), @CdnLVEq_LT_Weight as varchar(1000), @CdnLVEq_mu_rp as varchar(1000), @CdnLVEq_sd_rp as varchar(1000),
														@GloLVEq_max as float, @GloLVEq_min as float, @GloLVEq_breakpoint as float,	
															@GloLVEq_ST_Weight as varchar(1000), @GloLVEq_LT_Weight as varchar(1000), @GloLVEq_mu_rp as varchar(1000), @GloLVEq_sd_rp as varchar(1000),
														@PE_max as float, @PE_min as float, @PE_breakpoint as float,	
															@PE_ST_Weight as varchar(1000), @PE_LT_Weight as varchar(1000), @PE_mu_rp as varchar(1000), @PE_sd_rp as varchar(1000),
														@IE_max as float, @IE_min as float, @IE_breakpoint as float,	
															@IE_ST_Weight as varchar(1000), @IE_LT_Weight as varchar(1000), @IE_mu_rp as varchar(1000), @IE_sd_rp as varchar(1000),
														@RE_max as float, @RE_min as float, @RE_breakpoint as float,	
															@RE_ST_Weight as varchar(1000), @RE_LT_Weight as varchar(1000), @RE_mu_rp as varchar(1000), @RE_sd_rp as varchar(1000))
AS
BEGIN

	SET NOCOUNT ON;

	--exec GenerateNFITriangleDistribution @max, @min, @breakpoint, @ReturnType, @AssumptionSetNo	
	--exec GenerateProjectedNFIReturn @ST_Weight, @LT_Weight, @mu_rp, @sd_rp, @prob_sr, @ReturnType, @AssumptionSetNo, @CalcType

	exec GenerateNFITriangleDistribution @CdnEq_max, @CdnEq_min, @CdnEq_breakpoint, 'CdnEq', @AssumptionSetNo	
	exec GenerateProjectedNFIReturn @CdnEq_ST_Weight, @CdnEq_LT_Weight, @CdnEq_mu_rp, @CdnEq_sd_rp, @prob_sr, 'CdnEq', @AssumptionSetNo, 'IN'

	exec GenerateNFITriangleDistribution @GloEq_max, @GloEq_min, @GloEq_breakpoint, 'GloEq', @AssumptionSetNo	
	exec GenerateProjectedNFIReturn @GloEq_ST_Weight, @GloEq_LT_Weight, @GloEq_mu_rp, @GloEq_sd_rp, @prob_sr, 'GloEq', @AssumptionSetNo, 'IN'

	exec GenerateNFITriangleDistribution @EMEq_max, @EMEq_min, @EMEq_breakpoint, 'EMEq', @AssumptionSetNo	
	exec GenerateProjectedNFIReturn @EMEq_ST_Weight, @EMEq_LT_Weight, @EMEq_mu_rp, @EMEq_sd_rp, @prob_sr, 'EMEq', @AssumptionSetNo, 'IN'

	exec GenerateNFITriangleDistribution @CdnLVEq_max, @CdnLVEq_min, @CdnLVEq_breakpoint, 'CdnLVEq', @AssumptionSetNo	
	exec GenerateProjectedNFIReturn @CdnLVEq_ST_Weight, @CdnLVEq_LT_Weight, @CdnLVEq_mu_rp, @CdnLVEq_sd_rp, @prob_sr, 'CdnLVEq', @AssumptionSetNo, 'IN'

	exec GenerateNFITriangleDistribution @GloLVEq_max, @GloLVEq_min, @GloLVEq_breakpoint, 'GloLVEq', @AssumptionSetNo	
	exec GenerateProjectedNFIReturn @GloLVEq_ST_Weight, @GloLVEq_LT_Weight, @GloLVEq_mu_rp, @GloLVEq_sd_rp, @prob_sr, 'GloLVEq', @AssumptionSetNo, 'IN'

	exec GenerateNFITriangleDistribution @PE_max, @PE_min, @PE_breakpoint, 'PE', @AssumptionSetNo	
	exec GenerateProjectedNFIReturn @PE_ST_Weight, @PE_LT_Weight, @PE_mu_rp, @PE_sd_rp, @prob_sr, 'PE', @AssumptionSetNo, 'IN'

	exec GenerateNFITriangleDistribution @IE_max, @IE_min, @IE_breakpoint, 'IE', @AssumptionSetNo	
	exec GenerateProjectedNFIReturn @IE_ST_Weight, @IE_LT_Weight, @IE_mu_rp, @IE_sd_rp, @prob_sr, 'IE', @AssumptionSetNo, 'IN'

	exec GenerateNFITriangleDistribution @RE_max, @RE_min, @RE_breakpoint, 'RE', @AssumptionSetNo	
	exec GenerateProjectedNFIReturn @RE_ST_Weight, @RE_LT_Weight, @RE_mu_rp, @RE_sd_rp, @prob_sr, 'RE', @AssumptionSetNo, 'IN'
/*
	--exec _3_GenerateAllProjectedNFIReturn @AssumptionSetNo, @prob_sr , @CalcType ,
														@CdnEq_max , @CdnEq_min , @CdnEq_breakpoint , 
															@CdnEq_ST_Weight , @CdnEq_LT_Weight , @CdnEq_mu_rp , @CdnEq_sd_rp ,
														@GloEq_max , @GloEq_min , @GloEq_breakpoint ,	
															@GloEq_ST_Weight , @GloEq_LT_Weight , @GloEq_mu_rp , @GloEq_sd_rp ,
														@EMEq_max , @EMEq_min , @EMEq_breakpoint ,	
															@EMEq_ST_Weight , @EMEq_LT_Weight , @EMEq_mu_rp , @EMEq_sd_rp ,
														@CdnLVEq_max , @CdnLVEq_min , @CdnLVEq_breakpoint ,	
															@CdnLVEq_ST_Weight , @CdnLVEq_LT_Weight , @CdnLVEq_mu_rp , @CdnLVEq_sd_rp ,
														@GloLVEq_max , @GloLVEq_min , @GloLVEq_breakpoint ,	
															@GloLVEq_ST_Weight , @GloLVEq_LT_Weight , @GloLVEq_mu_rp , @GloLVEq_sd_rp ,
														@PE_max , @PE_min , @PE_breakpoint ,	
															@PE_ST_Weight , @PE_LT_Weight , @PE_mu_rp , @PE_sd_rp ,
														@IE_max , @IE_min , @IE_breakpoint ,	
															@IE_ST_Weight , @IE_LT_Weight , @IE_mu_rp , @IE_sd_rp ,
														@RE_max , @RE_min , @RE_breakpoint ,	
															@RE_ST_Weight , @RE_LT_Weight , @RE_mu_rp , @RE_sd_rp 

	exec _3_GenerateAllProjectedNFIReturn 1, '0.075' , 'IN' ,
														0 , 0 , 0 , 
															0 , 0 , 0 , 0 ,
														0 , 0 , 0 , 
															0 , 0 , 0 , 0 ,
														0 , 0 , 0 , 
															0 , 0 , 0 , 0 ,
														0, '-0.4' , '-0.15',	
															0,  0 ,'0.09' , '0.083' ,
														0, '-0.4' , '-0.15',	
															0,  0 ,'0.09' , '0.07' ,
														0 , 0 , 0 , 
															0 , 0 , 0 , 0 ,
														0, '-0.4' , '-0.15',	
															0,  0 ,'0.098' , '0.102' ,
														0, '-0.4' , '-0.15',
															0,  0 ,'0.089' , '0.103' 

*/
END

GO
/****** Object:  StoredProcedure [dbo].[_4_Create_ResultSet]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/01/03>
-- Description:	<Stored procedure for running a full result set for new asset mix>

-- Updated date: <2019/04/09>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <Add the functionality to run ALM on the Accounting Discount Rate Basis>
--				   <Add the floating asset class>
-- =============================================
CREATE PROCEDURE [dbo].[_4_Create_ResultSet] (@MixName as varchar(255), @AssumptionSetNo as int, 
											 @UBond_Weight as float, @LTBond_Weight as float, @Mort_Weight as float, @Corp_Weight as float,
											 @PrDebt_Weight as float, @STCr_Weight as float, @BorrowCst_Weight as float, @CdnEq_Weight as float,
											 @GloEq_Weight as float, @EMEq_Weight as float, @CdnLVEq_Weight as float, @GloLVEq_Weight as float,
											 @PE_Weight as float, @IE_Weight as float, @RE_Weight as float, @FI_Float as float, @NFI_Float as float, @DR_GC_Seed as float)
AS
BEGIN

	SET NOCOUNT ON;
	
	
	/*
	declare @MixName as varchar(255)	= 'Mix1'
	declare @AssumptionSetNo as int		= '1' 
	declare @UBond_Weight as float		= '0.000'
	declare @LTBond_Weight as float		= '0.675'
	declare @Mort_Weight as float		= '0.125'
	declare @Corp_Weight as float		= '0.100'
	declare @PrDebt_Weight as float		= '0.050'
	declare @STCr_Weight as float		= '0.150'
	declare @BorrowCst_Weight as float	= '-0.450'
	declare @CdnEq_Weight as float		= '0.000' 
	declare @GloEq_Weight as float		= '0.000'
	declare @EMEq_Weight as float		= '0.000'
	declare @CdnLVEq_Weight as float	= '0.05' 
	declare @GloLVEq_Weight as float	= '0.05'
	declare @PE_Weight as float			= '0.00'
	declare @IE_Weight as float			= '0.1'
	declare @RE_Weight as float			= '0.15' 
	declare @FI_Float as float			= '0.00'
	declare @NFI_Float as float			= '0.00'
	declare @DR_GC_Seed as float		= '0.054' 
	*/

	--Create the Result Set
	exec Create_ResultSet @AssumptionSetNo, @MixName, @MixName

	--Create the projected portfolio return
	exec GenerateProjectedPortfolioReturn @UBond_Weight, @LTBond_Weight, @Mort_Weight, @Corp_Weight, @PrDebt_Weight, @STCr_Weight, @BorrowCst_Weight, @CdnEq_Weight,
										@GloEq_Weight, @EMEq_Weight, @CdnLVEq_Weight, @GloLVEq_Weight, @PE_Weight, @IE_Weight, @RE_Weight, @FI_Float, @NFI_Float, @MixName, @AssumptionSetNo

	--Create Default Discount Rates
	declare @ResultSetNo as varchar(20) = (select ResultSetNo from ResultSet where AssumptionSetNo = @AssumptionSetNo and MixName = @MixName)
	
	declare @DIS_initial as float = (select distinct PERCENTILE_CONT(0.5) WITHIN GROUP(order by ProjectedReturns) OVER (PARTITION BY t) as Median_ProjectedReturn
									 from AlternativeMixes am
									 where t = 1 and ResultSetNo = @ResultSetNo)

	set @DR_GC_Seed = ISNULL((select case when @DR_GC_Seed = '' then @DIS_initial else @DR_GC_Seed end), @DIS_Initial)
	
	declare @PercentReflected as float = (@UBond_Weight + @LTBond_Weight + @PrDebt_Weight)


	--insert the SOLV discount rate from previous ResultSet
	--insert the ACC discount rate from previous ResultSet
	delete from ALM_I_L_DiscountRate where RateType = 'SOLV' and ResultSetNo = @ResultSetNo
	delete from ALM_I_L_DiscountRate where RateType = 'ACC' and ResultSetNo = @ResultSetNo

	insert into ALM_I_L_DiscountRate (n, t, DiscountRate, ResultSetNo, RateType, CreatedDate, CreatedBy)
	select n, t, DiscountRate, @ResultSetNo, RateType, GETDATE(), ORIGINAL_LOGIN()
	from ALM_I_L_DiscountRate
	where RateType = 'SOLV' and ResultSetNo = (select min(ResultSetNo) from ALM_I_L_DiscountRate dr where exists (select 1 from ResultSet r where r.ResultSetNo = dr.ResultSetNo and r.AssumptionSetNo = @AssumptionSetNo))

	insert into ALM_I_L_DiscountRate (n, t, DiscountRate, ResultSetNo, RateType, CreatedDate, CreatedBy)
	select n, t, DiscountRate, @ResultSetNo, RateType, GETDATE(), ORIGINAL_LOGIN()
	from ALM_I_L_DiscountRate
	where RateType = 'ACC' and ResultSetNo = (select min(ResultSetNo) from ALM_I_L_DiscountRate dr where exists (select 1 from ResultSet r where r.ResultSetNo = dr.ResultSetNo and r.AssumptionSetNo = @AssumptionSetNo))
			
	--User Feedback
	select distinct 'Step 1: Result Set Created' [Status], GETDATE() [StatusDate], 'Assigned ResultSetNo: ' + CAST(@ResultSetNo as varchar) [Next Steps]
		union
	select distinct 'Step 2: Asset Mix Created' [Status], GETDATE() [StatusDate], 'Asset Mix Name: ' + @MixName [Next Steps]
		union 
	select distinct 'Step 3: Asset Mix Linked to Result Set' [Status], GETDATE() [StatusDate], ISNULL(CAST(ResultSetNo as varchar(255)), 'Not Linked To Result Set') [Next Steps]
	from AlternativeMixes am 
	where am.AssumptionSetNo = @AssumptionSetNo and am.MixName = @MixName
		union 
	select distinct 'Step 4: Discount Rate Generated - Going Concern Basis' [Status], GETDATE() [StatusDate], 'Default discount rate seed: ' + CAST(@DR_GC_Seed as varchar) + ', Default % Yield Curve Reflected: ' +  CAST(@PercentReflected as varchar) [Next Steps]
		union 
	select distinct 'Step 5: Discount Rate Generated - Solvency Basis' [Status], GETDATE() [StatusDate], 'Rows Loaded in Discount Rate Table: ' + CAST((select COUNT(*) from ALM_I_L_DiscountRate WHERE RateType = 'SOLV' and ResultSetNo = @ResultSetNo) as varchar) + ' from Result Set: ' + CAST((select min(ResultSetNo) from ALM_I_L_DiscountRate) as varchar) [Next Steps]
		union
	select distinct 'Optional Next Step: Generate Discount Rate with User Parameters' [Status], GETDATE() [StatusDate], 'Next Step - GenerateProjectedDiscountRate' [Next Steps]

	exec GenerateProjectedDiscountRate @DR_GC_Seed, '0.00', '1.00', @PercentReflected, 'GC', @ResultSetNo

	--Check if it is the first Run?
		
	--Run the Liability Values
	exec GenerateProjectedLiability 'GC', @ResultSetNo
	exec GenerateProjectedLiability 'SOLV', @ResultSetNo
	exec GenerateProjectedLiability 'ACC', @ResultSetNo

	--Run the Market value of assets
	if OBJECT_ID('tempdb..#Parameters') IS NOT NULL
    drop table #Parameters

	select ParameterName, ParameterValue, ROW_NUMBER() over (partition by ParameterName order by CreatedDate) Seq
	into #Parameters
	from ParameterHistory
	where ParameterProc like '%GenerateProjectedMVA%'
	order by CreatedDate desc
	
	declare @StartingAssetValue as float = (select ParameterValue from #Parameters where ParameterName = '@StartingAssetValue' and Seq = 1)
	declare @AdminFees as float = (select ParameterValue from #Parameters where ParameterName = '@AdminFees' and Seq = 1)
	declare @AmortPeriod int = (select ParameterValue from #Parameters where ParameterName = '@AmortPeriod' and Seq = 1)
	declare @WUExp as float = (select ParameterValue from #Parameters where ParameterName = '@WUExp' and Seq = 1)

	exec GenerateProjectedMVA_SEPP @StartingAssetValue, @AdminFees, @AmortPeriod, @WUExp, @ResultSetNo
	

	--Testing
	--exec _4_Create_ResultSet @MixName, @AssumptionSetNo, @UBond_Weight, @LTBond_Weight, @Mort_Weight, @Corp_Weight, @PrDebt_Weight, @STCr_Weight, @BorrowCst_Weight, @CdnEq_Weight,
	--						   @GloEq_Weight, @EMEq_Weight, @CdnLVEq_Weight, @GloLVEq_Weight, @PE_Weight, @IE_Weight, @RE_Weight
	--exec _4_Create_ResultSet 'JUSTIN', '1', '0','0.675','0.125','0.10','0.05','0.15','-0.45','0','0','0','0.05','0.05','0','0.10','0.15'

END
GO
/****** Object:  StoredProcedure [dbo].[_6_MVA_Liab_Pre_work]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/01/03>
-- Description:	<Stored procedure for creating FI (fixed-interest) assumptions>
-- =============================================
CREATE PROCEDURE [dbo].[_6_MVA_Liab_Pre_work] (@ActiveDecline as varchar(1000), @AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;
	
	--Calculate the Normal Cost/Future Service Cost Increase
	exec GenerateProjectedNCFSChange @ActiveDecline, @AssumptionSetNo
	
	--Do the calculation Roll-out for the Liability Projection
	exec GenerateProjectedLiability_Initial  @AssumptionSetNo

	--Testing
	--exec _6_MVA_Liab_Pre_work @ActiveDecline, @AssumptionSetNo 
	--exec _6_MVA_Liab_Pre_work '-0.02', 1

END


GO
/****** Object:  StoredProcedure [dbo].[Create_AssumptionSet]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/02/13>
-- Description:	<Stored procedure for creating Assumption Set>

-- Updated date: <2019/04/09>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <Add the ability to copy the economic indicators from a previous assumption set>
-- =============================================
CREATE PROCEDURE [dbo].[Create_AssumptionSet] ( @AssumptionDescript as varchar(1000), @DuplicateEconomicIndicators as varchar(3))
AS
BEGIN

	SET NOCOUNT ON;

	/*
	declare @AssumptionDescript as varchar(1000) = 'Initial Assumptions'
	declare @DuplicateEconomicIndicators as varchar(3) = 'YES'
	*/

	declare @UserAssumptionSetNo as int = (select ISNULL(max(AssumptionSetNo),0) + 1 from AssumptionSet )
		
	insert into AssumptionSet (AssumptionSetNo, AssumptionSetDescript, CreatedDate, CreatedBy)
    select @UserAssumptionSetNo, @AssumptionDescript, GETDATE(), ORIGINAL_LOGIN()

	;with cte 
	as (
		select AssumptionSetDescript, CreatedDate, ROW_NUMBER() over (partition by AssumptionSetDescript, CreatedDate order by CreatedDate) Seq
		from AssumptionSet 
		)
	delete from cte where Seq > 1
	
	if @DuplicateEconomicIndicators = 'YES'
	begin
				
		--Inflation
		delete from FI_I_Infl where AssumptionSetNo = @UserAssumptionSetNo
		delete from ParameterHistory where ParameterProc = 'GenerateProjectedInflation' and AssumptionSetNo =  @UserAssumptionSetNo
		
		insert into FI_I_Infl (n, t, Inflation, AssumptionSetNo, CreatedDate, CreatedBy)
		select n, t, Inflation, @UserAssumptionSetNo, GETDATE(), ORIGINAL_LOGIN()
		from FI_I_Infl
		where AssumptionSetNo = 1

		insert into ParameterHistory (AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
		select @UserAssumptionSetNo, ParameterProc, ParameterName, ParameterValue, GETDATE(), ORIGINAL_LOGIN()
		from ParameterHistory
		where ParameterProc = 'GenerateProjectedInflation'
			and AssumptionSetNo = 1

		--Real Return
		delete from FI_I_RealReturn where AssumptionSetNo = @UserAssumptionSetNo
		delete from ParameterHistory where ParameterProc = 'GenerateProjectedRealReturn' and AssumptionSetNo =  @UserAssumptionSetNo

		insert into FI_I_RealReturn (n, t, RealReturn, AssumptionSetNo, CreatedDate, CreatedBy)
		select n, t, RealReturn, @UserAssumptionSetNo, GETDATE(), ORIGINAL_LOGIN()
		from FI_I_RealReturn
		where AssumptionSetNo = 1

		insert into ParameterHistory (AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
		select @UserAssumptionSetNo, ParameterProc, ParameterName, ParameterValue, GETDATE(), ORIGINAL_LOGIN()
		from ParameterHistory
		where ParameterProc = 'GenerateProjectedRealReturn'
			and AssumptionSetNo = 1
		
		--Short Term Return
		delete from FI_I_ShortTermReturn where AssumptionSetNo = @UserAssumptionSetNo

		insert into FI_I_ShortTermReturn (n, t, ST, AssumptionSetNo, CreatedDate, CreatedBy)
		select n, t, ST, @UserAssumptionSetNo, GETDATE(), ORIGINAL_LOGIN()
		from FI_I_ShortTermReturn
		where AssumptionSetNo = 1

		--Term Premium
		delete from FI_I_TermPremium where AssumptionSetNo = @UserAssumptionSetNo
		delete from ParameterHistory where ParameterProc = 'GenerateProjectedTermPremium' and AssumptionSetNo =  @UserAssumptionSetNo
		
		insert into FI_I_TermPremium (n, t, TermPremium, AssumptionSetNo, CreatedDate, CreatedBy)
		select n, t, TermPremium, @UserAssumptionSetNo, GETDATE(), ORIGINAL_LOGIN()
		from FI_I_TermPremium
		where AssumptionSetNo = 1

		insert into ParameterHistory (AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
		select @UserAssumptionSetNo, ParameterProc, ParameterName, ParameterValue, GETDATE(), ORIGINAL_LOGIN()
		from ParameterHistory
		where ParameterProc = 'GenerateProjectedTermPremium'
			and AssumptionSetNo = 1

		--Long Term Return
		delete from FI_I_LongTermReturn where AssumptionSetNo = @UserAssumptionSetNo
		
		insert into FI_I_LongTermReturn (n, t, LT, AssumptionSetNo, CreatedDate, CreatedBy)
		select n, t, LT, @UserAssumptionSetNo, GETDATE(), ORIGINAL_LOGIN()
		from FI_I_LongTermReturn
		where AssumptionSetNo = 1

		--Salary Increases
		delete from ALM_Salary_Increase where AssumptionSetNo = @UserAssumptionSetNo
		
		insert into ALM_Salary_Increase (n, t, Inflation, Salary_Increase, AssumptionSetNo, CreatedDate, CreatedBy)
		select n, t, Inflation, Salary_Increase, @UserAssumptionSetNo, GETDATE(), ORIGINAL_LOGIN()
		from ALM_Salary_Increase
		where AssumptionSetNo = 1

		--Credit Spread
		delete from FI_I_CreditSpread where AssumptionSetNo = @UserAssumptionSetNo
		delete from ParameterHistory where ParameterProc = 'GenerateProjectedCreditSpread' and AssumptionSetNo =  @UserAssumptionSetNo
		
		insert into FI_I_CreditSpread (n, t, CreditSpread, AssumptionSetNo, CreatedDate, CreatedBy)
		select n, t, CreditSpread, @UserAssumptionSetNo, GETDATE(), ORIGINAL_LOGIN()
		from FI_I_CreditSpread
		where AssumptionSetNo = 1

		insert into ParameterHistory (AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
		select @UserAssumptionSetNo, ParameterProc, ParameterName, ParameterValue, GETDATE(), ORIGINAL_LOGIN()
		from ParameterHistory
		where ParameterProc = 'GenerateProjectedCreditSpread'
			and AssumptionSetNo = 1

		--Correlation Matrix
		delete from NFI_R_Corr_Final where AssumptionSetNo = @UserAssumptionSetNo
		
		insert into NFI_R_Corr_Final (AssumptionSetNo, n, t, CdnEq, GloEq, EMEq, CdnLVEq, GloLVEq, PE, IE, RE)
		select @UserAssumptionSetNo, n, t, CdnEq, GloEq, EMEq, CdnLVEq, GloLVEq, PE, IE, RE
		from NFI_R_Corr_Final rco
		where AssumptionSetNo = 1

		--Stress Regime
		delete from FI_R_StressReg where AssumptionSetNo = @UserAssumptionSetNo

		insert into FI_R_StressReg (n, AssumptionSetNo, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
										[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
										[21], [22], [23], [24], [25], [26], [27], [28], [29], [30])

		select  n, @UserAssumptionSetNo, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
										[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
										[21], [22], [23], [24], [25], [26], [27], [28], [29], [30]
		from FI_R_StressReg
		where AssumptionSetNo = 1

		--Credit Premium Random Numbers
		delete from FI_R_CredPrem where AssumptionSetNo = @UserAssumptionSetNo

		insert into FI_R_CredPrem (n, AssumptionSetNo, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
										[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
										[21], [22], [23], [24], [25], [26], [27], [28], [29], [30])
		select n, @UserAssumptionSetNo, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
										[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
										[21], [22], [23], [24], [25], [26], [27], [28], [29], [30]
		from FI_R_CredPrem
		where AssumptionSetNo = 1

		--Liability Cashflows
		delete from ALM_I_L_CashFlow where AssumptionSetNo = @UserAssumptionSetNo

		insert into ALM_I_L_CashFlow (AssumptionSetNo, t, Year, Accrued, NormalCost, FutureService, Contributions)
		select @UserAssumptionSetNo, t, Year, Accrued, NormalCost, FutureService, Contributions
		from ALM_I_L_CashFlow
		where AssumptionSetNo = 1

	end

	select distinct 'Done' [Status], GETDATE() [StatusDate], 'Next Step - Step 2' [Next Steps], 'Your assumption set number is ' +CAST(@UserAssumptionSetNo as varchar)+ '.' [Output]
		union
	select distinct 'Done' [Status], GETDATE() [StatusDate], 'Next Step - Step 2' [Next Steps], 'Your assumption set number is ' +CAST(@UserAssumptionSetNo as varchar)+ '.' [Output]

	--Test
	--exec Create_AssumptionSet @AssumptionDescription
	--exec Create_AssumptionSet 'Current Assumptions', 'No'
	--exec Create_AssumptionSet 'Initial Assumptions', 'Yes'

	--Clear Assumption Set
	/*
	declare @UserAssumptionSetNo as int = 3
		
	delete from AssumptionSet where AssumptionSetNo = @UserAssumptionSetNo
				
	delete from ParameterHistory where ParameterProc = 'GenerateProjectedTermPremium' and AssumptionSetNo =  @UserAssumptionSetNo
	delete from ParameterHistory where ParameterProc = 'GenerateProjectedInflation' and AssumptionSetNo =  @UserAssumptionSetNo
	delete from ParameterHistory where ParameterProc = 'GenerateProjectedRealReturn' and AssumptionSetNo =  @UserAssumptionSetNo

	delete from FI_I_Infl where AssumptionSetNo = @UserAssumptionSetNo
	delete from FI_I_RealReturn where AssumptionSetNo = @UserAssumptionSetNo
	delete from FI_I_ShortTermReturn where AssumptionSetNo = @UserAssumptionSetNo
	delete from FI_I_TermPremium where AssumptionSetNo = @UserAssumptionSetNo
	delete from FI_I_LongTermReturn where AssumptionSetNo = @UserAssumptionSetNo
	delete from FI_I_CreditSpread where AssumptionSetNo = @UserAssumptionSetNo
	delete from NFI_R_Corr_Final where AssumptionSetNo = @UserAssumptionSetNo
	delete from FI_R_StressReg where AssumptionSetNo = @UserAssumptionSetNo
	delete from FI_R_CredPrem where AssumptionSetNo = @UserAssumptionSetNo
	*/

END
GO
/****** Object:  StoredProcedure [dbo].[Create_FI_Assumptions]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/01/03>
-- Description:	<Stored procedure for creating FI (fixed-interest) assumptions>

-- Updated date: <2019/04/09>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <Setting up the variables for the Fixed interest assumptions before Borrowing Cost Changes>
-- =============================================
CREATE PROCEDURE [dbo].[Create_FI_Assumptions] (@AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;
    
  --exec GenerateProjectedInflation @Inf_tmin1, @w, @Inf_LT, @sd_e, @mu_e, @AssumptionSetNo
	exec GenerateProjectedInflation '0.019', '0.85', '0.02', '0.005', '0.00', @AssumptionSetNo

  --exec GenerateProjectedRealReturn @RR_ST_tmin1, @w, @LT_RR_ST, @sd_e, @mu_e
	exec GenerateProjectedRealReturn '0.0082', '0.9', '0.0122', '0.002', '0.00', @AssumptionSetNo

  --exec GenerateProjectedTermPremium @TP_tmin1, @w, @LT_TP, @sd_e, @mu_e, @AssumptionSetNo
	exec GenerateProjectedTermPremium '0.0046', '0.9', '0.0034', '0.002', '0.00', @AssumptionSetNo

  --exec GenerateProjectedShortTermReturns @AssumptionSetNo
	exec GenerateProjectedShortTermReturn @AssumptionSetNo

  --exec GenerateProjectedLongTermReturns @AssumptionSetNo
	exec GenerateProjectedLongTermReturn @AssumptionSetNo

  --exec GenerateProjectedSalaryIncreases @AssumptionSetNo
	exec GenerateProjectedSalaryIncreases @AssumptionSetNo
	
  --exec GenerateProjectedCreditSpread @CS_tmin1, @w, @CS_LT, @sd_e, @mu_e, @AssumptionSetNo
	exec GenerateProjectedCreditSpread '0.0082', '0.90', '0.01', '0.002', '0.00', 1

  --exec GenerateProjectedFIReturn @ST, @LT, @CS, @ST_Dur, @LT_Dur, @CS_Dur, @E_alpha, @sd_e, @max_loss, @prob_sr, @ReturnType, @AssumptionSetNo
	/*
	--Commented out 2019-04-11 replaced with code for AA Bonds
	exec GenerateProjectedFIReturn '0.8', '0.2', '0.0', '2', '14', '0', '0.005', '0.006', '0.1' , '0.075', 'UBond', @AssumptionSetNo
	*/
			
	exec GenerateProjectedFIReturn '0', '1', '1', '7.5', '20', '20', '-0.002', '0.003', '0.1' , '0', 'UBond', @AssumptionSetNo

	exec GenerateProjectedFIReturn '0', '1', '0.0', '7.5', '28', '0', '0.005', '0.0075', '0.1' , '0', 'LTBond', @AssumptionSetNo
	exec GenerateProjectedFIReturn '0.6', '0.4', '0.0', '7.5', '14.5', '0', '0.0235', '0.015', '0.25' , '0.075', 'PrDebt', @AssumptionSetNo
	exec GenerateProjectedFIReturn '0.2', '0', '0.0', '7.5', '14.5', '0', '0.082', '0.005', '0.35' , '0.075', 'Corp', @AssumptionSetNo
	exec GenerateProjectedFIReturn '1', '0', '0.0', '7.5', '14.5', '0', '0.0075', '0.004', '0.05' , '0.075', 'STCr', @AssumptionSetNo
	exec GenerateProjectedFIReturn '0.5', '0', '0.0', '7.5', '14.5', '0', '0.031', '0.024', '0.1' , '0.075', 'Mort', @AssumptionSetNo
	exec GenerateProjectedFIReturn '0.75', '0', '0.0', '0', '14.5', '0', '0', '0.009', '0.1' , '0', 'BorrowCst', @AssumptionSetNo

	--Liability Driven Investment (LDI)
	exec GenerateProjectedFIReturn '0', '1', '0.0', '7.5', '20', '0', '0.005', '0.0075', '0.1' , '0', 'Float', @AssumptionSetNo

	--Testing
	--exec Create_FI_Assumptions @AssumptionSetNo
	--exec Create_FI_Assumptions 1

END
GO
/****** Object:  StoredProcedure [dbo].[Create_NFI_Assumptions]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/01/03>
-- Description:	<Stored procedure for creating NFI (Non-fixed-interest) assumptions>

-- Updated date: <2019/04/09>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <Setting up the variables for the Non-Fixed interest assumptions>
-- =============================================
CREATE PROCEDURE [dbo].[Create_NFI_Assumptions] (@AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;
    
  --exec Update_NFI_RCorr @AssumptionSetNo

  --exec GenerateNFITriangleDistribution @max, @min, @breakpoint, @ReturnType, @AssumptionSetNo
	exec GenerateNFITriangleDistribution '0.0', '-0.5', '-0.2', 'CdnEq', @AssumptionSetNo --From UCC plan
	exec GenerateNFITriangleDistribution '0.0', '-0.5', '-0.2', 'GloEq', @AssumptionSetNo --From UCC plan
	exec GenerateNFITriangleDistribution '0.0', '-0.65', '-0.2', 'EMEq', @AssumptionSetNo --From UCC plan
	exec GenerateNFITriangleDistribution '0.0', '-0.6', '-0.2', 'PE', @AssumptionSetNo	  --From UCC plan
	
	exec GenerateNFITriangleDistribution '0.0', '-0.4', '-0.15', 'CdnLVEq', @AssumptionSetNo
	exec GenerateNFITriangleDistribution '0.0', '-0.4', '-0.15', 'GloLVEq', @AssumptionSetNo
	exec GenerateNFITriangleDistribution '0.0', '-0.4', '-0.15', 'IE', @AssumptionSetNo
	exec GenerateNFITriangleDistribution '0.0', '-0.4', '-0.15', 'RE', @AssumptionSetNo
	
	
	--exec GenerateProjectedNFIReturn @ST_Weight, @LT_Weight, @mu_rp, @sd_rp, @prob_sr, @ReturnType, @AssumptionSetNo
	exec GenerateProjectedNFIReturn '0.65', '0.35', '0.073', '0.174', '0.075', 'CdnEq', @AssumptionSetNo, 'IN'  --From UCC plan
	exec GenerateProjectedNFIReturn '0.65', '0.35', '0.0695', '0.151', '0.075', 'GloEq', @AssumptionSetNo, 'IN' --From UCC plan
	exec GenerateProjectedNFIReturn '0.65', '0.35', '0.10', '0.233', '0.075', 'EMEq', @AssumptionSetNo, 'IN'    --From UCC plan
	exec GenerateProjectedNFIReturn '0.65', '0.35', '0.087', '0.177', '0.075', 'PE', @AssumptionSetNo, 'IN'	 --From UCC plan
		
	exec GenerateProjectedNFIReturn '0', '0', '0.090', '0.083', '0.075', 'CdnLVEq', @AssumptionSetNo, 'IN'
	exec GenerateProjectedNFIReturn '0', '0', '0.090', '0.07', '0.075', 'GloLVEq', @AssumptionSetNo, 'IN'
	exec GenerateProjectedNFIReturn '0', '0', '0.098', '0.102', '0.075', 'IE', @AssumptionSetNo, 'IN'
	exec GenerateProjectedNFIReturn '0', '0', '0.089', '0.103', '0.075', 'RE', @AssumptionSetNo, 'IN'

	--Testing
	--exec Create_NFI_Assumptions @AssumptionSetNo
	--exec Create_NFI_Assumptions 2

	/*
	--For the additional IE(VA) asset class, I generated the results using the below in the testing database and transferred the results.

	exec GenerateProjectedNFIReturn '0', '0', '0.098', '0.102', '0.075', 'IE', @AssumptionSetNo, 'IN'

	insert into NFI_AC_Float (n, t, Normal, Stressed, Combined, AssumptionSetNo, CreatedDate, CreatedBy)
	select n, t, Normal, Stressed, Combined, 2, GetDate(), ORIGINAL_LOGIN() 
	from PBI_ALM_TEST.dbo.NFI_AC_IE
	*/
	
	DROP INDEX idx_AssetClassReturn on AssetClassReturn

	TRUNCATE TABLE AssetClassReturn

	INSERT INTO AssetClassReturn (n, t, Normal, Stressed, Combined, AssetClass, AssetGroup, AssumptionSetno, CreatedDate, CreatedBy)
	SELECT n, t, Normal, Stressed, Combined, [Asset Class], [Asset Group], AssumptionSetno, CreatedDate, CreatedBy
	FROM vw_AC_Returns vac
	ORDER BY [Asset Class], AssumptionSetno, n, t

	CREATE NONCLUSTERED INDEX idx_AssetClassReturn on AssetClassReturn(n, t, AssumptionSetNo, AssetClass)

	update acr
	SET Cumulative = ISNULL(dbo.FV_Schedule_AssetClass(t, n, AssetClass, 1),1)
	FROM AssetClassReturn acr
	where Cumulative is NULL

	update acr
	SET CumulativeAnnualized = POWER((ISNULL(Cumulative,1)), (1 / (t * 1.0))) - 1 
	FROM AssetClassReturn acr
	where CumulativeAnnualized is NULL
		and Cumulative > 0

END
GO
/****** Object:  StoredProcedure [dbo].[Create_ResultSet]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/02/13>
-- Description:	<Stored procedure for creating ResultSet>

-- Updated date: <2019/04/09>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <Add the Accounting Discount Rate Basis to the result link table>
-- =============================================
CREATE PROCEDURE [dbo].[Create_ResultSet] (@AssumptionSetNo as int, @MixName as varchar(255), @ResultSetDescript as varchar(255))
AS
BEGIN

	declare @UserResultSetNo as int = (select ISNULL(max(ResultSetNo),0) + 1 from ResultSet)

	SET NOCOUNT ON;
		  
	insert into ResultSet(ResultSetNo, AssumptionSetNo, MixName, ResultSetDescript, CreatedDate, CreatedBy)
	select @UserResultSetNo, @AssumptionSetNo, @MixName, @ResultSetDescript, GetDate(), ORIGINAL_LOGIN()
	
	truncate table ResultSetLink

	insert into ResultSetLink(n, t, ResultSetNo, AssumptionSetNo, MixName, RateType, BasisType, ResultType, LinkKey, ResultLinkKey, ResultLinkKey2)
	select t1.n, t2.n [t], ResultSetNo, AssumptionSetNo, MixName, 'GC' RateType, 'Going Concern' BasisType,
	MixName + ':GC' ResultType, 
	 CAST(t2.n as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar)  [LinkKey],
     CAST(t2.n as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar) + '#' +  CAST(ResultSetNo as varchar) + '#' + 'GC' [ResultLinkKey],
     CAST(t2.n as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar) + '#' +  CAST(ResultSetNo as varchar) [ResultLinkKey2]
	from dbo.Tally t1
	inner join dbo.Tally t2 on 1 = 1 
	inner join dbo.ResultSet t on 1 = 1
	where t1.n <= 2000 and t2.n < 30

		union
	select t1.n, t2.n [t], ResultSetNo, AssumptionSetNo, MixName, 'SOLV' RateType, 'Solvency' BasisType,
		MixName + ':SOLV' ResultType, 
		 CAST(t2.n as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar)  [LinkKey],
		 CAST(t2.n as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar) + '#' +  CAST(ResultSetNo as varchar) + '#' + 'SOLV' [ResultLinkKey],
		 CAST(t2.n as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar) + '#' +  CAST(ResultSetNo as varchar) [ResultLinkKey2]
	from dbo.Tally t1
	inner join dbo.Tally t2 on 1 = 1 
	inner join dbo.ResultSet t on 1 = 1
	where t1.n <= 2000 and t2.n < 30

			union
	select t1.n, t2.n [t], ResultSetNo, AssumptionSetNo, MixName, 'ACC' RateType, 'Accounting' BasisType,
		MixName + ':ACC' ResultType, 
		 CAST(t2.n as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar)  [LinkKey],
		 CAST(t2.n as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar) + '#' +  CAST(ResultSetNo as varchar) + '#' + 'ACC' [ResultLinkKey],
		 CAST(t2.n as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar) + '#' +  CAST(ResultSetNo as varchar) [ResultLinkKey2]
	from dbo.Tally t1
	inner join dbo.Tally t2 on 1 = 1 
	inner join dbo.ResultSet t on 1 = 1
	where t1.n <= 2000 and t2.n < 30


	--Update the ResultSetNo
	update am
	set ResultSetNo = r.ResultSetNo
	from AlternativeMixes am
	inner join ResultSet r on r.AssumptionSetNo = am.AssumptionSetNo and r.Mixname = am.Mixname
	where am.AssumptionSetNo = @AssumptionSetNo and am.MixName = @MixName
	
	;with cte 
	as (
		select MixName, AssumptionSetNo, ROW_NUMBER() over (partition by MixName, AssumptionSetNo order by CreatedDate) Seq
		from ResultSet rs
		)
	delete from cte where Seq > 1

	/*
	--User Feedback
	select distinct 'Done' [Status], GETDATE() [StatusDate], 'Next Step - Generate Projected Discount Rate' [Next Steps], 'Your result set number is' +CAST(@UserResultSetNo as varchar)+ '' [Output]

	--Testing
	exec Create_ResultSet @AssumptionSetNo, @MixName, @ResultSetDescript
	*/
	
END
GO
/****** Object:  StoredProcedure [dbo].[Empty_Database]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/02/13>
-- Description:	<Stored procedure for clearing the database>
-- =============================================
CREATE PROCEDURE [dbo].[Empty_Database] ( @DeleteParameters as varchar(1000), @DeleteInputs as varchar(1000), @DeleteTrailTables as varchar(1000))
AS
BEGIN

	SET NOCOUNT ON;

	if @DeleteTrailTables = 'YES'
	begin

		truncate table trl.FI_AC_UBond
		truncate table trl.FI_AC_LTBond
		truncate table trl.FI_AC_Corp
		truncate table trl.FI_AC_PrDebt
		truncate table trl.FI_AC_STCr
		truncate table trl.FI_AC_Mort
		truncate table trl.FI_AC_BorrowCst
		truncate table trl.FI_AC_Float

		truncate table trl.NFI_I_TriangleDistribution
		truncate table trl.NFI_AC_CdnEq
		truncate table trl.NFI_AC_GloEq
		truncate table trl.NFI_AC_EMEq
		truncate table trl.NFI_AC_CdnLVEq
		truncate table trl.NFI_AC_GloLVEq
		truncate table trl.NFI_AC_RE
		truncate table trl.NFI_AC_IE
		truncate table trl.NFI_AC_PE

		truncate table trl.AlternativeMixes

		truncate table trl.ALM_R_A_ProjectedBenefitPayments
		truncate table trl.ALM_R_A_ProjectedContributions
		truncate table trl.ALM_R_A_ProjectedCashFlow

		truncate table trl.ALM_R_A_ProjectedMVA
		
		truncate table trl.ParameterHistory
	end

	if @DeleteParameters = 'YES'
	begin
		truncate table AssumptionSet

		--Economic Inputs
		truncate table FI_I_Infl
		truncate table FI_I_RealReturn
		truncate table FI_I_TermPremium
		truncate table FI_I_ShortTermReturn
		truncate table FI_I_LongTermReturn
		truncate table FI_I_CreditSpread
		
		--Fixed Income Asset Classes
		truncate table FI_AC_UBond
		truncate table FI_AC_LTBond
		truncate table FI_AC_Corp
		truncate table FI_AC_PrDebt
		truncate table FI_AC_STCr
		truncate table FI_AC_Mort
		truncate table FI_AC_BorrowCst
		truncate table FI_AC_Float
		
		--Non-fixed income Asset Classes
		truncate table NFI_I_TriangleDistribution
		truncate table NFI_AC_CdnEq
		truncate table NFI_AC_GloEq
		truncate table NFI_AC_EMEq
		truncate table NFI_AC_CdnLVEq
		truncate table NFI_AC_GloLVEq
		truncate table NFI_AC_PE
		truncate table NFI_AC_IE
		truncate table NFI_AC_RE
		
		--ResultSet
		truncate table ResultSet
		truncate table ResultSetLink
		
		--Portfolio Returns
		truncate table AlternativeMixes
		
		--ALM Modelling Assumptions
		truncate table ALM_I_L_DiscountRate
		truncate table ALM_I_NC_FS_Change
		truncate table ALM_Salary_Increase
		truncate table ALM_I_COLA

		--Temp tables that assist in calculations
		truncate table tmp.FV_Schedule_NC_FS
		truncate table tmp.FV_Schedule_CF
		truncate table tmp.ALM_R_L_AdjustedLiability
		truncate table tmp.ALM_R_CF_SF_DefPmt
		truncate table tmp.ALM_R_CF_NormalCost

		--Liability Values
		truncate table ALM_R_L_ProjectedLiability
		
		--Asset Values and Cash Flow
		truncate table ALM_R_A_ProjectedBenefitPayments
		truncate table ALM_R_A_ProjectedContributions
		truncate table ALM_R_A_ProjectedCashFlow
		truncate table ALM_R_A_ProjectedMVA
		
		--Worked Results
		truncate table ALM_R_FR_Volatility

		--Other tables
		truncate table ParameterHistory
		
	end

	if @DeleteInputs = 'YES'
	begin
		--User imported tables
		--Correlations Between Asset Classes (After Cholesky Decomposition)
		truncate table NFI_R_Corr
		truncate table NFI_R_NCorr
		truncate table NFI_R_Corr_Final
		
		truncate table ALM_I_L_CashFlow
	end

	--Not Deleted
	--dmRefCodes
	--FI_R_CredPrem
	--FI_R_Infl
	--FI_R_RealReturn
	--FI_R_StressReg
	--FI_R_TermPremium

	--NFI_R_Corr
	--NFI_R_Corr_Final
	--NFI_R_NCorr

	/*
	Test
	exec Empty_Database @DeleteParameters @DeleteInputs
	exec Empty_Database 'YES', 'NO'
	*/

END
GO
/****** Object:  StoredProcedure [dbo].[Empty_ResultSet]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/02/13>
-- Description:	<Stored procedure for creating ResultSet>
-- =============================================
CREATE PROCEDURE [dbo].[Empty_ResultSet] ( @ResultSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;
					
	--ResultSet
	delete from ResultSet where ResultSetNo = @ResultSetNo
	delete from ResultSetLink where ResultSetNo = @ResultSetNo
		
	--Portfolio Returns
	delete from AlternativeMixes where ResultSetNo = @ResultSetNo
		
	--ALM Modelling Assumptions
	delete from ALM_I_L_DiscountRate where ResultSetNo = @ResultSetNo
		
	--Temp tables that assist in calculations
	delete from tmp.ALM_R_CF_SF_DefPmt where ResultSetNo = @ResultSetNo
	delete from tmp.ALM_R_CF_NormalCost where ResultSetNo = @ResultSetNo



	--Liability Values
	delete from ALM_R_L_ProjectedLiability where ResultSetNo = @ResultSetNo
		
	--Asset Values and Cash Flow
	delete from ALM_R_A_ProjectedBenefitPayments where ResultSetNo = @ResultSetNo
	delete from ALM_R_A_ProjectedContributions where ResultSetNo = @ResultSetNo
	delete from ALM_R_A_ProjectedCashFlow where ResultSetNo = @ResultSetNo
	delete from ALM_R_A_ProjectedMVA where ResultSetNo = @ResultSetNo
				
	--Worked Results
	delete from ALM_R_FR_Volatility where ResultSetNo = @ResultSetNo

	select distinct 'Result Set ' + CAST(@ResultSetNo as varchar) + ' Cleared' [Status], GETDATE() [StatusDate], 'Redo Result Set?' [Next Steps]

	--exec Empty_ResultSet 8

END
GO
/****** Object:  StoredProcedure [dbo].[GenerateNFITriangleDistribution]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/01/02>
-- Description:	<Stored procedure for creating projecting future term premium (TP) numbers>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateNFITriangleDistribution] (@max as float, @min as float, @breakpoint as float, @ReturnType as varchar(1000), @AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;
	--END QUERY IF EMPTY
	if @max = 0 and @min = 0 and @breakpoint = 0 
		begin	
			return
		end
	else 
		--Parameters
		/*
		declare @max as float = 0
		declare @min as float = -0.5
		declare @breakpoint as float = -0.2
		declare @ReturnType as varchar(255) = 'CdnEq'
		declare @AssumptionSetNo as int = 1
		*/
	
		declare @limitA as float = (@max - @min) * (@breakpoint - @min)
		declare @limitB as float = (@max - @min) * (@max - @breakpoint)
		declare @ParameterProc as varchar(255) = 'GenerateNFITriangleDistribution' + ':' + @ReturnType
		declare @sql as nvarchar(max)
	
		--Write to trail table (if exists)
		set @sql = 'insert into trl.NFI_I_TriangleDistribution (n, t, ReturnType, TriangleDistValue, AssumptionSetNo, OriginalCreatedDate, OriginalCreatedBy, TrailCreatedDate, TrailCreatedBy, SourceKey)
					select n, t, ReturnType, TriangleDistValue, AssumptionSetNo, CreatedDate [OriginalCreatedDate], CreatedBy [OriginalCreatedBy],
					GETDATE(), ORIGINAL_LOGIN(), TriangleDistributionKey
					from NFI_I_TriangleDistribution
					where AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + '
					and ReturnType = ''' + @ReturnType + ''' 
					order by t, n'

		execute sp_executesql @sql

		--Delete from table (if exists)
		delete from NFI_I_TriangleDistribution where AssumptionSetNo = @AssumptionSetNo and ReturnType = @ReturnType
		delete from ParameterHistory where AssumptionSetNo = @AssumptionSetNo and ParameterProc = @ParameterProc

		--Store the parameter values for future reference
		insert into ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
		select @AssumptionSetNo, @ParameterProc, '@max', @max, GetDate(), ORIGINAL_LOGIN()
			union
		select @AssumptionSetNo, @ParameterProc, '@min', @min, GetDate(), ORIGINAL_LOGIN()
			union
		select @AssumptionSetNo, @ParameterProc, '@breakpoint', @breakpoint, GetDate(), ORIGINAL_LOGIN()
		
		--Create values
		insert into NFI_I_TriangleDistribution(n, t, ReturnType, TriangleDistValue, AssumptionSetNo, CreatedDate, CreatedBy)
		select fin.n, fin.t, @ReturnType ReturnType,
			CASE WHEN fin.CorrValue < (POWER((@breakpoint - @min),2) / @limitA) 
				 THEN (POWER((fin.CorrValue * @limitA), 0.5) + @min) 
				 ELSE (@max - POWER(((1 - fin.CorrValue) * @limitB),0.5)) END TriangleDistValue,
				 @AssumptionSetNo,
				 GETDATE() CreatedDate,
				 ORIGINAL_LOGIN() CreatedBy
		from vw_NFI_R_Corr_Final_Unpvt fin
		where fin.AssumptionSetNo = @AssumptionSetNo
			and fin.ReturnType = @ReturnType
		--User Feedback
		select distinct 'Done' [Status], GETDATE() [StatusDate], 'If you have finished entering all 8 triangle distributions. Next Step - Generate Projected Non-Fixed Income Returns' [Next Steps]
			
		/*
		--Test
		select *
		from NFI_I_TriangleDistribution
		where ReturnType = 'GloEq'
		order by TriangleDistributionKey
		*/

		--exec GenerateNFITriangleDistribution @max, @min, @breakpoint, @ReturnType, @AssumptionSetNo
		--exec GenerateNFITriangleDistribution '0.0', '-0.5', '-0.2', 'CdnEq', 1
		--exec GenerateNFITriangleDistribution '0.0', '0.0', '0.0', 'CdnEq', 1	
END

GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedCreditSpread]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/04/09>
-- Description:	<Stored procedure for creating projecting future credit spread>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedCreditSpread] (@CS_tmin1 as varchar(1000), @w as varchar(1000), @CS_LT as varchar(1000),@sd_e as varchar(1000), @mu_e as varchar(1000), @AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;
    
	--CIA yield over Solvency Yield - formula to project Credit Spread:    CS(t) = [ CS(t-1) x w ] + CS_LT x (1-w) ] + e
	--NORMINV(p, mu, sigma) = mu + sigma * NORMSINV(p)
	--Parameters
	/*
	set @CS_tmin1 = '0.0082'
	set @w = '0.9'
	set @CS_LT = '0.01'
	set @sd_e = '0.002'
	set @mu_e = '0'
	*/

	declare @n as int = 1
	declare @sql as nvarchar(max)

	--Write to trail table (if exists)
	--TODO

	--Delete from table (if exists)
	delete from FI_I_CreditSpread where AssumptionSetNo = @AssumptionSetNo
	delete from ParameterHistory where AssumptionSetNo = @AssumptionSetNo and ParameterProc = 'GenerateProjectedCreditSpread'

	--Store the parameter values for future reference
	insert into ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
	select @AssumptionSetNo, 'GenerateProjectedCreditSpread', '@CS_tmin1', @CS_tmin1, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, 'GenerateProjectedCreditSpread', '@w', @w, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, 'GenerateProjectedCreditSpread', '@CS_LT', @CS_LT, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, 'GenerateProjectedCreditSpread', '@sd_e', @sd_e, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, 'GenerateProjectedCreditSpread', '@mu_e', @mu_e, GetDate(), ORIGINAL_LOGIN()

	--Create values
	While @n <= 30
	Begin
	
		declare @cur varchar(1000) = CAST(@n as varchar(1000))
		declare @prev varchar(1000) = CAST(@n - 1 as varchar(1000))

		if @n = 1 
		begin
			set @sql = 'insert into FI_I_CreditSpread(n, t, CreditSpread, AssumptionSetNo)
						select r.n, ' + @cur + ',' + @CS_tmin1 + ' * ' + @w + ' + ' +  @CS_LT +' * (1 - ' + @w + ') + (' + @mu_e + ' + (' + @sd_e + '* Utils.dbo.normsinv(1 - r.['+ @cur + ']))), ' + CAST(@AssumptionSetNo as varchar) + '
						from FI_R_CredPrem r
						where r.AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + '
						order by r.n'
		end
		else
		begin
			set @sql ='insert into FI_I_CreditSpread(n, t, CreditSpread, AssumptionSetNo)
					   select r.n, ' + @Cur + ', i.CreditSpread * ' + @w + ' + ' +  @CS_LT +' * (1 - ' + @w + ') + (' + @mu_e + ' + (' + @sd_e + '* Utils.dbo.normsinv(1 - r.['+ @cur + ']))), ' + CAST(@AssumptionSetNo as varchar) + '
					   from FI_R_CredPrem r
					   inner join FI_I_CreditSpread i on r.AssumptionSetNo = i.AssumptionSetNo and i.n = r.n and i.t = ' + @prev + '
					   where r.AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + '
					   order by r.n'
		end
	
		execute sp_executesql @sql
	
		--roll to the next value
		set @n = @n + 1
	End

	--Update metadata
	update i
	set i.CreatedDate = GETDATE(),
		i.CreatedBy = ORIGINAL_LOGIN()
	from FI_I_CreditSpread i
	where i.AssumptionSetNo = @AssumptionSetNo

	--User Feedback
	--	select distinct 'Done' [Status], GETDATE() [StatusDate], 'Next Step - Generate Real Returns' [Next Steps]

	/*
	--Test
	select *
	from FI_I_CreditSpread
	order by CreditSpreadKey
	*/

	--exec GenerateProjectedCreditSpread @CS_tmin1, @w, @CS_LT, @sd_e, @mu_e, @AssumptionSetNo
	--exec GenerateProjectedCreditSpread '0.0082', '0.90', '0.01', '0.002', '0.00', 1

END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedDiscountRate]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Justin Saw>
-- Create date: <2019/01/23>
-- Description:	<Stored procedure for creating projected future Long-term Bond returns>

-- Updated date: <2019/04/09>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <Add the functionality to calculate the Accounting Discount Rate Basis>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedDiscountRate] (@DIS_initial as varchar(1000), @ST as varchar(1000), @LT as varchar(1000), @PercentReflected as varchar (1000), @RateType as varchar(255), @ResultSetNo as varchar(3))
AS
BEGIN

	SET NOCOUNT ON;

    
	/*
	--GC discount rate projection = GCi_(t-1) + ( (ST_t – ST_(t-1) )%ST + (LT_t – LT_(t-1) )%LT + (CS_t – CS_(t-1) )%CS ) * (Proportion of yield change to be reflected in DR)
	
	declare @DIS_initial as varchar(1000) = '0.057'
	declare @ST as varchar(1000) = '0.20'
	declare @LT as varchar(1000) = '0.80'
	declare @PercentReflected as varchar(1000) = '0.12'
	declare @RateType as varchar(10) = 'GC'
	declare @ResultSetNo as int = 1
	*/

	--Check for NULL Values or Empty strings
	set @ST = (select ISNULL(CASE WHEN @ST = '' THEN '0' ELSE @ST END, '0'))
	set @LT = (select ISNULL(CASE WHEN @LT = '' THEN '0' ELSE @LT END, '0'))
	
	declare @AssumptionSetNo as int = (select AssumptionSetNo from ResultSet where ResultSetNo = @ResultSetNo)
	declare @ProcName as varchar(255) = 'GenerateProjectedDiscountRate' + ':' + @RateType + ':' + CAST(@ResultSetNo as varchar)
	declare @STR_tmin1 as varchar(255)
	declare @LTR_tmin1 as varchar(255)
	
	declare @CS as varchar(255)
	declare @CS_tmin1 as varchar(255)

	declare @sql as nvarchar(max)
	declare @n as int = 0

	--Short Term Return is = Inflation + Real Return
	set @STR_tmin1 = (select SUM(CAST(ParameterValue as float))
					  from ParameterHistory
					  where ParameterProc in ('GenerateProjectedInflation', 'GenerateProjectedRealReturn')
						and ParameterName in ('@Inf_tmin1','@RR_ST_tmin1')
						and AssumptionSetNo = @AssumptionSetNo)

	--Long Term Return is = Short Term Return + Term Premium 
	set @LTR_tmin1 = @STR_tmin1 + (select SUM(CAST(ParameterValue as float))
								   from ParameterHistory
								   where ParameterProc in ('GenerateProjectedTermPremium')
									and ParameterName in ('@TP_tmin1')
									and AssumptionSetNo = @AssumptionSetNo)

	set @CS_tmin1 = (select SUM(CAST(ParameterValue as float))
					 from ParameterHistory
					 where ParameterProc in ('GenerateProjectedCreditSpread')
					   and ParameterName in ('@CS_tmin1')
					   and AssumptionSetNo = @AssumptionSetNo)

	set @CS = (SELECT CASE WHEN @RateType = 'ACC' THEN @LT ELSE '0' END)


	--Delete from table (if exists)
	set @sql = 'delete from ALM_I_L_DiscountRate where ResultSetNo = ' + CAST(@ResultSetNo as varchar) + ' and RateType = ''' + CAST(@RateType as varchar) + ''''
	execute sp_executesql @sql

	delete from ParameterHistory where AssumptionSetNo = @AssumptionSetNo and ParameterProc = @ProcName

	--Store the parameter values for future reference
	insert into ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
	select @AssumptionSetNo, @ProcName, '@DIS_initial', @DIS_initial, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@ST', @ST, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@LT', @LT, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@PercentReflected', @PercentReflected, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@RateType',  @RateType, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@ResultSetNo',  @ResultSetNo, GetDate(), ORIGINAL_LOGIN()

	DROP INDEX idx_ALM_I_L_DiscountRate on ALM_I_L_DiscountRate
	
	--Create values
	While @n <= 30
	Begin
	
		declare @cur varchar(1000) = CAST(@n as varchar(1000))
		declare @prev varchar(1000) = CAST(@n - 1 as varchar(1000))

		if @n = 0 
		begin
			set @sql = 'insert into ALM_I_L_DiscountRate (n, t, DiscountRate, ResultSetNo, RateType, CreatedDate, CreatedBy)
						select n , ' + @cur + ',' + @DIS_initial + ', ' + CAST(@ResultSetNo as varchar) + ', ''' + @RateType + ''', GetDate(), ORIGINAL_LOGIN()
						from FI_I_ShortTermReturn st
						where st.AssumptionSetNo =' + CAST(@AssumptionSetNo as varchar) + ' and st.t = 1'
		end
		else if @n = 1
		begin
			set @sql = 'insert into ALM_I_L_DiscountRate (n, t, DiscountRate, ResultSetNo, RateType, CreatedDate, CreatedBy)
					   select st.n, ' + @cur + ',' + @DIS_initial + ' + ' + @PercentReflected + ' * ( ISNULL((st.ST - ' + @STR_tmin1 + ') * ' + @ST + ' ,0) + ISNULL((lt.LT - ' + @LTR_tmin1 + ') * '+ @LT +' ,0) + ISNULL((cs.CreditSpread - ' + @CS_tmin1 + ') * '+ @CS +' ,0)), ' + CAST(@ResultSetNo as varchar) + ', ''' + @RateType + ''', GetDate(), ORIGINAL_LOGIN()
					   from FI_I_ShortTermReturn st
					   inner join FI_I_LongTermReturn lt on st.n = lt.n and st.t = lt.t and st.AssumptionSetNo = lt.AssumptionSetNo
					   inner join FI_I_CreditSpread cs on st.n = cs.n and st.t = cs.t and st.AssumptionSetNo = cs.AssumptionSetNo 
					   where st.AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + '
						  and st.t = ' + @cur + '
					   order by st.n'
		end
		else if @n > 1
		begin
			set @sql = 'insert into ALM_I_L_DiscountRate (n, t, DiscountRate, ResultSetNo, RateType, CreatedDate, CreatedBy)
					   select st.n, ' + @cur + ', dis.DiscountRate + ' + @PercentReflected + ' * ( ISNULL((st.ST - stp.ST) * ' + @ST + ',0) + ISNULL((lt.LT - ltp.LT) * '+ @LT +',0) + ISNULL((cs.CreditSpread - csp.CreditSpread) * '+ @CS +',0)), ' + CAST(@ResultSetNo as varchar) + ', ''' + @RateType + ''', GetDate(), ORIGINAL_LOGIN()
					   from FI_I_ShortTermReturn st
					   inner join FI_I_ShortTermReturn stp on st.n = stp.n and st.t = stp.t + 1 and st.AssumptionSetNo = stp.AssumptionSetNo
					   inner join FI_I_LongTermReturn lt on st.n = lt.n and st.t = lt.t and st.AssumptionSetNo = lt.AssumptionSetNo
					   inner join FI_I_LongTermReturn ltp on lt.n = ltp.n and lt.t = ltp.t + 1 and lt.AssumptionSetNo = ltp.AssumptionSetNo
					   inner join FI_I_CreditSpread cs on st.n = cs.n and st.t = cs.t and st.AssumptionSetNo = cs.AssumptionSetNo 
					   inner join FI_I_CreditSpread csp on cs.n = csp.n and cs.t = csp.t + 1 and cs.AssumptionSetNo = csp.AssumptionSetNo
					   inner join  ALM_I_L_DiscountRate dis on st.n = dis.n and st.t = dis.t + 1
									and dis.RateType ='''+ @RateType + '''
									and dis.ResultSetNo ='''+ @ResultSetNo + '''
					   where st.AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + '
						  and st.t = ' + @cur + '
					   order by st.n'
		end
		
		
		execute sp_executesql @sql
	
		--roll to the next value
		set @n = @n + 1
	End

	CREATE NONCLUSTERED INDEX idx_ALM_I_L_DiscountRate on ALM_I_L_DiscountRate(n, t, ResultSetNo, RateType)
	
	--User Feedback
	select distinct 'Done' [Status], GETDATE() [StatusDate], 'Next Step - If discount rates for both solvency, accounting and going concern are run, please run _6_MVA_Liab_Pre_work' [Next Steps]
	
	--exec GenerateProjectedDiscountRate @DIS_initial, @ST, @LT, @PercentReflected, @InterestRateType, @ResultSetNo
	/*
	exec GenerateProjectedDiscountRate '0.033', '0.00', '1.00', '1.00', 'SOLV', 1
	exec GenerateProjectedDiscountRate '0.044', '0.00', '1.00', '0.775', 'GC', 2
	exec GenerateProjectedDiscountRate '0.040', '0.00', '1.00', '1.0', 'ACC', 1
	*/

END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedFIReturn]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/01/04>
-- Description:	<Stored procedure for creating projected future Fixed Income Asset Class Returns>


-- Updated date:	<2019/04/11>
-- Updated by:		<Gerrit Marais>
-- Updated reason:	<Add the ability to add a Credit Spread to any Fixed Income asset class return>

-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedFIReturn] (@ST as varchar(1000), @LT as varchar(1000), @CS as varchar(1000), @ST_Dur as varchar(1000),@LT_Dur as varchar(1000), @CS_Dur as varchar(1000), @E_alpha as varchar(1000), @sd_e as varchar(1000), @max_loss as varchar(255), @prob_sr as varchar(255), @ReturnType as varchar(255), @AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;
	--END QUERY IF EMPTY
	if @ST = '0' and @LT = '0' and @ST_Dur = '0' and @LT_Dur = '0' and @E_alpha = '0' and @sd_e = '0' and @max_loss = '0' 
		begin	
			return
		end
	else 

	--Using ProVal's formula to project Inflation:    [ yieldST(t-1) + exp( Δ yieldST x Dur) ] x ST_weight + [ yieldLT(t-1) + exp( Δ yieldLT x Dur) ] x LT_weight + e
	--NORMINV(p, mu, sigma) = mu + sigma*NORMSINV(p)
	--Parameters
	/*
	declare @ST as varchar(255) = '0.65'
	declare @LT as varchar(255) = '0.35'
	declare @ST_Dur as varchar(255) = '2'
	declare @LT_Dur as varchar(255) = '14'
	declare @E_alpha as varchar(255) = '0.0075'
	declare @sd_e as varchar(255) = '0.006'
	declare @max_loss as varchar(255) = '0.10'
	declare @prob_sr as varchar(255) = '0.075'
	declare @ReturnType as varchar(255) = 'LTBond'
	declare @AssumptionSetNo as int = 1
	*/

	declare @ProcName as varchar(255) = 'GenerateProjectedFIReturn' + ':' + @ReturnType
	declare @STR_tmin1 as float
	declare @LTR_tmin1 as float
	declare @CS_tmin1 as float
	declare @sql as nvarchar(max)
	
	set @STR_tmin1 = (select SUM(CAST(ParameterValue as float))
					  from ParameterHistory
					  where ParameterProc in ('GenerateProjectedInflation', 'GenerateProjectedRealReturn')
						and ParameterName in ('@Inf_tmin1','@RR_ST_tmin1')
						and AssumptionSetNo = @AssumptionSetNo)

	set @LTR_tmin1 = @STR_tmin1 + (select SUM(CAST(ParameterValue as float))
								   from ParameterHistory
								   where ParameterProc in ('GenerateProjectedTermPremium')
									and ParameterName in ('@TP_tmin1')
									and AssumptionSetNo = @AssumptionSetNo)

	set @CS_tmin1 =  (select SUM(CAST(ParameterValue as float))
					  from ParameterHistory
					  where ParameterProc in ('GenerateProjectedCreditSpread')
						and ParameterName in ('@CS_tmin1')
						and AssumptionSetNo = @AssumptionSetNo)
	
	--Write to trail table (if exists)
	set @sql = 'insert into trl.FI_AC_' + @ReturnType + '(n, t, Normal, Stressed, Combined, AssumptionSetNo, OriginalCreatedDate, OriginalCreatedBy, TrailCreatedDate, TrailCreatedBy, SourceKey)
				select n, t, Normal, Stressed, Combined, AssumptionSetNo, CreatedDate [OriginalCreatedDate], CreatedBy [OriginalCreatedBy],
				GETDATE(), ORIGINAL_LOGIN(), ' + @ReturnType + 'Key
				from FI_AC_' + @ReturnType + '
				where AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + '
				order by t, n'

	execute sp_executesql @sql

	
	--Delete from table (if exists)
	set @sql = 'delete from FI_AC_' + @ReturnType + ' where AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar)
	execute sp_executesql @sql

	delete from ParameterHistory where AssumptionSetNo = @AssumptionSetNo and ParameterProc = @ProcName

	--Store the parameter values for future reference
	insert into ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
	select @AssumptionSetNo, @ProcName, '@ST', @ST, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@LT', @LT, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@CS', @CS, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@ST_Dur', @ST_Dur, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@LT_Dur', @LT_Dur, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@CS_Dur', @CS_Dur, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@E_alpha', @E_alpha, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@sd_e', @sd_e, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@max_loss',  @max_loss, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@prob_sr', @prob_sr, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@STR_tmin1', @STR_tmin1, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@LTR_tmin1', @LTR_tmin1, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@CS_tmin1', @CS_tmin1, GetDate(), ORIGINAL_LOGIN()

	--Create values
	--Pre-work
	if OBJECT_ID('tempdb..#FI_R_CredPrem') IS NOT NULL
    drop table #FI_R_CredPrem

	select *
	into #FI_R_CredPrem
	from vw_FI_R_CredPrem_Unpvt


	--Normal Regime
	if OBJECT_ID('tempdb..#FI_Normal') IS NOT NULL
    drop table #FI_Normal

	select n, t, Normal, AssumptionSetNo, CreatedDate, CreatedBy
	into #FI_Normal
	from (
		select cp.n, cp.t,
			Normal = (@STR_tmin1 + (EXP((@STR_tmin1 - st.ST) * @ST_Dur)) - 1) * @ST + (@LTR_tmin1 + (EXP((@LTR_tmin1 - lt.LT) * @LT_Dur)) - 1) * @LT + (@CS_tmin1 + (EXP((@CS_tmin1 - cs.CreditSpread) * @CS_Dur)) - 1) * @CS + (@E_alpha + @sd_e * Utils.dbo.normsinv(cp.R_CredPrem)),
			@AssumptionSetNo AssumptionSetNo, 
			GETDATE() CreatedDate,
			ORIGINAL_LOGIN() CreatedBy
		from #FI_R_CredPrem cp
		inner join FI_I_ShortTermReturn st on st.n = cp.n and st.t = cp.t and cp.AssumptionSetNo = st.AssumptionSetNo
		inner join FI_I_LongTermReturn lt on lt.n = cp.n and lt.t = cp.t and cp.AssumptionSetNo = lt.AssumptionSetNo
		inner join FI_I_CreditSpread cs on cs.n = cp.n and cs.t = cp.t and cp.AssumptionSetNo = cs.AssumptionSetNo
		where cp.AssumptionSetNo = @AssumptionSetNo
			and cp.t = 1
			union
		select cp.n, cp.t,
			Normal = (stmin1.ST + (EXP((stmin1.ST - st.ST) * @ST_Dur)) - 1) * @ST + (ltmin1.LT + (EXP((ltmin1.LT - lt.LT) * @LT_Dur)) - 1) * @LT + (csmin1.CreditSpread + (EXP((csmin1.CreditSpread - cs.CreditSpread) * @CS_Dur)) - 1) * @CS  + (@E_alpha + @sd_e * Utils.dbo.normsinv(cp.R_CredPrem)),
			@AssumptionSetNo AssumptionSetNo, 
			GETDATE() CreatedDate,
			ORIGINAL_LOGIN() CreatedBy
		from #FI_R_CredPrem cp
		inner join FI_I_ShortTermReturn st on st.n = cp.n and st.t = cp.t and cp.AssumptionSetNo = st.AssumptionSetNo
		inner join FI_I_ShortTermReturn stmin1 on stmin1.n = cp.n and stmin1.t + 1 = cp.t and cp.AssumptionSetNo = stmin1.AssumptionSetNo
		inner join FI_I_LongTermReturn lt on lt.n = cp.n and lt.t = cp.t and cp.AssumptionSetNo = lt.AssumptionSetNo
		inner join FI_I_LongTermReturn ltmin1 on ltmin1.n = cp.n and ltmin1.t + 1 = cp.t and cp.AssumptionSetNo = ltmin1.AssumptionSetNo
		inner join FI_I_CreditSpread cs on cs.n = cp.n and cs.t = cp.t and cp.AssumptionSetNo = cs.AssumptionSetNo
		inner join FI_I_CreditSpread csmin1 on csmin1.n = cp.n and csmin1.t = cp.t and cp.AssumptionSetNo = csmin1.AssumptionSetNo
		where cp.AssumptionSetNo = @AssumptionSetNo
			and cp.t > 1
	) sq 

	--Stressed Regime
	if OBJECT_ID('tempdb..#FI_Stressed') IS NOT NULL
    drop table #FI_Stressed

	;with FI_R_StressReg
	as (
		select *
		from vw_FI_R_StressReg_Unpvt
	), 
	FI_R_StressRegCdnEq
	as (
		select *
		from vw_FI_R_StressRegCdnEq_Unpvt
	)
	select sr.n, sr.t, 
		   CASE WHEN sr.StressReg < @prob_sr THEN (1 - cdn.CdnEq) * @max_loss ELSE 0 END Stressed,
		   sr.AssumptionSetNo
	into #FI_Stressed
	from FI_R_StressReg sr
	inner join FI_R_StressRegCdnEq cdn on cdn.n = sr.n and cdn.t = sr.t
		and cdn.AssumptionSetNo = sr.AssumptionSetNo
	where sr.AssumptionSetNo = @AssumptionSetNo
	order by sr.t, sr.n

	--Combined Regime
	set @sql = 	'insert into FI_AC_' + @ReturnType + '(n, t, Normal, Stressed, Combined, AssumptionSetNo, CreatedDate, CreatedBy)
				 select nor.n, nor.t, nor.Normal, st.Stressed, Combined = nor.Normal - st.Stressed, nor.AssumptionSetNo, CreatedDate, CreatedBy
				 from #FI_Normal nor
				 inner join #FI_Stressed st on nor.n = st.n and nor.t = st.t
				 where nor.AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + '
				 order by nor.t, nor.n'

	execute sp_executesql @sql
	--User Feedback

	declare @Status_FI_AC_BorrowCost as varchar(255) = ISNULL((select Cast(AssumptionSetNo as varchar) from FI_AC_BorrowCst where AssumptionSetNo = @AssumptionSetNo and n=1 and t =1),'Not Entered')
	declare @Status_FI_AC_Corp as varchar(255) = ISNULL((select Cast(AssumptionSetNo as varchar) from FI_AC_Corp where AssumptionSetNo = @AssumptionSetNo and n=1 and t =1),'Not Entered')
	declare @Status_FI_AC_LTBond as varchar(255) = ISNULL((select Cast(AssumptionSetNo as varchar) from FI_AC_LTBond where AssumptionSetNo = @AssumptionSetNo and n=1 and t =1),'Not Entered')
	declare @Status_FI_AC_Mort as varchar(255) = ISNULL((select Cast(AssumptionSetNo as varchar) from FI_AC_Mort where AssumptionSetNo = @AssumptionSetNo and n=1 and t =1),'Not Entered')
	declare @Status_FI_AC_PrDebt as varchar(255) = ISNULL((select Cast(AssumptionSetNo as varchar) from FI_AC_PrDebt where AssumptionSetNo = @AssumptionSetNo and n=1 and t =1),'Not Entered')
	declare @Status_FI_AC_STCr as varchar(255) = ISNULL((select Cast(AssumptionSetNo as varchar) from FI_AC_STCr where AssumptionSetNo = @AssumptionSetNo and n=1 and t =1),'Not Entered')
	declare @Status_FI_AC_UBond as varchar(255) = ISNULL((select Cast(AssumptionSetNo as varchar) from FI_AC_UBond where AssumptionSetNo = @AssumptionSetNo and n=1 and t =1),'Not Entered')

	select distinct 'Done' [Status], GETDATE() [StatusDate], 'If you have finished entering all 7 Fixed Income asset classes. Next Step - Generate Non-Fixed Income Triangle Distributions' [Next Steps],
	@Status_FI_AC_BorrowCost [Status_FI_AC_BorrowCost], @Status_FI_AC_Corp [Status_FI_AC_Corp], @Status_FI_AC_LTBond [Status_FI_AC_LTBond], @Status_FI_AC_Mort [Status_FI_AC_Mort], @Status_FI_AC_PrDebt [Status_FI_AC_PrDebt], @Status_FI_AC_STCr [Status_FI_AC_STCr], @Status_FI_AC_UBond [Status_FI_AC_UBond]

  --Test	
  --exec GenerateProjectedFIReturn @ST, @LT, @CS, @ST_Dur, @LT_Dur, @CS_Dur, @E_alpha, @sd_e, @max_loss, @prob_sr, @ReturnType, @AssumptionSetNo
	
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedInflation]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2018/12/21>
-- Description:	<Stored procedure for creating projecting future inflation numbers>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedInflation] (@Inf_tmin1 as varchar(1000), @w as varchar(1000), @Inf_LT as varchar(1000),@sd_e as varchar(1000), @mu_e as varchar(1000), @AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;
    
	--Using ProVal's formula to project Inflation:    Inf(t) = [ Inf(t-1) x w ] + LTInf x (1-w) ] + e
	--NORMINV(p, mu, sigma) = mu + sigma*NORMSINV(p)
	--Parameters
	/*
	set @Inf_tmin1 = '0.016'
	set @w = '0.85'
	set @Inf_LT = '0.02'
	set @sd_e = '0.006'
	set @mu_e = '0'
	*/

	declare @n as int = 1
	declare @sql as nvarchar(max)

	--Write to trail table (if exists)
	--TODO

	--Delete from table (if exists)
	delete from FI_I_Infl where AssumptionSetNo = @AssumptionSetNo
	delete from ParameterHistory where AssumptionSetNo = @AssumptionSetNo and ParameterProc = 'GenerateProjectedInflation'

	--Store the parameter values for future reference
	insert into ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
	select @AssumptionSetNo, 'GenerateProjectedInflation', '@Inf_tmin1', @Inf_tmin1, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, 'GenerateProjectedInflation', '@w', @w, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, 'GenerateProjectedInflation', '@Inf_LT', @Inf_LT, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, 'GenerateProjectedInflation', '@sd_e', @sd_e, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, 'GenerateProjectedInflation', '@mu_e', @mu_e, GetDate(), ORIGINAL_LOGIN()

	--Create values
	While @n <= 30
	Begin
	
		declare @cur varchar(1000) = CAST(@n as varchar(1000))
		declare @prev varchar(1000) = CAST(@n - 1 as varchar(1000))

		if @n = 1 
		begin
			set @sql = 'insert into FI_I_Infl(n, t, Inflation, AssumptionSetNo)
						select r.n, ' + @cur + ',' + @Inf_tmin1 + ' * ' + @w + ' + ' +  @Inf_LT +' * (1 - ' + @w + ') + (' + @mu_e + ' + (' + @sd_e + '* Utils.dbo.normsinv(r.['+ @cur + ']))), ' + CAST(@AssumptionSetNo as varchar) + '
						from FI_R_Infl r
						where r.AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + '
						order by r.n'
		end
		else
		begin
			set @sql ='insert into FI_I_Infl(n, t, Inflation, AssumptionSetNo)
					   select r.n, ' + @Cur + ', i.Inflation * ' + @w + ' + ' +  @Inf_LT +' * (1 - ' + @w + ') + (' + @mu_e + ' + (' + @sd_e + '* Utils.dbo.normsinv(r.['+ @cur + ']))), ' + CAST(@AssumptionSetNo as varchar) + '
					   from FI_R_Infl r
					   inner join FI_I_Infl i on i.AssumptionSetNo = r.AssumptionSetNo and i.n = r.n and i.t = ' + @prev + '
					   where r.AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + '
					   order by r.n'
		end
	
		execute sp_executesql @sql
	
		--roll to the next value
		set @n = @n + 1
	End

	--Update metadata
	update i
	set i.CreatedDate = GETDATE(),
		i.CreatedBy = ORIGINAL_LOGIN()
	from FI_I_Infl i
	where AssumptionSetNo = @AssumptionSetNo
	
	--User Feedback
--	select distinct 'Done' [Status], GETDATE() [StatusDate], 'Next Step - Generate Real Returns' [Next Steps]

	/*
	--Test
	select *
	from FI_I_Infl
	order by InflKey
	*/

	--exec GenerateProjectedInflation @Inf_tmin1, @w, @Inf_LT, @sd_e, @mu_e, @AssumptionSetNo
	--exec GenerateProjectedInflation '0.019', '0.85', '0.02', '0.005', '0.00', 1

END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedLiability]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:          <Justin Saw>
-- Create date:		<2019/01/23>
-- Description:     <Stored procedure for creating projected liability cash flow>

-- Updated date: <2019/04/09>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <Fix the calculation to allow for multiple assumption sets (previous version caused serious duplication)>
-- =============================================

CREATE PROCEDURE [dbo].[GenerateProjectedLiability] (@RateType as varchar(25), @ResultSetNo as int)
AS
BEGIN

SET NOCOUNT ON;
	/*
	--Testing Paramaters 
	declare @ResultSetNo as int = 1
	declare @AssumptionSetNo as int = (select AssumptionSetNo from ResultSet where ResultSetNo = @ResultSetNo)
	declare @MixName as varchar(25) = (select MixName from ResultSet where ResultSetNo = @ResultSetNo)
	declare @RateType as varchar(25) = 'GC'
	*/

	--Set starting parameters
	declare @AssumptionSetNo as int = (select AssumptionSetNo from ResultSet where ResultSetNo = @ResultSetNo)
	declare @ProcName as varchar(255) = 'GenerateProjectedLiability' +  ':' + CAST(@ResultSetNo as varchar) + ':' + @RateType

	--Remove previous results (if exists)
	delete from ALM_R_L_ProjectedLiability 
	where ResultSetNo = @ResultSetNo and RateType = @RateType
	

	drop index idx_ALM_R_L_ProjectedLiability on ALM_R_L_ProjectedLiability

	;with accr_cte
	as (
		--PV Accrued Liability (Looks good)
		select dr.n, dr.t, dr.ResultSetNo, SUM(Accrued * POWER((1 + dr.DiscountRate), - (cf.t - dr.t))) [PV Accrued Liability]
		from ALM_I_L_CashFlow cf
		inner join ALM_I_L_DiscountRate dr on cf.t >= dr.t + 1
		inner join ResultSet r on r.ResultSetNo = dr.ResultSetNo 
							  and r.AssumptionSetNo = cf.AssumptionSetNo
		where cf.t > dr.t 
			and dr.RateType = @RateType
			and dr.ResultSetNo = @ResultSetNo
			and cf.AssumptionSetNo = @AssumptionSetNo
		group by dr.n, dr.t, dr.ResultSetNo
	),
	serv_cte
	as (
		--PV Service Costs (Working)
		select fs.n, fs.t, dr.ResultSetNo, SUM(FutureService * FV_Schedule_NC_FS * POWER((1 + dr.DiscountRate), -cf.t)) [PV Service Costs]
		from tmp.FV_Schedule_NC_FS fs
			inner join ALM_I_L_CashFlow cf on 1 = 1 and cf.AssumptionSetNo = fs.AssumptionSetNo
			inner join ALM_I_L_DiscountRate dr on fs.n = dr.n and fs.t = dr.t + 1
			inner join ResultSet r on r.ResultSetNo = dr.ResultSetNo 
							      and r.AssumptionSetNo = cf.AssumptionSetNo
		where dr.RateType = @RateType 
		  and dr.ResultSetNo = @ResultSetNo
		  and fs.AssumptionsetNo = @AssumptionSetNo
		group by fs.n, fs.t, dr.ResultSetNo
	),
	norm_cte
	as (
		--Normal Cost
		/*
		select n, t, AssumptionSetNo, dbo.PV_Normal_Cost_New(t, n, @ResultSetNo, @RateType, 'PV') [PV Normal Costs]
		from ALM_I_NC_FS_Change nc
		where AssumptionSetNo = @AssumptionSetNo
		*/

		--added 2019/02/26
		select n, prj_t t, ResultSetNo, ISNULL(SUM(DiscountedValue),0) [PV Normal Costs]
		from (
			select w.n, w.prj_t, w.t, dr.ResultSetNo, NondiscountedValue, NondiscountedValue * POWER((1 + DiscountRate), -w.t) DiscountedValue
			from tmp.ALM_R_L_AdjustedLiability w
			inner join ALM_I_L_DiscountRate dr on w.n = dr.n and w.prj_t = dr.t 
												and dr.ResultSetNo = @ResultSetNo
												and dr.RateType = @RateType 
			inner join ResultSet r on r.ResultSetNo = dr.ResultSetNo 
							      and r.AssumptionSetNo = w.AssumptionSetNo
			where dr.RateType = @RateType 
			  and dr.ResultSetNo = @ResultSetNo
			  and w.AssumptionsetNo = @AssumptionSetNo 
		) sq
		group by n, prj_t, ResultSetNo
	)

	---
	select a.n, a.t, a.ResultSetNo,
	a.[PV Accrued Liability], s.[PV Service Costs], n.[PV Normal Costs], a.[PV Accrued Liability] + s.[PV Service Costs] + n.[PV Normal Costs] [PV Total],
	ROUND((a.[PV Accrued Liability] + s.[PV Service Costs] + n.[PV Normal Costs]) * Power((1 + dr.DiscountRate), 0.5), 0) [PV Total (Adj)]
	into #Result
	from accr_cte a 
		left join serv_cte s on a.n = s.n and a.t = s.t - 1 and a.ResultSetNo = s.ResultSetNo
		left join norm_cte n on a.n = n.n and a.t = n.t and a.ResultSetNo = n.ResultSetNo
		left join ALM_I_L_DiscountRate dr on a.n = dr.n and a.t = dr.t and a.ResultSetNo = dr.ResultSetNo and dr.RateType = @RateType
	order by a.n, a.t

	--We are left joining, and there is no normal cost cashflow at time = 0 in the input. 
	--This is an issue (Normal Cost Liability at t = 0 = NULL ) since we are calculating liabilities at t = 0
	update #Result
	set [PV Normal Costs] = 0 
	where t = 0

	--We are left joining, and there is no GC discount rate at t = 31. 
	--This is an issue (Future service liability at t = 30 = NULL ) since we are calculating liabilities at t = 30
	update #Result
	set [PV Service Costs] = 0 
	where t =30

	insert into ALM_R_L_ProjectedLiability(n, t, ResultSetNo, AccruedLiability, NormalCosts, ServiceCosts, RateType, CreatedDate, CreatedBy)
	select n, t, ResultSetNo, 
		ISNULL([PV Accrued Liability], 0) AccruedLiability, 
		ISNULL([PV Normal Costs], 0) NormalCosts, 
		ISNULL(CASE WHEN @RateType = 'GC' THEN [PV Service Costs] ELSE 0 END, 0) ServiceCosts, @RateType,
		GETDATE() CreatedDate, ORIGINAL_LOGIN() CreatedBy
	from #Result
	order by t, n

	drop table  #Result

	create nonclustered index idx_ALM_R_L_ProjectedLiability on ALM_R_L_ProjectedLiability(n, t, ResultSetNo)

	--User Feedback
	select distinct 'Done' [Status], GETDATE() [StatusDate], 'Next Step - Generate Projected Market Value of Assets' [Next Steps]
	
	
	/*
	--Testing
	exec GenerateProjectedLiability @RateType, @ResultSetNo
	exec GenerateProjectedLiability 'GC', 2
	exec GenerateProjectedLiability 'SOLV', 2
	exec GenerateProjectedLiability 'ACC', 2
	*/

END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedLiability_Initial]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:          <Justin Saw>
-- Create date:		<2019/02/26>
-- Description:     <Stored procedure for creating the pre-work for the projected liability cash flows>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedLiability_Initial] (@AssumptionSetNo as int)
AS
BEGIN

SET NOCOUNT ON;

	--Update the table for the NC_FS projection so we do not have to call the function for every line calculated
	delete from tmp.FV_Schedule_NC_FS
	where AssumptionSetNo = @AssumptionSetNo

	drop index idx_FV_Schedule_NC_FS on tmp.FV_Schedule_NC_FS

	insert into tmp.FV_Schedule_NC_FS(n, t, AssumptionSetNo, FV_Schedule_NC_FS, CreatedDate, CreatedBy)
	select dr.n, dr.t, dr.AssumptionSetNo, ISNULL(dbo.FV_Schedule(dr.t, dr.n, dr.AssumptionSetNo),1) FV_Schedule_NC_FS, GetDate() CreatedDate, ORIGINAL_LOGIN() CreatedBy
	from ALM_I_NC_FS_Change dr
	where dr.AssumptionSetNo = @AssumptionSetNo

	create nonclustered index idx_FV_Schedule_NC_FS on tmp.FV_Schedule_NC_FS(n, t, AssumptionSetNo)
		
	drop index idx_FV_Schedule_CF on tmp.FV_Schedule_CF

	--Adjust the cash flows using the NC_FC projection table
	delete from tmp.FV_Schedule_CF
	where AssumptionSetNo = @AssumptionSetNo

	;with FV_Schedule_CTE
	as (
		   select n, t, AssumptionSetNo, FV_Schedule_NC_FS FV_Schedule
		   from tmp.FV_Schedule_NC_FS dr 
		   where t > 0 and AssumptionSetNo = @AssumptionSetNo
	),
	work_cte
	as (
		   select fv.n, fv.t, cf.t cf_t, cf.NormalCost, ISNULL(fv.FV_Schedule * cf.NormalCost, 0) Adjusted, @AssumptionSetNo AssumptionSetNo 
		   from FV_Schedule_CTE fv
		   inner join ALM_I_L_CashFlow cf on 1 = 1 and fv.AssumptionSetNo = cf.AssumptionSetNo
		   where fv.AssumptionSetNo = @AssumptionSetNo
	)
	insert into tmp.FV_Schedule_CF
	select *
	from work_cte

	create nonclustered index idx_FV_Schedule_CF on tmp.FV_Schedule_CF(n, t, cf_t)
	
	--==============================
	--Build in COLA adjustment here.
	--==============================
	
	--Create adjusted cash flow table for each projection year
	drop index idx_ALM_R_L_AdjustedLiability on tmp.ALM_R_L_AdjustedLiability

	--Remove previous results (if exists)
	delete from tmp.ALM_R_L_AdjustedLiability
	where AssumptionSetNo = @AssumptionSetNo

	--Persist table
	insert into tmp.ALM_R_L_AdjustedLiability
	select j.n t, w.n, t.n prj_t, SUM(Adjusted) NondiscountedValue, @AssumptionSetNo AssumptionSetNo, GetDate() CreatedDate, ORIGINAL_LOGIN() CreatedBy
	from tmp.FV_Schedule_CF w 
		   inner join Tally t on w.t <= t.n and t.n <= 30
		   inner join Tally i on i.n between 1 and t.n
		   inner join Tally j on j.n between 1 and 100 and cf_t = (j.n + (t.n - i.n)) and w.t = i.n
	where w.AssumptionSetNo = @AssumptionSetNo
	group by j.n, w.n, t.n

	create nonclustered index idx_ALM_R_L_AdjustedLiability on tmp.ALM_R_L_AdjustedLiability(n, t, prj_t)
	
	--User Feedback
	select distinct 'Done' [Status], GETDATE() [StatusDate], 'Next Step - Generate Projected Liability' [Next Steps]
/*
	exec GenerateProjectedLiability_Initial @AssumptionSetNo
	exec GenerateProjectedLiability_Initial  2
*/
END

GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedLongTermReturn]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/01/03>
-- Description:	<Stored procedure for creating projecting future Long term returns>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedLongTermReturn] (@AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;
    
	--Using ProVal's formula to project Inflation:    LT(t) = ST(t) + TP(t)
	--Pre-requisites include running [dbo].[GenerateProjectedInflation] & [dbo].[GenerateProjectedInflation] & [dbo].[GenerateProjectedShortTermReturn] & [dbo].[GenerateProjectedTermPremium]
		
	--Write to trail table (if exists)
	--TODO

	--Delete from table (if exists)
	delete from FI_I_LongTermReturn where AssumptionSetNo = @AssumptionSetNo
	
	--Store the parameter values for future reference
	--Parameters used stored for preceding procedures

	--Create values
	insert into FI_I_LongTermReturn(n, t, LT, AssumptionSetNo, CreatedDate, CreatedBy)
	select i.n, i.t, ST + TermPremium [LT], i.AssumptionSetNo, GETDATE(), ORIGINAL_LOGIN()
	from FI_I_ShortTermReturn i
	inner join FI_I_TermPremium rr on rr.n = i.n and rr.t = i.t and rr.AssumptionSetNo = i.AssumptionSetNo
	where i.AssumptionSetNo = @AssumptionSetNo
	order by t, n

	--===============================================================================================================================================
	--Salary Increase Table Code
	exec GenerateProjectedSalaryIncreases @AssumptionSetNo
	--===============================================================================================================================================

	--User Feedback
	--select distinct 'Done' [Status], GETDATE() [StatusDate], 'Next Step - Generate Fixed-Income Asset Class Returns' [Next Steps]

	/*
	--Test
	select *
	from FI_I_LongTermReturn
	order by LTReturnKey
	*/

	--exec GenerateProjectedLongTermReturn @AssumptionSetNo
	--exec GenerateProjectedLongTermReturn 1


END

GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedMVA_MEPP]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:          <Justin Saw>
-- Updated by:		<Gerrit Marais>
-- Updated date:	<2019/02/13>
-- Create date:		<2019/01/23>
-- Description:     <Stored procedure for creating projected Market Value of Assets for MEPP>
-- =============================================
/*
--Notes
This stored procedure is meant for multi employer pension plans, where contributions are established by a collective agreement (imported by user).
*/
-- =============================================

CREATE PROCEDURE [dbo].[GenerateProjectedMVA_MEPP] (@StartingAssetValue as float, @AdminFees as float, @ResultSetNo as int)
AS
BEGIN

SET NOCOUNT ON;

	/*
	--Testing Paramaters 
	declare @StartingAssetValue as float = '1468041000.00'
	declare @AdminFees as float = '0.006'
	declare @ResultSetNo as int = 1
	declare @MixName as varchar(255) = (select MixName from ResultSet where ResultSetNo = @ResultSetNo)
	declare @AssumptionSetNo as int = (select AssumptionSetNo from ResultSet where ResultSetNo = @ResultSetNo)
	*/

	--Set starting parameters
	declare @MixName as varchar(255) = (select MixName from ResultSet where ResultSetNo = @ResultSetNo)
	declare @AssumptionSetNo as int = (select AssumptionSetNo from ResultSet where ResultSetNo = @ResultSetNo)
			
	declare @ProcName as varchar(255) = 'GenerateProjectedMVA' +  ':' + @MixName  +  ':' + CAST(@ResultSetNo as varchar)

	------------------------------------------------------------------------------------------------------
	--Parameter History
	delete from ParameterHistory where AssumptionSetNo = @AssumptionSetNo and ParameterProc = @ProcName

	--Store the parameter values for future reference
	insert into ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
	select @AssumptionSetNo, @ProcName, '@StartingAssetValue', @StartingAssetValue, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@AdminFees', @AdminFees, GetDate(), ORIGINAL_LOGIN()

	------------------------------------------------------------------------------------------------------
	--Contributions Table
	--PROJECTED CONTRIBUTION = CONTRIBUTION_(1) * ACCUMULATED_NC_FS_CHANGE
	------------------------------------------------------------------------------------------------------
	--Write to trail table (if exists)
	insert into trl.ALM_R_A_ProjectedContributions(n, t, Contributions, ResultSetNo, OriginalCreatedDate, OriginalCreatedBy, TrailCreatedDate, TrailCreatedBy, SourceKey)
	select n, t, Contributions, ResultSetNo, CreatedDate [OriginalCreatedDate], CreatedBy [OriginalCreatedBy], GETDATE(), ORIGINAL_LOGIN(), PCKey
	from ALM_R_A_ProjectedContributions
	where ResultSetNo = @ResultSetNo
	order by t, n

	--Remove previous results (if exists)
	delete from ALM_R_A_ProjectedContributions 
	where ResultSetNo = @ResultSetNo
	
	drop index idx_ALM_R_A_ProjectedContributions on ALM_R_A_ProjectedContributions


	--Calculate Results
	insert into ALM_R_A_ProjectedContributions (n, t, Contributions, ResultSetNo, CreatedDate, CreatedBy)
	select fs.n, fs.t, Contributions * FV_Schedule_NC_FS [Contributions], @ResultSetNo, GetDate() CreatedDate, ORIGINAL_LOGIN() CreatedBy
	from tmp.FV_Schedule_NC_FS fs
		   inner join ALM_I_L_CashFlow cf on cf.t = 1 and fs.AssumptionsetNo = cf.AssumptionSetNo
			
        	
	create nonclustered index idx_ALM_R_A_ProjectedContributions on ALM_R_A_ProjectedContributions(n, t, ResultSetNo)
	------------------------------------------------------------------------------------------------------
	--Benefit Payments
	------------------------------------------------------------------------------------------------------
	--Write to trail table (if exists)
	insert into trl.ALM_R_A_ProjectedBenefitPayments(n, t, BenefitPayment, ResultSetNo, OriginalCreatedDate, OriginalCreatedBy, TrailCreatedDate, TrailCreatedBy, SourceKey)
	select n, t, BenefitPayment, ResultSetNo, CreatedDate [OriginalCreatedDate], CreatedBy [OriginalCreatedBy],	GETDATE(), ORIGINAL_LOGIN(), BPKey
	from ALM_R_A_ProjectedBenefitPayments
	where ResultSetNo = @ResultSetNo
	order by t, n

	--Remove previous results (if exists)
	delete from ALM_R_A_ProjectedBenefitPayments where ResultSetNo = @ResultSetNo

	drop index idx_ALM_R_A_ProjectedBenefitPayments on ALM_R_A_ProjectedBenefitPayments
	
	--Calculate Results
	insert into ALM_R_A_ProjectedBenefitPayments(n, t, BenefitPayment, ResultSetNo, CreatedDate, CreatedBy)
	select w.n, w.prj_t, Accrued + ISNULL(w.NondiscountedValue, 0) BenefitPayment, @ResultSetNo ResultSetNo, GETDATE() CreatedDate, ORIGINAL_LOGIN() CreatedBy 
	from tmp.ALM_R_L_AdjustedLiability w
	inner join ALM_I_L_CashFlow cf on w.prj_t = cf.t and w.AssumptionsetNo = cf.AssumptionSetNo and w.t = 1

	create nonclustered index idx_ALM_R_A_ProjectedBenefitPayments on ALM_R_A_ProjectedBenefitPayments(n, t, ResultSetNo)

	------------------------------------------------------------------------------------------------------
	--Cash Flow & Market Value of Assets (MVA)
	--Expected Cash Flow (t) = Contribution(t) - Benefit Payment(t) - (Admin + Investment Fee) * MVA(t - 1)
	--Market Value of Assets = MVA(t) = MVA(t - 1) * (1 + Return(t)) + CF(t)*(1 + Return(t))^(1/2)
	------------------------------------------------------------------------------------------------------
    --Cash Flow
	--Write to trail table (if exists)
    insert into trl.ALM_R_A_ProjectedCashFlow(n, t, ExpectedCashFlow, ResultSetNo, OriginalCreatedDate, OriginalCreatedBy, TrailCreatedDate, TrailCreatedBy, SourceKey)
    select n, t, ExpectedCashFlow, ResultSetNo, CreatedDate [OriginalCreatedDate], CreatedBy [OriginalCreatedBy], GETDATE(), ORIGINAL_LOGIN(), CFKey
    from ALM_R_A_ProjectedCashFlow
    where ResultSetNo = @ResultSetNo
    order by t, n
    
    --Remove previous results (if exists)	
    delete from ALM_R_A_ProjectedCashFlow where ResultSetNo = @ResultSetNo
	drop index idx_ALM_R_A_ProjectedCashFlow on ALM_R_A_ProjectedCashFlow
	
    --Market Value of Assets (MVA)
	--Write to trail table (if exists)
    insert into trl.ALM_R_A_ProjectedMVA(n, t, MVA, ResultSetNo, OriginalCreatedDate, OriginalCreatedBy, TrailCreatedDate, TrailCreatedBy, SourceKey)
    select n, t, MVA, ResultSetNo, CreatedDate [OriginalCreatedDate], CreatedBy [OriginalCreatedBy], GETDATE(), ORIGINAL_LOGIN(), MVAKey
    from ALM_R_A_ProjectedMVA
	where ResultSetNo = @ResultSetNo
    order by t, n
    
	--Remove previous results (if exists)
	delete from ALM_R_A_ProjectedMVA where ResultSetNo = @ResultSetNo
    drop index idx_ALM_R_A_ProjectedMVA on ALM_R_A_ProjectedMVA

	--Calculate Results
	declare @t as int = 1
	
	While @t <= 30
	Begin
		if @t = 1 
		Begin
			print @t

			--Expected Cash Flow (@t = 1)
			insert into ALM_R_A_ProjectedCashFlow(n, t, ExpectedCashFlow, ResultSetNo, CreatedDate, CreatedBy)
			select ctr.n, ctr.t, ISNULL(ctr.Contributions, 0) - ISNULL(bp.BenefitPayment, 0) - (@AdminFees * @StartingAssetValue) ExpectedCashFlow, 
				@ResultSetNo ResultSetNo, GETDATE(), ORIGINAL_LOGIN()
			from ALM_R_A_ProjectedContributions ctr
				inner join ALM_R_A_ProjectedBenefitPayments bp on bp.ResultSetNo = ctr.ResultSetNo and bp.n = ctr.n and bp.t = ctr.t
			where ctr.t = @t and ctr.ResultSetNo = @ResultSetNo

			--Market Value of Assets (MVA) (@t = 1)
			insert into ALM_R_A_ProjectedMVA(n, t, MVA, ResultSetNo, CreatedDate, CreatedBy)
			select am.n, am.t, @StartingAssetValue * (1 + am.ProjectedReturns) + ExpectedCashFlow * POWER((1 + am.ProjectedReturns), 0.5) MVA,
				@ResultSetNo ResultSetNo, GetDate() CreatedDate, ORIGINAL_LOGIN() CreatedBy
			from AlternativeMixes am
				inner join ALM_R_A_ProjectedCashFlow cf on cf.n = am.n and cf.t = am.t and cf.ResultSetNo = am.ResultSetNo
			where am.ResultSetNo = @ResultSetNo and am.AssumptionSetNo = @AssumptionSetNo
				and am.t = @t

			set @t = @t + 1
		End
		Else
		Begin
			print @t

			--Expected Cash Flow (@t > 1)              
			insert into ALM_R_A_ProjectedCashFlow(n, t, ExpectedCashFlow, ResultSetNo, CreatedDate, CreatedBy)
			select ctr.n, ctr.t, ISNULL(ctr.Contributions, 0) - ISNULL(bp.BenefitPayment, 0) - (@AdminFees * mvamin1.MVA) ExpectedCashFlow, 
				@ResultSetNo ResultSetNo, GETDATE(), ORIGINAL_LOGIN()
			from ALM_R_A_ProjectedContributions ctr
				inner join ALM_R_A_ProjectedBenefitPayments bp on bp.ResultSetNo = ctr.ResultSetNo and bp.n = ctr.n and bp.t = ctr.t
				inner join ALM_R_A_ProjectedMVA mvamin1 on mvamin1.ResultSetNo = bp.ResultSetNo and mvamin1.n = bp.n and mvamin1.t + 1 = bp.t
			where ctr.t = @t and ctr.ResultSetNo = @ResultSetNo
                            
			--Market Value of Assets (MVA) (@t > 1)
			insert into ALM_R_A_ProjectedMVA(n, t, MVA, ResultSetNo, CreatedDate, CreatedBy)
			select am.n, am.t, mvamin1.mva * (1 + am.ProjectedReturns) + ExpectedCashFlow * POWER((1 + am.ProjectedReturns), 0.5) MVA,
				@ResultSetNo ResultSetNo, GetDate() CreatedDate, ORIGINAL_LOGIN() CreatedBy
			from AlternativeMixes am
				inner join ALM_R_A_ProjectedCashFlow cf on cf.n = am.n and cf.t = am.t and cf.ResultSetNo = am.ResultSetNo
				inner join ALM_R_A_ProjectedMVA mvamin1 on mvamin1.n = am.n and mvamin1.t + 1 = am.t and mvamin1.ResultSetNo = cf.ResultSetNo
			where am.ResultSetNo = @ResultSetNo and am.AssumptionSetNo = @AssumptionSetNo
				and am.t = @t

			set @t = @t + 1
		End
	End

	create nonclustered index idx_ALM_R_A_ProjectedCashFlow on ALM_R_A_ProjectedCashFlow(n, t, ResultSetNo)
	create nonclustered index idx_ALM_R_A_ProjectedMVA on ALM_R_A_ProjectedMVA(n, t, ResultSetNo)
/*
	exec GenerateProjectedMVA @StartingAssetValue, @AdminFees, @ResultSetNo
	exec GenerateProjectedMVA '1468041000.00', '0.006', 1
*/
END

GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedMVA_SEPP]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:          <Justin Saw>
-- Create date:		<2019/01/23>
-- Description:     <Stored procedure for creating projected Market Value of Assets for SEPP>

-- Updated date:	<2019/04/09>
-- Updated by:		<Gerrit Marais>
-- Updated reason:	<Fix the calculation to allow for multiple assumption sets (previous version caused serious duplication)>
--					<*Fix the normal cost calculation NC_FS Adjustment was linking to (t - 1) instead of (t)> -- 2019/04/12
-- =============================================
-- =============================================
--Notes
--This stored procedure is meant for single employer pension plans, where contributions are equal to the normal costs plus deficit payments (Contributions entered by user should be 0).
-- =============================================

CREATE PROCEDURE [dbo].[GenerateProjectedMVA_SEPP] (@StartingAssetValue as float, @AdminFees as float, @AmortPeriod as int, @WUExp as float, @ResultSetNo as int)
AS
BEGIN

SET NOCOUNT ON;

	
	--Testing Paramaters 
	/*
	declare @StartingAssetValue as float = '11066860.57'
	declare @AdminFees as float = '0.003'
	declare @AmortPeriod as int = 5
	declare @WUExp as float = '75000'
	declare @ResultSetNo as int = 2
	*/

	--Set starting parameters
	declare @MixName as varchar(255) = (select MixName from ResultSet where ResultSetNo = @ResultSetNo)
	declare @AssumptionSetNo as int = (select AssumptionSetNo from ResultSet where ResultSetNo = @ResultSetNo)
	declare @ProcName as varchar(255) = 'GenerateProjectedMVA' +  ':' + @MixName  +  ':' + CAST(@ResultSetNo as varchar)
	declare @RateType as varchar(50) = 'SOLV'
	
	
	------------------------------------------------------------------------------------------------------
	--Parameter History
	delete from ParameterHistory where AssumptionSetNo = @AssumptionSetNo and ParameterProc = @ProcName

	--Store the parameter values for future reference
	insert into ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
	select @AssumptionSetNo, @ProcName, '@StartingAssetValue', @StartingAssetValue, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@AdminFees', @AdminFees, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@AmortPeriod', @AmortPeriod, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@WUExp', @WUExp, GetDate(), ORIGINAL_LOGIN()
	
	------------------------------------------------------------------------------------------------------
	--Benefit Payments
	------------------------------------------------------------------------------------------------------
	--Write to trail table (if exists)
	insert into trl.ALM_R_A_ProjectedBenefitPayments(n, t, BenefitPayment, ResultSetNo, OriginalCreatedDate, OriginalCreatedBy, TrailCreatedDate, TrailCreatedBy, SourceKey)
	select n, t, BenefitPayment, ResultSetNo, CreatedDate [OriginalCreatedDate], CreatedBy [OriginalCreatedBy],	GETDATE(), ORIGINAL_LOGIN(), BPKey
	from ALM_R_A_ProjectedBenefitPayments
	where ResultSetNo = @ResultSetNo
	order by t, n

	--Remove previous results (if exists)
	delete from ALM_R_A_ProjectedBenefitPayments where ResultSetNo = @ResultSetNo
	drop index idx_ALM_R_A_ProjectedBenefitPayments on ALM_R_A_ProjectedBenefitPayments
	
	--Calculate Results
	insert into ALM_R_A_ProjectedBenefitPayments(n, t, BenefitPayment, ResultSetNo, CreatedDate, CreatedBy)
	select w.n, w.prj_t, Accrued + ISNULL(w.NondiscountedValue, 0) BenefitPayment, @ResultSetNo ResultSetNo, GETDATE() CreatedDate, ORIGINAL_LOGIN() CreatedBy 
	from tmp.ALM_R_L_AdjustedLiability w
	inner join ALM_I_L_CashFlow cf on w.prj_t = cf.t and w.AssumptionsetNo = cf.AssumptionSetNo and w.t = 1
	where w.AssumptionSetNo = @AssumptionSetNo

	create nonclustered index idx_ALM_R_A_ProjectedBenefitPayments on ALM_R_A_ProjectedBenefitPayments(n, t, ResultSetNo)
	
	------------------------------------------------------------------------------------------------------
	--Cash Flow & Market Value of Assets (MVA)
	--Expected Cash Flow (t) = Contribution(t) - Benefit Payment(t) - (Admin + Investment Fee) * MVA(t - 1)
	--Market Value of Assets = MVA(t) = MVA(t - 1) * (1 + Return(t)) + CF(t)*(1 + Return(t))^(1/2)
	------------------------------------------------------------------------------------------------------
    --Contributions 
	--Write to trail table (if exists)
	insert into trl.ALM_R_A_ProjectedContributions(n, t, Contributions, ResultSetNo, OriginalCreatedDate, OriginalCreatedBy, TrailCreatedDate, TrailCreatedBy, SourceKey)
	select n, t, Contributions, ResultSetNo, CreatedDate [OriginalCreatedDate], CreatedBy [OriginalCreatedBy], GETDATE(), ORIGINAL_LOGIN(), PCKey
	from ALM_R_A_ProjectedContributions
	where ResultSetNo = @ResultSetNo
	order by t, n

	--Remove previous results (if exists)
	delete from ALM_R_A_ProjectedContributions where ResultSetNo = @ResultSetNo
	drop index idx_ALM_R_A_ProjectedContributions on ALM_R_A_ProjectedContributions
	
	--Cash Flow
	--Write to trail table (if exists)
    insert into trl.ALM_R_A_ProjectedCashFlow(n, t, ExpectedCashFlow, ResultSetNo, OriginalCreatedDate, OriginalCreatedBy, TrailCreatedDate, TrailCreatedBy, SourceKey)
    select n, t, ExpectedCashFlow, ResultSetNo, CreatedDate [OriginalCreatedDate], CreatedBy [OriginalCreatedBy], GETDATE(), ORIGINAL_LOGIN(), CFKey
    from ALM_R_A_ProjectedCashFlow
    where ResultSetNo = @ResultSetNo
    order by t, n
    
    --Remove previous results (if exists)	
	delete from ALM_R_A_ProjectedCashFlow where ResultSetNo = @ResultSetNo
	drop index idx_ALM_R_A_ProjectedCashFlow on ALM_R_A_ProjectedCashFlow
	
    --Market Value of Assets (MVA)
	--Write to trail table (if exists)
	insert into trl.ALM_R_A_ProjectedMVA(n, t, MVA, ResultSetNo, OriginalCreatedDate, OriginalCreatedBy, TrailCreatedDate, TrailCreatedBy, SourceKey)
    select n, t, MVA, ResultSetNo, CreatedDate [OriginalCreatedDate], CreatedBy [OriginalCreatedBy], GETDATE(), ORIGINAL_LOGIN(), MVAKey
    from ALM_R_A_ProjectedMVA
	where ResultSetNo = @ResultSetNo
    order by t, n
    
	--Remove previous results (if exists)
	delete from ALM_R_A_ProjectedMVA where ResultSetNo = @ResultSetNo
    drop index idx_ALM_R_A_ProjectedMVA on ALM_R_A_ProjectedMVA
	
	--===================
	--CHECK
	--===================
	delete from tmp.ALM_R_CF_NormalCost where ResultSetNo = @ResultSetNo
	delete from tmp.ALM_R_CF_SF_DefPmt where ResultSetNo = @ResultSetNo and RateType = @RateType
	
	drop index idx_ALM_R_CF_NormalCost on tmp.ALM_R_CF_NormalCost
	drop index idx_ALM_R_CF_SF_DefPmt on tmp.ALM_R_CF_SF_DefPmt	

	--Calculate Results
	declare @t as int = 1
	
	While @t <= 30
	Begin
		if @t = 1 
		Begin
			--Normal Cost (@t = 1)
			insert into tmp.ALM_R_CF_NormalCost(n, t, NormalCost, RateType, ResultSetNo, CreatedDate, CreatedBy)
			select sq.n, @t t, SUM(CF) * POWER((1 + MAX(dr.DiscountRate)),0.5) NormalCost, dr.RateType, @ResultSetNo ResultSetNo, GetDate() CreatedDate, ORIGINAL_LOGIN() CreatedBy
			from (
				select dr.n, dr.t, cf.NormalCost * POWER((1 + dr.DiscountRate), -cf.t) CF, DiscountRate, RateType
				from ALM_I_L_DiscountRate dr
				inner join ALM_I_L_CashFlow cf on 1 = 1 and cf.AssumptionSetNo = @AssumptionSetNo
				where dr.t = (@t - 1)
					and dr.RateType = 'GC' --@RateType
					and dr.ResultSetNo = @ResultSetNo
			) sq
			inner join ALM_I_L_DiscountRate dr on dr.n = sq.n and dr.t = (@t - 1) 
											  and dr.RateType = sq.RateType
											  and dr.ResultSetNo = @ResultSetNo
			group by sq.n, dr.DiscountRate, dr.RateType
			order by sq.n
			
			--Expected Contribution (@t = 1)
			insert into ALM_R_A_ProjectedContributions (n, t, Contributions, ResultSetNo, CreatedDate, CreatedBy)
			select nc.n, nc.t, NormalCost [Contributions], @ResultSetNo, GetDate() CreatedDate, ORIGINAL_LOGIN() CreatedBy
			from tmp.ALM_R_CF_NormalCost nc
			where nc.t = @t
			  and nc.ResultSetNo = @ResultSetNo 
	
			--Expected Cash Flow (@t = 1)
			insert into ALM_R_A_ProjectedCashFlow(n, t, ExpectedCashFlow, ResultSetNo, CreatedDate, CreatedBy)
			select ctr.n, ctr.t, ISNULL(ctr.Contributions, 0) - ISNULL(bp.BenefitPayment, 0) - (@AdminFees * @StartingAssetValue) ExpectedCashFlow, 
				@ResultSetNo ResultSetNo, GETDATE(), ORIGINAL_LOGIN()
			from ALM_R_A_ProjectedContributions ctr
				inner join ALM_R_A_ProjectedBenefitPayments bp on bp.ResultSetNo = ctr.ResultSetNo and bp.n = ctr.n and bp.t = ctr.t
			where ctr.t = @t and ctr.ResultSetNo = @ResultSetNo

			--Market Value of Assets (MVA) (@t = 1)
			insert into ALM_R_A_ProjectedMVA(n, t, MVA, ResultSetNo, CreatedDate, CreatedBy)
			select am.n, am.t, @StartingAssetValue * (1 + am.ProjectedReturns) + ExpectedCashFlow * POWER((1 + am.ProjectedReturns), 0.5) MVA,
				@ResultSetNo ResultSetNo, GetDate() CreatedDate, ORIGINAL_LOGIN() CreatedBy
			from AlternativeMixes am
				inner join ALM_R_A_ProjectedCashFlow cf on cf.n = am.n and cf.t = am.t and cf.ResultSetNo = am.ResultSetNo
			where am.ResultSetNo = @ResultSetNo and am.AssumptionSetNo = @AssumptionSetNo
				and am.t = @t
			
			--Shortfall, Interim Funded Ratio & Subsequent Deficit Payments
			insert into tmp.ALM_R_CF_SF_DefPmt(n, t, ShortFall, DefPmt, RateType, ResultSetNo, CreatedDate, CreatedBy)
			select liab.n, @t t, -(@StartingAssetValue - AccruedLiability * POWER(1 + DiscountRate, 0.5) - @WUExp) ShortFall, 
				-Utils.dbo.PMT(dr.DiscountRate, @AmortPeriod, (@StartingAssetValue - AccruedLiability * POWER(1 + DiscountRate, 0.5) - @WUExp) / POWER(1 + DiscountRate, 0.5)) DefPmt,
				dr.RateType, @ResultSetNo ResultSetNo, GETDATE() CreatedDate, ORIGINAL_LOGIN() CreatedBy
			from ALM_R_L_ProjectedLiability liab
			inner join ResultSet r on r.ResultSetNo = liab.ResultSetNo
			inner join ALM_I_L_DiscountRate dr on dr.n = liab.n and dr.t = liab.t 
												and dr.RateType = liab.RateType 
												and dr.ResultSetNo = liab.ResultSetNo
			where liab.t = (@t - 1) 
				and liab.ResultSetNo = @ResultSetNo 
				and r.AssumptionSetNo = @AssumptionSetNo
				and dr.RateType = @RateType
			
			update dp
			set DefPmt = 0 
			from tmp.ALM_R_CF_SF_DefPmt dp
			where DefPmt < 0
			
			set @t = @t + 1
		End
		Else
		Begin
			--Normal Cost (@t > 1)
			insert into tmp.ALM_R_CF_NormalCost(n, t, NormalCost, RateType, ResultSetNo, CreatedDate, CreatedBy)
			select sq.n, @t t, SUM(CF) * POWER((1 + MAX(dr.DiscountRate)),0.5) * MAX(FV_Schedule_NC_FS) NormalCost, dr.RateType, @ResultSetNo, GetDate() CreatedDate, ORIGINAL_LOGIN() CreatedBy
			from (
				select dr.n, dr.t, cf.NormalCost * POWER((1 + dr.DiscountRate), -cf.t) cf, DiscountRate, dr.RateType, dr.ResultSetNo
				from ALM_I_L_DiscountRate dr
				inner join ALM_I_L_CashFlow cf on 1 = 1 and cf.AssumptionSetNo = @AssumptionSetNo
				where dr.t = (@t - 1)
					and dr.RateType = 'GC' --@RateType
					and dr.ResultSetNo = @ResultSetNo
			) sq
			inner join ALM_I_L_DiscountRate dr on dr.n = sq.n and dr.t = (@t - 1) and dr.RateType = sq.RateType and dr.ResultSetNo = sq.ResultSetNo
			inner join tmp.FV_Schedule_NC_FS fs on fs.n = dr.n and fs.t = @t and fs.AssumptionSetNo = @AssumptionSetNo									--*
			group by sq.n, dr.DiscountRate, dr.RateType
			order by sq.n

			--Expected Contribution (@t > 1)
			insert into ALM_R_A_ProjectedContributions (n, t, Contributions, ResultSetNo, CreatedDate, CreatedBy)
			select nc.n, nc.t, NormalCost + DefPmt [Contributions], @ResultSetNo, GetDate() CreatedDate, ORIGINAL_LOGIN() CreatedBy
			from tmp.ALM_R_CF_NormalCost nc
			inner join tmp.ALM_R_CF_SF_DefPmt dp on dp.n = nc.n and nc.t = dp.t + 1 and nc.ResultSetNo = dp.ResultSetNo
			where nc.t = @t
			  and nc.ResultSetNo = @ResultSetNo 
				
			--Expected Cash Flow (@t > 1)              
			insert into ALM_R_A_ProjectedCashFlow(n, t, ExpectedCashFlow, ResultSetNo, CreatedDate, CreatedBy)
			select ctr.n, ctr.t, ISNULL(ctr.Contributions, 0) - ISNULL(bp.BenefitPayment, 0) - (@AdminFees * mvamin1.MVA) ExpectedCashFlow, 
				@ResultSetNo ResultSetNo, GETDATE(), ORIGINAL_LOGIN()
			from ALM_R_A_ProjectedContributions ctr
				inner join ALM_R_A_ProjectedBenefitPayments bp on bp.ResultSetNo = ctr.ResultSetNo and bp.n = ctr.n and bp.t = ctr.t
				inner join ALM_R_A_ProjectedMVA mvamin1 on mvamin1.ResultSetNo = bp.ResultSetNo and mvamin1.n = bp.n and mvamin1.t + 1 = bp.t
			where ctr.t = @t and ctr.ResultSetNo = @ResultSetNo
                            
			--Market Value of Assets (MVA) (@t > 1)
			insert into ALM_R_A_ProjectedMVA(n, t, MVA, ResultSetNo, CreatedDate, CreatedBy)
			select am.n, am.t, mvamin1.mva * (1 + am.ProjectedReturns) + ExpectedCashFlow * POWER((1 + am.ProjectedReturns), 0.5) MVA,
				@ResultSetNo ResultSetNo, GetDate() CreatedDate, ORIGINAL_LOGIN() CreatedBy
			from AlternativeMixes am
				inner join ALM_R_A_ProjectedCashFlow cf on cf.n = am.n and cf.t = am.t and cf.ResultSetNo = am.ResultSetNo
				inner join ALM_R_A_ProjectedMVA mvamin1 on mvamin1.n = am.n and mvamin1.t + 1 = am.t and mvamin1.ResultSetNo = cf.ResultSetNo
			where am.ResultSetNo = @ResultSetNo and am.AssumptionSetNo = @AssumptionSetNo
				and am.t = @t

			--Shortfall, Interim Funded Ratio & Subsequent Deficit Payments
			insert into tmp.ALM_R_CF_SF_DefPmt(n, t, ShortFall, DefPmt, RateType, ResultSetNo, CreatedDate, CreatedBy)
			select liab.n, @t t, -(mva.MVA - (AccruedLiability + NormalCosts + ServiceCosts) * POWER(1 + DiscountRate, 0.5)- @WUExp * ISNULL(dbo.FV_Schedule_Inflation(dr.t, dr.n, @AssumptionSetNo),1)) ShortFall, 
				-Utils.dbo.PMT(dr.DiscountRate, @AmortPeriod, (mva.MVA - (AccruedLiability + NormalCosts + ServiceCosts) * POWER(1 + DiscountRate, 0.5)- @WUExp * ISNULL(dbo.FV_Schedule_Inflation(dr.t, dr.n, @AssumptionSetNo),1)) / POWER(1 + DiscountRate, 0.5)) DefPmt,
				dr.RateType, @ResultSetNo ResultSetNo, GETDATE() CreatedDate, ORIGINAL_LOGIN() CreatedBy
			from ALM_R_A_ProjectedMVA mva
			inner join ResultSet r on r.ResultSetNo = mva.ResultSetNo
			inner join ALM_R_L_ProjectedLiability liab on liab.n = mva.n and liab.t = mva.t and liab.ResultSetNo = mva.ResultSetNo
			inner join ALM_I_L_DiscountRate dr on dr.n = liab.n and dr.t = liab.t 
												and dr.RateType = liab.RateType 
												and dr.ResultSetNo = liab.ResultSetNo
			where liab.t = (@t - 1) 
				and liab.ResultSetNo = @ResultSetNo 
				and r.AssumptionSetNo = @AssumptionSetNo
				and dr.RateType = @RateType
			
			update dp
			set DefPmt = 0 
			from tmp.ALM_R_CF_SF_DefPmt dp
			where DefPmt < 0

			set @t = @t + 1
		End
	End
	
	create nonclustered index idx_ALM_R_CF_NormalCost on tmp.ALM_R_CF_NormalCost(n, t, ResultSetNo)
	create nonclustered index idx_ALM_R_CF_SF_DefPmt on tmp.ALM_R_CF_SF_DefPmt(n, t, ResultSetNo)		
	create nonclustered index idx_ALM_R_A_ProjectedContributions on ALM_R_A_ProjectedContributions(n, t, ResultSetNo)
	create nonclustered index idx_ALM_R_A_ProjectedCashFlow on ALM_R_A_ProjectedCashFlow(n, t, ResultSetNo)
	create nonclustered index idx_ALM_R_A_ProjectedMVA on ALM_R_A_ProjectedMVA(n, t, ResultSetNo)
	
	--Funded Ratio Volatility Calulation
	delete from ALM_R_FR_Volatility where ResultSetNo = @ResultSetNo
	drop index idx_ALM_R_FR_Volatility on ALM_R_FR_Volatility
		
	insert into ALM_R_FR_Volatility(n, t, ResultSetNo, ProjectedMVA, ProjectedLiability, ProjectedFundedRatio, DeltaFundedRatio, RateType, CreatedDate, CreatedBy)
	select mva.n, mva.t, mva.ResultSetNo, mva.MVA [ProjectedMVA], (AccruedLiability + NormalCosts + ServiceCosts) * POWER(1 + DiscountRate, 0.5) [ProjectedLiability], 
				mva.MVA / ((AccruedLiability + NormalCosts + ServiceCosts) * POWER(1+DiscountRate, 0.5)) [ProjectedFundedRatio], NULL, liab.RateType, GETDATE() CreatedDate, ORIGINAL_LOGIN() CreatedBy
	from ALM_R_A_ProjectedMVA mva
	inner join ALM_R_L_ProjectedLiability liab on liab.n = mva.n 
										and liab.t = mva.t
										and liab.ResultSetNo = mva.ResultSetNo
	inner join ALM_I_L_DiscountRate dis on liab.n = dis.n 
										and liab.t = dis.t 
										and liab.ResultSetNo = dis.ResultSetNo
										and liab.RateType = dis.RateType 
	where mva.ResultSetNo = @ResultSetNo
	order by t, n

	create nonclustered index idx_ALM_R_FR_Volatility on ALM_R_FR_Volatility(n, t, ResultSetNo, RateType)

	update t1
	set t1.DeltaFundedRatio = ISNULL((t1.ProjectedFundedRatio/t2.ProjectedFundedRatio - 1), 0)
	from ALM_R_FR_Volatility t1
	left join ALM_R_FR_Volatility t2 on t1.t = t2.t + 1 
								    and t1.n = t2.n 
									and t1.ResultSetNo = t2.ResultSetNo 
									and t1.RateType = t2.RateType
	where t1.DeltaFundedRatio is NULL

	--Update the Deficit Payment table with Cumulative Values
	update def
	set def.CumDefPmt = sq.CumDefPmt
	from tmp.ALM_R_CF_SF_DefPmt def 
	inner join (
			select pl.n, pl.t, pl.RateType, pl.ResultSetNo,	CumDefPmt = SUM(plc.DefPmt) 
			from tmp.ALM_R_CF_SF_DefPmt pl with (nolock)
			inner join tmp.ALM_R_CF_SF_DefPmt plc on plc.ResultSetNo = pl.ResultSetNo
	             								 and plc.n = pl.n
				            					 and plc.t <= pl.t
												 and plc.RateType = pl.RateType
			where pl.ResultSetNo = @ResultSetNo
			group by pl.n, pl.t, pl.RateType, pl.ResultSetNo
			) sq on def.n = sq.n and def.t = sq.t and def.RateType = sq.RateType and def.ResultSetNo = sq.ResultSetNo

	--Update the Contributions table with Cumulative Values
	update con
	set CumContributions = sq.CumContributions
	from ALM_R_A_ProjectedContributions con
	inner join (select pl.n, pl.t, pl.ResultSetNo, SUM(conc.Contributions) CumContributions
				from ALM_R_A_ProjectedContributions pl
				inner join ALM_R_A_ProjectedContributions conc on conc.n = pl.n 
	                                              and conc.t <= pl.t 
												  and conc.ResultSetNo = pl.ResultSetNo
				where pl.ResultSetNo = @ResultSetNo
				group by pl.n, pl.t, pl.ResultSetNo
			) sq on con.n = sq.n and con.t = sq.t and con.ResultSetNo = sq.ResultSetNo

	--User Feedback
	select distinct 'Done' [Status], GETDATE() [StatusDate], 'ALM Completed - No further action required' [Next Steps]

	/*
	exec GenerateProjectedMVA_SEPP @StartingAssetValue, @AdminFees, @AmortPeriod, @WUExp, @ResultSetNo 
	exec GenerateProjectedMVA_SEPP '11066860.57', '0.003', 5, '75000', 1
	*/

END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedNCFSChange]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Justin Saw>
-- Create date: <2019/1/24>
-- Description:	<Stored procedure for generating Normal Cost and Future Service Cost Change>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedNCFSChange] (@ActiveDecline as varchar(1000), @AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;

    --NC  & FS Change = (1 + Salary Increase)*(1 – Actives Decline %) -1 
	/*
	declare @ActiveDecline as varchar(1000) = '0.028'
	declare @AssumptionSetNo as int = 1
	*/
	declare @ProcName as varchar(255) = 'GenerateProjectedNCFSChange'
	declare @sql as nvarchar(max)
	declare @n as int = 1

	--TO DO
	--Write to trail table (if exists)

	--Delete from table (if exists)
	set @sql = 'delete from ALM_I_NC_FS_Change where AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) 
	execute sp_executesql @sql

	delete from ParameterHistory where AssumptionSetNo = @AssumptionSetNo and ParameterProc = @ProcName

	--Store the parameter values for future reference
	insert into ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
	select @AssumptionSetNo, @ProcName, '@ActiveDecline', @ActiveDecline, GetDate(), ORIGINAL_LOGIN()

	drop index idx_ALM_NC_FS_Change ON ALM_I_NC_FS_Change

	--Create values
	While @n <= 30
	Begin
	
		declare @cur varchar(1000) = CAST(@n as varchar(1000))
		declare @prev varchar(1000) = CAST(@n - 1 as varchar(1000))

		if @n >= 1 
		begin
			set @sql ='insert into ALM_I_NC_FS_Change (n, t, NC_FS_Change, AssumptionSetNo, CreatedDate, CreatedBy)
					   select n , ' + @cur + ',( 1 + si.Salary_Increase) * ( 1 - ' + CAST(@ActiveDecline AS VARCHAR) +') -1 ,' + CAST(@AssumptionSetNo as varchar) + ', GetDate(), ORIGINAL_LOGIN()
		               from ALM_Salary_Increase si
		               where si.AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + ' and si.t = ' + @cur + '
		               order by si.n'
		end
		
		execute sp_executesql @sql
	
		--roll to the next value
		set @n = @n + 1
	End

	CREATE NONCLUSTERED INDEX idx_ALM_NC_FS_Change ON ALM_I_NC_FS_Change(n,t,AssumptionSetNo)
	
	--User Feedback
	select distinct 'Done' [Status], GETDATE() [StatusDate], 'Next Step - Run Liability Pre-Work (GenerateProjectedLiability_Initial) it will take ~30 min' [Next Steps]
	/*
	exec GenerateProjectedNCFSChange @ActiveDecline @AssumptionSetNo
	exec GenerateProjectedNCFSChange '-0.02', 1
	*/
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedNFIReturn]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/01/04>
-- Description:	<Stored procedure for creating projected future Non-Fixed Income Returns>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedNFIReturn] (@ST_Weight as varchar(1000), @LT_Weight as varchar(1000), @mu_rp as varchar(1000), @sd_rp as varchar(1000), @prob_sr as varchar(1000), @ReturnType as varchar(255), @AssumptionSetNo as int, @CalcType as varchar(255))
AS
BEGIN

	SET NOCOUNT ON;

	/*
	--@CalcType
	1. NORM (independant of ST/LT return)
	2. NORMINV (mixed with ST/LT return)
	*/
    
	--NORMINV(p, mu, sigma) = mu + sigma*NORMSINV(p)
	--Parameters
	/*
	declare @ST_Weight as float = 0.65
	declare @LT_Weight as float = 0.35
	declare @mu_rp as float = 0.073
	declare @sd_rp as float = 0.174
	declare @prob_sr as float = 0.075

	declare @ReturnType as varchar(255) = 'CdnEq'
	declare @AssumptionSetNo as int = 2

	declare @CalcType as varchar(255) = 'IN'
	*/
	
	--Delete from table (if exists)
	delete from NFI_AC_CdnEq where AssumptionSetNo = @AssumptionSetNo and 'CdnEq' = @ReturnType
	delete from NFI_AC_CdnLVEq where AssumptionSetNo = @AssumptionSetNo and 'CdnLVEq' = @ReturnType
	delete from NFI_AC_EMEq where AssumptionSetNo = @AssumptionSetNo and 'EMEq' = @ReturnType
	delete from NFI_AC_GloEq where AssumptionSetNo = @AssumptionSetNo and 'GloEq' = @ReturnType
	delete from NFI_AC_GloLVEq where AssumptionSetNo = @AssumptionSetNo and 'GloLVEq' = @ReturnType
	delete from NFI_AC_IE where AssumptionSetNo = @AssumptionSetNo and 'IE' = @ReturnType
	delete from NFI_AC_PE where AssumptionSetNo = @AssumptionSetNo and 'PE' = @ReturnType
	delete from NFI_AC_RE where AssumptionSetNo = @AssumptionSetNo and 'RE' = @ReturnType

	declare @ProcName as varchar(255) = 'GenerateProjectedNFIReturn' + ':' + @ReturnType
	declare @sql as nvarchar(max)
	
	--Write to trail table (if exists)
	set @sql = 'insert into trl.NFI_AC_' + @ReturnType + '(n, t, Normal, Stressed, Combined, AssumptionSetNo, OriginalCreatedDate, OriginalCreatedBy, TrailCreatedDate, TrailCreatedBy, SourceKey)
				select n, t, Normal, Stressed, Combined, AssumptionSetNo, CreatedDate [OriginalCreatedDate], CreatedBy [OriginalCreatedBy],
				GETDATE(), ORIGINAL_LOGIN(), ' + @ReturnType + 'Key
				from NFI_AC_' + @ReturnType + '
				where AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + '
				order by t, n'

	execute sp_executesql @sql

	--Trail for Parameter
	set @sql = 'insert into trl.ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy, TrailCreatedDate, TrailCreatedBy, SourceKey)
				select AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy, GETDATE(), ORIGINAL_LOGIN(), ParameterHistoryKey
				from ParameterHistory
				where AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + '
				and ParameterProc = ''' + @ProcName + ''''
	
	execute sp_executesql @sql
	
		
	--Delete from table (if exists)
	set @sql = 'delete from NFI_AC_' + @ReturnType + ' where AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar)
	execute sp_executesql @sql

	delete from ParameterHistory where AssumptionSetNo = @AssumptionSetNo and ParameterProc = @ProcName

	--Store the parameter values for future reference
	insert into ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
	select @AssumptionSetNo, @ProcName, '@ST', @ST_Weight, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@LT', @LT_Weight, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@prob_sr', @prob_sr, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@mu_rp', @mu_rp, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@sd_rp', @sd_rp, GetDate(), ORIGINAL_LOGIN()


	--Create values
	--Normal Regime
	if OBJECT_ID('tempdb..#NFI_Normal') IS NOT NULL
    drop table #NFI_Normal

	;with ST_Median
	as (
		select distinct t, PERCENTILE_CONT(0.5) WITHIN GROUP(order by ST) OVER (PARTITION BY t) as Median_ST
		from FI_I_ShortTermReturn
		where AssumptionSetNo =  @AssumptionSetNo
	),
	LT_Median
	as (
		select distinct t, PERCENTILE_CONT(0.5) WITHIN GROUP(order by LT) OVER (PARTITION BY t) as Median_LT
		from FI_I_LongTermReturn
		where AssumptionSetNo = @AssumptionSetNo
	)
	select corr.n, corr.t, 
		CASE WHEN @CalcType = 'STLTIN' THEN (@ST_Weight * st.Median_ST + @LT_Weight * lt.Median_LT) + (@mu_rp + @sd_rp * Utils.dbo.normsinv(corr.CorrValue)) 
			 WHEN @CalcType = 'IN' THEN  (@mu_rp + @sd_rp * Utils.dbo.normsinv(corr.CorrValue)) 
			 ELSE '' END Normal, 
	corr.AssumptionSetNo, 
	GetDate() CreatedDate, ORIGINAL_LOGIN() CreatedBy
	into #NFI_Normal
	from vw_NFI_R_Corr_Final_Unpvt corr
		inner join ST_Median st on st.t = corr.t
		inner join LT_Median lt on lt.t = corr.t
	where ReturnType = @ReturnType and AssumptionSetNo = @AssumptionSetNo
	order by t,n
	

	--Stressed Regime
	if OBJECT_ID('tempdb..#NFI_Stressed') IS NOT NULL
    drop table #NFI_Stressed

	select st.n, st.t, CASE WHEN StressReg < @prob_sr then td.TriangleDistValue ELSE 0 END Stressed
	into #NFI_Stressed
	from vw_FI_R_StressReg_Unpvt st
	inner join NFI_I_TriangleDistribution td on td.n = st.n and td.t = st.t and st.AssumptionSetNo = td.AssumptionSetNo
	where st.AssumptionSetNo = @AssumptionSetNo
		and td.ReturnType = @ReturnType
	order by st.t, st.n

	--Combined Regime
	--Combined Regime
	set @sql = 	'insert into NFI_AC_' + @ReturnType + '(n, t, Normal, Stressed, Combined, AssumptionSetNo, CreatedDate, CreatedBy)
				 select nor.n, nor.t, nor.Normal, st.Stressed, 
				 Combined = CASE WHEN st.Stressed <> 0 THEN st.Stressed ELSE nor.Normal END, 
				 nor.AssumptionSetNo, CreatedDate, CreatedBy
				 from #NFI_Normal nor
				 inner join #NFI_Stressed st on nor.n = st.n and nor.t = st.t
				 where nor.AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + '
				 order by nor.t, nor.n'
	
	execute sp_executesql @sql



	--User Feedback
	declare @Status_NFI_AC_CdnEq as varchar(255) = ISNULL((select Cast(AssumptionSetNo as varchar) from NFI_AC_CdnEq where AssumptionSetNo = @AssumptionSetNo and n=1 and t =1),'Not Entered')
	declare @Status_NFI_AC_CdnLVEq as varchar(255) = ISNULL((select Cast(AssumptionSetNo as varchar) from NFI_AC_CdnLVEq where AssumptionSetNo = @AssumptionSetNo and n=1 and t =1),'Not Entered')
	declare @Status_NFI_AC_EMEq as varchar(255) = ISNULL((select Cast(AssumptionSetNo as varchar) from NFI_AC_EMEq where AssumptionSetNo = @AssumptionSetNo and n=1 and t =1),'Not Entered')
	declare @Status_NFI_AC_GloEq as varchar(255) = ISNULL((select Cast(AssumptionSetNo as varchar) from NFI_AC_GloEq where AssumptionSetNo = @AssumptionSetNo and n=1 and t =1),'Not Entered')
	declare @Status_NFI_AC_GloLVEq as varchar(255) = ISNULL((select Cast(AssumptionSetNo as varchar) from NFI_AC_GloLVEq where AssumptionSetNo = @AssumptionSetNo and n=1 and t =1),'Not Entered')
	declare @Status_NFI_AC_IE as varchar(255) = ISNULL((select Cast(AssumptionSetNo as varchar) from NFI_AC_IE where AssumptionSetNo = @AssumptionSetNo and n=1 and t =1),'Not Entered')
	declare @Status_NFI_AC_PE as varchar(255) = ISNULL((select Cast(AssumptionSetNo as varchar) from NFI_AC_PE where AssumptionSetNo = @AssumptionSetNo and n=1 and t =1),'Not Entered')
	declare @Status_NFI_AC_RE as varchar(255) = ISNULL((select Cast(AssumptionSetNo as varchar) from NFI_AC_RE where AssumptionSetNo = @AssumptionSetNo and n=1 and t =1),'Not Entered')

	select distinct 'Done' [Status], GETDATE() [StatusDate], 'If you have finished entering all 8 Non-Fixed Income asset classes, then you are finished with the Assumption Set. Next Step - Generate Projected Portfolio Return' [Next Steps],
	@Status_NFI_AC_CdnEq [NFI_AC_CdnEq], @Status_NFI_AC_CdnLVEq [NFI_AC_CdnLVEq], @Status_NFI_AC_EMEq [NFI_AC_EMEq], @Status_NFI_AC_GloEq [NFI_AC_GloEq],
	@Status_NFI_AC_GloLVEq [NFI_AC_GloLVEq], @Status_NFI_AC_IE [NFI_AC_IE], @Status_NFI_AC_PE [NFI_AC_PE], @Status_NFI_AC_RE [NFI_AC_RE]
	
	--exec GenerateProjectedNFIReturn @ST_Weight, @LT_Weight, @mu_rp, @sd_rp, @prob_sr, @ReturnType, @AssumptionSetNo, @CalcType
	--exec GenerateProjectedNFIReturn '0.65', '0.35', '0.073', '0.174', '0.075', 'CdnLVEq', 2, 'IN'

END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedPortfolioReturn]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/01/17>
-- Description:	<Stored procedure for creating projected future portfolio returns given a specific asset mix>

-- Updated date: <2019/04/11>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <Add the functionality for floating asset classes>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedPortfolioReturn] (@UBond_Weight as float, @LTBond_Weight as float, @Mort_Weight as float, @Corp_Weight as float,
														  @PrDebt_Weight as float, @STCr_Weight as float, @BorrowCst_Weight as float, @CdnEq_Weight as float,
														  @GloEq_Weight as float, @EMEq_Weight as float, @CdnLVEq_Weight as float, @GloLVEq_Weight as float,
														  @PE_Weight as float, @IE_Weight as float, @RE_Weight as float, @FI_Float as float, @NFI_Float as float,
														  @MixName as varchar(255), @AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;
   
	--Parameters
	/*
	declare @UBond_Weight as float = 0.22
	declare @LTBond_Weight as float = 0.00
	declare @Mort_Weight as float = 0.00
	declare @Corp_Weight as float = 0.16
	declare @PrDebt_Weight as float = 0.02
	declare @STCr_Weight as float = 0.00
	declare @BorrowCst_Weight as float = 0.00
	declare @CdnEq_Weight as float = 0.19
	declare @GloEq_Weight as float = 0.23
	declare @EMEq_Weight as float = 0.03
	declare @CdnLVEq_Weight as float = 0.00
	declare @GloLVEq_Weight as float = 0.00
	declare @PE_Weight as float = 0.05
	declare @IE_Weight as float = 0.00
	declare @RE_Weight as float = 0.10

	--floating asset classes
	declare @FI_Float as float = 0.25
	declare @NFI_Float as float = 0.25

	declare @MixName as varchar(255) = 'Mix3'
	declare @AssumptionSetNo as int = 1
	*/

	--exec Create_ResultSet @AssumptionSetNo, @MixName, 'Auto Generated Name - Update Result Set for new Name'
	
	drop index idx_AlternativeMixes on AlternativeMixes

	declare @ProcName as varchar(255) = 'GenerateProjectedPortfolioReturn' + ':' + @MixName
	declare @sql as nvarchar(max)
	
	--Write to trail table (if exists)
	set @sql = 'insert into trl.AlternativeMixes(n, t, ProjectedReturns, AssumptionSetNo, MixName, OriginalCreatedDate, OriginalCreatedBy, TrailCreatedDate, TrailCreatedBy, SourceKey)
				select n, t, ProjectedReturns, AssumptionSetNo, MixName, CreatedDate [OriginalCreatedDate], CreatedBy [OriginalCreatedBy],
				GETDATE(), ORIGINAL_LOGIN(), AMKey
				from AlternativeMixes
				where AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + ' and MixName = ''' + @MixName + '''
				order by t, n'

	execute sp_executesql @sql

	--Trail for Parameter
	set @sql = 'insert into trl.ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy, TrailCreatedDate, TrailCreatedBy, SourceKey)
				select AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy, GETDATE(), ORIGINAL_LOGIN(), ParameterHistoryKey
				from ParameterHistory
				where AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + '
				and ParameterProc = ''' + @ProcName + ''''
	
	execute sp_executesql @sql
	
		
	--Delete from table (if exists)
	set @sql = 'delete from AlternativeMixes where AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + ' and MixName = ''' + @MixName + ''''
	execute sp_executesql @sql

	delete from ParameterHistory where AssumptionSetNo = @AssumptionSetNo and ParameterProc = @ProcName

	--Store the parameter values for future reference
	insert into ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
	select @AssumptionSetNo, @ProcName, '@UBond_Weight', @UBond_Weight, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@LTBond_Weight', @LTBond_Weight, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@Mort_Weight', @Mort_Weight, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@Corp_Weight',  @Corp_Weight, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@PrDebt_Weight', @PrDebt_Weight, GetDate(), ORIGINAL_LOGIN()
		union 
	select @AssumptionSetNo, @ProcName, '@STCr_Weight', @STCr_Weight, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@BorrowCst_Weight', @BorrowCst_Weight, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@CdnEq_Weight', @CdnEq_Weight, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@GloEq_Weight', @GloEq_Weight, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@EMEq_Weight', @EMEq_Weight, GetDate(), ORIGINAL_LOGIN()
		union 
	select @AssumptionSetNo, @ProcName, '@CdnLVEq_Weight', @CdnLVEq_Weight, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@GloLVEq_Weight', @GloLVEq_Weight, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@PE_Weight', @PE_Weight, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@IE_Weight', @IE_Weight, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@RE_Weight', @RE_Weight, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@FI_Float', @FI_Float, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@NFI_Float', @NFI_Float, GetDate(), ORIGINAL_LOGIN()
	
	--Create values

	insert into AlternativeMixes(n, t, ProjectedReturns, AssumptionSetNo, MixName, CreatedDate, CreatedBy)
	select lt.n, lt.t, (@UBond_Weight * ISNULL(ub.Combined,0)) + (@LTBond_Weight * ISNULL(lt.Combined,0)) + (@Mort_Weight * ISNULL(mrt.Combined,0)) + (@Corp_Weight * ISNULL(cor.Combined,0))
					 + (@PrDebt_Weight * ISNULL(prd.Combined,0)) + (@STCr_Weight * ISNULL(stc.Combined,0)) + (@BorrowCst_Weight * ISNULL(bc.Combined,0))
					 + (@CdnEq_Weight * ISNULL(cdn.Combined,0)) + (@GloEq_Weight * ISNULL(glo.Combined,0)) + (@EMEq_Weight * ISNULL(em.Combined,0))
					 + (@CdnLVEq_Weight * ISNULL(cdnlv.Combined,0)) + (@GloLVEq_Weight * ISNULL(glolv.Combined,0)) + (@PE_Weight * ISNULL(pe.Combined,0))
					 + (@IE_Weight * ISNULL(ie.Combined,0)) + (@RE_Weight * ISNULL(re.Combined,0)) + (@FI_Float * ISNULL(fl.Combined,0)) + (@NFI_Float * ISNULL(fln.Combined,0)),
		@AssumptionSetNo, @MixName, GetDate(), ORIGINAL_LOGIN()
	from FI_AC_LTBond lt
		left join FI_AC_LTBond ub on lt.n = ub.n and lt.t = ub.t and lt.AssumptionSetNo = ub.AssumptionSetNo
		left join FI_AC_Mort mrt on mrt.n = lt.n and mrt.t = lt.t and mrt.AssumptionSetNo = lt.AssumptionSetNo
		left join FI_AC_Corp cor on cor.n = lt.n and cor.t = lt.t and cor.AssumptionSetNo = lt.AssumptionSetNo
		left join FI_AC_PrDebt prd on prd.n = lt.n and prd.t = lt.t and prd.AssumptionSetNo = lt.AssumptionSetNo
		left join FI_AC_STCr stc on stc.n = lt.n and stc.t = lt.t and stc.AssumptionSetNo = lt.AssumptionSetNo
		left join FI_AC_BorrowCst bc on bc.n = lt.n and bc.t = lt.t and bc.AssumptionSetNo = lt.AssumptionSetNo
		left join NFI_AC_CdnEq cdn on cdn.n = lt.n and cdn.t = lt.t and cdn.AssumptionSetNo = lt.AssumptionSetNo
		left join NFI_AC_GloEq glo on glo.n = lt.n and glo.t = lt.t and glo.AssumptionSetNo = lt.AssumptionSetNo
		left join NFI_AC_EMEq em on em.n = lt.n and em.t = lt.t and em.AssumptionSetNo = lt.AssumptionSetNo
		left join NFI_AC_CdnLVEq cdnlv on cdnlv.n = lt.n and cdnlv.t = lt.t and cdnlv.AssumptionSetNo = lt.AssumptionSetNo
		left join NFI_AC_GloLVEq glolv on glolv.n = lt.n and glolv.t = lt.t and glolv.AssumptionSetNo = lt.AssumptionSetNo
		left join NFI_AC_PE pe on pe.n = lt.n and pe.t = lt.t and pe.AssumptionSetNo = lt.AssumptionSetNo
		left join NFI_AC_IE ie on ie.n = lt.n and ie.t = lt.t and ie.AssumptionSetNo = lt.AssumptionSetNo
		left join NFI_AC_RE re on re.n = lt.n and re.t = lt.t and re.AssumptionSetNo = lt.AssumptionSetNo
		--Floating asset classes
		left join FI_AC_Float fl on lt.n = fl.n and lt.t = fl.t and lt.AssumptionSetNo = fl.AssumptionSetNo
		left join NFI_AC_Float fln on lt.n = fln.n and lt.t = fln.t and lt.AssumptionSetNo = fln.AssumptionSetNo
	where lt.AssumptionSetNo = @AssumptionSetNo
	order by lt.t, lt.n

	--Update the ResultSetNo
	update am
	set ResultSetNo = r.ResultSetNo
	from AlternativeMixes am
	inner join ResultSet r on r.AssumptionSetNo = am.AssumptionSetNo and r.Mixname = am.Mixname
	where am.AssumptionSetNo = @AssumptionSetNo and am.MixName = @MixName

	create nonclustered index idx_AlternativeMixes on AlternativeMixes(n, t, AssumptionSetNo, ResultSetNo, MixName)
	
	/*	
	exec GenerateProjectedPortfolioReturn @UBond_Weight, @LTBond_Weight, @Mort_Weight, @Corp_Weight, @PrDebt_Weight, @STCr_Weight, @BorrowCst_Weight, @CdnEq_Weight,
										  @GloEq_Weight, @EMEq_Weight, @CdnLVEq_Weight, @GloLVEq_Weight, @PE_Weight, @IE_Weight, @RE_Weight, @FI_Float, @NFI_Float, @MixName, @AssumptionSetNo
	*/
	
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedRealReturn]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/01/02>
-- Description:	<Stored procedure for creating projecting future real return rate numbers>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedRealReturn] (@RR_ST_tmin1 as varchar(1000), @w as varchar(1000), @LT_RR_ST as varchar(1000),@sd_e as varchar(1000), @mu_e as varchar(1000),  @AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;
    
	--Using ProVal's formula:    RR(t) = [ RR ST (t-1) x w ] + [ LT RR ST x (1-w) ] + e
	--NORMINV(p, mu, sigma) = mu + sigma*NORMSINV(p)
	--Parameters
	/*
	declare @RR_ST_tmin1 as varchar(1000) = '0.0045'
	declare @w as varchar(1000) = '0.90'
	declare @LT_RR_ST as varchar(1000) = '0.01'
	declare @sd_e as varchar(1000) = '0.006'
	declare @mu_e as varchar(1000) = '0'
	*/
		
	declare @n as int = 1
	declare @sql as nvarchar(max)
	
	--Write to trail table (if exists)
	--TODO

	--Delete from table (if exists)
	delete from FI_I_RealReturn where AssumptionSetNo = @AssumptionSetNo
	delete from ParameterHistory where AssumptionSetNo = @AssumptionSetNo and ParameterProc = 'GenerateProjectedRealReturn'

	--Store the parameter values for future reference
	insert into ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
	select @AssumptionSetNo, 'GenerateProjectedRealReturn', '@RR_ST_tmin1', @RR_ST_tmin1, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, 'GenerateProjectedRealReturn', '@w', @w, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, 'GenerateProjectedRealReturn', '@LT_RR_ST', @LT_RR_ST, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, 'GenerateProjectedRealReturn', '@sd_e', @sd_e, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, 'GenerateProjectedRealReturn', '@mu_e', @mu_e, GetDate(), ORIGINAL_LOGIN()

	--Create values
	While @n <= 30
	Begin
	
		declare @cur varchar(1000) = CAST(@n as varchar(1000))
		declare @prev varchar(1000) = CAST(@n - 1 as varchar(1000))

		if @n = 1 
		begin
			set @sql = 'insert into FI_I_RealReturn(n, t, RealReturn, AssumptionSetNo)
						select r.n, ' + @cur + ',' + @RR_ST_tmin1 + ' * ' + @w + ' + ' +  @LT_RR_ST +' * (1 - ' + @w + ') + (' + @mu_e + ' + (' + @sd_e + '* Utils.dbo.normsinv(r.['+ @cur + ']))), ' + CAST(@AssumptionSetNo as varchar) + '
						from FI_R_RealReturn r
						where r.AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + '
						order by r.n'
		end
		else
		begin
			set @sql ='insert into FI_I_RealReturn(n, t, RealReturn, AssumptionSetNo)
					   select r.n, ' + @Cur + ', rr.RealReturn * ' + @w + ' + ' +  @LT_RR_ST +' * (1 - ' + @w + ') + (' + @mu_e + ' + (' + @sd_e + '* Utils.dbo.normsinv(r.['+ @cur + ']))), ' + CAST(@AssumptionSetNo as varchar) + '
					   from FI_R_RealReturn r
					   inner join FI_I_RealReturn rr on rr.AssumptionSetNo = r.AssumptionSetNo and rr.n = r.n and rr.t = ' + @prev + '
					   where r.AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + '
					   order by r.n'
		end
		
		execute sp_executesql @sql
	
		--roll to the next value
		set @n = @n + 1
	End

	--Update metadata
	update rr
	set rr.CreatedDate = GETDATE(),
		rr.CreatedBy = ORIGINAL_LOGIN()
	from FI_I_RealReturn rr
	where AssumptionSetNo = @AssumptionSetNo

	--User Feedback
--	select distinct 'Done' [Status], GETDATE() [StatusDate], 'Next Step - Generate Term Premium' [Next Steps]

	/*
	--Test
	select *
	from FI_I_RealReturn
	order by RealReturnKey
	*/

	--exec GenerateProjectedRealReturn @RR_ST_tmin1, @w, @LT_RR_ST, @sd_e, @mu_e, @AssumptionSetNo
	--exec GenerateProjectedRealReturn '0.0082', '0.9', '0.0122', '0.002', '0.00', 1
	
END


GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedSalaryIncreases]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/04/10>
-- Description:	<Stored procedure for creating projecting future Salary Increases>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedSalaryIncreases] (@AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;
    
	--Using ProVal's formula to project salary increases:    SalaryIncrease(t) = MAX( Inflation(t), 0)
	--Pre-requisites include running [dbo].[GenerateProjectedInflation] & [dbo].[GenerateProjectedShortTermReturn] & [dbo].[GenerateProjectedTermPremium]
		
	--Write to trail table (if exists)
	--TODO
	
	--Delete from table (if exists)
	delete from ALM_Salary_Increase	where AssumptionSetNo = @AssumptionSetNo
	
	--Store the parameter values for future reference
	--Parameters used stored for preceding procedures

	--Create values
	insert into ALM_Salary_Increase (n, t, Inflation, Salary_Increase, AssumptionSetNo, CreatedDate, CreatedBy)
	select n, t, Inflation, case when Inflation <= 0 then 0 else Inflation END Salary_Increase,
		AssumptionSetNo, CreatedDate, CreatedBy
	from FI_I_Infl
	where AssumptionSetNo = @AssumptionSetNo
	order by n, t

	/*
	--Test
	select *
	from ALM_Salary_Increase
	order by SalaryIncreaseKey
	*/

	--exec GenerateProjectedSalaryIncreases @AssumptionSetNo
	--exec GenerateProjectedSalaryIncreases 1

END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedShortTermReturn]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/01/03>
-- Description:	<Stored procedure for creating projecting future short term returns>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedShortTermReturn] (@AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;
    
	--Using ProVal's formula to project Inflation:    ST(t) = Infl(t) + RR(t)
	--Pre-requisites include running [dbo].[GenerateProjectedInflation] & [dbo].[GenerateProjectedInflation]
		
	--Write to trail table (if exists)
	--TODO

	--Delete from table (if exists)
	delete from FI_I_ShortTermReturn where AssumptionSetNo = @AssumptionSetNo
	
	--Store the parameter values for future reference
	--Parameters used stored for preceding procedures

	--Create values
	insert into FI_I_ShortTermReturn(n, t, ST, AssumptionSetNo, CreatedDate, CreatedBy)
	select i.n, i.t, Inflation + RealReturn [ST], i.AssumptionSetNo, GETDATE(), ORIGINAL_LOGIN()
	from FI_I_Infl i
	inner join FI_I_RealReturn rr on rr.n = i.n and rr.t = i.t and rr.AssumptionSetNo = i.AssumptionSetNo
	where i.AssumptionSetNo = @AssumptionSetNo
	order by t, n

	--User Feedback
--	select distinct 'Done' [Status], GETDATE() [StatusDate], 'Next Step - Generate Long Term Return' [Next Steps]

	/*
	--Test
	select *
	from FI_I_ShortTermReturn
	order by STReturnKey
	*/

	--exec GenerateProjectedShortTermReturn @AssumptionSetNo
	--exec GenerateProjectedShortTermReturn 1
	
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedTermPremium]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/01/02>
-- Description:	<Stored procedure for creating projecting future term premium (TP) numbers>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedTermPremium] (@TP_tmin1 as varchar(1000), @w as varchar(1000), @LT_TP as varchar(1000),@sd_e as varchar(1000), @mu_e as varchar(1000), @AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;
    
	--Using ProVal's formula for projecting the Term Premium:  TP(t) = [ TP (t-1) x w ] +  LT TP x (1-w) ] + e
	--NORMINV(p, mu, sigma) = mu + sigma*NORMSINV(p)
	--Parameters
	/*
	declare @TP_tmin1 as varchar(1000) = '0.01'
	declare @w as varchar(1000) = '0.90'
	declare @LT_TP as varchar(1000) = '0.013'
	declare @sd_e as varchar(1000) = '0.0035'
	declare @mu_e as varchar(1000) = '0'
	*/
		
	declare @n as int = 1
	declare @sql as nvarchar(max)
	
	--Write to trail table (if exists)
	--TODO

	--Delete from table (if exists)
	delete from FI_I_TermPremium where AssumptionSetNo = @AssumptionSetNo
	delete from ParameterHistory where AssumptionSetNo = @AssumptionSetNo and ParameterProc = 'GenerateProjectedTermPremium'

	--Store the parameter values for future reference
	insert into ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
	select @AssumptionSetNo, 'GenerateProjectedTermPremium', '@TP_tmin1', @TP_tmin1, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, 'GenerateProjectedTermPremium', '@w', @w, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, 'GenerateProjectedTermPremium', '@LT_TP', @LT_TP, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, 'GenerateProjectedTermPremium', '@sd_e', @sd_e, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, 'GenerateProjectedTermPremium', '@mu_e', @mu_e, GetDate(), ORIGINAL_LOGIN()

	--Create values
	While @n <= 30
	Begin
	
		declare @cur varchar(1000) = CAST(@n as varchar(1000))
		declare @prev varchar(1000) = CAST(@n - 1 as varchar(1000))

		if @n = 1 
		begin
			set @sql = 'insert into FI_I_TermPremium(n, t, TermPremium, AssumptionSetNo)
						select r.n, ' + @cur + ',' + @TP_tmin1 + ' * ' + @w + ' + ' +  @LT_TP +' * (1 - ' + @w + ') + (' + @mu_e + ' + (' + @sd_e + '* Utils.dbo.normsinv(r.['+ @cur + ']))), ' + CAST(@AssumptionSetNo as varchar) + '
						from FI_R_TermPremium r
						where r.AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + '
						order by r.n'
		end
		else
		begin
			set @sql ='insert into FI_I_TermPremium(n, t, TermPremium, AssumptionSetNo)
					   select r.n, ' + @Cur + ', tp.TermPremium * ' + @w + ' + ' +  @LT_TP +' * (1 - ' + @w + ') + (' + @mu_e + ' + (' + @sd_e + '* Utils.dbo.normsinv(r.['+ @cur + ']))), ' + CAST(@AssumptionSetNo as varchar) + '
					   from FI_R_TermPremium r
					   inner join FI_I_TermPremium tp on tp.AssumptionSetNo = r.AssumptionSetNo and tp.n = r.n and tp.t = ' + @prev + '
					   where r.AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + '
					   order by r.n'
		end
		
		execute sp_executesql @sql
	
		--roll to the next value
		set @n = @n + 1
	End

	--Update metadata
	update tp
	set tp.CreatedDate = GETDATE(),
		tp.CreatedBy = ORIGINAL_LOGIN()
	from FI_I_TermPremium tp
	where AssumptionSetNo = @AssumptionSetNo

	--User Feedback
	--	select distinct 'Done' [Status], GETDATE() [StatusDate], 'Next Step - Generate Short Term Return' [Next Steps]
	/*
	--Test
	select *
	from FI_I_TermPremium
	order by TermPremiumKey
	*/

	--exec GenerateProjectedTermPremium @TP_tmin1, @w, @LT_TP, @sd_e, @mu_e, @AssumptionSetNo
	--exec GenerateProjectedTermPremium '0.0046', '0.9', '0.0034', '0.002', '0.00', 1
	
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateRandomNumbers]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2018/12/21>
-- Description:	<Stored procedure for generating a table of random numbers>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateRandomNumbers] 
AS
BEGIN

	SET NOCOUNT ON;

   --create a table of random numbers
	select n, RAND(CHECKSUM( NEWID())) [1], RAND(CHECKSUM( NEWID())) [2], RAND(CHECKSUM( NEWID())) [3], RAND(CHECKSUM( NEWID())) [4], RAND(CHECKSUM( NEWID())) [5], 
			  RAND(CHECKSUM( NEWID())) [6], RAND(CHECKSUM( NEWID())) [7], RAND(CHECKSUM( NEWID())) [8], RAND(CHECKSUM( NEWID())) [9], RAND(CHECKSUM( NEWID())) [10], 
			  RAND(CHECKSUM( NEWID())) [11], RAND(CHECKSUM( NEWID())) [12], RAND(CHECKSUM( NEWID())) [13], RAND(CHECKSUM( NEWID())) [14], RAND(CHECKSUM( NEWID())) [15], 
			  RAND(CHECKSUM( NEWID())) [16], RAND(CHECKSUM( NEWID())) [17], RAND(CHECKSUM( NEWID())) [18], RAND(CHECKSUM( NEWID())) [19], RAND(CHECKSUM( NEWID())) [20], 
			  RAND(CHECKSUM( NEWID())) [21], RAND(CHECKSUM( NEWID())) [22], RAND(CHECKSUM( NEWID())) [23], RAND(CHECKSUM( NEWID())) [24], RAND(CHECKSUM( NEWID())) [25], 
			  RAND(CHECKSUM( NEWID())) [26], RAND(CHECKSUM( NEWID())) [27], RAND(CHECKSUM( NEWID())) [28], RAND(CHECKSUM( NEWID())) [29], RAND(CHECKSUM( NEWID())) [30]
	from Tally
	where n <= 2000


	-- Ensure that the assumptionset that these numbers need to be stored in is defined

	--1. Inflation ([dbo].[FI_R_Infl])
	--2. Real Return ([dbo].[FI_R_RealReturn])
	--3. Term Premium ([dbo].[FI_I_TermPremium])
	--4. Credit Premium ([dbo].[FI_R_CredPrem])
	--5. Stressed Regime ([dbo].[FI_R_StressReg])

	--6. Non-fixed Income Non-correlated Random Numbers for each asset classs ([dbo].[NFI_R_NCorr])
	--7. Upload the Correlated Random numbers after Cholesky Decomposition ([dbo].[NFI_R_Corr])
	--8. Run Stored Procedure to fix the Correlated Random numbers ([dbo].[Update_NFI_RCorr]) ([dbo].[NFI_R_Corr_Final])

END
GO
/****** Object:  StoredProcedure [dbo].[Update_NFI_RCorr]    Script Date: 2019-04-15 09:51:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2018/01/04>
-- Description:	<Stored procedure for Updating and editing the Correlated Random numbers used of Non-Fixed-Income Asset Class returns>
-- =============================================
CREATE PROCEDURE [dbo].[Update_NFI_RCorr] (@AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;

	delete from NFI_R_Corr_Final where AssumptionSetNo = @AssumptionSetNo
   
	insert into NFI_R_Corr_Final(RKey, AssumptionSetNo, n, t, CdnEq, GloEq, EMEq, CdnLVEq, GloLVEq, PE, IE, RE)
	select RKey, AssumptionSetNo, n, t, 
		CASE WHEN (PERCENT_RANK() over ( ORDER BY CdnEq)) = 0 THEN 0.00000001 
			 WHEN (PERCENT_RANK() over ( ORDER BY CdnEq)) = 1 THEN 0.99999999 ELSE (PERCENT_RANK() over ( ORDER BY CdnEq)) END CdnEq,
		CASE WHEN (PERCENT_RANK() over ( ORDER BY GloEq)) = 0 THEN 0.00000001 
			 WHEN (PERCENT_RANK() over ( ORDER BY GloEq)) = 1 THEN 0.99999999 ELSE (PERCENT_RANK() over ( ORDER BY GloEq)) END GloEq,
		CASE WHEN (PERCENT_RANK() over ( ORDER BY EMEq)) = 0 THEN 0.00000001 
			 WHEN (PERCENT_RANK() over ( ORDER BY EMEq)) = 1 THEN 0.99999999 ELSE (PERCENT_RANK() over ( ORDER BY EMEq)) END EMEq,
		CASE WHEN (PERCENT_RANK() over ( ORDER BY CdnLVEq)) = 0 THEN 0.00000001 
			 WHEN (PERCENT_RANK() over ( ORDER BY CdnLVEq)) = 1 THEN 0.99999999 ELSE (PERCENT_RANK() over ( ORDER BY CdnLVEq)) END CdnLVEq,
		CASE WHEN (PERCENT_RANK() over ( ORDER BY GloLVEq)) = 0 THEN 0.00000001 
			 WHEN (PERCENT_RANK() over ( ORDER BY GloLVEq)) = 1 THEN 0.99999999 ELSE (PERCENT_RANK() over ( ORDER BY GloLVEq)) END GloLVEq,
		CASE WHEN (PERCENT_RANK() over ( ORDER BY PE)) = 0 THEN 0.00000001 
			 WHEN (PERCENT_RANK() over ( ORDER BY PE)) = 1 THEN 0.99999999 ELSE (PERCENT_RANK() over ( ORDER BY PE)) END PE,
		CASE WHEN (PERCENT_RANK() over ( ORDER BY IE)) = 0 THEN 0.00000001 
			 WHEN (PERCENT_RANK() over ( ORDER BY IE)) = 1 THEN 0.99999999 ELSE (PERCENT_RANK() over ( ORDER BY IE)) END IE,
		CASE WHEN (PERCENT_RANK() over ( ORDER BY RE)) = 0 THEN 0.00000001 
			 WHEN (PERCENT_RANK() over ( ORDER BY RE)) = 1 THEN 0.99999999 ELSE (PERCENT_RANK() over ( ORDER BY RE)) END RE
	from NFI_R_Corr
	where AssumptionSetNo = @AssumptionSetNo
	order by t, n

	--exec Update_NFI_RCorr @AssumptionSetNo
	--exec Update_NFI_RCorr 1

END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Infl_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 223
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_FI_Infl'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_FI_Infl'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Infl_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 223
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_NFI_CdnEq'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_NFI_CdnEq'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Infl_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 223
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_NFI_CdnLVEq'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_NFI_CdnLVEq'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Infl_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 223
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_NFI_EMEq'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_NFI_EMEq'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Infl_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 223
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_NFI_GloEq'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_NFI_GloEq'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Infl_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 223
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_NFI_GloLVEq'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_NFI_GloLVEq'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Infl_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 223
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_NFI_IE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_NFI_IE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Infl_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 223
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_NFI_RE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_NFI_RE'
GO
USE [master]
GO
ALTER DATABASE [PBI_ALM_WIP] SET  READ_WRITE 
GO
