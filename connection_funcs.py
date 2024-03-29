#Collection of functions for interfacing with bikeshare database
import os
import mysql.connector
from mysql.connector import errorcode
import pandas as pd
from functools import wraps


mysql_pass=os.environ.get('mysql_password')
#password stored as environment variable for security


db_connection_str = f'mysql+mysqlconnector://root:{mysql_pass}@localhost/bike_share'





def establish_connection(func):
    def wrapper(*args,**kwargs):
        result=None
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
#decorator function for connecting with database



def exec_query(query,*args,**kwargs):
    return pd.read_sql(query, con=db_connection_str,*args,**kwargs)
#Uses pandas built in function to query bikeshare database


def station_lookup(id):
    query=f"""
    SELECT *
    FROM stations 
    WHERE station_id={id}"""
    return exec_query(query)
#Executes common query, less verbose than using stored procedure




def cursor_execute(connection,query):
    cursor=connection.cursor()
    cursor.execute(query)
    result=pd.DataFrame(cursor.fetchall(),columns=cursor.column_names)
    cursor.close()
    return result



@establish_connection
def run_sql(connection,query):
    result=cursor_execute(connection,query)
    return result
#Performs the same role as exec_query, but using pandas built in read_sql function leads to errors for certain querries using stored procedures


@establish_connection
def run_multiple_sql(connection,queries,return_index=-1):

    for index,query in enumerate(queries):

        if index == return_index:
            result=cursor_execute(connection,query)
        else:
            cursor_execute(connection,query)
    return result
#Takes list of SQL statement, executes them in order and outputs the result of the query specified by return_index

