# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "pcs/map.jinja" import pcs with context -%}
{% set nodes = [] -%}
{% for v in pcs.nodes -%}
{%   do nodes.append(v.split(',')[0]) -%}
{% endfor -%}


pcs_auth__auth:
  pcs.auth:
    - nodes:  {{nodes}}
    - pcsuser: {{pcs.pcsuser}} 
    - pcspasswd: {{pcs.pcspasswd}}
    - extra_args: {{pcs.auth_extra_args|default([])}}
