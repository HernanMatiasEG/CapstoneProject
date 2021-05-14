prompt --application/shared_components/plugins/dynamic_action/com_oracle_apex_oramaps_setmarker
begin
--   Manifest
--     PLUGIN: COM.ORACLE.APEX.ORAMAPS.SETMARKER
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
 p_id=>wwv_flow_api.id(59825948618197099627)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'COM.ORACLE.APEX.ORAMAPS.SETMARKER'
,p_display_name=>'Oracle Maps - set Custom Marker'
,p_category=>'EXECUTE'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('DYNAMIC ACTION','COM.ORACLE.APEX.ORAMAPS.SETMARKER'),'')
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function render_da_oramaps_setcustfoi(',
'    p_dynamic_action in apex_plugin.t_dynamic_action,',
'    p_plugin         in apex_plugin.t_plugin )',
'    return apex_plugin.t_dynamic_action_render_result',
'is',
'    l_item_x        varchar2(30)   := upper(p_dynamic_action.attribute_01);',
'    l_item_y        varchar2(30)   := upper(p_dynamic_action.attribute_02);',
'    l_item_srid     varchar2(30)   := upper(p_dynamic_action.attribute_03);',
'    l_style         varchar2(10)   := upper(p_dynamic_action.attribute_04);',
'    l_text          varchar2(100)  := upper(p_dynamic_action.attribute_05);',
'    l_region_id     apex_application_page_da_acts.affected_elements%type;',
'    l_result        apex_plugin.t_dynamic_action_render_result;       ',
'    l_srid          varchar2(100);',
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
'        p_message => ''ORAMAPS_DA_SETZOOM: FATAL ERROR: Dynamic Action ID "%s" not found in the APEX dictionary!'',',
'        p0      => p_dynamic_action.id,',
'        p_level   => apex_debug.c_log_level_error',
'      );',
'      raise_application_error(-20000, ''FATAL ERROR: ''||p_dynamic_action.id||'' not found in dictionary for APP:PAGE ''||v(''APP_ID'')||'':''||v(''APP_PAGE_ID''), true);',
'  end;',
'',
'  apex_debug.message(',
'    p_message => ''ORAMAPS_DA_SETZOOM: found affected region: %s'',',
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
'  l_result.javascript_function := ''function () {',
'     getOramaps_setCustomMarker(''||',
'       apex_javascript.add_value(l_region_id, false) || '', '' ||',
'       ''$v(''||apex_javascript.add_value(l_item_x, false)||''), '' ||',
'       ''$v(''||apex_javascript.add_value(l_item_y, false)||''), '' ||',
'       apex_javascript.add_value(l_srid, false) ||'', ''||',
'       apex_javascript.add_value(l_style, false) ||'', ''||',
'       apex_javascript.add_value(l_text, false)||',
'    '');',
'  }'';',
'  apex_debug.message(',
'       p_message => ''ORAMAPS_DA_SETZOOM: JavaScript function is: %s'',',
'        p0      => l_result.javascript_function,',
'        p_level   => apex_debug.c_log_level_info',
'      );',
'  return l_result;',
'end render_da_oramaps_setcustfoi; ',
'',
''))
,p_api_version=>1
,p_render_function=>'render_da_oramaps_setcustfoi'
,p_standard_attributes=>'REGION:REQUIRED'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'20140707'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(59825948907629104505)
,p_plugin_id=>wwv_flow_api.id(59825948618197099627)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Item containing Position X value:'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>true
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(59825949206120105166)
,p_plugin_id=>wwv_flow_api.id(59825948618197099627)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Item containing Position Y value:'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>true
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(59825949503532106400)
,p_plugin_id=>wwv_flow_api.id(59825948618197099627)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Coordinate System'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'WGS84'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'SRID of the coordinate values. Choose between <b>WGS84</b> (standard latitude/longitude) and the Coordinate System (projection) of the map. '
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(59825791377409424749)
,p_plugin_attribute_id=>wwv_flow_api.id(59825949503532106400)
,p_display_sequence=>10
,p_display_value=>'Longitude/Latitude (WGS84)'
,p_return_value=>'WGS84'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(59825791773959426349)
,p_plugin_attribute_id=>wwv_flow_api.id(59825949503532106400)
,p_display_sequence=>20
,p_display_value=>'Use Map Region Coordinate System'
,p_return_value=>'MAP'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(59825949799866108147)
,p_plugin_id=>wwv_flow_api.id(59825948618197099627)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Marker Style:'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'gray'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(59825950098787108569)
,p_plugin_attribute_id=>wwv_flow_api.id(59825949799866108147)
,p_display_sequence=>10
,p_display_value=>'Gray'
,p_return_value=>'gray'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(59825950498140108902)
,p_plugin_attribute_id=>wwv_flow_api.id(59825949799866108147)
,p_display_sequence=>20
,p_display_value=>'Blue'
,p_return_value=>'blue'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(59825950897278109267)
,p_plugin_attribute_id=>wwv_flow_api.id(59825949799866108147)
,p_display_sequence=>30
,p_display_value=>'Red'
,p_return_value=>'red'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(59825951296199109782)
,p_plugin_attribute_id=>wwv_flow_api.id(59825949799866108147)
,p_display_sequence=>40
,p_display_value=>'Green'
,p_return_value=>'green'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(59825951694474110594)
,p_plugin_attribute_id=>wwv_flow_api.id(59825949799866108147)
,p_display_sequence=>50
,p_display_value=>'Purple'
,p_return_value=>'purple'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(59825952093180111235)
,p_plugin_attribute_id=>wwv_flow_api.id(59825949799866108147)
,p_display_sequence=>60
,p_display_value=>'Yellow'
,p_return_value=>'yellow'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(59825952518831114466)
,p_plugin_id=>wwv_flow_api.id(59825948618197099627)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Marker Title'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'The Position!'
,p_display_length=>15
,p_max_length=>50
,p_is_translatable=>false
);
wwv_flow_api.component_end;
end;
/
