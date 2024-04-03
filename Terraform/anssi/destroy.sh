#!/bin/bash

ssh-keygen -f "/home/seb/.ssh/known_hosts" -R "anssi-sebastienk.westeurope.cloudapp.azure.com"

terraform destroy