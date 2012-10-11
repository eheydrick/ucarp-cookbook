Description
===========

Manages ucarp IP failover on Linux.

Requirements
============

Currently supports Debian and Ubuntu style networking.

Attributes
==========

* vid - ID of the virtual server, defaults to 1
* password - ucarp password
* advskew - advertisement skew in seconds, defaults to 1 for master
* advbase - advertisement interval in seconds, defaults to 1
* master - true if this node is the master

Usage
=====

Add the ucarp recipe to the runlist. Specify site configuration
with node attributes.

Example role for a master:

    name "ucarp_master"
    description "Role for ucarp master"
    run_list([
      "recipe[ucarp]"
    ])

    override_attributes({
      :ucarp => { 
        :password => "sekret",
        :vip => "192.168.122.10",
        :netmask => "255.255.255.0",
        :master => true
      }
    })
