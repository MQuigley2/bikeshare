#Collection of functions for interfacing with bikeshare database
import os
import mysql.connector
from mysql.connector import errorcode
import pandas as pd


mysql_pass=os.environ.get('mysql_password')
#password stored as environment variable for security


db_connection_str = f'mysql+mysqlconnector://root:{mysql_pass}@localhost/bike_share'



def establish_connection(func):
    def wrapper(*args,**kwargs):

        try:
            connection = mysql.connector.connect(user='root',
                                                password=mysql_pass,
                                                host='localhost',
                                                database='bike_share')
            result=func(connection,*args,**kwargs)
            connection.close()
        except mysql.connector.Error as err:
            if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
                print("Something is wrong with your user name or password")
            elif err.errno == errorcode.ER_BAD_DB_ERROR:
                print("Database does not exist")
            else:
                print(err)
        else:
            connection.close()
        return result
    return wrapper


def exec_query(query,*args,**kwargs):
    return pd.read_sql(query, con=db_connection_str,*args,**kwargs)
#Runs SQL query on bikeshare database and returns pandas df


def station_lookup(id):
    query=f"""
    SELECT *
    FROM stations 
    WHERE station_id={id}"""
    return pd.read_sql(query, con=db_connection_str)
#Runs common query for a given station id


def run_sql(query):
    try:
        connection = mysql.connector.connect(user='root',
                                             password=mysql_pass,
                                             host='localhost',
                                             database='bike_share')
        cursor=connection.cursor()
        cursor.execute(query)
        cursor.close()
        connection.close()
    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("Something is wrong with your user name or password")
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print("Database does not exist")
        else:
            print(err)
    else:
        connection.close()
#More generalized function for DDL and DML statements. Does not return any output


@establish_connection
def run_multiple_sql(connection,queries):

    for query in queries[0:-1]:
        cursor=connection.cursor()
        cursor.execute(query)
        cursor.close()
    cursor=connection.cursor()
    cursor.execute(queries[-1])
    result=pd.DataFrame(cursor.fetchall())
    cursor.close()
    return result

