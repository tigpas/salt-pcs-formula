# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "pcs/map.jinja" import pcs with context %}

pcs_auth__auth:
  pcs.auth:
    - nodes:  {{pcs.nodes}}
    - pcsuser: {{pcs.pcsuser}} 
    - pcspasswd: {{pcs.pcspasswd}}
    - extra_args: {{pcs.auth_extra_args|default([])}}
