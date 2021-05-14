prompt --application/shared_components/plugins/dynamic_action/com_oracle_apex_oramaps_getcircle
begin
--   Manifest
--     PLUGIN: COM.ORACLE.APEX.ORAMAPS.GETCIRCLE
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
 p_id=>wwv_flow_api.id(2008220060358030219)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'COM.ORACLE.APEX.ORAMAPS.GETCIRCLE'
,p_display_name=>'Oracle Maps - get Circle'
,p_category=>'MISC'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('DYNAMIC ACTION','COM.ORACLE.APEX.ORAMAPS.GETCIRCLE'),'')
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function render_da_oramaps_getcircle(',
'    p_dynamic_action in apex_plugin.t_dynamic_action,',
'    p_plugin         in apex_plugin.t_plugin )',
'    return apex_plugin.t_dynamic_action_render_result',
'is',
'    l_region_id      apex_application_page_regions.static_id%type;',
'    l_it_map_ctr_x   p_dynamic_action.attribute_01%type := upper(p_dynamic_action.attribute_01);',
'    l_it_map_ctr_y   p_dynamic_action.attribute_02%type := upper(p_dynamic_action.attribute_02);',
'    l_it_radius      p_dynamic_action.attribute_03%type := upper(p_dynamic_action.attribute_03);',
'    l_it_srid        p_dynamic_action.attribute_04%type := upper(p_dynamic_action.attribute_04);',
'    l_ret_srid       p_dynamic_action.attribute_05%type := upper(p_dynamic_action.attribute_05);',
'    l_result         apex_plugin.t_dynamic_action_render_result;       ',
'',
'    l_js             varchar2(32767):='''';',
'    l_dec_char       varchar2(1);',
'begin',
'  l_dec_char := substr(to_char(1/2, ''FM0D0''),2,1);',
'  l_js := ',
'    ''function ( ) {'' ||',
'      ''getOramaps_circledata(this.triggeringElement.id, ''||apex_javascript.add_value(l_ret_srid, true)||'' function (pData) {'';',
'  l_js := l_js || ',
'     ''$s(''||apex_javascript.add_value(l_it_map_ctr_x, false)||'', String(pData.center.x).replace(".", "''||l_dec_char||''"));'';',
'  l_js := l_js || ',
'     ''$s(''||apex_javascript.add_value(l_it_map_ctr_y, false)||'', String(pData.center.y).replace(".", "''||l_dec_char||''"));'';',
'    l_js := l_js || ',
'     ''$s(''||apex_javascript.add_value(l_it_radius,    false)||'', String(pData.radius).replace(".", "''||l_dec_char||''"));'';',
'    l_js := l_js || ',
'     ''$s(''||apex_javascript.add_value(l_it_srid  ,    false)||'', String(pData.srid).replace(".", "''||l_dec_char||''"));'';',
'  l_js := l_js || ''});}'';',
'  l_result.javascript_function := l_js;',
'  apex_debug.message(',
'       p_message => ''ORAMAPS_DA_GETCIRCLE: JavaScript function is: %s'',',
'        p0      => l_result.javascript_function,',
'        p_level   => apex_debug.c_log_level_info',
'      );',
'  return l_result;',
'end render_da_oramaps_getcircle;',
'',
'',
''))
,p_api_version=>1
,p_render_function=>'render_da_oramaps_getcircle'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'20140707'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(2008220444621056537)
,p_plugin_id=>wwv_flow_api.id(2008220060358030219)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Item for Circle Center X'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>true
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_is_translatable=>false
,p_help_text=>'Provide an APEX item to store the X-coordinate of the circle center in.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(2008220794107058689)
,p_plugin_id=>wwv_flow_api.id(2008220060358030219)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Item for Circle Center Y'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_is_translatable=>false
,p_help_text=>'Provide an APEX item to store the Y-coordinate of the circle center in.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(2008221031931061799)
,p_plugin_id=>wwv_flow_api.id(2008220060358030219)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Item for circle radius'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_is_translatable=>false
,p_help_text=>'Provide an APEX item to store the circle radius in.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(2008221344053068603)
,p_plugin_id=>wwv_flow_api.id(2008220060358030219)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'SRID of Circle Center (Map SRID)'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_is_translatable=>false
,p_help_text=>'Provide an APEX item to store the SRID value in which the circle center is being returned.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(2008429016969377603)
,p_plugin_id=>wwv_flow_api.id(2008220060358030219)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>5
,p_prompt=>'Coordinte system for return data'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_default_value=>'WGS84'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Determine whether the circle center should be returned in the map coordinate system or as longitude / latitude (WGS84).'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2008429457227378560)
,p_plugin_attribute_id=>wwv_flow_api.id(2008429016969377603)
,p_display_sequence=>10
,p_display_value=>'Longitiude / Latitude (WGS84)'
,p_return_value=>'WGS84'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2008429838700379444)
,p_plugin_attribute_id=>wwv_flow_api.id(2008429016969377603)
,p_display_sequence=>20
,p_display_value=>'Current map projection'
,p_return_value=>'MAP'
);
wwv_flow_api.component_end;
end;
/
