# Changelog:
* **1.0.21b**
    - Fixed hang up on badge control
    - Fixed channel create with order id
    - Fixed join crash bug
    - Fixed broken channel tree recover tool (subchannels got shuffled on restart)
    
* **1.0.20b**
    - Fixed critical server snapshot deploy
    - Added possibility to kick client on invalid badges
    - Implemented permission grant system
    - Implement permission grant system in server snapshots
    - Moved annoying invalid handshake to debug
    
* **1.0.19b**
    - Released music bot system (test if yourself with .mbot <command>)
    - implemented sticky option
    - fixed a little server crash
      
* **1.0.18b**:
    - ~ unknown ~

* **1.0.17b**:
    - Fixed spelling mistake in default group
    - Fixed static port in weblist. Now showing real server port
    - Forcing the user to start the server on first time with the minimal script
    - Direct start server after creation
    - Renamed `sender` in `notifyplugincmd` to `invokerid`
    - Added property `invokerids` in `notifyconnectioninforequest`
    - Sending by default two query lines for TS3 query support (most programs try to receive 2 lines)
    - Fixed the `servernapshotdeloy` function
    - Fixed `CELT Mono` codec (Not transmitting)
    
* **1.0.16b**:
    - Implemented licensing system for the premium licensing :)
    
* **1.0.15b**:
    - Fixed possible server crash
    
* **1.0.14b**:
    - Fixed the query server (didn't work anymore... i just accidentally deleted one line of code :/)
    
* **1.0.13b**:
    - Fixed subchannel deletion crash
    
* **1.0.12b**:
    - Channel subscribe|unsubscribe hotfix
    - Possible server crash fixed
    - Fixed shutdown hangup
    - Moved protocol log to trace
        
* **1.0.11b**:
    - More messaged configurable in config
    - Rewrote dbid structure
    - Added global bans
    - Fixed ban system
    - Some small fixes
    - Created new command `banedit`
    - Fixed invalid client id
    - Fixed client properties crash
    - Fixed default enabled events
    - Added file transfer permissions & fixed channel password
        
* **1.0.10b**:
    - Fixed channel rename duplicated name bug
    - Added new config options
        
* **1.0.9b**:
    - Added the property Query::MOTD to the config
    - Implemented the new query notify-system
        
* **1.0.8b**:
    - Removed useless zeros from log timestamp
    - Fixed shutdown crash/hangup
    - Implement name ban regex
    - Fixed invalid config read. Nobody could join
        
* **1.0.7b**:
    - Fixed ThreadPool library
    - Fixed snapshotdeploy again.
        - Invalid group remapping
        - Server crash
        - Invalid permissions remapping
    - Fixed server admin group assignment on server 0
    - Fixed "The icon for client [...] was not found."
    - Fixed ack/and join spam crash
    - Fixed packet queue deadlock
    - Fixed permanent ban
    - Fixed channel merge on corrupt tree
    - Implemented a config file
        
* **1.0.6b**:
    - Fixed shutdown hangup bug.
    - Using libevent for query and file client as well (performance improve)
    
* **1.0.5b**:
    - Automatically get local address and bind on it
    - Performance improve (-20% CPU)
    - Using a thread pool for client packet handling
    - Server binds (if not defined elsewhere) on default assigned server address. Not on localhost anymore
    - Reenabled weblist reports
    
* **1.0.4b**:
    - ~ private ~
    
* **1.0.3b**:
    - ~ private ~
    
* **1.0.2b**:
    - ~ private ~
    
* **1.0.1b**:
    - ~ private ~
    
* **1.0.0b**:
    - ~ private ~
