##A little help sheet about the TeaSpeak Server Query event-system
###Available events
- Server
    - Server Edit
- Client (Misc)
    - poked
    - client get updated
    - plugin cmd received
- Client (Groups)
    - Group added
    - Groups removed
    - Channel group changed
- Client (View)
    - client joined
    - client switch
    - client leave
- Chat
    - chat composing
    - chat message
    - chat closed
- Channel
    - channel created
    - channel moved
    - channel edited
    - channel description changed
    - channel deleted

##Event Description
###General query command syntax
Enable events (No permissions required): ``` servernotifyregister event={server|client|chat|channel} specifier=~see event documentation~```


###Server based events
- Enable/disable server based events: ```servernotifyregister event=server specifier={edited}```
      
    ####Server Edit
    <p style="text-indent:100px;">
Description: This event gets fired when somebody edit the server settings</br>
    Command: <code>notifyserverupdated</code></br>
    Arguments:</br>
    - Typical invoker arguments</br>
    - Every changed value.</br>
    Example: <code>...</code></br>
    </p>