#!/usr/bin/python3

# -------------------------------------------------------------------------- #
# Copyright 2002-2022, OpenNebula Project, OpenNebula Systems                #
#                                                                            #
# Licensed under the Apache License, Version 2.0 (the "License"); you may    #
# not use this file except in compliance with the License. You may obtain    #
# a copy of the License at                                                   #
#                                                                            #
# http://www.apache.org/licenses/LICENSE-2.0                                 #
#                                                                            #
# Unless required by applicable law or agreed to in writing, software        #
# distributed under the License is distributed on an "AS IS" BASIS,          #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   #
# See the License for the specific language governing permissions and        #
# limitations under the License.                                             #
#--------------------------------------------------------------------------- #


import xml.etree.ElementTree as ET
from guacapy import Guacamole, RDP_CONNECTION
import pyone
import base64
import sys

root = ET.fromstring(base64.b64decode(sys.argv[1]))
vm_id = root.find('.//ID').text
vm_ip = root.find('.//TEMPLATE/CONTEXT/ETH0_IP').text
vm_host = root.find('.//HISTORY_RECORDS/HISTORY/HOSTNAME').text
guac_group = root.find('.//TEMPLATE/CONTEXT/GUAC_GROUP').text

# add connection to Guacamole
g = Guacamole(hostname='localhost:8080', url_path='/guacamole', username='guacadmin', password='guacadmin', method='http')
RDP_CONNECTION['name'] = vm_id
RDP_CONNECTION['parentIdentifier'] = guac_group
RDP_CONNECTION['protocol'] = "rdp"
RDP_CONNECTION['parameters']['security'] = "nla"
RDP_CONNECTION['parameters']['port'] = "3389"
RDP_CONNECTION['parameters']['ignore-cert'] = "true"
RDP_CONNECTION['parameters']['hostname'] = vm_ip

# Uncomment the next lines to match guacamole credentials with windows credentials
# Leave commented to prompt for credentials upon connection
#RDP_CONNECTION['parameters']['username'] = '${GUAC_USERNAME}' # Windows Username
#RDP_CONNECTION['parameters']['password'] = '${GUAC_PASSWORD}' # Windows Password
#RDP_CONNECTION['parameters']['domain'] = "DOMAIN" # Windows Domain

connection = g.add_connection(RDP_CONNECTION)

# add connection info to VM template
one = pyone.OneServer("http://localhost:2633/RPC2", session="oneadmin:oneadmin" )
one.vm.update(int(vm_id),
  {
    'TEMPLATE': {
      'GUAC_CONNECTION': connection
    }
  }, 1)
