# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "pcs/map.jinja" import pcs with context %}

# fix for debian
pcs_setup__file_/etc/corosync/uidgid.d:
  file.directory:
    - name: /etc/corosync/uidgid.d
    - ensure: present
    - makedirs: True
    - user: root
    - group: root
    - mode: '0755'

pcs_setup__setup:
  pcs.cluster_setup:
    - nodes: [ '{{pcs.nodes[0]}}' ]
    - pcsclustername: {{pcs.pcsclustername|default('pcscluster')}} 
    - extra_args: {{pcs.setup_extra_args|default([])}}

{% for node in pcs.nodes[1:]|sort %}
pcs_setup__node_present_{{node}}:
  pcs.cluster_node_present:
    - node: {{node}}
    - extra_args: {{pcs.node_present_extra_args|default([])}}
{% endfor %}
