#!/bin/bash
while sleep 10; do /home/pi/libcoap-4.1.1/examples/coap-client -m get -o /home/pi/libcoap-4.1.1/examples/output.txt coap://[bbbb::1415:9200:0017:9e13]/pir; done &

