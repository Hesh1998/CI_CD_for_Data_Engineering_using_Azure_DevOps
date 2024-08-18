-- Creates a schema for log tables
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'log')
BEGIN
    EXEC ('CREATE SCHEMA log')
END

-- Creates LakeLogs table
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'LakeLogs' AND TABLE_SCHEMA = 'log')
BEGIN
    EXEC('
        CREATE TABLE [log].[LakeLogs](
			[Id] [int] IDENTITY(1,1) NOT NULL,
			[Key] [varchar](50) NOT NULL,
			[Value] [varchar](100) NOT NULL
		)
    ')
END