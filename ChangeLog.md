# Changelog:
* **1.3.8b**
    - Fixed sinusbot issues, which was related to a fundamental issues
    - Improved the web client disconnect (prevent hangup)
    
* **1.3.7b**
    - Fixed crash on too long command packets
    - Fixed issue with multible IP bindings ([#F1753](https://forum.teaspeak.de/index.php?threads/how-to-add-multiple-ips.1753/))
    - Fixed bug that first ban dosn't work
    - Fixed CPU issues (Hopefully)
    
* **1.3.6b**
    - Improved internal buffer handling and allocations (try to decrease memory fragmentation)
    - May fixed issue [#556](https://github.com/TeaSpeak/TeaSpeak/issues/556) 
    - Fixed issue [#560](https://github.com/TeaSpeak/TeaSpeak/issues/560)
    - Restrict server bound queries to their server ([#566](https://github.com/TeaSpeak/TeaSpeak/issues/566))
    - Fixed issue [#565](https://github.com/TeaSpeak/TeaSpeak/issues/565)
    - Fixed serverlist bug ([#F1737](https://forum.teaspeak.de/index.php?threads/teaspeak-1-3-5-beta-serverlist-bug.1737))
    - Fixed server crash related to the music bots (assert fail)
    
* **1.3.5b**
    **ATTENTION**: I may recommend to create a sql backup before
    - Fixed talk power issues for clientkick
    - Fixed playlist permission showing up in `permfind`
    - Fixed YatQA issue with `channelinfo` (added an alias for `pid`)
    For SQLite users (The MySQL drivers does not support that yet):
    - Added primaries keys to the tables `permissions` and `properties` to prevent double entries
    - Any database upgrades are not made with transactions to prevent data loss on failure
    - Added `install_music.sh` script
    - Fixed issue [#564](https://github.com/TeaSpeak/TeaSpeak/issues/564) ((re)connecting loses muted status)
    - Fixed issue [#560](https://github.com/TeaSpeak/TeaSpeak/issues/560) (Change password of serveradmin does not apply)
    
* **1.3.4b**
    - `playlistedit current_song_id=<id>` changes not the currently playing music bot the bot as well (if assigned)
    - Added property `playlist_max_songs` to playlists to limit the max amount of songs.
      The initial value is equal to the owners `i_max_playlist_size` permission
    - Added permission `i_max_playlists` to prevent playlist spam
    - Added permission `i_max_playlist_size` to limit the songs within a playlist
    - Improved error handling for the music bot (`failed to invoke next tick. Ticking lock is still acquired.`)
    - Improved TeaSpeak Client and Web identity handshake
    - Improved Query initialization
    
* **1.3.3b**
    - Added parameter `playlist_bot_id` in response for command `playlistlist`
    - When the music bot receives a play command, and the playlist had finished, the playlist will now restart again
    - Added FFMPEG auto reconnect option within the ffmpeg command
    - Fixed music bot shuffle mode
    - Fixed abnormal high `connection timeout` timeouts
    - Readded permission `b_client_use_priority_speaker` to keep some legacy compatibility
    - The optimized build uses now optimized libraries as well
    - Fixed that `client_uptime_mode` applies even after a restart
    - Fixed YT replay breaks (lead to an change within youtube's API)
    
* **1.3.2b**
    - Improved ping timeout (dont enforce a response anymore, but enforce command acks)
      This should improve the `dropped (No ping response)` thing
    - Improved channel view and subscribe mechanism, and prevent some client disconnects
    
* **1.3.1b**
    - Fixed invalid memory read issue while `clientgetconnectioninfo`
    - Permissions `b_client_ban_name` `b_client_ban_ip` `b_client_ban_hwid` are now optional
    - Fixed that some invisible channels haven't shown up after view power change
    - Improved timeout and reconnect strategy, now direct reconnect without waiting 20 seconds
    - Improved (any) DDOS protection
    - Fixed kick issue for missing parameters
    - Added `-permsid` switch to `channelpermlist`, `servergrouppermlist`, `channelgrouppermlist`, `clientpermlist` (Required for YatQA)
    - Does not longer timeout when the client remote address changes (e.g. proxy switch etc)
    - Added a poke on permission edit, to prevent issues with the TeamSpeak 3 client.
    
* **1.3b**  
    *General music bot update and permission update*  
    Note: This update mainly focuses the Music Bot and his API. There are some API breaking changes!  
    - Added config option to disable IP saving
    - Added virtualserver property to disable IP logging (`virtualserver_disable_ip_saving`)
    - Command `querychangepassword` now checks specially the permission `b_client_query_change_password_global` when trying to change a unbound query's password (e.g. `serveradmin`)
    - Fixed issue [#530](https://github.com/TeaSpeak/TeaSpeak/issues/530)
    - Fixed issue [#537](https://github.com/TeaSpeak/TeaSpeak/issues/537) (Bantime gets miscalculated on flood bans)
    - Fixed issue [#540](https://github.com/TeaSpeak/TeaSpeak/issues/540) (`serverinfo` used wrong permissions)
    - Fixed issue [#536](https://github.com/TeaSpeak/TeaSpeak/issues/536) (Talk Power Request greyed out but possible)
    - Fixed issue [#542](https://github.com/TeaSpeak/TeaSpeak/issues/542) (Disconnected (not connected) for no reason)
    - Implemented issue [#541](https://github.com/TeaSpeak/TeaSpeak/issues/541) (alias `reasonmsg` for `serverprocessstop`)
    - Improved `clientedit` and `clientupdate` handling
    - Implemented issue [#M4](https://github.com/TeaSpeak/TeaMusic/issues/4) ("normal" music bot UID's)
    - Implemented issue [#M2](https://github.com/TeaSpeak/TeaMusic/issues/2) (Possibility to grant channel commander)
    - Implemented issue [#M6](https://github.com/TeaSpeak/TeaMusic/issues/6) (Added option to choose the online since mode for music bots)
    - Implemented issue [#M9](https://github.com/TeaSpeak/TeaMusic/issues/9) (Made the music bot version editiable via `clientedit` (properties: `client_version` `client_platform`))
    - Implemented issue [#M11](https://github.com/TeaSpeak/TeaMusic/issues/11) (Implemented bot types (bots which gets deleted when the owner leaves))
    - Implemented issue [#M8](https://github.com/TeaSpeak/TeaMusic/issues/8) (Send a notify on song change)
    - Implemented issue [#M16](https://github.com/TeaSpeak/TeaMusic/issues/16) (Max volume via permission)
    - Implemented issue [#M18](https://github.com/TeaSpeak/TeaMusic/issues/18)
        - Added music bots and playlists to server snapshots
        - Snapshot version is now 2
    - Improved music bot sound ending (Now smooth ending and not like a timeout)
    - Reworked music bot song replay system (Now using a playlist instead of a queue)
    - Renamed permission `b_client_is_priority_speaker` to `b_client_use_priority_speaker`
      Priority speaker could be activated via `clientupdate client_is_priority_speaker=<flag>`
    - Improved `getconnectioninfo`. Now you dont have to wait one second to receive the information
    - Fixed bug that channel admins are allowed to assign channel groups within another channel
    - Fixed command `permfind`
        - Showing client channel rights
        - Allow `permid` | `permsid` to be an array
        - Works with YatQA (Newest TeaSpeak version)
    - Added or implemented new commands:
        - `permoverview`
        - `playlistlist`
        - `playlistcreate`
        - `playlistdelete`
        - `playlistpermlist`
        - `playlistaddperm`
        - `playlistdelperm`
        - `playlistinfo`
        - `playlistedit`
        - `playlistsonglist`
        - `playlistsongadd`
        - `playlistsongreorder`
        - `playlistsongremove`
        - `musicbotplaylistassign`
    - Added new permissions:
        - `b_playlist_create`
        - `i_playlist_view_power`
        - `i_playlist_needed_view_power`
        - `i_playlist_modify_power`
        - `i_playlist_needed_modify_power`
        - `i_playlist_delete_power`
        - `i_playlist_needed_delete_power`
        - `i_playlist_song_add_power`
        - `i_playlist_song_needed_add_power`
        - `i_playlist_song_remove_power`
        - `i_playlist_song_needed_remove_power`
        - `i_playlist_song_move_power`
        - `i_playlist_song_needed_move_power`
        - `b_virtualserver_playlist_permission_list`
        - `i_playlist_permission_modify_power`
        - `i_playlist_permission_needed_modify_power`
        - `b_client_query_change_password_global`
    - Fixed global `channellist` sort oder (YatQA)
    - Fixed duplicated permission entries within the database for client and client channel permissions
    - Improved permission calculation for commands: (Using cached permissions now)
      This should improve the server performance, specially on channel chat or poke spam
        - `serveredit`
        - `serverrequestconnectioninfo`
        - `servergrouplist`
        - `clientedit`
        - `clientupdate`
        - `clientpoke`
        - `sendtextmessage`
        - `channelcreate`
        - `channeledit`
        - `channelpermlist`
        - `servergroupcopy`
        - `servergroupadd`
        - `servergrouprename`
        - `servergroupdel`
        - `servergroupclientlist`
        - `servergroupaddclient`
        - `servergroupdelclient`
        - `servergrouppermlist`
        - `servergroupaddperm`
        - `servergroupdelperm`
        - `ServerGroupAutoAddPerm`
        - `ServerGroupAutodelPerm`
        - `channelgroupadd`
        - `channelgroupcopy`
        - `channelgrouprename`
        - `channelgroupdel`
        - `channelgrouplist`
        - `channelgroupclientlist`
        - `channelgrouppermlist`
        - `channelgroupaddperm`
        - `channelgroupdelperm`
        - `banlist`
        - `banadd`
        - `banclient`
        - `bandel`
        - `bandelall`
        - `bantriggerlist`
        - `tokenlist`
        - `tokenadd`
        - `tokenuse`
        - `tokendelete`
        - `clientdblist`
        - `clientdbinfo`
        - `clientdbfind`
        - `complainlist`
        - `complaindel`
        - `complaindelall`
        - `clientlist`
        - `clientinfo`
        - `messageadd`
        - `permget`
        
* **1.2.34b**
    - Fixed critical vulnerability  (discovered by @Bluscream)
    - Fixed issue [#524](https://github.com/TeaSpeak/TeaSpeak/issues/524) (Bans and bantrigger list does not get deleted on server deletion)
    - Implemented issue [#523](https://github.com/TeaSpeak/TeaSpeak/issues/523) (property `client_nickname` within `use` to improve third party compatibilities)
    - Added custom shutdown delay messages
    - Added script to use the precompiled up2date libnice version. WebClient should work with that
    - Fixed issue [#527](https://github.com/TeaSpeak/TeaSpeak/issues/527)
    - Added possibility to assign channel commander to a bot (`clientedit clid=<botid> client_is_channel_commander=<flag>`)
    
* **1.2.33b**
    - Fixed bug with join limits (zero means now unlimited)
    - Added new permissions:
        - `i_server_group_self_add_power`
        - `i_server_group_self_remove_power`
        - `i_channel_group_self_add_power`
        - `i_channel_group_self_remove_power`
    - Fixed crash (sometimes when the web client disconnected)
    - Fixed handup (sometimes when the web client disconnected)
    - Fixed bug, that music bot dont get deleted when the server gets deleted
    - Fixed some permissions issues (Now enforcing/testing for an explicit set)
    - Fixed hidden non premium config settings 
    
* **1.2.32b**
    - Added an advanced query management system (`query_list`, `query_create`, `query_delete`, `query_rename`, `querychangepassword`)
    - Added new permissions:
        - `b_client_query_create`
        - `b_client_query_list`
        - `b_client_query_list_own`
        - `b_client_query_rename`
        - `b_client_query_rename_own`
        - `b_client_query_change_password`
        - `b_client_query_change_own_password`
        - `b_client_query_delete`
    - Server bounded queries are now directly logged on to their "home" server
    - Implemented server side check of the `i_client_ban_max_bantime` permissions
    - Fixed crash ony query group copy
    - Switching to default license, if the given premium license is expired
    
* **1.2.31b**
    - Added config option to force override the voice server ips
    - Added config option to hide not visible clients compleatly
    - Fixed TeaSpeak UDP isnt working within win 10 sub systems
    - Changed database (sqlite) synchronise mode to full (Hopefully prevents data loss)
    - Improved license request fail handle
    
* **1.2.30b**
    - Fixed weblist showing wrong server password settings
    - Renamed every parameter `botid` to `bot_id`
    - Renamed every parameter `songid` to `song_id`
    - Added switch `-bulk` in `musicbotqueuelist` to send the data as one line with `|`
    - Added property value `any` or `-1` for `type` within `musicbotqueueadd` to autodetect the best provider
    - Fixed `virtualserver_filebase` property
    - Added that the weblist now shows the correct state for channel creation
    - Added properties ... to `clientinfo`
        - connection_packets_sent_total
        - connection_bytes_sent_total
        - connection_packets_received_total
        - connection_bytes_received_total
        - connection_packetloss_total
        - connection_server2client_packetloss_total
        - connection_client2server_packetloss_total
        - connection_bandwidth_sent_last_second_total
        - connection_bandwidth_sent_last_minute_total
        - connection_bandwidth_received_last_second_total
        - connection_bandwidth_received_last_minute_total
        - connection_filetransfer_bandwidth_sent
        - connection_filetransfer_bandwidth_received
        - connection_filetransfer_bytes_received_total
        - connection_filetransfer_bytes_sent_total
    - Fixed libevent hangup on release build (missed initialisation call)
    - Returning database_empty_result on `musicbotqueuelist` when the list is empty
    - Fixed song id generation
    - Renamed (fix) `manager` as `event` to `client` within `servernotify(register|unregister|list)`
    - Added possibility to change the music bots volume via `clientedit` (`player_volume=0.1`)
    - When a query is in godmode and executes `clientmove` on himself he gets visible
    - Changed default country (property `client_country`) from `none` to `TS` (`TS` is unassigned)
    - Added command `musicbotsetsubscription bot_id=[0|<bot id>]` to enable/set subscribed bot and receive status updates when playing
    - Improved ffmpeg property detection (decreased log error spam)
    - Improved `Music bot contained empty frame!` message spam
    - Fixed license check hangup (2x), added connect timeout, and fixed crash on deallocation
    - Fixed instance hangup on force quit
    - Added the possibility to set the default `virtualserver_host` and `virtualserver_web_host` within the config.yml
    
* **1.2.29b**
    - Fixed WebList and server stop/delete bug.
    - Fixed 'invalid channels flags' when you set a password to the default channel
        
* **1.2.28b**
    - Fixed invalid memory read on printing error information form malformed packets (possible crash)
    - Fixed issue [#500](https://github.com/TeaSpeak/TeaSpeak/issues/500)
    - Added a timestamp for query connect. Queries now have an online time
    - Improved server create algorithm, port selection seeded up (> 100VS)
    - Removed unnecessary sqlite errors
    - Fixed a possible crash on serverstop, when clients are connected to the server
    
* **1.2.27b**
    - Improved the weblist client and added a global config option to disable the TeamSpeak weblist
    - Fixed web voice bridge for firefox
    - Fixed potential crash on query server switch
    - Implemented command `ftgetfileinfo`
    - Improved error handling on invalid db properties
    - Added "quick exit" mode when shutdown signal was triggered more than two times
    - Fixed property `connection_connected_time` on `clientinfo`
    - Fixed GLIBC minimum version
    - Fixed YT-DL startup spam
    - Fixed critical error for internal bots
    
* **1.2.26b**
    - Improved server ticking for temporary channels
    - Improved log handling (async log now) => Should speedup some processes
    - Fixed `virtualserver_query_client_connections` counter
    - Fixed client disconnect on double subchannel deletion
    - Implemented client property (`client_flag_talking`)
    - Added parameter `client_talk_power` to `clientlist -voice`
    - Added the possibility to edits a music bot client name via `clientedit` with the property `client_nickname`
    
* **1.2.25b**
    - Added permissions `b_client_ban_name`, `b_client_ban_ip`, `b_client_ban_hwid`
    - Return correct ban ID array on `banclient`
    - Added array handling within info request for commands `clientinfo`, `clientdbinfo`, `clientgetids`, `clientgetdbidfromuid`, `clientgetnamefromdbid`, `clientgetuidfromclid`
    - Added `cid` to `clientinfo`
    - Fixed `i_needed_modify_power_...` permission resolving
    - Fixed missing error for empty database for command `permfind`
    - Implemented `permfind` for `i_needed_modify_power` queries
    - Fixed file transfer fail for small files ([#482](https://github.com/TeaSpeak/TeaSpeak/issues/482))
    - Fixed music bot youtubdl module detecting youtube urls again
    
* **1.2.24b**
    - Grouped Web IO threads (configurable of cause)
    - Implemented support to override config options via command line
    - Improved config error handling
    - Added specific soundcloud replay support (`.mbot soundcould <url>`)
    - Added command line config overrides
    - Fixed bans for empty hardware id's. Not ban a empty id by `hwid=empty`
    - Fixed issue ([#481](https://github.com/TeaSpeak/TeaSpeak/issues/481))
    - Fixed premium config settings
    - Added `i_group_is_permanent` as default permission
    - Added possibility to define ice servers and local port ranges for the web client
    
* **1.2.23b**
    - Fixed stability issues within 22 :)
    - Added parameter `hwid` on `banlist`
    - Added the possibility to edit the `hwid` on `banedit`
    - Added synonym for `reason` on `banedit` (`banreason`)
    - Added flags on `banclient` (`no-nickname`, `no-hardware-id`, `no-ip`)
     
* **1.2.22b**
    - Fixed client disconnects on client channel switch
    - Some small improvements
    - Speeded up loading process
    - Fixed channel tree remerge on broken channel tree

* **1.2.21b**
    - Fixed ip v6 binding and MTU issue
    - Improved buffer strategies
    - Fixed music bot crash on delete
    - Fixed issue [#476](https://github.com/TeaSpeak/TeaSpeak/issues/476)
    - Removed autoban for display name on `banclient`
   
* **1.2.20b**
    - Several webclient improvements (stability as well)
        Should be now useable with TeaSpeak-Server without crashing :)
    - Implemented issue [#467](https://github.com/TeaSpeak/TeaSpeak/issues/467)
    - Fixed music bot crash on delete
    - Improved file transfer error handling on file opening
    - Improved error handling for eliminating the `invalid clientID` disconnect
    - Fixed issue [#367](https://github.com/TeaSpeak/TeaSpeak/issues/367)  
      **Important:** Update your server to beta 2!
      
* **1.2.19b**
    - Implemented native audio streaming for the web client (**No "robovoice" again**)
    - Fixed crash on web client disconnect
    - Don't ask for the default privilege key anymore, if it doesn't exists
    - Fixed file transfer instance hangup
    - Fixed issue [#422](https://github.com/TeaSpeak/TeaSpeak/issues/442)
    - Fixed query interface for `serverprocessstop`
    - Fixed client disconnect when own channel becomes theoretically invisible
    - Fixed address using on server stop, when a music bot is running
    
* **1.2.18b**
    - Fixed ban issue with internal ban id's
    - Implemented ban trigger count and log
    - Added command `bantriggerlist`
    - Implementing permission `b_client_use_channel_commander`
    - Fixed crash according to global groups assignments
    
* **1.2.17b**
    - Added permission `b_virtualserver_modify_default_musicgroup`
    - Added permission `b_channel_ignore_join_power`
    - Fixed config version auto update
    - Fixed file transfer and server hangup issue
    - Implemented music provider configurations
    - Added permission `b_virtualserver_select_godmode`
    - Fixed crashes from issue [#432](https://github.com/TeaSpeak/TeaSpeak/issues/432)
    - Implemented issue [#161](https://github.com/TeaSpeak/TeaSpeak/issues/161)
    
* **1.2.16b**
    - Improved error handling on double database access
    - Implemented the full whisper system
    - Made commands `serveredit` and `serverinfo` accessible globally
    - Implemented server property template implementation
    - Fixed weblist report
    - Fixed issue [#420](https://github.com/TeaSpeak/TeaSpeak/issues/420) (Snapshot incorrectly transfers server settings)
    - Implemented [#350](https://github.com/TeaSpeak/TeaSpeak/issues/350)
    - Added command line parameters `--set_query_password` and `--help` [#404](https://github.com/TeaSpeak/TeaSpeak/issues/404)
    
* **1.2.15b**
    - Implemented file transfer bandwidth
    - Implemented file transfer quotas
    - Implemented monthly and global static saving and resetting
    - Implemented permissions:
        - `b_virtualserver_channelgroup_list`
        - `b_virtualserver_servergroup_list`
        - `b_virtualserver_select`
        - `b_icon_manage` (On file listing)
    - Fixed channel tree rebuild crash
    Beta 7:
        - Fixed invalid channel order
        - Fixed invalid quotas (Disconnect on file transfare)
        - Fixed `serversnapshotdeploy`
        
* **1.2.14b**
    - Fixed too long channel name
    - Fixed override of query passwords
    - Improved move/switch logic
    
* **1.2.13b**
    - Fixed memory leak
    - Fixed issue [#347](https://github.com/TeaSpeak/TeaSpeak/issues/347)
    - Fixed issue [#333](https://github.com/TeaSpeak/TeaSpeak/issues/333)
    - Fixed issue [#362](https://github.com/TeaSpeak/TeaSpeak/issues/362)
    - Fixed issue [#361](https://github.com/TeaSpeak/TeaSpeak/issues/361)
    - Added debug messages for bans
    - Fixed not releasing port on server stopping
    - Fixed issue [#339](https://github.com/TeaSpeak/TeaSpeak/issues/339)
    - Fixed issue [#368](https://github.com/TeaSpeak/TeaSpeak/issues/368)
    - Implemented permissions `i_channel_max_depth` and `i_channel_min_depth` ([#377](https://github.com/TeaSpeak/TeaSpeak/issues/377))
    - Improved disconnect logic
    
* **1.2.12b**
    - Fixed issue with failed to move crash dump
    - Fixed nickname already in use issue on double connect
    - Fixed channel name already in use
    - Fixed version [#349](https://github.com/TeaSpeak/TeaSpeak/issues/349) (Fixed query notifies for `servergroupadd` and `servergroupdel`)
    
* **1.2.11b**
    - Added property:
        - `serverinstance_template_musicdefault_group`
        - `virtualserver_default_music_group`
    - Implemented permission `b_virtualserver_connectioninfo_view`
    - Implemented permission `b_serverinstance_info_view`
    - **Fixed client invalid parameter bug with invisible channels!**
    - Fixed server hangup in connection with web clients
    - `servergroupcopy` now check for permission `b_serverinstance_modify_querygroup` and `b_serverinstance_modify_templates`depends on the target
    - `servergroupcopy` now creates global query groups even when you're server bound
    - `channelgroupcopy` now check for permission `b_serverinstance_modify_querygroup` and `b_serverinstance_modify_templates`depends on the target
    - `channelgroupcopy` now creates global query groups even when you're server bound
    - Allow login when you're already logged in
    - Fixed issue [#346](https://github.com/TeaSpeak/TeaSpeak/issues/346)
    - Fixed permission test for ... when you upload a icon/avatar
        - `i_max_icon_filesize`
        - `i_client_max_avatar_filesize`
    
* **1.2.10b**
    - Improved internal packet management
    - Fixed sometimes first connect attempt timed out
    - Fixed memory leak [#316](https://github.com/TeaSpeak/TeaSpeak/issues/316)
    - Improved client disconnecting
    - Fixed issue [#319](https://github.com/TeaSpeak/TeaSpeak/issues/319)
    - Fixed issue [#314](https://github.com/TeaSpeak/TeaSpeak/issues/314) (Now updating the channel tree on perm add/removes)
    - Fixed issue [#307](https://github.com/TeaSpeak/TeaSpeak/issues/307)
    
* **1.2.9b**
    - Fixed issue [#302](https://github.com/TeaSpeak/TeaSpeak/issues/302) (Invalid permission handling with not granted and zero permissions)
    - Fixed possible channel tree crash when it comes to several synchronous actions
    - Fixed disappearing people on join ([#305](https://github.com/TeaSpeak/TeaSpeak/issues/305))
    - Fixed instance "hangup" when you deploy a snapshot and have just one virtual server
    - Fixed invalid characters disconnecting clients
    - Fixed channel creation on server 0
    
* **1.2.8b**
    - Fixed group sort id for id's over 255
    - Fixed missing channel join permission testing for `b_channel_join_*`
    - Fixed granted permission deletion
    - Fixed double server group adding on `tokenuse`
    - Added a config option to enable/disable the automatic icon deletion [#295](https://github.com/TeaSpeak/TeaSpeak/issues/295)
    - Implemented a config option to set the default voice server port [#294](https://github.com/TeaSpeak/TeaSpeak/issues/294)
    - Fixed talk power when its `-1`
    
* **1.2.7b**
    - Added new property: `client_myteamspeak_id`
    - Added option to suppress the myTeamSpeak error messages
    - Fixed channel tree crash
    - Improved connection handling
    - Fixed channel tree move
    - Fixed channel tree creation bug
    
* **1.2.6b**
    - Fixed the edibility of the default messages
      Hint: The web client has a GUI for that :)
    - Music bots are not banable anymore
    
* **1.2.5b**
    - Fixed serverquery event system
    - Several music bot improvements (for the WebClient)
    - Fixed issue with too long nicknames
    - Fixed web client crash on invalid client key!
    - Fixed avatar display
    - Fixed query cpu leak (Build 8)
    - Fixed bbcode detection
    
* **1.2.4b**
    - Using a build server now!
    
* **1.2.3b**
    - Using server 0 as template server.
      Now available for default channels and groups
        These commands are now available to change the templates:
        - `servergroupcopy`
        - `servergroupadd`
        - `servergrouprename`
        - `servergroupdel`
        - `servergrouppermlist`
        - `servergroupaddperm`
        - `servergroupdelperm`
        - `servergrouplist`
        - `channelgroupadd`
        - `channelgroupcopy`
        - `channelgrouprename`
        - `channelgroupdel`
        - `channelgrouplist`
        - `channelgrouppermlist`
        - `channelgroupaddperm`
        - `channelgroupdelperm`
        - `channellist`
        - `channelfind`
        - `channelinfo`
        - `channelcreate`
        - `channeldelete`
        - `channeledit`
        - `channelgetdescription`
        - `channelmove`
        - `channelpermlist`
        - `channeladdperm`
        - `channeldelperm`
        - `verifychannelpassword`
        
* **1.2.2b**
    - Fixed wrong implementation of `channelgroupclientlist`
    - Reimplemented the web client! (Unstable yet so its not recommended to use it within a production environment)
    - Fixed issue (invalid permission calculation on channel permissions) ([#241](https://github.com/TeaSpeak/TeaSpeak/issues/241))
    - Fixed convert error on invalid utf-8 characters (e.g. When you're running a music bot)
    - Fixed TCP_NO_DELAY (Can cause sometimes a "slow" query connection)
    
* **1.2.1b**
    - Fixed property `virtualserver_created`
    - Fixed invalid soft assertion at `ServerChannel.cpp:170`
    - Fixed speach (Cant send voice packets anymore after 20 when they are encrypted)
    - Implemented a limit/client for channels ([#247](https://github.com/TeaSpeak/TeaSpeak/issues/247))
        - New permissions:
            - `i_client_max_channels`  
            - `i_client_max_temporary_channels`  
            - `i_client_max_semi_channels`  
            - `i_client_max_permanent_channels` 
    - Fixed issue related with the default channel
    - Fixed issue ([#255](https://github.com/TeaSpeak/TeaSpeak/issues/255))
    - Fixed channel temp delete delay
    - Fixed channel subscribe power on perm not granted
    - Fixed VPN test for a range of only on ip address
    
* **1.2.0b**
    - Fixed server hangup on stop
    - Updated IP to location databases
    - Improved broken channel tree recovery and channel tree performance
    - Moved config entry `default_client_description` to a vs property (`virtualserver_default_client_description`) 
    - Moved config entry `default_channel_description` to a vs property (`virtualserver_default_channel_description`) 
    - Added property `virtualserver_default_channel_topic`
    - Fixed default serveradmin token creation
    - Fixed bb code bug (Upper and lowerchase bug)
    - Added "private"/invisible channel
        - New events:
            - `notifychannelhide`
            - `notifychannelshow`
        - New permissions:
            - `b_channel_ignore_view_power`
            - `i_channel_view_power`
            - `i_channel_needed_view_power`
        Notes:
            The channel visibility states updates only on a channel permission change  
            That means if a client/or group changes the permission `i_channel_view_power` he has to rejoin
            This also applies to server/channel groups.
            The reason for this is simple: To reduce the server sided load
    - Added VPN check support ([#85](https://github.com/TeaSpeak/TeaSpeak/issues/85))
        - New permission: `b_client_ignore_vpn`
    
* **1.1.41b**
    - Fixed server crash on snapshot deploy for override
    - Fixed query `permreset`
    - Fixed snapshot channel permissions
    - Implemented commands `servergroupautoaddperm` and `servergroupautodelperm`
    - If you don't have permissions to view ip's you don't will get any ip addresses
    - Testing for group add permission when you create a token
    - Added properties `client_total_online_time` and `client_total_online_time`
        - `clientlist -times`
        - `clientgetvariables`
        - `clientdbinfo`
    - Testing for `b_virtualserver_connectioninfo_view` on server connection info
    - Improved 3.1 protocol (Just applies for TeamSpeak 3 clients >= 3.2.0)
    
* **1.1.40b**
    - Improved server start
      Now caching everything so even *huge* server instance start's really fast (1000 VS < 40 sec)
    - Query starts again before all server are loaded, but it denies to create server until everything is loaded
    - Fixed deleted token appearing again after server restart
    - Implemented `logview`
    - Fixed `channel_icon_id` on `channeledit`
    - **Fixed memory leak within the query system**
    - **Fixed to many open files on query connections**
    - Fixed server crash on `banclient` if client isn't preset
    - Fixed `client_idle_time` in `clientinfo`
    - Fixed on huge server the server shutdown
    - Fixed music bot parameter ids
    
* **1.1.39b**  
    **Attention!:**   
    This build runs without the web client because im deploying it from my holiday PC
    This may even cause some mystic linking or dependency errors when you try to start the server
    
    Note: Build 1 is in release mode (so its much faster) 
    
    - Fixed invalid displayed permission when you dont have the permission to enter a url as bb code
    - Fixed bb code permission and mapping
    - Improved library linking and removed RPATH from executable
    - Don't tick empty server
    - Fixed issue [#225](https://github.com/TeaSpeak/TeaSpeak/issues/225)
    
* **1.1.38b**
    - Allow the user to define costume key chains for the server keypair
       Note: this only works when you enabled 3.1 support (`voice.protocol.experimental_31`)
    - Fixed `serversnapshotcreate`

* **1.1.37b**
    - Allow handling of voice packets parallel to command packets (should avoid voice hangup on complicated command)
    - Speeded (extremely) up permission calculation for needed permissions (significant at join or permission edit)
    - Speeded up client channel permission calculation
    - Increase join performance
    - Increase command performance of `permget`
    - Removed basic memory tracker for speed up
    - Fixed multithreading issue (within server tick. Could cause server crash)
    - Improved server tick performance (dont Whang up so long on client timeout)
    - Fixed write bug (delayed datagram writing)
    -- Summery --
    TeaSpeak is not running faster and also the sound should not be disturbed when its under heavy load
    
* **1.1.36b**
    - Fixed server crash on virtual server creation and deletion
    - Fixed voice client join and left message
    - Fixed invalid icon id of icon `4294967294` (Just `-2` which indicated a not preset permission)
    - Implemented crash handler again (for some reason i took him out)
    - First loading servers now than starting the query server
    - Fixed bug that clients can connect while server is shutting down 
    - Fixed global permissions does not work anymore
    
* **1.1.35b**
    - Fixed server crash's caused by heap buffer overflows
    - Fixed MySQL resource leak
    - Fixed query hangup on exit command
    Note: MySQL is still not the best solution. I recommend sqlite instead!
    
* **1.1.34b**
    - Implemented ip v6 (currently voice only)
    - Fixed that the server only bound to the main address and not on any addresses when its bound to 0.0.0.0
    - Improved music bot playback to avoid issue [#162](https://github.com/TeaSpeak/TeaSpeak/issues/162)
    - Implemented query white and black list
    - Implemented enchantment [#186](https://github.com/TeaSpeak/TeaSpeak/issues/186) (Output current volume instead of "Invalid volume!")
    - Fixed issue [187](https://github.com/TeaSpeak/TeaSpeak/issues/187)
    - Fixed invalid sqlite/mysql table setup65
    
* **1.1.33b**
    - Made invalid protocol kick messages configurable
    - Added tree new permissions
        - `b_client_use_bbcode_any`   Allows the client to use any bbcode within channel description
        - `b_client_use_bbcode_image`   Allows the client to use the img bbcode tag within channel description
        - `b_client_use_bbcode_url`   Allows the client to use url bbcode tag within channel description
    - Fixed invalid permission tree/- mapping
    - Implemented `b_client_skip_channelgroup_permissions`

* **1.1.32b**
    - Fixed issue (Check only private textmessage power when chat was closed) [#174](https://github.com/TeaSpeak/TeaSpeak/issues/174)
    - Fixed issue (Apply virtualserver's guest group to Server Query Guests) [#149](https://github.com/TeaSpeak/TeaSpeak/issues/149)
    - Fixed command `servergroupbyclientid`
    - Fixed ban deletion (now it does not delete active bans)
    - Implemented enchantment request [#151](https://github.com/TeaSpeak/TeaSpeak/issues/151) (Client HWID validation)
    - Improved default group assignment
    - Test on group deletion for default groups (server and instance)
    
* **1.1.31b**
    - Improved permission system and implemented skip & negate flag
    - Fixed missing grant permissions within the default file
    - Improved snapshot system
        - Importing TeamSpeak permissions better and migrate new permissions (based on `i_group_auto_update_type`)
        - Improved snapshot creation (using a better structure at some points)  
            For TeamSpeak compatibility use `version=0`. Note: This will also exclude **all** new permissions by TeaSpeak
            Default version is 1
    - Fixed query flood ignore system (it only updates when you joined a channel, not it applies everywhere) ([#167](https://github.com/TeaSpeak/TeaSpeak/issues/167))
    
* **1.1.30b**
    - Fixed several hangups
    - Fixed issue [#158](https://github.com/TeaSpeak/TeaSpeak/issues/158) (Music bot flag and online time)
    - Implemented suggested build timestamps ([#154](https://github.com/TeaSpeak/TeaSpeak/issues/154))
    - Fixed and improved flood system
    - Fixed memory leak (caused by my thread library)
    - Fixed second memory leak
    - Fixed missing permission check for `channellist`
    - Added possibility to delete old bans
    - Fixed TeamSpeak client crash on connect caused by an invalid packet order (sometimes)
    - Improved protocol backend
    
* **1.1.29b**
    - Fixed possible anti flood abuse ([#148](https://github.com/TeaSpeak/TeaSpeak/issues/148))
    - Fixed disappearing server query critical on off log level
    - Added possibility to change the serveradmin password (execute the command `passwd` within TeaSpeak's terminal)
    - Fixed TeaSpeak crash on invalid config entries
    - Fixed server hangup on music bot song change
    
* **1.1.28b**
    - Fixed inherited channel group
    - Fixed temporary channel groups
    - Fixed a server crash
    - Fixed max channel family clients
    - Start to use the compiler optimisations (`-O2`) for a little performance boost
    
* **1.1.27b**
    - Fixed not working server passwords
    - Moved the config options `kick_on_invalid_badges` and `kick_on_invalid_packets` to the permission system
    - Using command ack packets as secondary ping system (should be more stable now)
    - Command `clientupdate` just resets the idle time when some values have been changed
    - Fixed permission issue [#120](https://github.com/TeaSpeak/TeaSpeak/issues/120)
    - Fixed query group assignment bug
    - Fixed invalid guest server query permissions
    - Added verbose yt log
    - Added help command documentation
    - Improved music bot error output
    - Fixed permission system (again for build >= 5 (not working client permissions)
    
* **1.1.26b**
    - Waiting for a acknowledge of the `clientinitiv` packet before setting up crypto. Fixed (hopefully) the client crash 
    - Client connection core code improvement (faster and safer)
    - Improved the ping and timeout system
    - Fixed invalid client id on massive client joins (> 10/s)
    - Fixed memory leak (280 bytes/connection)
    - Fixed config override on invalid config
     
* **1.1.25b**
    - Fixed issue [#75](https://github.com/TeaSpeak/TeaSpeak/issues/75)
    - Fixed a channel tree issue
    - Fixed a server crash
    - Full implementation of `<server/channel>groupcopy`
    - Moved some messages to trace
    - Fixed icon bug
    - Fixed not working music bot
    - Fixed icons (again)
    
* **1.1.24b**
    - Improved the licensing system (...and i don't worked over 4 years on it o.O)
    - Fixed default channel codec (Now opus voice again)
    Note: Server starts to become more stable :)
        
* **1.1.23b**
    - Added alternative database support (MySQL)
    
* **1.1.22b**
    - Added a forward parameter for the web client (when you client the accept certificate link)
    - Fixed icon|file transfer bug
    
* **1.1.21b**
    - **Big** property update (Using ids now and reducing the memory usage)
    - Validating properties within commands  
    **Attention**: This update can cause the loss of some properties
    - Fixed incorrect variable `client_lastconnected`
    - Fixed command `permfind`
    - Fixed invalid icon removement (tested for an invalid path)
    - Improved temporary channel deletion
    - Fixed various channel tree bugs and exploits
    - Fixed icon id bug
    - Fixed memory leak on file transfare timeout
    
* **1.1.20b**
    - Fixed several server crashes
    - Fixed file upload not working sometimes
    - Fixed file transfer hangup bug
    - Order now icons after the age
    - Add a fix to fixing invalid icon id's in groups, channels and server on startup
    - Fixed default setup permissions
    - Implemented idle time ([#124](https://github.com/TeaSpeak/TeaSpeak/issues/124))
    - Made mute message configurable
    - Music bot now rejoining their last channel again
     
* **1.1.19b**
    - Implemented a advanced music bot query interface ([](read more))
    - Fixed all listed issues ([#112](https://github.com/TeaSpeak/TeaSpeak/issues/112))
    - Fixed command `banlist` (Invalid result)
    - Implemented requested enchantment [#111](https://github.com/TeaSpeak/TeaSpeak/issues/111)
    
* **1.1.18b**
    - Implemented disconnect on `MODALQUIT` ([#104](https://github.com/TeaSpeak/TeaSpeak/issues/104))
    - Added the possibility to send text messages to yourself ([#106](https://github.com/TeaSpeak/TeaSpeak/issues/106))
    - Added new permissions (`i_client_max_clones_ip` and `i_client_max_clones_hwid`) ([#48]()https://github.com/TeaSpeak/TeaSpeak/issues/48)
    - Fixed a critical decompress issue!
    
* **1.1.17b**
    - Moved the default web client port to 9987 (So TeamSpeak and TeaSpeak Web are bound to the same port!)  
        Notice:  
        Old already started servers are still bound to 19974 (Server properts: `virtualserver_web_port`)
    - Fixed issue [#96](https://github.com/TeaSpeak/TeaSpeak/issues/96)
    - Fixed issue [#94](https://github.com/TeaSpeak/TeaSpeak/issues/94) (Missing `clientinfo` properties)
    - Fixed a buggy perm system (Removing the permission `b_serverinstance_permission_list` is not the best idea) [#102](https://github.com/TeaSpeak/TeaSpeak/issues/102) and [#101](https://github.com/TeaSpeak/TeaSpeak/issues/101)
    - Fixed issue [#92](https://github.com/TeaSpeak/TeaSpeak/issues/92)
    
* **1.1.16b**
    - Fixed client side crash on join ([#82](https://github.com/TeaSpeak/TeaSpeak/issues/82)|[#53](https://github.com/TeaSpeak/TeaSpeak/issues/53))
    - First working release with web client (closed alpha)
    - Fixed server snapshot deploy bug
    - Fixed issue that firefox cant connect
    - Fixed file override (When you upload a new avatar)
    - Fixed the implementation of `b_group_is_permanent` (>= build 8) ([#89](https://github.com/TeaSpeak/TeaSpeak/issues/89))
    - Fixed invalid property `client_lastconnected` (Was named `client_ip`) ([#90](https://github.com/TeaSpeak/TeaSpeak/issues/90))
    
* **1.1.15b**
    - Improved the permission system. Now like TeamSpeak (Except skip & negate)
    - Fixed "crazy" grant value on permission add
    - Fixed group permanent property
    - Fixed ssl/tls crash (on too long messages)
    
* **1.1.14b**
    - Ignoring unknown properties at `serveredit`
    - Ignoring unknown properties at `channeledit`
    - Fixed a query connection crash
    
* **1.1.13b**
    - Using boringssl (for compatibility with WebRTC)
    - Implemented a optional query ssl/tls encryption
    
* **1.1.12b**
    - Implement 4 new server properties:
        - `virtualserver_last_client_connect`
        - `virtualserver_last_query_connect`
        - `virtualserver_last_client_disconnect`
        - `virtualserver_last_query_disconnect`
        I think the name explains the meaning by its self (Unit: Unix timestamp in seconds)
    - Fixed issue [#77](https://github.com/TeaSpeak/TeaSpeak/issues/77) (Missing grant permission for `i_group_show_name_in_tree`)
        
* **1.1.11b**
    - Implement a shutdown count down (Terminal: `shutdown <delay> <reason>` Query: `serverprocessstop type=cancel|schedule time=60 msg=`)
    - Fixed icon not exists bug
    - Speed up connection statistics
    - Fixed transferred data since start (bytes) (>= build 2)
    - Rewrite of the voice client accept system (not spawning a new thread on each handshake)
        Is now more powerful, and stable
    
* **1.1.10b**
    - Implemented shutdown time limit (server kills himself, if the shutdown takes more than 30 seconds)
    - Using new crash handler (using now google's `breakpad`)
    
* **1.1.9b**
    - Fixing some channel multi threading crash bugs
    - Deleting a temp channel instant when its empty
    - Fixed file client crashes and query | file client memory leak
    - Fixed critical memory bug in one of my internal libraries (>= build 3)
    - Fixed music bot hangup on server stop

* **1.1.8b**
    - Fixing shutdown fail on huge virtual server amount
    - Fixing internal threading library bug (Thread.join(<timeout>) didn't wait, possible crashes!)
    - Fixed terminal "crash" on TeaSpeak crash while its in minimal mode
    - Fixed some possible shutdown crashes
    
* **1.1.7b**
    - Fixed some SQL stuff (internal library)
    - Fixed incorrect/missing permissions `serversnapshotcreate` and `serversnapshotdeploy`
    - Added some display values when you create a music bot
    
* **1.1.6b**
    - Fixed (re)join default channel by path
    - Increasing numbers instead appending a '1' on client join
    - Implement a web auto forward (if you try to connect to the WS port)
    - Fixed possible crash with ssl connections
    - Caching the permission if a client is allowed to speak
    
* **1.1.5b**
    - Now loading *all* data from `serversnapshotdeploy` (still not override's old serverId)
    - Implement command `serversnapshotcreate` (useable for TeaSpeak)
    
* **1.1.4b**
    - Improved music bots (Using half of the performance now)
    - Some Web client updates (SSH certificate is now configurable (You require a up2date))
    - Music bots buffering
    - Fixed file client hangup on disconnect
    - *Huge* (1/2) sql improvements (Thanks to @[lexesv](https://github.com/lexesv))
        - Server's starting now much faster
    
* **1.1.3b**
    - Just an private increment (cause i switch my PC)
    
* **1.1.2b**
    - Fixed geo location!
    - Fixed libyaml (not requires gcc-6 anymore)
    
* **1.1.1b**
    - Fixed server hangup on stop
    - Implemented a configurable log system (log per server)
    - Fixed teastart_minimal.sh (Some systems dosnt support select)
    
* **1.1.0b**
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
    
* **1.0.29b**
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
