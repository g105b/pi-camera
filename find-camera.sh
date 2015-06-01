#!/usr/bin/env bash
# Locates the IP of the first IP camera on the same subnet.
# Stores the IP in the camera-ip.txt file
#
# Limitation is that only one camera can be used (as it will
# always be found first). Second phase of this project will
# broadcast each recorded camera from each Pi device, allowing
# multiple cameras to be automatically connected.
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
IP_FILE="$DIR/camera-ip.txt"
CAMERA_IP=( $("$DIR/nmap-camera.sh") )

# $CAMERA_IP => first camera IP
# This variable also references any other IPs like so:
# CAMERA_IP_2=${CAMERA_IP[1]}
# CAMERA_IP_3=${CAMERA_IP[2]}
#
# This can also be looped over:
# for IP in ${CAMERA_IP[@]}; do echo $IP; done

echo "Camera IP is $CAMERA_IP"
