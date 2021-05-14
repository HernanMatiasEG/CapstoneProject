prompt --application/shared_components/plugins/dynamic_action/com_oracle_apex_oramaps_setcentzo
begin
--   Manifest
--     PLUGIN: COM.ORACLE.APEX.ORAMAPS.SETCENTZO
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
 p_id=>wwv_flow_api.id(59825795067187553566)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'COM.ORACLE.APEX.ORAMAPS.SETCENTZO'
,p_display_name=>'Oracle Maps - set Center / Zoomlevel'
,p_category=>'EXECUTE'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('DYNAMIC ACTION','COM.ORACLE.APEX.ORAMAPS.SETCENTZO'),'')
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function render_da_oramap_setCentZo(',
'    p_dynamic_action in apex_plugin.t_dynamic_action,',
'    p_plugin         in apex_plugin.t_plugin )',
'    return apex_plugin.t_dynamic_action_render_result',
'is',
'    l_item_cx       varchar2(30)   := upper(p_dynamic_action.attribute_01);',
'    l_item_cy       varchar2(30)   := upper(p_dynamic_action.attribute_02);',
'    l_item_srid     varchar2(30)   := upper(p_dynamic_action.attribute_03);',
'    l_item_zoom     varchar2(30)   := upper(p_dynamic_action.attribute_04);',
'    l_type          varchar2(30)   := upper(p_dynamic_action.attribute_05);',
'    l_srid          varchar2(100);',
'',
'    l_region_id     apex_application_page_da_acts.affected_elements%type;',
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
'        p_message => ''ORAMAPS_DA_SETCENTERZOOM: FATAL ERROR: Dynamic Action ID "%s" not found in the APEX dictionary!'',',
'        p0      => p_dynamic_action.id,',
'        p_level   => apex_debug.c_log_level_error',
'      );',
'      raise_application_error(-20000, ''FATAL ERROR: ''||p_dynamic_action.id||'' not found in dictionary for APP:PAGE ''||v(''APP_ID'')||'':''||v(''APP_PAGE_ID''), true);',
'  end;',
'',
'  apex_debug.message(',
'    p_message => ''ORAMAPS_DA_SETCENTERZOOM: found affected region: %s'',',
'    p0        => l_region_id,',
'    p_level   => apex_debug.c_log_level_info',
'  );',
'',
'  if l_item_srid = ''WGS84'' then ',
'    l_srid := ''4326'';',
'  else',
'    l_srid := '''';',
'  end if;',
'',
'  if l_type = ''ZOOM'' then ',
'    l_result.javascript_function := ''function () {',
'        getOramaps_setZoomLevel(''||apex_javascript.add_value(l_region_id, false)||'', $v(''||apex_javascript.add_value(l_item_zoom, false)||''));',
'     }'';',
'  elsif l_type = ''CENTER'' then',
'    l_result.javascript_function := ''function () {',
'       getOramaps_setCenter(''||',
'         apex_javascript.add_value(l_region_id, false) || '', '' ||',
'         ''$v(''||apex_javascript.add_value(l_item_cx, false) ||''), '' ||',
'         ''$v(''||apex_javascript.add_value(l_item_cy, false) ||''), '' ||',
'         apex_javascript.add_value(l_srid, false) ||',
'      '');',
'    }'';',
'  else ',
'    l_result.javascript_function := ''function () {',
'       getOramaps_setCenterZoom(''||',
'         apex_javascript.add_value(l_region_id, false)||'', ''||',
'         ''$v(''||apex_javascript.add_value(l_item_cx, false)||''), ''||',
'         ''$v(''||apex_javascript.add_value(l_item_cy, false)||''), ''||',
'         apex_javascript.add_value(l_srid, false)||'', '' ||',
'         ''$v(''||apex_javascript.add_value(l_item_zoom, false)||'')''||',
'      '');',
'    }'';',
'  end if;',
'  apex_debug.message(',
'       p_message => ''ORAMAPS_DA_SETCENTERZOOM: JavaScript function is: %s'',',
'        p0      => l_result.javascript_function,',
'        p_level   => apex_debug.c_log_level_info',
'      );',
'  return l_result;',
'end render_da_oramap_setCentZo; '))
,p_api_version=>1
,p_render_function=>'render_da_oramap_setCentZo'
,p_standard_attributes=>'REGION:REQUIRED'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'20140707'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(59825795388094559063)
,p_plugin_id=>wwv_flow_api.id(59825795067187553566)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Item containing Center X value'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(2018494474472264054)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'CENTER,CENTERZOOM'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(59825795682702561595)
,p_plugin_id=>wwv_flow_api.id(59825795067187553566)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Item containing Center Y value'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(2018494474472264054)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'CENTER,CENTERZOOM'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(59825795979252563173)
,p_plugin_id=>wwv_flow_api.id(59825795067187553566)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Coordinate System'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_default_value=>'WGS84'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(2018494474472264054)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'CENTER,CENTERZOOM'
,p_lov_type=>'STATIC'
,p_help_text=>'SRID of the coordinate values to set the map center. Choose <b>WGS84</b> for standard latitude/longitude values or <b>MAP</b> for values in the map region coordinate system. '
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(59825796276448564471)
,p_plugin_attribute_id=>wwv_flow_api.id(59825795979252563173)
,p_display_sequence=>10
,p_display_value=>'Longitude/Latitude (WGS84)'
,p_return_value=>'WGS84'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(59825796674507565355)
,p_plugin_attribute_id=>wwv_flow_api.id(59825795979252563173)
,p_display_sequence=>20
,p_display_value=>'Use Map Region Coordinate System'
,p_return_value=>'MAP'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(59825797389591573638)
,p_plugin_id=>wwv_flow_api.id(59825795067187553566)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Item containing Zoom Level value'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(2018494474472264054)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'ZOOM,CENTERZOOM'
,p_help_text=>'Specify the item containing the new Zoom Level value here.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(2018494474472264054)
,p_plugin_id=>wwv_flow_api.id(59825795067187553566)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>5
,p_prompt=>'Set'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'CENTER'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2018494802711266185)
,p_plugin_attribute_id=>wwv_flow_api.id(2018494474472264054)
,p_display_sequence=>10
,p_display_value=>'Set Map Center'
,p_return_value=>'CENTER'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2018495200554267181)
,p_plugin_attribute_id=>wwv_flow_api.id(2018494474472264054)
,p_display_sequence=>20
,p_display_value=>'Set Zoomlevel'
,p_return_value=>'ZOOM'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2018495597319268629)
,p_plugin_attribute_id=>wwv_flow_api.id(2018494474472264054)
,p_display_sequence=>30
,p_display_value=>'Set Map Center and Zoomlevel'
,p_return_value=>'CENTERZOOM'
);
wwv_flow_api.component_end;
end;
/
