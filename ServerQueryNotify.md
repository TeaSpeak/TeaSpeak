## A little help sheet about the TeaSpeak Server Query event-system
### Available events
- [Server](#Server-based-events)
    - [Server Edit](#Server-Edit)
- [Client (Misc)](#Miscellaneous-client-events)
    - [Poke](#Client-Poke)
    - [Update](#Client-Updated)
    - [Command](#Client-Command)
- [Client (View)](#Client-view-events)
    - client joined
    - client switch
    - client leave
- [Client (Groups)](#Client-group-events)
    - Group added
    - Groups removed
    - Channel group changed
- [Chat](#Chat-events)
    - chat composing
    - chat message
    - chat closed
- [Channel](#Channel-events)
    - channel created
    - channel moved
    - channel edited
    - channel description changed
    - channel deleted

## Event Description
### General query command syntax
Enable events (No permissions required): ``` servernotifyregister event={server|client|chat|channel} specifier=~see event documentation~```


### Server based events
Enable/disable server based events: ```servernotifyregister event=server specifier={edit}```
      
- #### Server Edit
    * Description: This event gets fired when somebody edit the server settings
    * Command: ```notifyserverupdated```
    * Arguments:
        * Typical invoker arguments
        * Every changed value.
    * Example: ```...```
    
### Miscellaneous client events
Enable/disable client based events: ```servernotifyregister event=client specifier={poke|update|command}```
      
- #### Client Poke
    * Description: This event gets fired when you got poked by a client
    * Command: ```notifyclientpoke```
    * Arguments:
        * Typical invoker arguments
        * ```msg``` -> The given message
    * Example: ```...```
- #### Client Updated
    * Description: This event gets fired when a property of a subscribed client gets updated
    * Command: ```notifyclientupdated```
    * Arguments:
        * ```clid``` -> The client id which get updated
        * Every changed value.
    * Example: ```...```
- #### Client Command
    * Description: This event gets fired when the query recived as plugin msg
    * Command: ```notifyplugincmd```
    * Arguments:
        * ```name``` -> The plugin message channel name
        * ```data``` -> The plugin message data
    * Example: ```...```
### Client view events
Enable/disable client view based events: ```servernotifyregister event=client specifier={join|switch|leave}```
      
- #### Client Join
    * Description: ???
    * Command: ```???```
    * Arguments:
        * ???
    * Example: ```???```
- #### Client Switch
    * Description: ???
    * Command: ```???```
    * Arguments:
        * ???
    * Example: ```???```
- #### Client Leave
    * Description: ???
    * Command: ```???```
    * Arguments:
        * ???
    * Example: ```???```
### Client group events
Enable/disable client group based events: ```servernotifyregister event=client specifier={add|remove|change}```
      
- #### Client group added
    * Description: ???
    * Command: ```???```
    * Arguments:
        * ???
    * Example: ```???```
- #### Client group removed
    * Description: ???
    * Command: ```???```
    * Arguments:
        * ???
    * Example: ```???```
- #### Client channel group changed
    * Description: ???
    * Command: ```???```
    * Arguments:
        * ???
    * Example: ```???```
    
### Chat events
Enable/disable chat based events: ```servernotifyregister event=chat specifier={composing|receive|close}```
      
- #### Chat composing
    * Description: ???
    * Command: ```???```
    * Arguments:
        * ???
    * Example: ```???```
- #### Chat receive
    * Description: ???
    * Command: ```???```
    * Arguments:
        * ???
    * Example: ```???```
- #### Chat closed
    * Description: ???
    * Command: ```???```
    * Arguments:
        * ???
    * Example: ```???```
    
### Channel events
Enable/disable chat based events: ```servernotifyregister event=channel specifier={create|edit|desc|move|delete}```
      
- #### Channel create
    * Description: ???
    * Command: ```???```
    * Arguments:
        * ???
    * Example: ```???```
- #### Channel edit
    * Description: ???
    * Command: ```???```
    * Arguments:
        * ???
    * Example: ```???```
- #### Channel description changed
    * Description: ???
    * Command: ```???```
    * Arguments:
        * ???
    * Example: ```???```
- #### Channel moved
    * Description: ???
    * Command: ```???```
    * Arguments:
        * ???
    * Example: ```???```
- #### Channel deleted
    * Description: ???
    * Command: ```???```
    * Arguments:
        * ???
    * Example: ```???```