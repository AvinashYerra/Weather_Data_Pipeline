import os
import json
import time
import requests
from kafka import KafkaProducer
from dotenv import load_dotenv

load_dotenv()  # Loads from .env file

API_KEY = os.getenv("OPENWEATHER_API_KEY")
CITIES = ["New York", "London", "Tokyo"]
KAFKA_TOPIC = "weather_data"
KAFKA_SERVER = "localhost:9092"

producer = KafkaProducer(
    bootstrap_servers=KAFKA_SERVER,
    value_serializer=lambda v: json.dumps(v).encode('utf-8')
)

while True:
    for CITY in CITIES:
        url = f"http://api.openweathermap.org/data/2.5/weather?q={CITY}&appid={API_KEY}"
        response = requests.get(url).json()
        weather_data = {
            "city": CITY,
            "temperature": response["main"]["temp"],
            "humidity": response["main"]["humidity"],
            "description": response["weather"][0]["description"]
        }
        producer.send(KAFKA_TOPIC, weather_data)
        print(f"Sent: {weather_data}")
    
    time.sleep(600)
