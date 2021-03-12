ansible-playbook -vvv --ssh-common-args='-o StrictHostKeyChecking=no' --private-key=<your SSH key> satellite_playbook.yml --extra-vars "satellite-group" -i satellite_control_hosts
