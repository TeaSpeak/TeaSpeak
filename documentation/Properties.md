# TeaSpeak Properties
This file contains all known properties  
  
## Overview  
1. [Instance](#1-instance)
2. [Server](#2-virtual-server)
3. [Channel](#3-channel)
4. [Client](#4-client)
5. [Playlist](#5-playlist)

## 1. Instance
| Name | Type | Flags | Default Value | Description |  
| ---- | ---- | ----- | ------------- | ----------- |  
| `serverinstance_database_version` | unsigned_number | flag instance variable | `0` | no description |  
| `serverinstance_permissions_version` | unsigned_number | flag instance variable | `0` | no description |  
| `serverinstance_filetransfer_host` | string | flag save, flag instance variable | `0.0.0.0,[::]` | no description |  
| `serverinstance_filetransfer_port` | unsigned_number | flag save, flag instance variable | `30303` | no description |  
| `serverinstance_filetransfer_max_connections` | unsigned_number | flag save, flag instance variable | `100` | no description |  
| `serverinstance_filetransfer_max_connections_per_ip` | unsigned_number | flag save, flag instance variable | `20` | no description |  
| `serverinstance_query_host` | string | flag save, flag instance variable | `0.0.0.0,[::]` | no description |  
| `serverinstance_query_port` | unsigned_number | flag save, flag instance variable | `10101` | no description |  
| `serverinstance_query_max_connections` | unsigned_number | flag save, flag instance variable | `100` | no description |  
| `serverinstance_query_max_connections_per_ip` | unsigned_number | flag save, flag instance variable | `3` | no description |  
| `serverinstance_monthly_timestamp` | unsigned_number | flag save, flag instance variable | `0` | no description |  
| `serverinstance_max_download_total_bandwidth` | signed_number | flag save, flag instance variable | `-1` | no description |  
| `serverinstance_max_upload_total_bandwidth` | signed_number | flag save, flag instance variable | `-1` | no description |  
| `serverinstance_serverquery_flood_commands` | unsigned_number | flag save, flag instance variable | `3` | no description |  
| `serverinstance_serverquery_flood_time` | unsigned_number | flag save, flag instance variable | `1` | no description |  
| `serverinstance_serverquery_ban_time` | unsigned_number | flag save, flag instance variable | `600` | no description |  
| `serverinstance_template_serveradmin_group` | unsigned_number | flag save, flag instance variable | `0` | no description |  
| `serverinstance_template_serverdefault_group` | unsigned_number | flag save, flag instance variable | `0` | no description |  
| `serverinstance_template_channeladmin_group` | unsigned_number | flag save, flag instance variable | `0` | no description |  
| `serverinstance_template_channeldefault_group` | unsigned_number | flag save, flag instance variable | `0` | no description |  
| `serverinstance_template_musicdefault_group` | unsigned_number | flag save, flag instance variable | `0` | no description |  
| `serverinstance_guest_serverquery_group` | unsigned_number | flag save, flag instance variable | `0` | no description |  
| `serverinstance_admin_serverquery_group` | unsigned_number | flag save, flag instance variable | `0` | no description |  
| `serverinstance_pending_connections_per_ip` | unsigned_number | flag save, flag instance variable | `0` | no description |  
| `serverinstance_virtual_server_id_index` | unsigned_number | flag save, flag new, flag instance variable | `1` | no description |  
 
  
## 2. Virtual Server
| Name | Type | Flags | Default Value | Description |  
| ---- | ---- | ----- | ------------- | ----------- |  
| `virtualserver_unique_identifier` | string | flag snapshot, flag server variable, flag server view | empty | The unique identifier of the server, used for the client to identify and verify the server |  
| `virtualserver_name` | string | flag snapshot, flag save, flag server variable, flag server view, flag user editable | `Another\sTeaSpeak\sserver\ssoftware\suser` | The official name of the server |  
| `virtualserver_welcomemessage` | string | flag snapshot, flag save, flag server variable, flag server view, flag user editable | `Welcome\son\sanother\sTeaSpeak\sserver.\s(Download\snow\sand\sa\slicense\sfee\sis\snot\syour\scup\sof\stea!\s[URL]www.teaspeak.de[\/URL])` | The welcome message for the server, printed in the client log |  
| `virtualserver_platform` | string | flag server view | `undefined` | The platform the server runs on (set by the TeaSpeak server internally) |  
| `virtualserver_version` | string | flag server view | `undefined` | no description |  
| `virtualserver_maxclients` | unsigned_number | flag snapshot, flag save, flag server variable, flag server view, flag user editable | `120` | no description |  
| `virtualserver_password` | string | flag snapshot, flag save, flag user editable | empty | no description |  
| `virtualserver_clientsonline` | unsigned_number | flag server variable | `0` | no description |  
| `virtualserver_queryclientsonline` | unsigned_number | flag server variable | `0` | no description |  
| `virtualserver_channelsonline` | unsigned_number | flag server variable | `0` | no description |  
| `virtualserver_created` | unsigned_number | flag snapshot, flag save, flag server view | `0` | no description |  
| `virtualserver_uptime` | unsigned_number | flag server variable | `0` | no description |  
| `virtualserver_codec_encryption_mode` | unsigned_number | flag snapshot, flag save, flag server variable, flag server view, flag user editable | `0` | no description |  
| `virtualserver_keypair` | string | flag snapshot, flag save | empty | no description |  
| `virtualserver_hostmessage` | string | flag snapshot, flag save, flag server variable, flag server view, flag user editable | `Welcome` | no description |  
| `virtualserver_hostmessage_mode` | string | flag snapshot, flag save, flag server variable, flag server view, flag user editable | `1` | no description |  
| `virtualserver_filebase` | string | flag snapshot, flag save, flag server variable, flag user editable | empty | no description |  
| `virtualserver_default_server_group` | unsigned_number | flag snapshot, flag save, flag server variable, flag server view, flag user editable | `0` | no description |  
| `virtualserver_default_music_group` | unsigned_number | flag snapshot, flag save, flag server variable, flag server view, flag user editable | `0` | no description |  
| `virtualserver_default_channel_group` | unsigned_number | flag snapshot, flag save, flag server variable, flag server view, flag user editable | `0` | no description |  
| `virtualserver_flag_password` | bool | flag snapshot, flag save, flag server variable, flag user editable | `0` | no description |  
| `virtualserver_default_channel_admin_group` | unsigned_number | flag snapshot, flag save, flag server variable, flag server view, flag user editable | `0` | no description |  
| `virtualserver_max_download_total_bandwidth` | signed_number | flag snapshot, flag save, flag server variable, flag user editable | `-1` | no description |  
| `virtualserver_max_upload_total_bandwidth` | signed_number | flag snapshot, flag save, flag server variable, flag user editable | `-1` | no description |  
| `virtualserver_hostbanner_url` | string | flag snapshot, flag save, flag server variable, flag server view, flag user editable | empty | no description |  
| `virtualserver_hostbanner_gfx_url` | string | flag snapshot, flag save, flag server variable, flag server view, flag user editable | empty | no description |  
| `virtualserver_hostbanner_gfx_interval` | unsigned_number | flag snapshot, flag save, flag server variable, flag server view, flag user editable | `0` | no description |  
| `virtualserver_hostbanner_mode` | unsigned_number | flag snapshot, flag save, flag server variable, flag server view, flag user editable | `0` | no description |  
| `virtualserver_complain_autoban_count` | unsigned_number | flag snapshot, flag save, flag server variable, flag user editable | `5` | no description |  
| `virtualserver_complain_autoban_time` | unsigned_number | flag snapshot, flag save, flag server variable, flag user editable | `5` | no description |  
| `virtualserver_complain_remove_time` | unsigned_number | flag snapshot, flag save, flag server variable, flag user editable | `5` | no description |  
| `virtualserver_min_clients_in_channel_before_forced_silence` | unsigned_number | flag snapshot, flag save, flag server variable, flag user editable | `20` | no description |  
| `virtualserver_priority_speaker_dimm_modificator` | float | flag snapshot, flag save, flag server variable, flag server view, flag user editable | `-18` | no description |  
| `virtualserver_id` | unsigned_number | flag server view | `0` | no description |  
| `virtualserver_antiflood_points_tick_reduce` | unsigned_number | flag snapshot, flag save, flag server variable, flag user editable | `25` | no description |  
| `virtualserver_antiflood_points_needed_command_block` | unsigned_number | flag snapshot, flag save, flag server variable, flag user editable | `150` | no description |  
| `virtualserver_antiflood_points_needed_ip_block` | unsigned_number | flag snapshot, flag save, flag server variable, flag user editable | `300` | no description |  
| `virtualserver_client_connections` | unsigned_number | flag snapshot, flag save, flag server variable | `0` | no description |  
| `virtualserver_query_client_connections` | unsigned_number | flag snapshot, flag save, flag server variable | `0` | no description |  
| `virtualserver_hostbutton_tooltip` | string | flag snapshot, flag save, flag server variable, flag server view, flag user editable | empty | no description |  
| `virtualserver_hostbutton_url` | string | flag snapshot, flag save, flag server variable, flag server view, flag user editable | empty | no description |  
| `virtualserver_hostbutton_gfx_url` | string | flag snapshot, flag save, flag server variable, flag server view, flag user editable | empty | no description |  
| `virtualserver_download_quota` | signed_number | flag save, flag server variable, flag user editable | `-1` | no description |  
| `virtualserver_upload_quota` | signed_number | flag save, flag server variable, flag user editable | `-1` | no description |  
| `virtualserver_month_bytes_downloaded` | unsigned_number | flag save, flag server variable | `0` | no description |  
| `virtualserver_month_bytes_uploaded` | unsigned_number | flag save, flag server variable | `0` | no description |  
| `virtualserver_total_bytes_downloaded` | unsigned_number | flag save, flag server variable | `0` | no description |  
| `virtualserver_total_bytes_uploaded` | unsigned_number | flag save, flag server variable | `0` | no description |  
| `virtualserver_port` | unsigned_number | flag snapshot, flag save, flag server variable, flag user editable | `9987` | no description |  
| `virtualserver_host` | string | flag snapshot, flag save, flag server variable, flag user editable | `0.0.0.0,::` | no description |  
| `virtualserver_autostart` | bool | flag snapshot, flag save, flag server variable, flag user editable | `1` | no description |  
| `virtualserver_machine_id` | string | flag snapshot, flag save, flag server variable, flag user editable | empty | no description |  
| `virtualserver_needed_identity_security_level` | unsigned_number | flag snapshot, flag save, flag server variable, flag user editable | `8` | no description |  
| `virtualserver_log_client` | bool | flag snapshot, flag save, flag server variable, flag user editable | `1` | no description |  
| `virtualserver_log_query` | bool | flag snapshot, flag save, flag server variable, flag user editable | `1` | no description |  
| `virtualserver_log_channel` | bool | flag snapshot, flag save, flag server variable, flag user editable | `1` | no description |  
| `virtualserver_log_permissions` | bool | flag snapshot, flag save, flag server variable, flag user editable | `1` | no description |  
| `virtualserver_log_server` | bool | flag snapshot, flag save, flag server variable, flag user editable | `1` | no description |  
| `virtualserver_log_filetransfer` | bool | flag snapshot, flag save, flag server variable, flag user editable | `1` | no description |  
| `virtualserver_name_phonetic` | string | flag snapshot, flag save, flag server variable, flag server view, flag user editable | empty | no description |  
| `virtualserver_icon_id` | unsigned_number | flag snapshot, flag save, flag server variable, flag server view, flag user editable | `0` | no description |  
| `virtualserver_reserved_slots` | unsigned_number | flag snapshot, flag save, flag server variable, flag user editable | `0` | no description |  
| `virtualserver_total_packetloss_speech` | unsigned_number | flag server variable | `0` | no description |  
| `virtualserver_total_packetloss_keepalive` | float | flag server variable | `0` | no description |  
| `virtualserver_total_packetloss_control` | float | flag server variable | `0` | no description |  
| `virtualserver_total_packetloss_total` | float | flag server variable | `0` | no description |  
| `virtualserver_total_ping` | float | flag server variable | `0` | no description |  
| `virtualserver_weblist_enabled` | bool | flag snapshot, flag save, flag server variable, flag server view, flag user editable | `1` | no description |  
| `virtualserver_autogenerated_privilegekey` | string | flag save | empty | no description |  
| `virtualserver_ask_for_privilegekey` | bool | flag save, flag server variable, flag server view, flag user editable | `1` | no description |  
| `virtualserver_channel_temp_delete_delay_default` | unsigned_number | flag snapshot, flag save, flag server variable, flag server view, flag user editable | `60` | no description |  
| `virtualserver_min_client_version` | unsigned_number | flag server variable, flag user editable | `1445512488` | no description |  
| `virtualserver_min_android_version` | unsigned_number | flag server variable, flag user editable | `1407159763` | no description |  
| `virtualserver_min_ios_version` | unsigned_number | flag server variable, flag user editable | `1407159763` | no description |  
| `virtualserver_min_winphone_version` | unsigned_number | flag server variable, flag user editable | `1407159763` | no description |  
| `virtualserver_max_channels` | unsigned_number | flag server variable, flag user editable | `1000` | no description |  
| `virtualserver_last_client_connect` | unsigned_number | flag snapshot, flag save, flag new, flag server variable | `0` | no description |  
| `virtualserver_last_query_connect` | unsigned_number | flag snapshot, flag save, flag new, flag server variable | `0` | no description |  
| `virtualserver_last_client_disconnect` | unsigned_number | flag snapshot, flag save, flag new, flag server variable | `0` | no description |  
| `virtualserver_last_query_disconnect` | unsigned_number | flag snapshot, flag save, flag new, flag server variable | `0` | no description |  
| `virtualserver_web_host` | string | flag snapshot, flag save, flag new, flag server variable, flag user editable | `0.0.0.0` | no description |  
| `virtualserver_web_port` | unsigned_number | flag snapshot, flag save, flag new, flag server variable, flag user editable | `0` | no description |  
| `virtualserver_default_client_description` | string | flag snapshot, flag save, flag new, flag server variable, flag user editable | empty | no description |  
| `virtualserver_default_channel_description` | string | flag snapshot, flag save, flag new, flag server variable, flag user editable | empty | no description |  
| `virtualserver_default_channel_topic` | string | flag snapshot, flag save, flag new, flag server variable, flag user editable | empty | no description |  
| `virtualserver_music_bot_limit` | signed_number | flag snapshot, flag save, flag new, flag server variable, flag user editable | `-1` | no description |  
| `virtualserver_country_code` | string | flag save, flag server variable, flag server view, flag user editable | `XX` | no description |  

  
## 3. Channel
| Name | Type | Flags | Default Value | Description |  
| ---- | ---- | ----- | ------------- | ----------- |  
| `cid` | unsigned_number | flag snapshot, flag save, flag channel view | `0` | no description |  
| `cpid` | unsigned_number | flag snapshot, flag save, flag channel view | `0` | no description |  
| `channel_name` | string | flag snapshot, flag save, flag channel view, flag user editable | `undefined` | no description |  
| `channel_topic` | string | flag snapshot, flag save, flag channel view, flag user editable | empty | no description |  
| `channel_description` | string | flag snapshot, flag save, flag channel variable, flag user editable | empty | no description |  
| `channel_password` | string | flag snapshot, flag save, flag user editable | `0` | no description |  
| `channel_codec` | unsigned_number | flag snapshot, flag save, flag channel view, flag user editable | `4` | no description |  
| `channel_codec_quality` | unsigned_number | flag snapshot, flag save, flag channel view, flag user editable | `7` | no description |  
| `channel_maxclients` | signed_number | flag snapshot, flag save, flag channel view, flag user editable | `-1` | no description |  
| `channel_maxfamilyclients` | signed_number | flag snapshot, flag save, flag channel view, flag user editable | `-1` | no description |  
| `channel_order` | unsigned_number | flag snapshot, flag save, flag channel view, flag user editable | `0` | no description |  
| `channel_flag_permanent` | bool | flag snapshot, flag save, flag channel view, flag user editable | `1` | no description |  
| `channel_flag_semi_permanent` | bool | flag snapshot, flag save, flag channel view, flag user editable | `0` | no description |  
| `channel_flag_default` | bool | flag snapshot, flag save, flag channel view, flag user editable | `0` | no description |  
| `channel_flag_password` | bool | flag snapshot, flag save, flag channel view, flag user editable | `0` | no description |  
| `channel_codec_latency_factor` | unsigned_number | flag snapshot, flag save, flag channel view, flag user editable | `1` | no description |  
| `channel_codec_is_unencrypted` | bool | flag snapshot, flag save, flag channel view, flag user editable | `1` | no description |  
| `channel_security_salt` | string | flag snapshot, flag save | empty | no description |  
| `channel_delete_delay` | unsigned_number | flag snapshot, flag save, flag channel view, flag user editable | `0` | no description |  
| `channel_flag_maxclients_unlimited` | bool | flag snapshot, flag save, flag channel view, flag user editable | `1` | no description |  
| `channel_flag_maxfamilyclients_unlimited` | bool | flag snapshot, flag save, flag channel view, flag user editable | `1` | no description |  
| `channel_flag_maxfamilyclients_inherited` | bool | flag snapshot, flag save, flag channel view, flag user editable | `0` | no description |  
| `channel_filepath` | string | flag snapshot, flag save | empty | no description |  
| `channel_needed_talk_power` | unsigned_number | flag snapshot, flag save, flag channel view, flag user editable | `0` | no description |  
| `channel_forced_silence` | bool | flag snapshot, flag save, flag channel view, flag user editable | `0` | no description |  
| `channel_name_phonetic` | string | flag snapshot, flag save, flag channel view, flag user editable | empty | no description |  
| `channel_icon_id` | unsigned_number | flag snapshot, flag save, flag channel view, flag user editable | `0` | no description |  
| `channel_flag_private` | bool | flag snapshot, flag save, flag channel view | `0` | no description |  
| `channel_last_left` | unsigned_number | flag save, flag new, flag channel variable, flag channel view | `0` | no description |  
| `channel_created_at` | unsigned_number | flag snapshot, flag save, flag new, flag channel variable, flag channel view | `0` | no description |  
| `channel_created_by` | unsigned_number | flag snapshot, flag save, flag new, flag channel variable, flag channel view | `0` | no description |  
| `channel_conversation_history_length` | signed_number | flag snapshot, flag save, flag new, flag channel variable, flag channel view, flag user editable | `1500` | no description |  
| `channel_conversation_mode` | unsigned_number | flag snapshot, flag save, flag new, flag channel variable, flag channel view, flag user editable | `1` | no description |  

  
## 4. Client
| Name | Type | Flags | Default Value | Description |  
| ---- | ---- | ----- | ------------- | ----------- |  
| `client_unique_identifier` | string | flag global, flag snapshot, flag client view | empty | no description |  
| `client_nickname` | string | flag global, flag snapshot, flag save music, flag client view, flag user editable | `undefined` | no description |  
| `client_version` | string | flag global, flag snapshot, flag save, flag save music, flag client variable, flag client view, flag user editable | `unknown` | no description |  
| `client_platform` | string | flag global, flag snapshot, flag save, flag save music, flag client variable, flag client view, flag user editable | `unknown` | no description |  
| `client_input_muted` | bool | flag client view, flag user editable | `0` | no description |  
| `client_output_muted` | bool | flag client view, flag user editable | `0` | no description |  
| `client_outputonly_muted` | bool | flag client view, flag user editable | `0` | no description |  
| `client_input_hardware` | bool | flag client view, flag user editable | `0` | no description |  
| `client_output_hardware` | bool | flag client view, flag user editable | `0` | no description |  
| `client_meta_data` | string | flag global, flag client view, flag user editable | empty | no description |  
| `client_is_recording` | bool | flag client view, flag user editable | `0` | no description |  
| `client_login_name` | string | flag global, flag client variable | empty | no description |  
| `client_database_id` | unsigned_number | flag global, flag client view | `0` | no description |  
| `clid` | unsigned_number | flag client variable, flag client view | `0` | no description |  
| `hwid` | string | flag save | empty | no description |  
| `client_channel_group_id` | unsigned_number | flag client view | `0` | no description |  
| `client_servergroups` | string | flag client view | `0` | no description |  
| `client_created` | unsigned_number | flag global, flag snapshot, flag save music, flag client variable | `0` | no description |  
| `client_lastconnected` | unsigned_number | flag global, flag snapshot, flag client variable | `0` | no description |  
| `client_totalconnections` | unsigned_number | flag global, flag snapshot, flag client variable, flag client view | `0` | no description |  
| `client_away` | bool | flag client view, flag user editable | `0` | no description |  
| `client_away_message` | string | flag client view, flag user editable | empty | no description |  
| `client_type` | unsigned_number | flag global, flag client view | `0` | no description |  
| `client_type_exact` | unsigned_number | flag global, flag new, flag client view | `0` | no description |  
| `client_flag_avatar` | string | flag save, flag client view, flag user editable | empty | no description |  
| `client_talk_power` | unsigned_number | flag client view | `0` | no description |  
| `client_talk_request` | bool | flag client view, flag user editable | `0` | no description |  
| `client_talk_request_msg` | string | flag client view, flag user editable | empty | no description |  
| `client_description` | string | flag snapshot, flag save, flag client view, flag user editable | empty | no description |  
| `client_is_talker` | bool | flag client view, flag user editable | `0` | no description |  
| `client_month_bytes_uploaded` | unsigned_number | flag global, flag save, flag client variable | `0` | no description |  
| `client_month_bytes_downloaded` | unsigned_number | flag global, flag save, flag client variable | `0` | no description |  
| `client_total_bytes_uploaded` | unsigned_number | flag global, flag save, flag client variable | `0` | no description |  
| `client_total_bytes_downloaded` | unsigned_number | flag global, flag save, flag client variable | `0` | no description |  
| `client_total_online_time` | unsigned_number | flag save, flag new, flag client variable | `0` | no description |  
| `client_month_online_time` | unsigned_number | flag save, flag new, flag client variable | `0` | no description |  
| `client_is_priority_speaker` | bool | flag client view, flag user editable | `0` | no description |  
| `client_unread_messages` | unsigned_number | flag client view | `0` | no description |  
| `client_nickname_phonetic` | string | flag client view, flag user editable | empty | no description |  
| `client_needed_serverquery_view_power` | unsigned_number | flag client view | `0` | no description |  
| `client_icon_id` | unsigned_number | flag client variable, flag client view | `0` | no description |  
| `client_is_channel_commander` | bool | flag save music, flag client view, flag user editable | `0` | no description |  
| `client_country` | string | flag global, flag save music, flag client variable, flag client view, flag user editable | `TS` | no description |  
| `client_channel_group_inherited_channel_id` | unsigned_number | flag client view | `0` | no description |  
| `client_badges` | string | flag client view, flag user editable | empty | no description |  
| `client_myteamspeak_id` | string | flag snapshot, flag save, flag client view, flag user editable | empty | no description |  
| `client_integrations` | string | flag client view, flag user editable | empty | no description |  
| `client_teaforo_id` | unsigned_number | flag global, flag new, flag client view | `0` | no description |  
| `client_teaforo_name` | string | flag global, flag new, flag client view | empty | no description |  
| `client_teaforo_flags` | unsigned_number | flag global, flag new, flag client view | `0` | no description |  
| `client_owner` | unsigned_number | flag new, flag client view | `0` | no description |  
| `client_bot_type` | unsigned_number | flag save music, flag new, flag client view, flag user editable | `0` | no description |  
| `player_state` | unsigned_number | flag save music, flag new, flag client view | `0` | no description |  
| `player_volume` | float | flag save music, flag new, flag client view, flag user editable | `1` | no description |  
| `client_playlist_id` | unsigned_number | flag save music, flag new, flag client variable | `0` | no description |  
| `client_disabled` | bool | flag new, flag client variable | `0` | no description |  
| `client_uptime_mode` | unsigned_number | flag save music, flag new, flag client variable, flag user editable | `0` | no description |  
| `client_flag_notify_song_change` | bool | flag save music, flag new, flag client variable, flag user editable | `1` | no description |  

  
## 5. Playlist
| Name | Type | Flags | Default Value | Description |  
| ---- | ---- | ----- | ------------- | ----------- |  
| `playlist_id` | unsigned_number | flag playlist variable | `0` | no description |  
| `playlist_title` | string | flag save, flag user editable, flag playlist variable | `Yet\sanother\splaylist` | no description |  
| `playlist_description` | string | flag save, flag user editable, flag playlist variable | empty | no description |  
| `playlist_type` | unsigned_number | flag save, flag playlist variable | `0` | no description |  
| `playlist_owner_dbid` | unsigned_number | flag save, flag playlist variable | `0` | no description |  
| `playlist_owner_name` | string | flag save, flag playlist variable | `0` | no description |  
| `playlist_max_songs` | signed_number | flag save, flag user editable, flag playlist variable | `-1` | no description |  
| `playlist_flag_delete_played` | bool | flag save, flag user editable, flag playlist variable | `1` | no description |  
| `playlist_flag_finished` | bool | flag save, flag user editable, flag playlist variable | `0` | no description |  
| `playlist_replay_mode` | unsigned_number | flag save, flag user editable, flag playlist variable | `0` | no description |  
| `playlist_current_song_id` | unsigned_number | flag save, flag playlist variable | `0` | no description |  
