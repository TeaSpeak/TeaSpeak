## Things that make TeaSpeak different than TeamSpeak

+ Ability to allow clients/queries to view the clientdblist without IP's by not assigning b_client_remoteaddress_view to them. ([read more](https://github.com/TeaSpeak/TeaSpeak/issues/13))
+ Additional ServerQueryNotify events ([read more](https://github.com/TeaSpeak/TeaSpeak/blob/master/ServerQueryNotify.md))
+ Customizable Messages (Query MOTD, Timeouts, etc...) ([read more](https://github.com/TeaSpeak/TeaSpeak/blob/master/config.md))
+ Unrestricted slots (Okay only 1024 per virtual server, but who needs more than that?!)
+ Built in music bot system (Low bandwidth usage, remote client is not necessary) ([read more](https://forum.teaspeak.de/index.php?threads/teaspeak-music-bot-release.36/))
+ Customizable Version/Platform/License (Premium Version) ([read more](https://github.com/TeaSpeak/TeaSpeak/issues/6))
+ Global ban system ([read more](https://github.com/TeaSpeak/TeaSpeak/issues/11))
+ Ability to directly edit bans without re-adding ([read more](https://github.com/TeaSpeak/TeaSpeak/issues/18))
+ More infos in `channellist`, `channelinfo` ([read more](https://github.com/TeaSpeak/TeaSpeak/issues/22))
+ More infos in `clientdblist`, `clientdbfind` ([read more](https://github.com/TeaSpeak/TeaSpeak/issues/12))
+ Parameter `invokerid=<clid>` in `notifyplugincmd`([#35](https://github.com/TeaSpeak/TeaSpeak/issues/35)) and `notifyconnectioninforequest`([#36](https://github.com/TeaSpeak/TeaSpeak/issues/36))
+ Instance group assignment (servergroup[add|del|list]. Clients could be used on unbound state too)
+ Adding possibility to schedule a shutdown with the query command `serverprocessstop`
    - `serverprocessstop type=cancel|schedule time=60 msg=` 
        - `time` just required when `type` = `schedule` 
        - `msg` optional
+ Optional query SSL/TLS encryption
+ Possibility to send text messages to yourself ([read more #106](https://github.com/TeaSpeak/TeaSpeak/issues/106))
+ Possibility to limit the number of connections for one client by his ip and hwid
+ Parameter `hwid` in `banadd` so hwid bans can be added manually

## New Permissions
 - `b_client_allow_invalid_badges`
 - `b_client_allow_invalid_packet`
 - `b_client_ban_create_global`
 - `b_client_ban_delete_global`
 - `b_client_ban_delete_own_global`
 - `b_client_ban_edit`
 - `b_client_ban_edit_global`
 - `b_client_ban_list_global`
 - `b_client_even_textmessage_send`
 - `b_client_music_channel_list`
 - `b_client_music_create`
 - `b_client_music_delete_own`
 - `b_client_music_server_list`
 - `b_serverinstance_help_view`
 - `b_virtualserver_modify_host`
 - `b_virtualserver_modify_music_bot_limit`
 - `b_virtualserver_modify_nickname`
 - `i_channel_group_member_add_power`
 - `i_channel_group_member_remove_power`
 - `i_channel_group_modify_power`
 - `i_channel_group_needed_member_add_power`
 - `i_channel_group_needed_member_remove_power`
 - `i_channel_group_needed_modify_power`
 - `i_client_max_clones_hwid`
 - `i_client_max_clones_ip`
 - `i_client_music_delete_power`
 - `i_client_music_info`
 - `i_client_music_limit`
 - `i_client_music_needed_delete_power`
 - `i_client_music_needed_info`
 - `i_client_music_needed_play_power`
 - `i_client_music_needed_rename_power`
 - `i_client_music_play_power`
 - `i_client_music_rename_power`
