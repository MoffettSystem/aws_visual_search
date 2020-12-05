#!/bin/bash
TAG=hubxilinx/moffettai_sp_vs_accelerator:first_release 
AGFI=agfi-00df190238adaf3bc

# Load FPGA image
sudo fpga-clear-local-image  -S 0
sudo fpga-load-local-image  -S0 -I $AGFI
ACCESS_KEY_PATH=/opt/xilinx/cred.json

# Install xdma driver
if lsmod | grep -q 'xocl'; 
then 
    echo "Remove previously-installed xocl module"
    sudo rmmod xocl
fi

if lsmod | grep -q 'xdma';
then 
    echo "Remove previously-installed xdma module"
    sudo rmmod xdma
fi

sudo insmod /home/centos/aws_visual_search/utilities/xdma.ko
sudo chmod a+rw /dev/xdma0_user
sudo chmod a+rw /dev/xdma0_h2c_0
sudo chmod a+rw /dev/xdma0_c2h_0
source /home/centos/Xilinx_Base_Runtime/utilities/xilinx_aws_docker_setup.sh  

# Docker run command 
docker run --rm -v $ACCESS_KEY_PATH:/vsearch_sdk_demo/sdk/cred.json $XILINX_AWS_DOCKER_DEVICES $TAG
