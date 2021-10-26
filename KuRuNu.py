import subprocess as sp
import pymysql
import pymysql.cursors
from prettytable import PrettyTable

def print_table(json_dump):
    table = PrettyTable()
    table.field_names = json_dump[0].keys()
    for row in json_dump:
        table.add_row(row.values())
    print(table)
def TakeInput(attributes: list = [], datatype: list = []):
    """
    Function to take input conveniently
    """
    inputlist = {}
    for index, item in enumerate(attributes):
        value = input('Enter ' + item + ' of type ' + datatype[index] + ': ')
        inputlist[item] = value
    return inputlist


def SearchTeam():
    try:
        num = int(input("Enter the team number: "))
        query = "SELECT * FROM TEAM WHERE Team_No=%d" % (num)
        num = cur.execute(query)
        if num == 0:
            print("There are no results for this query")
        else:
            print_table(cur.fetchall())
    except Exception as e:
        con.rollback()
        print("Failed to Select")
        
def SearchHacker():
    try:
        Fname, Lname = '', ''
        try:
            Fname = input('Enter FirstName: ')
            Fname = '%' + Fname + '%'
        except:
            Fname = '%%'
        try:
            Lname = input('Enter LastName: ')
            Lname = '%' + Lname + '%'
        except:
            Lname = '%%'
        query = "SELECT * FROM HACKER WHERE First_Name LIKE '%s' AND Last_Name LIKE '%s'" % (Fname, Lname)
        num = cur.execute(query)
        if num == 0:
            print("There are no results for this query")
        else:
            print_table(cur.fetchall())

    except Exception as e:
        print("Failed to Select")
                        
def FirstSolve():
    try:
        query = "DROP VIEW IF EXISTS V1"
        cur.execute(query)
        query = "DROP VIEW IF EXISTS V2"
        cur.execute(query)
        ConID = int(input('Enter ContestID: '))
        query = "CREATE VIEW V1 AS SELECT Prob_Number, Team_No, Sub_Time FROM SUBMISSION NATURAL JOIN SUBMITS WHERE VERDICT='CORRECT' AND Contest_ID=%d" % (ConID)
        cur.execute(query)
        query = "CREATE VIEW V2 AS SELECT Prob_Number,MIN(Sub_Time) AS Sub_Time FROM SUBMISSION NATURAL JOIN SUBMITS WHERE VERDICT='CORRECT' AND Contest_ID=%d GROUP BY Prob_Number" % (ConID)
        cur.execute(query)
        query = "SELECT Team_No,Team_Name,Prob_Number,Sub_Time FROM V1 NATURAL JOIN V2 NATURAL JOIN TEAM ORDER BY Prob_Number"
        num = cur.execute(query)
        if num == 0:
            print("There are no results for this query")
        else:
            print_table(cur.fetchall())
        query = "DROP VIEW IF EXISTS V1, V2"
        cur.execute(query)
    except Exception as e:
        print("Failed to Select")

def LeastInc():
    try:
        query = "DROP VIEW IF EXISTS V1"
        cur.execute(query)
        con = int(input("Enter the Contest ID:"))
        prob = int(input("Enter the problem number:"))
        query = "CREATE VIEW V1 AS SELECT Team_No ,COUNT(Team_No) AS mycount FROM SUBMITS  WHERE Contest_ID=%d AND Prob_Number=%d AND Verdict='WRONG' GROUP BY Team_No" % (con,prob)
        cur.execute(query)
        query = "SELECT Team_No,MIN(mycount) As Incorrect from V1 GROUP BY Team_No"
        num = cur.execute(query)
        if num == 0:
            print("There are no results for this query")
        else:
            print_table(cur.fetchall())
        query = "DROP VIEW IF EXISTS V1"
        cur.execute(query)
    except Exception as e:
        print("Failed to Select")       
def projectHackers():
    try:
        query = 'SELECT DISTINCT CONTESTANT.Hacker_ID, HACKER.First_Name, HACKER.Last_Name FROM CONTESTANT JOIN SUBMITS ON SUBMITS.Team_No = CONTESTANT.Team_No JOIN HACKER ON CONTESTANT.Hacker_ID = HACKER.Hacker_ID'
        num = cur.execute(query)
        if num == 0:
            print("No hacker solved a single problem ever")
        else:
            print_table(cur.fetchall())
    except Exception as e:
        print("Failed to perform Projection query")
        
