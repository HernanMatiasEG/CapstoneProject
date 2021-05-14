prompt --application/shared_components/plugins/dynamic_action/com_oracle_apex_oramaps_clearrl
begin
--   Manifest
--     PLUGIN: COM.ORACLE.APEX.ORAMAPS.CLEARRL
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
 p_id=>wwv_flow_api.id(60762821463353515234)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'COM.ORACLE.APEX.ORAMAPS.CLEARRL'
,p_display_name=>'Oracle Maps - Map Actions'
,p_category=>'EXECUTE'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('DYNAMIC ACTION','COM.ORACLE.APEX.ORAMAPS.CLEARRL'),'')
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function render_da_oramaps_redline_acts(',
'    p_dynamic_action in apex_plugin.t_dynamic_action,',
'    p_plugin         in apex_plugin.t_plugin )',
'    return apex_plugin.t_dynamic_action_render_result',
'is',
'    l_region_id     apex_application_page_da_acts.affected_elements%type;',
'    l_action        p_dynamic_action.attribute_01%type := upper(p_dynamic_action.attribute_01);',
'  ',
'    l_result        apex_plugin.t_dynamic_action_render_result;       ',
'begin',
'  begin',
'    select nvl(r.static_id, ''R''||da.affected_region_id) into l_region_id',
'    from apex_application_page_da_acts da, apex_application_page_regions r',
'    where da.affected_region_id = r.region_id',
'    and da.application_id = v(''APP_ID'') and da.page_id = v(''APP_PAGE_ID'')',
'    and da.action_id = p_dynamic_action.id;',
'  exception',
'    when NO_DATA_FOUND then ',
'      apex_debug.message(',
'        p_message => ''ORAMAPS_DA_REDLINE_ACT: FATAL ERROR: Dynamic Action ID "%s" not found in the APEX dictionary!'',',
'        p0      => p_dynamic_action.id,',
'        p_level   => apex_debug.c_log_level_error',
'      );',
'      raise_application_error(-20000, ''FATAL ERROR: ''||p_dynamic_action.id||'' not found in dictionary for APP:PAGE ''||v(''APP_ID'')||'':''||v(''APP_PAGE_ID''), true);',
'  end;',
'',
'  apex_debug.message(',
'    p_message => ''ORAMAPS_DA_REDLINE_ACT: found affected region: %s'',',
'    p0        => l_region_id,',
'    p_level   => apex_debug.c_log_level_info',
'  );',
'  if l_action = ''RLCLEAR'' then',
'    l_result.javascript_function := ''function () {',
'       getOramaps_clearRedLine(''||apex_javascript.add_value(l_region_id, false)||'');',
'    }'';',
'  elsif l_action = ''CLEARCIRCLE'' then',
'    l_result.javascript_function := ''function () {',
'       getOramaps_clearCircle(''||apex_javascript.add_value(l_region_id, false)||'');',
'    }'';',
'  elsif l_action = ''ENDCIRCLE'' then',
'    l_result.javascript_function := ''function () {',
'       getOramaps_finishCircle(''||apex_javascript.add_value(l_region_id, false)||'');',
'    }'';',
'  elsif l_action = ''STARTCIRCLE'' then',
'    l_result.javascript_function := ''function () {',
'       getOramaps_startCircle(''||apex_javascript.add_value(l_region_id, false)||'');',
'    }'';',
'  elsif l_action = ''RLSTART'' then',
'    l_result.javascript_function := ''function () {',
'       getOramaps_startRedLine(''||apex_javascript.add_value(l_region_id, false)||'');',
'    }'';',
'  elsif l_action = ''REMOVEMARKER'' then',
'    l_result.javascript_function := ''function () {',
'       getOramaps_removeCustomMarker(''||apex_javascript.add_value(l_region_id, false)||'');',
'    }'';',
'  elsif l_action = ''REFRESHFOI'' then',
'    l_result.javascript_function := ''function () {',
'       getOramaps_refreshSqlFOI(''||apex_javascript.add_value(l_region_id, false)||'');',
'    }'';',
'  elsif l_action = ''RLFINISH'' then',
'    l_result.javascript_function := ''function () {',
'       getOramaps_finishRedLine(''||apex_javascript.add_value(l_region_id, false)||'');',
'    }'';',
'  elsif l_action = ''RECTZOOM'' then',
'    l_result.javascript_function := ''function () {',
'       getOramaps_startRectZoom(''||apex_javascript.add_value(l_region_id, false)||'');',
'    }'';',
'  elsif l_action = ''DISTANCE'' then',
'    l_result.javascript_function := ''function () {',
'       getOramaps_startDistanceTool(''||apex_javascript.add_value(l_region_id, false)||'');',
'    }'';',
'  end if;',
'  apex_debug.message(',
'       p_message => ''ORAMAPS_DA_REDLINE_ACT: JavaScript function is: %s'',',
'        p0      => l_result.javascript_function,',
'        p_level   => apex_debug.c_log_level_info',
'      );',
'  return l_result;',
'end render_da_oramaps_redline_acts; ',
'',
''))
,p_api_version=>1
,p_render_function=>'render_da_oramaps_redline_acts'
,p_standard_attributes=>'REGION:REQUIRED'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'20140707'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(2978460528530609737)
,p_plugin_id=>wwv_flow_api.id(60762821463353515234)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Map Action'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'RECTZOOM'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2978461125726611009)
,p_plugin_attribute_id=>wwv_flow_api.id(2978460528530609737)
,p_display_sequence=>10
,p_display_value=>'Rectangle Zoom'
,p_return_value=>'RECTZOOM'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2978462522491612568)
,p_plugin_attribute_id=>wwv_flow_api.id(2978460528530609737)
,p_display_sequence=>20
,p_display_value=>'Distance Tool'
,p_return_value=>'DISTANCE'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2978462919256614063)
,p_plugin_attribute_id=>wwv_flow_api.id(2978460528530609737)
,p_display_sequence=>30
,p_display_value=>'Start Drawing'
,p_return_value=>'RLSTART'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2978464517100615019)
,p_plugin_attribute_id=>wwv_flow_api.id(2978460528530609737)
,p_display_sequence=>40
,p_display_value=>'Finish Drawing'
,p_return_value=>'RLFINISH'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2978464915374615845)
,p_plugin_attribute_id=>wwv_flow_api.id(2978460528530609737)
,p_display_sequence=>50
,p_display_value=>'Clear Drawing'
,p_return_value=>'RLCLEAR'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2018490622317414589)
,p_plugin_attribute_id=>wwv_flow_api.id(2978460528530609737)
,p_display_sequence=>60
,p_display_value=>'Refresh SQL Features'
,p_return_value=>'REFRESHFOI'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2018494311476228766)
,p_plugin_attribute_id=>wwv_flow_api.id(2978460528530609737)
,p_display_sequence=>70
,p_display_value=>'Remove Markers'
,p_return_value=>'REMOVEMARKER'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2008217342616984355)
,p_plugin_attribute_id=>wwv_flow_api.id(2978460528530609737)
,p_display_sequence=>80
,p_display_value=>'Clear Circle Tool'
,p_return_value=>'CLEARCIRCLE'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2008217762781985209)
,p_plugin_attribute_id=>wwv_flow_api.id(2978460528530609737)
,p_display_sequence=>90
,p_display_value=>'Start Circle Tool'
,p_return_value=>'STARTCIRCLE'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2008218111220986692)
,p_plugin_attribute_id=>wwv_flow_api.id(2978460528530609737)
,p_display_sequence=>100
,p_display_value=>'Finish Circle Tool'
,p_return_value=>'ENDCIRCLE'
);
wwv_flow_api.component_end;
end;
/
