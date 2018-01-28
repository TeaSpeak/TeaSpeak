This is the default configuration file called `config.yml` which is being generated on start if it doesn't exist.

```yml
#The configuration version.
#Do NOT modify!
version: 5
log:
  #The log level
  #Available types:
  #  0: Trace
  #  1: Debug
  #  2: Info
  #  3: Warn
  #  4: Error
  #  5: Critical
  #  6: Off
  level: 1
  #Disable\/enable ascii codes in log
  colored: 0
messages:
  #The terminal log level
  level: 2
  voice:
    #The server stopped message
    server_stop: Server stopped
  application:
    #The server stopped message
    stop: Application stopped
    #The application crashed message
    crash: Application crashed
  client:
    #The default client description (if not set)
    defaultDescription: I don't have a description
  channel:
    #The default channel topic
    defaultTopic: Hey, I'm a new channel!
general:
  #The configuration file
  dbFile: TeaData.sqlite
  #Insert here your license code (if you have one)
  license: none
binding:
  file:
    #The default host for the file server
    host: 0.0.0.0
    #The default port for the file server
    port: 30303
  query:
    #The default host for the query server
    host: 0.0.0.0
    #The default port for the query server
    port: 10101
server:
  #The displayed version to the client
  #This option is only for the premium version.
  version: TeaSpeak 1.0.24-beta
  #The displayed platform to the client
  #This option is only for the premium version.
  platform: Linux C++
  #The displayed licence type to every TeaSpeak 3 Client
  #Available types:
  #  0: No Licence
  #  1: Authorised TeaSpeak Host Provider License (ATHP)
  #  2: Offline\/Lan Licence
  #  3: Non-Profit License (NPL)
  #  4: Unknown Licence
  #  5: ~placeholder~
  #  6: Auto-License (Server based)
  #  7: Auto-License (Instance based)
  #This option is only for the premium version.
  licence: 7
query:
  #Change the query newline character
  nl_char: "\r\n"
  #The query welcome message
  #Notice: If not like TeamSpeak then some applications may not recognize the Query
  #Default TeamSpeak 3 MOTD:
  #TS3\r\nWelcome to the TeaSpeak ServerQuery interface, type \"help\" for a list of commands and \"help <command>\" for information on a specific command.\r\n
  motd: "TeaSpeak\r\nWelcome on the TeaSpeak ServerQuery interface.\r\n"
voice:
  #Enable\/disable the mute notify
  notifymute: 1
  rsa:
    #The amount of precomputed puzzles
    #Do NOT TOUCH unless you're 100% sure!
    puzzle_pool_size: 128
    #The puzzle level. (A higher number will result a longer calculation time for the client RSA puzzle)
    #Do NOT TOUCH unless you're 100% sure!
    puzzle_level: 1000
  #The fallback country if lookup fails
  fallback_country: DE
  #Maximum amount of join attemps per second.
  connect_limit: 10
  #Maximum amount of join attemps per second per ip.
  client_connect_limit: 3
  protocol:
    #Enable\/disable for kicking clients if the send a corrupt protocol
    kick_invalid_packet: 0
    #Enable\/disable for kicking clients if the send a corrupt badge info
    kick_invalid_badges: 1

 ```
