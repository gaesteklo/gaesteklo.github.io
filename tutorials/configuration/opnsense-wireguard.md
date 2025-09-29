# Site to site tunneling

## OPNsense (ONE) <---> OPNsense (TWO) 

`ONE -> VPN -> Wireguard -> Local:`
- Create local
- Name it
- Set local port
- Save

`TWO -> VPN -> Wireguard -> Local:` 
- Create local
- Name it
- Set local port (same as on ONE)
- Save
- Open
- Copy public key

`ONE -> VPN -> Wireguard -> Endpoints:`
- Create endpoint
- Name it
- Set public key of TWO
- Set allowed IPs
- Save

`TWO -> VPN -> Wireguard -> Endpoints:`
- Create endpoint
- Name it
- Set public key of ONE
- Set allowed IPs
- Set endpoint address (IP of ONE)
- Set endpoint port (same as on ONE)
- Save

`TWO -> VPN -> Wireguard -> Local:`
- Open
- Select endpoint under peers
- Set tunnel address if needed
- Save

`ONE -> Interfaces -> Assignments:`
- Set description for new interface
- Create interface

`ONE -> Interfaces -> OPT1:`
- Enable
- Save

`ONE -> Firewall -> NAT -> Outbound:`
- Create rule
- Set interface to s2s interface
- Set translation/target to s2s address
- Save

`ONE -> Firewall -> Rules -> OPT1:`
- Create rule
- Set interface to s2s interface
- Set description
- Save

`ONE -> Firewall -> Rules -> WAN:`
- Create rule
- Set protocol to UDP
- Set destination port to s2s port
- Set description / categories
- Save

`TWO -> Firewall -> Rules -> WAN:`
- Create rule
- Set protocol to UDP
- Set destination port to s2s port
- Set description / categories
- Save