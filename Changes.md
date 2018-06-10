## Things that make TeaSpeak different than TeamSpeak

NOTE: Most of the here described changes only apply to the query interface. Making use of the functionality in the Teamspeak 3 Client would require a plugin that is planned for the near future.

### clientdblist without IPs
In TeaSpeak you have the ability to allow clients/queries to view the clientdblist without IP's by not assigning the `b_client_remoteaddress_view` permission to them. ([read more](https://github.com/TeaSpeak/TeaSpeak/issues/13))

**TeamSpeak:**
```
clientdblist
cldbid=3 client_unique_identifier=Dc3Wno3oyXQsrocaODdAAUwiPHo= client_nickname=SpoilerAlarm\s\p\sConnor client_created=1526131558 client_lastconnected=0 client_totalconnections=0 client_description client_lastip=127.0.0.1|cldbid=4 client_unique_identifier=ServerQuery client_nickname=Bluscream\s[YaTQA] client_created=1526131558 client_lastconnected=0 client_totalconnections=0 client_description client_lastip=8.8.8.8
error id=0 msg=ok

```
**TeaSpeak:**
```
clientdblist
cldbid=3 client_unique_identifier=Dc3Wno3oyXQsrocaODdAAUwiPHo= client_nickname=SpoilerAlarm\s\p\sConnor client_created=1526131558 client_lastconnected=0 client_totalconnections=0 client_description client_lastip=hidden|cldbid=4 client_unique_identifier=ServerQuery client_nickname=Bluscream\s[YaTQA] client_created=1526131558 client_lastconnected=0 client_totalconnections=0 client_description client_lastip=hidden
error id=0 msg=ok
```

