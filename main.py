from flask import Flask, jsonify, request
import mysql.connector

app = Flask(__name__)

# Replace these with your MySQL database credentials
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'credithub'
}

# Create a connection to the database
conn = mysql.connector.connect(**db_config)
cursor = conn.cursor()


# API route to fetch data from the database
@app.route('/api/data', methods=['GET'])
def get_data():
    try:
        query = "SELECT * FROM users"
        cursor.execute(query)
        data = cursor.fetchall()

        # Convert the result to a list of dictionaries
        result = []
        for row in data:
            result.append({
                'id': row[0],
                'column1': row[1],
                'column2': row[2],
                # Add more columns as needed
            })

        return jsonify(result)

    except Exception as e:
        return jsonify({'error': str(e)})


# API route to insert data into the database
@app.route('/api/data', methods=['POST'])
def insert_data():
    try:
        data = request.json
        query = "INSERT INTO your_table (column1, column2) VALUES (%s, %s)"
        cursor.execute(query, (data['column1'], data['column2']))
        conn.commit()

        return jsonify({'message': 'Data inserted successfully'})

    except Exception as e:
        return jsonify({'error': str(e)})


if __name__ == '__main__':
    app.run(debug=True)
