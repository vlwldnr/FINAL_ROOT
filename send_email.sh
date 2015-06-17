# send_email.sh

#value=$(tail /home/pi/libcoap-4.1.1/examples/output1.txt)

#echo "$1" | mail -s "From : DoIT_Admin <doit.hgu@gmail.com>"  "ALARM ALERT" $1


  echo -e "Dear $1, \n\n Your Do_IT alarm has been triggered at \n\n $2 $3 \n\n To see more details on the logs, \n\n click the link below. \n\n $6 " | mail -a "From: DoIT_Admin <doit.hgu@gmail.com>" \
                   -a "Subject: $4, Your Alarm has been TRIGGERED!" \
                   -a "X-Custom-Header: yes" $5
