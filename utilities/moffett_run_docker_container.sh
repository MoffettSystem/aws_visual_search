#!/bin/bash
TAG=hubxilinx/moffettai_sp_vs_accelerator:first_release 
#TAG=3cd7a293d3f4
AGFI=agfi-00df190238adaf3bc
sudo fpga-clear-local-image  -S 0
sudo fpga-load-local-image  -S0 -I $AGFI
ACCESS_KEY_PATH=/opt/xilinx/cred.json
sudo rmmod xocl
sudo rmmod xdma
sudo insmod aws_visual_search/utilities/xdma.ko
sudo chmod a+rw /dev/xdma0_user
sudo chmod a+rw /dev/xdma0_h2c_0
sudo chmod a+rw /dev/xdma0_c2h_0
source /home/centos/Xilinx_Base_Runtime/utilities/xilinx_aws_docker_setup.sh  

#git clone https://github.com/MoffettSystem/aws_visual_search.git
#sudo chmod +x aws_visual_search/utilities/setup_host_fpga.sh
#source aws_visual_search/utilities/setup_host_fpga.sh

docker run --rm -v $ACCESS_KEY_PATH:/vsearch_sdk_demo/sdk/cred.json $XILINX_AWS_DOCKER_DEVICES $TAG
