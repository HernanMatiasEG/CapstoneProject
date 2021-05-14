prompt --application/shared_components/plugins/dynamic_action/com_oracle_apex_oramaps_getdata
begin
--   Manifest
--     PLUGIN: COM.ORACLE.APEX.ORAMAPS.GETDATA
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
 p_id=>wwv_flow_api.id(59825924425277847669)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'COM.ORACLE.APEX.ORAMAPS.GETDATA'
,p_display_name=>'Oracle Maps - Get Data '
,p_category=>'MISC'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('DYNAMIC ACTION','COM.ORACLE.APEX.ORAMAPS.GETDATA'),'')
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function render_da_oramaps_getdata(',
'    p_dynamic_action in apex_plugin.t_dynamic_action,',
'    p_plugin         in apex_plugin.t_plugin )',
'    return apex_plugin.t_dynamic_action_render_result',
'is',
'    l_type           varchar2(30)   := upper(p_dynamic_action.attribute_01);',
'    l_srid           varchar2(30)   := upper(p_dynamic_action.attribute_02);',
'    l_region_id      apex_application_page_regions.static_id%type;',
'    l_it_map_bb_xmin p_dynamic_action.attribute_03%type := upper(p_dynamic_action.attribute_03);',
'    l_it_map_bb_ymin p_dynamic_action.attribute_04%type := upper(p_dynamic_action.attribute_04);',
'    l_it_map_bb_xmax p_dynamic_action.attribute_05%type := upper(p_dynamic_action.attribute_05);',
'    l_it_map_bb_ymax p_dynamic_action.attribute_06%type := upper(p_dynamic_action.attribute_06);',
'    l_it_map_ctr_x   p_dynamic_action.attribute_07%type := upper(p_dynamic_action.attribute_07);',
'    l_it_map_ctr_y   p_dynamic_action.attribute_08%type := upper(p_dynamic_action.attribute_08);',
'    l_it_map_mse_x   p_dynamic_action.attribute_09%type := upper(p_dynamic_action.attribute_09);',
'    l_it_map_mse_y   p_dynamic_action.attribute_10%type := upper(p_dynamic_action.attribute_10);',
'    l_it_map_zl_cur  p_dynamic_action.attribute_11%type := upper(p_dynamic_action.attribute_11);',
'    l_it_map_zl_max  p_dynamic_action.attribute_12%type := upper(p_dynamic_action.attribute_12);',
'    l_it_map_srid    p_dynamic_action.attribute_13%type := upper(p_dynamic_action.attribute_13);',
'    l_it_mapdata     p_dynamic_action.attribute_14%type := upper(p_dynamic_action.attribute_14);',
'    l_result         apex_plugin.t_dynamic_action_render_result;       ',
'',
'    l_js             varchar2(32767):='''';',
'    l_dec_char       varchar2(1);',
'begin',
'  l_dec_char := substr(to_char(1/2, ''FM0D0''),2,1);',
'  begin',
'    select nvl(r.static_id, ''R''||to_char(d.affected_region_id)) into l_region_id',
'    from apex_application_page_da_acts d, apex_application_page_regions r',
'    where d.affected_region_id = r.region_id and d.application_id = r.application_id and d.page_id = r.page_id',
'    and d.application_id = v(''APP_ID'') and d.page_id = v(''APP_PAGE_ID'')',
'    and d.action_id = p_dynamic_action.id;',
'',
'  exception',
'    when NO_DATA_FOUND then ',
'      apex_debug.message(',
'        p_message => ''ORAMAPS_DA_GETDATA: FATAL ERROR: Dynamic Action ID "%s" not found in the APEX dictionary!'',',
'        p0      => p_dynamic_action.id,',
'        p_level   => apex_debug.c_log_level_error',
'      );',
'      raise_application_error(-20000, ''FATAL ERROR: ''||p_dynamic_action.id||'' not found in dictionary for APP:PAGE ''||v(''APP_ID'')||'':''||v(''APP_PAGE_ID''), true);',
'  end;',
'',
'  apex_debug.message(',
'    p_message => ''ORAMAPS_DA_GETDATA: found affected region: %s'',',
'    p0        => l_region_id,',
'    p_level   => apex_debug.c_log_level_info',
'  );',
'  ',
'  l_js := ',
'    ''function () {''                                                          ||',
'       ''getOramaps_mapdata(''                                                 ||',
'          apex_javascript.add_value(l_region_id, true)                       ||',
'          ''"JSON", ''                                                         ||',
'          apex_javascript.add_value(l_srid, true)                            ||',
'          ''function( pData ) { ''                                             ||',
'          ''var lData = JSON.parse(pData);''                                   ;',
'',
'      if l_it_map_bb_xmin is not null then ',
'        l_js := l_js || ',
'         ''$s(''||apex_javascript.add_value(l_it_map_bb_xmin, false)||'', String(lData.mapdata.bbox.xmin).replace(".", "''||l_dec_char||''"));'';',
'      end if;',
'      if l_it_map_bb_ymin is not null then ',
'        l_js := l_js || ',
'         ''$s(''||apex_javascript.add_value(l_it_map_bb_ymin, false)||'', String(lData.mapdata.bbox.ymin).replace(".", "''||l_dec_char||''"));'';',
'      end if;',
'      if l_it_map_bb_xmax is not null then ',
'        l_js := l_js || ',
'         ''$s(''||apex_javascript.add_value(l_it_map_bb_xmax, false)||'', String(lData.mapdata.bbox.xmax).replace(".", "''||l_dec_char||''"));'';',
'      end if;',
'      if l_it_map_bb_ymax is not null then ',
'        l_js := l_js || ',
'         ''$s(''||apex_javascript.add_value(l_it_map_bb_ymax, false)||'', String(lData.mapdata.bbox.ymax).replace(".", "''||l_dec_char||''"));'';',
'      end if;',
'      if l_it_map_ctr_x is not null then ',
'        l_js := l_js || ',
'         ''$s(''||apex_javascript.add_value(l_it_map_ctr_x, false)||'', String(lData.mapdata.center.x).replace(".", "''||l_dec_char||''"));'';',
'      end if;',
'      if l_it_map_ctr_y is not null then ',
'        l_js := l_js || ',
'         ''$s(''||apex_javascript.add_value(l_it_map_ctr_y, false)||'', String(lData.mapdata.center.y).replace(".", "''||l_dec_char||''"));'';',
'      end if;',
'      if l_it_map_mse_x is not null then ',
'        l_js := l_js || ',
'         ''$s(''||apex_javascript.add_value(l_it_map_mse_x, false)||'', String(lData.mapdata.mouse_location.x).replace(".", "''||l_dec_char||''"));'';',
'      end if;',
'      if l_it_map_mse_y is not null then ',
'        l_js := l_js || ',
'         ''$s(''||apex_javascript.add_value(l_it_map_mse_y, false)||'', String(lData.mapdata.mouse_location.y).replace(".", "''||l_dec_char||''"));'';',
'      end if;',
'      if l_it_map_zl_cur is not null then ',
'        l_js := l_js || ',
'         ''$s(''||apex_javascript.add_value(l_it_map_zl_cur, false)||'', lData.mapdata.zoomlevel.current);'';',
'      end if;',
'      if l_it_map_zl_max is not null then ',
'        l_js := l_js || ',
'         ''$s(''||apex_javascript.add_value(l_it_map_zl_max, false)||'', lData.mapdata.zoomlevel.max);'';',
'      end if;',
'      if l_it_map_srid is not null then ',
'        l_js := l_js || ',
'         ''$s(''||apex_javascript.add_value(l_it_map_srid, false)||'', lData.mapdata.srid);'';',
'      end if;',
'',
'      if l_it_mapdata is not null then ',
'        l_js := l_js || ',
'         ''$s(''||apex_javascript.add_value(l_it_mapdata, false)||'', pData );'';',
'      end if;',
'',
'',
'  l_js := l_js || ''});}'';',
'   ',
'     ',
'  l_result.javascript_function := l_js;',
'  apex_debug.message(',
'       p_message => ''ORAMAPS_DA_GETDATA: JavaScript function is: %s'',',
'        p0      => l_result.javascript_function,',
'        p_level   => apex_debug.c_log_level_info',
'      );',
'  return l_result;',
'end render_da_oramaps_getdata;'))
,p_api_version=>1
,p_render_function=>'render_da_oramaps_getdata'
,p_standard_attributes=>'REGION'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'20140707'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(59825929818309200394)
,p_plugin_id=>wwv_flow_api.id(59825924425277847669)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Render Data As ...'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'JSON'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(59825930217015200953)
,p_plugin_attribute_id=>wwv_flow_api.id(59825929818309200394)
,p_display_sequence=>10
,p_display_value=>'JSON'
,p_return_value=>'JSON'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(59825930616152201322)
,p_plugin_attribute_id=>wwv_flow_api.id(59825929818309200394)
,p_display_sequence=>20
,p_display_value=>'XML'
,p_return_value=>'XML'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(59822663655131057301)
,p_plugin_id=>wwv_flow_api.id(59825924425277847669)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Coordinate System'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'WGS84'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(59822664150818059384)
,p_plugin_attribute_id=>wwv_flow_api.id(59822663655131057301)
,p_display_sequence=>10
,p_display_value=>'Longitiude / Latitude (WGS84)'
,p_return_value=>'WGS84'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(59822664548877060291)
,p_plugin_attribute_id=>wwv_flow_api.id(59822663655131057301)
,p_display_sequence=>20
,p_display_value=>'Current map projection'
,p_return_value=>'MAP'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(2974732279476932477)
,p_plugin_id=>wwv_flow_api.id(59825924425277847669)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Item for Map BBOX XMIN '
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(2974732974947934563)
,p_plugin_id=>wwv_flow_api.id(59825924425277847669)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Item for Map BBOX YMIN'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(2974733705774935475)
,p_plugin_id=>wwv_flow_api.id(59825924425277847669)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Item for Map BBOX XMAX'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(2974734403833936387)
,p_plugin_id=>wwv_flow_api.id(59825924425277847669)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Item for Map BBOX YMAX'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(2974735101029937632)
,p_plugin_id=>wwv_flow_api.id(59825924425277847669)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_prompt=>'Item for Map Center X'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(2974735799088938561)
,p_plugin_id=>wwv_flow_api.id(59825924425277847669)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_prompt=>'Item for Map Center Y'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(2974736494344940765)
,p_plugin_id=>wwv_flow_api.id(59825924425277847669)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>90
,p_prompt=>'Item for Mouse Location X'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(2974737192403941679)
,p_plugin_id=>wwv_flow_api.id(59825924425277847669)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>100
,p_prompt=>'Item for Mouse Location Y'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(2974737886796944236)
,p_plugin_id=>wwv_flow_api.id(59825924425277847669)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>110
,p_prompt=>'Item for current Zoomlevel'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(2974738583776945598)
,p_plugin_id=>wwv_flow_api.id(59825924425277847669)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>120
,p_prompt=>'Item for max. Zoomlevel'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(2974739281188946893)
,p_plugin_id=>wwv_flow_api.id(59825924425277847669)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>13
,p_display_sequence=>130
,p_prompt=>'Item for MAP SRID value'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(2974794178820212682)
,p_plugin_id=>wwv_flow_api.id(59825924425277847669)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>14
,p_display_sequence=>140
,p_prompt=>'Item for whole "Map Data" content (JSON / XML)'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.component_end;
end;
/
