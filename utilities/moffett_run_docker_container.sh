#!/bin/bash
TAG=hubxilinx/moffettai_sp_vs_accelerator:first_release 
AGFI=agfi-00df190238adaf3bc
set -e
# Install aws-fpga sdk
AWS_FPGA_REPO_DIR=/home/centos/aws-fpga
git clone https://github.com/aws/aws-fpga.git $AWS_FPGA_REPO_DIR
source $AWS_FPGA_REPO_DIR/sdk_setup.sh

# Load FPGA image
sudo fpga-clear-local-image  -S 0
sudo fpga-load-local-image  -S0 -I $AGFI
ACCESS_KEY_PATH=/opt/xilinx/cred.json

# Install xdma driver

sudo rmmod xocl
sudo rmmod xdma
sudo insmod /home/centos/aws_visual_search/utilities/xdma.ko
sudo chmod a+rw /dev/xdma0_user
sudo chmod a+rw /dev/xdma0_h2c_0
sudo chmod a+rw /dev/xdma0_c2h_0
source /home/centos/Xilinx_Base_Runtime/utilities/xilinx_aws_docker_setup.sh  

# Docker run command 
docker run --rm -v $ACCESS_KEY_PATH:/vsearch_sdk_demo/sdk/cred.json $XILINX_AWS_DOCKER_DEVICES $TAG
