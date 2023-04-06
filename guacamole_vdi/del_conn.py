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
from guacapy import Guacamole
import base64
import sys

root = ET.fromstring(base64.b64decode(sys.argv[1]))
connection_id = root.find('.//USER_TEMPLATE/GUAC_CONNECTION/identifier').text
g = Guacamole(hostname='localhost:8080', url_path='/guacamole', username='guacadmin', password='guacadmin', method='http')
g.delete_connection(connection_id)
