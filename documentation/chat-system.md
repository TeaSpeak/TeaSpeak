# The TeaSpeak chat system  
## Structure  
1. Introduction
2. Settings/Permissions
3. Planned features

## Introduction
The TeaSpeaks chat system is a channel based system which is using the voice channel tree channels as chat rooms.  
Therefore every voice channel could be used as a chat room.
Each of these chat rooms (conversations) are saved so users, even when they're offline, could lookup missed messages and participate to the conversation.
In general every conversation is accessibly (in terms of texting) without a need to join it explicitly.  
You're able to write from every channel to every other channel as long you have permission to access (join) the channel.  
This works except for channels which have a password or the `channel_flag_conversation_private` flag set.  
In case of a password protected channel, the user only receive messages while being actively within the channel.  
  
## Settings as Permissions
Each channel has individual configurable properties and permissions.  
All of them are listed here:  
  
### Properties
All properties are editable with the command `channeledit`. Permissions for these properties are explained [here](#permissions)  

#### Property `channel_conversation_history_length`  
The value could be a number within the range of -1 up to 2^16.  
A value of `-1` means that the chat history wound be saved, and only the last 100 messages will be kept in memory until instance restart.
A value of `0` means that the chat history will be saved without any message limit.  
If the limit will be decreased all messages above the new limit are not longer accessibly and will be erased.  
Only if the new limit is `-1` then nothing will happen and the conversation history log file will be ignored.  

#### Property `channel_flag_conversation_private`  
This channel flag determines if a chat room should be accessibly only while being in the channel explicitly.  
If enabled, you could not send any messages to this channel except you've joined the channel. You'll also not receive any message notifications about new messages.  
All messages which have been send will also not be logged (behaviour like `channel_conversation_history_length` is `-1`).  
An important note here is that the history of messages is not available to anybody!  
  
### Permissions  

#### Permission `b_channel_create_modify_conversation_private`
This permission determines if a user could create or modify the channels `channel_flag_conversation_private` property  
  
#### Permission `b_channel_create_modify_conversation_history_length`  
This permission determines if a user could create or modify the channels `channel_conversation_history_length` property  
If set the assigned value also limits the max value for the property  
  
#### Permission `b_channel_create_modify_conversation_history_unlimited`  
This permission determines if a user could create or modify the channels `channel_conversation_history_length` property  
If the permission is set the user is able to set the history length to unlimited.  
  
## Planned features
- Text only channels
- Searching for messages through the history
- Displaying images over an integrated ImageProxy (TeaSpeak server)
