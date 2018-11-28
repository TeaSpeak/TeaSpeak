# Documentation for the TeaSpeak query music bot interface
## Structure
- [Commands](#Commands)
- [Events](#Events)
- [Types](#Types)
- [Notes](#Notes)

## Commands
### Create a music bot (`musicbotcreate`)
Command: `musicbotcreate`  
Parameters:

| Parameter name | Description |  
| --- | --- |
| `cid` | The target channel where the bot should join (Not reqired and requires join permissions) |

Permissions:

| Permission name | Description |  
| --- | --- |  
| `i_client_music_limit` | client specific music bot limit |  

Properties:

| Property name | Type | Description |  
| --- | --- | --- |  
| `virtualserver_music_bot_limit` | Server | Server specific music bot limit |  

Result:  
If the action was successful, you'le get the property `bot_id` back, which is the created bot id

Notes:
The bot's required delete power will be set automatically to the clients bot delete power (if present)  

### Delete a music bot (`musicbotdelete`)
Command: `musicbotdelete`  
Parameters:

| Parameter name | Description |  
| --- | --- |  
| `bot_id` | The target bot id which you want to delete |

Permissions:  

| Permission name | Description |  
| --- | --- |  
| `i_client_music_delete_power` | This permission must be greater than `i_client_music_needed_delete_power` of the bot |  
| `b_client_music_delete_own` | If `i_client_music_delete_power` less than required, but you own the bot than you require this permission |  

Properties: None  

### Set subscribed bot (`musicbotsetsubscription`)
Command:
Parameters:

| Parameter name | Description |  
| --- | --- |  
| `bot_id` | The target bot id which you want to subscribe (zero for no selection) |

Permissions: None  

### Receive bot player info (`musicbotplayerinfo`)
Command: `musicbotplayerinfo`  
Parameters:  

| Parameter name | Description |  
| --- | --- |  
| `bot_id` | The target bot id |  

Permissions: None

Properties: None  

Result:  
You will receive a bunch of results which contains these parameters:  

| Parameter name | Description |  
| --- | --- |  
| `bot_id` | This is equal to the requested `bot_id` |  
| `player_state` | The current player state ([more info](#Player state)) |  
| `player_buffered_index` | Time index until the music if buffered (in `milliseconds`) |  
| `player_replay_index` | Time index until the music is played (in `milliseconds`) |  
| `player_max_index` | The song length (in `milliseconds`) |  
| `player_seekable` | `true` if seeking supported |  
| `player_title` | The title of the current song |  
| `player_description` | The description of the current song |  

### Start, stop, or pause (`musicbotplayeraction`)
Command: `musicbotplayeraction`  
Parameters:  

| Parameter name | Description |  
| --- | --- |  
| `bot_id` | The target bot id |  
| `action` | The action what you want ([more info](#Player action)) |  

Permissions:  

| Property name | Description |  
| --- | --- |  
| `i_client_music_play_power` | This permission must be greater than `i_client_music_needed_play_power` of the bot |  

Properties: None

### Queue info (`musicbotqueuelist`)
Command: `musicbotqueuelist`  
Parameters:  

| Parameter name | Description |  
| --- | --- |  
| `bot_id` | The target bot id |  
  
Switches:  
`-bulk`: Enables that the result will be one line instead or a new line for every entry  
  
Permissions:  

| Property name | Description |  
| --- | --- |  
| `i_client_music_info` | This permission must be greater than `i_client_music_needed_info` of the bot |  

Properties: None

Result:
You will receive a bunch of results which contains these parameters:

| Parameter name | Description |  
| --- | --- |  
| `bot_id` | This is equal to the requested `bot_id` |  
| `queue_index` | Index of the entry within the queue. Is it less than zero its a history entry. If its zero than its the currently replaying song. |  
| `song_loaded` | `true` is the song info loaded and/or a music player initialized |  
| `song_url` | The given stream url |  
| `song_invoker` | The invoker which inserted the entry |  
| `song_id` | The song id of the entry |  
| `song_title` | Only present if loaded == `true`. The song title of the entry |  
| `song_description` | Only present if loaded == `true`. The song description of the entry |  
| `song_thumbnail` | Only present if loaded == `true`. The songs thumbnail |  
| `song_length` | Only present if loaded == `true`. The song length (in `milliseconds`) of the entry |  

### Add a queue entry (`musicbotqueueadd`)
Command: `musicbotqueueadd`  
Parameters:  

| Parameter name | Description |  
| --- | --- |  
| `bot_id` | The target bot id |  
| `type` | The type of the song loader ([more info](#Song loader type)) |  
| `url` | The url of the file or link which will be played |  

Permissions:

| Property name | Description |  
| --- | --- |  
| `i_client_music_play_power` | This permission must be greater than `i_client_music_needed_play_power` of the bot |  

Properties: None  

### Remove a queue entry (`musicbotqueueremove`)
Command: `musicbotqueueremove`  
Parameters:  

| Parameter name | Description |  
| --- | --- |  
| `bot_id` | The target bot id |  
| `song_id`[] | The song ids which you would like to remove |  
  
Switches:  
`-skip_error`: Skip errors when a song is missing  
  
Permissions:

| Property name | Description |  
| --- | --- |  
| `i_client_music_play_power` | This permission must be greater than `i_client_music_needed_play_power` of the bot |  

Properties: None  

### Reorder a entry within the queue (`musicbotqueuereorder`)
Command: `musicbotqueueremove`  
Parameters:  

| Parameter name | Description |  
| --- | --- |  
| `bot_id` | The target bot id |  
| `song_id` | The song id which you would line to reorder |  
| `index` | The new index within the queue |  

Permissions:

| Property name | Description |  
| --- | --- |  
| `i_client_music_play_power` | This permission must be greater than `i_client_music_needed_play_power` of the bot |  

Properties: None    

## Events
### Music queue events
#### Entry add (`notifymusicqueueadd`)
Event trigger:  
This event get triggered when somebody add a queue entry  

Parameters:  

| Parameter name | Description |  
| --- | --- |  
| `bot_id` | The music bot id |  
| `song_id` | The song id of the added element |  
| `url` | The song url |  
| `index` | The song index within the queue |  
| `invokerid` | The client id who added this entry |  
| `invokername` | The client name who added this entry |  
| `invokeruid` | The client unique id who added this entry |  

#### Entry reordered (`notifymusicqueueorderchange`)
Event trigger:  
This event get triggered when somebody reorders a queue entry  

Parameters:  

| Parameter name | Description |  
| --- | --- |  
| `bot_id` | The music bot id |  
| `song_id` | The song id of the reordered element |  
| `index` | The new song index within the queue |  
| `invokerid` | The client id who reordered this entry |  
| `invokername` | The client name who reordered this entry |  
| `invokeruid` | The client unique id who reordered this entry |  

#### Entry removed (`notifymusicqueueremove`)
Event trigger:  
This event get triggered when somebody removes a queue entry  

Parameters:  

| Parameter name | Description |  
| --- | --- |  
| `bot_id` | The music bot id |  
| `song_id`[] | The song id's of the removed elements |  
| `invokerid` | The client id who removed this entry |  
| `invokername` | The client name who removed this entry |  
| `invokeruid` | The client unique id who removed this entry |  

#### Player song change (`notifymusicplayersongchange`)
Event trigger:  
This event get triggered when the music bot replays the next song

Parameters:  

| Parameter name | Description |  
| --- | --- |  
| `bot_id` | The music bot id |  
| `song_id` | The new song id. (Zero if bot is in sleep mode) |  
| `song_loaded` | `true` is the song info loaded and/or a music player initialized |  
| `song_url` | The given stream url |  
| `song_invoker` | The invoker which inserted the entry |  
| `song_id` | The song id of the entry |  
| `song_title` | Only present if loaded == `true`. The song title of the entry |  
| `song_description` | Only present if loaded == `true`. The song description of the entry |  
| `song_thumbnail` | Only present if loaded == `true`. The songs thumbnail |  
| `song_length` | Only present if loaded == `true`. The song length (in `milliseconds`) of the entry |  

#### Player status update (Only when subscribed) (`notifymusicstatusupdate`)
Event trigger:  
Every second

Parameters:  
| Parameter name | Description |  
| --- | --- |  
| `bot_id` | The music bot id |  
| `player_state` | The player state (See [player state](#player-state)) |  
| `player_buffered_index` | Time index until the music if buffered (in `milliseconds`) |  
| `player_replay_index` | Time index until the music is played (in `milliseconds`) |  

## Types
### Player state
```
enum ReplayState {
    SLEEPING = 0,
    LOADING,
    PLAYING,
    PAUSED,
    STOPPED
};
```

### Player action
```
enum PlayerAction {
    STOP = 0,
    PLAY,
    PAUSE,
    FORWARD,
    REWIND
};
```

### Song loader type
```
enum SongLoaderType {
    YTDLL = 0,
    FFMPEG = 1,
    CHANNEL = 2
};
```
#### Channel
The URL requires to match a TeaSpeak query command with the parameters `cid`, `name`, `path`  
Example: `musicbotqueueadd bot_id=5 type=2 url=cid=4\sname=audio.webm\spath`  


## Notes
There's still a concept mistake:  
If you have enough `i_client_music_play_power` you can control every bot, not only your own  
Change's a bot volume via `clientedit player_volume=0.1`