def averageTime():
    try:
        Cid = int(input('Enter Contest ID: '))
        query1 = "SELECT Prob_Number, SEC_TO_TIME(AVG(TIME_TO_SEC(Sub_Time))) AverageTime FROM SUBMITS NATURAL JOIN SUBMISSION WHERE VERDICT='CORRECT' AND Contest_ID=%d GROUP BY Prob_Number" % (
            Cid)
        num = cur.execute(query1)
        if num == 0:
            print("There are no results for this query")
        else:
            print_table(cur.fetchall())
    except Exception as e:
        print("Failed to perform Aggregatio query")
    
def listAdultHackers():
    """
    Function to list all hacker who are above 18 years old
    """
    try:
        query = 'SELECT Hacker_ID ,First_Name, Last_Name, Age FROM HACKER WHERE Age >= 18'
        num = cur.execute(query)
        if num == 0:
            print("No hackers above the age of 18")
        else:
            print_table(cur.fetchall())
    except Exception as e:
        print("Failed to perform SELECT query")


def listTeams():
    """
    Function to list all teams participating in a contest
    """
    try:
        contestID = int(input('Enter Contest ID: '))
        query = 'SELECT T.Team_No, Team_Name FROM TEAM T INNER JOIN PARTICIPATES P ON T.Team_No = P.Team_No WHERE P.Contest_ID = %d' % (
            contestID)
        num = cur.execute(query)
        if num == 0:
            print("No teams participated in this contest")
        else:
            print_table(cur.fetchall())
    except Exception as e:
        print("Failed to perform SELECT query")

def InsertHacker():
    """
    Inserts Hacker Details to the Table
    """
    try:
        # Takes emplyee details as input
        row = TakeInput(['Hacker_ID','Fname','Lname','Age','email'],['INT','STRING','STRING','INT','STRING'])
        is_setter=int(input('Is the user a problem setter, [0]=NO [1]=YES '))
        if(is_setter != 0 and is_setter !=1):
            print("Invalid Input")
            return
        row['is_Setter']=is_setter
        query = "INSERT INTO HACKER(Hacker_ID,First_Name,Last_Name,Age,Email_ID,is_setter) VALUES(%d, '%s', '%s', %d, '%s', %d)" % (int(row['Hacker_ID']), row['Fname'], row['Lname'], int(row['Age']), row['email'], int(row['is_Setter']))

        cur.execute(query)
        con.commit()

        print("Inserted Into Database")

    except Exception as e:
        con.rollback()
        print("Failed to insert into database")
        print(">>>>>>>>>>>>>", e)

    return


def InsertTeam():
    """
    Inserts Team into the table
    """
    try:
        row=TakeInput(['TeamNo','TeamName'],['INT','STRING'])
        query="INSERT INTO TEAM(Team_No, Team_Name) VALUES(%d,'%s')" % (int(row['TeamNo']),row['TeamName'])
        print(query)
        cur.execute(query)
        con.commit()
        print("Inserted Into Database")
    except Exception as e:
        con.rollback()
        print("Failed to insert into database")
        print(">>>>>>>>>>>>>", e)

def RemoveHacker():
    """
    Removes Hacker Entry from the table
    """
    try:
        removehackerid=int(input('Enter ID of Hacker you want to remove'))
        query="DELETE FROM HACKER WHERE Hacker_ID=%d" % (removehackerid)
        cur.execute(query)
        con.commit()
        print("Removed From Database")
    except Exception as e:
        con.rollback()
        print("Failed to insert into database")
        print(">>>>>>>>>>>>>", e)
    return

def UpdateHacker():
    """
    Updates Hacker info when given Hacker_ID
    """
    try:
        updatehackerid=int(input('Enter ID of Hacker whose credentials you want to upgrade'))
        print("Enter new credentials\n")
        row = TakeInput(['Fname','Lname','Age','email','is_setter'],['STRING','STRING','INT','STRING','INT'])
        if(int(row['is_setter'])!= 0 and int(row['is_setter'])!=1):
            print("Invalid Input")
            return
        query= " UPDATE HACKER SET First_Name='%s', Last_Name='%s', Age=%d, Email_ID='%s',is_setter=%d WHERE Hacker_ID=%d " % (row['Fname'],row['Lname'],int(row['Age']),row['email'],int(row['is_setter']),int(updatehackerid))
        cur.execute(query)
        con.commit()
        print("Updated Database")

    except Exception as e:
        con.rollback()
        print("Failed to update database")
        print(">>>>>>>>>>>>>", e)
    return

