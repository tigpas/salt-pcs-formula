#!jinja|yaml
{% if salt['pillar.get']('pcs:lookup:node_ids') -%}
{%     set node_ids = salt['pillar.get']('pcs:lookup:node_ids') -%}
{% else -%}
{%     set node_ids = [] -%}
{%     for v in salt['pillar.get']('pcs:lookup:nodes') -%}
{%         do node_ids.append(v.split(',')[0]) -%}
{%     endfor -%}
{% endif -%}
{% set admin_node_id = node_ids[0] -%}

# node_ids: {{node_ids|json}}
# admin_node_id: {{admin_node_id}}

pcs_orchestration__install:
  salt.state:
    - tgt: {{node_ids|json}}
    - tgt_type: list
    - expect_minions: True
    - saltenv: {{saltenv}}
    - sls: pcs

pcs_orchestration__cleanup:
  salt.state:
    - tgt: {{node_ids|json}}
    - tgt_type: list
    - expect_minions: True
    - saltenv: {{saltenv}}
    - sls: pcs.cleanup
    - require:
      - salt: pcs_orchestration__install

pcs_orchestration__auth:
  salt.state:
    - tgt: {{admin_node_id}}
    - expect_minions: True
    - saltenv: {{saltenv}}
    - sls: pcs.auth
    - require:
      - salt: pcs_orchestration__install

pcs_orchestration__setup:
  salt.state:
    - tgt: {{admin_node_id}}
    - expect_minions: True
    - saltenv: {{saltenv}}
    - sls: pcs.setup
    - require:
      - salt: pcs_orchestration__auth

pcs_orchestration__properties:
  salt.state:
    - tgt: {{admin_node_id}}
    - expect_minions: True
    - saltenv: {{saltenv}}
    - sls: pcs.properties
    - require:
      - salt: pcs_orchestration__setup

pcs_orchestration__stonith:
  salt.state:
    - tgt: {{admin_node_id}}
    - expect_minions: True
    - saltenv: {{saltenv}}
    - sls: pcs.stonith
    - require:
      - salt: pcs_orchestration__properties

pcs_orchestration__resources:
  salt.state:
    - tgt: {{admin_node_id}}
    - expect_minions: True
    - saltenv: {{saltenv}}
    - sls: pcs.resources
    - require:
      - salt: pcs_orchestration__stonith
