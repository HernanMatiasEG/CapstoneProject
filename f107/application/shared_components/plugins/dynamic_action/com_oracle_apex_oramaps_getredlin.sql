prompt --application/shared_components/plugins/dynamic_action/com_oracle_apex_oramaps_getredlin
begin
--   Manifest
--     PLUGIN: COM.ORACLE.APEX.ORAMAPS.GETREDLIN
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
 p_id=>wwv_flow_api.id(59825926218090120011)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'COM.ORACLE.APEX.ORAMAPS.GETREDLIN'
,p_display_name=>'Oracle Maps - Get Redline'
,p_category=>'MISC'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('DYNAMIC ACTION','COM.ORACLE.APEX.ORAMAPS.GETREDLIN'),'')
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function render_da_oramaps_getRedline(',
'    p_dynamic_action in apex_plugin.t_dynamic_action,',
'    p_plugin         in apex_plugin.t_plugin )',
'    return apex_plugin.t_dynamic_action_render_result',
'is',
'    l_type          varchar2(30)   := upper(p_dynamic_action.attribute_01);',
'    l_item_names    apex_application_page_da_acts.affected_elements%type;',
'    l_result        apex_plugin.t_dynamic_action_render_result;       ',
'begin',
'  begin',
'    select affected_elements into l_item_names',
'    from apex_application_page_da_acts',
'    where application_id = v(''APP_ID'') and page_id = v(''APP_PAGE_ID'')',
'    and action_id = p_dynamic_action.id;',
'  exception',
'    when NO_DATA_FOUND then ',
'      apex_debug.message(',
'        p_message => ''ORAMAPS_DA_GETREDLINE: FATAL ERROR: Dynamic Action ID "%s" not found in the APEX dictionary!'',',
'        p0      => p_dynamic_action.id,',
'        p_level   => apex_debug.c_log_level_error',
'      );',
'      raise_application_error(-20000, ''FATAL ERROR: ''||p_dynamic_action.id||'' not found in dictionary for APP:PAGE ''||v(''APP_ID'')||'':''||v(''APP_PAGE_ID''), true);',
'  end;',
'',
'  apex_debug.message(',
'    p_message => ''ORAMAPS_DA_GETREDLINE: found affected elements: %s'',',
'    p0        => l_item_names,',
'    p_level   => apex_debug.c_log_level_info',
'  );',
'  l_result.javascript_function := ''function () {',
'     $s(''||apex_javascript.add_value(l_item_names, false)||'', getOramaps_redlinegeom(this.triggeringElement.id, ''||apex_javascript.add_value(l_type, false)||''));',
'  }'';',
'  apex_debug.message(',
'       p_message => ''ORAMAPS_DA_GETREDLINE: JavaScript function is: %s'',',
'        p0      => l_result.javascript_function,',
'        p_level   => apex_debug.c_log_level_info',
'      );',
'  return l_result;',
'end render_da_oramaps_getRedline;',
''))
,p_api_version=>1
,p_render_function=>'render_da_oramaps_getRedline'
,p_standard_attributes=>'ITEM:REQUIRED'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'20140707'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(59825926512483122637)
,p_plugin_id=>wwv_flow_api.id(59825926218090120011)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Render Data as'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'XML'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(59825926811189123261)
,p_plugin_attribute_id=>wwv_flow_api.id(59825926512483122637)
,p_display_sequence=>10
,p_display_value=>'JSON'
,p_return_value=>'JSON'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(59825927210327123612)
,p_plugin_attribute_id=>wwv_flow_api.id(59825926512483122637)
,p_display_sequence=>20
,p_display_value=>'XML'
,p_return_value=>'XML'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2018486011342184984)
,p_plugin_attribute_id=>wwv_flow_api.id(59825926512483122637)
,p_display_sequence=>30
,p_display_value=>'Well Known Text (WKT)'
,p_return_value=>'WKT'
);
wwv_flow_api.component_end;
end;
/
