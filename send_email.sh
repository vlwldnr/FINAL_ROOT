# send_email.sh

#value=$(tail /home/pi/libcoap-4.1.1/examples/output1.txt)

#echo "$1" | mail -s "From : DoIT_Admin <doit.hgu@gmail.com>"  "ALARM ALERT" $1

  echo "$1 $2" | mail -a "From: DoIT_Admin <doit.hgu@gmail.com>" \
                   -a "Subject: ALARM ALERT" \
                   -a "X-Custom-Header: yes" $3
