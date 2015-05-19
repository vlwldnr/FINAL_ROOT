#!/bin/bash
while sleep 10; do /var/lib/tomcat7/webapps/ROOT/libcoap/coap-client -m get -o /var/lib/tomcat7/webapps/ROOT/libcoap/output.txt coap://[bbbb::1415:9200:0017:9e13]/pir; done &

