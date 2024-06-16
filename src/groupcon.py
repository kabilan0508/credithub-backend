from src import dbconnect as db
from psycopg2.extras import RealDictCursor


def addgroup(data):
    try:
        conn = db.get_db_connection()
        cur = conn.cursor(cursor_factory=RealDictCursor)
        gname = data['groupname']
        gdesc = data['groupdesc']

         # Define the SQL INSERT statement
        insert_query = """
        INSERT INTO usermgmt.group_info (name, descr)
        VALUES (%s, %s)
        """
        
        # Execute the SQL statement with the provided values
        cur.execute(insert_query, (gname, gdesc))
        
        # Commit the transaction to save changes
        conn.commit()
        
        # Close the cursor and connection
        cur.close()
        conn.close()

        return {'status': 'success', 'mesage':'Successfully created group'}

        
    except Exception as e:
        return {'error': str(e)}