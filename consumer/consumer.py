import os
import json
import psycopg2
from kafka import KafkaConsumer
from dotenv import load_dotenv

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")
KAFKA_TOPIC = os.getenv("KAFKA_TOPIC", "weather_data")
KAFKA_SERVER = os.getenv("KAFKA_SERVER", "localhost:9092")

consumer = KafkaConsumer(
    KAFKA_TOPIC,
    bootstrap_servers=KAFKA_SERVER,
    value_deserializer=lambda x: json.loads(x.decode('utf-8'))
)

conn = psycopg2.connect(DATABASE_URL)
cur = conn.cursor()

cur.execute("""
    CREATE TABLE IF NOT EXISTS weather (
        city TEXT,
        temperature FLOAT,
        humidity INT,
        description TEXT,
        timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
""")
conn.commit()

for msg in consumer:
    data = msg.value
    cur.execute(
        "INSERT INTO weather (city, temperature, humidity, description) VALUES (%s, %s, %s, %s)",
        (data["city"], data["temperature"], data["humidity"], data["description"])
    )
    conn.commit()
    print(f"Inserted: {data}")
