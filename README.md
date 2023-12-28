<h1>BORN2BEROOT TESTER</h1>
                                                                                     
HOW TO USE:
-  Clone the Git repository into your virtual machine.
-  If you are using a regular user account, run the tester.h files with the sudo command.
-  Cronjob files only detect the file named <b>monitoring.sh</b>. You can modify the file name in the test.sh to match your monitoring script's file name (only if yours if different.)
-  Run the command using "<b>sudo bash test.sh</b>"
-  Make sure you run using your username. Not as ROOT or using SU.
<br>
Line 211<be>
<img src="https://user-images.githubusercontent.com/74038190/212284115-f47cd8ff-2ffb-4b04-b5bf-4d1c14c0247f.gif"/>
RES=$(crontab -l | grep <b><i>monitoring.sh<i></b> | awk '$1 == "*/10" {print $1}')<br>
<img src="https://user-images.githubusercontent.com/74038190/212284115-f47cd8ff-2ffb-4b04-b5bf-4d1c14c0247f.gif"/><br><br>

<img src="https://i.ibb.co/PgQ4QJJ/Screenshot-2023-10-31-072953.png" alt="Screenshot-2023-10-31-072953" border="0" />
