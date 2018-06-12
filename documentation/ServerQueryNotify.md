## A little help sheet about the TeaSpeak Server Query event-system
## Notify-System since until TeaSpeak 1.0.9-beta
### Available events
- [Server](#server-based-events)
    - [Server Edit](#server-Edit)
- [Client (Misc)](#miscellaneous-client-events)
    - [Poke](#client-poke)
    - [Update](#client-updated)
    - [Command](#client-command)
- [Client (View)](#client-view-events)
    - [Client join](#client-join)
    - [Client switch](#client-switch)
    - [Client leave](#client-leave)
- [Client (Groups)](#client-group-events)
    - [Group add](#client-group-add)
    - [Group remove](#client-group-remove)
    - [Channel group change](#client-channel-group-change)
- [Chat](#chat-events)
    - [Chat composing](#chat-composing)
    - [Chat receive](#chat-receive)
        - Receive server
        - Receive channel
        - Receive private
    - [Chat close](#chat-close)
- [Channel](#channel-events)
    - [Channel create](#channel-create)
    - [Channel edit](#channel-edit)
    - [channel description change](#channel-description-changed)
    - [channel password change](#channel-password-changed)
    - [Channel move](#channel-moved)
    - [Channel delete](#channel-deleted)
- [Music](#music-events)

## Event Description
### General query command syntax
| Command | Description |
|:---|---:|
| `servernotifyregister event=all specifier=all`                                                    | Enable *all* events<br/>(No permissions required) |
| `servernotifyregister event={server/client/chat/channel/music} specifier=all`                           | Enable *all* events for a *specific group*<br/>(No permissions required) |
| `servernotifyregister event={server/client/chat/channel/music} specifier=~see event documentation~`     | Enable one event<br/>(No permissions required) | 
| `servernotifylist [-all]`                                                                         | List all enabled events<br/>(No permissions required) |
| `servernotifyunregister event=all specifier=all`                                                  | Disable *all* events<br/>(No permissions required) |
| `servernotifyunregister event={server/client/chat/channel/music} specifier=all`                         | Disable *all* events for a *specific group*<br/>(No permissions required) |
| `servernotifyunregister event={server/client/chat/channel/music} specifier=~see event documentation~`   | Disable one event<br/>(No permissions required) |

### Server based events
Enable/disable server based events: `servernotifyregister event=server specifier={edit}`
      
- #### Server Edit
    * Description: This event gets fired when somebody edit the server settings
    * Command: `notifyserverupdated`
    * Arguments:
        * Typical invoker arguments
        * Every changed value.
    * Example: `...`
    
### Miscellaneous client events
Enable/disable client based events: `servernotifyregister event=client specifier={poke|update|command}`
      
- #### Client Poke
    * Description: This event gets fired when you got poked by a client
    * Command: `notifyclientpoke`
    * Arguments:
        * Typical invoker arguments
        * `msg` -> The given message
    * Example: `...`
- #### Client Updated
    * Description: This event gets fired when a property of a subscribed client gets updated
    * Command: `notifyclientupdated`
    * Arguments:
        * `clid` -> The client id which get updated
        * Every changed value.
    * Example: `...`
- #### Client Command
    * Description: This event gets fired when the query recived as plugin msg
    * Command: `notifyplugincmd`
    * Arguments:
        * `name` -> The plugin message channel name
        * `data` -> The plugin message data
    * Example: `...`
### Client view events
Enable/disable client view based events: `servernotifyregister event=client specifier={join|switch|leave}`
      
- #### Client Join
    * Description: This event gets fired when a client joins the view
    * Command: `notifycliententerview`
    * Arguments:
        * `cfid` -> Old channel id
        * `ctid` -> Joined channel id
        * `reasonId` -> Joined | View entered (See ReasonId table)
        * Default client properties.
    * Example: `???`
- #### Client Switch
    * Description: This event gets fired when a client switched/moved the channel
    * Command: `notifyclientmoved`
    * Arguments:
        * `clid` -> Client id
        * `cfid` -> Old channel id
        * `ctid` -> New channel id
        * `reasonId` -> See ReasonId table
        * `reasonmsg` -> The message for this action
        * Typical invoker arguments
    * Example: `???`
- #### Client Leave
    * Description: This event gets fired when a client leave the server, get kicked or get banned
    * Command: `notifyclientleftview`
    * Arguments:
        * `clid` -> Client id
        * `cfid` -> Old channel id
        * `ctid` -> New channel id
        * `reasonId` -> See ReasonId table
        * `reasonmsg` -> The message for this action
        * Typical invoker arguments
        * In case of ban: `bantime` -> The length in seconds
    * Example: `???`
### Client group events
Enable/disable client group based events: `servernotifyregister event=client specifier={add|remove|change}`
      
- #### Client group add
    * Description: ???
    * Command: `notifyservergroupclientadded`
    * Arguments:
        * `sgid` -> Server group id
        * `name` -> The group name
        * `clid` -> Client id
        * `cluid` -> The client unique id
    * Example: `???`
- #### Client group remove
    * Description: ???
    * Command: `notifyservergroupclientdeleted`
    * Arguments:
        * `sgid` -> Server group id
        * `name` -> The group name
        * `clid` -> Client id
        * `cluid` -> The client unique id
    * Example: `???`
- #### Client channel group change
    * Description: ???
    * Command: `notifyclientchannelgroupchanged`
    * Arguments:
        * `cgid` -> Channel group id
        * `clid` -> Client id
        * `cid`  -> The target channel
        * `cgi`  -> The inherited channel
    * Example: `???`
    
### Chat events
Enable/disable chat based events: `servernotifyregister event=chat specifier={composing|receive_server|receive_channel|receive_private|close}`
      
- #### Chat composing
    * Description: ???
    * Command: `notifyclientchatcomposing`
    * Arguments:
        * `clid` -> The client id
        * `cluid` -> The client unique id
    * Example: `???`
- #### Chat receive
    * Description: ???
    * Command: `notifytextmessage`
    * Arguments:
        * `targetmode` -> The message target ({SERVER|CHANNEL|PRIVATE})
        * `target` -> The message sender
        * `msg` -> The actual message
    * Example: `???`
- #### Chat close
    * Description: ???
    * Command: `notifyclientchatclosed`
    * Arguments:
        * `clid` -> The client id
        * `cluid` -> The client unique id
    * Example: `???`
    
### Channel events
Enable/disable chat based events: `servernotifyregister event=channel specifier={create|edit|desc|move|delete}`
      
- #### Channel create
    * Description: ???
    * Command: `notifychannelcreated`
    * Arguments:
        * `cid` -> The channel id
        * All channel properties
        * Typical invoker arguments
    * Example: `???`
- #### Channel edit
    * Description: ???
    * Command: `notifychanneledited`
    * Arguments:
        * `cid` -> The channel id
        * `reasonid` -> const 0x0A
        * Typical invoker arguments   
    * Example: `???`
- #### Channel description changed
    * Description: ???
    * Command: `notifychanneldescriptionchanged`
    * Arguments:
        * `cid` -> The channel id
    * Example: `???`
- #### Channel password changed
    * Description: ???
    * Command: `notifychannelpasswordchanged`
    * Arguments:
        * `cid` -> The channel id
    * Example: `???`
- #### Channel moved
    * Description: ???
    * Command: `notifychannelmoved`
    * Arguments:
        * `cid` -> The channel id
        * `reasonid` -> const 0x01
        * `cpid` -> The new parent channel
        * `order` -> The new channel above
        * Typical invoker arguments
    * Example: `???`
- #### Channel deleted
    * Description: ???
    * Command: `notifychanneldeleted`
    * Arguments:
        * `cid` -> The channel id
        * `reasonid` -> const 0x0A
        * Typical invoker arguments   
    * Example: `???`
  
### Music Events
Enable/disable music based events: `servernotifyregister event=music specifier={queue|player}`
- #### Queue Events
    * `notifymusicqueueadd`
    * `notifymusicqueueremove`
    * `notifymusicqueueorderchange`
    More info here: [click me](https://github.com/TeaSpeak/TeaSpeak/blob/master/documentation/Music%20bot%20query%20interface.md#Events)
- #### Player Events
    * `notifymusicplayersongchange`
    More info here: [click me](https://github.com/TeaSpeak/TeaSpeak/blob/master/documentation/Music%20bot%20query%20interface.md#Events)