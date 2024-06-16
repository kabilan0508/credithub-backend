from flask import Flask, jsonify, request
from psycopg2.extras import RealDictCursor
import psycopg2
from auth import auth

app = Flask(__name__)
userid = ''


# Replace these with your MySQL database credentials
# conn = psycopg2.connect(database="credit_hub",  
#                         user="postgres", 
#                         password="123456",  
#                         host="localhost", port="5432") 
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
# # Create a connection to the database
# conn = mysql.connector.connect(**db_config)
# cursor = conn.cursor()


# API route to fetch data from the database
@app.route('/', methods=['GET'])
def get_data():
    try:
        conn = get_db_connection()
        cur = conn.cursor(cursor_factory=RealDictCursor)
        cur.execute('''SELECT rid,uname FROM usermgmt.users limit 1''') 
  
        # Fetch the data 
        data = cur.fetchall() 
        print(data)
        # close the cursor and connection 
        cur.close()

        return jsonify(data)

    except Exception as e:
        return jsonify({'error': str(e)})


# API route to insert data into the database
@app.route('/login', methods=['POST'])
def insert_data():
    try:
        conn = get_db_connection()
        cur = conn.cursor(cursor_factory=RealDictCursor)
        data = request.json
        query = '''SELECT * FROM usermgmt.users WHERE uname = %s AND password = %s AND is_deleted = false''' 
        cur.execute(query,(data['uname'],data['password'])) 
  
        # Fetch the data 
        data = cur.fetchone()
        # userid = data[0][0]
        # data[]
        return jsonify(data)

    except Exception as e:
        return jsonify({'error': str(e)})


@app.route('/api/token', methods=['POST'])
def token_generation():
    try:
        return auth.generate_token(5)
    except Exception as e:
        return jsonify({'error': str(e)})


if __name__ == '__main__':
    app.run(debug=True)
