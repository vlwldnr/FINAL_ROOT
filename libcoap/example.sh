#!/bin/bash

Detected=$(cat haha.txt)
ExampleString="This"

if [ $Detected = $ExampleString ] 
	then
	echo "Detected"
	touch a.txt
fi
