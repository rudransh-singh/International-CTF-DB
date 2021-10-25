import subprocess as sp
import pymysql
import pymysql.cursors

def TakeInput(items: list = [], Type: list = []):
    """
    Function to take input conveniently
    """
    inputlist = {}
    for index, item in enumerate(items):
        val = input('Please enter ' + item + ' of type (' + InpDesc[Type[index]] + '):- ')
        inputlist[item] = val
    return inputlist

def SearchTeam():
    try:
        num = (input("Enter the team number: "))
        query = "SELECT * FROM TEAM WHERE Team_No LIKE '%d'" % (num)
        num = cur.execute(query)
        if num == 0:
            print("There are no results for this query")
        else:
            print_table(cur.fetchall())
    except Exception as e:
        print("Failed to Select")

def SearchTeam():
    try:
        num = (input("Enter the team number: "))
        query = "SELECT * FROM TEAM WHERE Team_No LIKE '%d'" % (num)
        num = cur.execute(query)
        if num == 0:
            print("There are no results for this query")
        else:
            print_table(cur.fetchall())
    except Exception as e:
        print("Failed to Select")
        
def SearchCt():
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
        query = "CREATE VIEW V1 AS SELECT Prob_Number, Team_No, Sub_Time FROM SUBMISSION NATURAL JOIN SUBMITS WHERE VERDICT='CORRECT' AND Contest-ID=%d" % (ConID)
        cur.execute(query)
        query = "CREATE VIEW V2 AS SELECT Prob_Number,MIN(Sub_Time) AS Sub_Time FROM SUBMISSION NATURAL JOIN SUBMITS WHERE VERDICT='CORRECT' AND Contest-ID=%d GROUP BY Prob_Number" % (ConID)
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



# def projectHackers():
#     try:
#         query = 'SELECT '
#         num = cur.execute(query)
#         if num == 0:
#             print("No hackers above the age of 18")
#         else:
#             print_table(cur.fetchall())
#     except Exception as e:
#         print("Failed to perform SELECT query")
    
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
        query = 'SELECT Team_No, Team_Name FROM TEAM T INNER JOIN PARTICIPATES P ON T.Team_No = P.Team_No WHERE P.Contest_ID = %d' % (
            contestID)
        num = cur.execute(query)
        if num == 0:
            print("No teams participated in this contest")
        else:
            print_table(cur.fetchall())
    except Exception as e:
        print("Failed to perform SELECT query")


def hireAnEmployee():
    """
    This is a sample function implemented for the refrence.
    This example is related to the Employee Database.
    In addition to taking input, you are required to handle domain errors as well
    For example: the SSN should be only 9 characters long
    Sex should be only M or F
    If you choose to take Super_SSN, you need to make sure the foreign key constraint is satisfied
    HINT: Instead of handling all these errors yourself, you can make use of except clause to print the error returned to you by MySQL
    """
    try:
        # Takes emplyee details as input
        row = {}
        print("Enter new employee's details: ")
        name = (input("Name (Fname Minit Lname): ")).split(' ')
        row["Fname"] = name[0]
        row["Minit"] = name[1]
        row["Lname"] = name[2]
        row["Ssn"] = input("SSN: ")
        row["Bdate"] = input("Birth Date (YYYY-MM-DD): ")
        row["Address"] = input("Address: ")
        row["Sex"] = input("Sex: ")
        row["Salary"] = float(input("Salary: "))
        row["Dno"] = int(input("Dno: "))

        query = "INSERT INTO EMPLOYEE(Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Dno) VALUES('%s', '%c', '%s', '%s', '%s', '%s', '%c', %f, %d)" % (
            row["Fname"], row["Minit"], row["Lname"], row["Ssn"], row["Bdate"], row["Address"], row["Sex"], row["Salary"], row["Dno"])

        print(query)
        cur.execute(query)
        con.commit()

        print("Inserted Into Database")

    except Exception as e:
        con.rollback()
        print("Failed to insert into database")
        print(">>>>>>>>>>>>>", e)

    return

def InsertHacker():
    """
    Inserts Hacker Details to the Table
    """
    try:
        # Takes emplyee details as input
        row = TakeInput(['Hacker_ID','Fname','Lname','Age','email'],['INT','STRING','STRING','INT','STRING'])
        is_setter=int(input('Is the user a problem setter, [0]=NO [1]=YES '))
        if(is_setter != 0 or is_setter !=1):
            print("Invalid Input")
            return
        row['is_Setter']=is_setter
        query = "INSERT INTO PROGRAMMER(Hacker_ID,First_Name,Last_Name,Age,Email_ID,is_setter) VALUES(%d, '%s', '%s', %d, '%s', %d)" % (int(row['Hacker_ID']), row['Fname'], row['LName'], int(row['Age']), row['email'], int(row['is_Setter']))

        print(query)
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
        row = TakeInput(['Fname','Lname','Age','email'],['STRING','STRING','INT','STRING'])
        query= " UPDATE HACKER SET First_Name='%s' Last_Name='%s' Age=%d Email_ID='%s' WHERE Hacker_ID=%d " % (row['Fname'],row['Lname'],int(row['Age']),row['email'],int(updatehackerid))
        cur.execute(query)
        con.commit()

    except Exception as e:
        con.rollback()
        print("Failed to insert into database")
        print(">>>>>>>>>>>>>", e)
    return



def dispatch(ch):
    """
    Function that maps helper functions to option entered
    """

    if(ch == 1):
        hireAnEmployee()
    elif(ch == 2):
        option2()
    elif(ch == 3):
        option3()
    elif(ch == 4):
        option4()
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
                print("1. Option 1")  # Hire an Employee
                print("2. Option 2")  # Fire an Employee
                print("3. Option 3")  # Promote Employee
                print("4. Option 4")  # Employee Statistics
                print("5. Logout")
                ch = int(input("Enter choice> "))
                tmp = sp.call('clear', shell=True)
                if ch == 5:
                    exit()
                else:
                    dispatch(ch)
                    tmp = input("Enter any key to CONTINUE>")

    except Exception as e:
        tmp = sp.call('clear', shell=True)
        print(e)
        print("Connection Refused: Either username or password is incorrect or user doesn't have access to database")
        tmp = input("Enter any key to CONTINUE>")
