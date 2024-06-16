from psycopg2.extras import RealDictCursor
import psycopg2

DB_PARAMS = {
    'database':"credit_hub",
    'user':"postgres",
    'password':"123456",  
    'host':"localhost", 
    'port':"5432"
}

def get_db_connection():
    conn = psycopg2.connect(**DB_PARAMS)
    return conn