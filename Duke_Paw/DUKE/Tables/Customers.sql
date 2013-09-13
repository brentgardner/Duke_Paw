CREATE TABLE [DUKE].[Customers] (
    [Customer_ID]          INT           IDENTITY (1, 1) NOT NULL,
    [Pool]                 VARCHAR (25)  NOT NULL,
    [Status]               VARCHAR (25)  NOT NULL,
    [OpsStatus]            VARCHAR (25)  NULL,
    [BillingStatus]        VARCHAR (25)  NULL,
    [TaxCode]              BIT           NULL,
    [TaxPercent]           FLOAT (53)    NULL,
    [CustomerNumber]       VARCHAR (25)  NOT NULL,
    [AccountNumber]        VARCHAR (8)   NOT NULL,
    [TenantNumber]         VARCHAR (2)   NOT NULL,
    [Safari_ID]            VARCHAR (25)  NULL,
    [BillMethod]           VARCHAR (10)  NOT NULL,
    [MeterNumber]          NVARCHAR (25) NOT NULL,
    [UtilityAccountID]     NVARCHAR (25) NOT NULL,
    [CorporateAffiliation] NVARCHAR (75) NOT NULL,
    [TigerCustomerName]    NVARCHAR (75) NOT NULL,
    [CompanyName]          NVARCHAR (75) NOT NULL,
    [StartDate]            DATE          NULL,
    [EndDate]              DATE          NULL,
    [LastBillPeriod]       DATE          NULL,
    [LastBillStartDate]    DATE          NULL,
    [LastBillEndDate]      DATE          NULL,
    [ServiceAddress]       VARCHAR (100) NULL,
    [ServiceCity]          VARCHAR (50)  NULL,
    [ServiceState]         CHAR (2)      NULL,
    [ServicePostalCode]    VARCHAR (10)  NULL,
    [Email]                VARCHAR (75)  NULL,
    [BusinessPhone]        VARCHAR (11)  NULL,
    [Comments]             VARCHAR (255) NULL,
    [CreatedAt]            DATETIME      CONSTRAINT [DF_Customers_CreatedAt] DEFAULT (getdate()) NOT NULL,
    [UpdatedAt]            DATETIME      NULL,
    CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([Pool] ASC, [AccountNumber] ASC, [TenantNumber] ASC, [MeterNumber] ASC)
);


GO
-- =============================================
-- Author:		Brent Gardner
-- Create date: 
-- Description:	Handle updates to customer table
-- =============================================
CREATE TRIGGER [DUKE].[t_CustomerChangeAudit]
   ON  DUKE.Customers 
   FOR INSERT,DELETE,UPDATE
