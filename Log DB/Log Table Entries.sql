-- Lake folder path
MERGE [log].[LakeLogs] AS target
USING (SELECT 'cust_lake_path' AS [Key], 'customer' AS [Value]) AS source
ON (target.[Key] = source.[Key])
WHEN MATCHED THEN
    UPDATE SET 
    target.[Value] = source.[Value]
WHEN NOT MATCHED THEN
    INSERT ([Key], [Value])
    VALUES (source.[Key], source.[Value]);

-- DWH Table schema
MERGE [log].[LakeLogs] AS target
USING (SELECT 'cust_schema' AS [Key], 'DWH_Dim' AS [Value]) AS source
ON (target.[Key] = source.[Key])
WHEN MATCHED THEN
    UPDATE SET 
    target.[Value] = source.[Value]
WHEN NOT MATCHED THEN
    INSERT ([Key], [Value])
    VALUES (source.[Key], source.[Value]);

-- DWH Table name
MERGE [log].[LakeLogs] AS target
USING (SELECT 'cust_table' AS [Key], 'Customer' AS [Value]) AS source
ON (target.[Key] = source.[Key])
WHEN MATCHED THEN
    UPDATE SET 
    target.[Value] = source.[Value]
WHEN NOT MATCHED THEN
    INSERT ([Key], [Value])
    VALUES (source.[Key], source.[Value]);