def UpdateTeam():
    """
    Updates Team info when given Team_ID
    """
    try:
        updateteamid=int(input('Enter ID of Team Whose Name you want to update'))
        print("Enter new credentials")
        newteamname=input('Please enter ' + 'Team_Name' + ' of type (' + 'STRING' + '):- ')
        query= "UPDATE TEAM SET Team_Name='%s' WHERE Team_No=%d" % (newteamname,int(updateteamid))
        cur.execute(query)
        con.commit()
        print("Updated Database")

    except Exception as e:
        con.rollback()
        print("Failed to update database")
        print(">>>>>>>>>>>>>", e)
    return


def UpdateContest():
    """
    Updates info of Contest when given Contest_ID
    """
    try:
        updatecontestid=int(input('Enter Id of Contest whose info you want to change'))
        print("Enter new credentials")
        row=TakeInput(['Start_Date','Duration','Contest_Rating'],['DATE_TIME','INT','STRING'])
        query="UPDATE CONTEST SET Start_Date='%s', Duration=%d, Contest_Rating='%s' WHERE Contest_ID=%d" % (row['Start_Date'],int(row['Duration']),row['Contest_Rating'], int(updatecontestid))
        cur.execute(query)
        con.commit()
        print("Updated Database")
    except Exception as e:
        con.rollback()
        print("Failed to update database")
        print(">>>>>>>>>>>>>", e)
    return

def dispatch(ch):
    """
    Function that maps helper functions to option entered
    """

    if(ch == 1):
        InsertHacker()
    elif(ch == 2):
        InsertTeam()
    elif(ch == 3):
        RemoveHacker()
    elif(ch == 4):
        UpdateTeam()
    elif(ch == 5):
        UpdateContest()
    elif(ch == 6):
        UpdateHacker()
    elif(ch == 7):
        averageTime()
    elif(ch == 8):
        listTeams()
    elif(ch == 9):
        listAdultHackers()
    elif(ch == 10):
        LeastInc()
    elif(ch == 11):
        FirstSolve()
    elif(ch == 12):
        SearchHacker()
    elif(ch == 13):
        SearchTeam()
    elif(ch==14):
        projectHackers()
    else:
        print("Error: Invalid Option")


# Global
while(1):
    tmp = sp.call('clear', shell=True)
    
    # Can be skipped if you want to hardcode username and password
    username = input("Username: ")
    password = input("Password: ")

    try:
        # Set db name accordingly which have been create by you
        # Set host to the server's address if you don't want to use local SQL server 
        con = pymysql.connect(host='localhost',
                              port=3306,
                              user="root",
                              password="password",
                              db='KuRuNu',
                              cursorclass=pymysql.cursors.DictCursor)
        tmp = sp.call('clear', shell=True)

        if(con.open):
            print("Connected")
        else:
            print("Failed to connect")

        tmp = input("Enter any key to CONTINUE>")

        with con.cursor() as cur:
            while(1):
                tmp = sp.call('clear', shell=True)
                # Here taking example of Employee Mini-world
                print("1. Insert Hacker ")  # Hire an Employee
                print("2. Insert Team")  # Fire an Employee
                print("3. Remove Hacker")  # Employee Statistics
                print("4. Update Team")  # Promote Employee
                print("5. Update Contest")
                print("6. Update Hacker")
                print("7. Calculate Average Time for a problem")
                print("8. List All Teams")
                print("9. List All Hackers above the age of 18")
                print("10. Print Least Incorrect")
                print("11. First Solved")
                print("12. Search For a Hacker")
                print("13. Search For a Team")
                print("14. List all Hackers who have solved at least 1 problem")
                
                print("15. Logout")
                ch = int(input("Enter choice> "))
                tmp = sp.call('clear', shell=True)
                if ch == 15:
                    exit()
                else:
                    dispatch(ch)
                    tmp = input("Enter any key to CONTINUE>")

    except Exception as e:
        tmp = sp.call('clear', shell=True)
        print(e)
        print("Connection Refused: Either username or password is incorrect or user doesn't have access to database")
        tmp = input("Enter any key to CONTINUE>")
