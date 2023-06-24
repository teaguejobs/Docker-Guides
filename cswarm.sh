#!/bin/bash

if [ $1 = 1 ]; then
   ssh -i "devopsk8.pem" ubuntu@ec2-54-201-254-84.us-west-2.compute.amazonaws.com
elif [ $1 = 2 ]; then
   ssh -i "devopsk8.pem" ubuntu@ec2-35-163-229-238.us-west-2.compute.amazonaws.com
elif [ $1 = 3 ]; then
   ssh -i "devopsk8.pem" ubuntu@ec2-35-161-151-2.us-west-2.compute.amazonaws.com
fi

