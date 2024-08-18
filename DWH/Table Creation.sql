-- Creates DWH_Dim Schema
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'DWH_Dim')
BEGIN
    EXEC ('CREATE SCHEMA DWH_Dim')
END

-- Creates Customer table
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Customer' AND TABLE_SCHEMA = 'DWH_Dim')
BEGIN
    EXEC('
        CREATE TABLE [DWH_Dim].[Customer]
		(
			[Name] [varchar](50) NOT NULL,
			[Phone] [varchar](20) NOT NULL,
			[AddressLine1] [varchar](50) NOT NULL,
			[AddressLine2] [varchar](50) NULL,
			[City] [varchar](50) NOT NULL,
			[State] [varchar](50) NULL,
			[PostalCode] [varchar](20) NULL,
			[Country] [varchar](50) NOT NULL
		)
		WITH
		(
			DISTRIBUTION = REPLICATE
		)
    ')
END