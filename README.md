# vmq-elixir-plugin

from https://vernemq.com/blog/2016/09/29/building-an-elixir-plugin-for-vernemq.html

# enable elixir & plugin in vernemq

- vmq-admin plugin enable --name=elixir --path=/opt/elixir && vmq-admin plugin enable --name=vmq_elixir_plugin --path=/opt/vmq_elixir_plugin

# mosquitto commands

mosquitto_pub -i myclientid -t "mytopic" -m "hello world" -p 1883 -u "user" -P '{"connect_data": {"auth_type": "hgw","auth_method": "cn_challenge"}}' --property Connect user-property cpeId mycpeid --protocol-version 5