AS 
BEGIN
	declare @Icount int, @Dcount int;
	select @Icount = count(*) from Inserted;
	select @Dcount = count(*) from Deleted;
	
  IF @@ROWCOUNT<0 RETURN
    IF UPDATE([UpdatedAt])
		RETURN
	IF UPDATE([CreatedAt])
		RETURN
  if @Icount + @Dcount = 0
    return;
  if @Dcount = 0 begin
    -- Insert operation
    INSERT INTO [DUKE].[Customers_History]
           ([EditDate]
			,[EditUser]
			,[ChangeAction]
			,[Customer_ID]
			,[Pool]
			,[Status]
			,[OpsStatus]
			,[BillingStatus]
			,[TaxCode]
			,[TaxPercent]
			,[CustomerNumber]
			,[AccountNumber]
			,[TenantNumber]
			,[Safari_ID]
			,[BillMethod]
			,[MeterNumber]
			,[UtilityAccountID]
			,[CorporateAffiliation]
			,[TigerCustomerName]
			,[CompanyName]
			,[StartDate]
			,[EndDate]
			,[LastBillPeriod]
			,[LastBillStartDate]
			,[LastBillEndDate]
			,[ServiceAddress]
			,[ServiceCity]
			,[ServiceState]
			,[ServicePostalCode]
			,[Email]
			,[BusinessPhone]
			,[Comments]
			,[CreatedAt]
			,[UpdatedAt])
    SELECT GetDate(), 
	SYSTEM_USER, 
	'I', 
      C.[Customer_ID]
      ,C.[Pool]
      ,C.[Status]
      ,C.[OpsStatus]
      ,C.[BillingStatus]
      ,C.[TaxCode]
      ,C.[TaxPercent]
      ,C.[CustomerNumber]
      ,C.[AccountNumber]
      ,C.[TenantNumber]
      ,C.[Safari_ID]
      ,C.[BillMethod]
      ,C.[MeterNumber]
      ,C.[UtilityAccountID]
      ,C.[CorporateAffiliation]
      ,C.[TigerCustomerName]
      ,C.[CompanyName]
      ,C.[StartDate]
      ,C.[EndDate]
      ,C.[LastBillPeriod]
	  ,C.[LastBillStartDate]
	  ,C.[LastBillEndDate]
      ,C.[ServiceAddress]
      ,C.[ServiceCity]
      ,C.[ServiceState]
      ,C.[ServicePostalCode]
      ,C.[Email]
      ,C.[BusinessPhone]
      ,C.[Comments]
      ,C.[CreatedAt]
      ,C.[UpdatedAt]
	FROM Inserted C
  end;
  else if @ICount = 0 begin
    -- Delete operation
    INSERT INTO [DUKE].[Customers_History]
           ([EditDate]
			,[EditUser]
			,[ChangeAction]
			,[Customer_ID]
			,[Pool]
			,[Status]
			,[OpsStatus]
			,[BillingStatus]
			,[TaxCode]
			,[TaxPercent]
			,[CustomerNumber]
			,[AccountNumber]
			,[TenantNumber]
			,[Safari_ID]
			,[BillMethod]
			,[MeterNumber]
			,[UtilityAccountID]
			,[CorporateAffiliation]
			,[TigerCustomerName]
			,[CompanyName]
			,[StartDate]
			,[EndDate]
			,[LastBillPeriod]
			,[LastBillStartDate]
			,[LastBillEndDate]
			,[ServiceAddress]
			,[ServiceCity]
			,[ServiceState]
			,[ServicePostalCode]
			,[Email]
			,[BusinessPhone]
			,[Comments]
			,[CreatedAt]
			,[UpdatedAt])
    SELECT GetDate(), 
	SYSTEM_USER, 
	'D', 
      C.[Customer_ID]
      ,C.[Pool]
      ,C.[Status]
      ,C.[OpsStatus]
      ,C.[BillingStatus]
      ,C.[TaxCode]
      ,C.[TaxPercent]
      ,C.[CustomerNumber]
      ,C.[AccountNumber]
      ,C.[TenantNumber]
      ,C.[Safari_ID]
      ,C.[BillMethod]
      ,C.[MeterNumber]
      ,C.[UtilityAccountID]
      ,C.[CorporateAffiliation]
      ,C.[TigerCustomerName]
      ,C.[CompanyName]
      ,C.[StartDate]
      ,C.[EndDate]
      ,C.[LastBillPeriod]
	  ,C.[LastBillStartDate]
	  ,C.[LastBillEndDate]
      ,C.[ServiceAddress]
      ,C.[ServiceCity]
      ,C.[ServiceState]
      ,C.[ServicePostalCode]
      ,C.[Email]
      ,C.[BusinessPhone]
      ,C.[Comments]
      ,C.[CreatedAt]
      ,C.[UpdatedAt]
	FROM deleted C;

  end;
  else begin
    -- Update operation
    INSERT INTO [DUKE].[Customers_History]
           ([EditDate]
			,[EditUser]
			,[ChangeAction]
			,[Customer_ID]
			,[Pool]
			,[Status]
			,[OpsStatus]
			,[BillingStatus]
			,[TaxCode]
			,[TaxPercent]
			,[CustomerNumber]
			,[AccountNumber]
			,[TenantNumber]
			,[Safari_ID]
			,[BillMethod]
			,[MeterNumber]
			,[UtilityAccountID]
			,[CorporateAffiliation]
			,[TigerCustomerName]
			,[CompanyName]
			,[StartDate]
			,[EndDate]
			,[LastBillPeriod]
			,[LastBillStartDate]
			,[LastBillEndDate]
			,[ServiceAddress]
			,[ServiceCity]
			,[ServiceState]
			,[ServicePostalCode]
			,[Email]
			,[BusinessPhone]
			,[Comments]
			,[CreatedAt]
			,[UpdatedAt])
    SELECT GetDate(), 
	SYSTEM_USER, 
	'U', 
	C.[Customer_ID]
      ,C.[Pool]
      ,C.[Status]
      ,C.[OpsStatus]
      ,C.[BillingStatus]
      ,C.[TaxCode]
      ,C.[TaxPercent]
      ,C.[CustomerNumber]
      ,C.[AccountNumber]
      ,C.[TenantNumber]
      ,C.[Safari_ID]
      ,C.[BillMethod]
      ,C.[MeterNumber]
      ,C.[UtilityAccountID]
      ,C.[CorporateAffiliation]
      ,C.[TigerCustomerName]
      ,C.[CompanyName]
      ,C.[StartDate]
      ,C.[EndDate]
      ,C.[LastBillPeriod]
	  ,C.[LastBillStartDate]
	  ,C.[LastBillEndDate]
      ,C.[ServiceAddress]
      ,C.[ServiceCity]
      ,C.[ServiceState]
      ,C.[ServicePostalCode]
      ,C.[Email]
      ,C.[BusinessPhone]
      ,C.[Comments]
      ,C.[CreatedAt]
      ,C.[UpdatedAt]
	FROM Deleted C;
  end;
end;

GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [DUKE].[T_CustomerUpdate] 
   ON  DUKE.Customers
   For UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	IF @@ROWCOUNT<0 RETURN
	
	IF UPDATE([UpdatedAt])
		RETURN
	IF UPDATE([CreatedAt])
		RETURN
	Else	
		UPDATE C SET UpdatedAt = GETDATE()
		FROM Customers C INNER JOIN INSERTED I ON C.Customer_ID = I.Customer_ID


END
