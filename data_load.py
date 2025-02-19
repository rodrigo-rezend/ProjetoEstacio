import pandas as pd

# Snowflake connector libraries
import snowflake.connector as snow
from snowflake.connector.pandas_tools import write_pandas


# Conexao com o banco de dados
def create_connection():
   conn = snow.connect(user="testuser",
   password="testpwd!",
   account="snowflake account",
   warehouse="DEMO_WH",
   database="DEMO_DB",
   schema="DBT_RAW")
   cursor = conn.cursor()
   print('SQL Connection Created')
   return cursor,conn

def truncate_table():
   cur,conn=create_connection()
   sql_titles = "TRUNCATE TABLE IF EXISTS TITLES_RAW"
   sql_credits = "TRUNCATE TABLE IF EXISTS CREDITS_RAW"
   cur.execute(sql_titles)
   cur.execute(sql_credits)
   print('Tables truncated')

# Puxar as informaçoes e subir no banco
def load_data():
   cur,conn=create_connection()
   titles_file = r"C:\Users\rodri\Downloads\ProjetoEstacio\Data" 
   titles_delimiter = ","
   credits_file=r"C:\Users\rodri\Downloads\ProjetoEstacio\Data"
   credits_delimiter=","

   titles_df = pd.read_csv(titles_file, sep = titles_delimiter)
   print("Titles file read")
   credits_df = pd.read_csv(credits_file, sep = titles_delimiter)
   print("Credits file read")

   write_pandas(conn, titles_df, "TITLES",auto_create_table=True)
   print('Titles file loaded')
   write_pandas(conn, credits_df, "CREDITS",auto_create_table=True)
   print('Credits file loaded')

   cur = conn.cursor()


   # Close your cursor and your connection.
   cur.close()
   conn.close()

print("Starting Script")
truncate_table()
load_data()



