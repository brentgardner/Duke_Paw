﻿CREATE TABLE [dbo].[DailyUsageStaging]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	SupplierCode char(3) NOT NULL,
	AccountNumber varchar(8) NOT NULL,
	Tenant char(2) NOT NULL,
	CustomerNameLine1 varchar(30) NOT NULL,
	CustomerNameLine2 varchar(30) NULL,
	CustomerNameLine3 varchar(30) NULL,
	CustomerAddressLine1 varchar(30) NOT NULL,
	CustomerAddressLine2 varchar(30) NULL,
	CustomerAddressLine3 varchar(30) NULL,
	BillingPeriod varchar(10) NOT NULL,
	MeterNumber varchar(9) NOT NULL,
	MeterReadFromDate varchar(10) NOT NULL,
	MeterReadToDate varchar(10) NOT NULL,
	MeterReadStart varchar(7) NOT NULL,
	MeterReadEnd varchar(7) NOT NULL,
	GasPressureFactor varchar(5) NOT NULL,
	Usage varchar(10) NOT NULL,
	BillType char(3) NOT NULL,
	BudgetBillingIndicator char(1) NULL,
	SupplierRate char(4) NOT NULL,
	TaxName varchar(37) NOT NULL,
	ChargeAmount Varchar(12) NOT NULL,
	TaxAmount Varchar(12) NOT NULL,
	Savings Varchar(12) Null,
	BalanceReturned varchar(12) NULL,
	MoneyCollected varchar(12) NULL,
	ThirtyDayArrears varchar(11) NULL,
	SixtyDayArrears varchar(11) NULL,
	NintyDayArrears varchar(11) NULL,
	RevenuePeriod varchar(10) NOT NULL,
	SupplierBalance varchar(13) NULL,
	ProcessDate varchar(10) NOT NULL
)