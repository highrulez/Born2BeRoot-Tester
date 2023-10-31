<h1>BORN2BEROOT TESTER</h1>
                                                                                     
HOW TO USE:
-  Clone the Git repository into your virtual machine.
-  If you are using a regular user account, run the tester.h files with the sudo command.
-  Cronjob files only detect the file named <b>monitor.sh</b>. You can modify the file name in the tester.sh to match your monitoring script's file name.
-  Run the command using "bash tester.sh"
<br>
Line 211<br>
************************************************************************************************<br>
RES=$(crontab -l | grep <b><i>monitor.sh<i></b> | awk '$1 == "*/10" {print $1}')<br>
************************************************************************************************<br><br>

<img src="https://i.ibb.co/PgQ4QJJ/Screenshot-2023-10-31-072953.png" alt="Screenshot-2023-10-31-072953" border="0" />
