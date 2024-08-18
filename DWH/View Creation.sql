IF OBJECT_ID('DWH_Dim.Customer_vw', 'V') IS NOT NULL
BEGIN
    DROP VIEW [DWH_Dim].[Customer_vw]
END
GO

CREATE VIEW [DWH_Dim].[Customer_vw]
AS
SELECT [Name]
    ,[Phone]
    ,[AddressLine1]
    ,[AddressLine2]
    ,[City]
    ,[State]
    ,[PostalCode]
    ,[Country]
FROM [DWH_Dim].[Customer];
GO