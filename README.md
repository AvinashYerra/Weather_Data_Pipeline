# Real-Time Weather Data Pipeline
This project streams weather data from the OpenWeatherMap API to Apache Kafka and stores it in a PostgreSQL database.

## Components
- `producer.py`: Fetches weather data and sends to Kafka.
- `consumer.py`: Reads from Kafka and inserts into PostgreSQL.
- `.env`: Stores API keys and connection strings (excluded from version control).
- `analysis.sql`: SQL scripts for data analysis.
- `requirements.txt`: Python dependencies.

## Setup
    1.Project Directory Setup
    2.Install the requirements
    3.Python Installation
    4.go to Python Virtual environment
    5.Install Dependencies
    6.Install Kafka and Extract It
    7.Kafka 4.0.0 doesnt have zookeeper with it, so now we have 2 options:
      - Use lower Kafka version
      - Use WSL Linux setup
    8.Initiate Zookeepr and Kafka server in two cmds
    9.Create a kafka topic 
    10.Initialize the Producer and Consumer , now the input sent through the P will appear on C
    11.Install PostgreSQL and setup the Database and tables required
    12.Then run the .py files which helps executing the pipeling every 10m
    13.You can also use this data and then feed it into dashboard to create visualizations
