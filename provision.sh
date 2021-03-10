#!/bin/bash

ACTION=${1}
version=1.0.0

function display_version() {
	echo $version
}

function remove_server() {
	sudo service nginx stop
	sudo rm -rf /usr/share/nginx/html/*
	sudo yum remove nginx -y
}

function start_server() {
	sudo yum update -y
	sudo amazon-linux-extras install nginx1.12 -y
	sudo chkconfig nginx on
	sudo aws s3 cp s3://riley-martinez-ust-assignment-webserver/index.html /usr/share/nginx/html/index.html
	sudo service nginx start
}

function display_help() {	
cat << EOF
	Usage: ${0} {-r|--remove|-v|--version|-h|--help|*}
		
	OPTIONS:
		-r | --remove	Tear down the nginx server			
		-v | --version	Displays the script version
		-h | --help	Display the command help
		*		Start the nginx server
		
	Examples:
		Tear down server:
			$ ${0} -r
		
		Display version:
			$ ${0} -v

		Display help:
			$ ${0} -h

		Start server:
			$ ${0}
EOF
}

if [ $# -eq 0 ]
	then
		start_server	
fi

case "$ACTION" in
	-r | --remove)
		remove_server	
		;;
	-v | --version)
		display_version
		;;
	-h | --help)
		display_help
		;;
	*)
		echo "Usage ${0} {*|-r|-v|-h}"
		exit 1
esac

