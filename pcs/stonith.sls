# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "pcs/map.jinja" import pcs with context %}

{% if pcs.stonith_extra_cib is defined and pcs.stonith_extra_cib %}
pcs_stonith__cib_created_{{pcs.stonith_extra_cib}}:
  pcs.cib_created:
    - cibname: {{pcs.stonith_extra_cib}}
{% endif %}

{% for stonith_resource, stonith_resource_data in pcs.stonith_resources.items()|sort %}
pcs_stonith__create_{{stonith_resource}}:
  pcs.stonith_created:
    - stonith_id: {{stonith_resource_data.stonith_id}}
    - stonith_device_type: {{stonith_resource_data.stonith_device_type}}
    - stonith_device_options: {{stonith_resource_data.stonith_device_options}}
    - require:
      - pcs: pcs_stonith__cib_created_{{pcs.stonith_extra_cib}}
    - require_in:
      - pcs: pcs_stonith__cib_pushed_{{pcs.stonith_extra_cib}}
{% if pcs.stonith_extra_cib is defined and pcs.stonith_extra_cib %}
    - cibname: {{pcs.stonith_extra_cib}}
{% endif %}
{% endfor %}

{% if pcs.stonith_extra_cib is defined and pcs.stonith_extra_cib %}
pcs_stonith__cib_pushed_{{pcs.stonith_extra_cib}}:
  pcs.cib_pushed:
    - cibname: {{pcs.stonith_extra_cib}}
{% endif %}
