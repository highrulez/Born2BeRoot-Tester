#!/bin/bash

DEF_COLOR='\033[0;39m'
BLACK='\033[0;30m'
RED='\033[1;91m'
GREEN='\033[1;92m'
YELLOW='\033[0;93m'
BLUE='\033[0;94m'
MAGENTA='\033[0;95m'
CYAN='\033[0;96m'
GRAY='\033[0;90m'
WHITE='\033[0;97m'

printf ${BLUE}"  ____                   ____  ____       ____             _   \n"${DEF_COLOR};
printf ${BLUE}" | __ )  ___  _ __ _ __ |___ \| __ )  ___|  _ \ ___   ___ | |_ \n"${DEF_COLOR};
printf ${BLUE}" |  _ \ / _ \| '__| '_ \  __) |  _ \ / _ \ |_) / _ \ / _ \| __|\n"${DEF_COLOR};
printf ${CYAN}" | |_) | (_) | |  | | | |/ __/| |_) |  __/  _ < (_) | (_) | |_ \n"${DEF_COLOR};
printf ${CYAN}" |____/ \___/|_|  |_| |_|_____|____/ \___|_| \_\___/ \___/ \__| by highrulez\n\n"${DEF_COLOR};
                                                                                                                                                                      
USER=$(whoami)

if [ $USER != "root" ];then
  printf "${RED}You sure you are root user? If not, then be a fucking root before you start!${DEF_COLOR}\n";
  exit;
