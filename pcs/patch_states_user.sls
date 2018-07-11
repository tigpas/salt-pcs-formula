minion_patch_states_user:
  pkg.installed:
    - name: patch
  file.patch:
    {%- if salt['grains.get']('os_family') == 'RedHat' %}
    - name: /usr/lib/python2.7/site-packages/salt/states/user.py
    {%- else %}
    - name: /usr/lib/python2.7/dist-packages/salt/states/user.py
    {%- endif %}
    - source: salt://pcs/files/patch_states_user_2018.3.2.patch
    - hash: 166e19348c12b69e406e19611e3d5087341ba4c4597ad94bfa766577dca67036
