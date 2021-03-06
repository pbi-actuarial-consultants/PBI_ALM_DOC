USE [master]
GO
/****** Object:  Database [PBI_ALM_DEV]    Script Date: 2020-12-23 08:38:08 ******/
CREATE DATABASE [PBI_ALM_DEV]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PBI_ALM', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.PBI_EXPRESS2019\MSSQL\DATA\PBI_ALM_DEV.mdf' , SIZE = 8015936KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PBI_ALM_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.PBI_EXPRESS2019\MSSQL\DATA\PBI_ALM_DEV_log.ldf' , SIZE = 92864KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [PBI_ALM_DEV] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PBI_ALM_DEV].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PBI_ALM_DEV] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PBI_ALM_DEV] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PBI_ALM_DEV] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PBI_ALM_DEV] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PBI_ALM_DEV] SET ARITHABORT OFF 
GO
ALTER DATABASE [PBI_ALM_DEV] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PBI_ALM_DEV] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PBI_ALM_DEV] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PBI_ALM_DEV] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PBI_ALM_DEV] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PBI_ALM_DEV] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PBI_ALM_DEV] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PBI_ALM_DEV] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PBI_ALM_DEV] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PBI_ALM_DEV] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PBI_ALM_DEV] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PBI_ALM_DEV] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PBI_ALM_DEV] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PBI_ALM_DEV] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PBI_ALM_DEV] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PBI_ALM_DEV] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PBI_ALM_DEV] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PBI_ALM_DEV] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PBI_ALM_DEV] SET  MULTI_USER 
GO
ALTER DATABASE [PBI_ALM_DEV] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PBI_ALM_DEV] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PBI_ALM_DEV] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PBI_ALM_DEV] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [PBI_ALM_DEV] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PBI_ALM_DEV] SET QUERY_STORE = OFF
GO
USE [PBI_ALM_DEV]
GO
/****** Object:  User [PAC\nellie.pandey]    Script Date: 2020-12-23 08:38:08 ******/
CREATE USER [PAC\nellie.pandey] FOR LOGIN [PAC\nellie.pandey] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [PAC\Kevin.Hu]    Script Date: 2020-12-23 08:38:08 ******/
CREATE USER [PAC\Kevin.Hu] FOR LOGIN [PAC\Kevin.Hu] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [PAC\justin.saw]    Script Date: 2020-12-23 08:38:08 ******/
CREATE USER [PAC\justin.saw] FOR LOGIN [PAC\justin.saw] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [PAC\julia.friesen]    Script Date: 2020-12-23 08:38:08 ******/
CREATE USER [PAC\julia.friesen] FOR LOGIN [PAC\julia.friesen] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [PAC\chris.kimsing]    Script Date: 2020-12-23 08:38:08 ******/
CREATE USER [PAC\chris.kimsing] FOR LOGIN [PAC\chris.kimsing] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [PAC\charles.manty]    Script Date: 2020-12-23 08:38:08 ******/
CREATE USER [PAC\charles.manty] FOR LOGIN [PAC\charles.manty] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [PAC\bradley.hough]    Script Date: 2020-12-23 08:38:08 ******/
CREATE USER [PAC\bradley.hough] FOR LOGIN [PAC\bradley.hough] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Gateway]    Script Date: 2020-12-23 08:38:08 ******/
CREATE USER [Gateway] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [PAC\nellie.pandey]
GO
ALTER ROLE [db_owner] ADD MEMBER [PAC\Kevin.Hu]
GO
ALTER ROLE [db_datareader] ADD MEMBER [PAC\Kevin.Hu]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [PAC\Kevin.Hu]
GO
ALTER ROLE [db_owner] ADD MEMBER [PAC\justin.saw]
GO
ALTER ROLE [db_datareader] ADD MEMBER [PAC\justin.saw]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [PAC\justin.saw]
GO
ALTER ROLE [db_owner] ADD MEMBER [PAC\julia.friesen]
GO
ALTER ROLE [db_owner] ADD MEMBER [PAC\chris.kimsing]
GO
ALTER ROLE [db_datareader] ADD MEMBER [PAC\chris.kimsing]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [PAC\chris.kimsing]
GO
ALTER ROLE [db_owner] ADD MEMBER [PAC\charles.manty]
GO
ALTER ROLE [db_owner] ADD MEMBER [PAC\bradley.hough]
GO
ALTER ROLE [db_datareader] ADD MEMBER [PAC\bradley.hough]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [PAC\bradley.hough]
GO
ALTER ROLE [db_owner] ADD MEMBER [Gateway]
GO
/****** Object:  Schema [tmp]    Script Date: 2020-12-23 08:38:08 ******/
CREATE SCHEMA [tmp]
GO
/****** Object:  Schema [trl]    Script Date: 2020-12-23 08:38:08 ******/
CREATE SCHEMA [trl]
GO
/****** Object:  UserDefinedFunction [dbo].[FV_Schedule]    Script Date: 2020-12-23 08:38:08 ******/
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
/****** Object:  UserDefinedFunction [dbo].[FV_Schedule_AlternativeMixes]    Script Date: 2020-12-23 08:38:08 ******/
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
/****** Object:  UserDefinedFunction [dbo].[FV_Schedule_AssetClass]    Script Date: 2020-12-23 08:38:08 ******/
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
/****** Object:  UserDefinedFunction [dbo].[FV_Schedule_Inflation]    Script Date: 2020-12-23 08:38:08 ******/
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
/****** Object:  UserDefinedFunction [dbo].[PV_Normal_Cost]    Script Date: 2020-12-23 08:38:08 ******/
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
/****** Object:  UserDefinedFunction [dbo].[PV_Normal_Cost_New]    Script Date: 2020-12-23 08:38:08 ******/
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
/****** Object:  Table [dbo].[ALM_R_A_ProjectedContributions]    Script Date: 2020-12-23 08:38:08 ******/
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
/****** Object:  Table [dbo].[ALM_R_A_ProjectedReqContributions]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALM_R_A_ProjectedReqContributions](
	[PCKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[ReqContributions] [float] NULL,
	[Smooth_ReqContributions] [float] NULL,
	[CumReqContributions] [float] NULL,
	[RateType] [varchar](25) NULL,
	[ResultSetNo] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](4000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ResultSet]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResultSet](
	[ResultSetKey] [int] IDENTITY(1,1) NOT NULL,
	[ResultSetNo] [int] NOT NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[CashflowSetNo] [int] NULL,
	[MixName] [varchar](255) NOT NULL,
	[ResultSetDescript] [varchar](255) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL,
	[IsProjectedDate] [datetime] NULL,
	[IsProjectedBy] [varchar](100) NULL,
	[IsFinalizedDate] [datetime] NULL,
	[IsFinalizedBy] [varchar](100) NULL,
	[InitialCFRunDoneGC] [varchar](5) NULL,
	[InitialCFRunDoneSOLV] [varchar](5) NULL,
	[InitialCFRunDoneACC] [varchar](5) NULL,
	[UseSameCFAllBases] [varchar](5) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_Contr_Fail_Flags]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vw_Contr_Fail_Flags]

AS
	with base_cte 
	as (
		SELECT rc.n, rc.t, pc.Contributions, rc.ReqContributions, rc.Smooth_ReqContributions, rc.ResultSetNo, rc.RateType, 
			CASE WHEN Contributions <= ReqContributions THEN 1 ELSE 0 END [IterationFailFlag],
			CASE WHEN Contributions <= Smooth_ReqContributions THEN 1 ELSE 0 END [Smooth_IterationFailFlag]
		FROM ALM_R_A_ProjectedReqContributions rc
		inner join ALM_R_A_ProjectedContributions pc on rc.n = pc.n and rc.t = pc.t and rc.ResultSetNo = pc.ResultSetNo 
	),
	recur_cte
	as (
		SELECT cur.n, cur.t, cur.ResultSetNo, cur.RateType,
			cur.IterationFailFlag, cur.IterationFailFlag Run, cur.IterationFailFlag Run2,
			cur.Smooth_IterationFailFlag, cur.Smooth_IterationFailFlag Smooth_Run, cur.Smooth_IterationFailFlag Smooth_Run2
		FROM base_cte cur
		left join base_cte prev on prev.n = cur.n and prev.t + 1 = cur.t and prev.ResultSetNo = cur.ResultSetNo and prev.RateType = cur.RateType
		WHERE cur.t = 1
			UNION ALL
		SELECT cur.n, cur.t, cur.ResultSetNo, cur.RateType,
			cur.IterationFailFlag,
			CASE WHEN cur.IterationFailFlag > 0 THEN (recur.Run + recur.IterationFailFlag) ELSE 0 END Run,
			(recur.Run2 + recur.IterationFailFlag) Run2,
			cur.Smooth_IterationFailFlag,
			CASE WHEN cur.Smooth_IterationFailFlag > 0 THEN (recur.Smooth_Run + recur.Smooth_IterationFailFlag) ELSE 0 END Smooth_Run,
			(recur.Smooth_Run2 + recur.Smooth_IterationFailFlag) Smooth_Run2
		FROM base_cte cur
		INNER JOIN recur_cte recur on cur.n = recur.n and cur.t - 1 = recur.t and cur.ResultSetNo = recur.ResultSetNo and cur.RateType = recur.RateType
		WHERE cur.t > 1
	)
	select cur.n, cur.t, cur.ResultSetNo, cur.RateType, 'Non-Smoothed' CalculationType,
		--Non-smoothed Values
		cur.IterationFailFlag FYr_Rcvr, 
		CASE WHEN (cur.Run2 + cur.IterationFailFlag) >= 1 THEN 1 ELSE 0 END CumIterationFailFlag,
		CASE WHEN cur.IterationFailFlag > 0 THEN cur.Run + 1 ELSE 0 END Yrs_F_Rcvr, 
		CASE WHEN nxt.IterationFailFlag = 0 and cur.Run > 0 THEN cur.Run + 1 ELSE 0 END T_in_F_Rcvr,
		CAST(cur.t as varchar) + '#' + CAST(cur.n as varchar) + '#' + CAST(r.AssumptionSetNo as varchar) + '#' +  CAST(cur.ResultSetNo as varchar) + '#' + cur.RateType  [ResultLinkKey]
	from Recur_cte cur
	inner join Recur_cte nxt on cur.n = nxt.n and cur.t + 1 = nxt.t and cur.ResultSetNo = nxt.ResultSetNo and cur.RateType = nxt.RateType
	inner join ResultSet r with (nolock) on r.ResultSetNo = cur.ResultSetNo
		union
	select cur.n, cur.t, cur.ResultSetNo, cur.RateType, 'Smoothed' CalculationType,
		--Smoothed Values
		cur.Smooth_IterationFailFlag FYr_Rcvr_Smooth, 
		CASE WHEN (cur.Smooth_Run2 + cur.Smooth_IterationFailFlag) >= 1 THEN 1 ELSE 0 END Smooth_CumIterationFailFlag,
		CASE WHEN cur.Smooth_IterationFailFlag > 0 THEN cur.Smooth_Run + 1 ELSE 0 END Yrs_F_Rcvr_Smooth, 
		CASE WHEN nxt.Smooth_IterationFailFlag = 0 and cur.Smooth_Run > 0 THEN cur.Smooth_Run + 1 ELSE 0 END T_in_F_Rcvr_Smooth,
		CAST(cur.t as varchar) + '#' + CAST(cur.n as varchar) + '#' + CAST(r.AssumptionSetNo as varchar) + '#' +  CAST(cur.ResultSetNo as varchar) + '#' + cur.RateType  [ResultLinkKey]
	from Recur_cte cur
	inner join Recur_cte nxt on cur.n = nxt.n and cur.t + 1 = nxt.t and cur.ResultSetNo = nxt.ResultSetNo and cur.RateType = nxt.RateType
	inner join ResultSet r with (nolock) on r.ResultSetNo = cur.ResultSetNo


GO
/****** Object:  Table [dbo].[AssetClassReturn]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  View [dbo].[vw_AC_Returns]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE VIEW [dbo].[vw_AC_Returns]
WITH SCHEMABINDING  
AS
	
	SELECT acr.n, acr.t, acr.Normal, acr.Stressed, acr.Combined, acr.AssetClass [Asset Class], acr.AssetGroup [Asset Group],
		AssumptionSetNo, CreatedDate, CreatedBy, CAST(t as varchar) + '#' + CAST(n as varchar) + '#' + CAST(AssumptionSetNo as varchar)  [LinkKey]
		--sq.ParameterProc + '#' +  CAST(AssumptionSetNo as varchar)  [ParameterLinkKey]
	FROM dbo.AssetClassReturn acr

	/*
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
	*/
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
/****** Object:  Table [dbo].[FI_I_CreditSpread]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[ALM_Salary_Increase]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[FI_I_Infl]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[FI_I_TermPremium]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[FI_I_RealReturn]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[FI_I_ShortTermReturn]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[FI_I_LongTermReturn]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[ALM_I_NC_FS_Change]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  View [dbo].[vw_AC_Inputs]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[vw_AC_Inputs]
WITH SCHEMABINDING  
AS
	
	select sq.n, sq.t, sq.InputValue, sq.[Input Type], sq.AssumptionSetno, sq.SortSeq [Input Type Sort],
		CAST(t as varchar) + '#' + CAST(n as varchar) + '#' + CAST(AssumptionSetNo as varchar)  [LinkKey],
		sq.ParameterProc + '#' +  CAST(AssumptionSetNo as varchar)  [ParameterLinkKey]
	from (
		select n, t, Inflation [InputValue], AssumptionSetNo, 'Inflation' [Input Type], 'GenerateProjectedInflation' [ParameterProc], 1 SortSeq
		from [dbo].[FI_I_Infl]
			union
		select n, t, RealReturn [InputValue], AssumptionSetNo, 'Real Return' [Input Type], 'GenerateProjectedRealReturn', 2
		from [dbo].[FI_I_RealReturn]
			union
		select n, t, ST [InputValue], AssumptionSetNo, 'Short-Term Return' [Input Type], NULL, 3
		from [dbo].[FI_I_ShortTermReturn]
			union
		select n, t, TermPremium [InputValue], AssumptionSetNo, 'Term Premium' [Input Type], 'GenerateProjectedTermPremium', 4
		from [dbo].[FI_I_TermPremium]
			union
		select n, t, LT [InputValue], AssumptionSetNo, 'Long-Term Return' [Input Type], NULL, 5
		from [dbo].[FI_I_LongTermReturn]
			union
		select n, t, CreditSpread [InputValue], AssumptionSetNo, 'Credit Spread' [Input Type], 'GenerateProjectedCreditSpread', 6
		from [dbo].[FI_I_CreditSpread]
			union
		select n, t, Salary_Increase [InputValue], AssumptionSetNo, 'Salary Increase' [Input Type], NULL, 7
		from [dbo].[ALM_Salary_Increase]
			union
		select n, t, NC_FS_Change, AssumptionSetNo, 'Normal Cost/Future Service Cost' [Input Type], NULL, 8
	    from [dbo].[ALM_I_NC_FS_Change]

	) sq


GO
/****** Object:  Table [dbo].[ALM_R_A_ProjectedBenefitPayments]    Script Date: 2020-12-23 08:38:08 ******/
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
/****** Object:  Table [dbo].[ALM_R_A_ProjectedCashFlow]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[ALM_R_A_ProjectedMVA]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALM_R_A_ProjectedMVA](
	[MVAKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[MVA] [float] NULL,
	[Smooth_MVA] [float] NULL,
	[ResultSetNo] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_ProjectedMVA]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vw_ProjectedMVA]

AS
	select pl.MVAKey, 
		pl.n, 
		pl.t, 
		pl.MVA, 
		pl.Smooth_MVA, 
		pl.ResultSetNo, 
		-bp.BenefitPayment [BenefitPayment], 
		con.Contributions, 
		con.CumContributions, 
		cf.ExpectedCashflow, 
		rcon.ReqContributions, 
		rcon.CumReqContributions,
		rcon.Smooth_ReqContributions, 
		pl.CreatedDate, 
		pl.CreatedBy, 
		CAST(pl.t as varchar) + '#' + CAST(pl.n as varchar) + '#' + CAST(r.AssumptionSetNo as varchar) + '#' +  CAST(pl.ResultSetNo as varchar) + '#' + rcon.RateType [ResultLinkKey]
	from ALM_R_A_ProjectedMVA pl with (nolock)
		left join ResultSet r with (nolock) on r.ResultSetNo = pl.ResultSetNo
		left join ALM_R_A_ProjectedBenefitPayments bp with (nolock) on bp.n = pl.n and bp.t = pl.t and bp.ResultSetNo = pl.ResultSetNo
		left join ALM_R_A_ProjectedContributions con with (nolock) on con.n = pl.n and con.t = pl.t and con.ResultSetNo = pl.ResultSetNo
		left join ALM_R_A_ProjectedCashFlow cf with (nolock) on cf.n = pl.n and cf.t = pl.t and cf.ResultSetNo = pl.ResultSetNo
		left join ALM_R_A_ProjectedReqContributions rcon with (nolock) on rcon.n = pl.n and rcon.t = pl.t and rcon.ResultSetNo = pl.ResultSetNo


GO
/****** Object:  Table [dbo].[FI_R_Corr_Final]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FI_R_Corr_Final](
	[RKey] [int] IDENTITY(1,1) NOT NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[n] [float] NOT NULL,
	[t] [float] NOT NULL,
	[Infl] [float] NOT NULL,
	[FedCredSpread] [float] NOT NULL,
	[TermRPrem_7yrs] [float] NOT NULL,
	[TermRPrem_15yrs] [float] NOT NULL,
	[Prov_A_RatedDebtCredSpread_7yr] [float] NOT NULL,
	[Prov_A_RatedDebtCredSpread_15yr] [float] NOT NULL,
	[BBBCredSpread] [float] NOT NULL,
	[HighYieldSpread] [float] NOT NULL,
	[PrivDebt_illiquidityPrem] [float] NOT NULL,
	[Mort_IG_Spread] [float] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](max) NULL,
 CONSTRAINT [PK_FI_R_Corr_Final] PRIMARY KEY CLUSTERED 
(
	[RKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_FI_R_Corr_Final_Unpvt]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_FI_R_Corr_Final_Unpvt]
AS

	select AssumptionSetNo, n, t, BBType, BBCorrRandNum, CreatedDate, CreatedBy
	from   
	   (select * from FI_R_Corr_Final) bb  
	UNPIVOT  
	   (BBCorrRandNum for BBType IN   
		  (Infl, FedCredSpread, TermRPrem_7yrs, TermRPrem_15yrs, Prov_A_RatedDebtCredSpread_7yr, Prov_A_RatedDebtCredSpread_15yr, BBBCredSpread, HighYieldSpread, PrivDebt_illiquidityPrem, Mort_IG_Spread)  
		)as unpvt


GO
/****** Object:  Table [dbo].[FI_R_CredPrem]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FI_R_CredPrem](
	[PKey] [int] IDENTITY(1,1) NOT NULL,
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
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](max) NULL,
 CONSTRAINT [PK_FI_R_CredPrem] PRIMARY KEY CLUSTERED 
(
	[PKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_FI_R_CredPrem_Unpvt]    Script Date: 2020-12-23 08:38:08 ******/
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
/****** Object:  Table [dbo].[FI_R_StressReg]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FI_R_StressReg](
	[PKey] [int] IDENTITY(1,1) NOT NULL,
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
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](max) NULL,
 CONSTRAINT [PK_FI_R_StressReg] PRIMARY KEY CLUSTERED 
(
	[PKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_FI_R_StressReg_Unpvt]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[vw_FI_R_StressReg_Unpvt]
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
/****** Object:  Table [dbo].[NFI_R_Corr_Final]    Script Date: 2020-12-23 08:38:08 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_NFI_R_Corr_Final_Unpvt]    Script Date: 2020-12-23 08:38:08 ******/
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
/****** Object:  View [dbo].[vw_AC_FVSchedule]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_AC_FVSchedule]
AS
	
	with base_cte
	as ( 
		select n, t, Combined [Rate], (1 + Combined) [PlusRate], AssumptionSetNo, AssetClass, AssetGroup
		from AssetClassReturn acr
	),
	recur_cte
	as (
		select n, t, Rate, PlusRate, PlusRate CumulativeReturn, 
			   AssumptionSetNo, AssetClass, AssetGroup
		from base_cte cur
		where cur.t = 1
			union all
		select cur.n, cur.t, cur.Rate, cur.PlusRate, prev.CumulativeReturn * cur.PlusRate CumulativeReturn,
			   cur.AssumptionSetNo, cur.AssetClass, cur.AssetGroup
		from base_cte cur
		inner join recur_cte prev on prev.n = cur.n 
									and cur.t = prev.t + 1
									and prev.AssumptionSetNo = cur.AssumptionSetNo
									and prev.AssetClass = cur.AssetClass
		where cur.t > 1
	)
	select n, t, Rate, PlusRate, CumulativeReturn, POWER(CumulativeReturn, (1.0 / t)) - 1 [CumulativeAnnualized],
		AssumptionSetNo, AssetClass, AssetGroup
	from recur_cte

GO
/****** Object:  Table [dbo].[_Log]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_Log](
	[LogKey] [int] IDENTITY(1,1) NOT NULL,
	[LevelID] [int] NOT NULL,
	[LevelName] [varchar](max) NOT NULL,
	[LevelNo] [int] NOT NULL,
	[SubLevelID] [int] NOT NULL,
	[SubLevel] [varchar](max) NOT NULL,
	[ProcessID] [int] NOT NULL,
	[ProcessName] [varchar](max) NULL,
	[ProcessVariable] [varchar](max) NULL,
	[RunTime] [int] NULL,
	[RunCnt] [int] NOT NULL,
	[RowCnt] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_ProcessMap]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_ProcessMap](
	[LevelID] [int] NOT NULL,
	[LevelName] [varchar](max) NOT NULL,
	[LevelNo] [varchar](max) NOT NULL,
	[SubLevelID] [int] NOT NULL,
	[SubLevel] [varchar](max) NOT NULL,
	[ProcessID] [int] NOT NULL,
	[ProcessName] [varchar](max) NULL,
	[ProcessStoredProc] [varchar](max) NULL,
	[WriteLog] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ALM_I_A_AssetValueHistory]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALM_I_A_AssetValueHistory](
	[PKey] [int] IDENTITY(1,1) NOT NULL,
	[CashflowSetNo] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[MVA_BOY] [float] NULL,
	[MVA_EOY] [float] NOT NULL,
	[ExpectedIncome] [float] NOT NULL,
	[ActualIncome] [float] NOT NULL,
	[ExcessGains] [float] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ALM_I_COLA]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[ALM_I_L_CashFlow]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALM_I_L_CashFlow](
	[PKey] [int] IDENTITY(1,1) NOT NULL,
	[CashflowSetNo] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[RateType] [varchar](50) NULL,
	[Accrued] [float] NOT NULL,
	[NormalCost] [float] NOT NULL,
	[FutureService] [float] NULL,
	[Contributions] [float] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](255) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ALM_I_L_DiscountRate]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[ALM_R_FR_Volatility]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[ALM_R_L_ProjectedLiability]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[AlternativeMixes]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlternativeMixes](
	[AMKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[ProjectedReturns] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[ResultSetNo] [int] NULL,
	[MixName] [varchar](255) NULL,
	[CumulativeReturn] [float] NULL,
	[AnnualizedCumulativeReturn] [float] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AssetClass]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssetClass](
	[AssetClassKey] [bigint] IDENTITY(1,1) NOT NULL,
	[AssetSeq] [bigint] NULL,
	[AssumptionSetNo] [int] NULL,
	[AssetGroup] [varchar](100) NOT NULL,
	[AssetClass] [varchar](100) NOT NULL,
	[CumulativeAnnualizedYr10] [float] NULL,
	[CreatedBy] [varchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[IsFinalizedBy] [varchar](255) NULL,
	[IsFinalizedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AssumptionSet]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssumptionSet](
	[AssumptionSetKey] [int] IDENTITY(1,1) NOT NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[AssumptionSetDescript] [varchar](255) NOT NULL,
	[IterationCount] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL,
	[IsFinalizedDate] [datetime] NULL,
	[IsFinalizedBy] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CashflowSet]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CashflowSet](
	[CashflowSetKey] [int] IDENTITY(1,1) NOT NULL,
	[CashflowSetNo] [int] NOT NULL,
	[CashflowSetDescript] [varchar](max) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL,
	[AssPopulationChange] [float] NULL,
	[AssSalaryInflation] [float] NULL,
	[IsProjectedAssumptionSetNo] [int] NULL,
	[IsProjectedDate] [datetime] NULL,
	[IsProjectedBy] [varchar](100) NULL,
	[IsFinalizedDate] [datetime] NULL,
	[IsFinalizedBy] [varchar](100) NULL,
	[ClientName] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmBuildingBlock]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmBuildingBlock](
	[BBID] [int] NOT NULL,
	[BBType] [varchar](max) NOT NULL,
	[BBDescript] [varchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FI_I_AssetYields]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FI_I_AssetYields](
	[FIAssetKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[FIAsset] [varchar](100) NOT NULL,
	[FIYield] [float] NOT NULL,
	[FICredSprdInc] [float] NOT NULL,
	[FILoss] [float] NOT NULL,
	[Rand_Alpha] [float] NOT NULL,
	[Alpha] [float] NOT NULL,
	[FI_PreLossAlphaReturn] [float] NOT NULL,
	[FI_CombinedReturn] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FI_I_BuildingBlocks]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FI_I_BuildingBlocks](
	[BBKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[BBType] [varchar](100) NOT NULL,
	[BBValue] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FI_R_Corr]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FI_R_Corr](
	[RKey] [int] NOT NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[n] [float] NOT NULL,
	[t] [float] NOT NULL,
	[Infl] [float] NOT NULL,
	[FedCredSpread] [float] NOT NULL,
	[TermRPrem_7yrs] [float] NOT NULL,
	[TermRPrem_15yrs] [float] NOT NULL,
	[Prov_A_RatedDebtCredSpread_7yr] [float] NOT NULL,
	[Prov_A_RatedDebtCredSpread_15yr] [float] NOT NULL,
	[BBBCredSpread] [float] NOT NULL,
	[HighYieldSpread] [float] NOT NULL,
	[PrivDebt_illiquidityPrem] [float] NOT NULL,
	[Mort_IG_Spread] [float] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](max) NULL,
 CONSTRAINT [PK_FI_R_Corr] PRIMARY KEY CLUSTERED 
(
	[RKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FI_R_Infl]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FI_R_Infl](
	[PKey] [int] IDENTITY(1,1) NOT NULL,
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
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](max) NULL,
 CONSTRAINT [PK_R_Infl] PRIMARY KEY CLUSTERED 
(
	[PKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FI_R_NCorr]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FI_R_NCorr](
	[RKey] [int] IDENTITY(1,1) NOT NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[n] [float] NOT NULL,
	[t] [float] NOT NULL,
	[Infl] [float] NOT NULL,
	[FedCredSpread] [float] NOT NULL,
	[TermRPrem_7yrs] [float] NOT NULL,
	[TermRPrem_15yrs] [float] NOT NULL,
	[Prov_A_RatedDebtCredSpread_7yr] [float] NOT NULL,
	[Prov_A_RatedDebtCredSpread_15yr] [float] NOT NULL,
	[BBBCredSpread] [float] NOT NULL,
	[HighYieldSpread] [float] NOT NULL,
	[PrivDebt_illiquidityPrem] [float] NOT NULL,
	[Mort_IG_Spread] [float] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](max) NULL,
 CONSTRAINT [PK_FI_R_NCorr] PRIMARY KEY CLUSTERED 
(
	[RKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FI_R_RealReturn]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FI_R_RealReturn](
	[PKey] [int] IDENTITY(1,1) NOT NULL,
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
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](max) NULL,
 CONSTRAINT [PK_FI_R_RealReturn] PRIMARY KEY CLUSTERED 
(
	[PKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FI_R_TermPremium]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FI_R_TermPremium](
	[PKey] [int] IDENTITY(1,1) NOT NULL,
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
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](max) NULL,
 CONSTRAINT [PK_FI_R_TermPremium] PRIMARY KEY CLUSTERED 
(
	[PKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NFI_I_TriangleDistribution]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[NFI_R_Corr]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NFI_R_Corr](
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
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](max) NULL,
 CONSTRAINT [PK_NFI_R_Corr] PRIMARY KEY CLUSTERED 
(
	[RKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NFI_R_NCorr]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NFI_R_NCorr](
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
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](max) NULL,
 CONSTRAINT [PK_NFI_R_NCorr] PRIMARY KEY CLUSTERED 
(
	[RKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ParameterHistory]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[ResultSetLink]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[Tally]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tally](
	[n] [int] NOT NULL,
 CONSTRAINT [PK_Tally] PRIMARY KEY CLUSTERED 
(
	[n] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zzzFI_I_AssetReturns]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zzzFI_I_AssetReturns](
	[FIAssetKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[FIAsset] [varchar](100) NOT NULL,
	[FIYield] [float] NOT NULL,
	[FICredSprdInc] [float] NOT NULL,
	[FILoss] [float] NOT NULL,
	[Rand_Alpha] [float] NOT NULL,
	[Alpha] [float] NOT NULL,
	[FI_PreLossAlphaReturn] [float] NOT NULL,
	[FI_CombinedReturn] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zzzFI_I_AssetReturnsBB]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zzzFI_I_AssetReturnsBB](
	[FIAssetKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[FIAsset] [varchar](100) NOT NULL,
	[FIYield] [float] NOT NULL,
	[FICredSprdInc] [float] NOT NULL,
	[FILoss] [float] NOT NULL,
	[Rand_Alpha] [float] NOT NULL,
	[Alpha] [float] NOT NULL,
	[FI_PreLossAlphaReturn] [float] NOT NULL,
	[FI_CombinedReturn] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zzzFI_I_BBBCredSprd]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zzzFI_I_BBBCredSprd](
	[BBBCredSprdKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[BBBCredSprd] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zzzFI_I_BuildingBlocksTest]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zzzFI_I_BuildingBlocksTest](
	[BBKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[FIType] [varchar](100) NOT NULL,
	[FIValue] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zzzFI_I_FedCredSprd]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zzzFI_I_FedCredSprd](
	[FedCredSprdKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[FedCredSprd] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zzzFI_I_HighYieldSprd]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zzzFI_I_HighYieldSprd](
	[HighYieldSprdKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[HighYieldSprd] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zzzFI_I_Mort_IG_Sprd]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zzzFI_I_Mort_IG_Sprd](
	[Mort_IG_SprdKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Mort_IG_Sprd] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zzzFI_I_PrivDebt_illiquidityPrem]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zzzFI_I_PrivDebt_illiquidityPrem](
	[PrivDebt_illiquidityPremKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[PrivDebt_illiquidityPrem] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zzzFI_I_Prov_A_RatedDebtCredSprd_15yr]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zzzFI_I_Prov_A_RatedDebtCredSprd_15yr](
	[Prov_A_RatedDebtCredSprd_15yrKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Prov_A_RatedDebtCredSprd_15yr] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zzzFI_I_Prov_A_RatedDebtCredSprd_7yr]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zzzFI_I_Prov_A_RatedDebtCredSprd_7yr](
	[Prov_A_RatedDebtCredSprd_7yrKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[Prov_A_RatedDebtCredSprd_7yr] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zzzFI_I_TermRPrem_15yrs]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zzzFI_I_TermRPrem_15yrs](
	[TermRPrem_15yrsKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[TermRPrem_15yrs] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zzzFI_I_TermRPrem_7yrs]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zzzFI_I_TermRPrem_7yrs](
	[TermRPrem_7yrsKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[TermRPrem_7yrs] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zzzFI_R_Corr_Test]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zzzFI_R_Corr_Test](
	[RKey] [int] IDENTITY(1,1) NOT NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[n] [float] NOT NULL,
	[t] [float] NOT NULL,
	[Infl] [float] NOT NULL,
	[FedCredSpread] [float] NOT NULL,
	[TermRPrem_7yrs] [float] NOT NULL,
	[TermRPrem_15yrs] [float] NOT NULL,
	[Prov_A_RatedDebtCredSpread_7yr] [float] NOT NULL,
	[Prov_A_RatedDebtCredSpread_15yr] [float] NOT NULL,
	[BBBCredSpread] [float] NOT NULL,
	[HighYieldSpread] [float] NOT NULL,
	[PrivDebt_illiquidityPrem] [float] NOT NULL,
	[Mort_IG_Spread] [float] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](max) NULL,
 CONSTRAINT [PK_FI_R_Corr_Test] PRIMARY KEY CLUSTERED 
(
	[RKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zzzMatrixA]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zzzMatrixA](
	[i] [int] NOT NULL,
	[k] [int] NOT NULL,
	[element_value] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[i] ASC,
	[k] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [tmp].[ALM_I_A_AssetValueHistory]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [tmp].[ALM_I_A_AssetValueHistory](
	[PKey] [int] NULL,
	[CashflowSetNo] [int] NULL,
	[t] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[MVA_BOY] [float] NOT NULL,
	[MVA_EOY] [float] NOT NULL,
	[ExpectedIncome] [float] NOT NULL,
	[ActualIncome] [float] NOT NULL,
	[ExcessGains] [float] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [tmp].[ALM_I_L_CashFlow]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [tmp].[ALM_I_L_CashFlow](
	[t] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[Accrued_SOLV] [float] NULL,
	[Accrued_ACC] [float] NULL,
	[Accrued_GC] [float] NULL,
	[NormalCost] [float] NULL,
	[FutureService] [float] NULL,
	[Contributions] [float] NOT NULL,
	[CashflowSetNo] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [tmp].[ALM_R_A_ProjectedMVA_PBI]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [tmp].[ALM_R_A_ProjectedMVA_PBI](
	[MVAKey] [int] NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[MVA] [float] NULL,
	[Smooth_MVA] [float] NULL,
	[ResultSetNo] [int] NULL,
	[BenefitPayment] [float] NULL,
	[Contributions] [float] NULL,
	[CumContributions] [float] NULL,
	[ExpectedCashflow] [float] NULL,
	[ReqContributions] [float] NULL,
	[CumReqContributions] [float] NULL,
	[Smooth_ReqContributions] [float] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](255) NULL,
	[ResultLinkKey] [varchar](149) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [tmp].[ALM_R_CF_NormalCost]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [tmp].[ALM_R_CF_SF_DefPmt]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [tmp].[ALM_R_CF_SF_DefPmt](
	[n] [int] NOT NULL,
	[t] [int] NULL,
	[ShortFall] [float] NULL,
	[DefPmt] [float] NULL,
	[Smooth_DefPmt] [float] NULL,
	[Smooth_ShortFall] [float] NULL,
	[CumDefPmt] [float] NULL,
	[RateType] [varchar](10) NULL,
	[ResultSetNo] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [tmp].[ALM_R_L_AdjustedLiability]    Script Date: 2020-12-23 08:38:08 ******/
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
	[CashflowSetNo] [int] NULL,
	[RateType] [varchar](50) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](4000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [tmp].[CashflowSet]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [tmp].[CashflowSet](
	[CashflowSetNo] [int] NOT NULL,
	[CashflowSetDescript] [varchar](max) NOT NULL,
	[AssPopulationChange] [float] NULL,
	[AssSalaryInflation] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [tmp].[FV_Schedule_CF]    Script Date: 2020-12-23 08:38:08 ******/
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
	[AssumptionSetNo] [int] NULL,
	[CashflowSetNo] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [tmp].[FV_Schedule_NC_FS]    Script Date: 2020-12-23 08:38:08 ******/
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
/****** Object:  Table [trl].[ALM_R_A_ProjectedBenefitPayments]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [trl].[ALM_R_A_ProjectedCashFlow]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [trl].[ALM_R_A_ProjectedContributions]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [trl].[ALM_R_A_ProjectedMVA]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [trl].[AlternativeMixes]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [trl].[AlternativeMixes](
	[AMKey] [int] IDENTITY(1,1) NOT NULL,
	[n] [int] NOT NULL,
	[t] [int] NOT NULL,
	[ProjectedReturns] [float] NOT NULL,
	[AssumptionSetNo] [int] NULL,
	[ResultSetNo] [int] NULL,
	[MixName] [varchar](255) NULL,
	[OriginalCreatedDate] [datetime] NULL,
	[OriginalCreatedBy] [varchar](100) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](100) NULL,
	[SourceKey] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [trl].[FI_R_All]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [trl].[FI_R_All](
	[PKey] [int] IDENTITY(1,1) NOT NULL,
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
	[SourceTable] [varchar](max) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](max) NULL,
 CONSTRAINT [PK_R_All] PRIMARY KEY CLUSTERED 
(
	[PKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [trl].[FI_R_Corr_Final]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [trl].[FI_R_Corr_Final](
	[RKey] [int] IDENTITY(1,1) NOT NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[n] [float] NOT NULL,
	[t] [float] NOT NULL,
	[Infl] [float] NOT NULL,
	[FedCredSpread] [float] NOT NULL,
	[TermRPrem_7yrs] [float] NOT NULL,
	[TermRPrem_15yrs] [float] NOT NULL,
	[Prov_A_RatedDebtCredSpread_7yr] [float] NOT NULL,
	[Prov_A_RatedDebtCredSpread_15yr] [float] NOT NULL,
	[BBBCredSpread] [float] NOT NULL,
	[HighYieldSpread] [float] NOT NULL,
	[PrivDebt_illiquidityPrem] [float] NOT NULL,
	[Mort_IG_Spread] [float] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](max) NOT NULL,
 CONSTRAINT [PK_FI_R_Corr_Final] PRIMARY KEY CLUSTERED 
(
	[RKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [trl].[FI_R_NCorr]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [trl].[FI_R_NCorr](
	[RKey] [int] IDENTITY(1,1) NOT NULL,
	[AssumptionSetNo] [int] NOT NULL,
	[n] [float] NOT NULL,
	[t] [float] NOT NULL,
	[Infl] [float] NOT NULL,
	[FedCredSpread] [float] NOT NULL,
	[TermRPrem_7yrs] [float] NOT NULL,
	[TermRPrem_15yrs] [float] NOT NULL,
	[Prov_A_RatedDebtCredSpread_7yr] [float] NOT NULL,
	[Prov_A_RatedDebtCredSpread_15yr] [float] NOT NULL,
	[BBBCredSpread] [float] NOT NULL,
	[HighYieldSpread] [float] NOT NULL,
	[PrivDebt_illiquidityPrem] [float] NOT NULL,
	[Mort_IG_Spread] [float] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](max) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](max) NULL,
	[SourceKey] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [trl].[NFI_I_TriangleDistribution]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [trl].[NFI_R_Corr_Final]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [trl].[NFI_R_Corr_Final](
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
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](max) NOT NULL,
 CONSTRAINT [PK_NFI_R_Corr_Final] PRIMARY KEY CLUSTERED 
(
	[RKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [trl].[NFI_R_NCorr]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [trl].[NFI_R_NCorr](
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
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](max) NULL,
	[TrailCreatedDate] [datetime] NULL,
	[TrailCreatedBy] [varchar](max) NULL,
	[SourceKey] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [trl].[ParameterHistory]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_ALM_I_L_DiscountRate]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_ALM_I_L_DiscountRate] ON [dbo].[ALM_I_L_DiscountRate]
(
	[n] ASC,
	[t] ASC,
	[ResultSetNo] ASC,
	[RateType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_ALM_NC_FS_Change]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_ALM_NC_FS_Change] ON [dbo].[ALM_I_NC_FS_Change]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_ALM_R_A_ProjectedBenefitPayments]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_ALM_R_A_ProjectedBenefitPayments] ON [dbo].[ALM_R_A_ProjectedBenefitPayments]
(
	[n] ASC,
	[t] ASC,
	[ResultSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_ALM_R_A_ProjectedCashFlow]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_ALM_R_A_ProjectedCashFlow] ON [dbo].[ALM_R_A_ProjectedCashFlow]
(
	[n] ASC,
	[t] ASC,
	[ResultSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_ALM_R_A_ProjectedContributions]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_ALM_R_A_ProjectedContributions] ON [dbo].[ALM_R_A_ProjectedContributions]
(
	[n] ASC,
	[t] ASC,
	[ResultSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_ALM_R_A_ProjectedMVA]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_ALM_R_A_ProjectedMVA] ON [dbo].[ALM_R_A_ProjectedMVA]
(
	[n] ASC,
	[t] ASC,
	[ResultSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_ALM_R_A_ProjectedReqContributions]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_ALM_R_A_ProjectedReqContributions] ON [dbo].[ALM_R_A_ProjectedReqContributions]
(
	[n] ASC,
	[t] ASC,
	[RateType] ASC,
	[ResultSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_ALM_R_FR_Volatility]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_ALM_R_FR_Volatility] ON [dbo].[ALM_R_FR_Volatility]
(
	[n] ASC,
	[t] ASC,
	[ResultSetNo] ASC,
	[RateType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_ALM_R_L_ProjectedLiability]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_ALM_R_L_ProjectedLiability] ON [dbo].[ALM_R_L_ProjectedLiability]
(
	[n] ASC,
	[t] ASC,
	[ResultSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_AlternativeMixes]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_AlternativeMixes] ON [dbo].[AlternativeMixes]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC,
	[ResultSetNo] ASC,
	[MixName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_AssetClassReturn]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_AssetClassReturn] ON [dbo].[AssetClassReturn]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC,
	[AssetClass] ASC,
	[AssetGroup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_FI_I_AssetYields]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_FI_I_AssetYields] ON [dbo].[FI_I_AssetYields]
(
	[n] ASC,
	[t] ASC,
	[FIAsset] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_FI_I_BuildingBlocks]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_FI_I_BuildingBlocks] ON [dbo].[FI_I_BuildingBlocks]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_FI_I_Infl]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_FI_I_Infl] ON [dbo].[FI_I_Infl]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_FI_I_LongTermReturn]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_FI_I_LongTermReturn] ON [dbo].[FI_I_LongTermReturn]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_FI_I_RealReturn]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_FI_I_RealReturn] ON [dbo].[FI_I_RealReturn]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_FI_I_ShortTermReturn]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_FI_I_ShortTermReturn] ON [dbo].[FI_I_ShortTermReturn]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_FI_I_TermPremium]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_FI_I_TermPremium] ON [dbo].[FI_I_TermPremium]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_FI_R_Corr_Final]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_FI_R_Corr_Final] ON [dbo].[FI_R_Corr_Final]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_FI_R_CredPrem]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_FI_R_CredPrem] ON [dbo].[FI_R_CredPrem]
(
	[n] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_FI_R_Infl]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_FI_R_Infl] ON [dbo].[FI_R_Infl]
(
	[n] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_FI_R_RealReturn]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_FI_R_RealReturn] ON [dbo].[FI_R_RealReturn]
(
	[n] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_FI_R_StressReg]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_FI_R_StressReg] ON [dbo].[FI_R_StressReg]
(
	[n] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_FI_R_TermPremium]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_FI_R_TermPremium] ON [dbo].[FI_R_TermPremium]
(
	[n] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_TriangleDistribution]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_TriangleDistribution] ON [dbo].[NFI_I_TriangleDistribution]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC,
	[ReturnType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_NFI_R_Corr_Final]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_NFI_R_Corr_Final] ON [dbo].[NFI_R_Corr_Final]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_ResultSetLink]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_ResultSetLink] ON [dbo].[ResultSetLink]
(
	[n] ASC,
	[t] ASC,
	[ResultSetNo] ASC,
	[AssumptionSetNo] ASC,
	[RateType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_ALM_R_CF_NormalCost]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_ALM_R_CF_NormalCost] ON [tmp].[ALM_R_CF_NormalCost]
(
	[n] ASC,
	[t] ASC,
	[RateType] ASC,
	[ResultSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_ALM_R_CF_SF_DefPmt]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_ALM_R_CF_SF_DefPmt] ON [tmp].[ALM_R_CF_SF_DefPmt]
(
	[n] ASC,
	[t] ASC,
	[RateType] ASC,
	[ResultSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_ALM_R_L_AdjustedLiability_2]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_ALM_R_L_AdjustedLiability_2] ON [tmp].[ALM_R_L_AdjustedLiability]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC,
	[CashflowSetNo] ASC,
	[RateType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_FV_Schedule_CF]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_FV_Schedule_CF] ON [tmp].[FV_Schedule_CF]
(
	[n] ASC,
	[t] ASC,
	[cf_t] ASC,
	[AssumptionSetNo] ASC,
	[CashflowSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_FV_Schedule_CF_t]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_FV_Schedule_CF_t] ON [tmp].[FV_Schedule_CF]
(
	[n] ASC,
	[t] ASC,
	[cf_t] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_FV_Schedule_NC_FS]    Script Date: 2020-12-23 08:38:08 ******/
CREATE NONCLUSTERED INDEX [idx_FV_Schedule_NC_FS] ON [tmp].[FV_Schedule_NC_FS]
(
	[n] ASC,
	[t] ASC,
	[AssumptionSetNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[zzzMatrixA]  WITH CHECK ADD CHECK  (([i]>=(1) AND [i]<=(10)))
GO
ALTER TABLE [dbo].[zzzMatrixA]  WITH CHECK ADD CHECK  (([k]>=(1) AND [k]<=(10)))
GO
/****** Object:  StoredProcedure [dbo].[Create_AssumpSet]    Script Date: 2020-12-23 08:38:08 ******/
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
--				   <Added logging logic - 2020/02/05>
-- =============================================
CREATE PROCEDURE [dbo].[Create_AssumpSet] (@AssumptionSetDescript as varchar(1000), @DuplicateEconomicIndicators as varchar(3))
AS
BEGIN
	

	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Create Assumption Set'
	declare @ProcessStartDate as datetime = GETDATE()
		
	declare @itnCnt as int = 2000
	declare @UserAssumptionSetNo as int = ISNULL((select AssumptionSetNo from AssumptionSet where AssumptionSetDescript = @AssumptionSetDescript),
												 (select ISNULL(max(AssumptionSetNo),0) + 1 from AssumptionSet))
	
	if (select COUNT(*) from AssumptionSet where AssumptionSetDescript = @AssumptionSetDescript) > 0
	begin
		--Output
		select distinct 'Done' [Status], GETDATE() [StatusDate], ORIGINAL_LOGIN() [RunUser], @UserAssumptionSetNo [Output]

		exec WriteLog @UserAssumptionSetNo, 'Warning: AssumptionSet Already Exists - No Work Done', @ProcessStartDate, 0, @AssumptionSetDescript
	end
	else 
	begin
		--Output
		select distinct 'Done' [Status], GETDATE() [StatusDate], ORIGINAL_LOGIN() [RunUser], @UserAssumptionSetNo [Output]
		
		--Insert new line into AssumptionSet table
		insert into AssumptionSet (AssumptionSetNo, AssumptionSetDescript, CreatedDate, CreatedBy)
		select @UserAssumptionSetNo, @AssumptionSetDescript, GETDATE(), ORIGINAL_LOGIN();
	
		declare @RowCnt as float = (select COUNT(*) from AssumptionSet where AssumptionSetNo = @UserAssumptionSetNo)
		exec WriteLog @UserAssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @AssumptionSetDescript

		if @DuplicateEconomicIndicators = 'NO'
		begin	
		
			exec GenerateRandomNumbers @UserAssumptionSetNo, 'Inflation', @itnCnt
			exec GenerateRandomNumbers @UserAssumptionSetNo, 'Real Return', @itnCnt
			exec GenerateRandomNumbers @UserAssumptionSetNo, 'Term Premium', @itnCnt
			exec GenerateRandomNumbers @UserAssumptionSetNo, 'Credit Premium', @itnCnt
			exec GenerateRandomNumbers @UserAssumptionSetNo, 'Stressed Regime', @itnCnt
		
			--NFI Non-Correlated
			exec WriteLog @UserAssumptionSetNo, 'Message: Generating NFI Random Numbers', @ProcessStartDate, 0, @AssumptionSetDescript

			exec GenerateRandomNumbersNFI @UserAssumptionSetNo, @itnCnt

			exec WriteLog @UserAssumptionSetNo, 'Message: Kris is adding this step', @ProcessStartDate, 0, @AssumptionSetDescript
			
			exec GenerateRandomNumbersFI @UserAssumptionSetNo, @itnCnt

			--NFI Correlated (Done in VBA)
			--NFI Correlated (Normalized - Done in VBA)
		end
		else 
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
		
		end
	end	

END
GO
/****** Object:  StoredProcedure [dbo].[Create_CashflowSet]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/12/10>
-- Description:	<Stored procedure for creating Cashflow Sets>

-- Updated date: <2020/01/27>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <Updated the stored procedure to allow for simplified front-end - 2020/01/27>
--				   <Updated the stored procedure to have default checking values if no CFS loaded (else it loads nothing) - 2020/05/25>
-- =============================================
CREATE PROCEDURE [dbo].[Create_CashflowSet] (@CashflowDescript as varchar(1000), @AssumptionSetNo as int,
											@AssPopulationChange as float, @AssSalaryInflation as float,
											@CashflowSetNo as Int = NULL,
											@ClientName as varchar(MAX) = 'No Client Name Provided')
AS
BEGIN
	
	-- Testing Parameters
	/*
	declare @CashflowDescript as varchar(MAX) = 'Testing'
	declare @ClientName as varchar(MAX) = 'Testing'
	declare @AssumptionSetNo as int = 3
	declare @AssPopulationChange as float = 0.01
	declare @AssSalaryInflation as float = 0.01
	declare @CashflowSetNo as int = 1
	*/

	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Create Cash Flow Set'
	declare @OverallProcessStartDate as datetime = GETDATE()
	declare @ProcessStartDate as datetime = GETDATE()
	declare @RowCnt as float 
	declare @ProcessVariable as varchar(MAX)

	--*******************************
	set @ProcessStartDate = GETDATE()
	exec WriteLog 99, 'Message: Create Cash Flow Set - Start', @ProcessStartDate, 0
	--*******************************

	if OBJECT_ID('tempdb..#tmpCF') IS NOT NULL
		drop table #tmpCF
	
		select distinct CashflowSetNo
		into #tmpCF
		from CashflowSet

	--Check if a single set or multiple sets are being uploaded
	if (select MAX(ISNULL(CashflowSetNo,0)) from tmp.ALM_I_L_CashFlow) = 0
	begin

		--Assign cashflowset #
		declare @UserCashflowSetNo as int = ISNULL(@CashflowSetNo,(select ISNULL(max(CashflowSetNo),0) + 1 from CashflowSet))
		
		Update lcf
		set CashflowSetNo = @UserCashflowSetNo
		from tmp.ALM_I_L_CashFlow lcf
		where lcf.CashflowSetNo is NULL

		Update lcf
		set CashflowSetNo = @UserCashflowSetNo
		from tmp.ALM_I_A_AssetValueHistory lcf
		where lcf.CashflowSetNo is NULL

		insert into tmp.CashflowSet
		select @UserCashflowSetNo CashflowSetNo, @CashflowDescript CashflowSetDescript, @AssPopulationChange AssPopulationChange, @AssSalaryInflation AssSalaryInflation 
		from CashflowSet

		exec WriteLog 99, 'Message: CashflowSet Single Set Load', @ProcessStartDate, 0, @ProcessVariable
	end
	else
	begin			
		
		insert into tmp.CashflowSet
		select distinct CashflowSetNo, @CashflowDescript + '#' + CAST(CashflowSetNo as varchar) CashflowSetDescript, @AssPopulationChange AssPopulationChange, @AssSalaryInflation AssSalaryInflation
		from tmp.ALM_I_L_CashFlow lcf
		where not exists (select 1 from tmp.CashflowSet cf where cf.CashflowSetNo = lcf.CashflowSetNo)
				
		set @RowCnt = (select COUNT(*) from tmp.CashflowSet)
		exec WriteLog 99, 'Message: CashflowSet Multi-Set Load', @ProcessStartDate, @RowCnt, @ProcessVariable

	end
	
	declare @CursorCashFlowSetNo as int
	declare db_cursor cursor for
	select distinct CashflowSetNo
	from tmp.CashflowSet

	open db_cursor
	fetch next from db_cursor into @CursorCashFlowSetNo

	while @@FETCH_STATUS = 0  
	BEGIN

		print 'Compare CF set to previous Cash Flows'
		
		set @UserCashflowSetNo = (select ISNULL(max(CashflowSetNo),0) + 1 from CashflowSet)

		if OBJECT_ID('tempdb..#tmp1') IS NOT NULL
		drop table #tmp1

		--Compare tmp to dbo (Check if cashflowset is in database already)
		select sq.CashflowSetNo, 
				sum(Accrued_Diff)		[Total_Accrued_Diff], 
				sum(NormalCost_Diff)	[Total_NormalCost_Diff],		 
				sum(FutureService_Diff) [Total_FutureService_Diff], 
				sum(Contributions_Diff) [Total_Contributions_Diff],
				MAX(cf.AssPopulationChange) - @AssPopulationChange [AssPopulationChange],
				MAX(cf.AssSalaryInflation) - @AssSalaryInflation   [AssSalaryInflation],
				--Perfect Match Check
				case when abs(sum(Accrued_Diff) + sum(NormalCost_Diff) + sum(FutureService_Diff) + sum(Contributions_Diff)) < 1 
						and MAX(cf.AssPopulationChange) - @AssPopulationChange  = 0
						and MAX(cf.AssSalaryInflation) - @AssSalaryInflation  = 0
						then 1 else 0 end									[Perfect_Match],
				--Normal Cost Match Check
				case when abs(sum(NormalCost_Diff)) < 1 
						and MAX(cf.AssPopulationChange) - @AssPopulationChange  = 0
						and MAX(cf.AssSalaryInflation) - @AssSalaryInflation  = 0
						then 1 else 0 end									[NormalCost_Match]
		into #tmp1
		from (
			select dbo.CashflowSetNo, dbo.Year, 
				dbo.Accrued - tmp.Accrued_GC		  [Accrued_Diff], 
				dbo.NormalCost - tmp.NormalCost		  [NormalCost_Diff],
				dbo.FutureService - tmp.FutureService [FutureService_Diff], 
				dbo.Contributions - tmp.Contributions [Contributions_Diff]
			from dbo.ALM_I_L_CashFlow dbo
			inner join tmp.ALM_I_L_CashFlow tmp on tmp.Year = dbo.Year and tmp.CashflowSetNo = @CursorCashFlowSetNo
			where exists (select 1 from #tmpCF tcf where tcf.CashflowSetNo = dbo.CashflowSetNo)
		) sq
		inner join CashflowSet cf on cf.CashflowSetNo = sq.CashflowSetNo
		group by sq.CashflowSetNo
	
		--Partial Match - Duplicate initial normal cost run to save time
		if (select ISNULL(sum(NormalCost_Match), 0) from #tmp1) <> 0 and (select ISNULL(sum(Perfect_Match), 0) from #tmp1) = 0 
		begin
				print 'Partial Match - Duplicate initial normal cost run to save time'
			
				--Insert new line into CashflowSet table
				insert into CashflowSet (CashflowSetNo, CashflowSetDescript, CreatedDate, CreatedBy, AssPopulationChange, AssSalaryInflation, ClientName)
				select @UserCashflowSetNo, @CashflowDescript + ':' + CAST(@CursorCashFlowSetNo as varchar), GETDATE(), ORIGINAL_LOGIN(), @AssPopulationChange, @AssSalaryInflation, @ClientName
				where not exists (select 1 from CashflowSet cf where cf.CashflowSetNo = @UserCashflowSetNo)

				--Update the Liability Cashflows
				insert into dbo.ALM_I_L_CashFlow
				select @UserCashFlowSetNo [CashflowSetNo], [t], [Year], 'GC', [Accrued_GC], [NormalCost], [FutureService], [Contributions], GETDATE(), ORIGINAL_LOGIN()  
				from tmp.ALM_I_L_CashFlow
				where Accrued_GC > 0 and CashflowSetNo = @CursorCashFlowSetNo and
					not exists (select 1 from ALM_I_L_CashFlow cf where cf.CashflowSetNo = @UserCashflowSetNo)
							   
				--Update Asset History
				insert into dbo.ALM_I_A_AssetValueHistory(CashflowSetNo, t, Year, MVA_BOY, MVA_EOY, ExpectedIncome, ActualIncome, ExcessGains, CreatedDate, CreatedBy)
				select @UserCashflowSetNo, t, Year, MVA_BOY, MVA_EOY, ExpectedIncome, ActualIncome, ExcessGains, GETDATE(), ORIGINAL_LOGIN()
				from tmp.ALM_I_A_AssetValueHistory
				where MVA_BOY > 0 and CashflowSetNo = @CursorCashFlowSetNo and 
					not exists (select 1 from ALM_I_A_AssetValueHistory cf where cf.CashflowSetNo = @UserCashflowSetNo)
				
			/*


			--Copy the Normal Cost Projection
			drop index idx_ALM_R_L_AdjustedLiability on tmp.ALM_R_L_AdjustedLiability

			insert into tmp.ALM_R_L_AdjustedLiability (t, n, prj_t, NondiscountedValue, AssumptionSetNo, CashflowSetNo, RateType, CreatedDate, CreatedBy)
			select t, n, prj_t, NondiscountedValue, AssumptionSetNo, @UserCashflowSetNo, RateType, GETDATE(), 'Replicated from ' + CAST(CashflowSetNo as varchar)
			from tmp.ALM_R_L_AdjustedLiability
			where AssumptionSetNo = @AssumptionSetNo
				and CashflowSetNo = (select MIN(CashflowSetNo) from #tmp1 where NormalCost_Match = 1)

			create nonclustered index idx_ALM_R_L_AdjustedLiability on tmp.ALM_R_L_AdjustedLiability(n, t, prj_t, AssumptionSetNo, CashflowSetNo, RateType)

			*/
			--Write Log
			set @ProcessVariable = (select CashflowSetDescript from CashflowSet where CashflowSetNo = @UserCashflowSetNo)
			set @RowCnt = (select COUNT(*) from CashflowSet where CashflowSetNo = @UserCashFlowSetNo)
			exec WriteLog @UserCashFlowSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @ProcessVariable
			
			exec WriteLog @UserCashFlowSetNo, 'Message: CashflowSet Normal Cost Match Detected - Normal Cost Projection Copied', @ProcessStartDate, 0, @ProcessVariable

			set @RowCnt = (select COUNT(*) from ALM_I_L_CashFlow where CashflowSetNo = @UserCashFlowSetNo)
			exec WriteLog @UserCashFlowSetNo, 'Message: CashflowSet - Liability Cashflows Uploaded', @ProcessStartDate, @RowCnt, @ProcessVariable
				
			set @RowCnt = (select COUNT(*) from ALM_I_A_AssetValueHistory where CashflowSetNo = @UserCashFlowSetNo)
			exec WriteLog @UserCashFlowSetNo, 'Message: CashflowSet - Asset Value History Uploaded', @ProcessStartDate, @RowCnt, @ProcessVariable
		end
		begin
		--Perfect Match - Don't do anything
		if (select ISNULL(sum(Perfect_Match), 0) from #tmp1) <> 0 
		begin
				
			set @UserCashflowSetNo = (select MIN(CashflowSetNo) from #tmp1 where Perfect_Match = 1)
			exec WriteLog @UserCashFlowSetNo, 'Message: CashflowSet Match Detected - No Work Done', @ProcessStartDate, 0, @UserCashflowSetNo

		end
		if (select ISNULL(sum(NormalCost_Match), 0) from #tmp1) = 0 and (select ISNULL(sum(Perfect_Match), 0) from #tmp1) = 0 
		--No match, insert tmp to dbo
		begin
			
			print 'No Match Insert from tmp into dbo'

			--Insert new line into CashflowSet table
			insert into CashflowSet (CashflowSetNo, CashflowSetDescript, CreatedDate, CreatedBy, AssPopulationChange, AssSalaryInflation, ClientName)
			select @UserCashflowSetNo, @CashflowDescript + ':' + CAST(@CursorCashFlowSetNo as varchar), GETDATE(), ORIGINAL_LOGIN(), @AssPopulationChange, @AssSalaryInflation, @ClientName
			where not exists (select 1 from CashflowSet cf where cf.CashflowSetNo = @UserCashflowSetNo)

			--Update the Liability Cashflows
			insert into dbo.ALM_I_L_CashFlow
			select @UserCashFlowSetNo [CashflowSetNo], [t], [Year], 'GC', [Accrued_GC], [NormalCost], [FutureService], [Contributions], GETDATE(), ORIGINAL_LOGIN()  
			from tmp.ALM_I_L_CashFlow
			where Accrued_GC > 0 and CashflowSetNo = @CursorCashFlowSetNo and
				not exists (select 1 from ALM_I_L_CashFlow cf where cf.CashflowSetNo = @UserCashflowSetNo)
							   
			--Update Asset History
			insert into dbo.ALM_I_A_AssetValueHistory(CashflowSetNo, t, Year, MVA_BOY, MVA_EOY, ExpectedIncome, ActualIncome, ExcessGains, CreatedDate, CreatedBy)
			select @UserCashflowSetNo, t, Year, MVA_BOY, MVA_EOY, ExpectedIncome, ActualIncome, ExcessGains, GETDATE(), ORIGINAL_LOGIN()
			from tmp.ALM_I_A_AssetValueHistory
			where MVA_BOY > 0 and CashflowSetNo = @CursorCashFlowSetNo and 
				not exists (select 1 from ALM_I_A_AssetValueHistory cf where cf.CashflowSetNo = @UserCashflowSetNo)
				
			--Write Log
			set @ProcessVariable = (select CashflowSetDescript from CashflowSet where CashflowSetNo = @UserCashflowSetNo)
			set @RowCnt = (select COUNT(*) from CashflowSet where CashflowSetNo = @UserCashFlowSetNo)
			exec WriteLog @UserCashFlowSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @ProcessVariable
			exec WriteLog @UserCashFlowSetNo, 'Message: CashflowSet No Match Detected - Cashflow Uploaded', @ProcessStartDate, 0, @UserCashflowSetNo
				
			set @RowCnt = (select COUNT(*) from ALM_I_L_CashFlow where CashflowSetNo = @UserCashFlowSetNo)
			exec WriteLog @UserCashFlowSetNo, 'Message: CashflowSet - Liability Cashflows Uploaded', @ProcessStartDate, @RowCnt, @ProcessVariable
				
			set @RowCnt = (select COUNT(*) from ALM_I_A_AssetValueHistory where CashflowSetNo = @UserCashFlowSetNo)
			exec WriteLog @UserCashFlowSetNo, 'Message: CashflowSet - Asset Value History Uploaded', @ProcessStartDate, @RowCnt, @ProcessVariable
				
		end
	end

		fetch next from db_cursor into @CursorCashFlowSetNo
	END

	close db_cursor
	deallocate db_cursor

	--Calculate the CF Roll-forward here


	--Clear tmp tables
	truncate table tmp.CashflowSet
	truncate table tmp.ALM_I_L_CashFlow
	truncate table tmp.ALM_I_A_AssetValueHistory	

	--*******************************
	set @ProcessStartDate = GETDATE()
	exec WriteLog 99, 'Message: Create Cash Flow Set - End', @ProcessStartDate, 0
	--*******************************
	
	/*Test
	EXEC Create_CashflowSet @CashflowDescript, @AssumptionSetNo, @AssPopulationChange, @AssSalaryInflation
	EXEC Create_CashflowSet 'Test This Button', 1, 0.01, 0.01
	*/
END
GO
/****** Object:  StoredProcedure [dbo].[Create_ResultSet]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:			<Gerrit Marais>
-- Create date:		<2019/02/13>
-- Description:		<Stored procedure for creating ResultSet>

-- Updated date:	<2019/11/07>
-- Updated by:		<Gerrit Marais>
-- Updated reason:	<Add the Accounting Discount Rate Basis to the result link table>
--					<Altered the procedure to allow for the concept of a CashflowSetNo - 2019/11/07>
--					<Added logging logic - 2020/02/11>
--					<Added capability to run all bases using the same underlying Cashflows - 2020/05/20>	
-- =============================================
CREATE PROCEDURE [dbo].[Create_ResultSet] (@AssumptionSetNo as int, @CashflowSetNo as int, @MixName as varchar(255), @ResultSetDescript as varchar(255))
AS
BEGIN
	SET NOCOUNT ON;
	
	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Create Result Set'
	declare @ProcessStartDate as datetime = GETDATE()

	declare @UserResultSetNo as int = ISNULL((select ResultSetNo from ResultSet where AssumptionSetNo = @AssumptionSetNo and CashflowSetNo = @CashflowSetNo and MixName = @MixName),
											 (select ISNULL(max(ResultSetNo),0) + 1 from ResultSet))

	if (select COUNT(*) from ResultSet where ResultSetNo = @UserResultSetNo) > 0
	begin
		--Output
		exec WriteLog @UserResultSetNo, 'Warning: ResultSet Already Exists - No Work Done', @ProcessStartDate, 0, @ResultSetDescript
	end
	else 
	begin
		insert into ResultSet(ResultSetNo, AssumptionSetNo, CashflowSetNo, MixName, ResultSetDescript, CreatedDate, CreatedBy)
		select @UserResultSetNo, @AssumptionSetNo, @CashflowSetNo, @MixName, @ResultSetDescript, GetDate(), ORIGINAL_LOGIN()
	
		--Write to Log file
		declare @RowCnt as float = (select COUNT(*) from ResultSet where ResultSetNo = @UserResultSetNo)
		exec WriteLog @UserResultSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @ResultSetDescript
	end

	--=====================================================
	update rs
	set rs.UseSameCFAllBases = CASE WHEN sq.CNT = 1 THEN 'Yes' ELSE 'No' END
	from ResultSet rs
	left join (
		select CashflowSetNo, COUNT(DISTINCT RateType) Cnt 
		from ALM_I_L_CashFlow 
		where CashflowSetNo = @CashflowSetNo
		group by CashflowSetNo
		) sq on sq.CashflowSetNo = rs.CashflowSetNo and rs.ResultSetDescript = @ResultSetDescript
	--=====================================================
	--Check if Initial Liability Run was done
	update rs
	set rs.InitialCFRunDoneGC = 'No', rs.InitialCFRunDoneSOLV = 'No', rs.InitialCFRunDoneACC = 'No'
	from ResultSet rs
	
	--Solvency
	update rs
	set rs.InitialCFRunDoneSOLV = 'Yes'
	from ResultSet rs
	inner join (select AssumptionSetNo, CashflowSetNo, RateType, COUNT(*) Cnt, MAX(CreatedDate) IsProjectedDate
				from tmp.ALM_R_L_AdjustedLiability
				where RateType = 'SOLV'
				group by AssumptionSetNo, CashflowSetNo, RateType
				) sq on sq.AssumptionSetNo = rs.AssumptionSetNo 
					and sq.CashflowSetNo = rs.CashflowSetNo

	--Accounting
	update rs
	set rs.InitialCFRunDoneACC = 'Yes'
	from ResultSet rs
	inner join (select AssumptionSetNo, CashflowSetNo, RateType, COUNT(*) Cnt, MAX(CreatedDate) IsProjectedDate
				from tmp.ALM_R_L_AdjustedLiability
				where RateType = 'ACC'
				group by AssumptionSetNo, CashflowSetNo, RateType
				) sq on sq.AssumptionSetNo = rs.AssumptionSetNo 
					and sq.CashflowSetNo = rs.CashflowSetNo

	--Going Concern
	update rs
	set rs.InitialCFRunDoneGC = 'Yes',
		rs.InitialCFRunDoneSOLV = CASE WHEN rs.UseSameCFAllBases = 'Yes' THEN 'Yes' ELSE 'No' END,
		rs.InitialCFRunDoneACC = CASE WHEN rs.UseSameCFAllBases = 'Yes' THEN 'Yes' ELSE 'No' END
	from ResultSet rs
	inner join (select AssumptionSetNo, CashflowSetNo, RateType, MAX(CreatedDate) IsProjectedDate
				from tmp.ALM_R_L_AdjustedLiability
				where RateType = 'GC'
				group by AssumptionSetNo, CashflowSetNo, RateType
				) sq on sq.AssumptionSetNo = rs.AssumptionSetNo 
					and sq.CashflowSetNo = rs.CashflowSetNo
	--=====================================================
	
	truncate table ResultSetLink

	DROP INDEX idx_ResultSetLink on ResultSetLink

	--================================================
	insert into ResultSetLink(n, t, ResultSetNo, AssumptionSetNo, MixName, RateType, BasisType, ResultType, LinkKey, ResultLinkKey, ResultLinkKey2)
	select t1.n, (t2.n - 1) [t], ResultSetNo, AssumptionSetNo, MixName, 'GC' RateType, 'Going Concern' BasisType,
	MixName + ':GC:' + CAST(AssumptionSetNo as varchar) ResultType, 
	 CAST((t2.n - 1) as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar)  [LinkKey],
     CAST((t2.n - 1) as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar) + '#' +  CAST(ResultSetNo as varchar) + '#' + 'GC' [ResultLinkKey],
     CAST((t2.n - 1) as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar) + '#' +  CAST(ResultSetNo as varchar) [ResultLinkKey2]
	from dbo.Tally t1
	inner join dbo.Tally t2 on 1 = 1 
	inner join dbo.ResultSet t on 1 = 1
	where t1.n <= (select MAX(n) from FI_I_Infl i where i.AssumptionSetNo = t.AssumptionSetNo) and t2.n < 32

		union
	select t1.n, (t2.n - 1) [t], ResultSetNo, AssumptionSetNo, MixName, 'SOLV' RateType, 'Solvency' BasisType,
		MixName + ':SOLV:' + CAST(AssumptionSetNo as varchar) ResultType, 
		 CAST((t2.n - 1) as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar)  [LinkKey],
		 CAST((t2.n - 1) as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar) + '#' +  CAST(ResultSetNo as varchar) + '#' + 'SOLV' [ResultLinkKey],
		 CAST((t2.n - 1) as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar) + '#' +  CAST(ResultSetNo as varchar) [ResultLinkKey2]
	from dbo.Tally t1
	inner join dbo.Tally t2 on 1 = 1 
	inner join dbo.ResultSet t on 1 = 1
	where t1.n <= 2000 and t2.n < 32

			union
	select t1.n, (t2.n - 1) [t], ResultSetNo, AssumptionSetNo, MixName, 'ACC' RateType, 'Accounting' BasisType,
		MixName + ':ACC:' + CAST(AssumptionSetNo as varchar) ResultType, 
		 CAST((t2.n - 1) as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar)  [LinkKey],
		 CAST((t2.n - 1) as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar) + '#' +  CAST(ResultSetNo as varchar) + '#' + 'ACC' [ResultLinkKey],
		 CAST((t2.n - 1) as varchar) + '#' + CAST(t1.n as varchar) + '#' + CAST(AssumptionSetNo as varchar) + '#' +  CAST(ResultSetNo as varchar) [ResultLinkKey2]
	from dbo.Tally t1
	inner join dbo.Tally t2 on 1 = 1 
	inner join dbo.ResultSet t on 1 = 1
	where t1.n <= 2000 and t2.n < 32
	--================================================

	CREATE NONCLUSTERED INDEX idx_ResultSetLink on ResultSetLink(n, t, ResultSetNo, AssumptionSetNo, RateType)

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
/****** Object:  StoredProcedure [dbo].[Empty_AssumptionSet]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/09/30>
-- Description:	<Stored procedure for clearing AssumptionSet>

-- Updated date:	<2020/02/11>
-- Updated by:		<Gerrit Marais>
-- Updated reason:	<Added logging logic - 2020/02/11>
--					<Added delete statement for building block tables - 2020/12/21>
-- =============================================
CREATE PROCEDURE [dbo].[Empty_AssumptionSet] ( @AssumptionSetNo as int, @DeleteTrailTables as varchar(3))
AS
BEGIN

	SET NOCOUNT ON;

	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Empty AssumptionSet'
	declare @ProcessStartDate as datetime = GETDATE()

	declare @UserAssumptionSetNo as int = @AssumptionSetNo

	--Clean the Parameter History
	delete from ParameterHistory where ParameterProc = 'GenerateProjectedTermPremium' and AssumptionSetNo =  @UserAssumptionSetNo
	delete from ParameterHistory where ParameterProc = 'GenerateProjectedInflation' and AssumptionSetNo =  @UserAssumptionSetNo
	delete from ParameterHistory where ParameterProc = 'GenerateProjectedRealReturn' and AssumptionSetNo =  @UserAssumptionSetNo
	delete from ParameterHistory where ParameterProc = 'GenerateProjectedCreditSpread' and AssumptionSetNo =  @UserAssumptionSetNo
	delete from ParameterHistory where ParameterProc = 'GenerateProjectedSalaryIncreases' and AssumptionSetNo =  @UserAssumptionSetNo
	delete from ParameterHistory where (ParameterProc like 'GenerateProjectedNFIReturn%' 
									 or ParameterProc like 'GenerateProjectedFIReturn%'
									 or ParameterProc like 'GenerateProjectedBuildingBlock%'
									 or ParameterProc like 'GenerateProjectedFIReturn_BB%'
									 or ParameterProc like 'GenerateProjectedFIReturnCombinedYields_BB%'
									 or ParameterProc like 'GenerateProjectedDerivativeReturn%'
									 or ParameterProc like 'GenerateNFITriangleDistribution%') and AssumptionSetNo =  @UserAssumptionSetNo

	--Trail tables
	if @DeleteTrailTables = 'YES'
	begin

		delete from trl.FI_R_All where AssumptionSetNo = @UserAssumptionSetNo
		delete from trl.FI_R_NCorr where AssumptionSetNo = @UserAssumptionSetNo
		delete from trl.FI_R_Corr_Final where AssumptionSetNo = @UserAssumptionSetNo

		delete from trl.NFI_R_NCorr where AssumptionSetNo = @UserAssumptionSetNo
		delete from trl.NFI_R_Corr_Final where AssumptionSetNo = @UserAssumptionSetNo
		delete from trl.NFI_I_TriangleDistribution where AssumptionSetNo = @UserAssumptionSetNo

	end
	
	--AssumptionSet Definition		
	delete from AssumptionSet where AssumptionSetNo = @UserAssumptionSetNo
	
	--Random Numbers
	delete from FI_R_Infl where AssumptionSetNo = @UserAssumptionSetNo	
	delete from FI_R_RealReturn where AssumptionSetNo = @UserAssumptionSetNo
	delete from FI_R_TermPremium where AssumptionSetNo = @UserAssumptionSetNo
	delete from FI_R_CredPrem where AssumptionSetNo = @UserAssumptionSetNo
	delete from FI_R_StressReg where AssumptionSetNo = @UserAssumptionSetNo

	delete from NFI_R_NCorr where AssumptionSetNo = @UserAssumptionSetNo
	delete from NFI_R_Corr where AssumptionSetNo = @UserAssumptionSetNo
	delete from NFI_R_Corr_Final where AssumptionSetNo = @UserAssumptionSetNo

	--Economic Indicators
	delete from FI_I_Infl where AssumptionSetNo = @UserAssumptionSetNo
	delete from FI_I_RealReturn where AssumptionSetNo = @UserAssumptionSetNo
	delete from FI_I_ShortTermReturn where AssumptionSetNo = @UserAssumptionSetNo
	delete from FI_I_TermPremium where AssumptionSetNo = @UserAssumptionSetNo
	delete from FI_I_LongTermReturn where AssumptionSetNo = @UserAssumptionSetNo
	delete from FI_I_CreditSpread where AssumptionSetNo = @UserAssumptionSetNo

	delete from NFI_I_TriangleDistribution where AssumptionSetNo = @UserAssumptionSetNo
	delete from AssetClassReturn where AssumptionSetNo = @UserAssumptionSetNo
	delete from AssetClass where AssumptionSetNo = @UserAssumptionSetNo
	
	delete from ALM_Salary_Increase where AssumptionSetNo = @UserAssumptionSetNo
	delete from ALM_I_NC_FS_Change where AssumptionSetNo = @UserAssumptionSetNo

	--Temp tables that assist in the calculations
	delete from [tmp].[FV_Schedule_CF] where AssumptionSetNo = @UserAssumptionSetNo
	delete from [tmp].[FV_Schedule_NC_FS] where AssumptionSetNo = @UserAssumptionSetNo

	--New tables from Building Block Calculations
	--Random Numbers
	delete from FI_R_NCorr where AssumptionSetNo = @UserAssumptionSetNo
	delete from FI_R_Corr where AssumptionSetNo = @UserAssumptionSetNo
	delete from FI_R_Corr_Final where AssumptionSetNo = @UserAssumptionSetNo

	--Building Blocks
	delete from FI_I_BuildingBlocks where AssumptionSetNo = @UserAssumptionSetNo

	--Yields and Returns
	delete from FI_I_AssetYields where AssumptionSetNo = @UserAssumptionSetNo
	
	--Write to Log file
	declare @RowCnt as float = 0
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @DeleteTrailTables

	--Reindex the Keys in the database
	declare @sql as nvarchar(max)	
	
	--AssumptionSet
	declare @DBTable as varchar(MAX) = 'AssumptionSet'
	declare @DBTable_new_reseed_value as int = (select MAX(AssumptionSetKey) from AssumptionSet)

	set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
	execute sp_executesql @sql 

	--FI_I_Infl
	set @DBTable = 'FI_I_Infl'
	set @DBTable_new_reseed_value = (select MAX(InflKey) from FI_I_Infl)

	set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
	execute sp_executesql @sql

	--FI_I_RealReturn
	set @DBTable = 'FI_I_RealReturn'
	set @DBTable_new_reseed_value = (select MAX(RealReturnKey) from FI_I_RealReturn)

	set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
	execute sp_executesql @sql

	--FI_I_ShortTermReturn
	set @DBTable = 'FI_I_ShortTermReturn'
	set @DBTable_new_reseed_value = (select MAX(STReturnKey) from FI_I_ShortTermReturn)

	set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
	execute sp_executesql @sql

	--FI_I_TermPremium
	set @DBTable = 'FI_I_TermPremium'
	set @DBTable_new_reseed_value = (select MAX(TermPremiumKey) from FI_I_TermPremium)

	set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
	execute sp_executesql @sql

	--FI_I_LongTermReturn
	set @DBTable = 'FI_I_LongTermReturn'
	set @DBTable_new_reseed_value = (select MAX(LTReturnKey) from FI_I_LongTermReturn)

	set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
	execute sp_executesql @sql

	--FI_I_CreditSpread
	set @DBTable = 'FI_I_CreditSpread'
	set @DBTable_new_reseed_value = (select MAX(CreditSpreadKey) from FI_I_CreditSpread)

	set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
	execute sp_executesql @sql
	
	--AssetClassReturn
	set @DBTable = 'AssetClassReturn'
	set @DBTable_new_reseed_value = (select MAX(AssetClassReturnKey) from AssetClassReturn)

	set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
	execute sp_executesql @sql

	--AssetClass
	set @DBTable = 'AssetClass'
	set @DBTable_new_reseed_value = (select MAX(AssetClassKey) from AssetClass)

	set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
	execute sp_executesql @sql

	--Building Blocks
	set @DBTable = 'FI_I_BuildingBlocks'
	set @DBTable_new_reseed_value = (select MAX(BBKey) from FI_I_BuildingBlocks)

	set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
	execute sp_executesql @sql

	--Fixed Income Asset Yields
	set @DBTable = 'FI_I_AssetReturnsBB'
	set @DBTable_new_reseed_value = (select MAX(FIAssetKey) from FI_I_AssetReturnsBB)

	set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
	execute sp_executesql @sql

	--Fixed Income Asset Yields
	set @DBTable = 'FI_I_AssetYields'
	set @DBTable_new_reseed_value = (select MAX(FIAssetKey) from FI_I_AssetReturnsBB)

	set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
	execute sp_executesql @sql

	--exec Empty_AssumptionSet 3, 'YES'

END
GO
/****** Object:  StoredProcedure [dbo].[Empty_CashflowSet]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2020/01/29>
-- Description:	<Stored procedure for clearing CashFlowSet>

-- Updated date:	<2020/02/11>
-- Updated by:		<Gerrit Marais>
-- Updated reason:	<Added logging logic - 2020/02/11>
-- =============================================
CREATE PROCEDURE [dbo].[Empty_CashflowSet] ( @CashflowSetNo as int, @DeleteTrailTables as varchar(3))
AS
BEGIN

	SET NOCOUNT ON;

	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Empty CashflowSet'
	declare @ProcessStartDate as datetime = GETDATE()

	declare @UserCashflowSetNo as int = @CashflowSetNo

	--Delete from the CashflowSet table where already exists
	delete from CashflowSet where CashflowSetNo = @UserCashflowSetNo

	--Delete from the cash flow table where already exists
	delete from dbo.ALM_I_L_Cashflow where CashflowSetNo = @UserCashflowSetNo
	
	--Delete from the Asset Value table where already exists
	delete from dbo.ALM_I_A_AssetValueHistory where CashflowSetNo = @UserCashflowSetNo
	
	--Delete from the projection table where already exists
	delete from tmp.ALM_R_L_AdjustedLiability where CashflowSetNo = @UserCashflowSetNo
	
	declare @RowCnt as float = 0
	exec WriteLog @CashflowSetNo, @ProcessName, @ProcessStartDate, @RowCnt

	--=====================================================
	--Check if Initial Liability Run was done
	update rs
	set rs.InitialCFRunDoneGC = 'No', rs.InitialCFRunDoneSOLV = 'No', rs.InitialCFRunDoneACC = 'No'
	from ResultSet rs
	
	--Solvency
	update rs
	set rs.InitialCFRunDoneSOLV = 'Yes'
	from ResultSet rs
	inner join (select AssumptionSetNo, CashflowSetNo, RateType, COUNT(*) Cnt, MAX(CreatedDate) IsProjectedDate
				from tmp.ALM_R_L_AdjustedLiability
				where RateType = 'SOLV'
				group by AssumptionSetNo, CashflowSetNo, RateType
				) sq on sq.AssumptionSetNo = rs.AssumptionSetNo 
					and sq.CashflowSetNo = rs.CashflowSetNo

	--Accounting
	update rs
	set rs.InitialCFRunDoneACC = 'Yes'
	from ResultSet rs
	inner join (select AssumptionSetNo, CashflowSetNo, RateType, COUNT(*) Cnt, MAX(CreatedDate) IsProjectedDate
				from tmp.ALM_R_L_AdjustedLiability
				where RateType = 'ACC'
				group by AssumptionSetNo, CashflowSetNo, RateType
				) sq on sq.AssumptionSetNo = rs.AssumptionSetNo 
					and sq.CashflowSetNo = rs.CashflowSetNo

	--Going Concern
	update rs
	set rs.InitialCFRunDoneGC = 'Yes',
		rs.InitialCFRunDoneSOLV = CASE WHEN rs.UseSameCFAllBases = 'Yes' THEN 'Yes' ELSE 'No' END,
		rs.InitialCFRunDoneACC = CASE WHEN rs.UseSameCFAllBases = 'Yes' THEN 'Yes' ELSE 'No' END
	from ResultSet rs
	inner join (select AssumptionSetNo, CashflowSetNo, RateType, COUNT(*) Cnt, MAX(CreatedDate) IsProjectedDate
				from tmp.ALM_R_L_AdjustedLiability
				where RateType = 'GC'
				group by AssumptionSetNo, CashflowSetNo, RateType
				) sq on sq.AssumptionSetNo = rs.AssumptionSetNo 
					and sq.CashflowSetNo = rs.CashflowSetNo
	--=====================================================
	--exec Empty_CashflowSet 2, 'YES'

END
GO
/****** Object:  StoredProcedure [dbo].[Empty_Database]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/02/13>
-- Description:	<Stored procedure for clearing the database>

-- Updated date:	<2020/02/11>
-- Updated by:		<Gerrit Marais>
-- Updated reason:	<Added logging logic - 2020/02/11>
--					<Added tables for Building Block Approach - 2020/12/21>
-- =============================================
CREATE PROCEDURE [dbo].[Empty_Database] ( @DeleteParameters as varchar(1000), @DeleteInputs as varchar(1000), @DeleteTrailTables as varchar(1000))
AS
BEGIN

	SET NOCOUNT ON;

	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Empty Database'
	declare @ProcessStartDate as datetime = GETDATE()
	   
	if @DeleteTrailTables = 'YES'
	begin
		
		truncate table trl.FI_R_All
		truncate table trl.NFI_R_NCorr
		truncate table trl.NFI_R_Corr_Final
		
		truncate table trl.NFI_I_TriangleDistribution
		
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

		--Liability Modelling Assumptions
		truncate table ALM_Salary_Increase
		truncate table ALM_I_NC_FS_Change	
		truncate table ALM_I_COLA

		--Asset Classes
		truncate table NFI_I_TriangleDistribution
		truncate table AssetClassReturn

		--Building Block Approach
		--Random Numbers
		truncate table FI_R_NCorr
		truncate table FI_R_Corr
		truncate table FI_R_Corr_Final

		--Building Blocks
		truncate table FI_I_BuildingBlocks

		--Yields and Returns
		truncate table FI_I_AssetYields

		--CashflowSet
		truncate table CashflowSet

		--ResultSet
		truncate table ResultSet
		truncate table ResultSetLink
		
		--Portfolio Returns
		truncate table AlternativeMixes
		
		--ALM Modelling Assumptions
		truncate table ALM_I_L_DiscountRate
		
		--Temp tables that assist in calculations
		truncate table tmp.FV_Schedule_NC_FS
		truncate table tmp.FV_Schedule_CF
		truncate table tmp.ALM_R_L_AdjustedLiability
		truncate table tmp.ALM_R_CF_SF_DefPmt
		truncate table tmp.ALM_R_CF_NormalCost
		truncate table tmp.ALM_R_A_ProjectedMVA_PBI

		--Liability Values
		truncate table ALM_R_L_ProjectedLiability
		
		--Asset Values and Cash Flow
		truncate table ALM_R_A_ProjectedBenefitPayments
		truncate table ALM_R_A_ProjectedContributions
		truncate table ALM_R_A_ProjectedReqContributions
		truncate table ALM_R_A_ProjectedCashFlow
		truncate table ALM_R_A_ProjectedMVA
		
		--Worked Results
		truncate table ALM_R_FR_Volatility

		--Other tables
		truncate table ParameterHistory
		
	end

	if @DeleteInputs = 'YES'
	begin
		--Random Tables
		truncate table FI_R_CredPrem
		truncate table FI_R_Infl
		truncate table FI_R_RealReturn
		truncate table FI_R_StressReg
		truncate table FI_R_TermPremium
		
		--User imported tables
		--Correlations Between Asset Classes (After Cholesky Decomposition)
		truncate table NFI_R_Corr
		truncate table NFI_R_NCorr
		truncate table NFI_R_Corr_Final
		
		truncate table ALM_I_L_CashFlow
		truncate table ALM_I_A_AssetValueHistory
		
	end

	--Write Log
	declare @RowCnt as float = 0
	exec WriteLog 99, @ProcessName, @ProcessStartDate, @RowCnt, @DeleteTrailTables

	/*
	Test
	exec Empty_Database @DeleteParameters @DeleteInputs
	exec Empty_Database 'YES', 'YES', 'YES'
	*/

END
GO
/****** Object:  StoredProcedure [dbo].[Empty_ResultSet]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/02/13>
-- Description:	<Stored procedure for clearing ResultSet>

-- Updated date: <2020/02/25>
-- Updated by:	 <Gerrit Marais>
--				 <Added logic to stop execution if ResultSet is Finalized - 2020/02/25>
-- =============================================
CREATE PROCEDURE [dbo].[Empty_ResultSet] ( @ResultSetNo as int, @DeleteTrailTables as varchar(3))
AS
BEGIN

	SET NOCOUNT ON;

	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Empty ResultSet'
	declare @ProcessStartDate as datetime = GETDATE()
	
	--Stop stored procedure if results are finalized
	if (select IsFinalizedBy from ResultSet where ResultSetNo = @ResultSetNo) IS NOT NULL
		begin	
			exec WriteLog @ResultSetNo, 'Warning: ResultSet Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName
		end	
	else
		begin
			--Testing
			--exec Empty_ResultSet 6, 'YES'

			--Clean the Parameter History
			delete
			from ParameterHistory
			where ParameterProc like 'GenerateProjectedPortfolioReturn%' 
				and LTRIM(RTRIM(RIGHT(ParameterProc, LEN(RTRIM(LTRIM(ParameterProc))) - 33))) = (select MixName from ResultSet where ResultSetNo = @ResultSetNo)

			--Trail tables
			if @DeleteTrailTables = 'YES'
			begin

				delete from [trl].[AlternativeMixes] where ResultSetNo = @ResultSetNo
	
				delete from [trl].[ALM_R_A_ProjectedBenefitPayments] where ResultSetNo = @ResultSetNo
				delete from [trl].[ALM_R_A_ProjectedContributions] where ResultSetNo = @ResultSetNo	 
				delete from [trl].[ALM_R_A_ProjectedCashFlow] where ResultSetNo = @ResultSetNo			
				delete from [trl].[ALM_R_A_ProjectedMVA] where ResultSetNo = @ResultSetNo

			end

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
			delete from ALM_R_A_ProjectedReqContributions where ResultSetNo = @ResultSetNo
			delete from ALM_R_A_ProjectedCashFlow where ResultSetNo = @ResultSetNo
			delete from ALM_R_A_ProjectedMVA where ResultSetNo = @ResultSetNo
				
			--Worked Results
			delete from ALM_R_FR_Volatility where ResultSetNo = @ResultSetNo

			--Write Log
			declare @RowCnt as float = 0
			exec WriteLog @ResultSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @DeleteTrailTables

			--Reindex the Keys in the database
			declare @sql as nvarchar(max)	
	
			--ResultSet
			declare @DBTable as varchar(MAX) = 'ResultSet'
			declare @DBTable_new_reseed_value as int = (select MAX(ResultSetKey) from ResultSet)

			set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
			execute sp_executesql @sql 
			
			--AlternativeMixes
			set @DBTable = 'AlternativeMixes'
			set @DBTable_new_reseed_value = (select MAX(AMKey) from AlternativeMixes)

			set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
			execute sp_executesql @sql 

			--ALM_I_L_DiscountRate
			set @DBTable = 'ALM_I_L_DiscountRate'
			set @DBTable_new_reseed_value = (select MAX(DRKey) from ALM_I_L_DiscountRate)

			set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
			execute sp_executesql @sql 

			--ALM_R_L_ProjectedLiability
			set @DBTable = 'ALM_R_L_ProjectedLiability'
			set @DBTable_new_reseed_value = (select MAX(PLKey) from ALM_R_L_ProjectedLiability)

			set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
			execute sp_executesql @sql 
						
			--ALM_R_A_ProjectedBenefitPayments
			set @DBTable = 'ALM_R_A_ProjectedBenefitPayments'
			set @DBTable_new_reseed_value = (select MAX(BPKey) from ALM_R_A_ProjectedBenefitPayments)

			set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
			execute sp_executesql @sql 

			--ALM_R_A_ProjectedContributions
			set @DBTable = 'ALM_R_A_ProjectedContributions'
			set @DBTable_new_reseed_value = (select MAX(PCKey) from ALM_R_A_ProjectedContributions)

			set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
			execute sp_executesql @sql 

			--ALM_R_A_ProjectedReqContributions
			set @DBTable = 'ALM_R_A_ProjectedReqContributions'
			set @DBTable_new_reseed_value = (select MAX(PCKey) from ALM_R_A_ProjectedReqContributions)

			set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
			execute sp_executesql @sql 

			--ALM_R_A_ProjectedCashFlow
			set @DBTable = 'ALM_R_A_ProjectedCashFlow'
			set @DBTable_new_reseed_value = (select MAX(CFKey) from ALM_R_A_ProjectedCashFlow)

			set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
			execute sp_executesql @sql 

			--ALM_R_A_ProjectedMVA	
			set @DBTable = 'ALM_R_A_ProjectedMVA'
			set @DBTable_new_reseed_value = (select MAX(MVAKey) from ALM_R_A_ProjectedMVA)

			set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
			execute sp_executesql @sql 

			--ALM_R_FR_Volatility
			set @DBTable = 'ALM_R_FR_Volatility'
			set @DBTable_new_reseed_value = (select MAX(SigmaFRKey) from ALM_R_FR_Volatility)

			set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
			execute sp_executesql @sql 

		end
END
GO
/****** Object:  StoredProcedure [dbo].[FinalizeAssetClass]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2020/02/24>
-- Description:	<Stored procedure for finalizing the AssumptionSet>

-- Updated date: <>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <>
-- =============================================
CREATE PROCEDURE [dbo].[FinalizeAssetClass] (@AssumptionSetNo as int, @AssetClass as varchar(255))
AS
BEGIN

	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Finalize Asset Class'
	declare @ProcessStartDate as datetime = GETDATE()

	update r
	set r.IsFinalizedDate = GETDATE(), r.IsFinalizedBy = ORIGINAL_LOGIN()
	from AssetClass r
	where AssumptionSetNo = @AssumptionSetNo and AssetClass = @AssetClass

	--Write to Log file
	declare @RowCnt as float = 1
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @AssetClass
	
END
GO
/****** Object:  StoredProcedure [dbo].[FinalizeAssumptionSet]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2020/02/24>
-- Description:	<Stored procedure for finalizing the AssumptionSet>

-- Updated date: <>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <>
-- =============================================
CREATE PROCEDURE [dbo].[FinalizeAssumptionSet] (@AssumptionSetNo as int)
AS
BEGIN

	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Finalize AssumptionSet'
	declare @ProcessStartDate as datetime = GETDATE()

	update r
	set r.IsFinalizedDate = GETDATE(), r.IsFinalizedBy = ORIGINAL_LOGIN()
	from AssumptionSet r
	where AssumptionSetNo = @AssumptionSetNo

	--Write to Log file
	declare @RowCnt as float = 1
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt, 'Finalized'
	
END

GO
/****** Object:  StoredProcedure [dbo].[FinalizeCashflowSet]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2020/02/24>
-- Description:	<Stored procedure for finalizing the CashflowSet>

-- Updated date: <>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <>
-- =============================================
CREATE PROCEDURE [dbo].[FinalizeCashflowSet] (@CashflowSetNo as int)
AS
BEGIN

	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Finalize CashFlowSet'
	declare @ProcessStartDate as datetime = GETDATE()

	update r
	set r.IsFinalizedDate = GETDATE(), r.IsFinalizedBy = ORIGINAL_LOGIN()
	from CashFlowSet r
	where CashflowSetNo = @CashflowSetNo

	--Write to Log file
	declare @RowCnt as float = 1
	exec WriteLog @CashflowSetNo, @ProcessName, @ProcessStartDate, @RowCnt, 'Finalized'
	
END

GO
/****** Object:  StoredProcedure [dbo].[FinalizeResultSet]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2020/02/24>
-- Description:	<Stored procedure for finalizing the ResultSet>

-- Updated date:    <2020/02/25>
-- Updated by:	    <Gerrit Marais>
-- Updated reason:  <Added logic to stop execution if ResultSet is Finalized - 2020/02/25>
-- =============================================
CREATE PROCEDURE [dbo].[FinalizeResultSet] (@ResultSetNo as int)
AS
BEGIN

	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Finalize ResultSet'
	declare @ProcessStartDate as datetime = GETDATE()

	--Stop stored procedure if results are finalized
	if (select IsFinalizedBy from ResultSet where ResultSetNo = @ResultSetNo) IS NOT NULL
		begin	
			exec WriteLog @ResultSetNo, 'Warning: ResultSet Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName
		end	
	else
		begin

			update r
			set r.IsFinalizedDate = GETDATE(), r.IsFinalizedBy = ORIGINAL_LOGIN()
			from ResultSet r
			where ResultSetNo = @ResultSetNo

			--Write to Log file
			declare @RowCnt as float = 1
			exec WriteLog @ResultSetNo, @ProcessName, @ProcessStartDate, @RowCnt, 'Finalized'
		end
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateNFITriangleDistribution]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/01/02>
-- Description:	<Stored procedure for creating projecting future term premium (TP) numbers>

-- Updated date:	<2020/02/11>
-- Updated by:		<Gerrit Marais>
-- Updated reason:	<Added logging logic - 2020/02/11>

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

		--Logging Parameters
		declare @ProcessName as varchar(MAX) = 'Non-Fixed Income Assets (Triangle Distribution)'
		declare @ProcessStartDate as datetime = GETDATE()
	
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
		
		drop index idx_TriangleDistribution on NFI_I_TriangleDistribution

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
		
		create nonclustered index idx_TriangleDistribution on NFI_I_TriangleDistribution(n, t, AssumptionSetNo, ReturnType)

			--Write to Log file
		declare @RowCnt as float = (select COUNT(*) from NFI_I_TriangleDistribution where AssumptionSetNo = @AssumptionSetNo and ReturnType = @ReturnType)
		exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @ReturnType

		/*
		--User Feedback
		select distinct 'Done' [Status], GETDATE() [StatusDate], 'If you have finished entering all 8 triangle distributions. Next Step - Generate Projected Non-Fixed Income Returns' [Next Steps]
		*/	
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
/****** Object:  StoredProcedure [dbo].[GenerateProjectedBorrowingCost]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Justin Saw>
-- Create date: <2019/09/12>
-- Description:	<Stored procedure for creating projected future borrowing cost>

-- Updated date:	<2020/02/11>
-- Updated by:		<Gerrit Marais>
-- Updated reason:	<Added logging logic - 2020/02/11>

-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedBorrowingCost] (@ST_adj as varchar(1000), @min as varchar(1000), @AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;
    
	--Borrowing Cost (T bill) = MAX ( Short Term Return - ST_adj, min)
	--Parameters
	/*
	declare @ST_adj as float = -0.01
	declare @min as float = 0.0025

	declare @AssumptionSetNo as int = 1

	*/
	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Borrowing Cost'
	declare @ProcessStartDate as datetime = GETDATE()
	
	
	declare @ProcName as varchar(255) = 'GenerateProjectedFIReturn' + ':' + 'Borrowing Cost'

	--Delete from table (if exists)
	delete from AssetClassReturn where AssumptionSetNo = @AssumptionSetNo and AssetClass = 'Borrowing Cost'
		
	/*	
	--Write to trail table (if exists)
	set @sql = 'insert into trl.NFI_AC_' + @ReturnType + '(n, t, Normal, Stressed, Combined, AssumptionSetNo, OriginalCreatedDate, OriginalCreatedBy, TrailCreatedDate, TrailCreatedBy, SourceKey)
				select n, t, Normal, Stressed, Combined, AssumptionSetNo, CreatedDate [OriginalCreatedDate], CreatedBy [OriginalCreatedBy],
				GETDATE(), ORIGINAL_LOGIN(), ' + @ReturnType + 'Key
				from NFI_AC_' + @ReturnType + '
				where AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + '
				order by t, n'

	execute sp_executesql @sql
	*/
	--Delete from table (if exists)
	delete from AssetClassReturn where AssumptionSetNo = @AssumptionSetNo and AssetClass = 'Borrowing Cost'

	--Trail for Parameter
	insert into trl.ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy, TrailCreatedDate, TrailCreatedBy, SourceKey)
	select AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy, GETDATE(), ORIGINAL_LOGIN(), ParameterHistoryKey
	from ParameterHistory
	where AssumptionSetNo = @AssumptionSetNo and ParameterProc = @ProcName
	
	delete from ParameterHistory where AssumptionSetNo = @AssumptionSetNo and ParameterProc = @ProcName

	--Store the parameter values for future reference
	insert into ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
	select @AssumptionSetNo, @ProcName, '@ST_adj', @ST_adj, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@min', @min, GetDate(), ORIGINAL_LOGIN()
	
	drop index idx_AssetClassReturn on AssetClassReturn

	--Pre-work
	if OBJECT_ID('tempdb..#FI_I_ShortTermReturn') IS NOT NULL
    drop table #FI_I_ShortTermReturn


	
	--Insert into table
	insert into AssetClassReturn(n, t, Normal, Stressed, Combined, AssumptionSetNo, AssetClass, AssetGroup, Cumulative, CumulativeAnnualized, CreatedDate, CreatedBy)
	select ST.n, ST.t, case when ST.ST - @ST_adj < @min THEN @min ELSE ST.ST - @ST_adj END, case when ST.ST - @ST_adj < @min THEN @min ELSE ST.ST - @ST_adj END, case when ST.ST - @ST_adj < @min THEN @min ELSE ST.ST - @ST_adj END [Combined],
			ST.AssumptionSetNo, 'Borrowing Cost' AssetClass, 'Financing Cost' AssetGroup, NULL Cumulative, NULL CumulativeAnnualized,
		   GETDATE() CreatedDate, ORIGINAL_LOGIN() CreatedBy
	from FI_I_ShortTermReturn ST
	where ST.AssumptionSetNo = @AssumptionSetNo
	order by st.t, st.n

	create nonclustered index idx_AssetClassReturn on AssetClassReturn(n, t, AssumptionSetNo, AssetClass, AssetGroup)
	
	--Calculate the cumulative returns as well as cumulative annualized returns
	update acr
	set Cumulative = ISNULL(dbo.FV_Schedule_AssetClass(t, n, 'Borrowing Cost', @AssumptionSetNo),1),
		CumulativeAnnualized = POWER((ISNULL(dbo.FV_Schedule_AssetClass(t, n, 'Borrowing Cost', @AssumptionSetNo),1)), (1 / (t * 1.0))) - 1
	from AssetClassReturn acr
	where AssetClass = 'Borrowing Cost' and AssumptionSetNo = @AssumptionSetNo and Cumulative is NULL

	--Write to Log file
	declare @RowCnt as float = (select COUNT(*) from AssetClassReturn where AssumptionSetNo = @AssumptionSetNo and AssetClass = 'Borrowing Cost')
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt, 'Borrowing Cost'

	exec ProjectAssetClass @AssumptionSetNo, 'Borrowing Cost'

	--User Feedback
	
	--exec GenerateProjectedBorrowingCost @ST_adj, @min, @AssumptionSetNo
	--exec GenerateProjectedBorrowingCost '-0.01', '0.0025', 1

END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedBuildingBlock]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:          <Kris Kim Sing>
-- Create date:		<2020/09/23>
-- Description:     <Stored procedure for creating projected Fixed income building blocks>

-- Updated date:	<2020/09/24>
-- Updated by:		<Gerrit Marais>
-- Updated reason:	<Check the Stored Procedure, ensured that logging process works)> - <2020/09/24>
--					<Updated the Stored Procedure to store initial values for Building Blocks at t = 0> - <2020/10/29>
-- =============================================

CREATE PROCEDURE [dbo].[GenerateProjectedBuildingBlock] (@BB_tmin1 as varchar(1000), @w as varchar(1000), @BB_LT as varchar(1000),@sd_e as varchar(1000), @mu_e as varchar(1000), @BuildingBlock as varchar(255), @AssumptionSetNo as int)												
AS												
BEGIN												
												
	SET NOCOUNT ON;											
    												
	--Logging Parameters											
	declare @ProcessName as varchar(MAX) = 'Project Building Block'											
	declare @ProcessStartDate as datetime = GETDATE()	
	
	--Stop stored procedure if results are finalized											
	if (select IsFinalizedBy from AssumptionSet where AssumptionSetNo = @AssumptionSetNo) IS NOT NULL											
		begin										
			exec WriteLog @AssumptionSetNo, 'Warning: AssumptionSet Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName									
		end										
	else											
	begin		
	
	--Using ProVal's formula to project Building Block:    BB(t) = [ BB(t-1) x w ] + [ LT_BB x (1-w) ] + e											
	--NORMINV(p, mu, sigma) = mu + sigma*NORMSINV(p)											
	--Parameters											
	/*
	declare @BB_tmin1 as varchar(1000) = '0.017'
	declare @w as varchar(1000) = '0.75'
	declare @BB_LT as varchar(1000) = '0.0205'
	declare @sd_e as varchar(1000) = '0.002'
	declare @mu_e as varchar(1000) = '0'
	declare @AssumptionSetNo as int = 3
	declare @BuildingBlock as varchar(1000) = 'Infl'
	
	--exec GenerateProjectedBuildingBlock @BB_tmin1, @w, @BB_LT, @sd_e, @mu_e, @BuildingBlock, @AssumptionSetNo
	--exec GenerateProjectedBuildingBlock '0.017', '0.75', '0.0205', '0.002', '0.00', 'Infl', 3
	*/
	
	declare @n as int = 0											
	declare @sql as nvarchar(max)											
	--Write to trail table (if exists)											
	--TODO			
											
	--Delete from table (if exists)																		
	delete from ParameterHistory where AssumptionSetNo = @AssumptionSetNo and ParameterProc = 'GenerateProjectedBuildingBlock:' + @BuildingBlock										
	delete from FI_I_BuildingBlocks where AssumptionSetNo = @AssumptionSetNo and BBType = @BuildingBlock

	--=======================
	--Reindex the Keys in the database
	--Building Blocks
	declare @DBTable as varchar(MAX) = 'FI_I_BuildingBlocks'
	declare @DBTable_new_reseed_value as int = (select MAX(BBKey) from FI_I_BuildingBlocks)

	set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
	execute sp_executesql @sql
	--=======================

	--Store the parameter values for future reference											
	insert into ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)											
	select @AssumptionSetNo, 'GenerateProjectedBuildingBlock:' + @BuildingBlock, '@BB_tmin1', @BB_tmin1, GetDate(), ORIGINAL_LOGIN()											
		union										
	select @AssumptionSetNo, 'GenerateProjectedBuildingBlock:' + @BuildingBlock, '@w', @w, GetDate(), ORIGINAL_LOGIN()											
		union										
	select @AssumptionSetNo, 'GenerateProjectedBuildingBlock:' + @BuildingBlock, '@BB_LT', @BB_LT, GetDate(), ORIGINAL_LOGIN()											
		union										
	select @AssumptionSetNo, 'GenerateProjectedBuildingBlock:' + @BuildingBlock, '@sd_e', @sd_e, GetDate(), ORIGINAL_LOGIN()											
		union										
	select @AssumptionSetNo, 'GenerateProjectedBuildingBlock:' + @BuildingBlock, '@mu_e', @mu_e, GetDate(), ORIGINAL_LOGIN()		
			union										
	select @AssumptionSetNo, 'GenerateProjectedBuildingBlock:' + @BuildingBlock, '@BuildingBlock', @BuildingBlock, GetDate(), ORIGINAL_LOGIN()	
	
	--Drop index
	DROP INDEX idx_FI_I_BuildingBlocks on FI_I_BuildingBlocks
						
	--Create values											
	While @n <= 30									
	Begin											
		
		declare @cur varchar(1000) = CAST(@n as varchar(1000))										
		declare @prev varchar(1000) = CAST(@n - 1 as varchar(1000))										
		
		if @n = 0 										
		begin										
			set @sql = 'insert into FI_I_BuildingBlocks(n, t, BBType, BBValue, AssumptionSetNo)									
						select r.n, ' + CAST(@n as varchar) + ', ''' + @BuildingBlock + ''', ' + @BB_tmin1 + ', ' + CAST(@AssumptionSetNo as varchar) + '						
						from vw_FI_R_Corr_Final_Unpvt r						
						where r.AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + ' and r.t = 1 and r.BBType = ''' + @BuildingBlock + '''
						order by r.n'
		end										
		else										
		if @n = 1 										
		begin										
			set @sql = 'insert into FI_I_BuildingBlocks(n, t, BBType, BBValue, AssumptionSetNo)									
						select r.n, ' + CAST(@n as varchar) + ', ''' + @BuildingBlock + ''', ' + @BB_tmin1 + ' * ' + @w + ' + ' +  @BB_LT +' * (1 - ' + @w + ') + (' + @mu_e + ' + (' + @sd_e + ' * Utils.dbo.normsinv(r.BBCorrRandNum))), ' + CAST(@AssumptionSetNo as varchar) + '						
						from vw_FI_R_Corr_Final_Unpvt r						
						where r.AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + ' and r.t = ' + CAST(@n as varchar) + ' and r.BBType = ''' + @BuildingBlock + '''
						order by r.n'
		end										
		else										
		begin										
			set @sql ='insert into FI_I_BuildingBlocks(n, t, BBType, BBValue, AssumptionSetNo)									
					   select r.n, ' + CAST(@n as varchar) + ', ''' + @BuildingBlock + ''', i.BBValue * ' + @w + ' + ' +  @BB_LT +' * (1 - ' + @w + ') + (' + @mu_e + ' + (' + @sd_e + ' * Utils.dbo.normsinv(r.BBCorrRandNum))), ' + CAST(@AssumptionSetNo as varchar) + '							
					   from vw_FI_R_Corr_Final_Unpvt r							
					   inner join FI_I_BuildingBlocks i on i.AssumptionSetNo = r.AssumptionSetNo and i.n = r.n and i.t = ' + CAST(@n - 1 as varchar) + ' and r.BBType = i.BBType							
					   where r.AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + ' and r.t = ' + CAST(@n as varchar) + ' and r.BBType = ''' + @BuildingBlock + '''
					   order by r.n'							
		end	
		
		--print @sql
		execute sp_executesql @sql	
		
		--roll to the next value										
		set @n = @n + 1										
	End		
	
	--Create Index
	CREATE NONCLUSTERED INDEX idx_FI_I_BuildingBlocks on FI_I_BuildingBlocks (n, t, AssumptionSetNo)
	
	--Update metadata											
	update i											
	set i.CreatedDate = GETDATE(),											
		i.CreatedBy = ORIGINAL_LOGIN()										
	from FI_I_BuildingBlocks i											
	where AssumptionSetNo = @AssumptionSetNo	
	
	--Write to Log file											
	declare @RowCnt as float = (select COUNT(*) from FI_I_BuildingBlocks where AssumptionSetNo = @AssumptionSetNo and BBType = @BuildingBlock)											
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @BuildingBlock											
												
	end											
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedCreditSpread]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/04/09>
-- Description:	<Stored procedure for creating projecting future credit spread>

-- Updated date: <2019/02/11>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <Added logging logic - 2020/02/11>
--				   <Added logic to stop execution if AssumptionSet is Finalized - 2020/02/25>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedCreditSpread] (@CS_tmin1 as varchar(1000), @w as varchar(1000), @CS_LT as varchar(1000),@sd_e as varchar(1000), @mu_e as varchar(1000), @AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;
    
	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Project Credit Spread'
	declare @ProcessStartDate as datetime = GETDATE()

	--Stop stored procedure if results are finalized
	if (select IsFinalizedBy from AssumptionSet where AssumptionSetNo = @AssumptionSetNo) IS NOT NULL
		begin	
			exec WriteLog @AssumptionSetNo, 'Warning: AssumptionSet Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName
		end	
	else
	begin

	--CIA yield over Solvency Yield - formula to project Credit Spread:    CS(t) = [ CS(t-1) x w ] + CS_LT x (1-w) ] + e
	--NORMINV(p, mu, sigma) = mu + sigma * NORMSINV(p)
	--Parameters
	/*
	set @CS_tmin1 = '0.0082'
	set @w = '0.9'
	set @CS_LT = '0.01'
	set @sd_e = '0.002'
	set @mu_e = '0'

	--exec GenerateProjectedCreditSpread @CS_tmin1, @w, @CS_LT, @sd_e, @mu_e, @AssumptionSetNo
	--exec GenerateProjectedCreditSpread '0.0082', '0.90', '0.01', '0.002', '0.00', 1
	*/

	declare @n as int = 1
	declare @sql as nvarchar(max)

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

	--Write to Log file
	declare @RowCnt as float = (select COUNT(*) from FI_I_CreditSpread where AssumptionSetNo = @AssumptionSetNo)
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt
	
	end

END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedDerivativeReturn]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/07/03>
-- Description:	<Stored procedure for creating projected future Derivative Asset Class Returns>

-- Updated date:	<2019/05/06>
-- Updated by:		<Gerrit Marais>
-- Updated reason:	<Added logging logic - 2020/02/11>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedDerivativeReturn] (@BottomStrike as varchar(1000), @RockBottomStrike as varchar(1000), @RockBottomHedge as varchar(1000), @TopStrike as varchar(1000), @BaseAssetClass as varchar(1000), @AssetClass as varchar(1000), @AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;
		
	--Parameters
	/*
	declare @BottomStrike as float = -0.1
	declare @RockBottomStrike as float = -0.3
	declare @RockBottomHedge as float = 0.2
	declare @TopStrike as float = 0.2
	declare @BaseAssetClass as varchar(255) = 'Canadian Equity'
	
	declare @AssetClass as varchar(255) = 'Option Strategy - Canadian Equity Based'
	declare @AssumptionSetNo as int = 1
	*/

	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Derivative Assets'
	declare @ProcessStartDate as datetime = GETDATE()
	
	declare @ProcName as varchar(255) = 'GenerateProjectedDerivativeReturn' + ':' + @AssetClass

	--Delete from table (if exists)
	delete from AssetClassReturn where AssumptionSetNo = @AssumptionSetNo and AssetClass = @AssetClass
		
	--Trail for Parameter
	insert into trl.ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy, TrailCreatedDate, TrailCreatedBy, SourceKey)
	select AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy, GETDATE(), ORIGINAL_LOGIN(), ParameterHistoryKey
	from ParameterHistory
	where AssumptionSetNo = @AssumptionSetNo and ParameterProc = @ProcName
	
	delete from ParameterHistory where AssumptionSetNo = @AssumptionSetNo and ParameterProc = @ProcName

	--Store the parameter values for future reference
	insert into ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
	select @AssumptionSetNo, @ProcName, '@BottomStrike', @BottomStrike, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@RockBottomStrike', @RockBottomStrike, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@RockBottomHedge', @RockBottomHedge, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@TopStrike', @TopStrike, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@BaseAssetClass', @BaseAssetClass, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@AssetClass', @AssetClass, GetDate(), ORIGINAL_LOGIN()
	
	drop index idx_AssetClassReturn on AssetClassReturn

	--Create values
	;with option_cte 
	as (
		select n, t, AssumptionSetNo, Combined [AssetReturn],
			CASE WHEN Combined < @RockBottomStrike THEN Combined + @RockBottomHedge
				 ELSE (CASE WHEN (CASE WHEN Combined >= @TopStrike THEN @TopStrike ELSE Combined END) < @BottomStrike THEN @BottomStrike
							ELSE (CASE WHEN Combined >= @TopStrike THEN @TopStrike ELSE Combined END) END)
				 END OptionReturn
		from AssetClassReturn
		where AssetClass = @BaseAssetClass
	),
	option_work_cte
	as (
		select opt1.n, opt1.t, opt1.AssumptionSetNo, opt1.AssetReturn, opt1.OptionReturn, (opt1.OptionReturn - opt1.AssetReturn) OptionEffect,
			1 OptionResetFlag, 
			CAST(0.00 as float) Asset2YearReturn, 
			CAST(0.00 as float) Option2YearReturn
		from option_cte opt1
		left join option_cte opt2 on opt1.n = opt2.n and opt1.t - 1 = opt2.t and opt1.AssumptionSetNo = opt2.AssumptionSetNo
		where opt1.t = 1
			union all
		select opt1.n, opt1.t, opt1.AssumptionSetNo, opt1.AssetReturn, opt1.OptionReturn, (opt1.OptionReturn - opt1.AssetReturn) OptionEffect,
			CASE WHEN ((opt2.OptionResetFlag <> 1) or (opt2.AssetReturn > 0.1)) THEN 1 ELSE 0 END OptionResetFlag,
			((1 + opt1.AssetReturn) * (1 + opt2.AssetReturn) - 1) Asset2YearReturn,
			CASE WHEN ((1 + opt1.AssetReturn) * (1 + opt2.AssetReturn) - 1) < @RockBottomStrike THEN ((1 + opt1.AssetReturn) * (1 + opt2.AssetReturn) - 1) + @RockBottomHedge
				 ELSE (CASE WHEN (CASE WHEN ((1 + opt1.AssetReturn) * (1 + opt2.AssetReturn) - 1) >= @TopStrike THEN @TopStrike ELSE ((1 + opt1.AssetReturn) * (1 + opt2.AssetReturn) - 1) END) < @BottomStrike THEN @BottomStrike
									   ELSE (CASE WHEN ((1 + opt1.AssetReturn) * (1 + opt2.AssetReturn) - 1) >= @TopStrike THEN @TopStrike ELSE ((1 + opt1.AssetReturn) * (1 + opt2.AssetReturn) - 1) END) END)
				 END Option2YearReturn
		from option_cte opt1
		inner join option_work_cte opt2 on opt1.n = opt2.n and opt1.t - 1 = opt2.t and opt1.AssumptionSetNo = opt2.AssumptionSetNo
		where opt1.t > 1
	),
	final_cte
	as (
		select opt1.*, CASE WHEN Opt1.OptionResetFlag = 1 THEN opt1.OptionReturn ELSE opt1.AssetReturn + ((opt1.Option2YearReturn - opt1.Asset2YearReturn) - ISNULL(opt2.OptionEffect,0))/ (1 + ISNULL(opt2.AssetReturn,0)) END FinalReturn
		from option_work_cte opt1
		left join option_work_cte opt2 on opt1.n = opt2.n and opt1.t - 1 = opt2.t and opt1.AssumptionSetNo = opt2.AssumptionSetNo
	)
	insert into AssetClassReturn(n, t, Normal, Stressed, Combined, AssumptionSetNo, AssetClass, AssetGroup, Cumulative, CumulativeAnnualized, CreatedDate, CreatedBy)
	select n, t, AssetReturn, OptionReturn, FinalReturn, AssumptionSetNo, 
		@AssetClass [AssetClass], 'Derivatives' AssetGroup, NULL Cumulative, NULL CumulativeAnnualized, GETDATE(), ORIGINAL_LOGIN()
	from final_cte opt1
	order by opt1.AssumptionSetNo, opt1.n, opt1.t
	
	create nonclustered index idx_AssetClassReturn on AssetClassReturn(n, t, AssumptionSetNo, AssetClass, AssetGroup)
	
	--Calculate the cumulative returns as well as cumulative annualized returns
	update acr
	set Cumulative = ISNULL(dbo.FV_Schedule_AssetClass(t, n, @AssetClass, @AssumptionSetNo),1)
	  --CumulativeAnnualized = POWER((ISNULL(dbo.FV_Schedule_AssetClass(t, n, @AssetClass, @AssumptionSetNo),1)), (1 / (t * 1.0))) - 1
	from AssetClassReturn acr
	where AssetClass = @AssetClass and AssumptionSetNo = @AssumptionSetNo and Cumulative is NULL

	--Write to Log file
	declare @RowCnt as float = (select COUNT(*) from AssetClassReturn where AssumptionSetNo = @AssumptionSetNo and AssetClass = @AssetClass)
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @AssetClass

	--Test
	--exec GenerateProjectedDerivativeReturn @BottomStrike, @RockBottomStrike, @RockBottomHedge, @TopStrike, @BaseAssetClass, @AssetClass, @AssumptionSetNo
	--exec GenerateProjectedDerivativeReturn '-0.1', '-0.3', '0.2', '0.2', 'Canadian Equity', 'Option Strategy - Canadian Equity Based', 1

END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedDiscountRate]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Justin Saw>
-- Create date: <2019/01/23>
-- Description:	<Stored procedure for creating projected future Long-term Bond returns>

-- Updated date: <2020/02/25>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <Add the functionality to calculate the Accounting Discount Rate Basis>
--				   <Added logging logic - 2020/02/11>
--				   <Added logic to stop execution if ResultSet is Finalized - 2020/02/25>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedDiscountRate] (@DIS_initial as varchar(1000), @ST as varchar(1000), @LT as varchar(1000), @PercentReflected as varchar (1000), @RateType as varchar(255), @ResultSetNo as varchar(3))
AS
BEGIN

	SET NOCOUNT ON;

	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Project Discount Rate'
	declare @ProcessStartDate as datetime = GETDATE()

	--Stop stored procedure if results are finalized
	if (select IsFinalizedBy from ResultSet where ResultSetNo = @ResultSetNo) IS NOT NULL
		begin	
			exec WriteLog @ResultSetNo, 'Warning: ResultSet Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName
		end	
	else
		begin
			/*
			--GC discount rate projection = GCi_(t-1) + ( (ST_t – ST_(t-1) )%ST + (LT_t – LT_(t-1) )%LT + (CS_t – CS_(t-1) )%CS ) * (Proportion of yield change to be reflected in DR)
	
			declare @DIS_initial as varchar(1000) = '0.057'
			declare @ST as varchar(1000) = '0.20'
			declare @LT as varchar(1000) = '0.80'
			declare @PercentReflected as varchar(1000) = '0.12'
			declare @RateType as varchar(10) = 'GC'
			declare @ResultSetNo as int = 1

			exec GenerateProjectedDiscountRate @DIS_initial, @ST, @LT, @PercentReflected, @InterestRateType, @ResultSetNo
			exec GenerateProjectedDiscountRate '0.033', '0.00', '1.00', '1.00', 'SOLV', 1
			exec GenerateProjectedDiscountRate '0.044', '0.00', '1.00', '0.775', 'GC', 2
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

			--ALM_I_L_DiscountRate
			declare @DBTable as varchar(MAX) = 'ALM_I_L_DiscountRate'
			declare @DBTable_new_reseed_value as int = (select MAX(DRKey) from ALM_I_L_DiscountRate)

			set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
			execute sp_executesql @sql 

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
	
			--Write to Log file
			declare @RowCnt as float = (select COUNT(*) from ALM_I_L_DiscountRate where ResultSetNo = @ResultSetNo and RateType = @RateType)
			exec WriteLog @ResultSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @RateType

		end
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedFIReturn]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/01/04>
-- Description:	<Stored procedure for creating projected future Fixed Income Asset Class Returns>


-- Updated date:	<2019/05/06>
-- Updated by:		<Gerrit Marais>
-- Updated reason:	<Add the ability to add a Credit Spread to any Fixed Income asset class return> - <2019/04/11>
--					<Add the ability to calculate the cumulative returns and cumulative annualized returns> - <2019/05/06>
--					<Add the ability to write the output into a central asset class table> - <2019/05/06>
--					<Added logging logic - 2020/02/11>

-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedFIReturn] (@ST as varchar(1000), @LT as varchar(1000), @CS as varchar(1000), @ST_Dur as varchar(1000),@LT_Dur as varchar(1000), @CS_Dur as varchar(1000), @E_alpha as varchar(1000), @sd_e as varchar(1000), @max_loss as varchar(255), @prob_sr as varchar(255), @AssetClass as varchar(255), @AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;
	--END QUERY IF EMPTY
	if @ST = '0' and @LT = '0' and @ST_Dur = '0' and @LT_Dur = '0' and @E_alpha = '0' and @sd_e = '0' and @max_loss = '0' 
		begin	
			return
		end
	else 

	--Using ProVal's formula to project Inflation:    [ yieldST(t-1) + exp( Δ yieldST x Dur) ] x ST_weight + [ yieldLT(t-1) + exp( Δ yieldLT x Dur) ] x LT_weight + [ CreditSpread(t-1) + exp( Δ CreditSpread x Dur) ] x CS_weight + e
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
	declare @AssetClass as varchar(255) = 'LTBond'
	declare @AssumptionSetNo as int = 1
	*/

	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Fixed Income Assets'
	declare @ProcessStartDate as datetime = GETDATE()

	--Stop stored procedure if results are finalized
	if (select IsFinalizedBy from AssetClass where AssumptionSetNo = @AssumptionSetNo and AssetClass = @AssetClass) IS NOT NULL
		begin	
			exec WriteLog @AssumptionSetNo, 'Warning: Asset Class Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName
		end	
	else
		begin

	declare @ProcName as varchar(255) = 'GenerateProjectedFIReturn' + ':' + @AssetClass
	declare @STR_tmin1 as float
	declare @LTR_tmin1 as float
	declare @CS_tmin1 as float
	
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
	
	--Delete from table (if exists)
	delete from AssetClassReturn where AssumptionSetNo = @AssumptionSetNo and AssetClass = @AssetClass
	delete from AssetClass where AssumptionSetNo = @AssumptionSetNo and AssetClass = @AssetClass
	
	--=======================
	--Reindex the Keys in the database
	declare @sql as nvarchar(max)	
	
	--AssetClassReturn
	declare @DBTable as varchar(MAX) = 'AssetClassReturn'
	declare @DBTable_new_reseed_value as int = (select MAX(AssetClassReturnKey) from AssetClassReturn)

	set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
	execute sp_executesql @sql

	--AssetClass
	set @DBTable = 'AssetClass'
	set @DBTable_new_reseed_value = (select MAX(AssetClassKey) from AssetClass)

	set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
	execute sp_executesql @sql
	--=======================

	--Trail for Parameter
	insert into trl.ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy, TrailCreatedDate, TrailCreatedBy, SourceKey)
	select AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy, GETDATE(), ORIGINAL_LOGIN(), ParameterHistoryKey
	from ParameterHistory
	where AssumptionSetNo = @AssumptionSetNo and ParameterProc = @ProcName

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

	drop index idx_AssetClassReturn on AssetClassReturn

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
		select rco.n, rco.t, rco.AssumptionSetNo, CdnEq
		from NFI_R_Corr_Final rco
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
	insert into AssetClassReturn(n, t, Normal, Stressed, Combined, AssumptionSetNo, AssetClass, AssetGroup, Cumulative, CumulativeAnnualized, CreatedDate, CreatedBy)
	select nor.n, nor.t, nor.Normal, st.Stressed, (nor.Normal - st.Stressed) [Combined], nor.AssumptionSetNo, 
		   @AssetClass AssetClass, 'Fixed Income' AssetGroup, NULL Cumulative, NULL CumulativeAnnualized,
		   CreatedDate, CreatedBy
	from #FI_Normal nor
	inner join #FI_Stressed st on nor.n = st.n and nor.t = st.t
	where nor.AssumptionSetNo = CAST(@AssumptionSetNo as varchar)
	order by nor.t, nor.n
	
	create nonclustered index idx_AssetClassReturn on AssetClassReturn(n, t, AssumptionSetNo, AssetClass, AssetGroup)
	
	--Calculate the cumulative returns as well as cumulative annualized returns
	update acr
	set Cumulative = ISNULL(dbo.FV_Schedule_AssetClass(t, n, @AssetClass, @AssumptionSetNo),1), 
		CumulativeAnnualized = POWER((ISNULL(dbo.FV_Schedule_AssetClass(t, n, @AssetClass, @AssumptionSetNo),1)), (1 / (t * 1.0))) - 1
	from AssetClassReturn acr
	where AssetClass = @AssetClass and AssumptionSetNo = @AssumptionSetNo and Cumulative is NULL
	
	--Write to Log file
	declare @RowCnt as float = (select COUNT(*) from AssetClassReturn where AssumptionSetNo = @AssumptionSetNo and AssetClass = @AssetClass)
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @AssetClass

	exec ProjectAssetClass @AssumptionSetNo, @AssetClass

	--User Feedback
	/*	
	select distinct 'Done' [Status], GETDATE() [StatusDate], 'If you have finished entering all 7 Fixed Income asset classes. Next Step - Generate Non-Fixed Income Triangle Distributions' [Next Steps],
	@Status_FI_AC_BorrowCost [Status_FI_AC_BorrowCost], @Status_FI_AC_Corp [Status_FI_AC_Corp], @Status_FI_AC_LTBond [Status_FI_AC_LTBond], @Status_FI_AC_Mort [Status_FI_AC_Mort], @Status_FI_AC_PrDebt [Status_FI_AC_PrDebt], @Status_FI_AC_STCr [Status_FI_AC_STCr], @Status_FI_AC_UBond [Status_FI_AC_UBond]
	*/
	
  --Test	
  --exec GenerateProjectedFIReturn @ST, @LT, @CS, @ST_Dur, @LT_Dur, @CS_Dur, @E_alpha, @sd_e, @max_loss, @prob_sr, @AssetClass, @AssumptionSetNo
  --exec GenerateProjectedFIReturn '0.00', '1.00', '0.00', '7.5', '20', '0.00', '0.0003', '0.0035', '0.10', '0.000', 'PH&N Fixed Interest', 1
	
	end

END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedFIReturn_BB]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:          <Kris Kim Sing>
-- Create date:		<2020/10/15>
-- Description:     <Stored procedure for creating projected Fixed income yields and returns - Building Block Method>

-- Updated date:	<2020/10/29>
-- Updated by:		<Gerrit Marais>
-- Updated reason:	<Updated the Stored Procedure to include calculation of yields and returns using recursive CTE> - <2020/10/29>
--					
-- =============================================


CREATE PROCEDURE [dbo].[GenerateProjectedFIReturn_BB] (@BBType as varchar(1000), @BBWeight as varchar(MAX), @FIAsset as varchar(1000), @AssumptionSetNo as int, 
														@prob_sr as varchar(MAX), @max_loss as varchar(MAX), @max_spread as varchar(MAX), @yield_marg as varchar(MAX), 
														@mu_alpha as varchar(MAX), @sd_alpha as varchar(MAX), @dur as varchar(MAX))												
AS												
BEGIN												
												
	SET NOCOUNT ON;				
												
	--Logging Parameters											
	declare @ProcessName as varchar(MAX) = 'Project Fixed Income Asset Yields'	--'Returns' not 'Yields'?										
	declare @ProcessStartDate as datetime = GETDATE()
	declare @ProcName as varchar(255) = 'GenerateProjectedFIReturn_BB' + ':' + @FIAsset
	
	--Stop stored procedure if results are finalized											
	if (select IsFinalizedBy from AssumptionSet where AssumptionSetNo = @AssumptionSetNo) IS NOT NULL											
		begin										
			exec WriteLog @AssumptionSetNo, 'Warning: AssumptionSet Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName									
		end										
	else											
	begin
		/*	
		--Parameters											
		declare @BBType as varchar(MAX) = 'Infl,FedCredSpread,TermRPrem_7yrs,TermRPrem_15yrs,Prov_A_RatedDebtCredSpread_7yr,Prov_A_RatedDebtCredSpread_15yr,
											BBBCredSpread,HighYieldSpread,PrivDebt_illiquidityPrem,Mort_IG_Spread'
		declare @BBWeight as varchar(MAX) = '1,1,1,0,1,0,0,0,0,0'
			
		declare @FIAsset as varchar(MAX) = 'CreditBBB7yrdurbond'
		declare @AssumptionSetNo as int = 3

		declare @prob_sr as varchar(MAX) = '0.075'
		declare @max_loss as varchar(MAX) = '0.050'
		declare @max_spread as varchar(MAX) = '0.040'
		declare @yield_marg as varchar(MAX) = '0.0'
		declare @mu_alpha as varchar(MAX) = '0.005'
		declare @sd_alpha as varchar(MAX) = '0.006'
		declare @dur as varchar(MAX) = '0.25'
		*/

		--Delete from table (if exists)
		delete from AssetClassReturn where AssumptionSetNo = @AssumptionSetNo and AssetClass = @FIAsset
		delete from AssetClass where AssumptionSetNo = @AssumptionSetNo and AssetClass = @FIAsset
		delete from FI_I_AssetYields where AssumptionSetNo = @AssumptionSetNo and FIAsset = @FIAsset
		delete from ParameterHistory where AssumptionSetNo = @AssumptionSetNo and ParameterProc = @ProcName

		--=======================
		--Reindex the Keys in the database
		declare @sql as nvarchar(max)	
	
		--AssetClassReturn
		declare @DBTable as varchar(MAX) = 'AssetClassReturn'
		declare @DBTable_new_reseed_value as int = (select MAX(AssetClassReturnKey) from AssetClassReturn)

		set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
		execute sp_executesql @sql

		--AssetClass
		set @DBTable = 'AssetClass'
		set @DBTable_new_reseed_value = (select MAX(AssetClassKey) from AssetClass)

		set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
		execute sp_executesql @sql

		--Fixed Income Asset Yields
		set @DBTable = 'FI_I_AssetYields'
		set @DBTable_new_reseed_value = (select MAX(FIAssetKey) from FI_I_AssetYields)

		set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
		execute sp_executesql @sql
		--=======================

		--Drop index
		drop index idx_FI_I_AssetYields on FI_I_AssetYields
											
		--Store the parameter values for future reference											
		/*insert into ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)											
			select @AssumptionSetNo, 'GenerateProjectedFIReturn_BB' + ':' + @FIAsset, '@BBType', @BBType, GetDate(), ORIGINAL_LOGIN()											
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIReturn_BB' + ':' + @FIAsset, '@BBWeight', @BBWeight, GetDate(), ORIGINAL_LOGIN()											
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIReturn_BB' + ':' + @FIAsset, '@FIAsset', @FIAsset, GetDate(), ORIGINAL_LOGIN()											
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIReturn_BB' + ':' + @FIAsset, '@AssumptionSetNo', @AssumptionSetNo, GetDate(), ORIGINAL_LOGIN()											
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIReturn_BB' + ':' + @FIAsset, '@prob_sr', @prob_sr, GetDate(), ORIGINAL_LOGIN()		
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIReturn_BB' + ':' + @FIAsset, '@max_loss', @max_loss, GetDate(), ORIGINAL_LOGIN()	
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIReturn_BB' + ':' + @FIAsset, '@max_spread', @max_spread, GetDate(), ORIGINAL_LOGIN()		
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIReturn_BB' + ':' + @FIAsset, '@yield_marg', @yield_marg, GetDate(), ORIGINAL_LOGIN()	
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIReturn_BB' + ':' + @FIAsset, '@mu_alpha', @mu_alpha, GetDate(), ORIGINAL_LOGIN()		
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIReturn_BB' + ':' + @FIAsset, '@sd_alpha', @sd_alpha, GetDate(), ORIGINAL_LOGIN()	
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIReturn_BB' + ':' + @FIAsset, '@dur', @dur, GetDate(), ORIGINAL_LOGIN()		
		*/
		--Calculate the increase/decrease in Credit Spread / Maximum Loss / Random Numbers for Alpha
		if OBJECT_ID('tempdb..#FI_Stressed') IS NOT NULL
		drop table #FI_Stressed

		;with FI_R_StressReg
		as (
			select *
			from vw_FI_R_StressReg_Unpvt
			),
		FI_R_StressRegCdnEq
		as (
			select rco.n, rco.t, rco.AssumptionSetNo, CdnEq
			from NFI_R_Corr_Final rco	
			)
		select sr.n, sr.t, sr.AssumptionSetNo, RAND(CHECKSUM( NEWID())) Rand_Alpha,
		   CASE WHEN sr.StressReg < @prob_sr THEN (1 - cdn.CdnEq) * @max_loss ELSE 0 END StressedLoss,
		   CASE WHEN sr.StressReg < @prob_sr THEN (1 - cdn.CdnEq) * @max_spread ELSE 0 END StressedSpread
		into #FI_Stressed
		from FI_R_StressReg sr
		inner join FI_R_StressRegCdnEq cdn on cdn.n = sr.n and cdn.t = sr.t	and cdn.AssumptionSetNo = sr.AssumptionSetNo
		where sr.AssumptionSetNo = @AssumptionSetNo
		order by sr.t, sr.n
		
		CREATE NONCLUSTERED INDEX idx_FI_Stressed on #FI_Stressed (n, t, AssumptionSetNo)

		--Calculate the yields and asset class return
		;with building_block_list_cte 
		as (
			select sq1.Id, sq1.SplitString BBType, sq2.SplitString BBWeight
			from Utils.dbo.tvf_SplitString(@BBType, ',') sq1
			inner join (select * from Utils.dbo.tvf_SplitString(@BBWeight, ',')) sq2 on sq1.Id = sq2.Id
			where sq2.SplitString <> 0 
		),
		base_cte
		as (
			select bb.n, bb.t, 
					@FIAsset [FIAsset],
					SUM(BBWeight * BBValue) + (0.5 * ISNULL(MAX(stmin1.StressedSpread), 0)) + ISNULL(MAX(st.StressedSpread), 0) + @yield_marg [FIYield],
					ISNULL(MAX(st.StressedSpread), 0)		[FICredSprdInc] ,
					ISNULL(MAX(st.StressedLoss), 0)			[FILoss],
					ISNULL(MAX(st.Rand_Alpha),0)						[Rand_Alpha],
					@mu_alpha + @sd_alpha * Utils.dbo.normsinv(MAX(st.Rand_Alpha)) [Alpha], 
					bb.AssumptionSetNo [AssumptionSetNo]
			from FI_I_BuildingBlocks bb
			inner join building_block_list_cte bblist on bblist.BBType = bb.BBType
			left join #FI_Stressed st on bb.n = st.n and bb.t = st.t and bb.AssumptionSetNo = st.AssumptionSetNo
			left join #FI_Stressed stmin1 on bb.n = stmin1.n and bb.t = stmin1.t + 1 and bb.AssumptionSetNo = stmin1.AssumptionSetNo
			--I added only this line
			where bb.AssumptionSetNo = @AssumptionSetNo
			group by bb.n, bb.t, bb.AssumptionSetNo
		)

		,
		recur_cte
		as (
			select b.n, b.t, b.FIAsset, b.FIYield, b.FICredSprdInc, b.FILoss, b.Rand_Alpha, b.Alpha, --bmin1.FIYield FIYield_tmin1, 
				bmin1.FIYield +  EXP( @dur * (bmin1.FIYield - b.FIYield)) - 1 						[FI_PreLossAlphaReturn], 
				(bmin1.FIYield + EXP( @dur * (bmin1.FIYield - b.FIYield)) - 1 ) + b.Alpha - b.FILoss [FI_CombinedReturn],
				b.AssumptionSetNo
			from base_cte b 
			inner join base_cte bmin1 on b.n = bmin1.n and b.t = bmin1.t + 1 and b.AssumptionSetNo = bmin1.AssumptionSetNo
			where b.t = 1
				union all
			select b.n, b.t, b.FIAsset, b.FIYield, b.FICredSprdInc, b.FILoss, b.Rand_Alpha, b.Alpha, --bmin1.FIYield FIYield_tmin1, 
				bmin1.FIYield + ( EXP( @dur * (bmin1.FIYield - b.FIYield)) - 1 )						[FI_PreLossAlphaReturn], 
				(bmin1.FIYield + ( EXP( @dur * (bmin1.FIYield - b.FIYield)) - 1 )) + b.Alpha - b.FILoss [FI_CombinedReturn],
				b.AssumptionSetNo
			from base_cte b 
			inner join recur_cte bmin1 on b.n = bmin1.n and b.t = bmin1.t + 1 and b.AssumptionSetNo = bmin1.AssumptionSetNo
			where b.t > 0
		)

		insert into FI_I_AssetYields(n, t, FIAsset, FIYield, FICredSprdInc, FILoss, Rand_Alpha, Alpha, FI_PreLossAlphaReturn, FI_CombinedReturn, AssumptionSetNo, CreatedDate, CreatedBy)
		select n, t, FIAsset, FIYield, FICredSprdInc, FILoss, Rand_Alpha, Alpha, FI_PreLossAlphaReturn, FI_CombinedReturn, AssumptionSetNo, CreatedDate, CreatedBy
		from (
			select n, t, FIAsset, FIYield, FICredSprdInc, FILoss, Rand_Alpha, Alpha, FI_PreLossAlphaReturn, FI_CombinedReturn, AssumptionSetNo, GETDATE() CreatedDate, ORIGINAL_LOGIN() CreatedBy 
			from recur_cte b
			where t > 0
				UNION ALL
			select n, t, FIAsset, FIYield, ISNULL(FICredSprdInc,0), ISNULL(FILoss,0), ISNULL(Rand_Alpha,0), ISNULL(Alpha,0), 0 [FI_PreLossAlphaReturn], 0 [FI_CombinedReturn], AssumptionSetNo, GETDATE(), ORIGINAL_LOGIN()
			from base_cte b
			where t = 0
		) sq
		order by n, t

		create nonclustered index idx_FI_I_AssetYields on FI_I_AssetYields(n, t, FIAsset, AssumptionSetNo)
		
		--Write to Log file 
		declare @RowCnt as float = (select COUNT(*) from FI_I_AssetYields where AssumptionSetNo = @AssumptionSetNo and FIAsset = @FIAsset)  
		exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @FIAsset      


		--====================================
		--Load to the AssetClasseReturn table
		--Logging Parameters                                                                                                                                                                     
		set @ProcessName = 'Fixed Income Assets (Building Block Approach)'                                                                                                                                                                      
		set @ProcessStartDate = GETDATE()

		drop index idx_AssetClassReturn on AssetClassReturn


		--Insert the return summary into the AssetClassReturn Table
		insert into AssetClassReturn(n, t, Normal, Stressed, Combined, AssumptionSetNo, AssetClass, AssetGroup, Cumulative, CumulativeAnnualized, CreatedDate, CreatedBy)
		select n, t, FI_PreLossAlphaReturn [Normal], -FILoss + Alpha [Stressed], FI_CombinedReturn [Combined], AssumptionSetNo, FIAsset, 'Fixed Income' [AssetGroup], 
			NULL Cumulative, NULL CumulativeAnnualized, CreatedDate, CreatedBy
		from FI_I_AssetYields
		where FIAsset = @FIAsset and AssumptionSetNo = @AssumptionSetNo and t > 0

		create nonclustered index idx_AssetClassReturn on AssetClassReturn(n, t, AssumptionSetNo, AssetClass, AssetGroup)
			
		--Calculate the cumulative returns as well as cumulative annualized returns
		update acr
		set Cumulative = ISNULL(dbo.FV_Schedule_AssetClass(t, n, @FIAsset, @AssumptionSetNo),1), 
			CumulativeAnnualized = POWER((ISNULL(dbo.FV_Schedule_AssetClass(t, n, @FIAsset, @AssumptionSetNo),1)), (1 / (t * 1.0))) - 1
		from AssetClassReturn acr
		where AssetClass = @FIAsset 
		  and AssumptionSetNo = @AssumptionSetNo and Cumulative is NULL
		  and t > 0


	--Write to Log file											
    set @RowCnt = (select COUNT(*) from AssetClassReturn where AssumptionSetNo = @AssumptionSetNo and AssetClass = @FIAsset)                                
    exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @FIAsset   
	
	exec ProjectAssetClass @AssumptionSetNo, @FIAsset

	end		
	
	/*
	exec GenerateProjectedFIReturn_BB 'Infl,FedCredSpread,TermRPrem_7yrs,TermRPrem_15yrs,Prov_A_RatedDebtCredSpread_7yr,Prov_A_RatedDebtCredSpread_15yr,BBBCredSpread,HighYieldSpread,PrivDebt_illiquidityPrem,Mort_IG_Spread', '1,1,1,0,0,0,0,0,0,0', 'GoC_AAA_7yrdurbonds', 3, '0.075', '0', '0','0','0.002','0.002','7'
	*/
									
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedFIReturnCombinedYields_BB]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:          <Kris Kim Sing>
-- Create date:		<2020/12/01>
-- Description:     <Stored procedure for creating projected Fixed income yields and returns - Building Block Method>

-- Updated date:	<YYYY/MM/DD>
-- Updated by:		<Name>
-- Updated reason:	<Description>				
-- =============================================

CREATE PROCEDURE [dbo].[GenerateProjectedFIReturnCombinedYields_BB] (@FIAssetString as varchar(1000), @FIAssetWeights as varchar(MAX), @FIAsset as varchar(1000), @AssumptionSetNo as int, 
														@prob_sr as varchar(MAX), @max_loss as varchar(MAX), @max_spread as varchar(MAX), @yield_marg as varchar(MAX), 
														@mu_alpha as varchar(MAX), @sd_alpha as varchar(MAX), @dur as varchar(MAX))
AS												
BEGIN

	SET NOCOUNT ON;				
												
	--Logging Parameters																					
	declare @ProcessName as varchar(MAX) = 'Project Fixed Income Asset Yields (Combined)'	--'Returns' not 'Yields'?										
	declare @ProcessStartDate as datetime = GETDATE()
	declare @ProcName as varchar(255) = 'GenerateProjectedFIReturnCombinedYields_BB' + ':' + @FIAsset
	
	--Stop stored procedure if results are finalized											
	if (select IsFinalizedBy from AssumptionSet where AssumptionSetNo = @AssumptionSetNo) IS NOT NULL											
		begin										
			exec WriteLog @AssumptionSetNo, 'Warning: AssumptionSet Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName									
		end										
	else											
	begin
		/*
		--Parameters											
		declare @FIAssetString as varchar(MAX) = 'Tbills,GoC_AAA_7yrdurbonds,Prov_AAA_7yrdurbonds,Credit_BBB_7yrdurbonds,GoC_AAA_15yrdurbonds,Prov_AAA_15yrdurbonds,Credit_BBB_15yrdurbonds,
											HighYield,Mortgages,PrivDebt_SunlifePrxy,PrivDebt_InfraPrxy,PrivDebt_non_inv_grade'
		declare @FIAssetWeights as varchar(MAX) = '0,0.3,0.3,0.4,0,0,0,0,0,0,0,0'
			
		declare @FIAsset as varchar(MAX) = 'Univ_7yrdur'
		declare @AssumptionSetNo as int = 5

		declare @prob_sr as varchar(MAX) = '0.075'
		declare @max_loss as varchar(MAX) = '0.015'
		declare @max_spread as varchar(MAX) = '0.0'
		declare @yield_marg as varchar(MAX) = '0.0'
		declare @mu_alpha as varchar(MAX) = '0.005'
		declare @sd_alpha as varchar(MAX) = '0.005'
		declare @dur as varchar(MAX) = '7'
		*/

		--Delete from table (if exists)
		delete from AssetClassReturn where AssumptionSetNo = @AssumptionSetNo and AssetClass = @FIAsset
		delete from AssetClass where AssumptionSetNo = @AssumptionSetNo and AssetClass = @FIAsset
		delete from FI_I_AssetYields where AssumptionSetNo = @AssumptionSetNo and FIAsset = @FIAsset
		delete from ParameterHistory where AssumptionSetNo = @AssumptionSetNo and ParameterProc = @ProcName

		--=======================
		--Reindex the Keys in the database
		declare @sql as nvarchar(max)	
	
		--AssetClassReturn
		declare @DBTable as varchar(MAX) = 'AssetClassReturn'
		declare @DBTable_new_reseed_value as int = (select MAX(AssetClassReturnKey) from AssetClassReturn)

		set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
		execute sp_executesql @sql

		--AssetClass
		set @DBTable = 'AssetClass'
		set @DBTable_new_reseed_value = (select MAX(AssetClassKey) from AssetClass)

		set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
		execute sp_executesql @sql

		--Fixed Income Asset Yields
		set @DBTable = 'FI_I_AssetYields'
		set @DBTable_new_reseed_value = (select ISNULL(MAX(FIAssetKey),0) from FI_I_AssetYields)

		set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
		execute sp_executesql @sql
		--=======================

		--Drop index
		drop index idx_FI_I_AssetYields on FI_I_AssetYields

		--Store the parameter values for future reference											
		/*insert into ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)											
			select @AssumptionSetNo, 'GenerateProjectedFIReturn_BB' + ':' + @FIAsset, '@FIAssetString', @FIAssetString, GetDate(), ORIGINAL_LOGIN()											
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIReturn_BB' + ':' + @FIAsset, '@FIAssetWeights', @FIAssetWeights, GetDate(), ORIGINAL_LOGIN()											
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIReturn_BB' + ':' + @FIAsset, '@FIAsset', @FIAsset, GetDate(), ORIGINAL_LOGIN()											
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIReturn_BB' + ':' + @FIAsset, '@AssumptionSetNo', @AssumptionSetNo, GetDate(), ORIGINAL_LOGIN()											
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIReturn_BB' + ':' + @FIAsset, '@prob_sr', @prob_sr, GetDate(), ORIGINAL_LOGIN()		
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIReturn_BB' + ':' + @FIAsset, '@max_loss', @max_loss, GetDate(), ORIGINAL_LOGIN()	
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIReturn_BB' + ':' + @FIAsset, '@max_spread', @max_spread, GetDate(), ORIGINAL_LOGIN()		
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIReturn_BB' + ':' + @FIAsset, '@yield_marg', @yield_marg, GetDate(), ORIGINAL_LOGIN()	
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIReturn_BB' + ':' + @FIAsset, '@mu_alpha', @mu_alpha, GetDate(), ORIGINAL_LOGIN()		
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIReturn_BB' + ':' + @FIAsset, '@sd_alpha', @sd_alpha, GetDate(), ORIGINAL_LOGIN()	
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIReturn_BB' + ':' + @FIAsset, '@dur', @dur, GetDate(), ORIGINAL_LOGIN()		
		*/
		
		--Calculate the increase/decrease in Credit Spread / Maximum Loss / Random Numbers for Alpha
		if OBJECT_ID('tempdb..#FI_Stressed') IS NOT NULL
		drop table #FI_Stressed

		;with FI_R_StressReg
		as (
			select *
			from vw_FI_R_StressReg_Unpvt
			),

		FI_R_StressRegCdnEq
		as (
			select rco.n, rco.t, rco.AssumptionSetNo, CdnEq
			from NFI_R_Corr_Final rco	
			)

		select sr.n, sr.t, sr.AssumptionSetNo, RAND(CHECKSUM( NEWID())) Rand_Alpha,
		   CASE WHEN sr.StressReg < @prob_sr THEN (1 - cdn.CdnEq) * @max_loss ELSE 0 END StressedLoss,
		   CASE WHEN sr.StressReg < @prob_sr THEN (1 - cdn.CdnEq) * @max_spread ELSE 0 END StressedSpread
		into #FI_Stressed
		from FI_R_StressReg sr
		
		inner join FI_R_StressRegCdnEq cdn on cdn.n = sr.n and cdn.t = sr.t	and cdn.AssumptionSetNo = sr.AssumptionSetNo
		
		where sr.AssumptionSetNo = @AssumptionSetNo
		order by sr.t, sr.n

		CREATE NONCLUSTERED INDEX idx_FI_Stressed on #FI_Stressed (n, t, AssumptionSetNo)

		--Calculate the yields and asset class return
		;with FIAsset_list_cte 
		as (
			select sq1.Id, sq1.SplitString FIAssetString, sq2.SplitString FIAssetWeights
			from Utils.dbo.tvf_SplitString(@FIAssetString, ',') sq1
			
			inner join (select * from Utils.dbo.tvf_SplitString(@FIAssetWeights, ',')) sq2 on sq1.Id = sq2.Id
			
			where sq2.SplitString <> 0.0
			),
		
		base_cte
		as (
			select FI.n, FI.t, @FIAsset [FIAsset],
					SUM(FIAssetWeights * FIYield) + (0.5 * ISNULL(MAX(stmin1.StressedSpread), 0)) + ISNULL(MAX(st.StressedSpread), 0) + @yield_marg [FIYield],
					ISNULL(MAX(st.StressedSpread), 0)								[FICredSprdInc] ,
					ISNULL(MAX(st.StressedLoss), 0)									[FILoss],
					ISNULL(MAX(st.Rand_Alpha),0)									[Rand_Alpha],
					@mu_alpha + @sd_alpha * Utils.dbo.normsinv(MAX(st.Rand_Alpha))	[Alpha], 
					FI.AssumptionSetNo [AssumptionSetNo]
			from FI_I_AssetYields FI
			
			inner join FIAsset_list_cte FIlist on FIlist.FIAssetString = FI.FIAsset
			left join #FI_Stressed st on FI.n = st.n and FI.t = st.t and FI.AssumptionSetNo = st.AssumptionSetNo
			left join #FI_Stressed stmin1 on FI.n = stmin1.n and FI.t = stmin1.t + 1 and FI.AssumptionSetNo = stmin1.AssumptionSetNo
			
			--I added only this line
			where FI.AssumptionSetNo = @AssumptionSetNo
			group by FI.n, FI.t, FI.AssumptionSetNo
			),

		recur_cte
		as (
			select b.n, b.t, b.FIAsset, b.FIYield, b.FICredSprdInc, b.FILoss, b.Rand_Alpha, b.Alpha, --bmin1.FIYield FIYield_tmin1, 
				bmin1.FIYield +  EXP( @dur * (bmin1.FIYield - b.FIYield)) - 1							[FI_PreLossAlphaReturn], 
				(bmin1.FIYield + EXP( @dur * (bmin1.FIYield - b.FIYield)) - 1 ) + b.Alpha - b.FILoss	[FI_CombinedReturn],
				b.AssumptionSetNo
			from base_cte b 
			
			inner join base_cte bmin1 on b.n = bmin1.n and b.t = bmin1.t + 1 and b.AssumptionSetNo = bmin1.AssumptionSetNo
			
			)
			/*where b.t = 1
	
			SELECT * FROM recur_cte ORDER BY n, t			

			union all
			
			select b.n, b.t, b.FIAsset, b.FIYield, b.FICredSprdInc, b.FILoss, b.Rand_Alpha, b.Alpha, --bmin1.FIYield FIYield_tmin1, 
				bmin1.FIYield + ( EXP( @dur * (bmin1.FIYield - b.FIYield)) - 1 )						[FI_PreLossAlphaReturn], 
				(bmin1.FIYield + ( EXP( @dur * (bmin1.FIYield - b.FIYield)) - 1 )) + b.Alpha - b.FILoss [FI_CombinedReturn],
				b.AssumptionSetNo
			from base_cte b 
			
			inner join recur_cte bmin1 on b.n = bmin1.n and b.t = bmin1.t + 1 and b.AssumptionSetNo = bmin1.AssumptionSetNo
			where b.t > 1
			)
			*/
		
		insert into FI_I_AssetYields(n, t, FIAsset, FIYield, FICredSprdInc, FILoss, Rand_Alpha, Alpha, FI_PreLossAlphaReturn, FI_CombinedReturn, AssumptionSetNo, CreatedDate, CreatedBy)
		select n, t, FIAsset, FIYield, ISNULL(FICredSprdInc,0), ISNULL(FILoss,0), ISNULL(Rand_Alpha,0), ISNULL(Alpha,0), 0 [FI_PreLossAlphaReturn], 0 [FI_CombinedReturn], AssumptionSetNo, GETDATE(), ORIGINAL_LOGIN()
		from base_cte b
		where t = 0
		 UNION ALL
		select n, t, FIAsset, FIYield, FICredSprdInc, FILoss, Rand_Alpha, Alpha, FI_PreLossAlphaReturn, FI_CombinedReturn, AssumptionSetNo, GETDATE(), ORIGINAL_LOGIN()
		from recur_cte b
		where t > 0

		create nonclustered index idx_FI_I_AssetYields on FI_I_AssetYields(n, t, FIAsset, AssumptionSetNo)

		--Write to Log file 
		declare @RowCnt as float = (select COUNT(*) from FI_I_AssetYields where AssumptionSetNo = @AssumptionSetNo and FIAsset = @FIAsset)  
		exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @FIAsset      

		--====================================
		--Load to the AssetClasseReturn table
		--Logging Parameters                                                                                                                                                                     
		set @ProcessName = 'Fixed Income Assets (Building Block Approach - Combined)'                                                                                                                                                                      
		set @ProcessStartDate = GETDATE()

		drop index idx_AssetClassReturn on AssetClassReturn


		--Insert the return summary into the AssetClassReturn Table
		insert into AssetClassReturn(n, t, Normal, Stressed, Combined, AssumptionSetNo, AssetClass, AssetGroup, Cumulative, CumulativeAnnualized, CreatedDate, CreatedBy)
		select n, t, FI_PreLossAlphaReturn [Normal], -FILoss + Alpha [Stressed], FI_CombinedReturn [Combined], AssumptionSetNo, FIAsset, 'Fixed Income' [AssetGroup], 
			NULL Cumulative, NULL CumulativeAnnualized, CreatedDate, CreatedBy
		from FI_I_AssetYields
		where FIAsset = @FIAsset and AssumptionSetNo = @AssumptionSetNo and t > 0

		create nonclustered index idx_AssetClassReturn on AssetClassReturn(n, t, AssumptionSetNo, AssetClass, AssetGroup)
			
		--Calculate the cumulative returns as well as cumulative annualized returns
		update acr
		set Cumulative = ISNULL(dbo.FV_Schedule_AssetClass(t, n, @FIAsset, @AssumptionSetNo),1), 
			CumulativeAnnualized = POWER((ISNULL(dbo.FV_Schedule_AssetClass(t, n, @FIAsset, @AssumptionSetNo),1)), (1 / (t * 1.0))) - 1
		from AssetClassReturn acr
		where AssetClass = @FIAsset and AssumptionSetNo = @AssumptionSetNo and Cumulative is NULL

	--Write to Log file											
    set @RowCnt = (select COUNT(*) from AssetClassReturn where AssumptionSetNo = @AssumptionSetNo and AssetClass = @FIAsset)                                
    exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @FIAsset   
	
	exec ProjectAssetClass @AssumptionSetNo, @FIAsset

	end		
	
	/*
	exec GenerateProjectedFIReturnCombinedYields_BB 'Tbills,GoC_AAA_7yrdurbonds,Prov_AAA_7yrdurbonds,Credit_BBB_7yrdurbonds,GoC_AAA_15yrdurbonds,Prov_AAA_15yrdurbonds,Credit_BBB_15yrdurbonds,HighYield,Mortgages,PrivDebt_SunlifePrxy,PrivDebt_InfraPrxy,PrivDebt_non_inv_grade', '0,0.3,0.3,0.4,0,0,0,0,0,0,0,0', 'Univ_7yrdur', 5, '0.075', '0.015', '0.02','0','0.005','0.005','7'
	*/
									
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedInflation]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2018/12/21>
-- Description:	<Stored procedure for creating projecting future inflation numbers>

-- Updated date: <2019/02/25>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <Added logging logic - 2020/02/11>
--				   <Added logic to stop execution if AssumptionSet is Finalized - 2020/02/25>

-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedInflation] (@Inf_tmin1 as varchar(1000), @w as varchar(1000), @Inf_LT as varchar(1000),@sd_e as varchar(1000), @mu_e as varchar(1000), @AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;
    
	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Project Inflation'
	declare @ProcessStartDate as datetime = GETDATE()
	
	--Stop stored procedure if results are finalized
	if (select IsFinalizedBy from AssumptionSet where AssumptionSetNo = @AssumptionSetNo) IS NOT NULL
		begin	
			exec WriteLog @AssumptionSetNo, 'Warning: AssumptionSet Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName
		end	
	else
	begin
	
	--Using ProVal's formula to project Inflation:    Inf(t) = [ Inf(t-1) x w ] + LTInf x (1-w) ] + e
	--NORMINV(p, mu, sigma) = mu + sigma*NORMSINV(p)
	--Parameters
	/*
	set @Inf_tmin1 = '0.016'
	set @w = '0.85'
	set @Inf_LT = '0.02'
	set @sd_e = '0.006'
	set @mu_e = '0'

	--exec GenerateProjectedInflation @Inf_tmin1, @w, @Inf_LT, @sd_e, @mu_e, @AssumptionSetNo
	--exec GenerateProjectedInflation '0.019', '0.85', '0.02', '0.005', '0.00', 1
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
	
	--Write to Log file
	declare @RowCnt as float = (select COUNT(*) from FI_I_Infl where AssumptionSetNo = @AssumptionSetNo)
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt

	end	
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedLiability]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:          <Justin Saw>
-- Create date:		<2019/01/23>
-- Description:     <Stored procedure for creating projected liability cash flow>

-- Updated date:	<2019/11/07>
-- Updated by:		<Gerrit Marais>
-- Updated reason:	<Fix the calculation to allow for multiple assumption sets (previous version caused serious duplication)> - <2019/04/09>
--					<Update the calculation to allow for different sets of Cash Flows for Solvency and Going Concern> - <2019/05/03>
--					<Altered the procedure to allow for the concept of a CashflowSetNo - 2019/11/07>
--				    <Added logging logic - 2020/02/11>
--				    <Added logic to stop execution if ResultSet is Finalized - 2020/02/25>
--					<Added logic to run with RateTypeCF if only on set of CFs loaded for all bases - 2020/05/20>
-- =============================================

CREATE PROCEDURE [dbo].[GenerateProjectedLiability] (@RateType as varchar(25), @ResultSetNo as int)
AS
BEGIN

SET NOCOUNT ON;

	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Project Liability Value'
	declare @ProcessStartDate as datetime = GETDATE()

	--Stop stored procedure if results are finalized
	if (select IsFinalizedBy from ResultSet where ResultSetNo = @ResultSetNo) IS NOT NULL
		begin	
			exec WriteLog @ResultSetNo, 'Warning: ResultSet Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName
		end	
	else
		begin
			/*
			--Testing Paramaters 
			declare @RateType as varchar(25) = 'GC'
			declare @ResultSetNo as int = 1

			exec GenerateProjectedLiability @RateType, @ResultSetNo
			exec GenerateProjectedLiability 'GC', 7
			exec GenerateProjectedLiability 'SOLV', 1
			exec GenerateProjectedLiability 'ACC', 2
			*/

			--Set starting parameters
			declare @AssumptionSetNo as int = (select AssumptionSetNo from ResultSet where ResultSetNo = @ResultSetNo)
			declare @CashflowSetNo as int = (select CashflowSetNo from ResultSet where ResultSetNo = @ResultSetNo)

			declare @ProcName as varchar(255) = 'GenerateProjectedLiability' +  ':' + CAST(@ResultSetNo as varchar) + ':' + @RateType

			declare @RateTypeCF as varchar(25) = (SELECT CASE WHEN (select UseSameCFAllBases from ResultSet where ResultSetNo = @ResultSetNo) = 'Yes'
															  THEN (select MIN(RateType) from ALM_I_L_CashFlow where CashflowSetNo = @CashflowSetNo)
															  ELSE @RateType END)

			if @RateTypeCF <> @RateType 
			begin	
				exec WriteLog @ResultSetNo, 'Warning: Liability Projected using Different CF Basis', @ProcessStartDate, 0, @RateType
			end	

			--Remove previous results (if exists)
			delete from ALM_R_L_ProjectedLiability 
			where ResultSetNo = @ResultSetNo and RateType = @RateType

			declare @sql as nvarchar(max)	
			declare @DBTable as varchar(MAX) = 'ALM_R_L_ProjectedLiability'
			declare @DBTable_new_reseed_value as int = (select MAX(PLKey) from ALM_R_L_ProjectedLiability)

			set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
			execute sp_executesql @sql 
	
			drop index idx_ALM_R_L_ProjectedLiability on ALM_R_L_ProjectedLiability

			;with accr_cte
			as (
				--PV Accrued Liability (Looks good)
				select dr.n, dr.t, dr.ResultSetNo, SUM(Accrued * POWER((1 + dr.DiscountRate), - (cf.t - dr.t))) [PV Accrued Liability]
				from ALM_I_L_CashFlow cf
				inner join ALM_I_L_DiscountRate dr on cf.t >= dr.t + 1 and dr.RateType = @RateType
				inner join ResultSet r on r.ResultSetNo = dr.ResultSetNo 
									  and r.CashflowSetNo = cf.CashflowSetNo
				where cf.t > dr.t 
					and cf.RateType = @RateTypeCF
					and dr.RateType = @RateType
					and dr.ResultSetNo = @ResultSetNo
					and r.AssumptionSetNo = @AssumptionSetNo
					and cf.CashflowSetNo = @CashflowSetNo
				group by dr.n, dr.t, dr.ResultSetNo
			),
			serv_cte
			as (
				--PV Service Costs (Working)
				select fs.n, fs.t, dr.ResultSetNo, SUM(FutureService * FV_Schedule_NC_FS * POWER((1 + dr.DiscountRate), -cf.t)) [PV Service Costs]
				from tmp.FV_Schedule_NC_FS fs
					inner join ALM_I_L_CashFlow cf on 1 = 1 and cf.CashflowSetNo = @CashflowSetNo
					inner join ALM_I_L_DiscountRate dr on fs.n = dr.n and fs.t = dr.t + 1  and dr.RateType = @RateType 
					inner join ResultSet r on r.ResultSetNo = dr.ResultSetNo 
										  and r.CashflowSetNo = cf.CashflowSetNo
										  and r.AssumptionSetNo = fs.AssumptionSetNo
				where dr.RateType = @RateType 
				  and cf.RateType = @RateTypeCF	
				  and dr.ResultSetNo = @ResultSetNo
				  and fs.AssumptionsetNo = @AssumptionSetNo
				  and cf.CashflowSetNo = @CashflowSetNo
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
										  and r.CashflowSetNo = w.CashflowSetNo
					where dr.RateType = @RateType 
					  and w.RateType =  @RateTypeCF
					  and dr.ResultSetNo = @ResultSetNo
					  and w.AssumptionsetNo = @AssumptionSetNo 
					  and w.CashflowSetNo = @CashflowSetNo
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

			--Write to Log file
			declare @RowCnt as float = (select COUNT(*) from ALM_R_L_ProjectedLiability where ResultSetNo = @ResultSetNo and RateType = @RateType)
			exec WriteLog @ResultSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @RateType

	end
	
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedLiability_Initial]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:          <Justin Saw>
-- Create date:		<2019/02/26>
-- Description:     <Stored procedure for creating the pre-work for the projected liability cash flows>

-- Update date:		<2019/12/11>
-- Updated by:		<Gerrit Marais>
-- Updated Reason:	<Stored Procedure adjusted to allow for Cash flows for both Solvency and GC basis>
--					<Altered the procedure to allow for the concept of a CashflowSetNo - 2019/11/07>
--					<Altered the procedure to write to parameter history - 2019/11/14>
--					<Altered the procedure to run a CashflowSet on any AssumptionSet - 2019/11/14>
--					<Added logging logic - 2020/02/11>
--					<Update logging logic to include additional messages - 2020/02/27>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedLiability_Initial] (@AssumptionSetNo as int, @CashflowSetNo as int, @RateType as varchar(50), @Apply_NC_FS_Adj as varchar(50))
AS
BEGIN

SET NOCOUNT ON;
	/*
	declare @AssumptionSetNo as int = 1
	declare @CashflowSetNo as int = 1
	declare @Apply_NC_FS_Adj as varchar(5) = 'N'
	declare @RateType as varchar(5) = 'GC'
	
	--truncate table tmp.FV_Schedule_CF
	--truncate table tmp.ALM_R_L_AdjustedLiability
	*/
	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Initial Liability Roll-forward (normal cost)'
	declare @ProcessStartDate as datetime
	declare @RowCnt as float 
	declare @OverAllProcessStartDate as datetime = GETDATE()
	
	--*******************************
	set @ProcessStartDate = GETDATE()
	exec WriteLog @CashflowSetNo, 'Message: Initial Liability Roll-forward (Normal Cost) - Start', @ProcessStartDate, 0
	--*******************************

	declare @ActiveDecline as float = (select ISNULL(AssPopulationChange, 0) from CashflowSet where CashflowSetNo = @CashflowSetNo)
	declare @SI_Above_Infl as float = (select ISNULL(AssSalaryInflation, 0) from CashflowSet where CashflowSetNo = @CashflowSetNo)

	exec GenerateProjectedSalaryIncreases @AssumptionSetNo, @SI_Above_Infl
	exec GenerateProjectedNCFSChange @ActiveDecline, @AssumptionSetNo
		
	declare @itncnt as int = 2000

	declare @ProcName as varchar(255) = 'GenerateProjectedLiability_Initial' + ':' + @RateType + ':' + CAST(@CashflowSetNo as varchar)

	--Parameter History
	delete from ParameterHistory where AssumptionSetNo = @AssumptionSetNo and ParameterProc = @ProcName

	--Store the parameter values for future reference
	insert into ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
	select @AssumptionSetNo, @ProcName, '@CashflowSetNo', @CashflowSetNo, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@AssumptionSetNo', @AssumptionSetNo, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@Apply_NC_FS_Adj', CASE WHEN @Apply_NC_FS_Adj = 'Y' THEN 1 ELSE 0 END, GetDate(), ORIGINAL_LOGIN()
		
	--Adjust the cash flows using the NC_FC projection table
	truncate table tmp.FV_Schedule_CF
	/*
	delete from tmp.FV_Schedule_CF
	where AssumptionSetNo = @AssumptionSetNo
		and CashflowSetNo = @CashflowSetNo
	*/
	--*******************************
	set @ProcessStartDate = GETDATE()
	exec WriteLog @CashflowSetNo, 'Message: Setup FVSchedule for Normal Cost - Start', @ProcessStartDate, 0, @Apply_NC_FS_Adj
	--*******************************
	drop index idx_FV_Schedule_CF on tmp.FV_Schedule_CF
		
	insert into tmp.FV_Schedule_CF
	select fv.n, fv.t, cf.t cf_t, cf.NormalCost, 
		ISNULL((CASE WHEN @Apply_NC_FS_Adj = 'Y' THEN fv.FV_Schedule_NC_FS ELSE 1 END) * cf.NormalCost, 0) Adjusted, 
		@AssumptionSetNo AssumptionSetNo, @CashflowSetNo CashflowSetNo
	from tmp.FV_Schedule_NC_FS fv
	inner join ALM_I_L_CashFlow cf on 1 = 1 and cf.RateType = @RateType
											and cf.CashflowSetNo = @CashflowSetNo
	where fv.AssumptionSetNo = @AssumptionSetNo and fv.t > 0 and fv.n <= @itncnt
	
	--*******************************
	set @RowCnt = (select COUNT(*) from tmp.FV_Schedule_CF where AssumptionSetNo = @AssumptionSetNo and CashflowSetNo = @CashflowSetNo)
	exec WriteLog @CashflowSetNo, 'Message: Setup FVSchedule for Normal Cost - End', @ProcessStartDate, @RowCnt, @Apply_NC_FS_Adj
	--*******************************

	create nonclustered index idx_FV_Schedule_CF on tmp.FV_Schedule_CF(n, t, cf_t, AssumptionSetNo, CashflowSetNo)
	
	
	--==============================
	--Build in COLA adjustment here.
	--==============================
	
	--Create adjusted cash flow table for each projection year
	
	--*******************************
	set @ProcessStartDate = GETDATE()
	exec WriteLog @CashflowSetNo, 'Message: Project Adjusted Normal Cost Liability - Start',  @ProcessStartDate, 0, @Apply_NC_FS_Adj
	--*******************************

	--Remove previous results (if exists)
	delete from tmp.ALM_R_L_AdjustedLiability
	where AssumptionSetNo = @AssumptionSetNo 
	  and RateType = @RateType
	  and CashflowSetNo = @CashflowSetNo
	
	drop index idx_ALM_R_L_AdjustedLiability on tmp.ALM_R_L_AdjustedLiability
	
	--Persist table
	insert into tmp.ALM_R_L_AdjustedLiability
	select j.n t, w.n, t.n prj_t, SUM(Adjusted) NondiscountedValue, @AssumptionSetNo, @CashflowSetNo, @RateType RateType, GetDate() CreatedDate, ORIGINAL_LOGIN() CreatedBy
	from tmp.FV_Schedule_CF w 
		   inner join Tally t on w.t <= t.n and t.n <= 30
		   inner join Tally i on i.n between 1 and t.n
		   inner join Tally j on j.n between 1 and 100 and cf_t = (j.n + (t.n - i.n)) and w.t = i.n
	where w.AssumptionSetNo = @AssumptionSetNo
		and w.CashflowSetNo = @CashflowSetNo
	group by j.n, w.n, t.n

	--*******************************
	set @RowCnt = (select COUNT(*) from tmp.ALM_R_L_AdjustedLiability where AssumptionSetNo = @AssumptionSetNo and CashflowSetNo = @CashflowSetNo)
	exec WriteLog @CashflowSetNo, 'Message: Project Adjusted Normal Cost Liability - End', @ProcessStartDate, @RowCnt, @Apply_NC_FS_Adj
	--*******************************
	--Clean-up 
	truncate table tmp.FV_Schedule_CF

	create nonclustered index idx_ALM_R_L_AdjustedLiability on tmp.ALM_R_L_AdjustedLiability(n, t, prj_t, AssumptionSetNo, CashflowSetNo, RateType)
	
	
	--*******************************
	--Write to Log file
	--*******************************
	set @RowCnt = (select COUNT(*) from tmp.ALM_R_L_AdjustedLiability where CashflowSetNo = @CashflowSetNo and RateType = @RateType and AssumptionSetNo = @AssumptionSetNo)
	exec WriteLog @CashflowSetNo, @ProcessName, @OverAllProcessStartDate, @RowCnt, @itncnt
	--*******************************
	
	--Update the CashflowSet table
	update cf
	set IsProjectedDate = GETDATE(), IsProjectedBy = ORIGINAL_LOGIN(), 
		cf.AssPopulationChange = @ActiveDecline, cf.AssSalaryInflation = @SI_Above_Infl,
		cf.IsProjectedAssumptionSetNo = @AssumptionSetNo
	from CashflowSet cf
	where CashflowSetNo = @CashflowSetNo
	   
	--*******************************
	set @ProcessStartDate = GETDATE()
	exec WriteLog @CashflowSetNo, 'Message: Initial Liability Roll-forward (Normal Cost) - End', @ProcessStartDate, 0
	--*******************************
	
	/*
	--Test
	exec GenerateProjectedLiability_Initial @AssumptionSetNo, @CashflowSetNo, @RateType, @Apply_NC_FS_Adj 
	exec GenerateProjectedLiability_Initial  1, 1, 'GC', 'Y'
	exec GenerateProjectedLiability_Initial  2, 2, 'GC', 'Y'
	*/

END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedLongTermReturn]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/01/03>
-- Description:	<Stored procedure for creating projecting future Long term returns>

-- Updated date: <2019/02/11>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <Added logging logic - 2020/02/11>
--				   <Added logic to stop execution if AssumptionSet is Finalized - 2020/02/25>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedLongTermReturn] (@AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;
    
	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Project Long-Term Premium'
	declare @ProcessStartDate as datetime = GETDATE()

	--Stop stored procedure if results are finalized
	if (select IsFinalizedBy from AssumptionSet where AssumptionSetNo = @AssumptionSetNo) IS NOT NULL
		begin	
			exec WriteLog @AssumptionSetNo, 'Warning: AssumptionSet Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName
		end	
	else
	begin
	--Using ProVal's formula to project Inflation:    LT(t) = ST(t) + TP(t)
	--Pre-requisites include running [dbo].[GenerateProjectedInflation] & [dbo].[GenerateProjectedInflation] & [dbo].[GenerateProjectedShortTermReturn] & [dbo].[GenerateProjectedTermPremium]
	--exec GenerateProjectedLongTermReturn @AssumptionSetNo
	--exec GenerateProjectedLongTermReturn 1
	
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

	--Write to Log file
	declare @RowCnt as float = (select COUNT(*) from FI_I_LongTermReturn where AssumptionSetNo = @AssumptionSetNo)
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt
	
	end
	
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedMVA_MEPP]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:          <Justin Saw>
-- Create date:		<2019/01/23>
-- Description:     <Stored procedure for creating projected Market Value of Assets for MEPP>

-- Updated by:		<Gerrit Marais>
-- Updated date:	<2019/11/07>
-- Updated reason:	<Updated the stored procedure to allow for calculation of Funded Ratio tables> - <2019-05-07>
--					<Updated the stored procedure to calculate cumulative contributions> - <2019-05-17>
--					<Updated the stored procedure fix a duplication issue when running multiple assumption sets> - <2019-08-16>
--					<Altered the procedure to allow for the concept of a CashflowSetNo - 2019/11/07>
--					<Call the stored procedure for asset smoothing - 2019/11/07>
--				    <Added logging logic - 2020/02/11>
--				    <Added logic to stop execution if ResultSet is Finalized - 2020/02/25>
--					<Added logic to run with RateTypeCF if only on set of CFs loaded for all bases - 2020/05/20>
-- =============================================
/*
--Notes
This stored procedure is meant for multi employer pension plans, where contributions are established by a collective agreement (imported by user).
*/
-- =============================================

CREATE PROCEDURE [dbo].[GenerateProjectedMVA_MEPP] (@StartingAssetValue as float, @AdminFees as float, @ContrProj as varchar(5), @RateType as varchar(5), @ResultSetNo as int)
AS
BEGIN

SET NOCOUNT ON;

	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Project Asset Value (MEPP)'
	declare @ProcessStartDate as datetime = GETDATE()
	declare @RowCnt as float 
	declare @OverAllProcessStartDate as datetime = GETDATE()

	--*******************************
	set @ProcessStartDate = GETDATE()
	exec WriteLog @ResultSetNo, 'Message: Project Asset Value (MEPP) - Start', @ProcessStartDate, 0, @RateType
	--*******************************

	--Stop stored procedure if results are finalized
	if (select IsFinalizedBy from ResultSet where ResultSetNo = @ResultSetNo) IS NOT NULL
		begin	
			exec WriteLog @ResultSetNo, 'Warning: ResultSet Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName
		end	
	else
		begin

			/*
			--Testing Paramaters 
			declare @StartingAssetValue as float = '108436780.00'
			declare @AdminFees as float = '0.0035'
			declare @ContrProj as varchar(5) = 'Y'
	
			declare @RateType as varchar(5) = 'GC'
			declare @ResultSetNo as int = 1

			exec GenerateProjectedMVA_MEPP @StartingAssetValue, @AdminFees, @ContrProj, @RateType, @ResultSetNo
			exec GenerateProjectedMVA_MEPP '76702163', '0.0045', 'Y','GC', 1
			*/
					   
			--Set starting parameters
			declare @AssumptionSetNo as int = (select AssumptionSetNo from ResultSet where ResultSetNo = @ResultSetNo)
			declare @CashflowSetNo as int = (select CashflowSetNo from ResultSet where ResultSetNo = @ResultSetNo)
	
			declare @MixName as varchar(255) = (select MixName from ResultSet where ResultSetNo = @ResultSetNo)
			declare @ProcName as varchar(255) = 'GenerateProjectedMVA' +  ':' + @MixName  +  ':' + CAST(@ResultSetNo as varchar)
	
			--Check if the Asset History is populated and use that as starting value for assets
			set @StartingAssetValue = (SELECT CASE WHEN @StartingAssetValue = 0 THEN (select (MIN(AccruedLiability) + MIN(NormalCosts) + MIN(ServiceCosts)) * POWER(1 + MIN(DiscountRate), 0.5)
																					  from ALM_R_L_ProjectedLiability liab
																					  inner join ALM_I_L_DiscountRate dr on liab.n = dr.n and liab.t = dr.t and liab.ResultSetNo = dr.ResultSetNo
																					  where liab.t = 0 and liab.ResultSetNo = @ResultSetNo)
												   ELSE ISNULL((select MVA_EOY from ALM_I_A_AssetValueHistory where t = 0 and CashflowSetNo = @CashflowSetNo), @StartingAssetValue) END) 
			
			declare @RateTypeCF as varchar(25) = (SELECT CASE WHEN (select UseSameCFAllBases from ResultSet where ResultSetNo = @ResultSetNo) = 'Yes'
															  THEN (select MIN(RateType) from ALM_I_L_CashFlow where CashflowSetNo = @CashflowSetNo)
															  ELSE @RateType END)

			if @RateTypeCF <> @RateType 
			begin	
				exec WriteLog @ResultSetNo, 'Warning: Assets Projected using Different CF Basis', @ProcessStartDate, 0, @RateType
			end	
												
			------------------------------------------------------------------------------------------------------
			--Parameter History
			delete from ParameterHistory where AssumptionSetNo = @AssumptionSetNo and ParameterProc = @ProcName

			--Store the parameter values for future reference
			insert into ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
			select @AssumptionSetNo, @ProcName, '@StartingAssetValue', @StartingAssetValue, GetDate(), ORIGINAL_LOGIN()
				union
			select @AssumptionSetNo, @ProcName, '@AdminFees', @AdminFees, GetDate(), ORIGINAL_LOGIN()
				union 
			select @AssumptionSetNo, @ProcName, '@CashflowSetNo', @CashflowSetNo, GetDate(), ORIGINAL_LOGIN()
				union
			select @AssumptionSetNo, @ProcName, '@ContrProj', CASE WHEN @ContrProj = 'Y' THEN 1 ELSE 0 END, GetDate(), ORIGINAL_LOGIN()
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

			declare @sql as nvarchar(max)	
			declare @DBTable as varchar(MAX) = 'ALM_R_A_ProjectedContributions'
			declare @DBTable_new_reseed_value as int = (select MAX(PCKey) from ALM_R_A_ProjectedContributions)

			set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
			execute sp_executesql @sql 
	
			drop index idx_ALM_R_A_ProjectedContributions on ALM_R_A_ProjectedContributions
	
			--Calculate Results
			insert into ALM_R_A_ProjectedContributions (n, t, Contributions, ResultSetNo, CreatedDate, CreatedBy)
			select fs.n, fs.t, case when  @ContrProj ='Y' then Contributions * FV_Schedule_NC_FS else Contributions END [Contributions], @ResultSetNo, GetDate() CreatedDate, ORIGINAL_LOGIN() CreatedBy
			from tmp.FV_Schedule_NC_FS fs
				   inner join ALM_I_L_CashFlow cf on cf.t = fs.t
				   inner join ResultSet rs on rs.AssumptionSetNo = fs.AssumptionSetNo 
										  and rs.CashflowSetNo = cf.CashflowSetNo
										  and rs.ResultSetNo = @ResultSetNo
			where cf.RateType = @RateTypeCF 
			  and cf.CashflowSetNo = @CashflowSetNo
			  and fs.AssumptionSetNo = @AssumptionSetNo


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
			
			create nonclustered index idx_ALM_R_A_ProjectedContributions on ALM_R_A_ProjectedContributions(n, t, ResultSetNo)
			
			--*******************************
			set @ProcessStartDate = GETDATE()
			set @RowCnt = (select COUNT(*) from ALM_R_A_ProjectedContributions where ResultSetNo = @ResultSetNo)
			exec WriteLog @ResultSetNo, 'Message: Projecting Contributions', @ProcessStartDate, @RowCnt, @RateType 
			--*******************************
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

			set @DBTable = 'ALM_R_A_ProjectedBenefitPayments'
			set @DBTable_new_reseed_value = (select MAX(BPKey) from ALM_R_A_ProjectedBenefitPayments)

			set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
			execute sp_executesql @sql 

			drop index idx_ALM_R_A_ProjectedBenefitPayments on ALM_R_A_ProjectedBenefitPayments
			
			--Calculate Results
			insert into ALM_R_A_ProjectedBenefitPayments(n, t, BenefitPayment, ResultSetNo, CreatedDate, CreatedBy)
			select w.n, w.prj_t, Accrued + ISNULL(w.NondiscountedValue, 0) BenefitPayment, @ResultSetNo ResultSetNo, GETDATE() CreatedDate, ORIGINAL_LOGIN() CreatedBy 
			from tmp.ALM_R_L_AdjustedLiability w
			inner join ResultSet rs on rs.AssumptionSetNo = w.AssumptionSetNo 
								   and rs.CashflowSetNo = w.CashflowSetNo
								   and rs.ResultSetNo = @ResultSetNo
			inner join ALM_I_L_CashFlow cf on w.prj_t = cf.t and w.t = 1
										  and w.CashflowSetNo = cf.CashflowSetNo
										  and w.RateType = cf.RateType
			where w.AssumptionSetNo = @AssumptionSetNo
			  and w.CashflowSetNo = @CashflowSetNo
			  and w.RateType = @RateTypeCF 
	  
			create nonclustered index idx_ALM_R_A_ProjectedBenefitPayments on ALM_R_A_ProjectedBenefitPayments(n, t, ResultSetNo)
			
			--*******************************
			set @ProcessStartDate = GETDATE()
			set @RowCnt = (select COUNT(*) from ALM_R_A_ProjectedBenefitPayments where ResultSetNo = @ResultSetNo)
			exec WriteLog @ResultSetNo, 'Message: Projecting Benefit Payments', @ProcessStartDate, @RowCnt, @RateType
			--*******************************
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

			--ALM_R_A_ProjectedCashFlow
			set @DBTable = 'ALM_R_A_ProjectedCashFlow'
			set @DBTable_new_reseed_value = (select MAX(CFKey) from ALM_R_A_ProjectedCashFlow)

			set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
			execute sp_executesql @sql 
	
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

			--ALM_R_A_ProjectedMVA	
			set @DBTable = 'ALM_R_A_ProjectedMVA'
			set @DBTable_new_reseed_value = (select MAX(MVAKey) from ALM_R_A_ProjectedMVA)

			set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
			execute sp_executesql @sql 

			--Calculate Results
			declare @t as int = 1
	
			While @t <= 30
			Begin
				if @t = 1 
				Begin
					--Market Value of Assets at the Start of Projection
					insert into ALM_R_A_ProjectedMVA(n, t, MVA, ResultSetNo, CreatedDate, CreatedBy)
					select t.n, @t - 1, @StartingAssetValue MVA, @ResultSetNo ResultSetNo, GetDate() CreatedDate, ORIGINAL_LOGIN() CreatedBy
					from Tally t
					where t.n <= 2000 --(select MAX(n) from FI_I_Infl i where i.AssumptionSetNo = t.AssumptionSetNo)

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

			--*******************************
			set @ProcessStartDate = GETDATE()
			set @RowCnt = (select COUNT(*) from ALM_R_A_ProjectedMVA where ResultSetNo = @ResultSetNo)
			exec WriteLog @ResultSetNo, 'Message: Projecting Expected Cash Flow (ECF) & Market Value of Assets (MVA)', @ProcessStartDate, @RowCnt, @RateType
			--*******************************

			--Funded Ratio Volatility Calulation
			delete from ALM_R_FR_Volatility where ResultSetNo = @ResultSetNo and RateType = @RateType
			drop index idx_ALM_R_FR_Volatility on ALM_R_FR_Volatility

			set @DBTable = 'ALM_R_FR_Volatility'
			set @DBTable_new_reseed_value = (select MAX(SigmaFRKey) from ALM_R_FR_Volatility)

			set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
			execute sp_executesql @sql 
		
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
			where mva.ResultSetNo = @ResultSetNo and dis.RateType = @RateType
			order by t, n

			update t1
			set t1.DeltaFundedRatio = ISNULL((t1.ProjectedFundedRatio/t2.ProjectedFundedRatio - 1), 0)
			from ALM_R_FR_Volatility t1
			left join ALM_R_FR_Volatility t2 on t1.t = t2.t + 1 
											and t1.n = t2.n 
											and t1.ResultSetNo = t2.ResultSetNo 
											and t1.RateType = t2.RateType
			where t1.DeltaFundedRatio is NULL
			  and t1.RateType = @RateType

			create nonclustered index idx_ALM_R_FR_Volatility on ALM_R_FR_Volatility(n, t, ResultSetNo, RateType)
			
			--*******************************
			set @ProcessStartDate = GETDATE()
			set @RowCnt = (select COUNT(*) from ALM_R_FR_Volatility where ResultSetNo = @ResultSetNo and RateType = @RateType)
			exec WriteLog @ResultSetNo, 'Message: Calculating Funded Ratio & Funded Ratio Volatility', @ProcessStartDate, @RowCnt, @RateType
			--*******************************
			--*******************************
			set @ProcessStartDate = GETDATE()
			exec WriteLog @ResultSetNo, 'Message: Project Asset Value (MEPP) - End', @ProcessStartDate, 0, @RateType
			--*******************************
			
			--Write to Log file
			set @RowCnt = (select COUNT(*) from ALM_R_A_ProjectedMVA where ResultSetNo = @ResultSetNo)
			exec WriteLog @ResultSetNo, @ProcessName, @OverallProcessStartDate, @RowCnt, @RateType
	
			--Update the Projection Date
			EXEC ProjectResultSet @ResultSetNo

		end
	
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedMVA_MEPP_DP]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:          <Gerrit Marais>
-- Create date:		<2019/10/30>
-- Description:     <Stored procedure for creating projected Market Value of Assets for MEPP with deficit payments>

-- Updated date:	<2019/11/07>
-- Updated by:		<Gerrit Marais>
-- Updated reason:	<Altered the procedure to allow for the concept of a CashflowSetNo - 2019/11/07>
--				    <Added logging logic - 2020/02/11>
--				    <Added logic to stop execution if ResultSet is Finalized - 2020/02/25>
--					<Added logic to run with RateTypeCF if only on set of CFs loaded for all bases - 2020/05/21>
-- =============================================

CREATE PROCEDURE [dbo].[GenerateProjectedMVA_MEPP_DP] (@RateType as varchar(25), @AmortPeriod as float, @Expenses as float, @PfAD as float, @ResultSetNo as int)
AS
BEGIN

SET NOCOUNT ON;
	
	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Project Deficit Payments'
	declare @ProcessStartDate as datetime = GETDATE()
	declare @RowCnt as float

		--Stop stored procedure if results are finalized
	if (select IsFinalizedBy from ResultSet where ResultSetNo = @ResultSetNo) IS NOT NULL
		begin	
			exec WriteLog @ResultSetNo, 'Warning: ResultSet Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName
		end	
	else
		begin

			/*
			--Testing Paramaters 
			declare @AmortPeriod as int = 12
			declare @Expenses as float = '200000'
			declare @PfAD as float = '0.00'
			declare @RateType as varchar(50) = 'GC'
			declare @ResultSetNo as int = 7
						
			exec GenerateProjectedMVA_MEPP_DP @AmortPeriod, @Expenses, @PfAD, @ResultSetNo
			exec GenerateProjectedMVA_MEPP_DP 12, '14000000', '0.00', 13
	   		*/

			--*******************************
			set @ProcessStartDate = GETDATE()
			exec WriteLog @ResultSetNo, 'Message: Project Deficit Payments (MEPP) - Start', @ProcessStartDate, 0, @RateType
			--*******************************

			--Set starting parameters
			declare @AssumptionSetNo as int = (select AssumptionSetNo from ResultSet where ResultSetNo = @ResultSetNo)
			declare @CashflowSetNo as int = (select CashflowSetNo from ResultSet where ResultSetNo = @ResultSetNo)
	
			declare @MixName as varchar(255) = (select MixName from ResultSet where ResultSetNo = @ResultSetNo)
			declare @ProcName as varchar(255) = 'GenerateProjectedMVA_MEPP_DP' +  ':' + @MixName  +  ':' + CAST(@ResultSetNo as varchar)

			declare @RateTypeCF as varchar(25) = (SELECT CASE WHEN (select UseSameCFAllBases from ResultSet where ResultSetNo = @ResultSetNo) = 'Yes'
															THEN (select MIN(RateType) from ALM_I_L_CashFlow where CashflowSetNo = @CashflowSetNo)
															ELSE @RateType END)
			------------------------------------------------------------------------------------------------------
			--Parameter History
			delete from ParameterHistory where AssumptionSetNo = @AssumptionSetNo and ParameterProc = @ProcName

			--Store the parameter values for future reference
			insert into ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
			select @AssumptionSetNo, @ProcName, '@AmortPeriod', @AmortPeriod, GetDate(), ORIGINAL_LOGIN()
				union
			select @AssumptionSetNo, @ProcName, '@Expenses', @Expenses, GetDate(), ORIGINAL_LOGIN()
				union
			select @AssumptionSetNo, @ProcName, '@PfAD', @PfAD, GetDate(), ORIGINAL_LOGIN()
	
			--Clear the old data
			delete from tmp.ALM_R_CF_NormalCost where ResultSetNo = @ResultSetNo and RateType = @RateType
			delete from tmp.ALM_R_CF_SF_DefPmt where ResultSetNo = @ResultSetNo and RateType = @RateType
			delete from ALM_R_A_ProjectedReqContributions where ResultSetNo = @ResultSetNo and RateType = @RateType

			drop index idx_ALM_R_CF_NormalCost on tmp.ALM_R_CF_NormalCost
			drop index idx_ALM_R_CF_SF_DefPmt on tmp.ALM_R_CF_SF_DefPmt	
			drop index idx_ALM_R_A_ProjectedReqContributions on ALM_R_A_ProjectedReqContributions

			declare @sql as nvarchar(max)	
			declare @DBTable as varchar(MAX) = 'ALM_R_A_ProjectedReqContributions'
			declare @DBTable_new_reseed_value as int = (select MAX(PCKey) from ALM_R_A_ProjectedReqContributions)

			set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
			execute sp_executesql @sql

			--Calculate the Shortfall and possible Deficit Payment
			insert into tmp.ALM_R_CF_SF_DefPmt(n, t, ShortFall, DefPmt, Smooth_ShortFall, Smooth_DefPmt, RateType, ResultSetNo, CreatedDate, CreatedBy)
			select mva.n, mva.t, 
				--(AccruedLiability + NormalCosts + ServiceCosts) * POWER(1 + DiscountRate, 0.5) [ProjectedLiability],
				(mva.MVA - (AccruedLiability + NormalCosts + ServiceCosts) * POWER(1 + DiscountRate, 0.5)) ShortFall, 
				CASE WHEN -Utils.dbo.PMT(dr.DiscountRate, 12, (mva.MVA - (AccruedLiability + NormalCosts + ServiceCosts) * POWER(1 + DiscountRate, 0.5)) / POWER(1 + DiscountRate, 0.5)) > 0 
					 THEN -Utils.dbo.PMT(dr.DiscountRate, 12, (mva.MVA - (AccruedLiability + NormalCosts + ServiceCosts) * POWER(1 + DiscountRate, 0.5)) / POWER(1 + DiscountRate, 0.5)) ELSE 0 END	DefPmt,
				(mva.Smooth_MVA - (AccruedLiability + NormalCosts + ServiceCosts) * POWER(1 + DiscountRate, 0.5)) Smooth_ShortFall, 
				CASE WHEN -Utils.dbo.PMT(dr.DiscountRate, 12, (mva.Smooth_MVA - (AccruedLiability + NormalCosts + ServiceCosts) * POWER(1 + DiscountRate, 0.5)) / POWER(1 + DiscountRate, 0.5)) > 0 
					 THEN -Utils.dbo.PMT(dr.DiscountRate, 12, (mva.Smooth_MVA - (AccruedLiability + NormalCosts + ServiceCosts) * POWER(1 + DiscountRate, 0.5)) / POWER(1 + DiscountRate, 0.5)) ELSE 0 END	Smooth_DefPmt,
				pl.RateType, mva.ResultSetNo, GetDate() CreatedDate, ORIGINAL_LOGIN() CreatedBy
			from ALM_R_A_ProjectedMVA mva
			inner join ALM_R_L_ProjectedLiability pl on mva.n = pl.n and mva.t = pl.t 
													and mva.ResultSetNo = pl.ResultSetNo
			inner join ALM_I_L_DiscountRate dr on mva.n = dr.n and mva.t = dr.t	
											  and mva.ResultSetNo = dr.ResultSetNo 
											  and pl.RateType = dr.RateType
			where pl.RateType = @RateType
			  and mva.ResultSetNo = @ResultSetNo
			order by mva.n, mva.t
			
				
			--*******************************
			set @ProcessStartDate = GETDATE()
			set @RowCnt = (select COUNT(*) from tmp.ALM_R_CF_SF_DefPmt where ResultSetNo = @ResultSetNo and RateType = @RateType)
			exec WriteLog @ResultSetNo, 'Message: Projecting Shortfall & Deficit Payments', @ProcessStartDate, @RowCnt, @RateType
			--*******************************
		
			--Calculate Results
			declare @t as int = 1
	
			While @t <= 30
			Begin
				--Project the Normal Cost
				insert into tmp.ALM_R_CF_NormalCost(n, t, NormalCost, RateType, ResultSetNo, CreatedDate, CreatedBy)
				select sq.n, @t t, SUM(CF) * POWER((1 + MAX(dr.DiscountRate)),0.5) * MAX(ISNULL(FV_Schedule_NC_FS,1)) NormalCost, dr.RateType, @ResultSetNo, GetDate() CreatedDate, ORIGINAL_LOGIN() CreatedBy
				from (
					select dr.n, dr.t, cf.NormalCost * POWER((1 + dr.DiscountRate), -cf.t) cf, DiscountRate, dr.RateType, dr.ResultSetNo
					from ALM_I_L_DiscountRate dr
					inner join ALM_I_L_CashFlow cf on 1 = 1 and cf.CashflowSetNo = @CashflowSetNo
															and cf.RateType = dr.RateType
					inner join ResultSet rs on rs.ResultSetNo = dr.ResultSetNo
										   and rs.AssumptionSetNo = @AssumptionSetNo
										   and rs.CashflowSetNo = cf.CashflowSetNo										
					where dr.t = (@t - 1)
						and dr.RateType = 'GC'
						and dr.ResultSetNo = @ResultSetNo
				) sq
				inner join ALM_I_L_DiscountRate dr on dr.n = sq.n and dr.t = (@t - 1) 
												  and dr.RateType = @RateType
												  and dr.ResultSetNo = @ResultSetNo
				left join tmp.FV_Schedule_NC_FS fs on fs.n = dr.n and fs.t = @t and fs.AssumptionSetNo = @AssumptionSetNo
				group by sq.n, dr.DiscountRate, dr.RateType
				order by sq.n
		
				set @t = @t + 1
			End

			--*******************************
			set @ProcessStartDate = GETDATE()
			set @RowCnt = (select COUNT(*) from tmp.ALM_R_CF_NormalCost where ResultSetNo = @ResultSetNo and RateType = @RateType)
			exec WriteLog @ResultSetNo, 'Message: Projecting Normal Cost', @ProcessStartDate, @RowCnt, @RateType
			--*******************************
	
			create nonclustered index idx_ALM_R_CF_NormalCost on tmp.ALM_R_CF_NormalCost(n, t, RateType, ResultSetNo)
			create nonclustered index idx_ALM_R_CF_SF_DefPmt on tmp.ALM_R_CF_SF_DefPmt(n, t, RateType, ResultSetNo)
	
			--Calculate the Required Contributions
			insert into ALM_R_A_ProjectedReqContributions(n, t, ReqContributions, Smooth_ReqContributions, RateType, ResultSetNo, CreatedDate, CreatedBy)
			select nc.n, nc.t, (nc.NormalCost * (1 + @PfAD) + dp.DefPmt + @Expenses) ReqContributions, 
			(nc.NormalCost * (1 + @PfAD) + dp.Smooth_DefPmt + @Expenses) Smooth_ReqContributions, 
				nc.RateType, nc.ResultSetNo, GETDATE(), ORIGINAL_LOGIN()
			from tmp.ALM_R_CF_NormalCost nc
			inner join tmp.ALM_R_CF_SF_DefPmt dp on dp.n = nc.n and dp.t = nc.t and dp.ResultSetNo = nc.ResultSetNo and dp.RateType = nc.RateType
			where nc.ResultSetNo = @ResultSetNo and nc.RateType = @RateType
			order by n, t

			--*******************************
			set @ProcessStartDate = GETDATE()
			set @RowCnt = (select COUNT(*) from ALM_R_A_ProjectedReqContributions where ResultSetNo = @ResultSetNo and RateType = @RateType)
			exec WriteLog @ResultSetNo, 'Message: Projecting Required Contributions', @ProcessStartDate, @RowCnt, @RateType
			--*******************************

			create nonclustered index idx_ALM_R_A_ProjectedReqContributions on ALM_R_A_ProjectedReqContributions(n, t, RateType, ResultSetNo)

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
					where pl.ResultSetNo = @ResultSetNo and pl.RateType = @RateType
					group by pl.n, pl.t, pl.RateType, pl.ResultSetNo
					) sq on def.n = sq.n and def.t = sq.t and def.RateType = sq.RateType and def.ResultSetNo = sq.ResultSetNo
	
			--Update the Req.Contributions table with Cumulative Values
			update con
			set CumReqContributions = sq.CumReqContributions
			from ALM_R_A_ProjectedReqContributions con
			inner join (select pl.n, pl.t, pl.RateType, pl.ResultSetNo, SUM(conc.ReqContributions) CumReqContributions
						from ALM_R_A_ProjectedReqContributions pl
						inner join ALM_R_A_ProjectedReqContributions conc on conc.n = pl.n 
														  and conc.t <= pl.t 
														  and conc.ResultSetNo = pl.ResultSetNo
														  and conc.RateType = pl.RateType
						where pl.ResultSetNo = @ResultSetNo and pl.RateType = @RateType
						group by pl.n, pl.t, pl.RateType, pl.ResultSetNo
					) sq on con.n = sq.n and con.t = sq.t and con.ResultSetNo = sq.ResultSetNo and con.RateType = sq.RateType
	
			--*******************************
			set @ProcessStartDate = GETDATE()
			exec WriteLog @ResultSetNo, 'Message: Project Deficit Payments (MEPP) - End', @ProcessStartDate, 0, @RateType
			--*******************************

			--Write to Log file
			set @RowCnt = (select COUNT(*) from ALM_R_A_ProjectedReqContributions where ResultSetNo = @ResultSetNo and RateType = @RateType)
			exec WriteLog @ResultSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @RateType

		end
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedMVA_SEPP]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:          <Justin Saw>
-- Create date:		<2019/01/23>
-- Description:     <Stored procedure for creating projected Market Value of Assets for SEPP>

-- Updated date:	<2019/11/08>
-- Updated by:		<Gerrit Marais>
-- Updated reason:	<Fix the calculation to allow for multiple assumption sets (previous version caused serious duplication)>
--					<Fix the normal cost calculation NC_FS Adjustment was linking to (t - 1) instead of (t)> -- 2019/04/12
--					<Update the calculation to allow for different sets of Cash Flows for Solvency and Going Concern> - <2019/05/03>
--					<Altered the procedure to allow for the concept of a CashflowSetNo - 2019/11/07>
--				    <Added logging logic - 2020/02/26>
--				    <Added logic to stop execution if ResultSet is Finalized - 2020/02/26>
--					<Added logic to run with RateTypeCF if only on set of CFs loaded for all bases - 2020/05/21>
-- =============================================
-- =============================================
--Notes
--This stored procedure is meant for single employer pension plans, where contributions are equal to the normal costs plus deficit payments (Contributions entered by user should be 0).
-- =============================================

CREATE PROCEDURE [dbo].[GenerateProjectedMVA_SEPP] (@StartingAssetValue as float, @AdminFees as float, @AmortPeriod as int, @WUExp as float, @RateType as varchar(50) ='GC', @ResultSetNo as int)
AS
BEGIN

SET NOCOUNT ON;
	/*
	--Testing Paramaters 
	declare @StartingAssetValue as float = '108436780'
	declare @AdminFees as float = '0.0035'
	declare @AmortPeriod as int = 5
	declare @WUExp as float = '75000'
	declare @RateType as varchar(5) = 'GC'
	declare @ResultSetNo as int = 7
		
	--exec GenerateProjectedMVA_SEPP @StartingAssetValue, @AdminFees, @AmortPeriod, @WUExp, @ResultSetNo 
	--exec GenerateProjectedMVA_SEPP '11066860.57', '0.003', 5, '75000', 1
	*/
	
	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Project Asset Value (SEPP)'
	declare @ProcessStartDate as datetime = GETDATE()
	declare @RowCnt as float

	--*******************************
	set @ProcessStartDate = GETDATE()
	exec WriteLog @ResultSetNo, 'Message: Project Asset Value (SEPP) - Start', @ProcessStartDate, 0, @RateType
	--*******************************


	--Stop stored procedure if results are finalized
	if (select IsFinalizedBy from ResultSet where ResultSetNo = @ResultSetNo) IS NOT NULL
		begin	
			exec WriteLog @ResultSetNo, 'Warning: ResultSet Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName
		end	
	else
		begin


			--Set starting parameters
			declare @AssumptionSetNo as int = (select AssumptionSetNo from ResultSet where ResultSetNo = @ResultSetNo)
			declare @CashflowSetNo as int = (select CashflowSetNo from ResultSet where ResultSetNo = @ResultSetNo)
			

			declare @MixName as varchar(255) = (select MixName from ResultSet where ResultSetNo = @ResultSetNo)
			declare @ProcName as varchar(255) = 'GenerateProjectedMVA' +  ':' + @MixName  +  ':' + CAST(@ResultSetNo as varchar)
			
			--Check if the Asset History is populated and use that as starting value for assets
			set @StartingAssetValue = (SELECT CASE WHEN @StartingAssetValue = 0 THEN (select (MIN(AccruedLiability) + MIN(NormalCosts) + MIN(ServiceCosts)) * POWER(1 + MIN(DiscountRate), 0.5)
																					  from ALM_R_L_ProjectedLiability liab
																					  inner join ALM_I_L_DiscountRate dr on liab.n = dr.n and liab.t = dr.t and liab.ResultSetNo = dr.ResultSetNo
																					  where liab.t = 0 and liab.ResultSetNo = @ResultSetNo)
												   ELSE ISNULL((select MVA_EOY from ALM_I_A_AssetValueHistory where t = 0 and CashflowSetNo = @CashflowSetNo), @StartingAssetValue) END) 

			declare @RateTypeCF as varchar(25) = (SELECT CASE WHEN (select UseSameCFAllBases from ResultSet where ResultSetNo = @ResultSetNo) = 'Yes'
															  THEN (select MIN(RateType) from ALM_I_L_CashFlow where CashflowSetNo = @CashflowSetNo)
															  ELSE @RateType END)

			if @RateTypeCF <> @RateType 
			begin	
				exec WriteLog @ResultSetNo, 'Warning: Liability Projected using Different CF Basis', @ProcessStartDate, 0, @ProcessName
			end	
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
			/*
				union
			select @AssumptionSetNo, @ProcName, '@RateTypeCF',  @RateTypeCF, GetDate(), ORIGINAL_LOGIN()
			*/
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
			inner join ALM_I_L_CashFlow cf on w.prj_t = cf.t and w.t = 1 
										  and w.CashflowSetNo = cf.CashflowSetNo
										  and w.RateType = cf.RateType
			where w.AssumptionSetNo = @AssumptionSetNo 
			  and w.RateType = @RateTypeCF 
			  and w.CashflowSetNo = @CashflowSetNo

			create nonclustered index idx_ALM_R_A_ProjectedBenefitPayments on ALM_R_A_ProjectedBenefitPayments(n, t, ResultSetNo)

			--*******************************
			set @ProcessStartDate = GETDATE()
			set @RowCnt = (select COUNT(*) from ALM_R_A_ProjectedBenefitPayments where ResultSetNo = @ResultSetNo)
			exec WriteLog @ResultSetNo, 'Message: Projecting Benefit Payments (SEPP)', @ProcessStartDate, @RowCnt, @RateType
			--*******************************

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
			delete from tmp.ALM_R_CF_NormalCost where ResultSetNo = @ResultSetNo and @RateType = @RateType
			delete from tmp.ALM_R_CF_SF_DefPmt where ResultSetNo = @ResultSetNo and RateType = @RateType
	
			drop index idx_ALM_R_CF_NormalCost on tmp.ALM_R_CF_NormalCost
			drop index idx_ALM_R_CF_SF_DefPmt on tmp.ALM_R_CF_SF_DefPmt	

			--Calculate Results
			declare @t as int = 1
	
			While @t <= 30
			Begin
				if @t = 1 
				Begin
					--Market Value of Assets at the Start of Projection
					insert into ALM_R_A_ProjectedMVA(n, t, MVA, ResultSetNo, CreatedDate, CreatedBy)
					select t.n, @t - 1, @StartingAssetValue MVA, @ResultSetNo ResultSetNo, GetDate() CreatedDate, ORIGINAL_LOGIN() CreatedBy
					from Tally t
					where t.n <= 2000

					--Normal Cost (@t = 1)
					insert into tmp.ALM_R_CF_NormalCost(n, t, NormalCost, RateType, ResultSetNo, CreatedDate, CreatedBy)
					select sq.n, @t t, SUM(CF) * POWER((1 + MAX(dr.DiscountRate)),0.5) NormalCost, dr.RateType, @ResultSetNo ResultSetNo, GetDate() CreatedDate, ORIGINAL_LOGIN() CreatedBy
					from (
						select dr.n, dr.t, cf.NormalCost * POWER((1 + dr.DiscountRate), -cf.t) CF, DiscountRate, @RateType RateType
						from ALM_I_L_DiscountRate dr
						inner join ALM_I_L_CashFlow cf on 1 = 1 
													  and cf.CashflowSetNo = @CashflowSetNo
													  and cf.RateType = @RateTypeCF
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
						select dr.n, dr.t, cf.NormalCost * POWER((1 + dr.DiscountRate), -cf.t) cf, DiscountRate,  @RateType RateType, dr.ResultSetNo
						from ALM_I_L_DiscountRate dr
						inner join ALM_I_L_CashFlow cf on 1 = 1 and cf.CashflowSetNo = @CashflowSetNo
																and cf.RateType = @RateTypeCF
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
					inner join tmp.ALM_R_CF_SF_DefPmt dp on dp.n = nc.n and nc.t = dp.t + 1 and nc.ResultSetNo = dp.ResultSetNo and nc.RateType = dp.RateType
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

			--*******************************
			set @ProcessStartDate = GETDATE()
			set @RowCnt = (select COUNT(*) from tmp.ALM_R_CF_NormalCost where ResultSetNo = @ResultSetNo and RateType = @RateType)
			exec WriteLog @ResultSetNo, 'Message: Projecting Normal Cost (SEPP)', @ProcessStartDate, @RowCnt, @RateType
			--*******************************
			set @ProcessStartDate = GETDATE()
			set @RowCnt = (select COUNT(*) from ALM_R_A_ProjectedContributions where ResultSetNo = @ResultSetNo)
			exec WriteLog @ResultSetNo, 'Message: Projecting Contributions (SEPP)', @ProcessStartDate, @RowCnt, @RateType
			--*******************************
			set @ProcessStartDate = GETDATE()
			set @RowCnt = (select COUNT(*) from tmp.ALM_R_CF_SF_DefPmt where ResultSetNo = @ResultSetNo and RateType = @RateType)
			exec WriteLog @ResultSetNo, 'Message: Projecting Shortfall & Deficit Payments (SEPP)', @ProcessStartDate, @RowCnt, @RateType
			--*******************************
	
			create nonclustered index idx_ALM_R_CF_NormalCost on tmp.ALM_R_CF_NormalCost(n, t, RateType, ResultSetNo)
			create nonclustered index idx_ALM_R_CF_SF_DefPmt on tmp.ALM_R_CF_SF_DefPmt(n, t, RateType, ResultSetNo)		
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
			
			
			--*******************************
			set @ProcessStartDate = GETDATE()
			exec WriteLog @ResultSetNo, 'Message: Project Asset Value (SEPP) - End', @ProcessStartDate, 0, @RateType
			--*******************************

			--Write to Log file
			set @RowCnt = (select COUNT(*) from ALM_R_A_ProjectedMVA where ResultSetNo = @ResultSetNo)
			exec WriteLog @ResultSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @RateType

			--Update the Projection Date
			EXEC ProjectResultSet @ResultSetNo
	end
	
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedMVA_Smoothed]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:          <Gerrit Marais>
-- Create date:		<2019/11/06>
-- Description:     <Stored procedure for creating projected Smoothed Market Value of Assets>

-- Updated by:		<Gerrit Marais>
-- Updated date:	<2020/01/30>
-- Updated reason:	<Updated the stored procedure to allow for multiple Cashflow Sets>
--					<Updated the stored procedure to allow for dynamic number of iterations - 2020/01/30>
--				    <Added logging logic - 2020/02/11>
--				    <Added logic to stop execution if ResultSet is Finalized - 2020/02/25>
-- =============================================

CREATE PROCEDURE [dbo].[GenerateProjectedMVA_Smoothed] (@ResultSetNo as int, @Lag as int)
AS
BEGIN

SET NOCOUNT ON;
	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Project Asset Value (Smoothed)'
	declare @ProcessStartDate as datetime = GETDATE()

	--Stop stored procedure if results are finalized
	if (select IsFinalizedBy from ResultSet where ResultSetNo = @ResultSetNo) IS NOT NULL
		begin	
			exec WriteLog @ResultSetNo, 'Warning: ResultSet Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName
		end	
	else
		begin

			/*
			--Testing Paramaters 
			declare @ResultSetNo as int = 13
			declare @Lag as int = 3

			exec GenerateProjectedMVA_Smoothed @ResultSetNo, @Lag
			exec GenerateProjectedMVA_Smoothed 7, 3
			*/
		
			--Calculate the Median of Expected Returns for the Asset Mix - to use as the expected Value
			if OBJECT_ID('tempdb..#ExpectedReturns') IS NOT NULL
			drop table #ExpectedReturns

			select distinct t, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY ProjectedReturns) OVER (Partition by t) ExpectedReturn
			into #ExpectedReturns
			from AlternativeMixes am
			where am.ResultSetNo = @ResultSetNo

			--Smoothing Parameters - tell the procedure what weight to assign to the cashflow at each lag
			if OBJECT_ID('tempdb..#LagTable') IS NOT NULL
			drop table #LagTable

			select 0 Lag, 0.8 Lagweight
			into #LagTable
			union
			select 1 Lag, 0.6 Lagweight
			union
			select 2 Lag, 0.4 Lagweight
			union
			select 3 Lag, 0.2 Lagweight

			--Append the calculated MVA table with the known history required for the smoothing calculation
			if OBJECT_ID('tempdb..#ALM_R_A_ProjectedMVA_Smooth') IS NOT NULL
			drop table #ALM_R_A_ProjectedMVA_Smooth

			select n, t, MVA_EOY MVA, @ResultSetNo ResultSetNo, avh.CashflowSetNo
			into #ALM_R_A_ProjectedMVA_Smooth
			from ALM_I_A_AssetValueHistory avh
			inner join ResultSet r on r.CashflowSetNo = avh.CashflowSetNo and r.ResultSetNo = @ResultSetNo
			inner join Tally t on 1 = 1 and t.n <= (select max(n) from AlternativeMixes where ResultSetNo = @ResultSetNo)
				union 
			select n, t, MVA, mva.ResultSetNo, r.CashflowSetNo
			from ALM_R_A_ProjectedMVA mva
			inner join ResultSet r on r.ResultSetNo = mva.ResultSetNo
			where mva.ResultSetNo = @ResultSetNo and t > 0

			--Pre-work for the Asset Smoothing Calculation
			if OBJECT_ID('tempdb..#SmoothMVA') IS NOT NULL
			drop table #SmoothMVA

			;with base_cte 
			as (
				select mva.n, mva.t, 
					mva_p.MVA PreviousMVA, 
					mva.MVA, 
					am.ProjectedReturns ActualReturn, 
					sq.ExpectedReturn,
					CASE WHEN mva.t < 1 THEN ActualIncome
						 ELSE (mva_p.MVA * (am.ProjectedReturns) + ((cf.ExpectedCashFlow) * POWER((1 + am.ProjectedReturns), 0.5) - (cf.ExpectedCashFlow))) END [ActualIncome],
					CASE WHEN mva.t < 1 THEN ExpectedIncome
						 ELSE (mva_p.MVA + 0.5 * cf.ExpectedCashflow) * sq.ExpectedReturn END [ExpectedIncome],
					CASE WHEN mva.t < 1 THEN ExcessGains
						 ELSE (mva_p.MVA * (am.ProjectedReturns) + ((cf.ExpectedCashFlow) * POWER((1 + am.ProjectedReturns), 0.5) - (cf.ExpectedCashFlow))) - ((mva_p.MVA + 0.5 * cf.ExpectedCashflow) * sq.ExpectedReturn) END [ExcessGains]
				from #ALM_R_A_ProjectedMVA_Smooth mva
				left join #ALM_R_A_ProjectedMVA_Smooth mva_p on mva.n = mva_p.n and mva.t = mva_p.t + 1
														  and mva.ResultSetNo = mva_p.ResultSetNo
				left join ALM_I_A_AssetValueHistory mva_s on mva_s.t = mva.t and mva_s.CashflowSetNo = mva_p.CashflowSetNo
				left join ALM_R_A_ProjectedCashFlow cf on mva.n = cf.n and mva.t = cf.t
														  and mva.ResultSetNo = cf.ResultSetNo
				left join AlternativeMixes am on mva.n = am.n and mva.t = am.t
														  and mva.ResultSetNo = am.ResultSetNo
				left join #ExpectedReturns sq on sq.t = mva.t
			)
			select b.n, b.t, b.ExcessGains, SUM(bp.ExcessGains * lt.Lagweight) DefferredGains,
				MAX(b.MVA) - SUM(bp.ExcessGains * lt.Lagweight) SmoothedMVA, 
				@ResultSetNo ResultSetNo
			into #SmoothMVA
			from base_cte b
			left join base_cte bp on bp.n = b.n and bp.t >= b.t - @Lag and bp.t <= b.t
			left join #LagTable lt on lt.Lag = (b.t - bp.t)
			group by b.n, b.t, b.ExcessGains

			update mva
			set Smooth_MVA = SmoothedMVA
			from ALM_R_A_ProjectedMVA mva
			inner join #SmoothMVA smva on smva.n = mva.n 
									  and smva.t = mva.t 
									  and smva.ResultSetNo = mva.ResultSetNo
	
			--Write to Log file
			declare @RowCnt as float = (select COUNT(*) from ALM_R_A_ProjectedMVA where ResultSetNo = @ResultSetNo and Smooth_MVA is not NULL)
			exec WriteLog @ResultSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @Lag
		
		end

END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedNCFSChange]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Justin Saw>
-- Create date: <2019/1/24>
-- Description:	<Stored procedure for generating Normal Cost and Future Service Cost Change>

-- Updated date: <2019/02/11>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <Added logging logic - 2020/02/11>
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

	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Normal Cost / Future Service Cost Change'
	declare @ProcessStartDate as datetime = GETDATE()

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
					   select n , ' + @cur + ',( 1 + si.Salary_Increase) * ( 1 + ' + CAST(@ActiveDecline AS VARCHAR) +') -1 ,' + CAST(@AssumptionSetNo as varchar) + ', GetDate(), ORIGINAL_LOGIN()
		               from ALM_Salary_Increase si
		               where si.AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar) + ' and si.t = ' + @cur + '
		               order by si.n'
		end
		
		execute sp_executesql @sql
	
		--roll to the next value
		set @n = @n + 1
	End

	CREATE NONCLUSTERED INDEX idx_ALM_NC_FS_Change ON ALM_I_NC_FS_Change(n,t,AssumptionSetNo)
	
	--Update the table for the NC_FS projection so we do not have to call the function for every line calculated
	delete from tmp.FV_Schedule_NC_FS
	where AssumptionSetNo = @AssumptionSetNo

	drop index idx_FV_Schedule_NC_FS on tmp.FV_Schedule_NC_FS

	insert into tmp.FV_Schedule_NC_FS(n, t, AssumptionSetNo, FV_Schedule_NC_FS, CreatedDate, CreatedBy)
	select dr.n, dr.t, dr.AssumptionSetNo, ISNULL(dbo.FV_Schedule(dr.t, dr.n, dr.AssumptionSetNo),1) FV_Schedule_NC_FS, GetDate() CreatedDate, ORIGINAL_LOGIN() CreatedBy
	from ALM_I_NC_FS_Change dr
	where dr.AssumptionSetNo = @AssumptionSetNo

	create nonclustered index idx_FV_Schedule_NC_FS on tmp.FV_Schedule_NC_FS(n, t, AssumptionSetNo)

	--Write to Log file
	declare @RowCnt as float = (select COUNT(*) from ALM_I_NC_FS_Change where AssumptionSetNo = @AssumptionSetNo)
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @ActiveDecline
	/*
	--User Feedback
	select distinct 'Done' [Status], GETDATE() [StatusDate], 'Next Step - Run Liability Pre-Work (GenerateProjectedLiability_Initial) it will take ~30 min' [Next Steps]
	*/
	/*
	exec GenerateProjectedNCFSChange @ActiveDecline @AssumptionSetNo
	exec GenerateProjectedNCFSChange '-0.02', 1
	*/
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedNFIReturn]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/01/04>
-- Description:	<Stored procedure for creating projected future Non-Fixed Income Returns>

-- Updated date:	<2019/05/06>
-- Updated by:		<Gerrit Marais>
-- Updated reason:	<Add the ability to calculate the cumulative returns and cumulative annualized returns> - <2019/05/06>
--					<Add the ability to write the output into a central asset class table> - <2019/05/06>
--					<Added logging logic - 2020/02/11>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedNFIReturn] (@ST_Weight as varchar(1000), @LT_Weight as varchar(1000), @mu_rp as varchar(1000), @sd_rp as varchar(1000), @prob_sr as varchar(1000), @CorrClass as varchar(255), @AssetClass as varchar(255), @AssumptionSetNo as int, @CalcType as varchar(255))
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

	declare @AssetClass as varchar(255) = 'CdnEq'
	declare @AssumptionSetNo as int = 2

	declare @CalcType as varchar(255) = 'IN'
	*/

	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Non-Fixed Income Assets'
	declare @ProcessStartDate as datetime = GETDATE()

		--Stop stored procedure if results are finalized
	if (select IsFinalizedBy from AssetClass where AssumptionSetNo = @AssumptionSetNo and AssetClass = @AssetClass) IS NOT NULL
		begin	
			exec WriteLog @AssumptionSetNo, 'Warning: Asset Class Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName
		end	
	else
	begin
	
	declare @ProcName as varchar(255) = 'GenerateProjectedNFIReturn' + ':' + @AssetClass

	
	--Delete from table (if exists)
	delete from AssetClassReturn where AssumptionSetNo = @AssumptionSetNo and AssetClass = @AssetClass
	delete from AssetClass where AssumptionSetNo = @AssumptionSetNo and AssetClass = @AssetClass

	--=======================
	--Reindex the Keys in the database
	declare @sql as nvarchar(max)	
	
	--AssetClassReturn
	declare @DBTable as varchar(MAX) = 'AssetClassReturn'
	declare @DBTable_new_reseed_value as int = (select MAX(AssetClassReturnKey) from AssetClassReturn)

	set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
	execute sp_executesql @sql

	--AssetClass
	set @DBTable = 'AssetClass'
	set @DBTable_new_reseed_value = (select MAX(AssetClassKey) from AssetClass)

	set @sql = 'DBCC CHECKIDENT (' + @DBTable + ', RESEED, ' +  CAST(@DBTable_new_reseed_value as varchar) + ')'  
	execute sp_executesql @sql
	--=======================

	--Trail for Parameter
	insert into trl.ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy, TrailCreatedDate, TrailCreatedBy, SourceKey)
	select AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy, GETDATE(), ORIGINAL_LOGIN(), ParameterHistoryKey
	from ParameterHistory
	where AssumptionSetNo = @AssumptionSetNo and ParameterProc = @ProcName
	
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
		union
	select @AssumptionSetNo, @ProcName, '@CorrClass', @CorrClass, GetDate(), ORIGINAL_LOGIN()
		union
	select @AssumptionSetNo, @ProcName, '@CalcType', @CalcType, GetDate(), ORIGINAL_LOGIN()
	
	drop index idx_AssetClassReturn on AssetClassReturn

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
	where ReturnType = @CorrClass and AssumptionSetNo = @AssumptionSetNo
	order by t,n
	

	--Stressed Regime
	if OBJECT_ID('tempdb..#NFI_Stressed') IS NOT NULL
    drop table #NFI_Stressed

	select st.n, st.t, CASE WHEN StressReg < @prob_sr then td.TriangleDistValue ELSE 0 END Stressed
	into #NFI_Stressed
	from vw_FI_R_StressReg_Unpvt st
	inner join NFI_I_TriangleDistribution td on td.n = st.n and td.t = st.t and st.AssumptionSetNo = td.AssumptionSetNo
	where st.AssumptionSetNo = @AssumptionSetNo
		and td.ReturnType = @CorrClass
	order by st.t, st.n

	--Combined Regime
	insert into AssetClassReturn(n, t, Normal, Stressed, Combined, AssumptionSetNo, AssetClass, AssetGroup, Cumulative, CumulativeAnnualized, CreatedDate, CreatedBy)
	select nor.n, nor.t, nor.Normal, st.Stressed, Combined = CASE WHEN st.Stressed <> 0 THEN st.Stressed ELSE nor.Normal END, nor.AssumptionSetNo, 
	 @AssetClass AssetClass, 'Non-Fixed Income' AssetGroup, NULL Cumulative, NULL CumulativeAnnualized,
	 CreatedDate, CreatedBy
	from #NFI_Normal nor
	inner join #NFI_Stressed st on nor.n = st.n and nor.t = st.t
	where nor.AssumptionSetNo = CAST(@AssumptionSetNo as varchar)
	order by nor.t, nor.n
	
	create nonclustered index idx_AssetClassReturn on AssetClassReturn(n, t, AssumptionSetNo, AssetClass, AssetGroup)
	
	--Calculate the cumulative returns as well as cumulative annualized returns
	update acr
	set Cumulative = ISNULL(dbo.FV_Schedule_AssetClass(t, n, @AssetClass, @AssumptionSetNo),1),
		CumulativeAnnualized = POWER((ISNULL(dbo.FV_Schedule_AssetClass(t, n, @AssetClass, @AssumptionSetNo),1)), (1 / (t * 1.0))) - 1
	from AssetClassReturn acr
	where AssetClass = @AssetClass and AssumptionSetNo = @AssumptionSetNo and Cumulative is NULL

	/*
	update acr
	set Cumulative = ISNULL(fv.CumulativeReturn, 1),
		CumulativeAnnualized = ISNULL(fv.CumulativeAnnualized, 1)
	from AssetClassReturn acr
	inner join vw_AC_FVSchedule fv on fv.n = acr.n 
								  and fv.t = acr.t 
								  and fv.AssumptionSetNo = acr.AssumptionSetNo
								  and fv.AssetClass = acr.AssetClass
	*/

	--Write to Log file
	declare @RowCnt as float = (select COUNT(*) from AssetClassReturn where AssumptionSetNo = @AssumptionSetNo and AssetClass = @AssetClass)
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @AssetClass

	exec ProjectAssetClass @AssumptionSetNo, @AssetClass

	--User Feedback
	
	--exec GenerateProjectedNFIReturn @ST_Weight, @LT_Weight, @mu_rp, @sd_rp, @prob_sr, @CorrClass, @AssetClass, @AssumptionSetNo, @CalcType
	--exec GenerateProjectedNFIReturn '0.65', '0.35', '0.073', '0.174', '0.075', 'CdnLVEq', 'Canadian Low Volatility Equity',  1, 'IN'

	END
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedRealReturn]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/01/02>
-- Description:	<Stored procedure for creating projecting future real return rate numbers>

-- Updated date: <2019/02/11>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <Added logging logic - 2020/02/11>
--				   <Added logic to stop execution if AssumptionSet is Finalized - 2020/02/25>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedRealReturn] (@RR_ST_tmin1 as varchar(1000), @w as varchar(1000), @LT_RR_ST as varchar(1000),@sd_e as varchar(1000), @mu_e as varchar(1000),  @AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;
    
	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Project Real Return'
	declare @ProcessStartDate as datetime = GETDATE()

	--Stop stored procedure if results are finalized
	if (select IsFinalizedBy from AssumptionSet where AssumptionSetNo = @AssumptionSetNo) IS NOT NULL
		begin	
			exec WriteLog @AssumptionSetNo, 'Warning: AssumptionSet Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName
		end	
	else
	begin

	--Using ProVal's formula:    RR(t) = [ RR ST (t-1) x w ] + [ LT RR ST x (1-w) ] + e
	--NORMINV(p, mu, sigma) = mu + sigma*NORMSINV(p)
	--Parameters
	/*
	declare @RR_ST_tmin1 as varchar(1000) = '0.0045'
	declare @w as varchar(1000) = '0.90'
	declare @LT_RR_ST as varchar(1000) = '0.01'
	declare @sd_e as varchar(1000) = '0.006'
	declare @mu_e as varchar(1000) = '0'

	--exec GenerateProjectedRealReturn @RR_ST_tmin1, @w, @LT_RR_ST, @sd_e, @mu_e, @AssumptionSetNo
	--exec GenerateProjectedRealReturn '0.0082', '0.9', '0.0122', '0.002', '0.00', 1
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

	--Write to Log file
	declare @RowCnt as float = (select COUNT(*) from FI_I_RealReturn where AssumptionSetNo = @AssumptionSetNo)
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt
	
	end
	
END

GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedSalaryIncreases]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/04/10>
-- Description:	<Stored procedure for creating projecting future Salary Increases>

-- Updated date: <2019/02/11>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <Added logging logic - 2020/02/11>
--				   <Added logic to stop execution if AssumptionSet is Finalized - 2020/02/25>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedSalaryIncreases] (@AssumptionSetNo as int, @SI_Above_Infl as float = 0.00)
AS
BEGIN

	SET NOCOUNT ON;
    
	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Project Salary Increases'
	declare @ProcessStartDate as datetime = GETDATE()

	--Using ProVal's formula to project salary increases:    SalaryIncrease(t) = MAX( Inflation(t), 0)
	--Pre-requisites include running [dbo].[GenerateProjectedInflation] & [dbo].[GenerateProjectedShortTermReturn] & [dbo].[GenerateProjectedTermPremium]
	
	--exec GenerateProjectedSalaryIncreases @AssumptionSetNo, @SI_Above_Infl
	--exec GenerateProjectedSalaryIncreases 1, 0.03
	
	--Delete from table (if exists)
	delete from ALM_Salary_Increase	where AssumptionSetNo = @AssumptionSetNo
	
	--Store the parameter values for future reference
	declare @ProcName as varchar(255) = 'GenerateProjectedSalaryIncreases'

	--Parameter History
	delete from ParameterHistory where AssumptionSetNo = @AssumptionSetNo and ParameterProc = @ProcName

	--Store the parameter values for future reference
	insert into ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
	select @AssumptionSetNo, @ProcName, '@SI_Above_Infl', @SI_Above_Infl, GetDate(), ORIGINAL_LOGIN()
	
	--Create values
	insert into ALM_Salary_Increase (n, t, Inflation, Salary_Increase, AssumptionSetNo, CreatedDate, CreatedBy)
	select n, t, Inflation, case when Inflation + @SI_Above_Infl <= 0 then 0 else Inflation + @SI_Above_Infl END Salary_Increase,
		AssumptionSetNo, CreatedDate, CreatedBy
	from FI_I_Infl
	where AssumptionSetNo = @AssumptionSetNo
	order by n, t

	--Write to Log file
	declare @RowCnt as float = (select COUNT(*) from ALM_Salary_Increase where AssumptionSetNo = @AssumptionSetNo)
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt
	
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedShortTermReturn]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/01/03>
-- Description:	<Stored procedure for creating projecting future short term returns>

-- Updated date: <2019/02/11>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <Added logging logic - 2020/02/11>
--				   <Added logic to stop execution if AssumptionSet is Finalized - 2020/02/25>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedShortTermReturn] (@AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;
    
	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Project Short-Term Premium'
	declare @ProcessStartDate as datetime = GETDATE()

	--Stop stored procedure if results are finalized
	if (select IsFinalizedBy from AssumptionSet where AssumptionSetNo = @AssumptionSetNo) IS NOT NULL
		begin	
			exec WriteLog @AssumptionSetNo, 'Warning: AssumptionSet Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName
		end	
	else
	begin
	--Using ProVal's formula to project Inflation:    ST(t) = Infl(t) + RR(t)
	--Pre-requisites include running [dbo].[GenerateProjectedInflation] & [dbo].[GenerateProjectedInflation]
	--exec GenerateProjectedShortTermReturn @AssumptionSetNo
	--exec GenerateProjectedShortTermReturn 1
	
	
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

	--Write to Log file
	declare @RowCnt as float = (select COUNT(*) from FI_I_ShortTermReturn where AssumptionSetNo = @AssumptionSetNo)
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt
	
	end
	
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedTermPremium]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/01/02>
-- Description:	<Stored procedure for creating projecting future term premium (TP) numbers>

-- Updated date: <2019/02/11>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <Added logging logic - 2020/02/11>
--				   <Added logic to stop execution if AssumptionSet is Finalized - 2020/02/25>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateProjectedTermPremium] (@TP_tmin1 as varchar(1000), @w as varchar(1000), @LT_TP as varchar(1000),@sd_e as varchar(1000), @mu_e as varchar(1000), @AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;
    
	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Project Term Premium'
	declare @ProcessStartDate as datetime = GETDATE()

	--Stop stored procedure if results are finalized
	if (select IsFinalizedBy from AssumptionSet where AssumptionSetNo = @AssumptionSetNo) IS NOT NULL
		begin	
			exec WriteLog @AssumptionSetNo, 'Warning: AssumptionSet Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName
		end	
	else
	begin

	--Using ProVal's formula for projecting the Term Premium:  TP(t) = [ TP (t-1) x w ] +  LT TP x (1-w) ] + e
	--NORMINV(p, mu, sigma) = mu + sigma*NORMSINV(p)
	--Parameters
	/*
	declare @TP_tmin1 as varchar(1000) = '0.01'
	declare @w as varchar(1000) = '0.90'
	declare @LT_TP as varchar(1000) = '0.013'
	declare @sd_e as varchar(1000) = '0.0035'
	declare @mu_e as varchar(1000) = '0'

	--exec GenerateProjectedTermPremium @TP_tmin1, @w, @LT_TP, @sd_e, @mu_e, @AssumptionSetNo
	--exec GenerateProjectedTermPremium '0.0046', '0.9', '0.0034', '0.002', '0.00', 1
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

	--Write to Log file
	declare @RowCnt as float = (select COUNT(*) from FI_I_TermPremium where AssumptionSetNo = @AssumptionSetNo)
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt

	end
	
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateProjectedYields]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GenerateProjectedYields] (@BBList as varchar(1000), @FIAsset as varchar(1000), @AssumptionSetNo as int)												
AS												
BEGIN												
												
	SET NOCOUNT ON;											
    												
	--Logging Parameters											
	declare @ProcessName as varchar(MAX) = 'Project Yields'											
	declare @ProcessStartDate as datetime = GETDATE()	
	
	--Stop stored procedure if results are finalized											
	if (select IsFinalizedBy from AssumptionSet where AssumptionSetNo = @AssumptionSetNo) IS NOT NULL											
		begin										
			exec WriteLog @AssumptionSetNo, 'Warning: AssumptionSet Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName									
		end										
	else											
	begin
	
		--Parameters											
		/*
		declare @BBList as varchar(MAX) = 'Infl,FedCredSpread,TermRPrem_7yrs'
		
		declare @AssumptionSetNo as int = 3
		declare @FIAsset as varchar(MAX) = 'Test'
	
		select * from Utils.dbo.sample_Split(@BBList, ',')
		select * from Utils.dbo.sample_Split(@BBWeightList, ',')
		*/

		declare @BBWeightList as varchar(MAX) = '1,1,0.3'

		--Clean up the history
		delete from FI_I_BuildingBlocksTest where AssumptionSetNo = @AssumptionSetNo and FIType = @FIAsset
		
		--insert statement
		select n, t, @FIAsset, SUM(sq2.Data * BBValue), AssumptionSetNo, GETDATE(), ORIGINAL_LOGIN()
		from FI_I_BuildingBlocks bb
		inner join (select * from Utils.dbo.sample_Split(@BBList, ',')) sq1 on sq1.Data = bb.BBType
		inner join (select * from Utils.dbo.sample_Split(@BBWeightList, ',')) sq2 on sq1.Id = sq2.Id
		where AssumptionSetNo = @AssumptionSetNo
		group by n, t, AssumptionSetNo
		order by n, t

		
	end											
			
		
	--Write to Log file											
	declare @RowCnt as float = (select COUNT(*) from FI_I_BuildingBlocksTest where AssumptionSetNo = @AssumptionSetNo and FIType = @FIAsset)											
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @FIAsset											
												
									
END
GO
/****** Object:  StoredProcedure [dbo].[GenerateRandomNumbers]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2018/12/21>
-- Description:	<Stored procedure for generating a table of random numbers>

-- Updated date: <2020/02/05>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <Updated the stored procedure to allow for parameter input on iteration count - 2020/01/28>
--				   <Added logging logic - 2020/02/05>
--				   <Added logic to write to trail table - 2020/02/11>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateRandomNumbers] (@AssumptionSetNo as int, @Indicator as varchar(MAX), @itnCnt as int = 2000)
AS
BEGIN

	SET NOCOUNT ON;
	
	--Inflation
	--Real Return
	--Term Premium
	--Credit Premium
	--Stressed Regime
	--NFI Non-Correlated,
	--NFI Correlated,
	--NFI Correlared (Updated)

	/*
	declare @AssumptionSetNo as int = 3
	declare @Indicator as varchar(max) =  'Inflation'
	*/

	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Generate Economic Assumption Random Numbers'
	declare @ProcessStartDate as datetime = GETDATE()

	declare @sql as nvarchar(max)
	declare @table as varchar(max) = (select case when @Indicator = 'Inflation' then 'FI_R_Infl'
												  when @Indicator = 'Real Return' then 'FI_R_RealReturn'
												  when @Indicator = 'Term Premium' then 'FI_R_TermPremium'
												  when @Indicator = 'Credit Premium' then 'FI_R_CredPrem'
												  when @Indicator = 'Stressed Regime' then 'FI_R_StressReg'
												  end)
	
	--Write to trail table
	set @sql = 'insert into trl.FI_R_All(n, AssumptionSetNo, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
															[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
															[21], [22], [23], [24], [25], [26], [27], [28], [29], [30], SourceTable, CreatedDate, CreatedBy)
				select n, AssumptionSetNo, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
															[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
															[21], [22], [23], [24], [25], [26], [27], [28], [29], [30], ''' + @table + ''' SourceTable, CreatedDate, CreatedBy
				from ' + @table + ' where AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar)
			
	execute sp_executesql @sql

	--Clear table from previous values
	set @sql = 'delete from ' + @table + ' where AssumptionSetNo = ' + CAST(@AssumptionSetNo as varchar)

	execute sp_executesql @sql

	set @sql = 'drop index idx_' + @table + ' on ' + @table

	execute sp_executesql @sql

	--Upload new values to table
	set @sql = 'insert into ' + @table + ' 
				select n, ' + CAST(@AssumptionSetNo as varchar) + ' AssumptionSetNo,
					RAND(CHECKSUM( NEWID())) [1], RAND(CHECKSUM( NEWID())) [2], RAND(CHECKSUM( NEWID())) [3], RAND(CHECKSUM( NEWID())) [4], RAND(CHECKSUM( NEWID())) [5], 
					RAND(CHECKSUM( NEWID())) [6], RAND(CHECKSUM( NEWID())) [7], RAND(CHECKSUM( NEWID())) [8], RAND(CHECKSUM( NEWID())) [9], RAND(CHECKSUM( NEWID())) [10], 
					RAND(CHECKSUM( NEWID())) [11], RAND(CHECKSUM( NEWID())) [12], RAND(CHECKSUM( NEWID())) [13], RAND(CHECKSUM( NEWID())) [14], RAND(CHECKSUM( NEWID())) [15], 
					RAND(CHECKSUM( NEWID())) [16], RAND(CHECKSUM( NEWID())) [17], RAND(CHECKSUM( NEWID())) [18], RAND(CHECKSUM( NEWID())) [19], RAND(CHECKSUM( NEWID())) [20], 
					RAND(CHECKSUM( NEWID())) [21], RAND(CHECKSUM( NEWID())) [22], RAND(CHECKSUM( NEWID())) [23], RAND(CHECKSUM( NEWID())) [24], RAND(CHECKSUM( NEWID())) [25], 
					RAND(CHECKSUM( NEWID())) [26], RAND(CHECKSUM( NEWID())) [27], RAND(CHECKSUM( NEWID())) [28], RAND(CHECKSUM( NEWID())) [29], RAND(CHECKSUM( NEWID())) [30],
					GetDate() CreatedDate, ORIGINAL_LOGIN() CreatedBy
				from Tally
				where n <= ' + CAST(@itncnt as varchar) 

	execute sp_executesql @sql

	set @sql = 'create nonclustered index idx_' + @table + ' on ' + @table + '(n, AssumptionSetNo)'

	execute sp_executesql @sql

	declare @RowCnt as float = @itnCnt
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @table
		
	/*
	-- Ensure that the assumptionset that these numbers need to be stored in is defined

	--1. Inflation ([dbo].[FI_R_Infl])
	--2. Real Return ([dbo].[FI_R_RealReturn])
	--3. Term Premium ([dbo].[FI_I_TermPremium])
	--4. Credit Premium ([dbo].[FI_R_CredPrem])
	--5. Stressed Regime ([dbo].[FI_R_StressReg])

	--6. Non-fixed Income Non-correlated Random Numbers for each asset class ([dbo].[NFI_R_NCorr])
	--7. Upload the Correlated Random numbers after Cholesky Decomposition ([dbo].[NFI_R_Corr])
	--8. Run Stored Procedure to fix the Correlated Random numbers ([dbo].[Update_NFI_RCorr]) ([dbo].[NFI_R_Corr_Final])
	*/

END
GO
/****** Object:  StoredProcedure [dbo].[GenerateRandomNumbersFI]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:          <Kris Kim Sing>
-- Create date:		<2020/08/20>
-- Description:     <Stored procedure for random numbers for Fixed Income Building Blocks - Building Block Method>

-- Updated date:	<YYYY/MM/DD>
-- Updated by:		<>
-- Updated reason:	<> - <YYYY/MM/DD>
--					
-- =============================================
CREATE PROCEDURE [dbo].[GenerateRandomNumbersFI] (@AssumptionSetNo as int, @itncnt as int = 2000)
AS
BEGIN
	
	SET NOCOUNT ON;
	/*
	declare @AssumptionSetNo as int = 3
	declare @itncnt as int = 200
	*/
	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Generate Asset Class Assumption Random Numbers (Fixed Income)'
	declare @ProcessStartDate as datetime = GETDATE()

	insert into trl.FI_R_NCorr(AssumptionSetNo, n, t, Infl, FedCredSpread, TermRPrem_7yrs, TermRPrem_15yrs, Prov_A_RatedDebtCredSpread_7yr, Prov_A_RatedDebtCredSpread_15yr, BBBCredSpread, HighYieldSpread, PrivDebt_illiquidityPrem, Mort_IG_Spread, CreatedDate, CreatedBy, TrailCreatedDate, TrailCreatedBy, SourceKey)
	select  AssumptionSetNo, n, t, Infl, FedCredSpread, TermRPrem_7yrs, TermRPrem_15yrs, Prov_A_RatedDebtCredSpread_7yr, Prov_A_RatedDebtCredSpread_15yr, BBBCredSpread, HighYieldSpread, PrivDebt_illiquidityPrem, Mort_IG_Spread, CreatedDate, CreatedBy,GETDATE(),ORIGINAL_LOGIN(),RKey
	from FI_R_NCorr
	where AssumptionSetNo = @AssumptionSetNo
	
	delete from FI_R_NCorr where AssumptionSetNo = @AssumptionSetNo
	
	declare @sql as nvarchar(max)
	
	--Upload new values to table
	set @sql = 'insert into FI_R_NCorr  
				select ' + CAST(@AssumptionSetNo as varchar) + ' AssumptionSetNo, t1.n, t2.n t,
					Infl = RAND(CHECKSUM( NEWID())), 
					FedCredSpread = RAND(CHECKSUM( NEWID())), 
					TermRPrem_7yrs = RAND(CHECKSUM( NEWID())), 
					TermRPrem_15yrs = RAND(CHECKSUM( NEWID())), 
					Prov_A_RatedDebtCredSpread_7yr = RAND(CHECKSUM( NEWID())), 
					Prov_A_RatedDebtCredSpread_15yr = RAND(CHECKSUM( NEWID())), 
					BBBCredSpread = RAND(CHECKSUM( NEWID())), 
					HighYieldSpread = RAND(CHECKSUM( NEWID())),
					PrivDebt_illiquidityPrem = RAND(CHECKSUM( NEWID())), 
					Mort_IG_Spread = RAND(CHECKSUM( NEWID())),
					GetDate() CreatedDate, ORIGINAL_LOGIN() CreatedBy
				from dbo.Tally t1
				inner join dbo.Tally t2 on 1 = 1 
				where t1.n <= ' + CAST(@itncnt as varchar) + ' and t2.n <= 30'
	
	print @sql
	execute sp_executesql @sql

	declare @RowCnt as float = (select COUNT(*) from FI_R_NCorr where AssumptionSetNo = @AssumptionSetNo)
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt

	/*
	--6. Fixed Income Non-correlated Random Numbers for each asset class ([dbo].[FI_R_NCorr])
	--7. Upload the Correlated Random numbers after Cholesky Decomposition ([dbo].[FI_R_Corr])
	--8. Run Stored Procedure to fix the Correlated Random numbers ([dbo].[Update_FI_RCorr]) ([dbo].[FI_R_Corr_Final])
	*/

END
GO
/****** Object:  StoredProcedure [dbo].[GenerateRandomNumbersNFI]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/09/24>
-- Description:	<Stored procedure for generating a table of random numbers>

-- Updated date: <2020/02/05>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <Updated the stored procedure to allow for parameter input on iteration count - 2020/01/28>
--				   <Added logging logic - 2020/02/05>
--				   <Added logic to write to trail table - 2020/02/25>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateRandomNumbersNFI] (@AssumptionSetNo as int, @itncnt as int = 2000)
AS
BEGIN
	
	SET NOCOUNT ON;
	
	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Generate Asset Class Assumption Random Numbers'
	declare @ProcessStartDate as datetime = GETDATE()

	insert into trl.NFI_R_NCorr(AssumptionSetNo, n, t, CdnEq, GloEq, EMEq, CdnLVEq, GloLVEq, PE, IE, RE, CreatedDate, CreatedBy, TrailCreatedDate, TrailCreatedBy, SourceKey)
	select  AssumptionSetNo, n, t, CdnEq, GloEq, EMEq, CdnLVEq, GloLVEq, PE, IE, RE, CreatedDate, CreatedBy,GETDATE(),ORIGINAL_LOGIN(),RKey
	from NFI_R_NCorr
	where AssumptionSetNo = @AssumptionSetNo
	
	delete from NFI_R_NCorr where AssumptionSetNo = @AssumptionSetNo
	
	declare @sql as nvarchar(max)
	
	--Upload new values to table
	set @sql = 'insert into NFI_R_NCorr  
				select ' + CAST(@AssumptionSetNo as varchar) + ' AssumptionSetNo, t1.n, t2.n t,
					CdnEq = RAND(CHECKSUM( NEWID())), 
					GloEq = RAND(CHECKSUM( NEWID())), 
					EMEq = RAND(CHECKSUM( NEWID())), 
					CdnLVEq = RAND(CHECKSUM( NEWID())), 
					GloLVEq = RAND(CHECKSUM( NEWID())), 
					PE = RAND(CHECKSUM( NEWID())), 
					IE = RAND(CHECKSUM( NEWID())), 
					RE = RAND(CHECKSUM( NEWID())),
					GetDate() CreatedDate, ORIGINAL_LOGIN() CreatedBy
				from dbo.Tally t1
				inner join dbo.Tally t2 on 1 = 1 
				where t1.n <= ' + CAST(@itncnt as varchar) + ' and t2.n <= 30'

	execute sp_executesql @sql

	declare @RowCnt as float = (select COUNT(*) from NFI_R_NCorr where AssumptionSetNo = @AssumptionSetNo)
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt

	/*
	--6. Non-fixed Income Non-correlated Random Numbers for each asset class ([dbo].[NFI_R_NCorr])
	--7. Upload the Correlated Random numbers after Cholesky Decomposition ([dbo].[NFI_R_Corr])
	--8. Run Stored Procedure to fix the Correlated Random numbers ([dbo].[Update_NFI_RCorr]) ([dbo].[NFI_R_Corr_Final])
	*/

END
GO
/****** Object:  StoredProcedure [dbo].[Move_AssumptionSet]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2020/06/22>
-- Description:	<Stored procedure for moving Assumption Set from one Database to another (Archive/Restore)>

-- Updated date: <2020/06/22>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <>

-- =============================================
CREATE PROCEDURE [dbo].[Move_AssumptionSet] (@FromDB as varchar(max), @ToDB as varchar(max), @FromAssumptionSetNo as int, @ToAssumptionSetNo as int)
AS
BEGIN
	
	/*
	declare @FromAssumptionSetNo as int = 3
	declare @ToAssumptionSetNo as int = 3

	EXEC Move_AssumptionSet 'PBI_ALM_WIP_4', 'PBI_ALM_Archive', @FromAssumptionSetNo, @ToAssumptionSetNo
	EXEC Empty_AssumptionSet @FromAssumptionSetNo, 'YES'
	*/

	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Move AssumptionSet'
	declare @ProcessStartDate as datetime = GETDATE()
		
	declare @RowCnt as float = 1
	exec WriteLog @ToAssumptionSetNo, @ProcessName, @ProcessStartDate, 1, @FromDB

	/*
	declare @FromDB as varchar(max) = 'PBI_ALM_LAB'
	declare @ToDB as varchar(max) = 'PBI_ALM_WIP_4'
	declare @FromAssumptionSetNo as int = 1
	declare @ToAssumptionSetNo as int = 4
	*/

	declare @sql as nvarchar(max)
	declare @SourceTableName as varchar(max) 

	--Clean out the destination DB assumptionSet
	set @sql = 'EXEC ' + @ToDB + '.dbo.Empty_AssumptionSet ' +  CAST(@ToAssumptionSetNo as varchar) + ', ''YES'''

	print @sql
	execute sp_executesql @sql

	set @sql = 'insert into ' + @ToDB + '.dbo.AssumptionSet( AssumptionSetNo, AssumptionSetDescript, CreatedDate, CreatedBy, IsFinalizedDate, IsFinalizedBy)
				select ' + CAST(@ToAssumptionSetNo as varchar) + ' AssumptionSetNo, AssumptionSetDescript + '' (to Archive)'', CreatedDate, CreatedBy, GETDATE(), ''Moved from:' + @FromDB + ':' +  CAST(@FromAssumptionSetNo as varchar) + '''
				from ' + @FromDB + '.dbo.AssumptionSet ass
				where ass.AssumptionSetNo = ' + CAST(@FromAssumptionSetNo as varchar) + '
				order by ass.AssumptionSetNo'

	print @sql
	execute sp_executesql @sql
	--===========================================
	--Random numbers - Economic indictors
	--===========================================
	set @SourceTableName = 'FI_R_Infl'
	set @sql = 'insert into ' + @ToDB + '.dbo.' + @SourceTableName + '(n, AssumptionSetNo, 
					[1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
					[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
					[21], [22], [23], [24], [25], [26], [27], [28], [29], [30],
					CreatedDate, CreatedBy)
				select n, '+ CAST(@ToAssumptionSetNo as varchar) + ', 
					[1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
					[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
					[21], [22], [23], [24], [25], [26], [27], [28], [29], [30],
					CreatedDate, CreatedBy
				from ' + @FromDB + '.dbo.' + @SourceTableName + '
				where AssumptionSetNo = ' + CAST(@FromAssumptionSetNo as varchar) + '
				order by n'

	print @sql
	execute sp_executesql @sql
	--===========================================
	set @SourceTableName = 'FI_R_RealReturn'
	set @sql = 'insert into ' + @ToDB + '.dbo.' + @SourceTableName + '(n, AssumptionSetNo, 
				[1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
				[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
				[21], [22], [23], [24], [25], [26], [27], [28], [29], [30],
				CreatedDate, CreatedBy)
			select n, '+ CAST(@ToAssumptionSetNo as varchar) + ', 
				[1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
				[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
				[21], [22], [23], [24], [25], [26], [27], [28], [29], [30],
				CreatedDate, CreatedBy
			from ' + @FromDB + '.dbo.' + @SourceTableName + '
			where AssumptionSetNo = ' + CAST(@FromAssumptionSetNo as varchar) + '
			order by n'

	print @sql
	execute sp_executesql @sql
	--===========================================
	set @SourceTableName = 'FI_R_TermPremium'
	set @sql = 'insert into ' + @ToDB + '.dbo.' + @SourceTableName + '(n, AssumptionSetNo, 
					[1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
					[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
					[21], [22], [23], [24], [25], [26], [27], [28], [29], [30],
					CreatedDate, CreatedBy)
				select n, '+ CAST(@ToAssumptionSetNo as varchar) + ', 
					[1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
					[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
					[21], [22], [23], [24], [25], [26], [27], [28], [29], [30],
					CreatedDate, CreatedBy
				from ' + @FromDB + '.dbo.' + @SourceTableName + '
				where AssumptionSetNo = ' + CAST(@FromAssumptionSetNo as varchar) + '
				order by n'

	print @sql
	execute sp_executesql @sql
	--===========================================
	set @SourceTableName = 'FI_R_CredPrem'
	set @sql = 'insert into ' + @ToDB + '.dbo.' + @SourceTableName + '(n, AssumptionSetNo, 
					[1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
					[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
					[21], [22], [23], [24], [25], [26], [27], [28], [29], [30],
					CreatedDate, CreatedBy)
				select n, '+ CAST(@ToAssumptionSetNo as varchar) + ', 
					[1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
					[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
					[21], [22], [23], [24], [25], [26], [27], [28], [29], [30],
					CreatedDate, CreatedBy
				from ' + @FromDB + '.dbo.' + @SourceTableName + '
				where AssumptionSetNo = ' + CAST(@FromAssumptionSetNo as varchar) + '
				order by n'

	print @sql
	execute sp_executesql @sql
	--===========================================
	set @SourceTableName = 'FI_R_StressReg'
	set @sql = 'insert into ' + @ToDB + '.dbo.' + @SourceTableName + '(n, AssumptionSetNo, 
					[1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
					[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
					[21], [22], [23], [24], [25], [26], [27], [28], [29], [30],
					CreatedDate, CreatedBy)
				select n, '+ CAST(@ToAssumptionSetNo as varchar) + ', 
					[1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
					[11], [12], [13], [14], [15], [16], [17], [18], [19], [20],
					[21], [22], [23], [24], [25], [26], [27], [28], [29], [30],
					CreatedDate, CreatedBy
				from ' + @FromDB + '.dbo.' + @SourceTableName + '
				where AssumptionSetNo = ' + CAST(@FromAssumptionSetNo as varchar) + '
				order by n'

	print @sql
	execute sp_executesql @sql
	--===========================================
	--Random numbers - Non-fixed Income Asset Classes
	--===========================================
	set @SourceTableName = 'NFI_R_NCorr'
	set @sql = 'insert into ' + @ToDB + '.dbo.' + @SourceTableName + '(AssumptionSetNo, n, t, CdnEq, GloEq, EMEq, CdnLVEq, GloLVEq, PE, IE, RE)
				select ' + CAST(@ToAssumptionSetNo as varchar) + ' AssumptionSetNo, n, t, CdnEq, GloEq, EMEq, CdnLVEq, GloLVEq, PE, IE, RE
				from ' + @FromDB + '.dbo.' + @SourceTableName + '
				where AssumptionSetNo = ' + CAST(@FromAssumptionSetNo as varchar) + '
				order by t, n'

	print @sql
	execute sp_executesql @sql
	--===========================================
	/*
	set @SourceTableName = 'NFI_R_Corr'
	set @sql = 'insert into ' + @ToDB + '.dbo.' + @SourceTableName + '(RKey, AssumptionSetNo, n, t, CdnEq, GloEq, EMEq, CdnLVEq, GloLVEq, PE, IE, RE)
				select RKey,' + CAST(@ToAssumptionSetNo as varchar) + ' AssumptionSetNo, n, t, CdnEq, GloEq, EMEq, CdnLVEq, GloLVEq, PE, IE, RE
				from ' + @FromDB + '.dbo.' + @SourceTableName + '
				where AssumptionSetNo = ' + CAST(@FromAssumptionSetNo as varchar) + '
				order by t, n'

	print @sql
	execute sp_executesql @sql
	*/
	--===========================================
	set @SourceTableName = 'NFI_R_Corr_Final'
	set @sql = 'insert into ' + @ToDB + '.dbo.' + @SourceTableName + '(AssumptionSetNo, n, t, CdnEq, GloEq, EMEq, CdnLVEq, GloLVEq, PE, IE, RE)
				select ' + CAST(@ToAssumptionSetNo as varchar) + ' AssumptionSetNo, n, t, CdnEq, GloEq, EMEq, CdnLVEq, GloLVEq, PE, IE, RE
				from ' + @FromDB + '.dbo.' + @SourceTableName + '
				where AssumptionSetNo = ' + CAST(@FromAssumptionSetNo as varchar) + '
				order by t, n'

	print @sql
	execute sp_executesql @sql
	--===========================================
	--Economic Building Blocks
	--Inflation 
	set @sql = 'insert into ' + @ToDB + '.dbo.FI_I_Infl(n, t, Inflation, AssumptionSetNo, CreatedDate, CreatedBy)
				select n, t, Inflation, ' + CAST(@ToAssumptionSetNo as varchar) + ' AssumptionSetNo, CreatedDate, CreatedBy
				from ' + @FromDB + '.dbo.FI_I_Infl
				where AssumptionSetNo = ' + CAST(@FromAssumptionSetNo as varchar) + '
				order by n, t'

	print @sql
	execute sp_executesql @sql
	--===========================================
	--Real Return
	set @sql = 'insert into ' + @ToDB + '.dbo.FI_I_RealReturn(n, t, RealReturn, AssumptionSetNo, CreatedDate, CreatedBy)
				select n, t, RealReturn, ' + CAST(@ToAssumptionSetNo as varchar) + ' AssumptionSetNo, CreatedDate, CreatedBy
				from ' + @FromDB + '.dbo.FI_I_RealReturn
				where AssumptionSetNo = ' + CAST(@FromAssumptionSetNo as varchar) + '
				order by n, t'

	print @sql
	execute sp_executesql @sql
	--===========================================
	--Short Term Return
	set @sql = 'insert into ' + @ToDB + '.dbo.FI_I_ShortTermReturn(n, t, ST, AssumptionSetNo, CreatedDate, CreatedBy)
				select n, t, ST, ' + CAST(@ToAssumptionSetNo as varchar) + ' AssumptionSetNo, CreatedDate, CreatedBy
				from ' + @FromDB + '.dbo.FI_I_ShortTermReturn
				where AssumptionSetNo = ' + CAST(@FromAssumptionSetNo as varchar) + '
				order by n, t'

	print @sql
	execute sp_executesql @sql
	--===========================================
	--Term Premium 
	set @sql = 'insert into ' + @ToDB + '.dbo.FI_I_TermPremium(n, t, TermPremium, AssumptionSetNo, CreatedDate, CreatedBy)
				select n, t, TermPremium, ' + CAST(@ToAssumptionSetNo as varchar) + ' AssumptionSetNo, CreatedDate, CreatedBy
				from ' + @FromDB + '.dbo.FI_I_TermPremium
				where AssumptionSetNo = ' + CAST(@FromAssumptionSetNo as varchar) + '
				order by n, t'

	print @sql
	execute sp_executesql @sql
	--===========================================
	--Long Term Premium
	set @sql = 'insert into ' + @ToDB + '.dbo.FI_I_LongTermReturn(n, t, LT, AssumptionSetNo, CreatedDate, CreatedBy)
				select n, t, LT, ' + CAST(@ToAssumptionSetNo as varchar) + ' AssumptionSetNo, CreatedDate, CreatedBy
				from ' + @FromDB + '.dbo.FI_I_LongTermReturn
				where AssumptionSetNo = ' + CAST(@FromAssumptionSetNo as varchar) + '
				order by n, t'

	print @sql
	execute sp_executesql @sql
	--===========================================
	--Credit Spread
	set @sql = 'insert into ' + @ToDB + '.dbo.FI_I_CreditSpread(n, t, CreditSpread, AssumptionSetNo, CreatedDate, CreatedBy)
				select n, t, CreditSpread, ' + CAST(@ToAssumptionSetNo as varchar) + ' AssumptionSetNo, CreatedDate, CreatedBy
				from ' + @FromDB + '.dbo.FI_I_CreditSpread
				where AssumptionSetNo = ' + CAST(@FromAssumptionSetNo as varchar) + '
				order by n, t'

	print @sql
	execute sp_executesql @sql
	--===========================================
	--Salary Increase
	set @sql = 'insert into ' + @ToDB + '.dbo.ALM_Salary_Increase(n, t, Inflation, Salary_Increase, AssumptionSetNo, CreatedDate, CreatedBy)
				select n, t, Inflation, Salary_Increase, ' + CAST(@ToAssumptionSetNo as varchar) + ' AssumptionSetNo, CreatedDate, CreatedBy
				from ' + @FromDB + '.dbo.ALM_Salary_Increase
				where AssumptionSetNo = ' + CAST(@FromAssumptionSetNo as varchar) + '
				order by n, t'

	print @sql
	execute sp_executesql @sql
	--===========================================
	--Parameter History
	set @sql = 'insert into ' + @ToDB + '.dbo.ParameterHistory( AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
				SELECT ' + CAST(@ToAssumptionSetNo as varchar) + ' AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy
				FROM ' + @FromDB + '.dbo.ParameterHistory
				WHERE ParameterProc in (''GenerateProjectedInflation'',
										''GenerateProjectedRealReturn'',
										''GenerateProjectedTermPremium'',
										''GenerateProjectedCreditSpread'',
										''GenerateProjectedSalaryIncreases'') and AssumptionSetNo = ' + CAST(@FromAssumptionSetNo as varchar)
	
	print @sql
	execute sp_executesql @sql
	--===========================================
	--Asset Classes
	set @sql = 'insert into ' + @ToDB + '.dbo.AssetClassReturn(n, t, Normal, Stressed, Combined, AssumptionSetNo, AssetClass, AssetGroup, Cumulative, CumulativeAnnualized, CreatedDate, CreatedBy)
				select n, t, Normal, Stressed, Combined, ' + CAST(@ToAssumptionSetNo as varchar) + ' AssumptionSetNo, AssetClass, AssetGroup, Cumulative, CumulativeAnnualized, CreatedDate, CreatedBy
				from ' + @FromDB + '.dbo.AssetClassReturn
				where AssumptionSetNo = ' + CAST(@FromAssumptionSetNo as varchar) + '
				order by n, t'

	print @sql
	execute sp_executesql @sql

	--===========================================
	--Parameter History
	set @sql = 'insert into ' + @ToDB + '.dbo.ParameterHistory( AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
				SELECT ' + CAST(@ToAssumptionSetNo as varchar) + ' AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy
				FROM ' + @FromDB + '.dbo.ParameterHistory
				WHERE (ParameterProc like ''GenerateProjectedNFIReturn%''
					or ParameterProc like ''GenerateProjectedFIReturn%''
					or ParameterProc like ''GenerateProjectedDerivativeReturn%''
					or ParameterProc like ''GenerateNFITriangleDistribution%'') and AssumptionSetNo = ' + CAST(@FromAssumptionSetNo as varchar)
	
	print @sql
	execute sp_executesql @sql
	--===========================================

	insert into AssetClass(AssetSeq, AssumptionSetNo, AssetGroup, AssetClass, CumulativeAnnualizedYr10, CreatedBy, CreatedDate, IsFinalizedBy, IsFinalizedDate)
	select ROW_NUMBER() over (partition by AssumptionSetNo, AssetGroup order by AssetClass) as AssetSeq, 
		  AssumptionSetNo, AssetGroup, AssetClass, CumulativeAnnualizedYr10, CreatedBy, CreatedDate, IsFinalizedBy, IsFinalizedDate
	from (
		select distinct AssumptionSetNo, AssetGroup, AssetClass, 
			ISNULL(PERCENTILE_CONT(0.5) within group (order by CumulativeAnnualized) over (partition by AssetClass, AssumptionSetNo), 
				   PERCENTILE_CONT(0.5) within group (order by Combined) over (partition by AssetClass, AssumptionSetNo))As CumulativeAnnualizedYr10,
			CreatedBy, CreatedDate,
			'Moved to Archive' IsFinalizedBy,
			GETDATE() IsFinalizedDate
		from AssetClassReturn
		where t = 10
	) sq
	where not exists (select 1 from AssetClass ac where ac.AssetClass = sq.AssetClass and ac.AssumptionSetNo = sq.AssumptionSetNo)
		and sq.AssumptionSetNo = @ToAssumptionSetNo
	order by AssumptionSetNo, AssetGroup, AssetClass

	update ac
	set CumulativeAnnualizedYr10 = sq.CumulativeAnnualizedYr10, 
		CreatedDate = sq.CreatedDate, 
		CreatedBy = sq.CreatedBy,
		IsFinalizedBy = sq.IsFinalizedBy, 
		IsFinalizedDate = sq.IsFinalizedDate
	from AssetClass ac
	inner join (
		select distinct AssumptionSetNo, AssetGroup, AssetClass, 
			ISNULL(PERCENTILE_CONT(0.5) within group (order by CumulativeAnnualized) over (partition by AssetClass, AssumptionSetNo), 
				   PERCENTILE_CONT(0.5) within group (order by Combined) over (partition by AssetClass, AssumptionSetNo))As CumulativeAnnualizedYr10,
			CreatedBy, CreatedDate,
			'Moved to Archive' IsFinalizedBy,
			GETDATE() IsFinalizedDate
		from AssetClassReturn
		where t = 10
	) sq on sq.AssetClass = ac.AssetClass and sq.AssumptionSetNo = ac.AssumptionSetNo
	where sq.AssumptionSetNo = @ToAssumptionSetNo

END
GO
/****** Object:  StoredProcedure [dbo].[Move_CashflowSet]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2020/06/22>
-- Description:	<Stored procedure for moving Cashflow Set from one Database to another (Archive/Restore)>

-- Updated date: <2020/06/22>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <>

-- =============================================
CREATE PROCEDURE [dbo].[Move_CashflowSet] (@FromDB as varchar(max), @ToDB as varchar(max), @FromCashflowSetNo as int, @ToCashflowSetNo as int)
AS
BEGIN
	
	--EXEC Move_CashflowSet 'PBI_ALM_WIP_4', 'PBI_ALM_Archive', 3, 5
	
	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Move CashflowSet'
	declare @ProcessStartDate as datetime = GETDATE()
		
	declare @RowCnt as float = 1
	exec WriteLog @ToCashflowSetNo, @ProcessName, @ProcessStartDate, 1, @FromDB

	/*
	declare @FromDB as varchar(max) = 'PBI_ALM_WIP_4'
	declare @ToDB as varchar(max) = 'PBI_ALM_Archive'
	declare @FromCashflowSetNo as int = 3
	declare @ToCashflowSetNo as int = 3

	EXEC Move_CashflowSet @FromDB, @ToDB, @FromCashflowSetNo, @ToCashflowSetNo
	*/

	declare @sql as nvarchar(max)
	declare @SourceTableName as varchar(max) 
	 
	--Clean out the destination DB assumptionSet
	set @sql = 'EXEC ' + @ToDB + '.dbo.Empty_CashflowSet ' +  CAST( @ToCashflowSetNo as varchar) + ', ''YES'''

	print @sql
	execute sp_executesql @sql

	set @sql = 'insert into ' + @ToDB + '.dbo.CashflowSet(CashflowSetNo, CashflowSetDescript, CreatedDate, CreatedBy, AssPopulationChange, AssSalaryInflation, IsFinalizedDate, IsFinalizedBy, ClientName)
				select ' +  CAST( @ToCashflowSetNo as varchar) + ' CashflowSetNo, CashflowSetDescript, CreatedDate, CreatedBy, AssPopulationChange, AssSalaryInflation, GETDATE(), ''Moved from:' + @FromDB + ':' +  CAST(@FromCashflowSetNo as varchar) + ''' IsFinalizedBy, ClientName
				from ' + @FromDB + '.dbo.CashflowSet
				where CashflowSetNo = ' + CAST(@FromCashflowSetNo as varchar)

	print @sql
	execute sp_executesql @sql

	--Cashflows
	set @sql = 'insert into ' + @ToDB + '.dbo.ALM_I_L_CashFlow(CashflowSetNo, t, Year, RateType, Accrued, NormalCost, FutureService, Contributions, CreatedDate, CreatedBy)
				select ' +  CAST( @ToCashflowSetNo as varchar) + ' CashflowSetNo, t, Year, RateType, Accrued, NormalCost, FutureService, Contributions, GETDATE() CreatedDate, ''Restored from Archive'' CreatedBy
				from ' + @FromDB + '.dbo.ALM_I_L_CashFlow
				where CashflowSetNo = ' + CAST(@FromCashflowSetNo as varchar) + '
				order by t'

	print @sql
	execute sp_executesql @sql

	--Asset Value History
	set @sql = 'insert into ' + @ToDB + '.dbo.ALM_I_A_AssetValueHistory(CashflowSetNo, t, Year, MVA_BOY, MVA_EOY, ExpectedIncome, ActualIncome, ExcessGains, CreatedDate, CreatedBy)
				select ' +  CAST( @ToCashflowSetNo as varchar) + ' CashflowSetNo, t, Year, MVA_BOY, MVA_EOY, ExpectedIncome, ActualIncome, ExcessGains, GETDATE() CreatedDate, ''Restored from Archive'' CreatedBy
				from ' + @FromDB + '.dbo.ALM_I_A_AssetValueHistory
				where CashflowSetNo = ' + CAST(@FromCashflowSetNo as varchar) + '
				order by t'
	
	print @sql
	execute sp_executesql @sql


END
GO
/****** Object:  StoredProcedure [dbo].[Move_ResultSet]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2020/06/22>
-- Description:	<Stored procedure for moving Cashflow Set from one Database to another (Archive/Restore)>

-- Updated date: <2020/06/22>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <>

-- =============================================
CREATE PROCEDURE [dbo].[Move_ResultSet] (@FromDB as varchar(max), @ToDB as varchar(max), @FromResultSetNo as int, @ToResultSetNo as int)
AS
BEGIN
	
	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Move ResultSet'
	declare @ProcessStartDate as datetime = GETDATE()
		
	declare @RowCnt as float = 1
	exec WriteLog @ToResultSetNo, @ProcessName, @ProcessStartDate, 1, @FromDB

	/*
	declare @FromDB as varchar(max) = 'PBI_ALM_WIP_4'
	declare @ToDB as varchar(max) = 'PBI_ALM_Archive'
	declare @FromResultSetNo as int = 2
	declare @ToResultSetNo as int = 2

	EXEC Move_ResultSet @FromDB, @ToDB, @FromResultSetNo, @ToResultSetNo
	EXEC Empty_ResultSet @FromResultSetNo, 'YES'
	*/
	
	declare @sql as nvarchar(max)
	declare @SourceTableName as varchar(max) 
	 
	--Clean out the destination DB assumptionSet
	set @sql = 'EXEC ' + @ToDB + '.dbo.Empty_ResultSet ' +  CAST( @ToResultSetNo as varchar) + ', ''YES'''

	print @sql
	execute sp_executesql @sql

	--Check if required AssumptionSet and CashflowSet Exists in Destination DB
	--set @sql = select AssumptionSetNo
	--		   from PBI_ALM_Archive.dbo.AssumptionSet
	--		   where IsFinalizedBy = 'Moved from:PBI_ALM_WIP_4:3'

	--ResultSet
	set @sql =	'insert into ' + @ToDB + '.dbo.ResultSet (ResultSetNo, AssumptionSetNo, CashflowSetNo, MixName, ResultSetDescript, 
							CreatedDate, CreatedBy, IsProjectedDate, IsProjectedBy, IsFinalizedDate, IsFinalizedBy,
							InitialCFRunDoneGC, InitialCFRunDoneSOLV, InitialCFRunDoneACC, UseSameCFAllBases)
				select ' + CAST(@ToResultSetNo as varchar) + ' ResultSetNo, ass.AssumptionSetNo, cf.CashflowSetNo, MixName, ResultSetDescript, 
					rs.CreatedDate, rs.CreatedBy, rs.IsProjectedDate, rs.IsProjectedBy, GETDATE() IsFinalizedDate, ''Moved from:' + @FromDB + ':' +  CAST(@FromResultSetNo as varchar) + ''' IsFinalizedBy,
					InitialCFRunDoneGC, InitialCFRunDoneSOLV, InitialCFRunDoneACC, UseSameCFAllBases 
				from ' + @FromDB + '.dbo.ResultSet rs
				left join  ' + @ToDB + '.dbo.AssumptionSet ass on ass.IsFinalizedBy = ''Moved from:' + @FromDB + ':'' + CAST(rs.AssumptionSetNo as varchar)
				left join  ' + @ToDB + '.dbo.CashflowSet cf on cf.IsFinalizedBy = ''Moved from:' + @FromDB + ':'' + CAST(rs.CashflowSetNo as varchar)
				where ResultSetNo = ' + CAST(@FromResultSetNo as varchar)

	print @sql
	execute sp_executesql @sql
	
	--AlternativeMixes
	set @sql =	'insert into ' + @ToDB + '.dbo.AlternativeMixes (n, t, ProjectedReturns, AssumptionSetNo, ResultSetNo, MixName, CumulativeReturn, AnnualizedCumulativeReturn, CreatedDate, CreatedBy)
				 select n, t, ProjectedReturns, (select AssumptionSetNo from ' + @ToDB + '.dbo.ResultSet where ResultSetNo = ' + CAST(@ToResultSetNo as varchar)+ '), ' + CAST(@ToResultSetNo as varchar) + ' ResultSetNo, MixName, CumulativeReturn, AnnualizedCumulativeReturn, CreatedDate, CreatedBy
				 from ' + @FromDB + '.dbo.AlternativeMixes
				 where ResultSetNo = ' + CAST(@FromResultSetNo as varchar)

	print @sql
	execute sp_executesql @sql

	--ParameterHistory
	set @sql =	'insert into ' + @ToDB + '.dbo.ParameterHistory (AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)
				 select (select AssumptionSetNo from ' + @ToDB + '.dbo.ResultSet where ResultSetNo = ' + CAST(@ToResultSetNo as varchar)+ '), ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy
				 from  ' + @FromDB + '.dbo.ParameterHistory
				 where ParameterProc = ''GenerateProjectedPortfolioReturn:'' + (select distinct MixName from ' + @FromDB + '.dbo.AlternativeMixes where ResultSetNo = ' + CAST(@FromResultSetNo as varchar) + ')'

	print @sql
	execute sp_executesql @sql

END
GO
/****** Object:  StoredProcedure [dbo].[ProjectAssetClass]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2020/02/24>
-- Description:	<Stored procedure for finalizing the ResultSet>

-- Updated date: <>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <>
-- =============================================
CREATE PROCEDURE [dbo].[ProjectAssetClass] (@AssumptionSetNo as int, @AssetClass as varchar(255))
AS
BEGIN
	

	insert into AssetClass(AssetSeq, AssumptionSetNo, AssetGroup, AssetClass, CumulativeAnnualizedYr10, CreatedBy, CreatedDate, IsFinalizedBy, IsFinalizedDate)
	select ROW_NUMBER() over (partition by AssumptionSetNo, AssetGroup order by AssetClass) as AssetSeq, 
		  AssumptionSetNo, AssetGroup, AssetClass, CumulativeAnnualizedYr10, CreatedBy, CreatedDate, IsFinalizedBy, IsFinalizedDate
	from (
		select distinct AssumptionSetNo, AssetGroup, AssetClass, 
			ISNULL(PERCENTILE_CONT(0.5) within group (order by CumulativeAnnualized) over (partition by AssetClass, AssumptionSetNo), 
				   PERCENTILE_CONT(0.5) within group (order by Combined) over (partition by AssetClass, AssumptionSetNo))As CumulativeAnnualizedYr10,
			CreatedBy, CreatedDate,
			CAST(NULL as varchar(255)) IsFinalizedBy,
			CAST(NULL as datetime) IsFinalizedDate
		from AssetClassReturn
		where t = 10
	) sq
	where not exists (select 1 from AssetClass ac where ac.AssetClass = sq.AssetClass and ac.AssumptionSetNo = sq.AssumptionSetNo)
		and sq.AssetClass = @AssetClass 
		and sq.AssumptionSetNo = @AssumptionSetNo
	order by AssumptionSetNo, AssetGroup, AssetClass

	update ac
	set CumulativeAnnualizedYr10 = sq.CumulativeAnnualizedYr10, 
		CreatedDate = sq.CreatedDate, 
		CreatedBy = sq.CreatedBy,
		IsFinalizedBy = sq.IsFinalizedBy, 
		IsFinalizedDate = sq.IsFinalizedDate
	from AssetClass ac
	inner join (
		select distinct AssumptionSetNo, AssetGroup, AssetClass, 
			ISNULL(PERCENTILE_CONT(0.5) within group (order by CumulativeAnnualized) over (partition by AssetClass, AssumptionSetNo), 
				   PERCENTILE_CONT(0.5) within group (order by Combined) over (partition by AssetClass, AssumptionSetNo))As CumulativeAnnualizedYr10,
			CreatedBy, CreatedDate,
			CAST(NULL as varchar(255)) IsFinalizedBy,
			CAST(NULL as datetime) IsFinalizedDate
		from AssetClassReturn
		where t = 10
	) sq on sq.AssetClass = ac.AssetClass and sq.AssumptionSetNo = ac.AssumptionSetNo
	where sq.AssetClass = @AssetClass
	  and sq.AssumptionSetNo = @AssumptionSetNo
	
END
GO
/****** Object:  StoredProcedure [dbo].[ProjectResultSet]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2020/02/24>
-- Description:	<Stored procedure for finalizing the ResultSet>

-- Updated date: <>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <>
-- =============================================
CREATE PROCEDURE [dbo].[ProjectResultSet] (@ResultSetNo as int)
AS
BEGIN

	update r
	set r.IsProjectedDate = GETDATE(), r.IsProjectedBy = ORIGINAL_LOGIN()
	from ResultSet r
	where ResultSetNo = @ResultSetNo

	--=====================================================
	--Check if Initial Liability Run was done
	update rs
	set rs.InitialCFRunDoneGC = 'No', rs.InitialCFRunDoneSOLV = 'No', rs.InitialCFRunDoneACC = 'No'
	from ResultSet rs

	--Solvency
	update rs
	set rs.InitialCFRunDoneSOLV = 'Yes'
	from ResultSet rs
	inner join (select AssumptionSetNo, CashflowSetNo, RateType, COUNT(*) Cnt, MAX(CreatedDate) IsProjectedDate
				from tmp.ALM_R_L_AdjustedLiability
				where RateType = 'SOLV'
				group by AssumptionSetNo, CashflowSetNo, RateType
				) sq on sq.AssumptionSetNo = rs.AssumptionSetNo 
					and sq.CashflowSetNo = rs.CashflowSetNo

	--Accounting
	update rs
	set rs.InitialCFRunDoneACC = 'Yes'
	from ResultSet rs
	inner join (select AssumptionSetNo, CashflowSetNo, RateType, COUNT(*) Cnt, MAX(CreatedDate) IsProjectedDate
				from tmp.ALM_R_L_AdjustedLiability
				where RateType = 'ACC'
				group by AssumptionSetNo, CashflowSetNo, RateType
				) sq on sq.AssumptionSetNo = rs.AssumptionSetNo 
					and sq.CashflowSetNo = rs.CashflowSetNo

	--Going Concern
	update rs
	set rs.InitialCFRunDoneGC = 'Yes',
		rs.InitialCFRunDoneSOLV = CASE WHEN rs.UseSameCFAllBases = 'Yes' THEN 'Yes' ELSE 'No' END,
		rs.InitialCFRunDoneACC = CASE WHEN rs.UseSameCFAllBases = 'Yes' THEN 'Yes' ELSE 'No' END
	from ResultSet rs
	inner join (select AssumptionSetNo, CashflowSetNo, RateType, COUNT(*) Cnt, MAX(CreatedDate) IsProjectedDate
				from tmp.ALM_R_L_AdjustedLiability
				where RateType = 'GC'
				group by AssumptionSetNo, CashflowSetNo, RateType
				) sq on sq.AssumptionSetNo = rs.AssumptionSetNo 
					and sq.CashflowSetNo = rs.CashflowSetNo
	--=====================================================


	drop table tmp.ALM_R_A_ProjectedMVA_PBI

	select *
	into tmp.ALM_R_A_ProjectedMVA_PBI
	from vw_ProjectedMVA
	where ResultLinkKey is not NULL
	
END
GO
/****** Object:  StoredProcedure [dbo].[Replicate_CashFlows]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2019/09/30>
-- Description:	<Stored procedure for replicating cash flows from previous input>

-- Updated date:	<2020/02/11>
-- Updated by:		<Gerrit Marais>
-- Updated reason:	<Added logging logic - 2020/02/11>
-- =============================================
CREATE PROCEDURE [dbo].[Replicate_CashFlows] (@CashflowSetNo as int)
AS
BEGIN
	
	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Replicate CashFlows'
	declare @ProcessStartDate as datetime = GETDATE()

	--Liability Cashflows
	delete from ALM_I_L_CashFlow where CashflowSetNo = @CashflowSetNo

	insert into ALM_I_L_CashFlow (CashflowSetNo, t, Year, RateType, Accrued, NormalCost, FutureService, Contributions)
	select @CashflowSetNo, t, Year, RateType, Accrued, NormalCost, FutureService, Contributions
	from ALM_I_L_CashFlow
	where CashflowSetNo = 1

	--Write to Log file
	declare @RowCnt as float = 0
	exec WriteLog 99, @ProcessName, @ProcessStartDate, @RowCnt
	
END
GO
/****** Object:  StoredProcedure [dbo].[Update_FI_RCorr]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:          <Kris Kim Sing>
-- Create date:		<2020/08/20>
-- Description:     <Stored procedure to Update and Normalize FI Correlated Random Numbers - Building Block Method>

-- Updated date:	<YYYY/MM/DD>
-- Updated by:		<>
-- Updated reason:	<> - <YYYY/MM/DD>
--					
-- =============================================
CREATE PROCEDURE [dbo].[Update_FI_RCorr] (@AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;

	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Update and Normalize FI Correlated Random Numbers'
	declare @ProcessStartDate as datetime = GETDATE()

	--Stop stored procedure if results are finalized
	if (select IsFinalizedBy from AssumptionSet where AssumptionSetNo = @AssumptionSetNo) IS NOT NULL
		begin	
			exec WriteLog @AssumptionSetNo, 'Warning: AssumptionSet Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName
		end	
	else
	begin
	
	--Write to trail table
	insert into trl.FI_R_Corr_Final(AssumptionSetNo, n, t, Infl, FedCredSpread, TermRPrem_7yrs, TermRPrem_15yrs, Prov_A_RatedDebtCredSpread_7yr, Prov_A_RatedDebtCredSpread_15yr, BBBCredSpread, HighYieldSpread, PrivDebt_illiquidityPrem, Mort_IG_Spread, CreatedDate, CreatedBy)
	select AssumptionSetNo, n, t, Infl, FedCredSpread, TermRPrem_7yrs, TermRPrem_15yrs, Prov_A_RatedDebtCredSpread_7yr, Prov_A_RatedDebtCredSpread_15yr, BBBCredSpread, HighYieldSpread, PrivDebt_illiquidityPrem, Mort_IG_Spread, GETDATE(), ORIGINAL_LOGIN()
	from FI_R_Corr_Final where AssumptionSetNo = @AssumptionSetNo

	--Clear table from previous values
	delete from FI_R_Corr_Final where AssumptionSetNo = @AssumptionSetNo
	
	drop index idx_FI_R_Corr_Final on FI_R_Corr_Final

	insert into FI_R_Corr_Final(AssumptionSetNo, n, t, Infl, FedCredSpread, TermRPrem_7yrs, TermRPrem_15yrs, Prov_A_RatedDebtCredSpread_7yr, Prov_A_RatedDebtCredSpread_15yr, BBBCredSpread, HighYieldSpread, PrivDebt_illiquidityPrem, Mort_IG_Spread, CreatedDate, CreatedBy)
	select AssumptionSetNo, n, t, 
		CASE WHEN (PERCENT_RANK() over ( ORDER BY Infl)) = 0 THEN 0.00000001 
			 WHEN (PERCENT_RANK() over ( ORDER BY Infl)) = 1 THEN 0.99999999 ELSE (PERCENT_RANK() over ( ORDER BY Infl)) END Infl,
		CASE WHEN (PERCENT_RANK() over ( ORDER BY FedCredSpread)) = 0 THEN 0.00000001 
			 WHEN (PERCENT_RANK() over ( ORDER BY FedCredSpread)) = 1 THEN 0.99999999 ELSE (PERCENT_RANK() over ( ORDER BY FedCredSpread)) END FedCredSpread,
		CASE WHEN (PERCENT_RANK() over ( ORDER BY TermRPrem_7yrs)) = 0 THEN 0.00000001 
			 WHEN (PERCENT_RANK() over ( ORDER BY TermRPrem_7yrs)) = 1 THEN 0.99999999 ELSE (PERCENT_RANK() over ( ORDER BY TermRPrem_7yrs)) END TermRPrem_7yrs,
		CASE WHEN (PERCENT_RANK() over ( ORDER BY TermRPrem_15yrs)) = 0 THEN 0.00000001 
			 WHEN (PERCENT_RANK() over ( ORDER BY TermRPrem_15yrs)) = 1 THEN 0.99999999 ELSE (PERCENT_RANK() over ( ORDER BY TermRPrem_15yrs)) END TermRPrem_15yrs,
		CASE WHEN (PERCENT_RANK() over ( ORDER BY Prov_A_RatedDebtCredSpread_7yr)) = 0 THEN 0.00000001 
			 WHEN (PERCENT_RANK() over ( ORDER BY Prov_A_RatedDebtCredSpread_7yr)) = 1 THEN 0.99999999 ELSE (PERCENT_RANK() over ( ORDER BY Prov_A_RatedDebtCredSpread_7yr)) END Prov_A_RatedDebtCredSpread_7yr,
		CASE WHEN (PERCENT_RANK() over ( ORDER BY Prov_A_RatedDebtCredSpread_15yr)) = 0 THEN 0.00000001 
			 WHEN (PERCENT_RANK() over ( ORDER BY Prov_A_RatedDebtCredSpread_15yr)) = 1 THEN 0.99999999 ELSE (PERCENT_RANK() over ( ORDER BY Prov_A_RatedDebtCredSpread_15yr)) END Prov_A_RatedDebtCredSpread_15yr,
		CASE WHEN (PERCENT_RANK() over ( ORDER BY BBBCredSpread)) = 0 THEN 0.00000001 
			 WHEN (PERCENT_RANK() over ( ORDER BY BBBCredSpread)) = 1 THEN 0.99999999 ELSE (PERCENT_RANK() over ( ORDER BY BBBCredSpread)) END BBBCredSpread,
		CASE WHEN (PERCENT_RANK() over ( ORDER BY HighYieldSpread)) = 0 THEN 0.00000001 
			 WHEN (PERCENT_RANK() over ( ORDER BY HighYieldSpread)) = 1 THEN 0.99999999 ELSE (PERCENT_RANK() over ( ORDER BY HighYieldSpread)) END HighYieldSpread,
		CASE WHEN (PERCENT_RANK() over ( ORDER BY PrivDebt_illiquidityPrem)) = 0 THEN 0.00000001 
			 WHEN (PERCENT_RANK() over ( ORDER BY PrivDebt_illiquidityPrem)) = 1 THEN 0.99999999 ELSE (PERCENT_RANK() over ( ORDER BY PrivDebt_illiquidityPrem)) END PrivDebt_illiquidityPrem,
		CASE WHEN (PERCENT_RANK() over ( ORDER BY Mort_IG_Spread)) = 0 THEN 0.00000001 
			 WHEN (PERCENT_RANK() over ( ORDER BY Mort_IG_Spread)) = 1 THEN 0.99999999 ELSE (PERCENT_RANK() over ( ORDER BY Mort_IG_Spread)) END Mort_IG_Spread,
		GETDATE(), 
		ORIGINAL_LOGIN()
	from FI_R_Corr
	where AssumptionSetNo = @AssumptionSetNo
	order by t, n

	create nonclustered index idx_FI_R_Corr_Final on FI_R_Corr_Final(n, t, AssumptionSetNo)

	declare @RowCnt as float = (select COUNT(*) from FI_R_Corr_Final where AssumptionSetNo = @AssumptionSetNo)
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt

	end
	--exec Update_FI_RCorr @AssumptionSetNo
	--exec Update_FI_RCorr 3

END
GO
/****** Object:  StoredProcedure [dbo].[Update_NFI_RCorr]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2018/01/04>
-- Description:	<Stored procedure for Updating and editing the Correlated Random numbers used of Non-Fixed-Income Asset Class returns>

-- Updated date: <2020/02/05>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <Added logging logic - 2020/02/05>
--				   <Write to trail tables - 2020/02/11>
--				   <Added logic to stop execution if AssumptionSet is Finalized - 2020/02/25>
-- =============================================
CREATE PROCEDURE [dbo].[Update_NFI_RCorr] (@AssumptionSetNo as int)
AS
BEGIN

	SET NOCOUNT ON;

	--Logging Parameters
	declare @ProcessName as varchar(MAX) = 'Update and Normalize Correlated Random Numbers'
	declare @ProcessStartDate as datetime = GETDATE()

	--Stop stored procedure if results are finalized
	if (select IsFinalizedBy from AssumptionSet where AssumptionSetNo = @AssumptionSetNo) IS NOT NULL
		begin	
			exec WriteLog @AssumptionSetNo, 'Warning: AssumptionSet Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName
		end	
	else
	begin
	
	--Write to trail table
	insert into trl.NFI_R_Corr_Final(AssumptionSetNo, n, t, CdnEq, GloEq, EMEq, CdnLVEq, GloLVEq, PE, IE, RE, CreatedDate, CreatedBy)
	select AssumptionSetNo, n, t, CdnEq, GloEq, EMEq, CdnLVEq, GloLVEq, PE, IE, RE, GETDATE(), ORIGINAL_LOGIN()
	from NFI_R_Corr_Final where AssumptionSetNo = @AssumptionSetNo

	--Clear table from previous values
	delete from NFI_R_Corr_Final where AssumptionSetNo = @AssumptionSetNo
	
	drop index idx_NFI_R_Corr_Final on NFI_R_Corr_Final

	insert into NFI_R_Corr_Final(AssumptionSetNo, n, t, CdnEq, GloEq, EMEq, CdnLVEq, GloLVEq, PE, IE, RE)
	select AssumptionSetNo, n, t, 
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

	create nonclustered index idx_NFI_R_Corr_Final on NFI_R_Corr_Final(n, t, AssumptionSetNo)

	declare @RowCnt as float = (select COUNT(*) from NFI_R_Corr_Final where AssumptionSetNo = @AssumptionSetNo)
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt

	end
	--exec Update_NFI_RCorr @AssumptionSetNo
	--exec Update_NFI_RCorr 3

END
GO
/****** Object:  StoredProcedure [dbo].[WriteLog]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Gerrit Marais>
-- Create date: <2020/02/05>
-- Description:	<Stored procedure for writing process progress to a log file>

-- Updated date: <2020/02/05>
-- Updated by:	 <Gerrit Marais>
-- Updated reason: <>
-- =============================================
CREATE PROCEDURE [dbo].[WriteLog] (@LevelNo as int, @ProcessName as varchar(MAX), @ProcessStartDate as datetime,  @RowCnt as float, @ProcessVariable as varchar(MAX) = NULL)
AS
BEGIN

	insert into _Log(LevelID, LevelName, LevelNo, SubLevelID, SubLevel, ProcessID, ProcessName, ProcessVariable, RunTime, RunCnt, RowCnt, CreatedDate, CreatedBy)
	select pm.LevelID, pm.LevelName, @LevelNo, pm.SubLevelID, pm.SubLevel, pm.ProcessID, @ProcessName, @ProcessVariable,  datediff(second,@ProcessStartDate,GETDATE()) RunTime, 
		(SELECT COUNT(*) from _Log l where LevelNo = @LevelNo and l.ProcessID = pm.ProcessID and ISNULL(ProcessVariable, 0) = ISNULL(@ProcessVariable, 0))  + 1 RunCnt, @RowCnt, GETDATE(), ORIGINAL_LOGIN()
	from _ProcessMap pm
	where ProcessName = @ProcessName

END
GO
/****** Object:  StoredProcedure [dbo].[zzzGenerateProjectedFIAssetReturns]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:          <Kris Kim Sing>
-- Create date:		<2020/10/15>
-- Description:     <Stored procedure for creating projected Fixed income yields and returns - Building Block Method>

-- Updated date:	<2020/10/30>
-- Updated by:		<Kris Kim Sing>
-- Updated reason:	<Updated the Stored Procedure to include calculation of yields and returns using recursive CTE> - <2020/10/29>
--					
-- =============================================

CREATE PROCEDURE [dbo].[zzzGenerateProjectedFIAssetReturns] (@BBType as varchar(1000), @BBWeight as varchar(MAX), @FIAsset as varchar(1000), @AssumptionSetNo as int, 
															@prob_sr as varchar(MAX), @max_loss as varchar(MAX), @max_spread as varchar(MAX), @yield_marg as varchar(MAX), 
															@mu_alpha as varchar(MAX), @sd_alpha as varchar(MAX), @dur as varchar(MAX))												
AS												
BEGIN												
												
	SET NOCOUNT ON;				
	    												
	--Logging Parameters											
	declare @ProcessName as varchar(MAX) = 'Project FI Asset Returns'											
	declare @ProcessStartDate as datetime = GETDATE()	
	declare @ProcName as varchar(255) = 'GenerateProjectedFIAssetReturns' + ':' + @FIAsset
	
	--Stop stored procedure if results are finalized											
	if (select IsFinalizedBy from AssumptionSet where AssumptionSetNo = @AssumptionSetNo) IS NOT NULL											
		begin										
			exec WriteLog @AssumptionSetNo, 'Warning: AssumptionSet Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName									
		end										
	else											
	begin
	
		--Parameters											
		/*
		declare @BBType as varchar(MAX) = 'Infl,FedCredSpread,TermRPrem_7yrs,TermRPrem_15yrs,Prov_A_RatedDebtCredSpread_7yr,Prov_A_RatedDebtCredSpread_15yr,
											BBBCredSpread,HighYieldSpread,PrivDebt_illiquidityPrem,Mort_IG_Spread'
		declare @BBWeight as varchar(MAX) = '1,1,1,0,0,0,1,0,0,0'

		declare @FIAsset as varchar(MAX) = 'CreditBBB7yrdurbond'
		declare @AssumptionSetNo as int = 3

		declare @prob_sr as varchar(MAX) = '0.075'
		declare @max_loss as varchar(MAX) = '0.050'
		declare @max_spread as varchar(MAX) = '0.040'
		declare @yield_marg as varchar(MAX) = '0.0'
		declare @mu_alpha as varchar(MAX) = '0.005'
		declare @sd_alpha as varchar(MAX) = '0.006'
		declare @dur as varchar(MAX) = '7.0'
		*/

		--Clean up the history
		delete from FI_I_AssetReturns where AssumptionSetNo = @AssumptionSetNo and FIAsset = @FIAsset
		delete from ParameterHistory where AssumptionSetNo = @AssumptionSetNo and ParameterProc = @ProcName

		--Drop index
		/*drop index idx_FI_I_AssetReturns on FI_I_AssetReturns*/

		--Store the parameter values for future reference	
		/*
		insert into ParameterHistory(AssumptionSetNo, ParameterProc, ParameterName, ParameterValue, CreatedDate, CreatedBy)											
			select @AssumptionSetNo, 'GenerateProjectedFIAssetReturns' + ':' + @FIAsset, '@BBType', @BBType, GetDate(), ORIGINAL_LOGIN()											
				union									
			select @AssumptionSetNo, 'GenerateProjectedFIAssetReturns' + ':' + @FIAsset, '@BBWeight', @BBWeight, GetDate(), ORIGINAL_LOGIN()											
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIAssetReturns' + ':' + @FIAsset, '@FIAsset', @FIAsset, GetDate(), ORIGINAL_LOGIN()											
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIAssetReturns' + ':' + @FIAsset, '@AssumptionSetNo', @AssumptionSetNo, GetDate(), ORIGINAL_LOGIN()											
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIAssetReturns' + ':' + @FIAsset, '@prob_sr', @prob_sr, GetDate(), ORIGINAL_LOGIN()		
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIAssetReturns' + ':' + @FIAsset, '@max_loss', @max_loss, GetDate(), ORIGINAL_LOGIN()	
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIAssetReturns' + ':' + @FIAsset, '@max_spread', @max_spread, GetDate(), ORIGINAL_LOGIN()		
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIAssetReturns' + ':' + @FIAsset, '@yield_marg', @yield_marg, GetDate(), ORIGINAL_LOGIN()	
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIAssetReturns' + ':' + @FIAsset, '@mu_alpha', @mu_alpha, GetDate(), ORIGINAL_LOGIN()		
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIAssetReturns' + ':' + @FIAsset, '@sd_alpha', @sd_alpha, GetDate(), ORIGINAL_LOGIN()	
				union										
			select @AssumptionSetNo, 'GenerateProjectedFIAssetReturns' + ':' + @FIAsset, '@dur', @dur, GetDate(), ORIGINAL_LOGIN()
		*/
		--Calculate the increase/decrease in Credit Spread / Maximum Loss
		if OBJECT_ID('tempdb..#FI_Stressed') IS NOT NULL
		drop table #FI_Stressed

		; with FI_R_StressReg
		as (
			select *
			from vw_FI_R_StressReg_Unpvt
			),
		
		FI_R_StressRegCdnEq
		as (
			select rco.n, rco.t, rco.AssumptionSetNo, CdnEq
			from NFI_R_Corr_Final rco	
			)	

		select sr.n, sr.t, 
		   CASE WHEN sr.StressReg < @prob_sr THEN (1 - cdn.CdnEq) * @max_loss ELSE 0 END StressedLoss,
		   CASE WHEN sr.StressReg < @prob_sr THEN (1 - cdn.CdnEq) * @max_spread ELSE 0 END StressedSpread,
		   sr.AssumptionSetNo,
		   RAND(CHECKSUM( NEWID())) Rand_Alpha
		into #FI_Stressed
		from FI_R_StressReg sr
		
		inner join FI_R_StressRegCdnEq cdn on cdn.n = sr.n and cdn.t = sr.t
			and cdn.AssumptionSetNo = sr.AssumptionSetNo
		where sr.AssumptionSetNo = @AssumptionSetNo --links to @AssumptionSetNo parameter = '3'
		
		order by sr.t, sr.n

		; with base_cte 
		as (
			select bb.n, bb.t, @FIAsset [FIAsset], SUM(sq2.SplitString * bb.BBValue) + 0 + ISNULL(MAX(st.StressedSpread),0) + @yield_marg [FIYield], 
					ISNULL(MAX(st.StressedSpread),0) [StressedSpread], ISNULL(MAX(st.StressedLoss),0) [StressedLoss], 
					ISNULL(MAX(st.Rand_Alpha),0) [Rand_Alpha], ISNULL(@mu_alpha + @sd_alpha * Utils.dbo.normsinv(MAX(st.Rand_Alpha)),0) [Alpha],
					bb.AssumptionSetNo
			from FI_I_BuildingBlocks bb

			inner join (select * from Utils.dbo.tvf_SplitString(@BBType, ',')) sq1 on sq1.SplitString = bb.BBType
			inner join (select * from Utils.dbo.tvf_SplitString(@BBWeight, ',')) sq2 on sq1.Id = sq2.Id
			left join #FI_Stressed st on bb.n = st.n and bb.t = st.t
			GROUP BY bb.n, bb.t, bb.AssumptionSetNo
			),
			
			recur_cte
			as (
			select cur.n, cur.t, cur.FIAsset, cur.FIYield, cur.StressedSpread, cur.StressedLoss, cur.Rand_Alpha, cur.Alpha,
					prev.FIYield + EXP( @dur * (prev.FIYield - cur.FIYield)) - 1 [FI_PreLossAplhaReturn],
					prev.FIYield + EXP( @dur * (prev.FIYield - cur.FIYield)) - 1 - cur.StressedLoss + cur.Alpha [FI_CombinedReturn],
					cur.AssumptionSetNo [AssumptionSetNo], GETDATE() [CreatedDate], ORIGINAL_LOGIN() [CreatedBy]
			from base_cte cur
			
			left join base_cte prev on prev.n = cur.n and prev.t + 1 = cur.t
			WHERE cur.t = 1
			
			UNION all
			
			select cur.n, cur.t, cur.FIAsset, cur.FIYield, cur.StressedSpread, cur.StressedLoss, cur.Rand_Alpha, cur.Alpha,
					recur.FIYield + EXP( @dur * (recur.FIYield - cur.FIYield)) - 1 [FI_PreLossAplhaReturn],
					recur.FI_PreLossAplhaReturn - cur.StressedLoss + cur.Alpha [FI_CombinedReturn],
					cur.AssumptionSetNo [AssumptionSetNo], GETDATE() [CreatedDate], ORIGINAL_LOGIN() [CreatedBy]
			FROM base_cte cur
		
			INNER JOIN recur_cte recur on cur.n = recur.n and cur.t - 1 = recur.t
			WHERE cur.t > 1

			)

			insert into FI_I_AssetReturns(n, t, FIAsset, FIYield, FICredSprdInc, FILoss, Rand_Alpha, Alpha, FI_PreLossAlphaReturn, FI_CombinedReturn, AssumptionSetNo, CreatedDate, CreatedBy)
			select * FROM recur_cte
			order by n, t		
	
	end											
				
	--Write to Log file											
	declare @RowCnt as float = (select COUNT(*) from FI_I_AssetReturns where AssumptionSetNo = @AssumptionSetNo and FIAsset = @FIAsset)											
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @FIAsset											
																					
END
GO
/****** Object:  StoredProcedure [dbo].[zzzGenerateProjectedFIAssetYields]    Script Date: 2020-12-23 08:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[zzzGenerateProjectedFIAssetYields] (@BBType as varchar(1000), @BBWeight as varchar(MAX), @FIAsset as varchar(1000), @AssumptionSetNo as int, @prob_sr as varchar(MAX), @max_loss as varchar(MAX), @max_spread as varchar(MAX), @yield_marg as varchar(MAX), @mu_alpha as varchar(MAX), @sd_alpha as varchar(MAX), @dur as varchar(MAX))												
AS												
BEGIN												
												
	SET NOCOUNT ON;				
	    												
	--Logging Parameters											
	declare @ProcessName as varchar(MAX) = 'Project FI Asset Yields'											
	declare @ProcessStartDate as datetime = GETDATE()	
	
	--Stop stored procedure if results are finalized											
	if (select IsFinalizedBy from AssumptionSet where AssumptionSetNo = @AssumptionSetNo) IS NOT NULL											
		begin										
			exec WriteLog @AssumptionSetNo, 'Warning: AssumptionSet Finalized - No Work Done', @ProcessStartDate, 0, @ProcessName									
		end										
	else											
	begin
	
		--Parameters											
		/*
		declare @BBType as varchar(MAX) = 'Infl,FedCredSpread,TermRPrem_7yrs,TermRPrem_15yrs,Prov_A_RatedDebtCredSpread_7yr,Prov_A_RatedDebtCredSpread_15yr,BBBCredSpread,HighYieldSpread,PrivDebt_illiquidityPrem,Mort_IG_Spread'
		declare @BBWeight as varchar(MAX) = '1,1,1,0,0,0,1,0,0,0'

		declare @itncnt as int = 2000

		declare @FIAsset as varchar(MAX) = 'CreditBBB7yrdurbond'
		declare @AssumptionSetNo as int = 3

		declare @prob_sr as varchar(MAX) = '0.075'
		declare @max_loss as varchar(MAX) = '0.050'
		declare @max_spread as varchar(MAX) = '0.040'
		declare @yield_marg as varchar(MAX) = '0.0'
		declare @mu_alpha as varchar(MAX) = '0.005'
		declare @sd_alpha as varchar(MAX) = '0.006'
		declare @dur as varchar(MAX) = '7.0'
	
		select * from Utils.dbo.sample_Split(@BBType, ',')
		select * from Utils.dbo.sample_Split(@BBWeight, ',')
	
		exec GenerateProjectedFIAssetYields 'Infl,FedCredSpread,TermRPrem_7yrs,TermRPrem_15yrs,Prov_A_RatedDebtCredSpread_7yr,Prov_A_RatedDebtCredSpread_15yr,BBBCredSpread,HighYieldSpread,PrivDebt_illiquidityPrem,Mort_IG_Spread', '1,1,0,0,0,0,0,0,0,0', 'Tbills', 3, '0.075', '0', '0'
		
		exec GenerateProjectedFIAssetYields 'Infl,FedCredSpread,TermRPrem_7yrs,TermRPrem_15yrs,Prov_A_RatedDebtCredSpread_7yr,Prov_A_RatedDebtCredSpread_15yr,BBBCredSpread,HighYieldSpread,PrivDebt_illiquidityPrem,Mort_IG_Spread', '1,1,1,0,0,0,0,0,0,0', 'GoC_AAA_7yrdurbonds', 3, '0.075', '0', '0'
		exec GenerateProjectedFIAssetYields 'Infl,FedCredSpread,TermRPrem_7yrs,TermRPrem_15yrs,Prov_A_RatedDebtCredSpread_7yr,Prov_A_RatedDebtCredSpread_15yr,BBBCredSpread,HighYieldSpread,PrivDebt_illiquidityPrem,Mort_IG_Spread', '1,1,1,0,1,0,0,0,0,0', 'Prov_AAA_7yrdurbonds', 3, '0.075', '0', '0.015'
		exec GenerateProjectedFIAssetYields 'Infl,FedCredSpread,TermRPrem_7yrs,TermRPrem_15yrs,Prov_A_RatedDebtCredSpread_7yr,Prov_A_RatedDebtCredSpread_15yr,BBBCredSpread,HighYieldSpread,PrivDebt_illiquidityPrem,Mort_IG_Spread', '1,1,1,0,0,0,1,0,0,0', 'Credit_BBB_7yrdurbonds', 3, '0.075', '0.05', '0.03'

		exec GenerateProjectedFIAssetYields 'Infl,FedCredSpread,TermRPrem_7yrs,TermRPrem_15yrs,Prov_A_RatedDebtCredSpread_7yr,Prov_A_RatedDebtCredSpread_15yr,BBBCredSpread,HighYieldSpread,PrivDebt_illiquidityPrem,Mort_IG_Spread', '1,1,0,1,0,0,0,0,0,0', 'GoC_AAA_15yrdurbonds', 3, '0.075', '0', '0'
		exec GenerateProjectedFIAssetYields 'Infl,FedCredSpread,TermRPrem_7yrs,TermRPrem_15yrs,Prov_A_RatedDebtCredSpread_7yr,Prov_A_RatedDebtCredSpread_15yr,BBBCredSpread,HighYieldSpread,PrivDebt_illiquidityPrem,Mort_IG_Spread', '1,1,0,1,0,1,0,0,0,0', 'Prov_AAA_15yrdurbonds', 3, '0.075', '0', '0.02'
		exec GenerateProjectedFIAssetYields 'Infl,FedCredSpread,TermRPrem_7yrs,TermRPrem_15yrs,Prov_A_RatedDebtCredSpread_7yr,Prov_A_RatedDebtCredSpread_15yr,BBBCredSpread,HighYieldSpread,PrivDebt_illiquidityPrem,Mort_IG_Spread', '1,1,0,1,0,0,1,0,0,0', 'Credit_BBB_15yrdurbonds', 3, '0.075', '0.05', '0.04'

		exec GenerateProjectedFIAssetYields 'Infl,FedCredSpread,TermRPrem_7yrs,TermRPrem_15yrs,Prov_A_RatedDebtCredSpread_7yr,Prov_A_RatedDebtCredSpread_15yr,BBBCredSpread,HighYieldSpread,PrivDebt_illiquidityPrem,Mort_IG_Spread', '1,1,1,0,0,0,0,1,0,0', 'HighYield', 3, '0.075', '0.1', '0.12'
		exec GenerateProjectedFIAssetYields 'Infl,FedCredSpread,TermRPrem_7yrs,TermRPrem_15yrs,Prov_A_RatedDebtCredSpread_7yr,Prov_A_RatedDebtCredSpread_15yr,BBBCredSpread,HighYieldSpread,PrivDebt_illiquidityPrem,Mort_IG_Spread', '1,1,0,0,0,0,0,0,0,1', 'Mortgages', 3, '0.075', '0.03', '0.02'
		exec GenerateProjectedFIAssetYields 'Infl,FedCredSpread,TermRPrem_7yrs,TermRPrem_15yrs,Prov_A_RatedDebtCredSpread_7yr,Prov_A_RatedDebtCredSpread_15yr,BBBCredSpread,HighYieldSpread,PrivDebt_illiquidityPrem,Mort_IG_Spread', '1,1,1,0,0,0,1,0,1,0', 'PrivDebt_SunlifePrxy', 3, '0.075', '0.1', '0.04'
		exec GenerateProjectedFIAssetYields 'Infl,FedCredSpread,TermRPrem_7yrs,TermRPrem_15yrs,Prov_A_RatedDebtCredSpread_7yr,Prov_A_RatedDebtCredSpread_15yr,BBBCredSpread,HighYieldSpread,PrivDebt_illiquidityPrem,Mort_IG_Spread', '1,1,0,1,0,1,0,0,1,0', 'PrivDebt_InfraPrxy', 3, '0.075', '0.1', '0.04'		
		*/

		--Clean up the history
		delete from FI_I_AssetYields where AssumptionSetNo = @AssumptionSetNo and FIAsset = @FIAsset
		/*
		--Calculate the increase/decrease in Credit Spread / Maximum Loss
		*/
		if OBJECT_ID('tempdb..#FI_Stressed') IS NOT NULL
		drop table #FI_Stressed

		; with FI_R_StressReg
		as (
			select *
			from vw_FI_R_StressReg_Unpvt
			),
		FI_R_StressRegCdnEq
		as (
			select rco.n, rco.t, rco.AssumptionSetNo, CdnEq
			from NFI_R_Corr_Final rco	
			)

		select sr.n, sr.t, 
		   CASE WHEN sr.StressReg < @prob_sr THEN (1 - cdn.CdnEq) * @max_loss ELSE 0 END StressedLoss,
		   CASE WHEN sr.StressReg < @prob_sr THEN (1 - cdn.CdnEq) * @max_spread ELSE 0 END StressedSpread,
		   sr.AssumptionSetNo
		into #FI_Stressed
		from FI_R_StressReg sr
		inner join FI_R_StressRegCdnEq cdn on cdn.n = sr.n and cdn.t = sr.t
			and cdn.AssumptionSetNo = sr.AssumptionSetNo
		where sr.AssumptionSetNo = @AssumptionSetNo
		order by sr.t, sr.n


		/*Gerrit notes for Kris
		if OBJECT_ID('tempdb..#FI_Stressed') IS NOT NULL
		drop table #FI_Stressed

		select st.n, st.t, CASE WHEN StressReg < @prob_sr then /*Calculation*/ ELSE 0 END Loss,
						   CASE WHEN StressReg < @prob_sr then /*Calculation*/ ELSE 0 END Spread,
		into #FI_Stressed
		from vw_FI_R_StressReg_Unpvt st
		where st.AssumptionSetNo = @AssumptionSetNo
		order by st.t, st.n
		*/

		--insert statement
		--insert into FI_I_AssetYields(n, t, FIAsset, FIYield, FILoss, FISpreadIncrease, Rand_Alpha, Alpha, FI_PreLossAlphaReturn, FI_CombinedReturn, AssumptionSetNo, CreatedDate, CreatedBy)

		insert into FI_I_AssetYields(n, t, FIAsset, FIYield, FICredSprdInc, FILoss, Rand_Alpha, Alpha, FI_PreLossAlphaReturn, FI_CombinedReturn, AssumptionSetNo, CreatedDate, CreatedBy)
		select bb.n, bb.t, @FIAsset, SUM(sq2.SplitString * BBValue) + 0 + st.StressedSpread + @yield_marg, st.StressedSpread, st.StressedLoss, RAND(CHECKSUM( NEWID())), @mu_alpha + @sd_alpha * Utils.dbo.normsinv(y.Rand_Alpha), 0 + ( EXP( @dur * (0 - y.FIYield)) - 1 ), y.FI_PreLossAlphaReturn - y.FILoss + y.Alpha, bb.AssumptionSetNo, GETDATE(), ORIGINAL_LOGIN()
		from FI_I_BuildingBlocks bb
		inner join (select * from Utils.dbo.tvf_SplitString(@BBType, ',')) sq1 on sq1.SplitString = bb.BBType
		inner join (select * from Utils.dbo.tvf_SplitString(@BBWeight, ',')) sq2 on sq1.Id = sq2.Id
		inner join #FI_Stressed st on bb.n = st.n and bb.t = st.t
		inner join FI_I_AssetYields y on bb.n = y.n and bb.t = y.t
		where bb.AssumptionSetNo = @AssumptionSetNo
				and bb.t = 1
		group by bb.n, bb.t, bb.AssumptionSetNo, st.StressedSpread, st.StressedLoss, y.FILoss, y.Rand_Alpha, y.Alpha, y.FIYield, y.FI_PreLossAlphaReturn, y.FI_CombinedReturn
			union
		select bb.n, bb.t, @FIAsset, SUM(sq2.SplitString * BBValue) + (0.5 * stmin1.StressedSpread) + st.StressedSpread + @yield_marg, st.StressedSpread, st.StressedLoss, RAND(CHECKSUM( NEWID())), @mu_alpha + @sd_alpha * Utils.dbo.normsinv(y.Rand_Alpha), ymin1.FIYield + ( EXP( @dur * (ymin1.FIYield - y.FIYield)) - 1 ), y.FI_PreLossAlphaReturn - y.FILoss + y.Alpha, bb.AssumptionSetNo, GETDATE(), ORIGINAL_LOGIN()
		from FI_I_BuildingBlocks bb
		inner join (select * from Utils.dbo.tvf_SplitString(@BBType, ',')) sq1 on sq1.SplitString = bb.BBType
		inner join (select * from Utils.dbo.tvf_SplitString(@BBWeight, ',')) sq2 on sq1.Id = sq2.Id
		inner join #FI_Stressed st on bb.n = st.n and bb.t = st.t
		inner join #FI_Stressed stmin1 on bb.n = stmin1.n and bb.t = stmin1.t + 1
		inner join FI_I_AssetYields y on bb.n = y.n and bb.t = y.t
		inner join FI_I_AssetYields ymin1 on bb.n = ymin1.n and bb.t = ymin1.t + 1
		where bb.AssumptionSetNo = @AssumptionSetNo
				and bb.t > 1
		group by bb.n, bb.t, bb.AssumptionSetNo, st.StressedSpread, stmin1.StressedSpread, st.StressedLoss, y.FILoss, y.Rand_Alpha, y.Alpha, y.FIYield, ymin1.FIYield, y.FI_PreLossAlphaReturn, y.FI_CombinedReturn
		order by n, t
		
		--Generate Random Numbers for Alpha
		--Independant of anything
		

		--Calculate AC returns
		
		/*
		create nonclustered index idx_FI_I_AssetYields on FI_I_AssetYields(n, t, FIAsset, FIYield, AssumptionSetNo, CreatedDate, CreatedBy)
		*/
	end											
			
		
	--Write to Log file											
	declare @RowCnt as float = (select COUNT(*) from FI_I_AssetYields where AssumptionSetNo = @AssumptionSetNo and FIAsset = @FIAsset)											
	exec WriteLog @AssumptionSetNo, @ProcessName, @ProcessStartDate, @RowCnt, @FIAsset											
												
									
END
GO
USE [master]
GO
ALTER DATABASE [PBI_ALM_DEV] SET  READ_WRITE 
GO
