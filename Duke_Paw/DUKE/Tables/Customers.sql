CREATE TABLE [DUKE].[Customers](
	[Customer_ID] [int] IDENTITY(1,1) NOT NULL,
	[Pool] [varchar](25) NOT NULL,
	[Status] [varchar](25) NOT NULL,
	[OpsStatus] [varchar](25) NULL,
	[BillingStatus] [varchar](25) NULL,
	[TaxCode] [bit] NULL,
	[TaxPercent] [float] NULL,
	[CustomerNumber] [varchar](25) NOT NULL,
	[AccountNumber] [varchar](8) NOT NULL,
	[TenantNumber] [varchar](2) NOT NULL,
	[Safari_ID] [varchar](25) NULL,
	[BillMethod] [varchar](10) NOT NULL,
	[RateId] [int] NULL,
	[MeterNumber] [nvarchar](25) NOT NULL,
	[UtilityAccountID] [nvarchar](25) NOT NULL,
	[CorporateAffiliation] [nvarchar](75) NOT NULL,
	[TigerCustomerName] [nvarchar](75) NOT NULL,
	[CompanyName] [nvarchar](75) NOT NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[LastBillPeriod] [date] NULL,
	[LastBillStartDate] [date] NULL,
	[LastBillEndDate] [date] NULL,
	[ServiceAddress1] [varchar](30) NULL,
	[ServiceAddress2] [varchar](30) NULL,
	[ServiceCity] [varchar](30) NULL,
	[ServiceState] [char](2) NULL,
	[ServicePostalCode] [varchar](10) NULL,
	[Email] [varchar](75) NULL,
	[BusinessPhone] [varchar](11) NULL,
	[Comments] [varchar](255) NULL,
	[CreatedAt] [datetime] NOT NULL  DEFAULT GETDATE(),
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[Pool] ASC,
	[AccountNumber] ASC,
	[TenantNumber] ASC,
	[MeterNumber] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
-- =============================================
-- Author:		Brent Gardner
-- Create date: 
-- Description:	Handle updates to customer table
-- =============================================
CREATE TRIGGER [DUKE].[t_CustomerChangeAudit]
   ON  [DUKE].[Customers] 
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
    INSERT INTO [Duke_Paw].[DUKE].[Customers_History]
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
			,[ServiceAddress1]
			,[ServiceAddress2]
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
      ,C.[ServiceAddress1]
      ,C.[ServiceAddress2]
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
    INSERT INTO [Duke_Paw].[DUKE].[Customers_History]
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
			,[ServiceAddress1]
			,[ServiceAddress2]
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
      ,C.[ServiceAddress1]
      ,C.[ServiceAddress2]
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
			,[ServiceAddress1]
			,[ServiceAddress2]
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
      ,C.[ServiceAddress1]
      ,C.[ServiceAddress2]
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
