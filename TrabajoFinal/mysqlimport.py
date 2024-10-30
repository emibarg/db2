import pandas as pd
from sqlalchemy import create_engine

import os




# Step 1: Load the cleaned CSV into a pandas DataFrame
df = pd.read_csv('NASA_CLEAN2.csv', low_memory=False)

# Step 2: Define MySQL connection details
username = 'root'
password = ''
host = 'localhost'  # or '127.0.0.1' or your MySQL server IP address
database = 'NASA'


# Step 3: Create a connection with a collation compatible with MariaDB
engine = create_engine(f'mysql+mysqlconnector://{username}:{password}@{host}/{database}?charset=utf8mb4&collation=utf8mb4_unicode_ci')

# Step 4: Insert the DataFrame into the MySQL table
# 'table_name' is the name of the table in MySQL where you want to insert the data
df.to_sql(name='table_name', con=engine, if_exists='replace', index=False)
#
print("Data imported successfully into MariaDB!")
