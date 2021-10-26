# International-CTF-DB
This is a database for an International Capture The Flag Contest.

The Team consists of the following members :-

1) Kushagra Kharbanda
2) Rudransh Pratap Singh
3) Nukit Tailor

#Usage Guide
1. Clone the repository
2. Run the following command to install the following dependencies
```
pip install -r requirements.txt
```
3. Run `python KuRuNu.py` to run the program

We have implemented the following functional requirements :

1.  Insert Hacker : Inserts Hacker into HACKER table with Hacker_Id, First_Name, Last_Name, Age, Email-ID, as input and asks whether the user is a problem setter or not.
2.  Insert Team : Inserts Team into TEAM table with Team ID, and Team Name as input
3.  Remove Hacker : Removes a Hacker with given Hacker_ID from the HACKER table
4.  Update Team : Updates the Team Name of a team with Team_ID as input.
5.  Update Contest : Updates Contest Details in the CONTEST table, such as Start_Date, Duration, and Contest Rating
6.  Update Hacker : Updates Hacker Details in the HACKER table, given the Hacker_ID
7.  Calculate Average Time for a problem : Calculate Average Time required to solve a particular problem, inputs are Contest_ID
8.  List All Teams : Lists all the teams which are participating 
9.  List All Hackers above the age of 18 : Lists all Hackers who are above the age of 18 ( >=18 )
10. Print Least Incorrect : Displays the team with lowest incorrect submission to a given problem, inputs are Contest_ID and Prob_No
11. First Solved : Takes input as Contest_ID, and prints the time of first "correct" submission of each problem in that Contest 
12. Search For a Hacker : Searches for Hacker when given Hacker Name (First Name + Last Name)
13. Search For a Team : Searches for Team Name when given Team_No
14. List all Hackers who have solved at least 1 problem : Prints the Hacker_ID of all participants who have solved at least 1 Problem 



