#!/bin/bash
oc new-app --docker-image=sonatype/nexus3
oc expose svc/nexus3

printf "Nexus takes a while to boot, be patient....\n"

until [ "$(oc get pod -l deploymentconfig=nexus3 --field-selector status.phase=Running)" != "" ]
do
  printf "\rWaiting for pod to be available (Ctrl-D to stop) "
  sleep 3
done

podname="$(oc get pod -l deploymentconfig=nexus3 --field-selector status.phase=Running -o name)"

echo "$podname is ready!"
sleep 3

until [ "$(oc exec $podname -- grep "Writing admin user temporary password to /nexus-data/admin.password"  /nexus-data/log/nexus.log )" != "" ]
do
  printf "\rWaiting for nexus to load (Ctrl-D to stop) "
  sleep 10
done

echo "Nexus is ready!!"
echo "Use this password to log into nexus to configure it"
oc exec $podname -- cat /nexus-data/admin.password
echo ""
