<h1>BORNTOBEROOT TESTER</h1>
                                                                                     
HOW TO USE:
-  Git clone into your virtual machine.
-  Run the tester.h files with the sudo command if you are using a normal user.
-  Cronjob files detect only if the file name is <b>monitor.sh.</b> You can change the file name in the tester with your monitoring script file name.

Line 211
************************************************************************************************
RES=$(crontab -l | grep <b><i>monitor.sh<i></b> | awk '$1 == "*/10" {print $1}')
************************************************************************************************

<img src="https://i.ibb.co/5cSDdF9/Screenshot-2023-10-31-063508.png" alt="Screenshot-2023-10-31-063508" border="0" />
