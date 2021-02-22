# TeaSpeak Server Tokens
## Introduction
Server tokens are long, random generated keys which could be used to trigger certain actions.  
Their main purpose is it to grant people extra permissions after using such token.   
  
Each token has a list of [actions](#actions) which will be executed when using a token.  
The actual number of actions is unlimited.  
  
## Options
Each token has the following options:  
  
### Max uses
By default, a server token can be used infinity times.  
The number of maximal uses can be set via `token_max_uses`.  
If the token has been used such many times it will be no longer be use able.

### Expire timestamp
Each token can be limited for how long it should be valid.  
The expire timestamp can be set as seconds since unix epoch via the `token_expired` property.  

## Actions
All tokens have a set of actions.  
Each action will be executed sequentially in order of their action id (ascending).
The order is database depended and might change in future.  
  
Available actions are:  
| Name | ID | ID1 | ID2 | Text | Description |  
| :--- | :---: | --- | --- | --- | :-- |  
| Add server group | `0x01` | Server group id | *unused* | *unused* | Add the client to the target server group |  
| Remove server group | `0x02` | Server group id | *unused* | *unused* | Remove the client from the target server group |  
| Set channel group | `0x03` | Channel group id | Channel id | *unused* | Set the channel group for the client for the target channel |  
| Allow channel join | `0x04` | *unused* | Channel id | *unused* | Allow the client to join the target channel ignoring if the client has permission to do so. This only applies when connecting (joining the server) and not to a general channel switch. This means that the client must join with the token (e. g. via an invite link). |  
