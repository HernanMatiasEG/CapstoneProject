prompt --application/create_application
begin
--   Manifest
--     FLOW: 107
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_flow(
 p_id=>wwv_flow.g_flow_id
,p_owner=>nvl(wwv_flow_application_install.get_schema,'BILL_AND_COLL')
,p_name=>nvl(wwv_flow_application_install.get_application_name,'Geolocation and Tracking')
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'107')
,p_page_view_logging=>'YES'
,p_page_protection_enabled_y_n=>'Y'
,p_checksum_salt=>'68934C068A8106C0740C500C73EF52A0AB1D71100271FA44EA461016BEA2121B'
,p_checksum_salt_last_reset=>'20150102075609'
,p_bookmark_checksum_function=>'SH1'
,p_compatibility_mode=>'19.2'
,p_flow_language=>'en-us'
,p_flow_language_derived_from=>'FLOW_PRIMARY_LANGUAGE'
,p_date_format=>'mm/dd/yyyy'
,p_date_time_format=>'mm/dd/yyyy hh24:mi'
,p_timestamp_format=>'mm/dd/yyyy hh24:mi'
,p_timestamp_tz_format=>'mm/dd/yyyy hh24:mi'
,p_direction_right_to_left=>'N'
,p_flow_image_prefix => nvl(wwv_flow_application_install.get_image_prefix,'')
,p_authentication=>'PLUGIN'
,p_authentication_id=>wwv_flow_api.id(46757782511761001723)
,p_application_tab_set=>1
,p_logo_type=>'T'
,p_logo_text=>'Geolocation and Tracking'
,p_favicons=>'<link rel="shortcut icon" href="#IMAGE_PREFIX#apex_ui/img/favicons/app-sample-geolocation.ico"><link rel="icon" sizes="16x16" href="#IMAGE_PREFIX#apex_ui/img/favicons/app-sample-geolocation-16x16.png"><link rel="icon" sizes="32x32" href="#IMAGE_PREFI'
||'X#apex_ui/img/favicons/app-sample-geolocation-32x32.png"><link rel="apple-touch-icon" sizes="180x180" href="#IMAGE_PREFIX#apex_ui/img/favicons/app-sample-geolocation.png">'
,p_public_user=>'APEX_PUBLIC_USER'
,p_proxy_server=>nvl(wwv_flow_application_install.get_proxy,'')
,p_no_proxy_domains=>nvl(wwv_flow_application_install.get_no_proxy_domains,'')
,p_flow_version=>'19.2'
,p_flow_status=>'AVAILABLE_W_EDIT_LINK'
,p_flow_unavailable_text=>'This application is currently unavailable at this time.'
,p_exact_substitutions_only=>'Y'
,p_browser_cache=>'N'
,p_browser_frame=>'D'
,p_deep_linking=>'Y'
,p_runtime_api_usage=>'T'
,p_security_scheme=>wwv_flow_api.id(2193433286277507733)
,p_rejoin_existing_sessions=>'P'
,p_csv_encoding=>'Y'
,p_auto_time_zone=>'N'
,p_friendly_url=>'N'
,p_substitution_string_01=>'MAPSERVER_URL'
,p_substitution_value_01=>'https://elocation.oracle.com/mapviewer'
,p_substitution_string_02=>'MAPTILELAYER'
,p_substitution_value_02=>'elocation_mercator.world_map'
,p_substitution_string_03=>'MAPSERVER_NAME'
,p_substitution_value_03=>'Oracle eLocation Service'
,p_substitution_string_04=>'IMAGE_PROCESSING'
,p_substitution_value_04=>'SYNC'
,p_substitution_string_05=>'LICENSE_TERMS'
,p_substitution_value_05=>'The Oracle Maps and Geocoder Plug-ins within this Oracle Application Express application use the mapping and geocoding services of Oracle''s eLocation Service (maps.oracle.com). These Plug-ins must be used as-is and the services may only be accessed t'
||'hrough the Plug-ins. '
,p_substitution_string_06=>'LEGAL_NOTICE'
,p_substitution_value_06=>'The Here (formerly Navteq) data accessible through this service is subject to <a href="http://www.oracle.com/us/legal/index.html" target="_blank">Oracle Legal Notices</a> and under these <a href="http://elocation.oracle.com/elocation/legal.html" targ'
||'et="_blank">Terms of Use</a>.'
,p_substitution_string_07=>'MAP_COPYRIGHT'
,p_substitution_value_07=>'(c) 2020 Oracle Corporation  Map Data (c) 2020 HERE'
,p_substitution_string_08=>'MAPSERVER'
,p_substitution_value_08=>'https://elocation.oracle.com'
,p_substitution_string_09=>'APP_NAME'
,p_substitution_value_09=>'Geolocation and Tracking'
,p_substitution_string_10=>'MAP_OSM_COPYRIGHT'
,p_substitution_value_10=>'(c) 2020 OpenMapTiles (c) 2020 OpenStreetMap contributors'
,p_last_updated_by=>'B&C_ADMIN'
,p_last_upd_yyyymmddhh24miss=>'20210514073631'
,p_file_prefix => nvl(wwv_flow_application_install.get_static_app_file_prefix,'')
,p_files_version=>8
,p_ui_type_name => null
,p_print_server_type=>'INSTANCE'
);
wwv_flow_api.component_end;
end;
/