fi
RES=$(ls /usr/bin/*session)
printf "${MAGENTA}1. GUI MODE DISABLE?${DEF_COLOR}\n";
  if [[ $RES == "/usr/bin/dbus-run-session" ]]; then
    printf "${GREEN}[GOOD] ✔${GRAY} GUI mode disable${DEF_COLOR}\n";
  else
    printf "${RED}[FAILED] ✗${GRAY} GUI mode enable${DEF_COLOR}\n";
fi

echo
printf "${MAGENTA}6. Hostname${DEF_COLOR}\n";
RES=$(env | grep SUDO_USER | head -1 | cut -d '=' -f2)
CONCAT="42"
RES="$RES$CONCAT"
RES2=$(hostname)
if [ $RES == $RES2 ];then
        printf "${GREEN}[GOOD] ✔${DEF_COLOR}\n";
  else
        printf "${RED}[FAILED] ✗${DEF_COLOR}\n";
fi

echo
printf "${MAGENTA}2. Disk partitions${DEF_COLOR}\n";
RES=$(lsblk | grep lvm | wc -l)
if [ $RES -gt 1 ];then
  printf "${GREEN}[GOOD] ✔${GRAY} LVM${DEF_COLOR}\n";
  else
        printf "${RED}[FAILED] ✗${GRAY} no LVM partition${DEF_COLOR}\n";
fi
RES=$(lsblk | grep home | wc -l)
if [ $RES -gt 0 ];then
        printf "${GREEN}[GOOD] ✔${GRAY} home${DEF_COLOR}\n";
  else
        printf "${RED}[FAILED] ✗${GRAY} no home partition${DEF_COLOR}\n";
fi
RES=$(lsblk | grep swap | wc -l)
if [ $RES -gt 0 ];then
        printf "${GREEN}[GOOD] ✔${GRAY} swap${DEF_COLOR}\n";
  else
        printf "${RED}[FAILED] ✗${GRAY} no swap partition${DEF_COLOR}\n";
fi
RES=$(lsblk | grep root | wc -l)
if [ $RES -gt 0 ];then
        printf "${GREEN}[GOOD] ✔${GRAY} root${DEF_COLOR}\n";
  else
        printf "${RED}[FAILED] ✗${GRAY} no root partition${DEF_COLOR}\n";
fi

echo
printf "${MAGENTA}3. Bonus Disk Partitions (Optional)${DEF_COLOR}\n";
RES=$(lsblk | grep var | wc -l)
if [ $RES -gt 0 ];then
        printf "${GREEN}[GOOD] ✔${GRAY} var${DEF_COLOR}\n";
  else
        printf "${RED}[FAILED] ✗${GRAY} no var partition${DEF_COLOR}\n";
fi
RES=$(lsblk | grep srv | wc -l)
if [ $RES -gt 0 ];then
        printf "${GREEN}[GOOD] ✔${GRAY} srv${DEF_COLOR}\n";
  else
        printf "${RED}[FAILED] ✗${GRAY} no srv partition${DEF_COLOR}\n";
fi
RES=$(lsblk | grep tmp | wc -l)
if [ $RES -gt 0 ];then
        printf "${GREEN}[GOOD] ✔${GRAY} tmp${DEF_COLOR}\n";
  else
        printf "${RED}[FAILED] ✗${GRAY} no tmp partition${DEF_COLOR}\n";
fi
RES=$(lsblk | grep var--log | wc -l)
if [ $RES -gt 0 ];then
        printf "${GREEN}[GOOD] ✔${GRAY} var--log${DEF_COLOR}\n";
  else
        printf "${RED}[FAILED] ✗${GRAY} no var--log partition${DEF_COLOR}\n";
fi

echo
printf "${MAGENTA}4. UFW (Uncomplicated Firewall)${DEF_COLOR}\n";
RES=$(sudo ufw status | grep -v ALLOW | grep active | wc -l)
if [ $RES -gt 0 ];then
        printf "${GREEN}[GOOD] ✔${GRAY} Active${DEF_COLOR}\n";
  else
        printf "${RED}[FAILED] ✗${GRAY} Not Active${DEF_COLOR}\n";
fi
RES=$(sudo ufw status | grep 4242 | wc -l)
if [ $RES -gt 1 ];then
        printf "${GREEN}[GOOD] ✔${GRAY} Port 4242 is open${DEF_COLOR}\n";
  else
        printf "${RED}[FAILED] ✗${GRAY} Port 4242 is closed${DEF_COLOR}\n";
fi

echo
printf "${MAGENTA}4. UFW (Port 80 for HTTP - Bonus part)${DEF_COLOR}\n";
RES=$(sudo ufw status | grep 80 | wc -l)
if [ $RES -gt 1 ];then
        printf "${GREEN}[GOOD] ✔${GRAY} Port 80 is open${DEF_COLOR}\n";
  else
        printf "${RED}[FAILED] ✗${GRAY} Port 80 is closed${DEF_COLOR}\n";
fi

echo
RES=$(sudo service ssh status | awk '$1 == "Active:"' | grep running | wc -l)
printf "${MAGENTA}5. SSH${DEF_COLOR}\n";
if [ $RES -gt 0 ];then
        printf "${GREEN}[GOOD] ✔${GRAY} Active${DEF_COLOR}\n";
  else
        printf "${RED}[FAILED] ✗${GRAY} Not Active${DEF_COLOR}\n";
fi
RES=$(which lsof | wc -l)
if [ $RES -eq 0 ];then
  sudo apt-get update -qq -y > /dev/null 2>&1
  sudo apt-get install -qq -y lsof > /dev/null 2>&1
fi
RES=$(sudo lsof -i -P -n | grep sshd | grep LISTEN | grep 4242 | wc -l)
if [ $RES -gt 1 ];then
        printf "${GREEN}[GOOD] ✔${GRAY} Port 4242 ${DEF_COLOR}\n";
  else
        printf "${RED}[FAILED] ✗${GRAY} Port 4242 ${DEF_COLOR}\n";
fi

echo
printf "${MAGENTA}7. Password policy${DEF_COLOR}\n";
RES=$(cd ~ && cat /etc/pam.d/common-password | grep -o minlen=10)
if [ $RES == "minlen=10" ];then
        printf "${GREEN}1.[GOOD] ✔${GRAY} minlen ${DEF_COLOR}\n";
  else
        printf "${RED}1.[FAILED] ✗${GRAY} minlen ${DEF_COLOR}\n";
fi
RES=$(cd ~ && cat /etc/pam.d/common-password | grep -o ucredit=-1)
if [ $RES == "ucredit=-1" ];then
        printf "${GREEN}2.[GOOD] ✔${GRAY} uppercase ${DEF_COLOR}\n";
  else
        printf "${RED}2.[FAILED] ✗${GRAY} uppercase ${DEF_COLOR}\n";
fi
RES=$(cd ~ && cat /etc/pam.d/common-password | grep -o lcredit=-1)
if [ $RES == "lcredit=-1" ];then
        printf "${GREEN}3.[GOOD] ✔${GRAY} lowercase ${DEF_COLOR}\n";
  else
        printf "${RED}3.[FAILED] ✗${GRAY} lowercase ${DEF_COLOR}\n";
fi
RES=$(cd ~ && cat /etc/pam.d/common-password | grep -o dcredit=-1)
if [ $RES == "dcredit=-1" ];then
        printf "${GREEN}4.[GOOD] ✔${GRAY} digit ${DEF_COLOR}\n";
  else
        printf "${RED}4.[FAILED] ✗${GRAY} digit ${DEF_COLOR}\n";
fi
RES=$(cd ~ && cat /etc/pam.d/common-password | grep -o maxrepeat=3)
if [ $RES == "maxrepeat=3" ];then
        printf "${GREEN}5.[GOOD] ✔${GRAY} consecutive char ${DEF_COLOR}\n";
  else
        printf "${RED}5.[FAILED] ✗${GRAY} consecutive char ${DEF_COLOR}\n";
fi
RES=$(cd ~ && cat /etc/pam.d/common-password | grep -o difok=7)
if [ $RES == "difok=7" ];then
        printf "${GREEN}6.[GOOD] ✔${GRAY} difok ${DEF_COLOR}\n";
  else
        printf "${RED}6.[FAILED] ✗${GRAY} difok ${DEF_COLOR}\n";
fi
RES=$(cd ~ && cat /etc/pam.d/common-password | grep -o enforce_for_root)
if [ $RES == "enforce_for_root" ];then
        printf "${GREEN}7.[GOOD] ✔${GRAY} enforce for root ${DEF_COLOR}\n";
  else
        printf "${RED}7.[FAILED] ✗${GRAY} enforce for root ${DEF_COLOR}\n";
fi
RES=$(cd ~ && cat /etc/pam.d/common-password | grep -o reject_username)
if [ $RES == "reject_username" ];then
        printf "${GREEN}8.[GOOD] ✔${GRAY} reject username ${DEF_COLOR}\n";
  else
        printf "${RED}8.[FAILED] ✗${GRAY} reject username ${DEF_COLOR}\n";
fi
RES=$(cd && cat /etc/login.defs | grep PASS_MAX_DAYS | grep -o 30)
if [ $RES == "30" ];then
        printf "${GREEN}9.[GOOD] ✔${GRAY} passwd expire days ${DEF_COLOR}\n";
  else
        printf "${RED}9.[FAILED] ✗${GRAY} passwd expire days ${DEF_COLOR}\n";
fi
RES=$(cd && cat /etc/login.defs | grep PASS_MIN_DAYS | grep -o 2)
if [ $RES == "2" ];then
        printf "${GREEN}10.[GOOD] ✔${GRAY} days allowed before the modification ${DEF_COLOR}\n";
  else
        printf "${RED}10.[FAILED] ✗${GRAY} days allowed before the modification ${DEF_COLOR}\n";
fi
RES=$(cd && cat /etc/login.defs | grep PASS_WARN_AGE | grep -o 7)
if [ $RES == "7" ];then
        printf "${GREEN}11.[GOOD] ✔${GRAY} warning message ${DEF_COLOR}\n";
  else
        printf "${RED}11.[FAILED] ✗${GRAY} warning message ${DEF_COLOR}\n";
fi
if [ -d "/var/log/sudo/" ];then
        printf "${GREEN}12.[GOOD] ✔${GRAY} folder /var/log/sudo exist ${DEF_COLOR}\n";
  else
        printf "${RED}12.[FAILED] ✗${GRAY} folder /var/log/sudo exist ${DEF_COLOR}\n";
fi

echo
printf "${MAGENTA}8. Cronjob${DEF_COLOR}\n";
RES=$(crontab -l | grep monitor.sh | awk '$1 == "*/10" {print $1}')
if [ $RES == "*/10" ];then
        printf "${GREEN}[GOOD] ✔${GRAY} cronjob setting is */10${DEF_COLOR}\n";
  else
        printf "${RED}[FAILED] ✗${GRAY} missing / wrong setting in cronjob${GRAY} ${DEF_COLOR}\n";
fi
echo

printf ${YELLOW}"Mandatory test Done! It's time to test WordPress in a browser, and other services if any (ex. ftp / fail2ban / Cloudflare tunnel).${DEF_COLOR}\n\n";
