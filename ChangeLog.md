# Changelog:
* 1.0.5b:
    - automatically get local address and bind on it
    - Performance improve (-20% CPU)
    - Using a thread pool for client packet handling
    - server binds (if not defined elsewhere) on default assigned server address. Not on localhost anymore
    - reenabled weblist reports
    
- 1.0.6b
    - fixed shutdown hangup bug.
    - using libevent for query and file client as well (performance improve)
    
* 1.0.7b:
    - fixed ThreadPool library
    - fixed snapshotdeploy again.
        - invalid group remapping
        - server crash
        - invalid permissions remapping
    - fixed server admin group assignment on server 0
    - fixed "The icon for client [...] was not found."
    - fixed ack/and join spam crash
    - fixed packet queue deadlock
    - fixed perma ban
    - fixed channel merge on corrupt tree
    - Implemented a config file
    
* 1.0.8b:
    - removed useless zeros from log timestamp
    - fixed shutdown crash/hangup
    - implement name ban regex
    - fixed invalid config read. Nobody could join
    
* 1.0.9b:
    - Added the property Query::MOTD to the config
    - Implemented the new query notify-system
    
* 1.0.10b:
    - Fixed channel rename duplicated name bug
    - Added new config options
    
* 1.0.11b:
    - More messaged configurable in config
    - rewrote dbid structure
    - added global bans
    - Fixed ban system
    - some small fixes
    - Created new command `banedit`
    - Fixed invalid client id
    - fixed client properties crash
    - fixed default enabled events
    - Added file transfare permissions & fixed channel password
    
* 1.0.12b
    - Channel subscribe|unsubscribe hotfix
    - Possible server crash fixed
    - Fixed shutdown hangup
    - Moved protocol log to trace
