minion_patch_states_pcs:
  pkg.installed:
    - name: patch
  file.patch:
    {%- if salt['grains.get']('os_family') == 'RedHat' %}
    - name: /usr/lib/python2.7/site-packages/salt/states/pcs.py
    {%- else %}
    - name: /usr/lib/python2.7/dist-packages/salt/states/pcs.py
    {%- endif %}
    - source: salt://pcs/files/patch_states_pcs_2018.3.0.patch
    - hash: bef57f9b01772d4a5230ea8c119c35f5ba09d903ca06d9ba4c55794a5df34b17
