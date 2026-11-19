from dotenv import load_dotenv
import os

load_dotenv()
import mysql.connector

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password=os.getenv("MYSQL_PASSWORD"),
    database="onlinestore"
)

if conn.is_connected():
    print("MySQL Connected Successfully!")

cursor = conn.cursor()
cursor.execute("SELECT * FROM customer")

for row in cursor.fetchall():
    print(row)

cursor.close()
conn.close()