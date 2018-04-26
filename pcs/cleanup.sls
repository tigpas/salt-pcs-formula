pcs_cleanup__set_maintenance:
  pcs.prop_has_value:
    - prop: maintenance-mode
    - value: true
    - onlyif: ls /etc/corosync/corosync.conf

pcs_cleanup:
  cmd.run:
    - name: systemctl stop pacemaker corosync; rm -Rf /etc/corosync/corosync.conf /var/lib/pacemaker/cib/*
