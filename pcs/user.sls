# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "pcs/map.jinja" import pcs with context %}

pcs_user__user:
  group.present:
    - name: {{pcs.pcsgroup}}
    - gid: {{pcs.pcsgid}}
  user.present:
    - name: {{pcs.pcsuser}}
    - home: /home/hacluster
    - createhome: False
    - shell: /sbin/nologin
    - uid: {{pcs.pcsuid}}
    - password: {{pcs.pcspasswd}}
    - hash_password: True
    - enforce_password: True
    - gid: {{pcs.pcsgid}}
    - remove_groups: False
    - groups:
      - {{pcs.pcsgroup}}
    - require:
      - group: pcs_user__user
