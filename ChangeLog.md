# Changelog:
* **1.1.8**
    - Fixing shutdown fail on huge virtual server amount
    - Fixing internal threading library bug (Thread.join(<timeout>) didn't wait, possible crashes!)
    - Fixed terminal "crash" on TeaSpeak crash while its in minimal mode
    - Fixed some possible shutdown crashes
    
* **1.1.7**
    - Fixed some SQL stuff (internal library)
    - Fixed incorrect/missing permissions `serversnapshotcreate` and `serversnapshotdeploy`
    - Added some display values when you create a music bot
    
* **1.1.6**
    - Fixed (re)join default channel by path
    - Increasing numbers instead appending a '1' on client join
    - Implement a web auto forward (if you try to connect to the WS port)
    - Fixed possible crash with ssl connections
    - Caching the permission if a client is allowed to speak
    
* **1.1.5**
    - Now loading *all* data from `serversnapshotdeploy` (still not override's old serverId)
    - Implement command `serversnapshotcreate` (useable for TeaSpeak)
    
* **1.1.4**
    - Improved music bots (Using half of the performance now)
    - Some Web client updates (SSH certificate is now configurable (You require a up2date))
    - Music bots buffering
    - Fixed file client hangup on disconnect
    - *Huge* (1/2) sql improvements (Thanks to @[lexesv](https://github.com/lexesv))
        - Server's starting now much faster
    
* **1.1.3**
    - Just an private increment (cause i switch my PC)
    
* **1.1.2**
    - Fixed geo location!
    - Fixed libyaml (not requires gcc-6 anymore)
    
* **1.1.1**
    - Fixed server hangup on stop
    - Implemented a configurable log system (log per server)
    - Fixed teastart_minimal.sh (Some systems dosnt support select)
    
* **1.1.0***
    - Server version for the TeaSpeak Web client :)
    - New property `virtualserver_web_host` and `virtualserver_web_port`
        By default `virtualserver_web_host` is equal to `virtualserver_host` and
        `virtualserver_web_port` is the `virtualserver_port` multiplied with 2 (e.g. standard port: 19974)
    - Rewrote client initialise system (hopefully client isn't crashing anymore)
    - Fixed channel tree bug (similar to the one in 1.0.27b)
    - Fixed 100% CPU usage (sometimes)
    - Fixed several music bot crashes
    - Fixed `teastart.sh`
    - Fixed music bot hangup
    - Fixed server snapshot deploy (now testing hash and striping string)
    - Fixed channel & server group icon
    - Fixed server binding issues
    - Fixed `servercreate` command
    
* **1.0.29b***
    - Fixed channel tree crash on root channel change
    - Merge all build into a new version
    - TeaSpeak nearly stable :)
    - Fixed a `serversnapsotdeploy` bug (v. 1)
    - Fixed query `notifyclientupdated` without subscription
    
* **1.0.28b**
    - Merged io loops globally
    - Fixed query group client removement
    - Impelemented support for global group assignment (assign while bound to server 0)
      Commands wich could be used unbound to a server:
        - `servergroupaddclient [sid=0]`
        - `servergroupdelclient [sid=0]`
        - `servergroupclientlist [sid=0]`
    - Improved crashlog
    - Fixed critical crash in library (Fixed in build 12)
    
* **1.0.27b**
    - Increased slot limit to 1024
    - Fixed talk power issue
    - Fixed critical channel tree bug
    - Fixed another crash
    - Add a server start delay for performance improvements
    - Fixed possible crash on disconnect
    - Fixed several threading bugs
    - Changed build system number assignment a littlebit (attached a release number behind)
    - Validate group add data
    - Validate client db ids when they given by the client
    - Fixed variable cross initialisation bug
    - Removed a race condition
    - Implemented `serverinstance_serverquery_ban_time`
    
* **1.0.26b**
    - Added a config option to limit the command handle threads
    - Fixed YatQA grant permission
    - Fixed general grant permission bug
    - Sql API rewrite
    - Fixed *critical* mutex issue (Thread library)
    - Fixed music bot forward and rewind
    - Fixed server hang up on license request (if failed)
    
* **1.0.25b**
    - Added an auto restart script (`teastart_autorestart.sh`)
    
* **1.0.24b**
    - Fixed group rename
    - Fixed query group assignment (if assigned with a server then server bound only)
    - Updating displaying server version in the config, if not otherwise specified
    - Implemented geo location lookup
    - Fixed music bot performance issue
    - Fixed grant permissions (got deleted to if the perm was removed)
    - Graping channel commands only if they start with one point
    - Added new command to the terminal `permgrant`
        * Usage: `permgrant <ServerId> <GroupId> <Permission Name> <Grant>`
        * Description: Update a groups grant permission (may when you failed your grant permission)
    - Fixed channel crash
    - Moved VoiceServer ticker to an instance ticker
    - Merged the old instance ticker into the new instance ticker
    - Fixed disconnect|cmd handle server crash
    - Implemented query ban system
    - Fixed several query commands
    - Fixed log. (Directly writing now)
    - Fixed query token list
    - Fixed virtual server client/query count
    - Fixed channel group modify grant permission
    - Fixed (possible) client crash on join (not 100% sure but should be)
    
* **1.0.23b**
    - Fixed grant permission for `b_client_music_channel_list`
    - Fixed grant permission for `b_client_music_server_list`
    - Added new permission `b_virtualserver_modify_music_bot_limit`
    - Added new server property `virtualserver_music_bot_limit`
    - Big music bot update
        - Improved Youtube (streaming now not downloading)
        - Added stream support
        - Added Youtube stream support (May not working because of Googlevideo stuff)
        - Added volume support
    - Moved RSA puzzle from a single vs instance to global
    - Some little performance improvements
    - Fixed small channel delete crash
    
* **1.0.22b**
    - Make mute notify configurable
    - Fixed query connection spam crash
    - Added global join limit and some join improvements
    - Disconnect client on handshake fail (with reason)
    - Fixed default setup with no music bot permissions
    
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
