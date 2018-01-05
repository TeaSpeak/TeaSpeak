This is the default configuration file called `config.yml` which is being generated on start if it doesn't exist.

```yml
#The configuration version.
#Do NOT modify!
version: 1
general:
  #The configuration file
  dbFile: TeaData.sqlite
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
  version: TeaSpeak 1.0.9-beta
  #The displayed platform to the client
  #This option is only for the premium version.
  platform: Linux C++
  #The displayed licence type to every TeaSpeak 3 Client
  #Avariable types:
  #  0: No licence
  #  1: Host Provider License
  #  2: Offline/Lan licence
  #  3: Non profit licence
  #  4: Unknown licence
  #This option is only for the premium version.
  licence: 2
query:
  #The query welcome message
  #Notice: If not like TeamSpeak then some applications may not recognize the Query
  motd: "TS3\nWelcome to the TeaSpeak ServerQuery interface, type \"help\" for a list of commands and \"help <command>\" for information on a specific command.\n"
voice:
  #The amount of precomputed puzzles
  #Do NOT TOUCH unless you're 100% sure!
  rsa_puzzle_precompute_size: 128
 ```
