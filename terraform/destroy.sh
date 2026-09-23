#!/bin/bash
set -e


error() {
    echo -e "\n\e[1;36m[Errors has been encoutered during 'terraform destroy']\e[0m\n"
}
trap error ERR


echo -e "\n\e[1;36m[Destroying Dev Enviroment]\e[0m\n"
cd ./environments/dev
terraform destroy -auto-approve


echo -e "\n\e[1;36m[Destroying Prod Enviroment]\e[0m\n"
cd ../prod
terraform destroy -auto-approve

echo -e "\n\e[1;36m[Success destroying the devices!]\n\e[0m"