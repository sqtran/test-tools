#!/bin/bash

podman run --rm -it -e POSTGRES_PASSWORD=password -p 5432:5432/tcp docker.io/library/postgres

#oc new-app openshift/openldap-2441-centos7
#
#
#oc patch service openldap-2441-centos7 -p '{"spec":{"type": "LoadBalancer"}}'
#
#PORT=$(oc get service openldap-2441-centos7 --no-headers  | awk '{split($5, arr, ","); print substr(arr[1], 5, 5) }')
#
#until [ "$(oc get pod -l deploymentconfig=openldap-2441-centos7 --field-selector status.phase=Running)" != "" ]
#do
#  printf "\rWaiting for pod to be available (Ctrl-D to stop) "
#  sleep 3
#done
#
#DOMAIN=$(oc project | awk '{print $6}' | sed 's/"https:\/\/[a-z]\+.//g' | sed 's/:[0-9]\+".//g')
#
#echo "Connecting to *.apps.$DOMAIN:$PORT"
#
#ldapadd -w admin -D "cn=Manager,dc=example,dc=com" -h frenchfries.apps.$DOMAIN:$PORT -f simpsons.ldif
#ldapsearch -w admin -D "cn=Manager,dc=example,dc=com" -b "ou=intranet,dc=example,dc=com" -h freedomfries.apps.$DOMAIN:$PORT
