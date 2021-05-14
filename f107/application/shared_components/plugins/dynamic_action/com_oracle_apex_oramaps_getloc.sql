prompt --application/shared_components/plugins/dynamic_action/com_oracle_apex_oramaps_getloc
begin
--   Manifest
--     PLUGIN: COM.ORACLE.APEX.ORAMAPS.GETLOC
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(59825778790070712189)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'COM.ORACLE.APEX.ORAMAPS.GETLOC'
,p_display_name=>'Oracle Maps - get HTML5 Location'
,p_category=>'MISC'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('DYNAMIC ACTION','COM.ORACLE.APEX.ORAMAPS.GETLOC'),'')
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function render_da_oramaps_getlocation(',
'    p_dynamic_action in apex_plugin.t_dynamic_action,',
'    p_plugin         in apex_plugin.t_plugin )',
'    return apex_plugin.t_dynamic_action_render_result',
'is',
'    l_item_lat      varchar2(30)   := upper(p_dynamic_action.attribute_02);',
'    l_item_lon      varchar2(30)   := upper(p_dynamic_action.attribute_01);',
'    l_item_status   varchar2(30)   := upper(p_dynamic_action.attribute_03);',
'    l_result        apex_plugin.t_dynamic_action_render_result;       ',
'begin',
'  l_result.javascript_function := ''function () {',
'    if (navigator.geolocation) {',
'     navigator.geolocation.getCurrentPosition (',
'      function (pos) {',
'       try {',
'         if ($x(''||apex_javascript.add_value(l_item_lat, false)||'')) {',
'           $s(''||apex_javascript.add_value(l_item_lat, false)||'', String(pos.coords.latitude).replace(".", "''||substr(to_char((1/2), ''FM0D0''),2,1)||''"));',
'         }',
'         if ($x(''||apex_javascript.add_value(l_item_lon, false)||'')) {',
'           $s(''||apex_javascript.add_value(l_item_lon, false)||'', String(pos.coords.longitude).replace(".", "''||substr(to_char((1/2), ''FM0D0''),2,1)||''"));',
'         }',
'         if ($x(''||apex_javascript.add_value(l_item_status, false)||'')) {',
'           $s(''||apex_javascript.add_value(l_item_status, false)||'', "SUCCESS");',
'         }',
'         apex.event.trigger(',
'           document,',
'           "com_oracle_oramapshtml5_locsuccess"',
'         );',
'       } catch (e) {',
'         if ($v("pDebug")=="YES") {',
'           console.log(e);',
'         }',
'         apex.event.trigger(',
'           document,',
'           "com_oracle_oramapshtml5_locerror"',
'         );',
'       }',
'      },',
'      function(error) {',
'       var mesg;',
'       if ($v("pDebug")=="YES") {',
'         console.log(e);',
'       }',
'       switch (error.code) {',
'        case error.PERMISSION_DENIED:',
'         mesg = "ERROR: Permission denied.";',
'         break;',
'        case error.POSITION_UNAVAILABLE:',
'         mesg = "ERROR: Location information unavailable.";',
'         break;',
'        case error.TIMEOUT:',
'         mesg = "ERROR: Location retrieval timed out.";',
'         break;',
'        case error.UNKNOWN_ERROR:',
'         mesg = "ERROR: Unknown error.";',
'         break;',
'       } ',
'       if ($x(''||apex_javascript.add_value(l_item_status, false)||'')) {',
'         $s(''||apex_javascript.add_value(l_item_status, false)||'', mesg);',
'       }',
'       console.log(mesg);',
'       apex.event.trigger(',
'         document,',
'         "com_oracle_oramapshtml5_locerror"',
'       );',
'      } ',
'     );',
'    } else {',
'     mesg = "ERROR: No Geolocation capability available.";',
'     if ($x(''||apex_javascript.add_value(l_item_status, false)||'')) {',
'       $s(''||apex_javascript.add_value(l_item_status, false)||'', mesg);',
'     }',
'     console.log(mesg);',
'     apex.event.trigger(',
'       document,',
'       "com_oracle_oramapshtml5_locerror"',
'     );',
'    }',
'  }'';',
'  return l_result;',
'end render_da_oramaps_getlocation; '))
,p_api_version=>1
,p_render_function=>'render_da_oramaps_getlocation'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'	This plugin uses the Browsers&#39; HTML5 capabilities to get the current location. The longitude and latitude values are being stored in APEX items provided by the application developer. Upon receiving of the coordinate values from the browser the p'
||'lugin fires the<strong> HTML5 Location received</strong> event on the <strong>document</strong> DOM Element. You can create additional Dynamic Actions based on this in order to further process the coordinates.</p>'))
,p_version_identifier=>'20140707'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(59825779073033720030)
,p_plugin_id=>wwv_flow_api.id(59825778790070712189)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>5
,p_prompt=>'Item for Longitude value'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>true
,p_is_translatable=>false
,p_help_text=>'Specify Item to store the longitude value.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(59825779400194722630)
,p_plugin_id=>wwv_flow_api.id(59825778790070712189)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Item for Latitude value'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>true
,p_is_translatable=>false
,p_help_text=>'Item to store the longitude value.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(59822650641096591090)
,p_plugin_id=>wwv_flow_api.id(59825778790070712189)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Item for Status Message'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>true
,p_is_translatable=>false
,p_help_text=>'Specify the APEX item, in which to store the Status message (Success / Error) here.'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(59822651143456605160)
,p_plugin_id=>wwv_flow_api.id(59825778790070712189)
,p_name=>'com_oracle_oramapshtml5_locerror'
,p_display_name=>'HTML5 Location error'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(59825779783588730408)
,p_plugin_id=>wwv_flow_api.id(59825778790070712189)
,p_name=>'com_oracle_oramapshtml5_locsuccess'
,p_display_name=>'HTML5 Location received'
);
wwv_flow_api.component_end;
end;
/
