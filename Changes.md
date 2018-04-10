## Things that make TeaSpeak different than TeamSpeak

+ Ability to allow clients/queries to view the clientdblist without IP's by not assigning b_client_remoteaddress_view to them.
+ Additional ServerQueryNotify events ([read more](https://github.com/TeaSpeak/TeaSpeak/blob/master/ServerQueryNotify.md))
+ Customizable Messages (Query MOTD, Timeouts, etc...)
+ Unrestricted slots (Okay only 1024, but who needs more than that?!)
+ Built in music bot system (Low bandwidth usage, remote client is not necessary) ([read more](https://forum.teaspeak.de/index.php?threads/teaspeak-music-bot-release.36/))
+ Customizable Version/Platform/License (Premium Version)
+ Global ban system ([read more](https://github.com/TeaSpeak/TeaSpeak/issues/11))
+ Ability to directly edit bans without re-adding ([read more](https://github.com/TeaSpeak/TeaSpeak/issues/18))
+ More infos in `channellist`, `channelinfo` ([read more](https://github.com/TeaSpeak/TeaSpeak/issues/22))
+ More infos in `clientdblist`, `clientdbfind` ([read more](https://github.com/TeaSpeak/TeaSpeak/issues/12))
+ Added parameter `invokerid=<clid>` to `notifyplugincmd` and `notifyconnectioninforequest`
+ Added instance group assignment (servergroup[add|del|list]. Clients could be used on unbound state too)
+ Adding possibility to schedule a shutdown with the query command `serverprocessstop`
    - `serverprocessstop type=cancel|schedule time=60 msg=` 
        - `time` just required when `type` = `schedule` 
        - `msg` optional
+ Added optional query SSL/TLS encryption
