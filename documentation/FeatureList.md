# This document covers the features listed by `listfeaturesupport`

# ToC
- [Bulked command responds](#bulked-command-responds)
- [Advanced channel chat](#advanced-channel-chat)


## Bulked command responds  
Bulked command responds are an extend of the default `error id=<> msg=<> [return_code=<>]` command responses.
Instead of returning one error `id` and `msg` for all bulks giving as command input,
it returns the same amount of  bulks in the `error` return code, containing an `id` and `msg`. This allows the sender to determine,
which sub actions succeeded and which failed.  
  
*Note:*  
Even thou these commands return individual error codes, they may return just one bulk which implies that all actions had the same outcome.
This might happen in case of a miss matching permission which prevents any action of that kind.  
  
An example would look like this:    
```
servergroupaddperm sgid=13 permsid=b_serverinstance_virtualserver_list permvalue=50 permnegated=0 permskip=0|permsid=b_client_enforce_valid_hwid permvalue=20 permnegated=0
error id=2568 msg=insufficient\sclient\spermissions failed_permid=178 | id=0 msg=ok
```

### Feature info
A table with supported commands could be found [here](#bulked-responds-supported-commands)  
  
Feature name: `error-bulks`  
Version table:  
| Version | Server Release |  
| -- | -- |  
| 1 | 1.4.15-beta 2 |  
  
<h3 id="bulked-responds-supported-commands">Supported commands</h3>

| Command | Version |  
| -- | -- |  
| `servergroupaddperm`        | 1 |  
| `servergroupdelperm`        | 1 |  
| `servergroupautoaddperm`    | 1 |  
| `servergroupautodelperm`    | 1 |  
| `channeladdperm`            | 1 |  
| `channeldelperm`            | 1 |  
| `clientaddperm`             | 1 |  
| `clientdelperm`             | 1 |  
| `channelclientaddperm`      | 1 |  
| `channelclientdelperm`      | 1 |  
| `channelgroupaddperm`       | 1 |  
| `channelgroupdelperm`       | 1 |  
| `playlistaddperm`           | 1 |  
| `playlistdelperm`           | 1 |  
| `playlistclientaddperm`     | 1 |  
| `playlistclientdelperm`     | 1 |  
| `ftdeletefile`              | 1 |  
| `ftgetfileinfo`             | 1 |  
  
## Advanced channel chat
This feature describes the ability, to chat in channels regardless of the clients channel.
This also implies that the channel conversation is persistent and the commands bellow exists.  

### Feature info
A table with supported commands could be found [here](#advanced-channel-chat-supported-commands)  
  
Feature name: `advanced-channel-chat`  
Version table:  
| Version | Server Release |  
| -- | -- |  
| 1 | 1.4.4<sup>[1](#advanced-channel-chat-f1)</sub> |  
  
<a name="advanced-channel-chat-f1">1: </a>Supported since `1.4.4` but the feature command has been introduced in `1.4.15`.

<h3 id="advanced-channel-chat-supported-commands">Supported commands</h3>
  
| Command | Version |  Notes |  
| -- | -- | -- |  
| `sendtextmessage`              | 1 | Only the `cid` parameter is affected |  
| `conversationhistory`          | 1 |  |  
| `conversationfetch`            | 1 |  |  
| `conversationmessagedelete`    | 1 |  |  
  