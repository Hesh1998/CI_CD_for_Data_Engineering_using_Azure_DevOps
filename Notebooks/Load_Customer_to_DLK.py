# Databricks notebook source
# 1) Gets the username and password of an account with full access(read/write) to the SharePoint site. This username and password is saved in Azure key vault.

sharepoint_usr = dbutils.secrets.get(scope = 'KV-Secret', key = 'SharePoint-Usr')
sharepoint_pwd = dbutils.secrets.get(scope = 'KV-Secret', key = 'SharePoint-Pwd')

# COMMAND ----------

# 2) Connects to the SharePoint site, read the csv file and get the csv file into a pandas dataframe

# Install sharepy library seperately to the cluster used
# json and pandas libraries are by default available in the cluster, so no need to install seperately
import sharepy
import json
import pandas as pd

# Authenticate
s = sharepy.connect('https://klnaclk.sharepoint.com',username=sharepoint_usr, password=sharepoint_pwd)

file_url = 'https://klnaclk.sharepoint.com/sites/dwhsource/Shared%20Documents/Customers.csv'

filename = 'Customers.csv'

r = s.getfile(file_url, filename=filename)
df = pd.read_csv(filename)
df = spark.createDataFrame(df.astype(str))

# COMMAND ----------

# 3) Prints the contents of the dataframe

display(df)

# COMMAND ----------

# 4) Dbutils widget created to get the folder path to save the parquet file in the data lake. A value can be passed as a parameter for this widget.

# path - customer
dbutils.widgets.text('path', '')
path = dbutils.widgets.get('path')
print(path)

# COMMAND ----------

# 5) Writes the dataframe in parquet format to the data lake

# Access key and storage account name used to connect to the data lake
# This value is saved in the Azure key vault
str_key = dbutils.secrets.get(scope = 'KV-Secret', key = 'DLK-Key')
str_name = dbutils.secrets.get(scope = 'KV-Secret', key = 'DLK-Name')

spark.conf.set(
  str_name,
  str_key
)

# Data lake folder path where we want to write the parquet file
target_folder_path = dbutils.secrets.get(scope = 'KV-Secret', key = 'DLK-Container') + path

df.coalesce(1).write.mode('overwrite').option('header','false').parquet(target_folder_path)
