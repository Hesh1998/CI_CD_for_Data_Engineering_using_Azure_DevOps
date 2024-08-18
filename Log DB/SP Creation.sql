-- This SP is used to retrieve values from the [log].[LakeLogs] table based on the key value passed as a parameter
IF OBJECT_ID('log.LakeLogs_S', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [log].[LakeLogs_S];
END
GO

CREATE PROCEDURE [log].[LakeLogs_S] @Key VARCHAR(50)
AS
	SELECT [Value] FROM [log].[LakeLogs] WHERE [Key] = @Key;
RETURN 0
GO