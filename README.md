<h1>BORNTOBEROOT TESTER</h1>
                                                                                     
HOW TO USE:
-  Clone the Git repository into your virtual machine.
-  If you are using a regular user account, run the tester.h files with the sudo command.
-  Cronjob files only detect the file named monitor.sh. You can modify the file name in the tester.sh to match your monitoring script's file name.

Line 211
************************************************************************************************
RES=$(crontab -l | grep <b><i>monitor.sh<i></b> | awk '$1 == "*/10" {print $1}')
************************************************************************************************

<img src="https://i.ibb.co/5cSDdF9/Screenshot-2023-10-31-063508.png" alt="Screenshot-2023-10-31-063508" border="0" />