### Additional Server Query Notifies
In TeamSpeak your can register a query client to ServerQueryNotify via `servernotifyregister` so you don't have to use loops and sleeps in your scripts, but the amount of events provided by TeamSpeak is very limited (`server`|`channel`|`textserver`|`textchannel`|`textprivate`). However on TeaSpeak you have a wide variety of events to use (almost all events that are sent to normal voice clients) (This change is so big that we created an extra page for it [here](https://github.com/TeaSpeak/TeaSpeak/blob/master/ServerQueryNotify.md))
![](https://i.imgur.com/1D8dhBo.png)

### Customizable Messages
In TeaSpeak you can customize a lot of otherwise hardcoded messages via the `config.yml`.
- The message that users see when the virtualserver or instance was stopped or crashed.
- The description of channels and clients that don't have a custom description set.
- The message of the kick a user gets when he exceeds his `i_client_max_idletime`.
- The version and platform of the server shown on the infodata pane and server connection info of the client.
- The license type that is shown to any connecting client in the infodata pane (You can choose between No Licence, ATHP, LAN LICENSE, NPL and two auto-license modes that will change the license type based on the current slotcount of the instance/server)
- The query message-of-the-day (motd) and newline character of the query interface.
- The country flag a client gets when no valid country can be detected (Either through connecting with a local or not yet registered IP)

### Increased slot count
We at TeaSpeak believe that admins that just want to run their own little server for their own little community should be bound to such high restrictions as they are in the non-profit license, therefor on TeaSpeak you can have as many virtual servers you like, with each of them having a slotcount of max 1024 slots. (If you need more take a look at the database)

### Built in musicbots
TeaSpeak brings it's own built-in music bot system which brings high-quality, high-performance and low bandwith usage music bots. For a quick setup grant yourself the music related permissions and then type `.mbot` in the channel chat. If you want more detailed information, click [here](https://forum.teaspeak.de/index.php?threads/teaspeak-music-bot-release.36/).

### Global bans
With TeaSpeak you can easily create/modify and delete instance-wide banrules. The commands `banlist`, `banadd`, `bandel` and `banedit` have a new `sid` property, that (if 0 or not on a virtual server `use sid...`) will apply the action to the global banlist. So for example `banadd sid=1 ip=8.8.8.8 reason=Google\sDNS` will become `banadd sid=0 ip=8.8.8.8 reason=Google\sDNS` if you want to ban that id globally. You can even use that system in YaTQA, as you see here:
![](https://i.imgur.com/uesO3Be.png)

### Additional Ban tweaks
Also TeaSpeak allows you to directly editing bans. The Teamspeak 3 Client has a dummy "Edit ban" feature that just executes `bandel <original ban>` and `banadd <modified ban>` afterwards which i would call a workaround rather than proper implementation.
In addition to that hardware id's (Which TeamSpeak claims [they would not ban](https://forum.teamspeak.com/threads/124057-Hardware-sided-bans?p=435740#post435740) even though they [do](https://i.imgur.com/JIirVJU.png)) with the new `hwid` property (Example: `banadd hwid=165dwq18q4f6qw5f1f5q64d9qw448wq,165dwq18q4f6qw5f1f5q64d9qw448wq` or `banadd hwid=` to ban empty hwids)

### Encrypted Query Connection
On Teamspeak everything sent through server query (telnet) is plain text (unencrypted). Even your Admin Server Query password! TeaSpeak gives you the ability to either enforce, allow or deny SSL encrypted telnet sessions so you can use certificates to secure your connection. To use this feature your telnet client must support certificate based encryption!

### Additional props in commands
TeaSpeak is a community driven project so we listen a lot to feature requests
- `channellist`, `channelinfo` ([read more](https://github.com/TeaSpeak/TeaSpeak/issues/22))
  - `created_by` -> Client db id (Visible in channel list & channel info)
  - `created_at` -> Unix timestamp (Milliseconds)
- `clientdblist -details`, `clientdbfind -details`, `clientdbinfo` ([read more](https://github.com/TeaSpeak/TeaSpeak/issues/12))
  - `client_badges` -> Last used badges string
  - `client_version` -> Last used version
  - `client_platform` -> Last used platform
  - `client_hwid` -> Last used hardware id
- `notifyplugincmd` ([#35](https://github.com/TeaSpeak/TeaSpeak/issues/35)), `notifyconnectioninforequest` ([#36](https://github.com/TeaSpeak/TeaSpeak/issues/36))
  - `invokerid` -> The client id of the invoker

### Scheduled Shutdowns
TeaSpeak has the possibility to schedule a shutdown with the query command `serverprocessstop`
    - `serverprocessstop type=cancel|schedule time=60 msg=`
        - `time` just required when `type` = `schedule`
        - `msg` optional

### Built-in console
TeaSpeak has a built-in console that can be used from stdout containing the following commands:
- `end|shutdown <now|<number>[h|m|s]:...> <reason>`
- `chat <serverId> <mode{server=3|channel=2|manager=1}> <targetId> <message...>`
- `permgrant <ServerId> <GroupId> <Permission Name> <Grant>` to recover permissions without tampering with the database.
- `passwd <new_password> <repeated>` to change the Admin Server Query password.

# No idea how to write about this since i haven't tested it yet
+ Instance group assignment (servergroup[add|del|list]. Clients could be used on unbound state too)


### New Permissions

Permission | Description
--- | ---
`b_client_allow_invalid_badges` | Bypasses the serverkick when invalid (hacked) badges were detected.
`b_client_allow_invalid_packet`| Bypasses the serverkick when empty packets were recieved from that client.
`b_client_ban_create_global` | Allows to create global ban rules.
`b_client_ban_delete_global` | Allows to delete any global ban rules.
`b_client_ban_delete_own_global` | Allows to delete global ban rules that were created by that client.
`b_client_ban_edit` | Allows to edit any local ban rule.
`b_client_ban_edit_global` | Allows to edit any global ban rule.
`b_client_ban_list_global` | Allows to list the global ban rules.
`b_client_even_textmessage_send` | Allows the client to send private text messages to himself.
`b_virtualserver_modify_music_bot_limit` | Allows to modify the maximum amount of musicbots that can be created on that server.
`i_channel_group_member_add_power` | Power to set a channel group for a client.
`i_channel_group_needed_member_add_power` | Needed `i_channel_group_member_add_power` to add this client to a channel group.
`i_channel_group_member_remove_power` | Power to take a channel group from a client.
`i_channel_group_needed_member_remove_power` | Needed `i_channel_group_member_remove_power` to remove this client from a channel group.
`i_channel_group_modify_power` | Power to modify a channel group
`i_channel_group_needed_modify_power` | Needed `i_channel_group_modify_power` to modify a channel group
`i_client_max_clones_hwid` | Sets the maximum amount of clients with same hwid that can be on the server at the same time.
`i_client_max_clones_ip` | Sets the maximum amount of clients with same ip that can be on the server at the same time.
`b_client_music_server_list` | Allows to list all musicbots on the server.
`b_client_music_channel_list` | Allows to list all musicbots in their current channel.
`b_client_music_create` | Allows to create new music bots.
`b_client_music_delete_own` | Allows to delete music bots that were created by that client.
`i_client_music_delete_power` | Power to delete music bots.
`i_client_music_needed_delete_power` | Needed `i_client_music_delete_power` to delete music bots.
`i_client_music_info` | Power to use chatcommand `.mbot info`.
`i_client_music_needed_info`| Needed `i_client_music_info` power for this musicbot.
`i_client_music_limit` | The limit of musicbots a client can create.
`i_client_music_play_power` | Power to use chatcommand `.mbot play`.
`i_client_music_needed_play_power` | Needed `i_client_music_play_power` power for this musicbot.
`i_client_music_rename_power` | Power to use chatcommand `.mbot rename`.
`i_client_music_needed_rename_power` | Needed `i_client_music_rename_power` power for this musicbot.
