import pandas as pd
import mysql.connector

# Step 1: Extract
df = pd.read_csv("C:\\Users\\owner\\OneDrive\\Desktop\\Pizza_sales_DE\\pizza_sales (1).csv")

# Step 2: Transform
df.dropna(inplace=True)
df['order_date'] = pd.to_datetime(df['order_date'], dayfirst=True).dt.date

df['order_time'] = pd.to_datetime(df['order_time'], format="%H:%M:%S").dt.time


df['total_price'] = df['quantity'] * df['unit_price']

# ✅ Set up connection safely
conn = None
try:
    conn = mysql.connector.connect(
        host='localhost',
        port=3306,
        user='root',
        password='Sindhu@13',  # 👈 Replace with what you typed into Workbench
        database='pizza_sales_db'
    )
    cursor = conn.cursor()

    for _, row in df.iterrows():
        cursor.execute("""
            INSERT INTO pizza_orders (
                order_id, order_date, order_time, pizza_id,
                quantity, unit_price, total_price,
                pizza_category, pizza_size, pizza_ingredients, pizza_name
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (
            int(row['order_id']), row['order_date'], row['order_time'], row['pizza_id'],
            int(row['quantity']), float(row['unit_price']), float(row['total_price']),
            row['pizza_category'], row['pizza_size'], row['pizza_ingredients'], row['pizza_name']
        ))

    conn.commit()
    print("✅ Data loaded into MySQL successfully!")

except mysql.connector.Error as err:
    print(f"❌ MySQL Error: {err}")

finally:
    if conn and conn.is_connected():
        cursor.close()
        conn.close()

print(df.head())

