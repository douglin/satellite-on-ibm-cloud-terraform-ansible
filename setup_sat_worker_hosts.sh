ansible-playbook -vvv --ssh-common-args='-o StrictHostKeyChecking=no' --private-key=/Users/douglin/.ssh/bluemix satellite_playbook.yml --extra-vars "satellite-group" -i satellite_worker_hosts
