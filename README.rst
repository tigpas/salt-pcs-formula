================
salt-pcs-formula
================

A saltstack formula that can install pcs (pacemaker configuration system)
Along with pcs pacemaker and corosync are installed.
With pcs pacemaker and corosync can be configured.
This includes creating resources.

.. note::

    This module is a WIP. 
    Creating resources shouldn't break existing resources.

Available modules
=================

.. contents::
    :local:

``pcs``
------------

call pcs commands

Available state modules
=======================

.. contents::
    :local:

``pcs``
------------

pcs commands for use in salt state files (sls)

Available states
================

.. contents::
    :local:

``pcs``
------------

Installs the pcs package, and starts the associated pcsd service.

``pcs.resources``
------------

Configures pacemaker resources.

``pcs.orchestration``
------------

Set PCS in maintenance mode, cleanup the hole cluster config and will recreate the cluster config.
On masterless salt: You must run pcs.cleanup on all other nodes, before you can run pcs.orchestration on admin node (first node in node list)
