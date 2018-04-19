minion_patch_states_user:
  pkg.installed:
    - name: patch
  file.patch:
    {%- if salt['grains.get']('os_family') == 'RedHat' %}
    - name: /usr/lib/python2.7/site-packages/salt/states/user.py
    {%- else %}
    - name: /usr/lib/python2.7/dist-packages/salt/states/user.py
    {%- endif %}
    - source: salt://pcs/files/patch_states_user_2018.3.0.patch
    - hash: 7cd5a9041085dc19b5ae9ba901446d5f261af08cc4cded5e81fee80002bafee0
