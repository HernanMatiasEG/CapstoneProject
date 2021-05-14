prompt --application/shared_components/plugins/region_type/com_oracle_apex_oramaps_html5
begin
--   Manifest
--     PLUGIN: COM.ORACLE.APEX.ORAMAPS.HTML5
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
 p_id=>wwv_flow_api.id(61535298363463408228)
,p_plugin_type=>'REGION TYPE'
,p_name=>'COM.ORACLE.APEX.ORAMAPS.HTML5'
,p_display_name=>'Oracle HTML5 Maps - Region'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('REGION TYPE','COM.ORACLE.APEX.ORAMAPS.HTML5'),'')
,p_javascript_file_urls=>'#PLUGIN_FILES#apx-maps-plugin-html5.js'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'procedure intfunc_printjsonforgeom(',
'  p_attr_name  varchar2',
' ,p_geom       sdo_geometry',
') is ',
'begin',
'  apex_json.open_object(p_attr_name);',
'  apex_json.write(''sdo_gtype'', p_geom.sdo_gtype );',
'  apex_json.write(''sdo_srid'',  p_geom.sdo_srid);',
'  if p_geom.sdo_point is not null then',
'    apex_json.open_object(''sdo_point'');',
'    apex_json.write(''x'', nvl(replace(to_char(p_geom.sdo_point.x), '','', ''.''),''null''));',
'    apex_json.write(''y'', nvl(replace(to_char(p_geom.sdo_point.y), '','', ''.''),''null''));',
'    apex_json.write(''z'', nvl(replace(to_char(p_geom.sdo_point.z), '','', ''.''),''null''));',
'    apex_json.close_object;',
'  elsif  p_geom.sdo_gtype = 2001 and p_geom.sdo_ordinates.count >= 2 then',
'    apex_json.open_object(''sdo_point'');',
'    apex_json.write(''x'', nvl(replace(to_char(p_geom.sdo_ordinates( 1 )), '','', ''.''),''null''));',
'    apex_json.write(''y'', nvl(replace(to_char(p_geom.sdo_ordinates( 2 )), '','', ''.''),''null''));',
'    apex_json.write(''z'', ''null'');',
'    apex_json.close_object;  ',
'  else ',
'    apex_json.write(''sdo_point'', ''null'');',
'  end if;',
'  if p_geom.sdo_elem_info is not null then',
'    apex_json.open_array(''sdo_elem_info'');',
'    for i in p_geom.sdo_elem_info.first.. p_geom.sdo_elem_info.last loop',
'      apex_json.write(replace(to_char(p_geom.sdo_elem_info(i)),'','',''.''));',
'    end loop;',
'    apex_json.close_array;',
'  else',
'    apex_json.write(''sdo_elem_info'', ''null'');',
'  end if;',
'  if p_geom.sdo_ordinates is not null then',
'    apex_json.open_array(''sdo_ordinates'');',
'    for i in p_geom.sdo_ordinates.first.. p_geom.sdo_ordinates.last loop',
'      apex_json.write(replace(to_char(p_geom.sdo_ordinates(i)), '','', ''.''));',
'    end loop;',
'    apex_json.close_array;',
'  else',
'    apex_json.write(''sdo_ordinates'', ''null'');',
'  end if;',
'  apex_json.close_object;',
'end intfunc_printjsonforgeom;',
'',
'function render_map_ajax( ',
'    p_region              in apex_plugin.t_region,',
'    p_plugin              in apex_plugin.t_plugin',
') return apex_plugin.t_region_ajax_result is',
'  l_maxrows   apex_application_page_regions.attribute_14%type := p_region.attribute_14;',
'  l_output    clob;',
'begin',
' if apex_application.g_x10 = ''FOIDATA'' then',
'   apex_debug.message(',
'     p_message => ''ORACLE MAPS PLUGIN: Current Zoom Level %s.'',',
'     p0 => apex_application.g_x07,',
'     p_level   => apex_debug.c_log_level_info',
'   );',
'',
'   if p_region.source is not null then ',
'     declare',
'       l_sql               varchar2(32767);',
'       l_where             varchar2(32767);',
'       l_cur               apex_plugin_util.t_sql_handler;',
'',
'       l_bidx              pls_integer := 1;',
'       l_bsrid             boolean := true;',
'       l_bbbox             boolean := false;',
'       l_bzoom             boolean := false;',
'',
'       l_geomcol           varchar2(128);',
'       l_minzoom           boolean := false;',
'       l_maxzoom           boolean := false;',
'',
'       l_geom              sdo_geometry; ',
'       l_dummy             pls_integer;',
'       l_firstrow          boolean := true;',
'       l_column_value_list apex_plugin_util.t_column_value_list2; ',
'       l_bindlist          apex_plugin_util.t_bind_list;',
'     begin',
'       ',
'       -- parse the original SQL ',
'       l_cur := apex_plugin_util.get_sql_handler(',
'         p_sql_statement  => apex_plugin_util.replace_substitutions(p_region.source),',
'         p_min_columns    => 3,',
'         p_max_columns    => null,',
'         p_component_name => p_region.name',
'       );',
'',
'       l_sql := ''select '';',
'       for i in 1..l_cur.column_list.count loop',
'        -- Select ONLY columns consumable by the plugin',
'        if upper(l_cur.column_list(i).col_name) in (''ID'', ''INFOTEXT'', ''INFOTIP'', ''GEOMETRY'', ''STYLE'', ''MAXZOOM'', ''MINZOOM'', ''MARKERTEXT'', ''IMAGEURL'', ''LAYER'', ''MARKERSIZE'') then',
' ',
'         -- test for object types in general ',
'         if l_cur.column_list(i).col_type = 109 then ',
'           -- handle SDO_GEOMETRY only',
'           if l_cur.column_list(i).col_schema_name = ''MDSYS'' and l_cur.column_list(i).col_type_name = ''SDO_GEOMETRY'' then',
'             l_geomcol := l_cur.column_list(i).col_name;',
'             l_sql := l_sql || ''sdo_cs.transform(''||l_cur.column_list(i).col_name||'', to_number(:SRID)) as ''||l_cur.column_list(i).col_name||'','';',
'             l_bsrid := true;',
'           end if;',
'           -- and ignore all others',
'         else ',
'           l_sql := l_sql || l_cur.column_list(i).col_name || '','';',
'         end if;',
'         if upper(l_cur.column_list(i).col_name) = ''MINZOOM'' then l_minzoom := true; end if; ',
'         if upper(l_cur.column_list(i).col_name) = ''MAXZOOM'' then l_maxzoom := true; end if; ',
'        end if;',
'       end loop;',
'       -- remove last comma',
'       l_sql := substr(l_sql, 1, length(l_sql) - 1);',
'',
'       apex_debug.message(',
'         p_message => ''ORACLE MAPS PLUGIN: Generated SELECT list: %s'',',
'         p0 => l_sql,',
'         p_level   => apex_debug.c_log_level_info',
'       );',
'       ',
'       l_sql := l_sql || '' from ('';',
'       l_sql := l_sql ||    apex_plugin_util.replace_substitutions(p_region.source);',
'       l_sql := l_sql || '') e '';',
'',
'       l_where := '''';',
'',
'       if apex_application.g_x06 = ''Y'' then ',
'         l_where := l_where || ''where sdo_filter('';',
'         l_where := l_where ||   ''e.'' || l_geomcol || '', '';',
'         l_where := l_where ||   ''sdo_geometry('';',
'         l_where := l_where ||     ''2003, '';',
'         l_where := l_where ||     '':SRID, '';',
'         l_where := l_where ||     ''null, '';',
'         l_where := l_where ||     ''sdo_elem_info_array(1, 1003, 3), '';',
'         l_where := l_where ||     ''sdo_ordinate_array('';',
'         l_where := l_where ||       ''(to_number(:MINX)/1000000000),'';',
'         l_where := l_where ||       ''(to_number(:MINY)/1000000000),'';',
'         l_where := l_where ||       ''(to_number(:MAXX)/1000000000),'';',
'         l_where := l_where ||       ''(to_number(:MAXY)/1000000000)'';',
'         l_where := l_where ||     '')'';',
'         l_where := l_where ||   '')'';',
'         l_where := l_where || '') = ''''TRUE'''' '';',
'         l_bbbox := true;',
'       else ',
'         l_where := l_where || ''where 1 = 1 '';',
'       end if;',
'       if l_minzoom and apex_application.g_x06 = ''Y'' then ',
'         l_where := l_where || '' and minzoom <= to_number(:ZOOMLEVEL) '';',
'         l_bzoom := true;',
'       end if;',
'       if l_maxzoom and apex_application.g_x06 = ''Y'' then ',
'         l_where := l_where || '' and maxzoom >= to_number(:ZOOMLEVEL) '';',
'         l_bzoom := true;',
'       end if;',
'       apex_debug.message(',
'         p_message => ''ORACLE MAPS PLUGIN: new WHERE clause generated: %s'',',
'         p0 => l_where,',
'         p_level   => apex_debug.c_log_level_info',
'       );',
'',
'       l_sql := l_sql || l_where;',
'',
'       apex_plugin_util.free_sql_handler(',
'         p_sql_handler => l_cur',
'       );',
'       l_cur := null;',
'',
'       --',
'       -- SECTION II: Prepare Bind Array and Call APEX_PLUGIN_UTIL.GET_DATA2',
'       --',
'',
'       if l_bsrid then',
'         l_bindlist(l_bidx).name := ''SRID'';',
'         l_bindlist(l_bidx).value := apex_application.g_x01;',
'         l_bidx := l_bidx + 1;',
'       end if;',
'       if l_bbbox then',
'         l_bindlist(l_bidx).name := ''MINX'';',
'         l_bindlist(l_bidx).value := apex_application.g_x02;',
'         l_bindlist(l_bidx+1).name := ''MINY'';',
'         l_bindlist(l_bidx+1).value := apex_application.g_x03;',
'         l_bindlist(l_bidx+2).name := ''MAXX'';',
'         l_bindlist(l_bidx+2).value := apex_application.g_x04;',
'         l_bindlist(l_bidx+3).name := ''MAXY'';',
'         l_bindlist(l_bidx+3).value := apex_application.g_x05;',
'         l_bidx := l_bidx + 4;',
'       end if;',
'       if l_bzoom then',
'         l_bindlist(l_bidx).name := ''ZOOMLEVEL'';',
'         l_bindlist(l_bidx).value := apex_application.g_x07;',
'       end if;',
'',
'       l_column_value_list :=',
'          apex_plugin_util.get_data2 (',
'            p_sql_statement    => l_sql,',
'            p_min_columns      => 3,',
'            p_max_columns      => null,',
'            p_component_name   => p_region.name,',
'            p_bind_list        => l_bindlist,',
'            p_max_rows         => l_maxrows ',
'         );',
'',
'       -- ',
'       -- SECTION III: FETCH RESULTS and build JSON',
'       --',
'',
'       apex_debug.message(',
'         p_message => ''ORACLE MAPS PLUGIN: found %s rows'',',
'         p0 => l_column_value_list(1).value_list.count,',
'         p_level   => apex_debug.c_log_level_info',
'       );',
'',
'       apex_json.open_object;',
'       apex_json.open_array(''row'');',
'       for row in 1 .. l_column_value_list(1).value_list.count loop',
'         apex_json.open_object;',
'         for col in 1 .. l_column_value_list.count loop',
'           if l_column_value_list(col).data_type = ''SDO_GEOMETRY'' then',
'             -- Object Type columns are always returned using ANYDATA and we have to',
'             -- use GETOBJECT to transform them back into the original object type',
'             l_dummy := l_column_value_list(col).value_list(row).anydata_value.getobject( l_geom );',
'             intfunc_printjsonforgeom(l_column_value_list(col).name, l_geom);',
'           else',
'             apex_json.write(',
'               l_column_value_list(col).name,',
'               apex_plugin_util.get_value_as_varchar2(',
'                 p_data_type => l_column_value_list(col).data_type,',
'                 p_value     => l_column_value_list(col).value_list(row)',
'               )',
'             );',
'           end if;',
'         end loop;',
'         apex_json.close_object;',
'         apex_debug.message(',
'           p_message => ''ORACLE MAPS PLUGIN: row fetched.'',',
'           p_level   => apex_debug.c_log_level_info',
'         );',
'       end loop;',
'       apex_json.close_array;',
'       apex_json.close_object;',
'     exception ',
'       when others then ',
'         begin',
'           -- Close the cursor, if open',
'             apex_plugin_util.free_sql_handler(',
'               p_sql_handler => l_cur',
'             );',
'         exception',
'           -- ERROR during close cursor - do nothing.',
'           when others then null;',
'         end;',
'         apex_debug.message(',
'           p_message => ''ORACLE MAPS PLUGIN: error: %s.'',',
'           p0 => sqlerrm,',
'           p_level   => apex_debug.c_log_level_info',
'         );',
'         apex_json.open_object;',
'         apex_json.write(''error'', sqlerrm);',
'         apex_json.close_object;',
'     end;',
'   else ',
'     apex_json.open_object;',
'     apex_json.open_array(''row'');',
'     apex_json.close_array;',
'     apex_json.close_object;',
'   end if;',
' elsif apex_application.g_x10 = ''TRANSFORM'' then',
'   declare',
'     l_trgeom      sdo_geometry;',
'     l_xarray      APEX_APPLICATION_GLOBAL.VC_ARR2;',
'     l_yarray      APEX_APPLICATION_GLOBAL.VC_ARR2;',
'   begin',
'     apex_debug.message(',
'       p_message => ''ORACLE MAPS PLUGIN: GOT TRANSFORM DATA %s %s %s %s'',',
'       p0 => apex_application.g_x01, -- Array of X coordinates',
'       p1 => apex_application.g_x02, -- Array of Y coordinates',
'       p2 => apex_application.g_x03, -- FROM SRID',
'       p3 => apex_application.g_x04, -- TO   SRID',
'       p_level   => apex_debug.c_log_level_info',
'     );',
'     l_xarray := apex_util.string_to_table(apex_application.g_x01, '':'');',
'     l_yarray := apex_util.string_to_table(apex_application.g_x02, '':'');',
' ',
'     apex_json.open_array;',
' ',
'     for i in l_xarray.first..l_xarray.last loop ',
'       l_trgeom := sdo_cs.transform(',
'         sdo_geometry(',
'           2001, ',
'           to_number(apex_application.g_x03), ',
'           sdo_point_type(',
'              to_number(l_xarray(i))/1000000000,',
'              to_number(l_yarray(i))/1000000000,',
'              null',
'           ),',
'           null, ',
'           null',
'         ), ',
'         to_number(apex_application.g_x04)',
'       );',
'       apex_json.open_object;',
'       apex_json.write(''x'', to_char(l_trgeom.sdo_point.x, ''9999999990D9999999999'',''nls_numeric_characters=''''.,''''''));',
'       apex_json.write(''y'', to_char(l_trgeom.sdo_point.y, ''9999999990D9999999999'',''nls_numeric_characters=''''.,''''''));',
'       apex_json.close_object;',
'     end loop;',
'',
'     apex_json.close_array;',
'   end;',
' end if;',
' return null;',
'end;',
'',
'function render_map (',
'    p_region              in apex_plugin.t_region,',
'    p_plugin              in apex_plugin.t_plugin,',
'    p_is_printer_friendly in boolean ',
') return apex_plugin.t_region_render_result',
'is',
'    l_baseurl_host  apex_application_page_regions.attribute_01%type := p_region.attribute_01;',
'    l_mapsize       apex_application_page_regions.attribute_03%type := p_region.attribute_03;',
'    l_basemap       apex_application_page_regions.attribute_04%type := p_region.attribute_04;',
'    l_mapcenter     apex_application_page_regions.attribute_06%type := p_region.attribute_06;',
'    l_zoomlevel     apex_application_page_regions.attribute_07%type := p_region.attribute_07;',
'    l_nav           apex_application_page_regions.attribute_08%type := p_region.attribute_08;',
'    l_navopt        apex_application_page_regions.attribute_09%type := p_region.attribute_09;',
'    l_additional    apex_application_page_regions.attribute_13%type := p_region.attribute_13;',
'    l_copyright     apex_application_page_regions.attribute_20%type := p_region.attribute_20;',
'',
'    l_showsqlfoi    apex_application_page_regions.attribute_17%type := p_region.attribute_17;',
'    l_sqlfoiinfow   apex_application_page_regions.attribute_16%type := p_region.attribute_16;',
'    l_sqlfoiinfoh   apex_application_page_regions.attribute_15%type := p_region.attribute_15;',
'    l_sqlfoilazy    apex_application_page_regions.attribute_19%type := p_region.attribute_19;',
'    l_sqlfoimaxrow  apex_application_page_regions.attribute_14%type := p_region.attribute_14;',
'    l_usecookie     apex_application_page_regions.attribute_18%type := p_region.attribute_18;',
'    l_sizetype      apex_application_page_regions.attribute_21%type := p_region.attribute_21;',
'    l_unitsystem    apex_application_page_regions.attribute_22%type := nvl(p_region.attribute_22, ''METRIC'');',
'    l_unitsystem_it apex_application_page_regions.attribute_23%type := nvl(p_region.attribute_23, ''ORACLEMAPS_UNITSYSTEM'');',
'    l_use_eloc      apex_application_page_regions.attribute_24%type := nvl(p_region.attribute_24, ''YES'');',
'',
'    l_onloadCode    varchar2(32767);',
'',
'    l_mapWidth      number;',
'    l_mapHeight     number;',
'    l_mapCenterX    number;',
'    l_mapCenterY    number;',
'',
'    l_escape_html   varchar2(1);',
'begin',
'    if l_unitsystem = ''ITEM'' then',
'      l_unitsystem := v(l_unitsystem_it);',
'    end if;',
'',
'    if l_mapcenter is null then',
'      l_mapcenter := ''-100,38'';',
'      l_zoomlevel := 1;',
'    end if;',
'  ',
'    begin',
'      l_mapCenterX := to_number(substr(l_mapcenter, 1, instr(l_mapcenter, '','') - 1), ''999999999D999999'',''nls_numeric_characters=''''.,'''''');',
'      l_mapCenterY := to_number(substr(l_mapcenter, instr(l_mapcenter,'','') + 1), ''999999999D999999'',''nls_numeric_characters=''''.,'''''');',
'    exception',
'      when others then',
'        raise_application_error(-20000, ''error in parsing MAP CENTER attribute:''||l_mapcenter);',
'    end;',
'',
'    begin',
'      l_mapWidth := to_number(substr(l_mapsize, 1, instr(l_mapsize, '','') - 1));',
'      l_mapHeight := to_number(substr(l_mapsize, instr(l_mapsize, '','') + 1));',
'    exception',
'      when others then',
'        raise_application_error(-20000, ''error in parsing MAP WIDTH and HEIGHT attribute'');',
'    end;',
'',
'    if p_region.escape_output then ',
'      l_escape_html := ''Y'';',
'    else ',
'      l_escape_html := ''N'';',
'    end if;',
'',
'    if l_basemap is null and l_use_eloc = ''NONE'' then ',
'      raise_application_error(-20000, ''At least one custom or external Map Tile Layer is required.'');',
'    end if;',
'',
'    apex_javascript.add_library (',
'        p_name           => ''oraclemapsv2.js'',',
'        p_directory      => l_baseurl_host || ''/jslib/v19.1/'', ',
'        p_version        => null,',
'        p_skip_extension => true );',
'',
'  ',
'    if l_sizetype = ''PIXEL'' then',
'    sys.htp.p(''<div id="''||p_region.static_id||''_map" style="width:''||l_mapWidth||''px; height:''||l_mapHeight||''px"></div>'');',
'    else ',
'    sys.htp.p(''<div id="''||p_region.static_id||''_map" style="width:''||l_mapWidth||''%; height:''||l_mapHeight||''px"></div>'');',
'    end if;',
'    l_onloadCode := ''createPluginMap('' ||',
'      apex_javascript.add_value(p_region.static_id,              true) ||',
'      apex_javascript.add_value(apex_plugin.get_ajax_identifier, true) ||',
'      apex_javascript.add_value(p_plugin.file_prefix,            true) ||',
'      apex_javascript.add_value(l_baseurl_host,                  true) ||',
'      apex_javascript.add_value(l_basemap,                       true) ||',
'      apex_javascript.add_value(l_mapCenterX,                    true) ||',
'      apex_javascript.add_value(l_mapCenterY,                    true) ||',
'      apex_javascript.add_value(l_zoomlevel,                     true) ||',
'      apex_javascript.add_value(l_nav,                           true) ||',
'      apex_javascript.add_value(l_navopt,                        true) ||',
'      apex_javascript.add_value(l_mapwidth,                      true) ||',
'      apex_javascript.add_value(l_mapHeight,                     true) ||',
'      apex_javascript.add_value(l_additional,                    true) ||',
'      apex_javascript.add_value(nvl(l_sqlfoiinfow, 0),           true) ||',
'      apex_javascript.add_value(nvl(l_sqlfoiinfoh, 0),           true) ||',
'      apex_javascript.add_value(apex_util.host_url(''SCRIPT''),    true) ||',
'      apex_javascript.add_value(l_escape_html,                   true) ||',
'      apex_javascript.add_value(p_region.ajax_items_to_submit,   true) ||',
'      apex_javascript.add_value(l_showsqlfoi,                    true) ||',
'      apex_javascript.add_value(l_usecookie,                     true) ||',
'      apex_javascript.add_value(l_copyright,                     true) ||',
'      apex_javascript.add_value(l_sqlfoilazy,                    true) ||',
'      apex_javascript.add_value(l_sizetype,                      true) ||',
'      apex_javascript.add_value(l_unitsystem,                    true) ||',
'      apex_javascript.add_value(lower(v(''BROWSER_LANGUAGE'')),    true) ||',
'      apex_javascript.add_value(l_use_eloc,                      true) ||',
'      apex_javascript.add_value(substr(to_char((1/2), ''FM0D0''), 2,1), false)||',
'      '');'' || chr(10);',
'',
'    apex_javascript.add_onload_code (l_onloadCode);',
'    return null;',
'end;',
''))
,p_api_version=>1
,p_render_function=>'render_map'
,p_ajax_function=>'render_map_ajax'
,p_standard_attributes=>'SOURCE_SQL:AJAX_ITEMS_TO_SUBMIT:ESCAPE_OUTPUT'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'	This plugin integrates Oracle Maps as a region into an APEX application. This plugins requires an running installation of Oracle&#39;s Fusion Middleware MapViewer in order to run properly. The Map Tile Layers and Features of Interest to be displayed'
||' are being configured as Plugin parameters.</p>',
'<p>',
'	<br />',
'	&nbsp;</p>'))
,p_version_identifier=>'20.2'
,p_about_url=>'http://apex.oracle.com/plugins'
,p_files_version=>190
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(61535303583182962589)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Map Server URL'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'https://elocation.oracle.com/mapviewer'
,p_display_length=>50
,p_max_length=>200
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'	Enter the URL of the Oracle Maps Server to use. It typically ends with </b>/mapviewer.</b></p>',
'<ul>',
'	<li>',
'		<strong>https://elocation.oracle.com/mapviewer</strong></li>',
'	<li>',
'		<strong>http://mapserver.mydomain.com:8888/mapviewer<br />',
'		</strong></li>',
'</ul>',
''))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(61535304964266966564)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Map Size (width, height)'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'100,500'
,p_display_length=>20
,p_max_length=>20
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'	Enter the size of the map on the screen (width, height). Note the next attribute which controls the interpretation.</p>',
''))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(61535305874309969521)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Custom map tile layers'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_display_length=>100
,p_max_length=>500
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(2831387199711035155)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'NONE'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'	Enter map tile layers defined within the Oracle Maps server to be added to the map. Separate multiple map tile layers by colons. If more then one map tile layer is being added the plugin adds buttons to switch between the map tile layers. You might '
||'use a comma to specify a label for those switch buttons.</p>',
'<p>',
'	Examples:</p>',
'<ul>',
'	<li>',
'		<strong>elocation_mercator.world_map</strong></li>',
'	<li>',
'		<strong>elocation</strong><strong>_mercator</strong><strong>.world_map:geows.free_map</strong></li>',
'	<li>',
'		<strong>elocation</strong><strong>_mercator</strong><strong>.world_map,Dataset One:geows.free_map,Dataset Two</strong></li>',
'</ul>',
''))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(61535306851237972304)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Map Center (lon, lat)'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'10,50'
,p_display_length=>20
,p_max_length=>20
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'	Enter the map center (longitude, latitude) here. Example:</p>',
'<p>',
'	<strong>10,50</strong></p>',
'<p>',
'	The longitude and latitude value is excpected as a decimal value. So 50&deg;N, 30&#39; is being expressed as 50,5. Southern latitudes and western longitudes are negative.</p>',
''))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(61535307355739973560)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_prompt=>'Initial Zoom Level'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'8'
,p_display_length=>20
,p_max_length=>20
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'	Enter the initial zoom level of the map here. The available zoom levels depend on the chosen map tile laver. Zero (0) is the level in which most of the map area is visible. </p>',
''))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(61535307866128976574)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_prompt=>'Navigation Bar'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'WEST'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'	Choose the position of the map navigation bar.</p>',
''))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(61535308468206977233)
,p_plugin_attribute_id=>wwv_flow_api.id(61535307866128976574)
,p_display_sequence=>10
,p_display_value=>'None'
,p_return_value=>'NONE'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(61535308870284977776)
,p_plugin_attribute_id=>wwv_flow_api.id(61535307866128976574)
,p_display_sequence=>20
,p_display_value=>'Left'
,p_return_value=>'WEST'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(61535309272362978427)
,p_plugin_attribute_id=>wwv_flow_api.id(61535307866128976574)
,p_display_sequence=>30
,p_display_value=>'Right'
,p_return_value=>'EAST'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(60647235113824258109)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>90
,p_prompt=>'Navigation Bar Options'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_default_value=>'1'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(61535307866128976574)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'NOT_EQUALS'
,p_depending_on_expression=>'NONE'
,p_lov_type=>'STATIC'
,p_help_text=>'Configure the appearance of the navigation bar.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(60647235743141259693)
,p_plugin_attribute_id=>wwv_flow_api.id(60647235113824258109)
,p_display_sequence=>10
,p_display_value=>'Navigation Panel only'
,p_return_value=>'4'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(60647236139906261170)
,p_plugin_attribute_id=>wwv_flow_api.id(60647235113824258109)
,p_display_sequence=>20
,p_display_value=>'Zoom buttons only'
,p_return_value=>'3'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(60647236536240262871)
,p_plugin_attribute_id=>wwv_flow_api.id(60647235113824258109)
,p_display_sequence=>30
,p_display_value=>'Slide bar and zoom buttons'
,p_return_value=>'2'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(60647236932789264463)
,p_plugin_attribute_id=>wwv_flow_api.id(60647235113824258109)
,p_display_sequence=>40
,p_display_value=>'Complete'
,p_return_value=>'1'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(60647164921411566779)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>13
,p_display_sequence=>100
,p_prompt=>'Additional Map Features'
,p_attribute_type=>'CHECKBOXES'
,p_is_required=>false
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Choose additional map features.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(60647165318823567995)
,p_plugin_attribute_id=>wwv_flow_api.id(60647164921411566779)
,p_display_sequence=>10
,p_display_value=>'Overview Map'
,p_return_value=>'OVER'
,p_help_text=>'Show an overview map in the lower right corner of the screen'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(60647165716235569238)
,p_plugin_attribute_id=>wwv_flow_api.id(60647164921411566779)
,p_display_sequence=>20
,p_display_value=>'Rectangle Zoom'
,p_return_value=>'MARQUEE'
,p_help_text=>'Zoom into the map by drawing a rectangle'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(60647166114079570187)
,p_plugin_attribute_id=>wwv_flow_api.id(60647164921411566779)
,p_display_sequence=>30
,p_display_value=>'Distance tool'
,p_return_value=>'DISTANCE'
,p_help_text=>'Add a tool to measure distances to the map'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(60647166542749572158)
,p_plugin_attribute_id=>wwv_flow_api.id(60647164921411566779)
,p_display_sequence=>40
,p_display_value=>'Draw Polygons'
,p_return_value=>'REDLINE'
,p_help_text=>'Activate the "redlining" tool to draw polygons on the map'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2821111027359905962)
,p_plugin_attribute_id=>wwv_flow_api.id(60647164921411566779)
,p_display_sequence=>45
,p_display_value=>'Circle Tool'
,p_return_value=>'CIRCLE'
,p_help_text=>'Tool to draw a circle on the map'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2831368397568489185)
,p_plugin_attribute_id=>wwv_flow_api.id(60647164921411566779)
,p_display_sequence=>50
,p_display_value=>'Scale bar'
,p_return_value=>'SCALE'
,p_help_text=>'Add a scale bar to the map'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(1089708159787354739)
,p_plugin_attribute_id=>wwv_flow_api.id(60647164921411566779)
,p_display_sequence=>60
,p_display_value=>'Cluster SQL Features'
,p_return_value=>'FOICLUSTERS'
,p_help_text=>'Enable this to automatically cluster colocatred SQL features.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(1089708552243356598)
,p_plugin_attribute_id=>wwv_flow_api.id(60647164921411566779)
,p_display_sequence=>70
,p_display_value=>'Mousewheel zoom'
,p_return_value=>'MOUSEWHEEL'
,p_help_text=>'Enable Mousewheel zooming'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(60647168041215603274)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>14
,p_display_sequence=>115
,p_prompt=>'Maximum number of Rows'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_default_value=>'500'
,p_display_length=>10
,p_max_length=>10
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(60647188516966854842)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_help_text=>'Determines the maximum number of objects to fetch by the region source SQL query. Be aware that too many FOI objects slow down the browsers'' javascript engine.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(60647187527102850233)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>15
,p_display_sequence=>200
,p_prompt=>'SQL FOI Info Window Height in Pixel'
,p_attribute_type=>'NUMBER'
,p_is_required=>false
,p_default_value=>'150'
,p_display_length=>5
,p_max_length=>10
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(60647188516966854842)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_help_text=>'Determines the height of the Marker FOI''s information window in pixels.'
);
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(60647188023221852010)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>16
,p_display_sequence=>160
,p_prompt=>'SQL FOI Info Window Width in Pixel'
,p_attribute_type=>'NUMBER'
,p_is_required=>false
,p_default_value=>'250'
,p_display_length=>5
,p_max_length=>150
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(60647188516966854842)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_help_text=>'Determines the width of the Marker FOI''s information window in pixels.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(60647188516966854842)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>17
,p_display_sequence=>114
,p_prompt=>'Show SQL FOI'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'Set to <b>Yes</b> to show the Features of Interest provides by the SQL query in the region source.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(60647240826915859852)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>18
,p_display_sequence=>75
,p_prompt=>'Save map position in Cookie'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'If set to <b>Yes</b>, the Maps Plugin will store the current map center and zoom level in a cookie. The map will then initialize with the last position after an APEX page refresh.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(60647415331957167658)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>19
,p_display_sequence=>140
,p_prompt=>'SQL FOI Lazy Loading'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(60647188516966854842)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_help_text=>'Setting Lazy Loading to <b>No</b> lets the plugin load all FOI data at initialization time. Choosing <b>Yes</b> will only load the FOI data for the current map window. For large amounts of FOI data distributed over large areas, choose <b>Yes</b>. <i>'
||'Note that you need a spatial index on your SDO_GEOMETRY column in the latter case</i>.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(60647416025056170831)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>20
,p_display_sequence=>105
,p_prompt=>'Copyright Notice'
,p_attribute_type=>'TEXTAREA'
,p_is_required=>false
,p_default_value=>'(c) 2020 Oracle Corp., (c) 2020 HERE'
,p_display_length=>50
,p_max_length=>100
,p_is_translatable=>false
,p_help_text=>'Enter the copyright notice to be displayed on the map here.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(60641855156904259312)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>21
,p_display_sequence=>35
,p_prompt=>'Map Width Interpretation'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'PERCENT'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>The Map Window size can be specified either in <b>Pixels</b> or in <b>Percent</b>. If specified in Pixel, then the map size will be static on all devices and for all screens. If <b>Percent</b> is chosen, the <b>Width</b> will be interpreted in per'
||'cent of the region width. The Map height will still be in pixels. </p>',
'<p><b>100,75<b> means that the map will use 100% of the region width, and the height will be 75% of the map width.',
'</p>'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(60641855854748260282)
,p_plugin_attribute_id=>wwv_flow_api.id(60641855156904259312)
,p_display_sequence=>10
,p_display_value=>'Pixel'
,p_return_value=>'PIXEL'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(60641856251513261799)
,p_plugin_attribute_id=>wwv_flow_api.id(60641855156904259312)
,p_display_sequence=>20
,p_display_value=>'Percent'
,p_return_value=>'PERCENT'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(3775049404008907817)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>22
,p_display_sequence=>110
,p_prompt=>'Unit System'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'METRIC'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(60647164921411566779)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'DISTANCE,SCALE'
,p_lov_type=>'STATIC'
,p_help_text=>'Specify whether the results of the "Distance tool" should be given in the metric or imperial system. If <b>Item or Substitution</b> is chosen, enter the name of an item or substitution string which contains either <b>METRIC</b> or <b>IMPERIAL</b>.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(3775050800342909461)
,p_plugin_attribute_id=>wwv_flow_api.id(3775049404008907817)
,p_display_sequence=>10
,p_display_value=>'Metric System (km,m,cm)'
,p_return_value=>'METRIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(3775051196676911172)
,p_plugin_attribute_id=>wwv_flow_api.id(3775049404008907817)
,p_display_sequence=>20
,p_display_value=>'Imperial System (mile,yard,foot)'
,p_return_value=>'IMPERIAL'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(3775056486035007255)
,p_plugin_attribute_id=>wwv_flow_api.id(3775049404008907817)
,p_display_sequence=>30
,p_display_value=>'Derived from Item or Substitution String'
,p_return_value=>'ITEM'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(3775058186886022041)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>23
,p_display_sequence=>112
,p_prompt=>'Item or substitution containing unit system to use'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_default_value=>'ORACLEMAPS_UNITSYSTEM'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(3775049404008907817)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'ITEM'
,p_help_text=>'Enter the name of a page item, application item or substitution string, which contains either <b>METRIC</b> or <b>IMPERIAL</b>.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(2831387199711035155)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>24
,p_display_sequence=>38
,p_prompt=>'External map tile layer'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'OSM'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Choose an external map tile layer as your background map.</p>',
'<p>',
'To use Bing maps as a map tile layer, your usage of the maps must meet the Terms of Service defined by Microsoft(http://www.microsoft.com/maps/product/terms.html). You must create a Bing Maps Developer Account(https://www.bingmapsportal.com/) and cre'
||'ate a Bing Maps key for your application before you can display Bing Maps with this class. Please refer to this link(http://msdn.microsoft.com/en-us/library/ee692181.aspx) for more information about creating Bing Maps Developer Account and aquiring B'
||'ing Maps key. Note that you need a  Bing developer account in order to use Bing Maps. ',
'</p>'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2831388493457038131)
,p_plugin_attribute_id=>wwv_flow_api.id(2831387199711035155)
,p_display_sequence=>10
,p_display_value=>'None (Use Custom)'
,p_return_value=>'NONE'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2831387697339036249)
,p_plugin_attribute_id=>wwv_flow_api.id(2831387199711035155)
,p_display_sequence=>20
,p_display_value=>'Oracle Elocation '
,p_return_value=>'ELOCATION'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2831388096045036855)
,p_plugin_attribute_id=>wwv_flow_api.id(2831387199711035155)
,p_display_sequence=>30
,p_display_value=>'OpenStreetMap "Positron"'
,p_return_value=>'OSM'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(184037630964714633)
,p_plugin_attribute_id=>wwv_flow_api.id(2831387199711035155)
,p_display_sequence=>40
,p_display_value=>'OpenStreetMap "Bright"'
,p_return_value=>'OSM_BRIGHT'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(184040032825717080)
,p_plugin_attribute_id=>wwv_flow_api.id(2831387199711035155)
,p_display_sequence=>50
,p_display_value=>'OpenStreetMap "Dark Matter"'
,p_return_value=>'OSM_DARK'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2831389883105042929)
,p_plugin_attribute_id=>wwv_flow_api.id(2831387199711035155)
,p_display_sequence=>220
,p_display_value=>'Bing Auto (Deprecated)'
,p_return_value=>'BING_AUTO'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2831389485262041893)
,p_plugin_attribute_id=>wwv_flow_api.id(2831387199711035155)
,p_display_sequence=>230
,p_display_value=>'Bing Aerial (Deprecated)'
,p_return_value=>'BING_AERIAL'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(2831389089575039845)
,p_plugin_attribute_id=>wwv_flow_api.id(2831387199711035155)
,p_display_sequence=>240
,p_display_value=>'Bing Road (Deprecated)'
,p_return_value=>'BING'
);
wwv_flow_api.create_plugin_std_attribute(
 p_id=>wwv_flow_api.id(1078523053054587023)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_name=>'SOURCE_SQL'
,p_is_required=>false
,p_sql_min_column_count=>3
,p_depending_on_has_to_exist=>true
,p_examples=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>The <i>Feature Of Interest</i> (FOI) display style and information text depends on your SQL query. Make sure that it returns the following columns.</p>',
'<ul>',
'<li><b>ID</b> (Mandatory): Must uniquely identify a row - use the primary key for this. </li>',
'<li><b>GEOMETRY</b> (Mandatory): Must be a column of type SDO_GEOMETRY. Currently only point geometries are supported.</li>',
'<li><b>STYLE</b> (Mandatory): Determines the marker style: <b>blue|red|green|purple|yellow|gray</b>: Displays the marker as a pin in the given color. <b>IMAGE</b> allows to use custom images as markers. The image will be loaded from the URL given in '
||'the <b>IMAGEURL</b> column.</li>',
'<li><b>MARKERSIZE</b> (Optional): Provide a value in the form <b>R|C{size})</b> (e.g. R10 or C5). Values starting with a <b>C</b> are rendered as a circle with the specifed radius. Values starting with <b>R</b> are rendered as a rectangle with the sp'
||'ecified size. The no MARKERSIZE is given, a pin image will be used as the marker.</li>',
'<li><b>IMAGEURL</b> (Optional): Provide a URL to the image you want to use as marker here. You can use APEX Application images with #APP_IMAGES#. Note that images need a transparent background for optimal display.</li>',
'<li><b>LAYER</b> (Optional): Assign this row to a layer number from 0 to 9. Layer 9 is the top layer. Use this to determine which FOI are to be layered on top of others. If not given, the row will be assigned to layer 1. Use <b>HEAT</b> as Layer to g'
||'enerate a heat map from the data. A Heat Map is always Layer 0.</li>',
'<li><b>INFOTIP</b> (Optional): This column content will be displayed when hovering the marker with the mouse.</li>',
'<li><b>INFOTEXT</b> (Optional): If given, the marker will get a clickable information window with the content of this column.</li>',
'<li><b>MINZOOM</b> (Optional): Display the FOI only, if the map is zoomed at least to this level. Only supported, when "Lazy Load" is set to <b>Yes</b>.</li>',
'<li><b>MAXZOOM</b> (Optional): Display the FOI only unitl the map is zoomed to this level. Only supported, when "Lazy Load" is set to <b>Yes</b>.</li>',
'</ul>',
'<p>',
'SQL Query for simple marker display.',
'</p>',
'<pre>',
'select ',
'  id, ',
'  name as infotip,',
'  ''Customer: ''||name||''&lt;br/&gt;Revenue: ''||revenue as infotext, ',
'  geometry, ',
'  case ',
'    when revenue < 5000 then ''blue'' ',
'    when revenue between 5000 and 10000 then ''red'' ',
'    else ''purple'' ',
'  end as style ',
'from customers',
'where revenue is not null',
'</pre>'))
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(2821113064819916935)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_name=>'com_oracle_oramapshtml5_circleclear'
,p_display_name=>'map_circletool_clear'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(2821112388562916931)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_name=>'com_oracle_oramapshtml5_circlefinish'
,p_display_name=>'map_circletool_finish'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(2821112712993916935)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_name=>'com_oracle_oramapshtml5_circlestart'
,p_display_name=>'map_circletool_start'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(2831413985188986884)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_name=>'com_oracle_oramapshtml5_distanceclear'
,p_display_name=>'map_distance_clear'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(2831414680788986889)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_name=>'com_oracle_oramapshtml5_distancefinish'
,p_display_name=>'map_distance_finish'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(2831414302814986888)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_name=>'com_oracle_oramapshtml5_distancestart'
,p_display_name=>'map_distance_start'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(1089704665191345750)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_name=>'com_oracle_oramapshtml5_foiclick'
,p_display_name=>'map_foi_click'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(60656428744624008086)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_name=>'com_oracle_oramapshtml5_mapchanged'
,p_display_name=>'map_changed'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(60647226628822672795)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_name=>'com_oracle_oramapshtml5_mapinitialized'
,p_display_name=>'map_initialized'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(60656423458195841813)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_name=>'com_oracle_oramapshtml5_maprecenter'
,p_display_name=>'map_center_changed'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(60656428161891984735)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_name=>'com_oracle_oramapshtml5_mapzoomchanged'
,p_display_name=>'map_zoomlevel_changed'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(60641285332816599008)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_name=>'com_oracle_oramapshtml5_mousedblclick'
,p_display_name=>'map_mouse_dbl_click'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(60647227020800688824)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_name=>'com_oracle_oramapshtml5_mouseleftclick'
,p_display_name=>'map_mouse_left_click'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(2821438954631128946)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_name=>'com_oracle_oramapshtml5_mouserightclick'
,p_display_name=>'map_mouse_right_click'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(3796781182589963716)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_name=>'com_oracle_oramapshtml5_redlineclear'
,p_display_name=>'map_redlinetool_clear'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(60656432840868511289)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_name=>'com_oracle_oramapshtml5_redlinefinish'
,p_display_name=>'map_redline_finish'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(3796781882848963720)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_name=>'com_oracle_oramapshtml5_redlinepoint'
,p_display_name=>'map_redlinetool_pointadded'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(3796781507421963720)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_name=>'com_oracle_oramapshtml5_redlinestart'
,p_display_name=>'map_redlinetool_start'
);
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '89504E470D0A1A0A0000000D4948445200000018000000420802000000C200813E0000000674524E5300FF00FF00FF37581B7D000000097048597300000EC400000EC401952B0E1B000002C849444154789CED96CF4FDA6018C79FBE2DED455A3948A8A3';
wwv_flow_api.g_varchar2_table(2) := 'B4C8868CC3E2B01922A91246AC211C3CECE09FB8C30E1E763086C584444D16DD6E0EF9915182E249E82E1EAA74873743EC2F60BBECD0EFE97DBE7D9E4FDBE77DFAA684699AF05CA6696A5AB7DDFED9EFDF0E87BA6118001008041617399E8F241271518C';
wwv_flow_api.g_varchar2_table(3) := '110461A9222CA0ABABE6C9C999AEFF0277711C9BCFE756575F39830CC3383AFAD268B43C10934A265FEEECBC0F0402CF4086611C1C7CEEF5AE67A46045A32FF6F62A9885B055AD1ECF4B01805EEFBA5A3DC66B0400AD56BB5E6FCC4BC1AAD71BAD561B00';
wwv_flow_api.g_varchar2_table(4) := '90699AB5DAE9DF51B06AB553D33491A675755DFF1790AEEB9AD6A59ACDB6FD9A2C67DEE57200F0F5ECECFCFC9BA333A966B34D964AEAFDFDBD85A2289B1422284488A2F0F0F0B0BCCC5B9C9B9BFE64C9E3E3231A0C8616BC24C52CA1DDB1940C0643341A';
wwv_flow_api.g_varchar2_table(5) := '8DA63561BA46A3112249D2E2763A5D4B68772C252449521CC7DEDD0D265D4B2FEDADB53B1CC7128787D5CBCB1F6ECFECBD5963A5D3AF9124091E1445D9642882A10845D994E58C5BA62409281E97EC6DFA7379CA66619124198F4B88A6E9542AE976AB59';
wwv_flow_api.g_varchar2_table(6) := '944A25699A4600B0B6F6C63163EA6661E1720A00C2E125518C699A350F7717BF51A7D3756CB628C6C2E125181F6CFDFEEDC78F9FE67B250000D8DFFFC0F311181F6C3C1F492456E6A524122B98F204020045C921845C4A1C84105294DC53385E8542218F';
wwv_flow_api.g_varchar2_table(7) := '49B14B9633A150C8010400D9ACCC71EC2C148E63B359F9D9034E061445158BDBB3808AC56D8AA25C41002049623A9DF2A6A4D32949122DA643770B85AD6070C18D120C2E140A5B76DF01C430B4AA96DC40AA5A62187A2610000842D471076539230851C7';
wwv_flow_api.g_varchar2_table(8) := '12D7C1C9E737C6C386C5F3917C7EC32DDF1584102A9755866170C8304CB9AC7A4CACD728B36CB052D9C5EB4A659765831EC9D6FF23BB2E2EBE03C0FAFA5BEFB4E9A01935C757EA837C900FF2413EC807F9201FF43F837E03F965F27D0D9FFC0000000000';
wwv_flow_api.g_varchar2_table(9) := '49454E44AE426082';
null;
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(1987483331917202608)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_file_name=>'m-cluster.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '89504E470D0A1A0A0000000D49484452000000100000002E0802000000AEE10EEB0000000674524E5300FF00FF00FF37581B7D000000097048597300000EC400000EC401952B0E1B000001CE49444154789CED94CF2B445114C7BFE7BC57681AA34CF1C4';
wwv_flow_api.g_varchar2_table(2) := '2CB0404313C68A94C5647A4949616547D8DA584869CA7A3634F66A8A9D58888558215929B3507E2CA649D1C8CFCCBD166F669EF7BC66E60F98EFEA9E7B3FDF73CEBDDD7B494A0900801072EF5AEE5CC9F37BF9F406005E17823E1A0F90DE41CC64606418';
wwv_flow_api.g_varchar2_table(3) := '1E5FE44C3C73F10047F53661735269ACA1AC219996A18D4C32ED4C1BAAAFC6C19C525F4D0C60615B14A60124D358D81600F828214E6EA56D9909B99E4D9DDCCAA38450E39716BA52C5DA088F0708C0CE955CDA159F3FE66AFC522A5FBDCB6FDFE65444E7';
wwv_flow_api.g_varchar2_table(4) := 'E93E569954A6AE06F254E13061667CFE00A75E2D7547FC54204CBD8255B618FE56FB1FAA0C6EF15AA6A2C7A240D8E2853AD04C3729B3CBAD0BF9FC9E99EC26638BFBD796231968263ABB137A2C83D2B437AB70D0477EAD24DAAF21E82306B038C445E93C';
wwv_flow_api.g_varchar2_table(5) := 'C600C2EDC58BF83584DB296B20A295E1224556869928670030D8CAA39DFF6E4F4EA39D34D89A25CDC4AB61765738D0EE0AAC864DCC1C691E8AE80E8D4574D63CE4600030D5C3A1364B63A1369AEAB130F694D131AE7367C7756E44C7EC803DAE75516C42';
wwv_flow_api.g_varchar2_table(6) := '311E506C42A975D94F82F2BFC65FAD9F0A00F3FD0E5B723614504997A26C281BCA86B221AF5FF4A78C769A55B7040000000049454E44AE426082';
null;
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(1987483719628202612)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_file_name=>'m-darkblue.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '89504E470D0A1A0A0000000D49484452000000100000002E0802000000AEE10EEB0000000674524E5300FF00FF00FF37581B7D000000097048597300000EC400000EC401952B0E1B000001D649444154789CED9431EBAA6018C51FDFF7D21041A092839B';
wwv_flow_api.g_varchar2_table(2) := '34648BB80846080D2E39B644AB824B43D252DFA0C1A0CF11F401A2A1AD8684D0415AFB8F81482EB5587730FC4B75BD7D80CEF43EE79C1FCF2B8AC4FD7E070000B8DD6E9BCD66BD5EFBBE7F3E9F01A05C2ED7EBF556ABD568341042498D4880D3E934994C';
wwv_flow_api.g_varchar2_table(3) := '0E8703BC53AD561B8D46954AE501044130180C822078DB4E4451D46C36A3280A01806DDBF96D000882C0B66D00408EE3B8AEFB142384D24BA7725DD7711CCC71DCF1784CDD42A1D0EFF7C7E371B7DB651866BFDFC7719CA6711C638661AED76B6A99A6D9';
wwv_flow_api.g_varchar2_table(4) := '6EB731C618E36AB55A2A9576BB5D9A465184C230CCEE6D369B3963188608639CB52E974BCE8831462CCB66ADF97C9E33B22CFB4710849F9F9FD45A2E975114A9AA0A00ABD56ABBDD6601411008DFF787C3217CA6E9748A789EE738EE9336C7713CCF2300';
wwv_flow_api.g_varchar2_table(5) := 'E8F57A9F00490D01802CCBFF5DC2719C2CCB0F8020085DD7F3015DD70982780000208AA2A228FF6A2B8A228A6272FEFDC20CC328168BAFED62B16818463AFE02344D9BA6F90A98A649D3F41B00005455952429EB489294BCC4F700005896459264722649';
wwv_flow_api.g_varchar2_table(6) := 'D2B2ACE78DF717799EA7699AA6699EE7BDA644FAD7C86AB1580040A7D3798DDE03397A7E862FF005BEC017C8D75F4708C65F99BB6D280000000049454E44AE426082';
null;
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(1987484161669202614)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_file_name=>'m-darkgray.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '89504E470D0A1A0A0000000D49484452000000100000002E0802000000AEE10EEB0000000674524E5300FF00FF00FF37581B7D000000097048597300000EC400000EC401952B0E1B000001DC49444154789CED94BF4B5B5114C7BFE7BC50C106218F6AC8';
wwv_flow_api.g_varchar2_table(2) := 'D2C4254921E40D62088224229245D141118A4D4327DD0A5A8B3F7008A51DBA74C8580A45E85809BA1A02715107A3E860A15BA11042487FE02FECBD1D12F3F292E74BFE807CB773CEF773BEF70EF792941200002904760FC44E0EC7E728FD0600B5079A8F';
wwv_flow_api.g_varchar2_table(3) := 'C787311A22E68A8D2A80FC5914AF3EE0E41B4C15F4F2FB97E47A540564A1249EAEA250327757D4A7F297B7D4A73200B1966AE106502889B51400967B79EC9F368E997177685DFBA7722F6F93E9ACA1DBF580565ED0F83000B99393EF3EE1FAA63694E9AC';
wwv_flow_api.g_varchar2_table(4) := 'B2D1F5181757B516BD4EF0CC18290A290A3DE947CF43E48EF475BFFE308AE5FA001A0B5B9428961936C5D0BABCB22A6D0AC3EDAAEFC88F5B1625DC2E1B8502F2FB0FDDF135F3AFFC9727A300443A8BCC81E184A10089FCB978B68EF6C49B6F98342FFC9E';
wwv_flow_api.g_varchar2_table(5) := 'B6EC7E0F695E06C0F3D36DAD9F9F06C0003032085FAB109F0723835580887871AEC5FAC53922BA4B00281CA4D8D07D6E8A0D51385825F5EE521CF66E13BBBD9B96E27A940E38555A4E98AC5F4E9053350100F054149101833D32C0535183A7611F2717D0';
wwv_flow_api.g_varchar2_table(6) := 'EBA816BD0E4E2E3426CA2689C3B35B6DF6569B158767CD53AAFD1AF5129FB701F0F309932B9902166A7AB81DA00374800E60A9FF9E92AFB9592F9B610000000049454E44AE426082';
null;
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(1987484534980202615)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_file_name=>'m-darkred.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '89504E470D0A1A0A0000000D49484452000000100000002E0802000000AEE10EEB0000000674524E5300FF00FF00FF37581B7D000000097048597300000EC400000EC401952B0E1B000001A549444154789CED93DD6EA33010858F0D7612CA3F2E9522B4';
wwv_flow_api.g_varchar2_table(2) := '341B21ED4DDFFF417AB352A36DB455AB46D0841256DDC634EC852BD6A288F60172AE66C6E7F38C6D206DDB0200D0B6ED765B16C576BFAF9BA601609AA6E3D8428461E81342948D28E0F5F57073F3ABAEFF6048B67D9665DF2713FE0E1C0E87EBEB9F52CA';
wwv_flow_api.g_varchar2_table(3) := '41B71263ECEAEA07E79C0258ADD6E36E0052CAD56A0D8096E57355EDC7DD4A55B52FCB6733CF9FF42A2164B1F8264408A028B6B7B7BFBB5B0190E74F6655D53A90A6491C0B15C7B1381E8FEBF59DD6A4A6BDE9A3281849A594B4BB60A5B7B7E3484A08A1';
wwv_flow_api.g_varchar2_table(4) := 'D3E9442FDDDF3F8EA4D3E9C4745DE7E5E5AF76ACA2699AF3F3481D71B72B75C0751D538870B3C9F5EA6E57F67C9D8408A9E3D896351B5CEEC9B2668E6353004932FF0AA06C144010789F36B1AC591078EF0021244D9371204D13F50054E59EE7F6DE4857';
wwv_flow_api.g_varchar2_table(5) := '14059EE7AA98EA7B1886F1D16D1886DEFF3FC0391F1C2C4D13CEF90000208E85EF7B7AC5F7BDEE5B1C00002C97978C311533C696CBCB9EA10F306666D942C559B660CCEC1988FE7F747A78D80098CF2F3E2E0D0323EA8F74024EC0093801E3FA077BDF95';
wwv_flow_api.g_varchar2_table(6) := '5FCEF76AAF0000000049454E44AE426082';
null;
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(1987485578140202618)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_file_name=>'m-lightgray.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '89504E470D0A1A0A0000000D49484452000000100000002E0802000000AEE10EEB0000000674524E5300FF00FF00FF37581B7D000000097048597300000EC400000EC401952B0E1B000001CD49444154789CED94BF6B535118869FF7DCD092365A486B12';
wwv_flow_api.g_varchar2_table(2) := 'A485548BA6E8D04A87728943B011E9A0103A7476EDE49442108742B7E2ECE22C585A74D42CD6A15BE866145108546D0B5690C48A98E370D3FCEA35C91F9077BAEF77DEE7FBCEE1DE7365AD05006BAB7C7A6D3FBCE45B815FDF018261623774E52E97D292';
wwv_flow_api.g_varchar2_table(3) := 'F162F200FBF38B7DF580833D7C159DD1EDC73A77B106D8F281DD5CA27CE89FF6341CD1D2A686A306B0F96C9734503EB4F92C606C6987FDDDF665194E37DDD0FEAE2DED046C71BBA5EA0CEAE643AEDE0378FFC2BE5DE3EFEFFAA22D6E3B8F6E39FCA9345A';
wwv_flow_api.g_varchar2_table(4) := '2773BABE2CE3C838BA708DC1F394DE34DA9DFC30548E5A265CBED3C9568E0C26D0526A9AE6634DC030126FAED8C2930E96917880F1798E3F364AEF9E574F8E95C800B6B8C5E77C0B303EAFEAD782DD5AA63729F3CC2836CBD8744FF1B169C5660DA0B995';
wwv_flow_api.g_varchar2_table(5) := '9EDACFAD0006607281D14497F86882C9851A20496EB64B7B372BE9740268C2656AF1BFF1A9454DB8DE63E30B93BBCA40C8273D1092BB5A774D4028AA64CE6733C99C42511F005022433CD5128FA7BC97E80F004AAD3314A999A18852EB6D81334030ACF4';
wwv_flow_api.g_varchar2_table(6) := '86778194DE5030DC1EA8FF359A65F79E029AB9EF73245FA083CE5CDC3ED007FA401FE8A87FFA2D8109E25A77F30000000049454E44AE426082';
null;
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(1987486017531202620)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_file_name=>'m-orange.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '89504E470D0A1A0A0000000D49484452000000100000002E0802000000AEE10EEB0000000674524E5300FF00FF00FF37581B7D000000097048597300000EC400000EC401952B0E1B000001FE49444154789CED94BD6FD35014C5CF7BB61B5C276E6D8A8C';
wwv_flow_api.g_varchar2_table(2) := 'CB6077A819FA31B40DA452A019608305C67E24746991AAA833022104624648ED08FF02086648211319F0D00EA10B48A562681B37493F44D298C191EB3AC6CD1F9033BD7BEEF9E95E3DE93D62DB3600008D865DF856C9E7F77F148FCAE51300A2C81857F9';
wwv_flow_api.g_varchar2_table(3) := '64B2277E2D46297162C40176766AAF5FFDDEDC3C42900607F9ECF295BE3EAE09ECEDD51E3FFA592AD503D38E24897DF15297658E02585DD90E4F032895EAAB2BDB00A8695637D60F7D6D4240889FD9583F34CD2ABB96B3BC2EC79107F39793374400F9AF';
wwv_flow_api.g_varchar2_table(4) := 'E5B76FFED46AB6DB5DCB598CAE3D3C3E6EB8563AA3DCBA2D310C61183230704110A8F9FDC0ED56AB0D6A5967B6BF9E10434ACBAA538639B3A8775A6BC930A0AADAE5B5DEBFDB0D2955B58B1D1A16B6B6FEBAD6E74F56B5727233D503E04B6EBF50A87881';
wwv_flow_api.g_varchar2_table(5) := 'A16181148B074F9FFC427B7AF65CA386D1ADEB9176D2BA1E318C6E0AE0DEFD4BED004E8C0298884735ED9C219A169988479B0021647A460907A667144248130030322A242663FF4B27266323A38273A6AE3B3BA7F03C6D4DF33C9D9D3B9D7F9A90652E9D';
wwv_flow_api.g_varchar2_table(6) := '09582C9D5164990B00004CA57AC7C6A35E676C3C3A95EAF53AFE1D16165549629DB324B10B8BAA2FE00744915DCAF63B0F6829DB2F8AAC2F40DC5FC3AB8F1F7601DCB97BB1B5150C8428E01E3B4007E8001D2044FF0011FE97AA0ED6F937000000004945';
wwv_flow_api.g_varchar2_table(7) := '4E44AE426082';
null;
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(1987486630241202623)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_file_name=>'m-violet.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2A0D0A202A204A61766153637269707420636F646520666F72204150455820352E78204F7261636C65204D41505320706C7567696E0D0A202A0D0A202A205075626C6963204A6176615363726970742066756E6374696F6E730D0A202A202D2D2D2D2D';
wwv_flow_api.g_varchar2_table(2) := '2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D0D0A202A2066756E6374696F6E206765744F72616D6170732870526567696F6E496429200D0A202A2066756E6374696F6E206765744F72616D';
wwv_flow_api.g_varchar2_table(3) := '6170735F6D6170766965772870526567696F6E496429200D0A202A2066756E6374696F6E206765744F72616D6170735F6D6170666F6F747072696E742870526567696F6E49642C20705479706529200D0A202A2066756E6374696F6E206765744F72616D';
wwv_flow_api.g_varchar2_table(4) := '6170735F7265646C696E6567656F6D2870526567696F6E49642C20705479706529200D0A202A2066756E6374696F6E206765744F72616D6170735F636C6561725265644C696E652870526567696F6E496429200D0A202A2066756E6374696F6E20676574';
wwv_flow_api.g_varchar2_table(5) := '4F72616D6170735F73657443656E7465722870526567696F6E49642C2070582C2070592C20705372696429200D0A202A2066756E6374696F6E206765744F72616D6170735F7365745A6F6F6D4C6576656C2870526567696F6E49642C20705A6F6F6D2920';
wwv_flow_api.g_varchar2_table(6) := '0D0A202A2066756E6374696F6E206765744F72616D6170735F736574437573746F6D4D61726B65722870526567696F6E49642C2070582C2070592C2070537269642C20705374796C652C2070546578742029200D0A202A2066756E6374696F6E20676574';
wwv_flow_api.g_varchar2_table(7) := '4F72616D6170735F72656D6F7665437573746F6D4D61726B65722870526567696F6E496429200D0A202A0D0A202A2056455253494F4E20352E302E310D0A202A0D0A202A2F0D0A0D0A7661722067506C7567696E4F626A65637473203D205B5D3B0D0A76';
wwv_flow_api.g_varchar2_table(8) := '6172206765744F72616D6170735F67446563696D616C436861723B0D0A0D0A766172204F52414D4150535F434F4E53545F49434F4E5041544820202020202020203D20272F6A736C69622F7631392E312F696D616765732F746269636F6E732F273B0D0A';
wwv_flow_api.g_varchar2_table(9) := '766172204F52414D4150535F434F4E53545F544F4F4C5354594C45202020202020203D2027666F6E742D66616D696C793A205461686F6D612C2053616E732D53657269663B20666F6E742D7765696768743A20626F6C643B20666F6E742D73697A653A20';
wwv_flow_api.g_varchar2_table(10) := '313270743B206C696E652D6865696768743A20313670743B20636F6C6F723A20626C61636B3B20626F726465722D7261646975733A203370783B2070616464696E673A203270783B273B0D0A766172204F52414D4150535F434F4E53545F54494C454255';
wwv_flow_api.g_varchar2_table(11) := '54544F4E5354594C45203D207B0D0A20202020226373737374796C65223A20276261636B67726F756E642D636F6C6F723A20236565656566663B206F7061636974793A20302E38353B20746578742D616C69676E3A2063656E7465723B20626F72646572';
wwv_flow_api.g_varchar2_table(12) := '3A2031707820736F6C696420626C61636B3B20626F726465722D7261646975733A203270783B20666F6E742D73697A653A203870743B2070616464696E672D6C6566743A203270783B2070616464696E672D72696768743A203270783B20666F6E742D77';
wwv_flow_api.g_varchar2_table(13) := '65696768743A20626F6C643B20666F6E742D66616D696C793A205461686F6D612C2053616E732D53657269663B2077686974652D73706163653A206E6F777261703B2077696474683A2031323070783B206F766572666C6F773A2068696464656E3B270D';
wwv_flow_api.g_varchar2_table(14) := '0A7D3B0D0A766172204F52414D4150535F434F4E53545F484541545354594C45202020202020203D207B0D0A20202020636F6C6F7253746F7073202020202020203A205B202223303030306666222C202223303032626666222C20222330303536666622';
wwv_flow_api.g_varchar2_table(15) := '2C202223303037666666222C202223303061626666222C202223303064356666222C202223303066666666222C202223303066663766222C202223303066663030222C202223376666663030222C202223666666663030222C202223666664353030222C';
wwv_flow_api.g_varchar2_table(16) := '202223666661623030222C202223666637663030222C202223666635363030222C202223666632623030222C20222366663030303022205D0D0A202020202C2073706F746C696768745261646975733A2037350D0A202020202C206C656E677468556E69';
wwv_flow_api.g_varchar2_table(17) := '7420202020203A2022706978656C220D0A202020202C206F70616369747920202020202020203A20302E350D0A7D3B0D0A0D0A766172204F52414D4150535F434F4E53545F425453495A45203D2032343B0D0A0D0A66756E6374696F6E20637265617465';
wwv_flow_api.g_varchar2_table(18) := '506C7567696E4D6170282070526567696F6E49642C0D0A202020202020202020202020202020202020202020202020202070506C7567696E4E616D652C0D0A20202020202020202020202020202020202020202020202020207046696C65507265666978';
wwv_flow_api.g_varchar2_table(19) := '2C0D0A2020202020202020202020202020202020202020202020202020704D6170536572766572486F73742C0D0A2020202020202020202020202020202020202020202020202020704D617054696C654C61796572732C0D0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(20) := '202020202020202020202020202020704D617043656E7465724C6F6E2C0D0A2020202020202020202020202020202020202020202020202020704D617043656E7465724C61742C0D0A202020202020202020202020202020202020202020202020202070';
wwv_flow_api.g_varchar2_table(21) := '496E69745A6F6F6D2C0D0A2020202020202020202020202020202020202020202020202020704E617650616E656C2C0D0A2020202020202020202020202020202020202020202020202020704E617650616E656C4F7074732C0D0A202020202020202020';
wwv_flow_api.g_varchar2_table(22) := '2020202020202020202020202020202020704D617057696474682C0D0A2020202020202020202020202020202020202020202020202020704D61704865696768742C0D0A2020202020202020202020202020202020202020202020202020704164646974';
wwv_flow_api.g_varchar2_table(23) := '696F6E616C2C0D0A20202020202020202020202020202020202020202020202020207053716C466F69496E666F572C0D0A20202020202020202020202020202020202020202020202020207053716C466F69496E666F482C0D0A20202020202020202020';
wwv_flow_api.g_varchar2_table(24) := '20202020202020202020202020202020704170657855524C2C0D0A20202020202020202020202020202020202020202020202020207045736361706548544D4C2C0D0A202020202020202020202020202020202020202020202020202070506167654974';
wwv_flow_api.g_varchar2_table(25) := '656D735375626D69742C0D0A20202020202020202020202020202020202020202020202020207053686F7753716C466F692C0D0A202020202020202020202020202020202020202020202020202070557365436F6F6B69652C0D0A202020202020202020';
wwv_flow_api.g_varchar2_table(26) := '202020202020202020202020202020202070436F707972696768742C0D0A20202020202020202020202020202020202020202020202020207053716C466F694C617A792C0D0A20202020202020202020202020202020202020202020202020207053697A';
wwv_flow_api.g_varchar2_table(27) := '65547970652C0D0A202020202020202020202020202020202020202020202020202070556E697453797374656D2C0D0A2020202020202020202020202020202020202020202020202020704C616E67756167652C0D0A2020202020202020202020202020';
wwv_flow_api.g_varchar2_table(28) := '20202020202020202020202070557365456C6F632C0D0A202020202020202020202020202020202020202020202020202070446563696D616C436861722029207B0D0A202020206966202820617065782E6A51756572792E6D6F62696C652029207B0D0A';
wwv_flow_api.g_varchar2_table(29) := '2020202020202020617065782E6A5175657279282027235027202B20247628202270466C6F7753746570496422202920292E6C6976652820277061676573686F77272C2066756E6374696F6E2028206576656E742029207B0D0A20202020202020202020';
wwv_flow_api.g_varchar2_table(30) := '2020617065782E6A51756572792E6765745363726970742820704D6170536572766572486F7374202B20272F6A736C69622F7631392E312F6F7261636C656D61707376322E6A73272C2066756E6374696F6E202829207B0D0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(31) := '202020202067506C7567696E4F626A656374735B2070526567696F6E4964205D203D206E657720417065784F7261636C654D617073506C7567696E280D0A202020202020202020202020202020202020202070526567696F6E49642C0D0A202020202020';
wwv_flow_api.g_varchar2_table(32) := '202020202020202020202020202070506C7567696E4E616D652C0D0A20202020202020202020202020202020202020207046696C655072656669782C0D0A2020202020202020202020202020202020202020704D6170536572766572486F73742C0D0A20';
wwv_flow_api.g_varchar2_table(33) := '20202020202020202020202020202020202020704D617054696C654C61796572732C0D0A2020202020202020202020202020202020202020704D617043656E7465724C6F6E2C0D0A2020202020202020202020202020202020202020704D617043656E74';
wwv_flow_api.g_varchar2_table(34) := '65724C61742C0D0A202020202020202020202020202020202020202070496E69745A6F6F6D2C0D0A2020202020202020202020202020202020202020704E617650616E656C2C0D0A2020202020202020202020202020202020202020704E617650616E65';
wwv_flow_api.g_varchar2_table(35) := '6C4F7074732C0D0A2020202020202020202020202020202020202020704D617057696474682C0D0A2020202020202020202020202020202020202020704D61704865696768742C0D0A202020202020202020202020202020202020202070416464697469';
wwv_flow_api.g_varchar2_table(36) := '6F6E616C2C0D0A20202020202020202020202020202020202020207053716C466F69496E666F572C0D0A20202020202020202020202020202020202020207053716C466F69496E666F482C0D0A2020202020202020202020202020202020202020704170';
wwv_flow_api.g_varchar2_table(37) := '657855524C2C0D0A20202020202020202020202020202020202020207045736361706548544D4C2C0D0A202020202020202020202020202020202020202070506167654974656D735375626D69742C0D0A20202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(38) := '207053686F7753716C466F692C0D0A202020202020202020202020202020202020202070557365436F6F6B69652C0D0A202020202020202020202020202020202020202070436F707972696768742C0D0A20202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(39) := '207053716C466F694C617A792C0D0A20202020202020202020202020202020202020207053697A65547970652C0D0A202020202020202020202020202020202020202070556E697453797374656D2C0D0A20202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(40) := '20704C616E67756167652C0D0A202020202020202020202020202020202020202070557365456C6F632C0D0A202020202020202020202020202020202020202070446563696D616C436861720D0A20202020202020202020202020202020293B0D0A2020';
wwv_flow_api.g_varchar2_table(41) := '20202020202020202020202020206765744D6170506C7567696E282070526567696F6E496420292E6D6170766965772E696E697428293B0D0A2020202020202020202020207D20293B0D0A20202020202020207D20293B0D0A202020207D20656C736520';
wwv_flow_api.g_varchar2_table(42) := '7B0D0A202020202020202067506C7567696E4F626A656374735B2070526567696F6E4964205D203D206E657720417065784F7261636C654D617073506C7567696E280D0A20202020202020202020202070526567696F6E49642C0D0A2020202020202020';
wwv_flow_api.g_varchar2_table(43) := '2020202070506C7567696E4E616D652C0D0A2020202020202020202020207046696C655072656669782C0D0A202020202020202020202020704D6170536572766572486F73742C0D0A202020202020202020202020704D617054696C654C61796572732C';
wwv_flow_api.g_varchar2_table(44) := '0D0A202020202020202020202020704D617043656E7465724C6F6E2C0D0A202020202020202020202020704D617043656E7465724C61742C0D0A20202020202020202020202070496E69745A6F6F6D2C0D0A202020202020202020202020704E61765061';
wwv_flow_api.g_varchar2_table(45) := '6E656C2C0D0A202020202020202020202020704E617650616E656C4F7074732C0D0A202020202020202020202020704D617057696474682C0D0A202020202020202020202020704D61704865696768742C0D0A2020202020202020202020207041646469';
wwv_flow_api.g_varchar2_table(46) := '74696F6E616C2C0D0A2020202020202020202020207053716C466F69496E666F572C0D0A2020202020202020202020207053716C466F69496E666F482C0D0A202020202020202020202020704170657855524C2C0D0A2020202020202020202020207045';
wwv_flow_api.g_varchar2_table(47) := '736361706548544D4C2C0D0A20202020202020202020202070506167654974656D735375626D69742C0D0A2020202020202020202020207053686F7753716C466F692C0D0A20202020202020202020202070557365436F6F6B69652C0D0A202020202020';
wwv_flow_api.g_varchar2_table(48) := '20202020202070436F707972696768742C0D0A2020202020202020202020207053716C466F694C617A792C0D0A2020202020202020202020207053697A65547970652C0D0A20202020202020202020202070556E697453797374656D2C0D0A2020202020';
wwv_flow_api.g_varchar2_table(49) := '20202020202020704C616E67756167652C0D0A20202020202020202020202070557365456C6F632C0D0A20202020202020202020202070446563696D616C436861720D0A2020202020202020293B0D0A20202020202020206765744D6170506C7567696E';
wwv_flow_api.g_varchar2_table(50) := '282070526567696F6E496420292E6D6170766965772E696E697428293B0D0A202020207D0D0A7D0D0A0D0A66756E6374696F6E20417065784F7261636C654D617073506C7567696E282070526567696F6E49642C0D0A2020202020202020202020202020';
wwv_flow_api.g_varchar2_table(51) := '202020202020202020202020202020202070506C7567696E4E616D652C0D0A202020202020202020202020202020202020202020202020202020202020207046696C655072656669782C0D0A202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(52) := '20202020202020704D6170536572766572486F73742C0D0A20202020202020202020202020202020202020202020202020202020202020704D617054696C654C61796572732C0D0A20202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(53) := '202020704D617043656E7465724C6F6E2C0D0A20202020202020202020202020202020202020202020202020202020202020704D617043656E7465724C61742C0D0A2020202020202020202020202020202020202020202020202020202020202070496E';
wwv_flow_api.g_varchar2_table(54) := '69745A6F6F6D2C0D0A20202020202020202020202020202020202020202020202020202020202020704E617650616E656C2C0D0A20202020202020202020202020202020202020202020202020202020202020704E617650616E656C4F7074732C0D0A20';
wwv_flow_api.g_varchar2_table(55) := '202020202020202020202020202020202020202020202020202020202020704D617057696474682C0D0A20202020202020202020202020202020202020202020202020202020202020704D61704865696768742C0D0A2020202020202020202020202020';
wwv_flow_api.g_varchar2_table(56) := '2020202020202020202020202020202020704164646974696F6E616C2C0D0A202020202020202020202020202020202020202020202020202020202020207053716C466F69496E666F572C0D0A2020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(57) := '20202020202020207053716C466F69496E666F482C0D0A20202020202020202020202020202020202020202020202020202020202020704170657855524C2C0D0A2020202020202020202020202020202020202020202020202020202020202070457363';
wwv_flow_api.g_varchar2_table(58) := '61706548544D4C2C0D0A2020202020202020202020202020202020202020202020202020202020202070506167654974656D735375626D69742C0D0A202020202020202020202020202020202020202020202020202020202020207053686F7753716C46';
wwv_flow_api.g_varchar2_table(59) := '6F692C0D0A2020202020202020202020202020202020202020202020202020202020202070557365436F6F6B69652C0D0A2020202020202020202020202020202020202020202020202020202020202070436F707972696768742C0D0A20202020202020';
wwv_flow_api.g_varchar2_table(60) := '2020202020202020202020202020202020202020202020207053716C466F694C617A792C0D0A202020202020202020202020202020202020202020202020202020202020207053697A65547970652C0D0A20202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(61) := '20202020202020202020202070556E697453797374656D2C0D0A20202020202020202020202020202020202020202020202020202020202020704C616E67756167652C0D0A20202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(62) := '70557365456C6F632C0D0A2020202020202020202020202020202020202020202020202020202020202070446563696D616C436861722029207B0D0A202020206765744F72616D6170735F67446563696D616C43686172203D2070446563696D616C4368';
wwv_flow_api.g_varchar2_table(63) := '61723B0D0A0D0A20202020746869732E6D61707669657720203D2066616C73653B0D0A0D0A20202020746869732E637573746F6D4D61726B6572203D206E6577204F4D2E6C617965722E566563746F724C6179657228202743555354464F49272C207B20';
wwv_flow_api.g_varchar2_table(64) := '6465663A207B20747970653A204F4D2E6C617965722E566563746F724C617965722E545950455F4C4F43414C207D207D20293B0D0A0D0A20202020746869732E666F694C6179657273203D205B0D0A20202020202020206E6577204F4D2E6C617965722E';
wwv_flow_api.g_varchar2_table(65) := '566563746F724C6179657228202753514C464F4930272C207B206465663A207B20747970653A204F4D2E6C617965722E566563746F724C617965722E545950455F4C4F43414C207D207D20292C0D0A20202020202020206E6577204F4D2E6C617965722E';
wwv_flow_api.g_varchar2_table(66) := '566563746F724C6179657228202753514C464F4931272C207B206465663A207B20747970653A204F4D2E6C617965722E566563746F724C617965722E545950455F4C4F43414C207D207D20292C0D0A20202020202020206E6577204F4D2E6C617965722E';
wwv_flow_api.g_varchar2_table(67) := '566563746F724C6179657228202753514C464F4932272C207B206465663A207B20747970653A204F4D2E6C617965722E566563746F724C617965722E545950455F4C4F43414C207D207D20292C0D0A20202020202020206E6577204F4D2E6C617965722E';
wwv_flow_api.g_varchar2_table(68) := '566563746F724C6179657228202753514C464F4933272C207B206465663A207B20747970653A204F4D2E6C617965722E566563746F724C617965722E545950455F4C4F43414C207D207D20292C0D0A20202020202020206E6577204F4D2E6C617965722E';
wwv_flow_api.g_varchar2_table(69) := '566563746F724C6179657228202753514C464F4934272C207B206465663A207B20747970653A204F4D2E6C617965722E566563746F724C617965722E545950455F4C4F43414C207D207D20292C0D0A20202020202020206E6577204F4D2E6C617965722E';
wwv_flow_api.g_varchar2_table(70) := '566563746F724C6179657228202753514C464F4935272C207B206465663A207B20747970653A204F4D2E6C617965722E566563746F724C617965722E545950455F4C4F43414C207D207D20292C0D0A20202020202020206E6577204F4D2E6C617965722E';
wwv_flow_api.g_varchar2_table(71) := '566563746F724C6179657228202753514C464F4936272C207B206465663A207B20747970653A204F4D2E6C617965722E566563746F724C617965722E545950455F4C4F43414C207D207D20292C0D0A20202020202020206E6577204F4D2E6C617965722E';
wwv_flow_api.g_varchar2_table(72) := '566563746F724C6179657228202753514C464F4937272C207B206465663A207B20747970653A204F4D2E6C617965722E566563746F724C617965722E545950455F4C4F43414C207D207D20292C0D0A20202020202020206E6577204F4D2E6C617965722E';
wwv_flow_api.g_varchar2_table(73) := '566563746F724C6179657228202753514C464F4938272C207B206465663A207B20747970653A204F4D2E6C617965722E566563746F724C617965722E545950455F4C4F43414C207D207D20292C0D0A20202020202020206E6577204F4D2E6C617965722E';
wwv_flow_api.g_varchar2_table(74) := '566563746F724C6179657228202753514C464F4939272C207B206465663A207B20747970653A204F4D2E6C617965722E566563746F724C617965722E545950455F4C4F43414C207D207D20290D0A202020205D3B0D0A0D0A20202020746869732E674D61';
wwv_flow_api.g_varchar2_table(75) := '70546F6F6C4261723B0D0A20202020746869732E674D6170486173546F6F6C73203D2066616C73653B0D0A20202020746869732E67506C7567696E4E616D6520203D2070506C7567696E4E616D653B0D0A20202020746869732E67526567696F6E464F49';
wwv_flow_api.g_varchar2_table(76) := '2020203D2066616C73653B0D0A0D0A20202020746869732E6753716C466F69496E666F5720202020203D207053716C466F69496E666F573B0D0A20202020746869732E6753716C466F69496E666F4820202020203D207053716C466F69496E666F483B0D';
wwv_flow_api.g_varchar2_table(77) := '0A20202020746869732E6753716C466F694C617A792020202020203D207053716C466F694C617A793B0D0A20202020746869732E6745736361706548544D4C2020202020203D207045736361706548544D4C3B0D0A20202020746869732E675061676549';
wwv_flow_api.g_varchar2_table(78) := '74656D735375626D6974203D2070506167654974656D735375626D69743B0D0A20202020746869732E6753686F7753716C466F692020202020203D207053686F7753716C466F693B0D0A20202020746869732E67557365436F6F6B696520202020202020';
wwv_flow_api.g_varchar2_table(79) := '3D2070557365436F6F6B69653B0D0A20202020746869732E6753697A655479706520202020202020203D207053697A65547970653B0D0A20202020746869732E674D6170576964746820202020202020203D20704D617057696474683B0D0A2020202074';
wwv_flow_api.g_varchar2_table(80) := '6869732E674D6170486569676874202020202020203D20704D61704865696768743B0D0A20202020746869732E67556E697453797374656D2020202020203D2070556E697453797374656D3B0D0A20202020746869732E674C616E677561676520202020';
wwv_flow_api.g_varchar2_table(81) := '202020203D20704C616E67756167653B0D0A20202020696620282021746869732E674C616E6775616765207C7C20746869732E674C616E6775616765203D3D2022222029207B0D0A2020202020202020746869732E674C616E6775616765203D2022656E';
wwv_flow_api.g_varchar2_table(82) := '223B0D0A202020207D0D0A0D0A202020206966202820704164646974696F6E616C2E73656172636828202F464F49434C5553544552532F202920213D202D312029207B0D0A2020202020202020746869732E666F69436C757374657273203D2074727565';
wwv_flow_api.g_varchar2_table(83) := '3B0D0A202020207D20656C7365207B0D0A2020202020202020746869732E666F69436C757374657273203D2066616C73653B0D0A202020207D0D0A0D0A20202020746869732E686561746D6170203D2066616C73653B0D0A0D0A20202020746869732E72';
wwv_flow_api.g_varchar2_table(84) := '65646C696E653B0D0A20202020746869732E64697374616E6365746F6F6C3B0D0A20202020746869732E7363616C656261723B0D0A20202020746869732E6D6172717565657A6F6F6D746F6F6C3B0D0A20202020746869732E7265646C696E65746F6F6C';
wwv_flow_api.g_varchar2_table(85) := '3B0D0A20202020746869732E636972636C65746F6F6C3B0D0A0D0A20202020746869732E66697273744D61704C61796572496E7465726E616C203D20747275653B0D0A0D0A20202020746869732E67526567696F6E49642020203D2070526567696F6E49';
wwv_flow_api.g_varchar2_table(86) := '643B0D0A20202020746869732E6746696C65507265666978203D207046696C655072656669783B0D0A0D0A20202020746869732E6D61706C61796572202020203D205B5D3B0D0A20202020746869732E6C61796572537769746368203D205B5D3B0D0A0D';
wwv_flow_api.g_varchar2_table(87) := '0A20202020766172206C496E69745A6F6F6D2020202020203D2070496E69745A6F6F6D3B0D0A20202020766172206C4D617043656E7465724C6F6E20203D207061727365466C6F61742820704D617043656E7465724C6F6E20293B0D0A20202020766172';
wwv_flow_api.g_varchar2_table(88) := '206C4D617043656E7465724C617420203D207061727365466C6F61742820704D617043656E7465724C617420293B0D0A20202020766172206C4D617043656E74657253524944203D20343332363B0D0A20202020746869732E676F6F676C65496E697420';
wwv_flow_api.g_varchar2_table(89) := '2020203D2066616C73653B0D0A0D0A202020204F4D2E67762E5F6261736555524C203D20704D6170536572766572486F73743B0D0A202020204F4D2E67762E7365745265736F75726365506174682820704D6170536572766572486F7374202B20222F6A';
wwv_flow_api.g_varchar2_table(90) := '736C69622F7631392E312220293B0D0A202020204F4D2E67762E5F72657350617468202020203D20704D6170536572766572486F7374202B20222F6A736C69622F7631392E312F696D616765732F223B0D0A202020204F4D2E67762E5F63737352657350';
wwv_flow_api.g_varchar2_table(91) := '617468203D20704D6170536572766572486F7374202B20222F6A736C69622F7631392E312F6373732F223B0D0A202020204F4D2E67762E6D65737361676550617468203D20704D6170536572766572486F7374202B20222F6A736C69622F7631392E312F';
wwv_flow_api.g_varchar2_table(92) := '6D657373616765732F223B0D0A202020204F4D2E67762E6C6F6164696E6749636F6E203D20227472616E73706172656E742E676966223B0D0A202020204F4D2E4D61702E7365744C6F63616C652820746869732E674C616E67756167652E737562737472';
wwv_flow_api.g_varchar2_table(93) := '696E672820302C2032202920293B0D0A0D0A202020202F2F20637265617465206C6F63616C207374796C65730D0A20202020746869732E675374796C6573203D205B5D3B0D0A0D0A20202020746869732E675374796C65735B2022626C756522205D2020';
wwv_flow_api.g_varchar2_table(94) := '203D206E6577204F4D2E7374796C652E436F6C6F7228207B0D0A2020202020202020226E616D6522202020202020203A2022626C7565222C0D0A2020202020202020227374726F6B652220202020203A202223303030306666222C0D0A20202020202020';
wwv_flow_api.g_varchar2_table(95) := '202266696C6C22202020202020203A202223383038306666222C0D0A20202020202020202266696C6C4F706163697479223A20302E370D0A202020207D20293B0D0A20202020746869732E675374796C65735B202272656422205D202020203D206E6577';
wwv_flow_api.g_varchar2_table(96) := '204F4D2E7374796C652E436F6C6F7228207B0D0A2020202020202020226E616D6522202020202020203A2022726564222C0D0A2020202020202020227374726F6B652220202020203A202223666630303030222C0D0A20202020202020202266696C6C22';
wwv_flow_api.g_varchar2_table(97) := '202020202020203A202223666638303830222C0D0A20202020202020202266696C6C4F706163697479223A20302E370D0A202020207D20293B0D0A20202020746869732E675374796C65735B2022677265656E22205D20203D206E6577204F4D2E737479';
wwv_flow_api.g_varchar2_table(98) := '6C652E436F6C6F7228207B0D0A2020202020202020226E616D6522202020202020203A2022677265656E222C0D0A2020202020202020227374726F6B652220202020203A202223303063303030222C0D0A20202020202020202266696C6C222020202020';
wwv_flow_api.g_varchar2_table(99) := '20203A202223363063303630222C0D0A20202020202020202266696C6C4F706163697479223A20302E370D0A202020207D20293B0D0A20202020746869732E675374796C65735B20226772617922205D2020203D206E6577204F4D2E7374796C652E436F';
wwv_flow_api.g_varchar2_table(100) := '6C6F7228207B0D0A2020202020202020226E616D6522202020202020203A202267726179222C0D0A2020202020202020227374726F6B652220202020203A202223636363636363222C0D0A20202020202020202266696C6C22202020202020203A202223';
wwv_flow_api.g_varchar2_table(101) := '383038303830222C0D0A20202020202020202266696C6C4F706163697479223A20302E370D0A202020207D20293B0D0A20202020746869732E675374796C65735B202279656C6C6F7722205D203D206E6577204F4D2E7374796C652E436F6C6F7228207B';
wwv_flow_api.g_varchar2_table(102) := '0D0A2020202020202020226E616D6522202020202020203A202279656C6C6F77222C0D0A2020202020202020227374726F6B652220202020203A202223666666663030222C0D0A20202020202020202266696C6C22202020202020203A20222365656565';
wwv_flow_api.g_varchar2_table(103) := '3830222C0D0A20202020202020202266696C6C4F706163697479223A20302E370D0A202020207D20293B0D0A20202020746869732E675374796C65735B2022707572706C6522205D203D206E6577204F4D2E7374796C652E436F6C6F7228207B0D0A2020';
wwv_flow_api.g_varchar2_table(104) := '202020202020226E616D6522202020202020203A2022707572706C65222C0D0A2020202020202020227374726F6B652220202020203A202223666630306666222C0D0A20202020202020202266696C6C22202020202020203A202223666638306666222C';
wwv_flow_api.g_varchar2_table(105) := '0D0A20202020202020202266696C6C4F706163697479223A20302E370D0A202020207D20293B0D0A20202020746869732E675374796C65735B20226F72616E676522205D203D206E6577204F4D2E7374796C652E436F6C6F7228207B0D0A202020202020';
wwv_flow_api.g_varchar2_table(106) := '2020226E616D6522202020202020203A20226F72616E6765222C0D0A2020202020202020227374726F6B652220202020203A202223666638303030222C0D0A20202020202020202266696C6C22202020202020203A202223666663303830222C0D0A2020';
wwv_flow_api.g_varchar2_table(107) := '2020202020202266696C6C4F706163697479223A20302E370D0A202020207D20293B0D0A0D0A202020202F2F20696E697469616C697A6520746865206D61702068616E646C650D0A20202020746869732E6D617076696577203D206E6577204F4D2E4D61';
wwv_flow_api.g_varchar2_table(108) := '70280D0A2020202020202020617065782E6A51756572792820222322202B20746869732E67526567696F6E4964202B20225F6D61702220292C0D0A20202020202020207B206D617076696577657255524C3A20704D6170536572766572486F73742C2064';
wwv_flow_api.g_varchar2_table(109) := '697361626C654F766572766965774D61703A2028704164646974696F6E616C2E73656172636828202F4F5645522F2029203D3D202D3129207D0D0A20202020293B0D0A0D0A202020202F2F20537769746368204D6F75736520576865656C207A6F6F6D20';
wwv_flow_api.g_varchar2_table(110) := '6F66660D0A202020206966202820704164646974696F6E616C2E73656172636828202F4D4F555345574845454C2F202920213D202D312029207B0D0A2020202020202020746869732E6D6170766965772E656E61626C654D6F757365576865656C5A6F6F';
wwv_flow_api.g_varchar2_table(111) := '6D696E6728207472756520293B0D0A202020207D20656C7365207B0D0A2020202020202020746869732E6D6170766965772E656E61626C654D6F757365576865656C5A6F6F6D696E67282066616C736520293B0D0A202020207D0D0A0D0A202020202F2F';
wwv_flow_api.g_varchar2_table(112) := '204164642065787465726E616C204D616C2054696C65204C61796572732C206966207265717565737465640D0A20202020766172206C54696C654C6179657273203D20303B0D0A20202020696620282070557365456C6F6320213D20224E4F4E45222029';
wwv_flow_api.g_varchar2_table(113) := '207B0D0A2020202020202020696620282070557365456C6F63203D3D2022454C4F434154494F4E222029207B0D0A202020202020202020202020746869732E6D61706C617965725B206C54696C654C6179657273205D203D206E6577204F4D2E6C617965';
wwv_flow_api.g_varchar2_table(114) := '722E456C6F636174696F6E54696C654C6179657228202254696C654C617965725F22202B206C54696C654C617965727320293B0D0A20202020202020207D0D0A2020202020202020696620282070557365456C6F63203D3D202242494E47222029207B0D';
wwv_flow_api.g_varchar2_table(115) := '0A202020202020202020202020746869732E6D61706C617965725B206C54696C654C6179657273205D203D206E6577204F4D2E6C617965722E42696E6754696C654C6179657228202254696C654C617965725F22202B206C54696C654C61796572732C20';
wwv_flow_api.g_varchar2_table(116) := '7B206D6170547970653A204F4D2E6C617965722E42696E6754696C654C617965722E545950455F524F4144207D20293B0D0A20202020202020207D0D0A2020202020202020696620282070557365456C6F63203D3D202242494E475F41455249414C2220';
wwv_flow_api.g_varchar2_table(117) := '29207B0D0A202020202020202020202020746869732E6D61706C617965725B206C54696C654C6179657273205D203D206E6577204F4D2E6C617965722E42696E6754696C654C6179657228202254696C654C617965725F22202B206C54696C654C617965';
wwv_flow_api.g_varchar2_table(118) := '72732C207B206D6170547970653A204F4D2E6C617965722E42696E6754696C654C617965722E545950455F41455249414C207D20293B0D0A20202020202020207D0D0A2020202020202020696620282070557365456C6F63203D3D202242494E475F4155';
wwv_flow_api.g_varchar2_table(119) := '544F222029207B0D0A202020202020202020202020746869732E6D61706C617965725B206C54696C654C6179657273205D203D206E6577204F4D2E6C617965722E42696E6754696C654C6179657228202254696C654C617965725F22202B206C54696C65';
wwv_flow_api.g_varchar2_table(120) := '4C61796572732C207B206D6170547970653A204F4D2E6C617965722E42696E6754696C654C617965722E545950455F4155544F207D20293B0D0A20202020202020207D0D0A2020202020202020696620282070557365456C6F632E737562737472282030';
wwv_flow_api.g_varchar2_table(121) := '2C20332029203D3D3D20224F534D222029207B0D0A202020202020202020202020746869732E6D61706C617965725B206C54696C654C6179657273205D203D206E6577204F4D2E6C617965722E54696C654C61796572280D0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(122) := '20202020202254696C654C617965725F22202B206C54696C654C61796572732C0D0A202020202020202020202020202020207B0D0A202020202020202020202020202020202020202064617461536F757263652020203A2022656C6F636174696F6E5F6D';
wwv_flow_api.g_varchar2_table(123) := '65726361746F72222C0D0A202020202020202020202020202020202020202074696C654C61796572202020203A20282070557365456C6F63203D3D3D20224F534D22203F20224F534D5F504F534954524F4E22203A20282070557365456C6F63203D3D3D';
wwv_flow_api.g_varchar2_table(124) := '20224F534D5F4441524B22203F20224F534D5F4441524B4D415454455222203A2070557365456C6F63202920292C0D0A202020202020202020202020202020202020202074696C6553657276657255524C3A20704D6170536572766572486F7374202B20';
wwv_flow_api.g_varchar2_table(125) := '222F6D63736572766572220D0A202020202020202020202020202020207D0D0A202020202020202020202020293B0D0A20202020202020207D0D0A0D0A2020202020202020746869732E6D61706C617965725B206C54696C654C6179657273205D2E7365';
wwv_flow_api.g_varchar2_table(126) := '7456697369626C6528207472756520293B0D0A2020202020202020746869732E6D6170766965772E6164644C617965722820746869732E6D61706C617965725B206C54696C654C6179657273205D20293B0D0A20202020202020206C54696C654C617965';
wwv_flow_api.g_varchar2_table(127) := '72732B2B3B0D0A202020207D20656C7365207B0D0A20202020202020206966202820704D617054696C654C617965727320213D2022222029207B0D0A202020202020202020202020766172206C4D61704172726179203D20704D617054696C654C617965';
wwv_flow_api.g_varchar2_table(128) := '72732E73706C69742820223A2220293B0D0A0D0A202020202020202020202020666F722028207661722069203D20303B2069203C206C4D617041727261792E6C656E6774683B20692B2B2029207B0D0A2020202020202020202020202020202076617220';
wwv_flow_api.g_varchar2_table(129) := '6C4D617044657461696C7320202020202020202020202020203D206C4D617041727261795B2069205D2E73706C69742820222C2220293B0D0A20202020202020202020202020202020766172206C4D61704C617965725370656320202020202020202020';
wwv_flow_api.g_varchar2_table(130) := '20203D206C4D617044657461696C735B2030205D2E73706C69742820222E2220293B0D0A20202020202020202020202020202020746869732E6D61706C617965725B206C54696C654C6179657273205D203D206E6577204F4D2E6C617965722E54696C65';
wwv_flow_api.g_varchar2_table(131) := '4C61796572280D0A20202020202020202020202020202020202020202254696C654C617965725F22202B206C54696C654C61796572732C0D0A20202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(132) := '2020202064617461536F757263652020203A206C4D61704C61796572537065635B2030205D2C0D0A20202020202020202020202020202020202020202020202074696C654C61796572202020203A206C4D61704C61796572537065635B2031205D2C0D0A';
wwv_flow_api.g_varchar2_table(133) := '20202020202020202020202020202020202020202020202074696C6553657276657255524C3A20704D6170536572766572486F7374202B20222F6D63736572766572220D0A20202020202020202020202020202020202020207D0D0A2020202020202020';
wwv_flow_api.g_varchar2_table(134) := '2020202020202020293B0D0A20202020202020202020202020202020746869732E6D61706C617965725B206C54696C654C6179657273205D2E73657456697369626C6528207472756520293B0D0A20202020202020202020202020202020746869732E6D';
wwv_flow_api.g_varchar2_table(135) := '6170766965772E6164644C617965722820746869732E6D61706C617965725B206C54696C654C6179657273205D20293B0D0A0D0A20202020202020202020202020202020746869732E6C617965725377697463685B206C54696C654C6179657273205D20';
wwv_flow_api.g_varchar2_table(136) := '3D206E6577204F4D2E636F6E74726F6C2E4D61704465636F726174696F6E280D0A2020202020202020202020202020202020202020273C646976207374796C653D2227202B204F52414D4150535F434F4E53545F54494C45425554544F4E5354594C452E';
wwv_flow_api.g_varchar2_table(137) := '6373737374796C65202B0D0A20202020202020202020202020202020202020202722206F6E436C69636B3D226765744D6170506C7567696E285C2727202B2070526567696F6E4964202B20275C27292E746F67676C654D61704C617965722827202B206C';
wwv_flow_api.g_varchar2_table(138) := '54696C654C6179657273202B0D0A202020202020202020202020202020202020202027293B223E27202B206C4D617044657461696C735B2031205D202B20273C2F6469763E270D0A20202020202020202020202020202020293B0D0A2020202020202020';
wwv_flow_api.g_varchar2_table(139) := '2020202020202020746869732E6C617965725377697463685B206C54696C654C6179657273205D2E736574506F736974696F6E2820746869732E6D6170766965772E6765744D6170436F6E7465787428292E67657444657669636557696474682829202D';
wwv_flow_api.g_varchar2_table(140) := '203530202D2028313530202A20286C54696C654C6179657273202B203129292C20323020293B0D0A202020202020202020202020202020206C54696C654C61796572732B2B3B0D0A2020202020202020202020207D0D0A0D0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(141) := '202F2F2061646420627574746F6E7320746F2073776974636820746865206D61702074696C65206C61796572730D0A20202020202020202020202069662028206C54696C654C6179657273203E20312029207B0D0A202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(142) := '20666F722028207661722074203D20303B2074203C206C54696C654C61796572733B20742B2B2029207B0D0A2020202020202020202020202020202020202020746869732E6D6170766965772E6164644D61704465636F726174696F6E2820746869732E';
wwv_flow_api.g_varchar2_table(143) := '6C617965725377697463685B2074205D20293B0D0A202020202020202020202020202020207D0D0A2020202020202020202020207D0D0A20202020202020207D0D0A202020207D0D0A0D0A202020202F2F20676574204D617020506F736974696F6E2061';
wwv_flow_api.g_varchar2_table(144) := '6E64205A6F6F6D206C6576656C20636F6F6B69652C2069662065786973747320616E6420706172736520636F6E74656E74730D0A0D0A202020206966202820746869732E67557365436F6F6B6965203D3D202259222029207B0D0A202020202020202074';
wwv_flow_api.g_varchar2_table(145) := '7279207B0D0A202020202020202020202020766172206C436F6F6B6965203D20617065782E73746F726167652E676574436F6F6B69652820274F7261636C654D617073506C7567696E5F27202B20746869732E67526567696F6E4964202B20225F22202B';
wwv_flow_api.g_varchar2_table(146) := '20247628202270496E7374616E636522202920293B0D0A20202020202020202020202069662028206C436F6F6B69652029207B0D0A2020202020202020202020202020202076617220636F6F6B696556616C756573203D206C436F6F6B69652E73706C69';
wwv_flow_api.g_varchar2_table(147) := '74282022232220293B0D0A202020202020202020202020202020206C496E69745A6F6F6D20202020202020203D207061727365496E742820636F6F6B696556616C7565735B2030205D20293B0D0A202020202020202020202020202020206C4D61704365';
wwv_flow_api.g_varchar2_table(148) := '6E7465724C6F6E202020203D207061727365466C6F61742820636F6F6B696556616C7565735B2031205D2029202F20313030303030303030303B0D0A202020202020202020202020202020206C4D617043656E7465724C6174202020203D207061727365';
wwv_flow_api.g_varchar2_table(149) := '466C6F61742820636F6F6B696556616C7565735B2032205D2029202F20313030303030303030303B0D0A202020202020202020202020202020206C4D617043656E746572535249442020203D207061727365496E742820636F6F6B696556616C7565735B';
wwv_flow_api.g_varchar2_table(150) := '2033205D20293B0D0A2020202020202020202020207D0D0A20202020202020207D206361746368202820652029207B0D0A20202020202020202020202069662028202476282022706465627567222029203D3D2022594553222029207B0D0A2020202020';
wwv_flow_api.g_varchar2_table(151) := '2020202020202020202020636F6E736F6C652E6C6F6728206520293B0D0A2020202020202020202020207D0D0A20202020202020207D0D0A2020202020202020696620282069734E614E28206C4D617043656E7465724C6F6E2029207C7C2069734E614E';
wwv_flow_api.g_varchar2_table(152) := '28206C4D617043656E7465724C617420292029207B0D0A2020202020202020202020206C4D617043656E7465724C6F6E20203D207061727365466C6F61742820704D617043656E7465724C6F6E20293B0D0A2020202020202020202020206C4D61704365';
wwv_flow_api.g_varchar2_table(153) := '6E7465724C617420203D207061727365466C6F61742820704D617043656E7465724C617420293B0D0A2020202020202020202020206C4D617043656E74657253524944203D20343332363B0D0A20202020202020207D0D0A202020207D0D0A0D0A202020';
wwv_flow_api.g_varchar2_table(154) := '206966202820704E617650616E656C20213D20224E4F4E45222029207B0D0A202020202020202076617220706F733B0D0A20202020202020206966202820704E617650616E656C203D3D202257455354222029207B0D0A20202020202020202020202070';
wwv_flow_api.g_varchar2_table(155) := '6F73203D20313B0D0A20202020202020207D0D0A2020202020202020656C7365206966202820704E617650616E656C203D3D202245415354222029207B0D0A202020202020202020202020706F73203D20333B0D0A20202020202020207D0D0A20202020';
wwv_flow_api.g_varchar2_table(156) := '20202020656C7365207B0D0A202020202020202020202020706F73203D20333B0D0A20202020202020207D0D0A0D0A2020202020202020766172206C4E617650616E656C203D206E6577204F4D2E636F6E74726F6C2E4E617669676174696F6E50616E65';
wwv_flow_api.g_varchar2_table(157) := '6C426172280D0A2020202020202020202020207B20226F7269656E746174696F6E223A20312C20227374796C65223A20704E617650616E656C4F7074732C2022616E63686F72506F736974696F6E223A20706F73207D0D0A2020202020202020293B0D0A';
wwv_flow_api.g_varchar2_table(158) := '2020202020202020746869732E6D6170766965772E6164644D61704465636F726174696F6E28206C4E617650616E656C20293B0D0A202020207D0D0A0D0A202020202F2F2063726561746520746865206D617020746F6F6C730D0A20202020746869732E';
wwv_flow_api.g_varchar2_table(159) := '64697374616E6365746F6F6C203D206E6577204F4D2E746F6F6C2E44697374616E6365546F6F6C2820746869732E6D61707669657720293B0D0A202020206966202820746869732E67556E697453797374656D203D3D2022494D50455249414C22202920';
wwv_flow_api.g_varchar2_table(160) := '7B0D0A2020202020202020746869732E64697374616E6365746F6F6C2E756E6974203D20226D696C65223B0D0A202020207D20656C7365207B0D0A2020202020202020746869732E64697374616E6365746F6F6C2E756E6974203D20226B696C6F6D6574';
wwv_flow_api.g_varchar2_table(161) := '6572223B0D0A202020207D0D0A20202020746869732E64697374616E6365746F6F6C2E6164644C697374656E6572280D0A20202020202020204F4D2E6576656E742E546F6F6C4576656E742E544F4F4C5F454E442C0D0A202020202020202066756E6374';
wwv_flow_api.g_varchar2_table(162) := '696F6E202820652029207B0D0A202020202020202020202020617065782E6576656E742E74726967676572280D0A20202020202020202020202020202020617065782E6A51756572792820222322202B2070526567696F6E496420292C0D0A2020202020';
wwv_flow_api.g_varchar2_table(163) := '202020202020202020202022636F6D5F6F7261636C655F6F72616D61707368746D6C355F64697374616E636566696E697368220D0A202020202020202020202020293B0D0A20202020202020207D0D0A20202020293B0D0A20202020746869732E646973';
wwv_flow_api.g_varchar2_table(164) := '74616E6365746F6F6C2E6164644C697374656E6572280D0A20202020202020204F4D2E6576656E742E546F6F6C4576656E742E544F4F4C5F53544152542C0D0A202020202020202066756E6374696F6E202820652029207B0D0A20202020202020202020';
wwv_flow_api.g_varchar2_table(165) := '2020617065782E6576656E742E74726967676572280D0A20202020202020202020202020202020617065782E6A51756572792820222322202B2070526567696F6E496420292C0D0A2020202020202020202020202020202022636F6D5F6F7261636C655F';
wwv_flow_api.g_varchar2_table(166) := '6F72616D61707368746D6C355F64697374616E63657374617274220D0A202020202020202020202020293B0D0A20202020202020207D0D0A20202020293B0D0A20202020746869732E64697374616E6365746F6F6C2E6164644C697374656E6572280D0A';
wwv_flow_api.g_varchar2_table(167) := '20202020202020204F4D2E6576656E742E546F6F6C4576656E742E544F4F4C5F434C4541522C0D0A202020202020202066756E6374696F6E202820652029207B0D0A202020202020202020202020617065782E6576656E742E74726967676572280D0A20';
wwv_flow_api.g_varchar2_table(168) := '202020202020202020202020202020617065782E6A51756572792820222322202B2070526567696F6E496420292C0D0A2020202020202020202020202020202022636F6D5F6F7261636C655F6F72616D61707368746D6C355F64697374616E6365636C65';
wwv_flow_api.g_varchar2_table(169) := '6172220D0A202020202020202020202020293B0D0A20202020202020207D0D0A20202020293B0D0A0D0A20202020746869732E6D6172717565657A6F6F6D746F6F6C203D206E6577204F4D2E746F6F6C2E4D6172717565655A6F6F6D546F6F6C28207468';
wwv_flow_api.g_varchar2_table(170) := '69732E6D6170766965772C204F4D2E746F6F6C2E4D6172717565655A6F6F6D546F6F6C2E4F4E455F54494D4520293B0D0A0D0A20202020746869732E636972636C65746F6F6C203D206E6577204F4D2E746F6F6C2E436972636C65546F6F6C2820746869';
wwv_flow_api.g_varchar2_table(171) := '732E6D61707669657720293B0D0A20202020746869732E636972636C65746F6F6C2E6164644C697374656E6572280D0A20202020202020204F4D2E6576656E742E546F6F6C4576656E742E544F4F4C5F454E442C0D0A202020202020202066756E637469';
wwv_flow_api.g_varchar2_table(172) := '6F6E202820652029207B0D0A202020202020202020202020617065782E6576656E742E74726967676572280D0A20202020202020202020202020202020617065782E6A51756572792820222322202B2070526567696F6E496420292C0D0A202020202020';
wwv_flow_api.g_varchar2_table(173) := '2020202020202020202022636F6D5F6F7261636C655F6F72616D61707368746D6C355F636972636C6566696E697368220D0A202020202020202020202020293B0D0A20202020202020207D0D0A20202020293B0D0A20202020746869732E636972636C65';
wwv_flow_api.g_varchar2_table(174) := '746F6F6C2E6164644C697374656E6572280D0A20202020202020204F4D2E6576656E742E546F6F6C4576656E742E544F4F4C5F434C4541522C0D0A202020202020202066756E6374696F6E202820652029207B0D0A202020202020202020202020617065';
wwv_flow_api.g_varchar2_table(175) := '782E6576656E742E74726967676572280D0A20202020202020202020202020202020617065782E6A51756572792820222322202B2070526567696F6E496420292C0D0A2020202020202020202020202020202022636F6D5F6F7261636C655F6F72616D61';
wwv_flow_api.g_varchar2_table(176) := '707368746D6C355F636972636C65636C656172220D0A202020202020202020202020293B0D0A20202020202020207D0D0A20202020293B0D0A0D0A20202020746869732E7265646C696E65746F6F6C203D206E6577204F4D2E746F6F6C2E5265646C696E';
wwv_flow_api.g_varchar2_table(177) := '65546F6F6C2820746869732E6D6170766965772C204F4D2E746F6F6C2E5265646C696E65546F6F6C2E545950455F504F4C59474F4E20293B0D0A20202020746869732E7265646C696E65746F6F6C2E6164644C697374656E6572280D0A20202020202020';
wwv_flow_api.g_varchar2_table(178) := '204F4D2E6576656E742E546F6F6C4576656E742E544F4F4C5F454E442C0D0A202020202020202066756E6374696F6E202820652029207B0D0A202020202020202020202020617065782E6576656E742E74726967676572280D0A20202020202020202020';
wwv_flow_api.g_varchar2_table(179) := '202020202020617065782E6A51756572792820222322202B2070526567696F6E496420292C0D0A2020202020202020202020202020202022636F6D5F6F7261636C655F6F72616D61707368746D6C355F7265646C696E6566696E697368220D0A20202020';
wwv_flow_api.g_varchar2_table(180) := '2020202020202020293B0D0A20202020202020207D0D0A20202020293B0D0A20202020746869732E7265646C696E65746F6F6C2E6164644C697374656E6572280D0A20202020202020204F4D2E6576656E742E546F6F6C4576656E742E544F4F4C5F434C';
wwv_flow_api.g_varchar2_table(181) := '4541522C0D0A202020202020202066756E6374696F6E202820652029207B0D0A202020202020202020202020617065782E6576656E742E74726967676572280D0A20202020202020202020202020202020617065782E6A51756572792820222322202B20';
wwv_flow_api.g_varchar2_table(182) := '70526567696F6E496420292C0D0A2020202020202020202020202020202022636F6D5F6F7261636C655F6F72616D61707368746D6C355F7265646C696E65636C656172220D0A202020202020202020202020293B0D0A20202020202020207D0D0A202020';
wwv_flow_api.g_varchar2_table(183) := '20293B0D0A0D0A20202020746869732E7265646C696E65746F6F6C2E6164644C697374656E6572280D0A20202020202020204F4D2E6576656E742E546F6F6C4576656E742E5245444C494E455F504F494E545F4352454154452C0D0A2020202020202020';
wwv_flow_api.g_varchar2_table(184) := '66756E6374696F6E202820652029207B0D0A202020202020202020202020617065782E6576656E742E74726967676572280D0A20202020202020202020202020202020617065782E6A51756572792820222322202B2070526567696F6E496420292C0D0A';
wwv_flow_api.g_varchar2_table(185) := '2020202020202020202020202020202022636F6D5F6F7261636C655F6F72616D61707368746D6C355F7265646C696E65706F696E74220D0A202020202020202020202020293B0D0A20202020202020207D0D0A20202020293B0D0A0D0A202020202F2F20';
wwv_flow_api.g_varchar2_table(186) := '6275696C6420746865206D617020746F6F6C6261720D0A20202020746869732E674D6170546F6F6C426172203D206E6577204F4D2E636F6E74726F6C2E546F6F6C426172280D0A2020202020202020226170782D6D6170732D746F6F6C6261725F22202B';
wwv_flow_api.g_varchar2_table(187) := '20746869732E67526567696F6E49642C0D0A20202020202020207B0D0A2020202020202020202020206275696C74496E427574746F6E733A205B5D2C0D0A2020202020202020202020206F7269656E746174696F6E2020203A204F4D2E636F6E74726F6C';
wwv_flow_api.g_varchar2_table(188) := '2E546F6F6C4261722E484F52495A4F4E54414C0D0A20202020202020207D0D0A20202020293B0D0A0D0A202020206966202820704164646974696F6E616C2E73656172636828202F5245444C494E452F202920213D202D31207C7C20704164646974696F';
wwv_flow_api.g_varchar2_table(189) := '6E616C2E73656172636828202F44495354414E43452F202920213D202D31207C7C20704164646974696F6E616C2E73656172636828202F434952434C452F202920213D202D312029207B0D0A2020202020202020766172206C4274436C656172203D206E';
wwv_flow_api.g_varchar2_table(190) := '6577204F4D2E636F6E74726F6C2E546F6F6C427574746F6E280D0A202020202020202020202020746869732E67526567696F6E4964202B20225F636C656172222C0D0A2020202020202020202020204F4D2E636F6E74726F6C2E546F6F6C427574746F6E';
wwv_flow_api.g_varchar2_table(191) := '2E434F4D4D414E442C0D0A2020202020202020202020207B0D0A20202020202020202020202020202020627574746F6E49636F6E3A20704D6170536572766572486F7374202B204F52414D4150535F434F4E53545F49434F4E50415448202B2022636C65';
wwv_flow_api.g_varchar2_table(192) := '61722E676966222C0D0A20202020202020202020202020202020776964746820202020203A204F52414D4150535F434F4E53545F425453495A452C0D0A20202020202020202020202020202020686569676874202020203A204F52414D4150535F434F4E';
wwv_flow_api.g_varchar2_table(193) := '53545F425453495A450D0A2020202020202020202020207D0D0A2020202020202020293B0D0A20202020202020206C4274436C6561722E6164644C697374656E6572280D0A2020202020202020202020204F4D2E6576656E742E546F6F6C626172457665';
wwv_flow_api.g_varchar2_table(194) := '6E742E425554544F4E5F444F574E2C0D0A20202020202020202020202066756E6374696F6E202820652029207B0D0A202020202020202020202020202020206765744D6170506C7567696E282070526567696F6E496420292E636C656172416C6C546F6F';
wwv_flow_api.g_varchar2_table(195) := '6C7328293B0D0A2020202020202020202020207D0D0A2020202020202020293B0D0A2020202020202020746869732E674D6170546F6F6C4261722E616464427574746F6E28206C4274436C65617220293B0D0A2020202020202020746869732E674D6170';
wwv_flow_api.g_varchar2_table(196) := '486173546F6F6C73203D20747275653B0D0A202020207D0D0A202020206966202820704164646974696F6E616C2E73656172636828202F44495354414E43452F202920213D202D312029207B0D0A2020202020202020766172206C427444697374616E63';
wwv_flow_api.g_varchar2_table(197) := '65203D206E6577204F4D2E636F6E74726F6C2E546F6F6C427574746F6E280D0A202020202020202020202020746869732E67526567696F6E4964202B20225F64697374616E6365746F6F6C222C0D0A2020202020202020202020204F4D2E636F6E74726F';
wwv_flow_api.g_varchar2_table(198) := '6C2E546F6F6C427574746F6E2E434F4D4D414E442C0D0A2020202020202020202020207B0D0A20202020202020202020202020202020627574746F6E49636F6E3A20704D6170536572766572486F7374202B204F52414D4150535F434F4E53545F49434F';
wwv_flow_api.g_varchar2_table(199) := '4E50415448202B202264697374616E63652E676966222C0D0A20202020202020202020202020202020776964746820202020203A204F52414D4150535F434F4E53545F425453495A452C0D0A202020202020202020202020202020206865696768742020';
wwv_flow_api.g_varchar2_table(200) := '20203A204F52414D4150535F434F4E53545F425453495A450D0A2020202020202020202020207D0D0A2020202020202020293B0D0A20202020202020206C427444697374616E63652E6164644C697374656E6572280D0A2020202020202020202020204F';
wwv_flow_api.g_varchar2_table(201) := '4D2E6576656E742E546F6F6C6261724576656E742E425554544F4E5F444F574E2C0D0A20202020202020202020202066756E6374696F6E202820652029207B0D0A202020202020202020202020202020206765744D6170506C7567696E28207052656769';
wwv_flow_api.g_varchar2_table(202) := '6F6E496420292E636C656172416C6C546F6F6C7328293B0D0A202020202020202020202020202020206765744D6170506C7567696E282070526567696F6E496420292E64697374616E6365746F6F6C2E737461727428293B0D0A20202020202020202020';
wwv_flow_api.g_varchar2_table(203) := '20207D0D0A2020202020202020293B0D0A2020202020202020746869732E674D6170546F6F6C4261722E616464427574746F6E28206C427444697374616E636520293B0D0A2020202020202020746869732E674D6170486173546F6F6C73203D20747275';
wwv_flow_api.g_varchar2_table(204) := '653B0D0A202020207D0D0A0D0A202020206966202820704164646974696F6E616C2E73656172636828202F4D4152515545452F202920213D202D312029207B0D0A2020202020202020766172206C42745A6F6F6D203D206E6577204F4D2E636F6E74726F';
wwv_flow_api.g_varchar2_table(205) := '6C2E546F6F6C427574746F6E280D0A202020202020202020202020746869732E67526567696F6E4964202B20225F6D6172717565657A6F6F6D746F6F6C222C0D0A2020202020202020202020204F4D2E636F6E74726F6C2E546F6F6C427574746F6E2E43';
wwv_flow_api.g_varchar2_table(206) := '4F4D4D414E442C0D0A2020202020202020202020207B0D0A20202020202020202020202020202020627574746F6E49636F6E3A20704D6170536572766572486F7374202B204F52414D4150535F434F4E53545F49434F4E50415448202B20227A6F6F6D2E';
wwv_flow_api.g_varchar2_table(207) := '676966222C0D0A20202020202020202020202020202020776964746820202020203A204F52414D4150535F434F4E53545F425453495A452C0D0A20202020202020202020202020202020686569676874202020203A204F52414D4150535F434F4E53545F';
wwv_flow_api.g_varchar2_table(208) := '425453495A450D0A2020202020202020202020207D0D0A2020202020202020293B0D0A20202020202020206C42745A6F6F6D2E6164644C697374656E6572280D0A2020202020202020202020204F4D2E6576656E742E546F6F6C6261724576656E742E42';
wwv_flow_api.g_varchar2_table(209) := '5554544F4E5F444F574E2C0D0A20202020202020202020202066756E6374696F6E202820652029207B0D0A202020202020202020202020202020206765744F72616D6170735F7374617274526563745A6F6F6D282070526567696F6E496420293B0D0A20';
wwv_flow_api.g_varchar2_table(210) := '20202020202020202020207D0D0A2020202020202020293B0D0A2020202020202020746869732E674D6170546F6F6C4261722E616464427574746F6E28206C42745A6F6F6D20293B0D0A2020202020202020746869732E674D6170486173546F6F6C7320';
wwv_flow_api.g_varchar2_table(211) := '3D20747275653B0D0A202020207D0D0A0D0A202020206966202820704164646974696F6E616C2E73656172636828202F434952434C452F202920213D202D312029207B0D0A2020202020202020766172206C4274436972636C65203D206E6577204F4D2E';
wwv_flow_api.g_varchar2_table(212) := '636F6E74726F6C2E546F6F6C427574746F6E280D0A202020202020202020202020746869732E67526567696F6E4964202B20225F636972636C65746F6F6C222C0D0A2020202020202020202020204F4D2E636F6E74726F6C2E546F6F6C427574746F6E2E';
wwv_flow_api.g_varchar2_table(213) := '434F4D4D414E442C0D0A2020202020202020202020207B0D0A20202020202020202020202020202020627574746F6E49636F6E3A20704D6170536572766572486F7374202B204F52414D4150535F434F4E53545F49434F4E50415448202B202263697263';
wwv_flow_api.g_varchar2_table(214) := '6C652E676966222C0D0A20202020202020202020202020202020776964746820202020203A204F52414D4150535F434F4E53545F425453495A452C0D0A20202020202020202020202020202020686569676874202020203A204F52414D4150535F434F4E';
wwv_flow_api.g_varchar2_table(215) := '53545F425453495A450D0A2020202020202020202020207D0D0A2020202020202020293B0D0A20202020202020206C4274436972636C652E6164644C697374656E6572280D0A2020202020202020202020204F4D2E6576656E742E546F6F6C6261724576';
wwv_flow_api.g_varchar2_table(216) := '656E742E425554544F4E5F444F574E2C0D0A20202020202020202020202066756E6374696F6E202820652029207B0D0A202020202020202020202020202020206765744F72616D6170735F7374617274436972636C65282070526567696F6E496420293B';
wwv_flow_api.g_varchar2_table(217) := '0D0A2020202020202020202020207D0D0A2020202020202020293B0D0A2020202020202020746869732E674D6170546F6F6C4261722E616464427574746F6E28206C4274436972636C6520293B0D0A2020202020202020746869732E674D617048617354';
wwv_flow_api.g_varchar2_table(218) := '6F6F6C73203D20747275653B0D0A202020207D0D0A0D0A0D0A202020206966202820704164646974696F6E616C2E73656172636828202F5245444C494E452F202920213D202D312029207B0D0A2020202020202020766172206C42745265646C696E6520';
wwv_flow_api.g_varchar2_table(219) := '3D206E6577204F4D2E636F6E74726F6C2E546F6F6C427574746F6E280D0A202020202020202020202020746869732E67526567696F6E4964202B20225F7265646C696E65746F6F6C222C0D0A2020202020202020202020204F4D2E636F6E74726F6C2E54';
wwv_flow_api.g_varchar2_table(220) := '6F6F6C427574746F6E2E434F4D4D414E442C0D0A2020202020202020202020207B0D0A20202020202020202020202020202020627574746F6E49636F6E3A20704D6170536572766572486F7374202B204F52414D4150535F434F4E53545F49434F4E5041';
wwv_flow_api.g_varchar2_table(221) := '5448202B20227265646C696E652E676966222C0D0A20202020202020202020202020202020776964746820202020203A204F52414D4150535F434F4E53545F425453495A452C0D0A20202020202020202020202020202020686569676874202020203A20';
wwv_flow_api.g_varchar2_table(222) := '4F52414D4150535F434F4E53545F425453495A450D0A2020202020202020202020207D0D0A2020202020202020293B0D0A20202020202020206C42745265646C696E652E6164644C697374656E6572280D0A2020202020202020202020204F4D2E657665';
wwv_flow_api.g_varchar2_table(223) := '6E742E546F6F6C6261724576656E742E425554544F4E5F444F574E2C0D0A20202020202020202020202066756E6374696F6E202820652029207B0D0A202020202020202020202020202020206765744F72616D6170735F73746172745265644C696E6528';
wwv_flow_api.g_varchar2_table(224) := '2070526567696F6E496420293B0D0A2020202020202020202020207D0D0A2020202020202020293B0D0A2020202020202020746869732E674D6170546F6F6C4261722E616464427574746F6E28206C42745265646C696E6520293B0D0A20202020202020';
wwv_flow_api.g_varchar2_table(225) := '20746869732E674D6170486173546F6F6C73203D20747275653B0D0A202020207D0D0A0D0A202020206966202820704164646974696F6E616C2E73656172636828202F5343414C452F202920213D202D312029207B0D0A2020202020202020746869732E';
wwv_flow_api.g_varchar2_table(226) := '7363616C65626172203D206E6577204F4D2E636F6E74726F6C2E5363616C65426172280D0A2020202020202020202020207B20666F726D61743A20746869732E67556E697453797374656D2C20616E63686F72506F736974696F6E3A2034207D0D0A2020';
wwv_flow_api.g_varchar2_table(227) := '202020202020293B0D0A2020202020202020746869732E6D6170766965772E6164644D61704465636F726174696F6E2820746869732E7363616C6562617220293B0D0A202020207D0D0A0D0A20202020746869732E674D6170546F6F6C4261722E736574';
wwv_flow_api.g_varchar2_table(228) := '506F736974696F6E2820302E31352C20302E313020293B0D0A202020206966202820746869732E674D6170486173546F6F6C732029207B0D0A2020202020202020746869732E674D6170546F6F6C4261722E73657456697369626C652820747275652029';
wwv_flow_api.g_varchar2_table(229) := '3B0D0A202020207D20656C7365207B0D0A2020202020202020746869732E674D6170546F6F6C4261722E73657456697369626C65282066616C736520293B0D0A202020207D0D0A20202020746869732E6D6170766965772E616464546F6F6C4261722820';
wwv_flow_api.g_varchar2_table(230) := '746869732E674D6170546F6F6C42617220293B0D0A0D0A20202020746869732E6D6170766965772E6164644D61704465636F726174696F6E28206E6577204F4D2E636F6E74726F6C2E436F7079526967687428207B20227465787456616C7565223A2070';
wwv_flow_api.g_varchar2_table(231) := '436F707972696768742C2022616E63686F72506F736974696F6E223A2036207D202920293B0D0A0D0A202020202F2F20736574206D61702063656E74657220616E64207A6F6F6D206C6576656C0D0A20202020766172206C4D617043656E746572203D20';
wwv_flow_api.g_varchar2_table(232) := '6E6577204F4D2E67656F6D657472792E506F696E7428206C4D617043656E7465724C6F6E2C206C4D617043656E7465724C61742C206765744F72616D6170735F61646A7573745352494428206C4D617043656E74657253524944202920293B0D0A0D0A20';
wwv_flow_api.g_varchar2_table(233) := '2020206966202820216C496E69745A6F6F6D207C7C206C496E69745A6F6F6D203D3D2022222029207B0D0A20202020202020206C496E69745A6F6F6D203D20303B0D0A202020207D0D0A20202020746869732E6D6170766965772E7365744D617043656E';
wwv_flow_api.g_varchar2_table(234) := '746572416E645A6F6F6D4C6576656C28206C4D617043656E7465722C207061727365496E7428206C496E69745A6F6F6D20292C2066616C736520293B0D0A0D0A202020202F2F2062696E6420415045582052656672657368206576656E743A2052656672';
wwv_flow_api.g_varchar2_table(235) := '65736820746865206D61700D0A20202020617065782E6A51756572792820222322202B20746869732E67526567696F6E496420292E62696E64280D0A2020202020202020226170657872656672657368222C0D0A202020202020202066756E6374696F6E';
wwv_flow_api.g_varchar2_table(236) := '202829207B6765744D6170506C7567696E282070526567696F6E496420292E7265667265736853514C466F6928293B7D0D0A20202020293B0D0A0D0A202020202F2F20617474616368206576656E74206C697374656E6572730D0A20202020746869732E';
wwv_flow_api.g_varchar2_table(237) := '6D6170766965772E6164644C697374656E6572280D0A20202020202020204F4D2E6576656E742E4D6F7573654576656E742E4D4F5553455F434C49434B2C0D0A202020202020202066756E6374696F6E202820652029207B20617065782E6576656E742E';
wwv_flow_api.g_varchar2_table(238) := '747269676765722820617065782E6A51756572792820222322202B2070526567696F6E496420292C2022636F6D5F6F7261636C655F6F72616D61707368746D6C355F6D6F7573656C656674636C69636B2220293B207D0D0A20202020293B0D0A20202020';
wwv_flow_api.g_varchar2_table(239) := '746869732E6D6170766965772E6164644C697374656E6572280D0A20202020202020204F4D2E6576656E742E4D6F7573654576656E742E4D4F5553455F444F55424C455F434C49434B2C0D0A202020202020202066756E6374696F6E202820652029207B';
wwv_flow_api.g_varchar2_table(240) := '20617065782E6576656E742E747269676765722820617065782E6A51756572792820222322202B2070526567696F6E496420292C2022636F6D5F6F7261636C655F6F72616D61707368746D6C355F6D6F75736564626C636C69636B2220293B207D0D0A20';
wwv_flow_api.g_varchar2_table(241) := '202020293B0D0A20202020746869732E6D6170766965772E6164644C697374656E6572280D0A20202020202020204F4D2E6576656E742E4D6F7573654576656E742E4D4F5553455F52494748545F434C49434B2C0D0A202020202020202066756E637469';
wwv_flow_api.g_varchar2_table(242) := '6F6E202820652029207B20617065782E6576656E742E747269676765722820617065782E6A51756572792820222322202B2070526567696F6E496420292C2022636F6D5F6F7261636C655F6F72616D61707368746D6C355F6D6F7573657269676874636C';
wwv_flow_api.g_varchar2_table(243) := '69636B2220293B207D0D0A20202020293B0D0A0D0A20202020746869732E6D6170766965772E6164644C697374656E6572280D0A20202020202020204F4D2E6576656E742E4D61704576656E742E4D41505F524543454E54455245442C0D0A2020202020';
wwv_flow_api.g_varchar2_table(244) := '20202066756E6374696F6E202820652029207B6765744D6170506C7567696E282070526567696F6E496420292E66697265417065784576656E74524543454E54455228293B7D0D0A20202020293B0D0A0D0A20202020746869732E6D6170766965772E61';
wwv_flow_api.g_varchar2_table(245) := '64644C697374656E6572280D0A20202020202020204F4D2E6576656E742E4D61704576656E742E4D41505F41465445525F5A4F4F4D2C0D0A202020202020202066756E6374696F6E202820652029207B6765744D6170506C7567696E282070526567696F';
wwv_flow_api.g_varchar2_table(246) := '6E496420292E66697265417065784576656E745A4F4F4D4348414E474528293B7D0D0A20202020293B0D0A0D0A20202020746869732E6D6170766965772E6164644C697374656E6572280D0A20202020202020204F4D2E6576656E742E4D61704576656E';
wwv_flow_api.g_varchar2_table(247) := '742E4D41505F494E495449414C495A45442C0D0A202020202020202066756E6374696F6E202820652029207B77696E646F772E73657454696D656F7574282066756E6374696F6E202829207B6765744D6170506C7567696E282070526567696F6E496420';
wwv_flow_api.g_varchar2_table(248) := '292E66697265417065784576656E74494E495449414C495A4528293B7D2C2032303020297D0D0A20202020293B0D0A0D0A20202020666F7220282076617220666C203D20303B20666C203C20746869732E666F694C61796572732E6C656E6774683B2066';
wwv_flow_api.g_varchar2_table(249) := '6C2B2B2029207B0D0A2020202020202020746869732E6D6170766965772E6164644C617965722820746869732E666F694C61796572735B20666C205D20293B0D0A2020202020202020746869732E666F694C61796572735B20666C205D2E736574566973';
wwv_flow_api.g_varchar2_table(250) := '69626C6528207472756520293B0D0A202020207D0D0A0D0A20202020746869732E6D6170766965772E6164644C617965722820746869732E637573746F6D4D61726B657220293B0D0A20202020746869732E637573746F6D4D61726B65722E7365745669';
wwv_flow_api.g_varchar2_table(251) := '7369626C6528207472756520293B0D0A7D0D0A0D0A2F2F20746F67676C65206D61702074696C65206C617965722C206966206D756C7469706C6520657869737420616E6420627574746F6E20686173206265656E20636C69636B65640D0A417065784F72';
wwv_flow_api.g_varchar2_table(252) := '61636C654D617073506C7567696E2E70726F746F747970652E746F67676C654D61704C61796572203D2066756E6374696F6E202820704C617965722029207B0D0A20202020666F722028207661722069203D20303B2069203C20746869732E6D61706C61';
wwv_flow_api.g_varchar2_table(253) := '7965722E6C656E6774683B20692B2B2029207B0D0A2020202020202020746869732E6D61706C617965725B2069205D2E73657456697369626C65282066616C736520293B0D0A202020207D0D0A20202020746869732E6D61706C617965725B20704C6179';
wwv_flow_api.g_varchar2_table(254) := '6572205D2E73657456697369626C6528207472756520293B0D0A7D0D0A0D0A2F2F2053514C20464F49204C617965722066756E6374696F6E733A20526566726573682C2072656D6F76652C206765740D0A417065784F7261636C654D617073506C756769';
wwv_flow_api.g_varchar2_table(255) := '6E2E70726F746F747970652E7265667265736853514C466F69203D2066756E6374696F6E202829207B0D0A202020206966202820746869732E6753686F7753716C466F692029207B0D0A2020202020202020746869732E72656D6F766553514C466F6928';
wwv_flow_api.g_varchar2_table(256) := '293B0D0A2020202020202020746869732E67657453514C466F6928293B0D0A202020207D0D0A7D0D0A0D0A417065784F7261636C654D617073506C7567696E2E70726F746F747970652E72656D6F766553514C466F69203D2066756E6374696F6E202829';
wwv_flow_api.g_varchar2_table(257) := '207B0D0A20202020666F7220282076617220666C203D20303B20666C203C20746869732E666F694C61796572732E6C656E6774683B20666C2B2B2029207B0D0A20202020202020206966202820746869732E666F694C61796572735B20666C205D202920';
wwv_flow_api.g_varchar2_table(258) := '7B0D0A202020202020202020202020747279207B0D0A20202020202020202020202020202020746869732E666F694C61796572735B20666C205D2E72656D6F7665416C6C466561747572657328293B0D0A2020202020202020202020207D206361746368';
wwv_flow_api.g_varchar2_table(259) := '202820652029207B0D0A2020202020202020202020202020202069662028202476282022706465627567222029203D3D2022594553222029207B0D0A2020202020202020202020202020202020202020636F6E736F6C652E6C6F6728206520293B0D0A20';
wwv_flow_api.g_varchar2_table(260) := '2020202020202020202020202020207D0D0A2020202020202020202020207D0D0A20202020202020207D0D0A202020207D0D0A7D0D0A0D0A417065784F7261636C654D617073506C7567696E2E70726F746F747970652E67657453514C466F69203D2066';
wwv_flow_api.g_varchar2_table(261) := '756E6374696F6E202829207B0D0A20202020746869732E72656D6F766553514C466F6928293B0D0A20202020666F7220282076617220666C203D20303B20666C203C20746869732E666F694C61796572732E6C656E6774683B20666C2B2B2029207B0D0A';
wwv_flow_api.g_varchar2_table(262) := '2020202020202020746869732E666F694C61796572735B20666C205D2E656E61626C65436C7573746572696E67282066616C736520293B0D0A202020207D0D0A20202020766172206C506C67203D20746869733B0D0A0D0A20202020617065782E736572';
wwv_flow_api.g_varchar2_table(263) := '7665722E706C7567696E280D0A2020202020202020746869732E67506C7567696E4E616D652C0D0A20202020202020207B0D0A2020202020202020202020207830312020202020203A20746869732E6D6170766965772E676574556E6976657273652829';
wwv_flow_api.g_varchar2_table(264) := '2E6765745352494428292C0D0A2020202020202020202020207830322020202020203A204D6174682E726F756E642820746869732E6D6170766965772E6765744D617057696E646F77426F756E64696E67426F7828292E6765744D696E582829202A2031';
wwv_flow_api.g_varchar2_table(265) := '30303030303030303020292C0D0A2020202020202020202020207830332020202020203A204D6174682E726F756E642820746869732E6D6170766965772E6765744D617057696E646F77426F756E64696E67426F7828292E6765744D696E592829202A20';
wwv_flow_api.g_varchar2_table(266) := '3130303030303030303020292C0D0A2020202020202020202020207830342020202020203A204D6174682E726F756E642820746869732E6D6170766965772E6765744D617057696E646F77426F756E64696E67426F7828292E6765744D6178582829202A';
wwv_flow_api.g_varchar2_table(267) := '203130303030303030303020292C0D0A2020202020202020202020207830352020202020203A204D6174682E726F756E642820746869732E6D6170766965772E6765744D617057696E646F77426F756E64696E67426F7828292E6765744D617859282920';
wwv_flow_api.g_varchar2_table(268) := '2A203130303030303030303020292C0D0A2020202020202020202020207830362020202020203A20746869732E6753716C466F694C617A792C0D0A2020202020202020202020207830372020202020203A20746869732E6D6170766965772E6765744D61';
wwv_flow_api.g_varchar2_table(269) := '705A6F6F6D4C6576656C28292C0D0A2020202020202020202020207831302020202020203A2027464F4944415441272C0D0A202020202020202020202020705F646562756720203A2024762820277064656275672720292C0D0A20202020202020202020';
wwv_flow_api.g_varchar2_table(270) := '2020706167654974656D733A202820746869732E67506167654974656D735375626D697420262620746869732E67506167654974656D735375626D697420213D3D202222203F20746869732E67506167654974656D735375626D69742E73706C69742820';
wwv_flow_api.g_varchar2_table(271) := '222C222029203A2066616C7365202920202020202020207D2C0D0A20202020202020207B0D0A2020202020202020202020206572726F7220203A2066756E6374696F6E202820652029207B0D0A2020202020202020202020202020202069662028202476';
wwv_flow_api.g_varchar2_table(272) := '282022706465627567222029203D3D2022594553222029207B0D0A2020202020202020202020202020202020202020636F6E736F6C652E6C6F6728206520293B0D0A202020202020202020202020202020207D0D0A2020202020202020202020207D2C0D';
wwv_flow_api.g_varchar2_table(273) := '0A202020202020202020202020737563636573733A2066756E6374696F6E20282070446174612029207B0D0A2020202020202020202020202020202076617220666F693B0D0A20202020202020202020202020202020766172206C5F68746D6C3B0D0A20';
wwv_flow_api.g_varchar2_table(274) := '202020202020202020202020202020766172206C4D617856616C756520203D20303B0D0A20202020202020202020202020202020766172206C426172486569676874203D2032353B0D0A20202020202020202020202020202020766172206C4261725769';
wwv_flow_api.g_varchar2_table(275) := '64746820203D20363B0D0A20202020202020202020202020202020766172206C4A736F6E47656F6D3B0D0A20202020202020202020202020202020766172206C466F694C617965723B0D0A20202020202020202020202020202020766172206C47656F6D';
wwv_flow_api.g_varchar2_table(276) := '3B0D0A20202020202020202020202020202020766172206C4D61726B65725374796C653B0D0A20202020202020202020202020202020766172206C496D616765436F6465203D206C506C672E6746696C65507265666978202B20227472616E73702E706E';
wwv_flow_api.g_varchar2_table(277) := '67223B0D0A20202020202020202020202020202020766172206C53686F77464F492020203D2066616C73653B0D0A0D0A20202020202020202020202020202020666F722028207661722069203D20303B2069203C2070446174612E726F772E6C656E6774';
wwv_flow_api.g_varchar2_table(278) := '683B20692B2B2029207B0D0A2020202020202020202020202020202020202020666F692020202020203D205B5D3B0D0A20202020202020202020202020202020202020206C47656F6D202020203D205B5D3B0D0A20202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(279) := '202020206C53686F77464F49203D20747275653B0D0A0D0A20202020202020202020202020202020202020202F2F20636865636B20776865746865722074686520464F49206973206265696E6720646973706C6179656420696E20746865206375727265';
wwv_flow_api.g_varchar2_table(280) := '6E74205A6F6F6D204C6576656C202E2E2E0D0A202020202020202020202020202020202020202069662028206C506C672E6753716C466F694C617A79203D3D202759272029207B0D0A202020202020202020202020202020202020202020202020696620';
wwv_flow_api.g_varchar2_table(281) := '282070446174612E726F775B2069205D2E4D494E5A4F4F4D2029207B0D0A2020202020202020202020202020202020202020202020202020202069662028206C506C672E6D6170766965772E6765744D61705A6F6F6D4C6576656C2829203C2070617273';
wwv_flow_api.g_varchar2_table(282) := '65496E74282070446174612E726F775B2069205D2E4D494E5A4F4F4D20292029207B0D0A20202020202020202020202020202020202020202020202020202020202020206C53686F77464F49203D2066616C73653B0D0A20202020202020202020202020';
wwv_flow_api.g_varchar2_table(283) := '2020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020207D0D0A202020202020202020202020202020202020202020202020696620282070446174612E726F775B2069205D2E4D41585A4F4F4D2029207B';
wwv_flow_api.g_varchar2_table(284) := '0D0A2020202020202020202020202020202020202020202020202020202069662028206C506C672E6D6170766965772E6765744D61705A6F6F6D4C6576656C2829203E207061727365496E74282070446174612E726F775B2069205D2E4D41585A4F4F4D';
wwv_flow_api.g_varchar2_table(285) := '20292029207B0D0A20202020202020202020202020202020202020202020202020202020202020206C53686F77464F49203D2066616C73653B0D0A202020202020202020202020202020202020202020202020202020207D0D0A20202020202020202020';
wwv_flow_api.g_varchar2_table(286) := '20202020202020202020202020207D0D0A20202020202020202020202020202020202020207D0D0A0D0A202020202020202020202020202020202020202069662028206C53686F77464F492029207B0D0A20202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(287) := '2020202020696620282070446174612E726F775B2069205D2E4C415945522029207B0D0A20202020202020202020202020202020202020202020202020202020696620282070446174612E726F775B2069205D2E4C415945522E746F5570706572436173';
wwv_flow_api.g_varchar2_table(288) := '652829203D3D202248454154222029207B0D0A20202020202020202020202020202020202020202020202020202020202020206C466F694C61796572202020203D20303B0D0A202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(289) := '20206C506C672E686561746D6170203D20747275653B0D0A202020202020202020202020202020202020202020202020202020207D20656C7365207B0D0A20202020202020202020202020202020202020202020202020202020202020206C466F694C61';
wwv_flow_api.g_varchar2_table(290) := '796572203D207061727365496E74282070446174612E726F775B2069205D2E4C4159455220293B0D0A2020202020202020202020202020202020202020202020202020202020202020696620282069734E614E28206C466F694C6179657220292029207B';
wwv_flow_api.g_varchar2_table(291) := '0D0A2020202020202020202020202020202020202020202020202020202020202020202020206C466F694C61796572203D20313B0D0A20202020202020202020202020202020202020202020202020202020202020207D0D0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(292) := '20202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020207D20656C7365207B0D0A202020202020202020202020202020202020202020202020202020206C466F694C61796572203D20313B0D0A2020';
wwv_flow_api.g_varchar2_table(293) := '202020202020202020202020202020202020202020207D0D0A0D0A2020202020202020202020202020202020202020202020202F2F204275696C64207468652067656F6D6574726965730D0A202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(294) := '6C4A736F6E47656F6D203D2070446174612E726F775B2069205D2E47454F4D455452593B0D0A20202020202020202020202020202020202020202020202069662028206C4A736F6E47656F6D20213D206E756C6C2029207B0D0A20202020202020202020';
wwv_flow_api.g_varchar2_table(295) := '20202020202020202020202020202020202069662028206C4A736F6E47656F6D2E73646F5F6774797065203D3D20323030312029207B0D0A20202020202020202020202020202020202020202020202020202020202020206C47656F6D5B2030205D203D';
wwv_flow_api.g_varchar2_table(296) := '206E6577204F4D2E67656F6D657472792E506F696E74280D0A2020202020202020202020202020202020202020202020202020202020202020202020207061727365466C6F617428206C4A736F6E47656F6D2E73646F5F706F696E742E7820292C0D0A20';
wwv_flow_api.g_varchar2_table(297) := '20202020202020202020202020202020202020202020202020202020202020202020207061727365466C6F617428206C4A736F6E47656F6D2E73646F5F706F696E742E7920292C0D0A202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(298) := '2020202020202020207061727365496E7428206C4A736F6E47656F6D2E73646F5F7372696420290D0A2020202020202020202020202020202020202020202020202020202020202020293B0D0A2020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(299) := '20202020207D0D0A2020202020202020202020202020202020202020202020202020202069662028206C4A736F6E47656F6D2E73646F5F6774797065203D3D20323030322029207B0D0A2020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(300) := '2020202020206C47656F6D5B2030205D203D206E6577204F4D2E67656F6D657472792E4C696E65537472696E67280D0A2020202020202020202020202020202020202020202020202020202020202020202020206C4A736F6E47656F6D2E73646F5F6F72';
wwv_flow_api.g_varchar2_table(301) := '64696E617465732C0D0A2020202020202020202020202020202020202020202020202020202020202020202020206C4A736F6E47656F6D2E73646F5F737269640D0A2020202020202020202020202020202020202020202020202020202020202020293B';
wwv_flow_api.g_varchar2_table(302) := '0D0A202020202020202020202020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020202020202069662028206C4A736F6E47656F6D2E73646F5F6774797065203D3D20323030332029207B0D0A20';
wwv_flow_api.g_varchar2_table(303) := '2020202020202020202020202020202020202020202020202020202020202069662028206C4A736F6E47656F6D2E73646F5F656C656D5F696E666F2E6C656E677468203D3D20332029207B0D0A2020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(304) := '2020202020202020202020202069662028206C4A736F6E47656F6D2E73646F5F656C656D5F696E666F5B2032205D203D3D20332029207B0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020206C4765';
wwv_flow_api.g_varchar2_table(305) := '6F6D5B2030205D203D206E6577204F4D2E67656F6D657472792E52656374616E676C65280D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020206C4A736F6E47656F6D2E73646F5F6F726469';
wwv_flow_api.g_varchar2_table(306) := '6E617465735B2030205D2C0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020206C4A736F6E47656F6D2E73646F5F6F7264696E617465735B2031205D2C0D0A202020202020202020202020';
wwv_flow_api.g_varchar2_table(307) := '20202020202020202020202020202020202020202020202020202020202020206C4A736F6E47656F6D2E73646F5F6F7264696E617465735B2032205D2C0D0A20202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(308) := '202020202020206C4A736F6E47656F6D2E73646F5F6F7264696E617465735B2033205D2C0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020206C4A736F6E47656F6D2E73646F5F73726964';
wwv_flow_api.g_varchar2_table(309) := '0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020293B0D0A2020202020202020202020202020202020202020202020202020202020202020202020207D20656C7365207B0D0A2020202020202020';
wwv_flow_api.g_varchar2_table(310) := '20202020202020202020202020202020202020202020202020202020202020206C47656F6D5B2030205D203D206E6577204F4D2E67656F6D657472792E506F6C79676F6E280D0A2020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(311) := '2020202020202020202020202020205B206C4A736F6E47656F6D2E73646F5F6F7264696E61746573205D2C0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020206C4A736F6E47656F6D2E73';
wwv_flow_api.g_varchar2_table(312) := '646F5F737269640D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020293B0D0A2020202020202020202020202020202020202020202020202020202020202020202020207D0D0A2020202020202020';
wwv_flow_api.g_varchar2_table(313) := '2020202020202020202020202020202020202020202020207D20656C7365207B0D0A202020202020202020202020202020202020202020202020202020202020202020202020766172206C52696E677320203D205B5D3B0D0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(314) := '202020202020202020202020202020202020202020202020206C52696E67735B2030205D203D206C4A736F6E47656F6D2E73646F5F6F7264696E617465732E736C6963652820302C206C4A736F6E47656F6D2E73646F5F656C656D5F696E666F5B203320';
wwv_flow_api.g_varchar2_table(315) := '5D20293B0D0A202020202020202020202020202020202020202020202020202020202020202020202020666F722028207661722072203D20333B2072203C206C4A736F6E47656F6D2E73646F5F656C656D5F696E666F2E6C656E6774683B2072203D2072';
wwv_flow_api.g_varchar2_table(316) := '202B20332029207B0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202069662028202872202B203329203C3D206C4A736F6E47656F6D2E73646F5F656C656D5F696E666F2E6C656E6774682029207B';
wwv_flow_api.g_varchar2_table(317) := '0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020206C52696E67735B206C52696E67732E6C656E677468205D203D206C4A736F6E47656F6D2E73646F5F6F7264696E617465732E736C6963';
wwv_flow_api.g_varchar2_table(318) := '65280D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020206C4A736F6E47656F6D2E73646F5F656C656D5F696E666F5B2072205D202D20312C0D0A20202020202020202020202020';
wwv_flow_api.g_varchar2_table(319) := '20202020202020202020202020202020202020202020202020202020202020202020206C4A736F6E47656F6D2E73646F5F656C656D5F696E666F5B2072202B2033205D202D20310D0A202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(320) := '2020202020202020202020202020202020293B0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020207D20656C7365207B0D0A2020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(321) := '2020202020202020202020202020206C52696E67735B206C52696E67732E6C656E677468205D203D206C4A736F6E47656F6D2E73646F5F6F7264696E617465732E736C69636528206C4A736F6E47656F6D2E73646F5F656C656D5F696E666F5B2072205D';
wwv_flow_api.g_varchar2_table(322) := '202D203120293B0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020202020202020202020202020207D0D0A202020202020202020';
wwv_flow_api.g_varchar2_table(323) := '2020202020202020202020202020202020202020202020202020206C47656F6D5B2030205D203D206E6577204F4D2E67656F6D657472792E506F6C79676F6E280D0A20202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(324) := '2020202020206C52696E67732C0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020206C4A736F6E47656F6D2E73646F5F737269640D0A20202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(325) := '2020202020202020202020293B0D0A20202020202020202020202020202020202020202020202020202020202020207D0D0A202020202020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(326) := '20202020202020202069662028206C4A736F6E47656F6D2E73646F5F6774797065203D3D20323030372029207B0D0A2020202020202020202020202020202020202020202020202020202020202020766172206C52696E6773203D205B5D3B0D0A0D0A20';
wwv_flow_api.g_varchar2_table(327) := '20202020202020202020202020202020202020202020202020202020202020666F722028207661722072203D20303B2072203C206C4A736F6E47656F6D2E73646F5F656C656D5F696E666F2E6C656E6774683B2072203D2072202B20332029207B0D0A20';
wwv_flow_api.g_varchar2_table(328) := '202020202020202020202020202020202020202020202020202020202020202020202069662028206C4A736F6E47656F6D2E73646F5F656C656D5F696E666F5B2072202B2031205D203D3D20313030332029207B0D0A2020202020202020202020202020';
wwv_flow_api.g_varchar2_table(329) := '20202020202020202020202020202020202020202020202020202F2F206E657720506F6C79676F6E207374617274730D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020696620282072203E203020';
wwv_flow_api.g_varchar2_table(330) := '29207B0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020206C47656F6D5B206C47656F6D2E6C656E677468205D203D206E6577204F4D2E67656F6D657472792E506F6C79676F6E28206C52';
wwv_flow_api.g_varchar2_table(331) := '696E67732C206C4A736F6E47656F6D2E73646F5F7372696420293B0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(332) := '2020202020202020202020206C52696E6773203D205B5D3B0D0A2020202020202020202020202020202020202020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(333) := '2069662028202872202B203329203C206C4A736F6E47656F6D2E73646F5F656C656D5F696E666F2E6C656E6774682029207B0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020206C52696E67735B20';
wwv_flow_api.g_varchar2_table(334) := '6C52696E67732E6C656E677468205D203D206C4A736F6E47656F6D2E73646F5F6F7264696E617465732E736C696365280D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020206C4A736F6E47';
wwv_flow_api.g_varchar2_table(335) := '656F6D2E73646F5F656C656D5F696E666F5B2072205D202D20312C0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020206C4A736F6E47656F6D2E73646F5F656C656D5F696E666F5B207220';
wwv_flow_api.g_varchar2_table(336) := '2B2033205D202D20310D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020293B0D0A2020202020202020202020202020202020202020202020202020202020202020202020207D20656C7365207B0D';
wwv_flow_api.g_varchar2_table(337) := '0A202020202020202020202020202020202020202020202020202020202020202020202020202020206C52696E67735B206C52696E67732E6C656E677468205D203D206C4A736F6E47656F6D2E73646F5F6F7264696E617465732E736C69636528206C4A';
wwv_flow_api.g_varchar2_table(338) := '736F6E47656F6D2E73646F5F656C656D5F696E666F5B2072205D202D203120293B0D0A2020202020202020202020202020202020202020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(339) := '2020202020207D0D0A20202020202020202020202020202020202020202020202020202020202020206C47656F6D5B206C47656F6D2E6C656E677468205D203D206E6577204F4D2E67656F6D657472792E506F6C79676F6E28206C52696E67732C206C4A';
wwv_flow_api.g_varchar2_table(340) := '736F6E47656F6D2E73646F5F7372696420293B0D0A202020202020202020202020202020202020202020202020202020207D0D0A0D0A202020202020202020202020202020202020202020202020202020202F2F205374617274206275696C64696E6720';
wwv_flow_api.g_varchar2_table(341) := '7468652046656174757265730D0A2020202020202020202020202020202020202020202020202020202069662028206C4A736F6E47656F6D2E73646F5F6774797065203D3D2032303032207C7C206C4A736F6E47656F6D2E73646F5F6774797065203D3D';
wwv_flow_api.g_varchar2_table(342) := '20323030332029207B0D0A2020202020202020202020202020202020202020202020202020202020202020666F695B2030205D203D206E6577204F4D2E46656174757265280D0A2020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(343) := '2020202020202022524547494F4E464F495F22202B2070446174612E726F775B2069205D2E49442C0D0A2020202020202020202020202020202020202020202020202020202020202020202020206C47656F6D5B2030205D2C0D0A202020202020202020';
wwv_flow_api.g_varchar2_table(344) := '2020202020202020202020202020202020202020202020202020207B2072656E646572696E675374796C653A206C506C672E675374796C65735B2070446174612E726F775B2069205D2E5354594C45205D207D0D0A202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(345) := '2020202020202020202020202020202020293B0D0A202020202020202020202020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020202020202069662028206C4A736F6E47656F6D2E73646F5F67';
wwv_flow_api.g_varchar2_table(346) := '74797065203D3D20323030372029207B0D0A2020202020202020202020202020202020202020202020202020202020202020666F722028207661722067203D20303B2067203C206C47656F6D2E6C656E6774683B20672B2B2029207B0D0A202020202020';
wwv_flow_api.g_varchar2_table(347) := '202020202020202020202020202020202020202020202020202020202020666F695B2067205D203D206E6577204F4D2E46656174757265280D0A202020202020202020202020202020202020202020202020202020202020202020202020202020202252';
wwv_flow_api.g_varchar2_table(348) := '4547494F4E464F495F22202B2070446174612E726F775B2069205D2E4944202B20225F22202B20672C0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020206C47656F6D5B2067205D2C0D0A20202020';
wwv_flow_api.g_varchar2_table(349) := '2020202020202020202020202020202020202020202020202020202020202020202020207B2072656E646572696E675374796C653A206C506C672E675374796C65735B2070446174612E726F775B2069205D2E5354594C45205D207D0D0A202020202020';
wwv_flow_api.g_varchar2_table(350) := '202020202020202020202020202020202020202020202020202020202020293B0D0A20202020202020202020202020202020202020202020202020202020202020207D0D0A202020202020202020202020202020202020202020202020202020207D0D0A';
wwv_flow_api.g_varchar2_table(351) := '0D0A2020202020202020202020202020202020202020202020202020202069662028206C4A736F6E47656F6D2E73646F5F6774797065203D3D20323030312029207B0D0A2020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(352) := '696620282070446174612E726F775B2069205D2E5354594C452E746F5570706572436173652829203D3D2022494D414745222029207B0D0A202020202020202020202020202020202020202020202020202020202020202020202020666F695B2030205D';
wwv_flow_api.g_varchar2_table(353) := '203D206E6577204F4D2E46656174757265280D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202022524547494F4E464F495F22202B2070446174612E726F775B2069205D2E49442C0D0A2020202020';
wwv_flow_api.g_varchar2_table(354) := '20202020202020202020202020202020202020202020202020202020202020202020206C47656F6D5B2030205D2C0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020207B0D0A202020202020202020';
wwv_flow_api.g_varchar2_table(355) := '202020202020202020202020202020202020202020202020202020202020202020202072656E646572696E675374796C653A206E6577204F4D2E7374796C652E4D61726B6572280D0A202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(356) := '2020202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207372632020202020203A2070446174612E726F775B206920';
wwv_flow_api.g_varchar2_table(357) := '5D2E494D41474555524C2C0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020746578745374796C653A207B0D0A202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(358) := '202020202020202020202020202020202020202020202020202020202020202020202066696C6C3A2022626C61636B222C0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(359) := '20202020202020666F6E7453697A653A2031322C0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020666F6E745765696768743A204F4D2E546578742E464F';
wwv_flow_api.g_varchar2_table(360) := '4E545745494748545F424F4C440D0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207D0D0A202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(361) := '2020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020290D0A2020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(362) := '20202020202020207D0D0A202020202020202020202020202020202020202020202020202020202020202020202020293B0D0A20202020202020202020202020202020202020202020202020202020202020207D20656C7365207B0D0A0D0A2020202020';
wwv_flow_api.g_varchar2_table(363) := '20202020202020202020202020202020202020202020202020202020202020696620282070446174612E726F775B2069205D2E4D41524B455253495A452026262070446174612E726F775B2069205D2E4D41524B455253495A4520213D3D202222202920';
wwv_flow_api.g_varchar2_table(364) := '7B0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020696620282070446174612E726F775B2069205D2E4D41524B455253495A452E7375627374722820302C203120292E746F557070657243617365';
wwv_flow_api.g_varchar2_table(365) := '2829203D3D3D202243222029207B0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020206C4D61726B65725374796C65203D206E6577204F4D2E7374796C652E4D61726B6572280D0A202020';
wwv_flow_api.g_varchar2_table(366) := '2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(367) := '202020202020202020202020202020202020202020202020202020202020202020202020766563746F72446566203A205B7B0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(368) := '202020202020202020202020202020202020202020202020202020202020202020202020207368617065203A207B0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(369) := '2020202020202020202020202020202020202020202020202020202020202020202020202020202020202074797065202020202020203A2022636972636C65222C0D0A202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(370) := '202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202063782020202020202020203A20302C0D0A202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(371) := '202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202063792020202020202020203A20302C0D0A202020202020202020';
wwv_flow_api.g_varchar2_table(372) := '202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202077696474682020202020203A2070';
wwv_flow_api.g_varchar2_table(373) := '61727365496E74282070446174612E726F775B2069205D2E4D41524B455253495A452E737562737472282031202920292C0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(374) := '2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202068656967687420202020203A207061727365496E74282070446174612E726F775B2069205D2E4D41524B455253495A452E7375627374';
wwv_flow_api.g_varchar2_table(375) := '7228203120292029207D2C0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207374';
wwv_flow_api.g_varchar2_table(376) := '796C65203A206C506C672E675374796C65735B70446174612E726F775B2069205D2E5354594C452E746F4C6F7765724361736528295D207D5D2C0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(377) := '202020202020202020202020202020202020202020202020202020202020746578744F66667365743A207B20783A202D302C20793A202D3138207D2C0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(378) := '2020202020202020202020202020202020202020202020202020202020202020746578745374796C65203A207B0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(379) := '20202020202020202020202020202020202020202066696C6C3A2022626C61636B222C0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(380) := '2020202020202020202020666F6E7453697A653A2031322C0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(381) := '666F6E745765696768743A204F4D2E546578742E464F4E545745494748545F424F4C44207D207D293B0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020207D20656C7365207B0D0A20202020202020';
wwv_flow_api.g_varchar2_table(382) := '202020202020202020202020202020202020202020202020202020202020202020202020206C4D61726B65725374796C65203D206E6577204F4D2E7374796C652E4D61726B6572280D0A2020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(383) := '202020202020202020202020202020202020202020202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(384) := '20202020202020202020202020766563746F72446566203A205B7B0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(385) := '20202020202020202020202020207368617065203A207B0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(386) := '202020202020202020202020202020202020202074797065202020202020203A202272656374616E676C65222C0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(387) := '20202020202020202020202020202020202020202020202020202020202020202020202020202020202078202020202020202020203A20302C0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(388) := '20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202079202020202020202020203A20302C0D0A2020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(389) := '20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202077696474682020202020203A207061727365496E74282070446174612E726F775B20';
wwv_flow_api.g_varchar2_table(390) := '69205D2E4D41524B455253495A452E737562737472282031202920292C0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(391) := '202020202020202020202020202020202020202020202020202068656967687420202020203A207061727365496E74282070446174612E726F775B2069205D2E4D41524B455253495A452E73756273747228203120292029207D2C0D0A20202020202020';
wwv_flow_api.g_varchar2_table(392) := '2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207374796C65203A206C506C672E675374796C65735B70';
wwv_flow_api.g_varchar2_table(393) := '446174612E726F775B2069205D2E5354594C452E746F4C6F7765724361736528295D207D5D2C0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(394) := '20202020202020202020746578744F66667365743A207B20783A202D302C20793A202D3138207D2C0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(395) := '202020202020202020202020746578745374796C65203A207B0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(396) := '2066696C6C3A2022626C61636B222C0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020666F6E7453697A653A';
wwv_flow_api.g_varchar2_table(397) := '2031322C0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020666F6E745765696768743A204F4D2E546578742E';
wwv_flow_api.g_varchar2_table(398) := '464F4E545745494748545F424F4C44207D207D293B0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(399) := '20207D20656C7365207B0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020206C4D61726B65725374796C65203D206E6577204F4D2E7374796C652E4D61726B6572280D0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(400) := '2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(401) := '2020202020202020202020202020202020202020737263202020202020203A206C506C672E6746696C65507265666978202B20226D2D22202B2070446174612E726F775B2069205D2E5354594C452E746F4C6F776572436173652829202B20222E706E67';
wwv_flow_api.g_varchar2_table(402) := '222C0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020784F66667365742020203A20302C0D0A2020202020202020202020202020';
wwv_flow_api.g_varchar2_table(403) := '20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020794F66667365742020203A20302C0D0A2020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(404) := '20202020202020202020202020202020202020202020202020202020202020202020746578744F66667365743A207B20783A202D302C20793A202D3138207D2C0D0A20202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(405) := '2020202020202020202020202020202020202020202020202020202020202020746578745374796C65203A207B0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(406) := '202020202020202020202020202020202066696C6C3A2022626C61636B222C0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(407) := '202020666F6E7453697A653A2031322C0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020666F6E745765696768743A20';
wwv_flow_api.g_varchar2_table(408) := '4F4D2E546578742E464F4E545745494748545F424F4C44207D207D293B0D0A2020202020202020202020202020202020202020202020202020202020202020202020207D0D0A0D0A20202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(409) := '2020202020202020666F695B2030205D203D206E6577204F4D2E46656174757265280D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202022524547494F4E464F495F22202B2070446174612E726F77';
wwv_flow_api.g_varchar2_table(410) := '5B2069205D2E49442C0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020206C47656F6D5B2030205D2C0D0A202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(411) := '202020207B0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202072656E646572696E675374796C653A206C4D61726B65725374796C650D0A20202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(412) := '2020202020202020202020202020202020202020207D0D0A202020202020202020202020202020202020202020202020202020202020202020202020293B0D0A20202020202020202020202020202020202020202020202020202020202020207D0D0A20';
wwv_flow_api.g_varchar2_table(413) := '2020202020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020202020202020202020202020202020666F722028207661722066203D20303B2066203C20666F692E6C656E6774683B20662B2B2029207B0D0A';
wwv_flow_api.g_varchar2_table(414) := '2020202020202020202020202020202020202020202020202020202020202020696620282070446174612E726F775B2069205D2E4D41524B4552544558542029207B0D0A2020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(415) := '20202020666F695B2066205D2E7365744D61726B657254657874282070446174612E726F775B2069205D2E4D41524B45525445585420293B0D0A20202020202020202020202020202020202020202020202020202020202020207D0D0A20202020202020';
wwv_flow_api.g_varchar2_table(416) := '20202020202020202020202020202020202020202020202020696620282070446174612E726F775B2069205D2E494E464F5449502029207B0D0A202020202020202020202020202020202020202020202020202020202020202020202020666F695B2066';
wwv_flow_api.g_varchar2_table(417) := '205D2E6C6162656C203D206765744F72616D6170735F65736361706548544D4C282070446174612E726F775B2069205D2E494E464F5449502C206C506C672E6745736361706548544D4C20293B0D0A202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(418) := '20202020202020202020207D0D0A2020202020202020202020202020202020202020202020202020202020202020696620282070446174612E726F775B2069205D2E494E464F544558542029207B0D0A2020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(419) := '20202020202020202020202020202020666F695B2066205D2E637573746F6D436F6E74656E74203D207B0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202068746D6C537472696E673A206765744F';
wwv_flow_api.g_varchar2_table(420) := '72616D6170735F65736361706548544D4C282070446174612E726F775B2069205D2E494E464F544558542C206C506C672E6745736361706548544D4C20292C0D0A2020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(421) := '20202020206D6170526567696F6E203A206C506C672E67526567696F6E49640D0A2020202020202020202020202020202020202020202020202020202020202020202020207D3B0D0A202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(422) := '202020202020202020666F695B2066205D2E6164644C697374656E6572280D0A202020202020202020202020202020202020202020202020202020202020202020202020202020204F4D2E6576656E742E4D6F7573654576656E742E4D4F5553455F434C';
wwv_flow_api.g_varchar2_table(423) := '49434B2C0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202066756E6374696F6E202820652029207B0D0A202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(424) := '20202020202020206765744D6170506C7567696E2820652E7461726765742E637573746F6D436F6E74656E742E6D6170526567696F6E20292E6D6170766965772E646973706C6179496E666F57696E646F77280D0A202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(425) := '2020202020202020202020202020202020202020202020202020202020202020206765744D6170506C7567696E2820652E7461726765742E637573746F6D436F6E74656E742E6D6170526567696F6E20292E6D6170766965772E676574437572736F724C';
wwv_flow_api.g_varchar2_table(426) := '6F636174696F6E28292C0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020652E7461726765742E637573746F6D436F6E74656E742E68746D6C537472696E672C0D0A20202020';
wwv_flow_api.g_varchar2_table(427) := '20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207B0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202077';
wwv_flow_api.g_varchar2_table(428) := '69647468203A206765744D6170506C7567696E2820652E7461726765742E637573746F6D436F6E74656E742E6D6170526567696F6E20292E6753716C466F69496E666F572C0D0A2020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(429) := '20202020202020202020202020202020202020202020206865696768743A206765744D6170506C7567696E2820652E7461726765742E637573746F6D436F6E74656E742E6D6170526567696F6E20292E6753716C466F69496E666F480D0A202020202020';
wwv_flow_api.g_varchar2_table(430) := '2020202020202020202020202020202020202020202020202020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020293B0D0A20202020202020';
wwv_flow_api.g_varchar2_table(431) := '20202020202020202020202020202020202020202020202020202020202020202020202020617065782E6576656E742E74726967676572280D0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(432) := '202020202020617065782E6A51756572792820222322202B206C506C672E67526567696F6E496420292C0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202022636F6D5F6F7261';
wwv_flow_api.g_varchar2_table(433) := '636C655F6F72616D61707368746D6C355F666F69636C69636B222C0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020652E7461726765740D0A20202020202020202020202020';
wwv_flow_api.g_varchar2_table(434) := '20202020202020202020202020202020202020202020202020202020202020293B0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(435) := '2020202020202020202020202020293B0D0A20202020202020202020202020202020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020202020202020202020747279207B0D0A2020202020202020';
wwv_flow_api.g_varchar2_table(436) := '2020202020202020202020202020202020202020202020202020202069662028206C506C672E666F694C61796572735B206C466F694C61796572205D2E67657446656174757265282022524547494F4E464F495F22202B2070446174612E726F775B2069';
wwv_flow_api.g_varchar2_table(437) := '205D2E49442029203D3D206E756C6C2029207B0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202069662028206C506C672E686561746D6170202626206C466F694C61796572203D3D203020262620';
wwv_flow_api.g_varchar2_table(438) := '666F695B2066205D2E67657447656F6D6574727928292E67657454797065282920213D2022506F696E74222029207B0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020207D20656C7365207B0D0A20';
wwv_flow_api.g_varchar2_table(439) := '202020202020202020202020202020202020202020202020202020202020202020202020202020202020206C506C672E666F694C61796572735B206C466F694C61796572205D2E616464466561747572652820666F695B2066205D20293B0D0A20202020';
wwv_flow_api.g_varchar2_table(440) := '2020202020202020202020202020202020202020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020202020202020202020202020207D20656C7365207B0D0A202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(441) := '2020202020202020202020202020202020202020202020202069662028202476282022706465627567222029203D3D2022594553222029207B0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(442) := '202020636F6E736F6C652E6C6F672820224665617475726520776974682049442022202B2022524547494F4E464F495F22202B2070446174612E726F775B2069205D2E4944202B202220636F756C64206E6F74206265206164646564202D206475706C69';
wwv_flow_api.g_varchar2_table(443) := '63617465204944212220293B0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020636F6E736F6C652E6C6F672820666F695B2066205D20293B0D0A20202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(444) := '2020202020202020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020202020202020202020202020202020202020207D20';
wwv_flow_api.g_varchar2_table(445) := '6361746368202820652029207B0D0A20202020202020202020202020202020202020202020202020202020202020202020202069662028202476282022706465627567222029203D3D2022594553222029207B0D0A202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(446) := '20202020202020202020202020202020202020202020202020636F6E736F6C652E6C6F6728206520293B0D0A2020202020202020202020202020202020202020202020202020202020202020202020207D0D0A2020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(447) := '2020202020202020202020202020207D0D0A202020202020202020202020202020202020202020202020202020207D0D0A2020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020202020202020207D0D0A20';
wwv_flow_api.g_varchar2_table(448) := '2020202020202020202020202020207D0D0A0D0A2020202020202020202020202020202069662028206C506C672E686561746D61702029207B0D0A20202020202020202020202020202020202020206C506C672E666F694C61796572735B2030205D2E73';
wwv_flow_api.g_varchar2_table(449) := '657452656E646572696E675374796C6528206E6577204F4D2E7374796C652E486561744D617028204F52414D4150535F434F4E53545F484541545354594C45202920293B0D0A20202020202020202020202020202020202020206C506C672E666F694C61';
wwv_flow_api.g_varchar2_table(450) := '796572735B2030205D2E72656472617728293B0D0A202020202020202020202020202020207D0D0A0D0A2020202020202020202020202020202069662028202476282022706465627567222029203D3D2022594553222029207B0D0A2020202020202020';
wwv_flow_api.g_varchar2_table(451) := '202020202020202020202020666F722028207661722069203D20303B2069203C206C506C672E666F694C61796572732E6C656E6774683B20692B2B2029207B0D0A202020202020202020202020202020202020202020202020636F6E736F6C652E6C6F67';
wwv_flow_api.g_varchar2_table(452) := '2820224C617965722022202B2069202B20223A2022202B206C506C672E666F694C61796572735B2069205D2E676574416C6C466561747572657328292E6C656E67746820293B0D0A20202020202020202020202020202020202020207D0D0A2020202020';
wwv_flow_api.g_varchar2_table(453) := '20202020202020202020207D0D0A0D0A202020202020202020202020202020202F2F20464F4920436C7573746572696E6720436F64650D0A2020202020202020202020202020202069662028206C506C672E666F69436C7573746572732029207B0D0A20';
wwv_flow_api.g_varchar2_table(454) := '20202020202020202020202020202020202020666F7220282076617220666C203D20303B20666C203C206C506C672E666F694C61796572732E6C656E6774683B20666C2B2B2029207B0D0A2020202020202020202020202020202020202020202020206C';
wwv_flow_api.g_varchar2_table(455) := '506C672E666F694C61796572735B20666C205D2E656E61626C65436C7573746572696E67280D0A20202020202020202020202020202020202020202020202020202020747275652C0D0A2020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(456) := '20207B0D0A20202020202020202020202020202020202020202020202020202020202020207468726573686F6C642020202020202020203A2035302C0D0A2020202020202020202020202020202020202020202020202020202020202020636C75737465';
wwv_flow_api.g_varchar2_table(457) := '725374796C652020202020203A206E6577204F4D2E7374796C652E4D61726B6572280D0A2020202020202020202020202020202020202020202020202020202020202020202020207B0D0A20202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(458) := '202020202020202020202020202020737263202020202020203A206C506C672E6746696C65507265666978202B20226D2D636C75737465722E706E67222C0D0A202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(459) := '20202020784F66667365742020203A20302C0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020794F66667365742020203A20302C0D0A202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(460) := '20202020202020202020202020202020746578744F66667365743A207B20783A202D302C20793A203138207D2C0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020746578745374796C65203A207B';
wwv_flow_api.g_varchar2_table(461) := '2066696C6C3A2022626C61636B222C20666F6E7453697A653A2031342C20666F6E745765696768743A204F4D2E546578742E464F4E545745494748545F424F4C44207D0D0A20202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(462) := '20202020207D0D0A2020202020202020202020202020202020202020202020202020202020202020292C0D0A20202020202020202020202020202020202020202020202020202020202020206D696E506F696E74436C6F756420202020203A20352C0D0A';
wwv_flow_api.g_varchar2_table(463) := '20202020202020202020202020202020202020202020202020202020202020206D6178436C7573746572696E674C6576656C3A2031340D0A202020202020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020';
wwv_flow_api.g_varchar2_table(464) := '2020202020202020202020293B0D0A2020202020202020202020202020202020202020202020206C506C672E666F694C61796572735B20666C205D2E72656472617728293B0D0A20202020202020202020202020202020202020207D0D0A202020202020';
wwv_flow_api.g_varchar2_table(465) := '202020202020202020207D0D0A2020202020202020202020207D0D0A20202020202020207D0D0A20202020293B0D0A7D0D0A0D0A417065784F7261636C654D617073506C7567696E2E70726F746F747970652E636C656172416C6C546F6F6C73203D2066';
wwv_flow_api.g_varchar2_table(466) := '756E6374696F6E202829207B0D0A20202020747279207B0D0A2020202020202020746869732E7265646C696E65746F6F6C2E636C65617228293B0D0A202020207D20636174636820282065782029207B0D0A202020207D0D0A20202020747279207B0D0A';
wwv_flow_api.g_varchar2_table(467) := '2020202020202020746869732E64697374616E6365746F6F6C2E636C65617228293B0D0A202020207D20636174636820282065782029207B0D0A202020207D0D0A20202020747279207B0D0A2020202020202020746869732E636972636C65746F6F6C2E';
wwv_flow_api.g_varchar2_table(468) := '636C65617228293B0D0A202020207D20636174636820282065782029207B0D0A202020207D0D0A20202020747279207B0D0A2020202020202020746869732E6D6172717565657A6F6F6D746F6F6C2E636C65617228293B0D0A202020207D206361746368';
wwv_flow_api.g_varchar2_table(469) := '20282065782029207B0D0A202020207D0D0A7D0D0A0D0A0D0A2F2F20436972636C652066756E6374696F6E733A2073746172742C2066696E6973682C20636C6561720D0A417065784F7261636C654D617073506C7567696E2E70726F746F747970652E63';
wwv_flow_api.g_varchar2_table(470) := '6C656172436972636C65203D2066756E6374696F6E202829207B0D0A20202020747279207B0D0A2020202020202020746869732E636972636C65746F6F6C2E636C65617228293B0D0A202020207D206361746368202820652029207B0D0A202020207D0D';
wwv_flow_api.g_varchar2_table(471) := '0A7D0D0A0D0A417065784F7261636C654D617073506C7567696E2E70726F746F747970652E66696E697368436972636C65203D2066756E6374696F6E202829207B0D0A20202020747279207B0D0A2020202020202020746869732E636972636C65746F6F';
wwv_flow_api.g_varchar2_table(472) := '6C2E66696E69736828293B0D0A202020207D206361746368202820652029207B0D0A202020202020202069662028202476282022706465627567222029203D3D2022594553222029207B0D0A202020202020202020202020636F6E736F6C652E6C6F6728';
wwv_flow_api.g_varchar2_table(473) := '206520293B0D0A20202020202020207D0D0A202020207D0D0A7D0D0A0D0A417065784F7261636C654D617073506C7567696E2E70726F746F747970652E7374617274436972636C65203D2066756E6374696F6E202829207B0D0A20202020746869732E63';
wwv_flow_api.g_varchar2_table(474) := '6C656172416C6C546F6F6C7328293B0D0A20202020746869732E636972636C65746F6F6C2E737461727428293B0D0A20202020617065782E6576656E742E74726967676572280D0A2020202020202020617065782E6A51756572792820222322202B2074';
wwv_flow_api.g_varchar2_table(475) := '6869732E67526567696F6E496420292C0D0A202020202020202022636F6D5F6F7261636C655F6F72616D61707368746D6C355F636972636C657374617274220D0A20202020293B0D0A202020202F2A0D0A2020202020696620284F4D2E76657273696F6E';
wwv_flow_api.g_varchar2_table(476) := '203D3D202231312E312E312E372E3122207C7C204F4D2E76657273696F6E203D3D202231312E312E312E372E3222207C7C204F4D2E76657273696F6E203D3D202231312E312E312E372E302229207B0D0A2020202020616C6572742822596F75206E6565';
wwv_flow_api.g_varchar2_table(477) := '64204F7261636C65204D6170732048544D4C35204150492076657273696F6E2031312E312E312E372E33206F722068696768657220696E206F7264657220746F207573652074686520636972636C6520746F6F6C2E2043757272656E746C792C20796F75';
wwv_flow_api.g_varchar2_table(478) := '20617265207573696E67205C753030323222202B204F4D2E76657273696F6E202B20225C7530303232204F7261636C6520456C6F636174696F6E205365727665722077696C6C20626520757067726164656420736F6F6E2E22293B0D0A20202020207D20';
wwv_flow_api.g_varchar2_table(479) := '656C7365207B0D0A2020202020746869732E636972636C65746F6F6C2E737461727428293B0D0A2020202020617065782E6576656E742E74726967676572280D0A2020202020617065782E6A5175657279282223222B746869732E67526567696F6E4964';
wwv_flow_api.g_varchar2_table(480) := '292C0D0A202020202022636F6D5F6F7261636C655F6F72616D61707368746D6C355F636972636C657374617274220D0A2020202020293B0D0A20202020207D0D0A20202020202A2F0D0A7D0D0A0D0A2F2F205265646C696E696E672066756E6374696F6E';
wwv_flow_api.g_varchar2_table(481) := '733A2073746172742C2066696E6973682C20636C6561720D0A417065784F7261636C654D617073506C7567696E2E70726F746F747970652E636C6561725265646C696E65203D2066756E6374696F6E202829207B0D0A20202020747279207B0D0A202020';
wwv_flow_api.g_varchar2_table(482) := '2020202020746869732E7265646C696E65746F6F6C2E636C65617228293B0D0A202020207D206361746368202820652029207B0D0A202020207D0D0A7D0D0A0D0A417065784F7261636C654D617073506C7567696E2E70726F746F747970652E66696E69';
wwv_flow_api.g_varchar2_table(483) := '73685265646C696E696E67203D2066756E6374696F6E202829207B0D0A20202020747279207B0D0A2020202020202020746869732E7265646C696E65746F6F6C2E66696E69736828293B0D0A202020207D206361746368202820652029207B0D0A202020';
wwv_flow_api.g_varchar2_table(484) := '202020202069662028202476282022706465627567222029203D3D2022594553222029207B0D0A202020202020202020202020636F6E736F6C652E6C6F6728206520293B0D0A20202020202020207D0D0A202020207D0D0A7D0D0A0D0A417065784F7261';
wwv_flow_api.g_varchar2_table(485) := '636C654D617073506C7567696E2E70726F746F747970652E73746172745265646C696E696E67203D2066756E6374696F6E202829207B0D0A20202020746869732E636C656172416C6C546F6F6C7328293B0D0A0D0A20202020746869732E7265646C696E';
wwv_flow_api.g_varchar2_table(486) := '65746F6F6C2E737461727428293B0D0A20202020617065782E6576656E742E74726967676572280D0A2020202020202020617065782E6A51756572792820222322202B20746869732E67526567696F6E496420292C0D0A202020202020202022636F6D5F';
wwv_flow_api.g_varchar2_table(487) := '6F7261636C655F6F72616D61707368746D6C355F7265646C696E657374617274220D0A20202020293B0D0A7D0D0A0D0A0D0A417065784F7261636C654D617073506C7567696E2E70726F746F747970652E72656D6F7665437573746F6D4D61726B657273';
wwv_flow_api.g_varchar2_table(488) := '203D2066756E6374696F6E202829207B0D0A20202020746869732E637573746F6D4D61726B65722E72656D6F7665416C6C466561747572657328293B0D0A7D0D0A0D0A417065784F7261636C654D617073506C7567696E2E70726F746F747970652E6164';
wwv_flow_api.g_varchar2_table(489) := '64437573746F6D4D61726B6572203D2066756E6374696F6E20282070582C2070592C2070537269642C20705374796C652C2070546578742029207B0D0A20202020766172206C4D61726B65722020203D206E6577204F4D2E46656174757265280D0A2020';
wwv_flow_api.g_varchar2_table(490) := '20202020202022435553544F4D464F495F22202B20746869732E637573746F6D4D61726B65722E676574416C6C466561747572657328292E6C656E6774682C0D0A20202020202020206E6577204F4D2E67656F6D657472792E506F696E74282070582C20';
wwv_flow_api.g_varchar2_table(491) := '70592C206765744F72616D6170735F61646A7573745352494428207053726964202920292C0D0A20202020202020207B0D0A20202020202020202020202072656E646572696E675374796C653A206E6577204F4D2E7374796C652E4D61726B657228207B';
wwv_flow_api.g_varchar2_table(492) := '0D0A202020202020202020202020202020207372633A20746869732E6746696C65507265666978202B20226D2D22202B20705374796C652E746F4C6F776572436173652829202B20222E706E67222C0D0A20202020202020202020202020202020784F66';
wwv_flow_api.g_varchar2_table(493) := '667365743A20302C0D0A20202020202020202020202020202020794F66667365743A20300D0A2020202020202020202020207D20290D0A20202020202020207D0D0A20202020293B0D0A202020206C4D61726B65722E6C6162656C203D2070546578743B';
wwv_flow_api.g_varchar2_table(494) := '0D0A20202020746869732E637573746F6D4D61726B65722E6164644665617475726528206C4D61726B657220293B0D0A7D0D0A0D0A2F2F206576656E742068616E646C65722066756E6374696F6E730D0A417065784F7261636C654D617073506C756769';
wwv_flow_api.g_varchar2_table(495) := '6E2E70726F746F747970652E66697265417065784576656E74524543454E544552203D2066756E6374696F6E202829207B0D0A20202020746869732E736574436F6F6B696528293B0D0A20202020617065782E6576656E742E74726967676572280D0A20';
wwv_flow_api.g_varchar2_table(496) := '20202020202020617065782E6A51756572792820222322202B20746869732E67526567696F6E496420292C0D0A202020202020202022636F6D5F6F7261636C655F6F72616D61707368746D6C355F6D6170726563656E746572220D0A20202020293B0D0A';
wwv_flow_api.g_varchar2_table(497) := '20202020617065782E6576656E742E74726967676572280D0A2020202020202020617065782E6A51756572792820222322202B20746869732E67526567696F6E496420292C0D0A202020202020202022636F6D5F6F7261636C655F6F72616D6170736874';
wwv_flow_api.g_varchar2_table(498) := '6D6C355F6D61706368616E676564220D0A20202020293B0D0A0D0A202020206966202820746869732E6753686F7753514C466F6920262620746869732E6753716C466F694C617A79203D3D202759272029207B0D0A2020202020202020746869732E6765';
wwv_flow_api.g_varchar2_table(499) := '7453514C466F6928293B0D0A202020207D0D0A7D0D0A0D0A417065784F7261636C654D617073506C7567696E2E70726F746F747970652E66697265417065784576656E74494E495449414C495A45203D2066756E6374696F6E202829207B0D0A20202020';
wwv_flow_api.g_varchar2_table(500) := '6966202820746869732E6753686F7753716C466F69203D3D202759272029207B0D0A2020202020202020746869732E67657453514C466F6928293B0D0A202020207D0D0A20202020617065782E6576656E742E747269676765722820222322202B207468';
wwv_flow_api.g_varchar2_table(501) := '69732E67526567696F6E49642C2022636F6D5F6F7261636C655F6F72616D61707368746D6C355F6D6170696E697469616C697A65642220293B0D0A2020202069662028202476282022706465627567222029203D3D2022594553222029207B0D0A202020';
wwv_flow_api.g_varchar2_table(502) := '2020202020636F6E736F6C652E6C6F672820224D415020696E6974206576656E742073656E7420666F72206A51756572792073656C6563746F72205C222322202B20746869732E67526567696F6E4964202B20225C222220293B0D0A202020207D0D0A7D';
wwv_flow_api.g_varchar2_table(503) := '0D0A0D0A417065784F7261636C654D617073506C7567696E2E70726F746F747970652E66697265417065784576656E745A4F4F4D4348414E4745203D2066756E6374696F6E202820705F6F6C642C20705F6E65772029207B0D0A20202020746869732E73';
wwv_flow_api.g_varchar2_table(504) := '6574436F6F6B696528293B0D0A20202020617065782E6576656E742E74726967676572280D0A2020202020202020617065782E6A51756572792820222322202B20746869732E67526567696F6E496420292C0D0A202020202020202022636F6D5F6F7261';
wwv_flow_api.g_varchar2_table(505) := '636C655F6F72616D61707368746D6C355F6D61707A6F6F6D6368616E676564220D0A20202020293B0D0A20202020617065782E6576656E742E74726967676572280D0A2020202020202020617065782E6A51756572792820222322202B20746869732E67';
wwv_flow_api.g_varchar2_table(506) := '526567696F6E496420292C0D0A202020202020202022636F6D5F6F7261636C655F6F72616D61707368746D6C355F6D61706368616E676564220D0A20202020293B0D0A202020206966202820746869732E6753686F7753716C466F692026262074686973';
wwv_flow_api.g_varchar2_table(507) := '2E6753716C466F694C617A79203D3D202759272029207B0D0A2020202020202020746869732E67657453514C466F6928293B0D0A202020207D0D0A7D0D0A0D0A2F2F2068656C70657220696E7374616E63652066756E6374696F6E730D0A0D0A41706578';
wwv_flow_api.g_varchar2_table(508) := '4F7261636C654D617073506C7567696E2E70726F746F747970652E736574436F6F6B6965203D2066756E6374696F6E202829207B0D0A202020206966202820746869732E67557365436F6F6B6965203D3D202259222029207B0D0A202020202020202061';
wwv_flow_api.g_varchar2_table(509) := '7065782E73746F726167652E736574436F6F6B6965280D0A202020202020202020202020224F7261636C654D617073506C7567696E5F22202B20746869732E67526567696F6E4964202B20225F22202B20247628202270496E7374616E63652220292C0D';
wwv_flow_api.g_varchar2_table(510) := '0A202020202020202020202020537472696E672820746869732E6D6170766965772E6765744D61705A6F6F6D4C6576656C28292029202B20222322202B0D0A202020202020202020202020537472696E6728204D6174682E726F756E642820746869732E';
wwv_flow_api.g_varchar2_table(511) := '6D6170766965772E6765744D617043656E74657228292E676574582829202A203130303030303030303020292029202B20222322202B0D0A202020202020202020202020537472696E6728204D6174682E726F756E642820746869732E6D617076696577';
wwv_flow_api.g_varchar2_table(512) := '2E6765744D617043656E74657228292E676574592829202A203130303030303030303020292029202B20222322202B0D0A202020202020202020202020537472696E672820746869732E6D6170766965772E676574556E69766572736528292E67657453';
wwv_flow_api.g_varchar2_table(513) := '524944282920290D0A2020202020202020293B0D0A202020207D0D0A7D0D0A2F2A0D0A202A20476C6F62616C2046756E6374696F6E730D0A202A2F0D0A0D0A66756E6374696F6E206765744F72616D617073282070526567696F6E49642029207B0D0A20';
wwv_flow_api.g_varchar2_table(514) := '20202072657475726E206765744D6170506C7567696E282070526567696F6E496420293B0D0A7D0D0A0D0A66756E6374696F6E206765744F72616D6170735F6D617076696577282070526567696F6E49642029207B0D0A2020202072657475726E206765';
wwv_flow_api.g_varchar2_table(515) := '744D6170506C7567696E282070526567696F6E496420292E6D6170766965773B0D0A7D0D0A0D0A66756E6374696F6E207072657061726544617461282070526567696F6E49642C2070547970652C2070537269642C207042426F782C20704D6F7573654C';
wwv_flow_api.g_varchar2_table(516) := '6F632C20704D617043656E7465722029207B0D0A20202020766172206C446174613B0D0A20202020766172206C6D617076696577203D206765744F72616D617073282070526567696F6E496420292E6D6170766965773B0D0A0D0A202020206966202820';
wwv_flow_api.g_varchar2_table(517) := '7054797065203D3D2022584D4C222029207B0D0A20202020202020206C44617461203D20223C4D4150444154413E223B0D0A20202020202020206C44617461203D206C44617461202B20223C42424F583E22202B0D0A2020202020202020202020202020';
wwv_flow_api.g_varchar2_table(518) := '2020223C584D494E3E22202B204D6174682E6D696E28207042426F782E6765744D696E5828292C207042426F782E6765744D61785828292029202B20223C2F584D494E3E22202B0D0A20202020202020202020202020202020223C594D494E3E22202B20';
wwv_flow_api.g_varchar2_table(519) := '4D6174682E6D617828207042426F782E6765744D696E5828292C207042426F782E6765744D61785828292029202B20223C2F594D494E3E22202B0D0A20202020202020202020202020202020223C584D41583E22202B204D6174682E6D696E2820704242';
wwv_flow_api.g_varchar2_table(520) := '6F782E6765744D696E5928292C207042426F782E6765744D61785928292029202B20223C2F584D41583E22202B0D0A20202020202020202020202020202020223C594D41583E22202B204D6174682E6D617828207042426F782E6765744D696E5928292C';
wwv_flow_api.g_varchar2_table(521) := '207042426F782E6765744D61785928292029202B20223C2F594D41583E22202B0D0A20202020202020202020202020202020223C2F42424F583E223B0D0A20202020202020206C44617461203D206C44617461202B20223C43454E5445523E22202B0D0A';
wwv_flow_api.g_varchar2_table(522) := '20202020202020202020202020202020223C583E22202B20704D617043656E7465722E676574582829202B20223C2F583E22202B0D0A20202020202020202020202020202020223C593E22202B20704D617043656E7465722E676574592829202B20223C';
wwv_flow_api.g_varchar2_table(523) := '2F593E22202B0D0A20202020202020202020202020202020223C2F43454E5445523E223B0D0A20202020202020206C44617461203D206C44617461202B20223C535249443E22202B20287053726964203D3D2022574753383422203F2022343332362220';
wwv_flow_api.g_varchar2_table(524) := '3A206C6D6170766965772E676574556E69766572736528292E67657453524944282929202B20223C2F535249443E223B0D0A20202020202020206C44617461203D206C44617461202B20223C5A4F4F4D4C4556454C3E22202B0D0A202020202020202020';
wwv_flow_api.g_varchar2_table(525) := '20202020202020223C43555252454E543E22202B206C6D6170766965772E6765744D61705A6F6F6D4C6576656C2829202B20223C2F43555252454E543E22202B0D0A20202020202020202020202020202020223C4D41583E22202B20286C6D6170766965';
wwv_flow_api.g_varchar2_table(526) := '772E676574556E69766572736528292E6765745A6F6F6D4C6576656C4E756D6265722829202D203129202B20223C2F4D41583E22202B0D0A20202020202020202020202020202020223C2F5A4F4F4D4C4556454C3E223B0D0A20202020202020206C4461';
wwv_flow_api.g_varchar2_table(527) := '7461203D206C44617461202B20223C4D4F5553455F4C4F434154494F4E3E22202B0D0A20202020202020202020202020202020223C583E22202B20704D6F7573654C6F632E676574582829202B20223C2F583E22202B0D0A202020202020202020202020';
wwv_flow_api.g_varchar2_table(528) := '20202020223C593E22202B20704D6F7573654C6F632E676574592829202B20223C2F593E22202B0D0A20202020202020202020202020202020223C2F4D4F5553455F4C4F434154494F4E3E223B0D0A20202020202020206C44617461203D206C44617461';
wwv_flow_api.g_varchar2_table(529) := '202B20223C2F4D4150444154413E223B0D0A202020207D20656C7365207B0D0A20202020202020206C44617461203D204A534F4E2E737472696E6769667928207B0D0A202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(530) := '2020206D6170646174613A207B0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202062626F78202020202020202020203A207B0D0A2020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(531) := '202020202020202020202020202020202020786D696E3A204D6174682E6D696E28207042426F782E6765744D696E5828292C207042426F782E6765744D617858282920292C0D0A2020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(532) := '202020202020202020202020202020786D61783A204D6174682E6D617828207042426F782E6765744D696E5828292C207042426F782E6765744D617858282920292C0D0A2020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(533) := '202020202020202020202020796D696E3A204D6174682E6D696E28207042426F782E6765744D696E5928292C207042426F782E6765744D617859282920292C0D0A2020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(534) := '202020202020202020796D61783A204D6174682E6D617828207042426F782E6765744D696E5928292C207042426F782E6765744D617859282920290D0A202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(535) := '207D2C0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202063656E74657220202020202020203A207B0D0A202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(536) := '2020202020202020783A20704D6F7573654C6F632E6765745828292C0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020793A20704D6F7573654C6F632E6765745928290D0A2020202020';
wwv_flow_api.g_varchar2_table(537) := '20202020202020202020202020202020202020202020202020202020202020202020207D2C0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202073726964202020202020202020203A202870537269';
wwv_flow_api.g_varchar2_table(538) := '64203D3D2022574753383422203F20223433323622203A206C6D6170766965772E676574556E69766572736528292E676574535249442829292C0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(539) := '7A6F6F6D6C6576656C20202020203A207B0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202063757272656E743A206C6D6170766965772E6765744D61705A6F6F6D4C6576656C28292C0D';
wwv_flow_api.g_varchar2_table(540) := '0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020206D6178202020203A20286C6D6170766965772E676574556E69766572736528292E6765745A6F6F6D4C6576656C4E756D6265722829202D';
wwv_flow_api.g_varchar2_table(541) := '2031290D0A202020202020202020202020202020202020202020202020202020202020202020202020202020207D2C0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020206D6F7573655F6C6F636174';
wwv_flow_api.g_varchar2_table(542) := '696F6E3A207B0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020783A20704D6F7573654C6F632E6765745828292C0D0A2020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(543) := '202020202020202020202020202020202020793A20704D6F7573654C6F632E6765745928290D0A202020202020202020202020202020202020202020202020202020202020202020202020202020207D0D0A202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(544) := '2020202020202020202020202020202020207D0D0A20202020202020202020202020202020202020202020202020202020202020207D20293B0D0A202020207D0D0A2020202072657475726E206C446174613B0D0A7D0D0A0D0A66756E6374696F6E2067';
wwv_flow_api.g_varchar2_table(545) := '65744F72616D6170735F6D617064617461282070526567696F6E49642C2070547970652C2070537269642C207043616C6C6261636B2029207B0D0A20202020766172206C6D617076696577203D206765744F72616D617073282070526567696F6E496420';
wwv_flow_api.g_varchar2_table(546) := '292E6D6170766965773B0D0A20202020766172206C62626F783B0D0A20202020766172206C6D63656E7465723B0D0A20202020766172206C6D6C6F633B0D0A202020207661722078436F6F7264733B0D0A202020207661722079436F6F7264733B0D0A0D';
wwv_flow_api.g_varchar2_table(547) := '0A202020206C62626F78202020203D206C6D6170766965772E6765744D617057696E646F77426F756E64696E67426F7828293B0D0A202020206C6D63656E746572203D206C6D6170766965772E6765744D617043656E74657228293B0D0A202020206C6D';
wwv_flow_api.g_varchar2_table(548) := '6C6F63202020203D206C6D6170766965772E676574437572736F724C6F636174696F6E28293B0D0A0D0A2020202069662028207053726964203D3D2022574753383422202626206C6D6170766965772E676574556E69766572736528292E676574535249';
wwv_flow_api.g_varchar2_table(549) := '44282920213D2038333037202626206C6D6170766965772E676574556E69766572736528292E67657453524944282920213D20343332362029207B0D0A20202020202020202F2F20436F6E7374727563742074686520537472696E67730D0A2020202020';
wwv_flow_api.g_varchar2_table(550) := '20202078436F6F726473203D204D6174682E726F756E6428206C62626F782E6765744D696E582829202A203130303030303030303020292E746F537472696E672829202B20223A22202B0D0A2020202020202020202020202020202020204D6174682E72';
wwv_flow_api.g_varchar2_table(551) := '6F756E6428206C62626F782E6765744D6178582829202A203130303030303030303020292E746F537472696E672829202B20223A22202B0D0A2020202020202020202020202020202020204D6174682E726F756E6428206C6D63656E7465722E67657458';
wwv_flow_api.g_varchar2_table(552) := '2829202A203130303030303030303020292E746F537472696E672829202B20223A22202B0D0A2020202020202020202020202020202020204D6174682E726F756E6428206C6D6C6F632E676574582829202A203130303030303030303020292E746F5374';
wwv_flow_api.g_varchar2_table(553) := '72696E6728293B0D0A202020202020202079436F6F726473203D204D6174682E726F756E6428206C62626F782E6765744D696E592829202A203130303030303030303020292E746F537472696E672829202B20223A22202B0D0A20202020202020202020';
wwv_flow_api.g_varchar2_table(554) := '20202020202020204D6174682E726F756E6428206C62626F782E6765744D6178592829202A203130303030303030303020292E746F537472696E672829202B20223A22202B0D0A2020202020202020202020202020202020204D6174682E726F756E6428';
wwv_flow_api.g_varchar2_table(555) := '206C6D63656E7465722E676574592829202A203130303030303030303020292E746F537472696E672829202B20223A22202B0D0A2020202020202020202020202020202020204D6174682E726F756E6428206C6D6C6F632E676574592829202A20313030';
wwv_flow_api.g_varchar2_table(556) := '3030303030303020292E746F537472696E6728293B0D0A20202020202020202F2F20414A41582052657175657374202E2E2E0D0A0D0A2020202020202020617065782E7365727665722E706C7567696E280D0A2020202020202020202020206765744F72';
wwv_flow_api.g_varchar2_table(557) := '616D617073282070526567696F6E496420292E67506C7567696E4E616D652C0D0A2020202020202020202020207B0D0A20202020202020202020202020202020783031202020203A2078436F6F7264732C0D0A2020202020202020202020202020202078';
wwv_flow_api.g_varchar2_table(558) := '3032202020203A2079436F6F7264732C0D0A20202020202020202020202020202020783033202020203A206C6D6170766965772E676574556E69766572736528292E6765745352494428292C0D0A20202020202020202020202020202020783034202020';
wwv_flow_api.g_varchar2_table(559) := '203A20343332362C0D0A20202020202020202020202020202020783130202020203A20275452414E53464F524D272C0D0A20202020202020202020202020202020705F64656275673A2024762820277064656275672720292C0D0A0D0A20202020202020';
wwv_flow_api.g_varchar2_table(560) := '20202020207D2C0D0A2020202020202020202020207B0D0A20202020202020202020202020202020737563636573733A2066756E6374696F6E202820646174612029207B0D0A20202020202020202020202020202020202020206C62626F78202020203D';
wwv_flow_api.g_varchar2_table(561) := '206E6577204F4D2E67656F6D657472792E52656374616E676C65280D0A202020202020202020202020202020202020202020202020646174615B2030205D2E782C0D0A202020202020202020202020202020202020202020202020646174615B2030205D';
wwv_flow_api.g_varchar2_table(562) := '2E792C0D0A202020202020202020202020202020202020202020202020646174615B2031205D2E782C0D0A202020202020202020202020202020202020202020202020646174615B2031205D2E792C0D0A20202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(563) := '2020202020343332360D0A2020202020202020202020202020202020202020293B0D0A20202020202020202020202020202020202020206C6D63656E746572203D206E6577204F4D2E67656F6D657472792E506F696E7428207061727365466C6F617428';
wwv_flow_api.g_varchar2_table(564) := '20646174615B2032205D2E7820292C207061727365466C6F61742820646174615B2032205D2E7920292C203433323620293B0D0A20202020202020202020202020202020202020206C6D6C6F63202020203D206E6577204F4D2E67656F6D657472792E50';
wwv_flow_api.g_varchar2_table(565) := '6F696E7428207061727365466C6F61742820646174615B2033205D2E7820292C207061727365466C6F61742820646174615B2033205D2E7920292C203433323620293B0D0A20202020202020202020202020202020202020207043616C6C6261636B2820';
wwv_flow_api.g_varchar2_table(566) := '7072657061726544617461282070526567696F6E49642C2070547970652C2070537269642C206C62626F782C206C6D6C6F632C206C6D63656E746572202920293B0D0A202020202020202020202020202020207D0D0A2020202020202020202020207D0D';
wwv_flow_api.g_varchar2_table(567) := '0A2020202020202020293B0D0A202020207D20656C7365207B0D0A20202020202020207043616C6C6261636B28207072657061726544617461282070526567696F6E49642C2070547970652C2070537269642C206C62626F782C206C6D6C6F632C206C6D';
wwv_flow_api.g_varchar2_table(568) := '63656E746572202920293B0D0A202020207D0D0A7D0D0A0D0A66756E6374696F6E206765744F72616D6170735F6D6170666F6F747072696E74282070526567696F6E49642C2070547970652C2070537269642029207B0D0A20202020766172206C6D6170';
wwv_flow_api.g_varchar2_table(569) := '76696577203D206765744F72616D617073282070526567696F6E496420292E6D6170766965773B0D0A20202020766172206C62626F783B0D0A20202020766172206C6D63656E7465723B0D0A20202020766172206C6D6C6F633B0D0A2020202076617220';
wwv_flow_api.g_varchar2_table(570) := '6C446174613B0D0A20202020766172206C416A6178526571756573743B0D0A20202020766172206C416A6178526573756C743B0D0A20202020766172206C526573756C74506F696E74733B0D0A202020207661722078436F6F7264733B0D0A2020202076';
wwv_flow_api.g_varchar2_table(571) := '61722079436F6F7264733B0D0A0D0A202020206C62626F78202020203D206C6D6170766965772E6765744D617057696E646F77426F756E64696E67426F7828293B0D0A202020206C6D63656E746572203D206C6D6170766965772E6765744D617043656E';
wwv_flow_api.g_varchar2_table(572) := '74657228293B0D0A202020206C6D6C6F63202020203D206C6D6170766965772E676574437572736F724C6F636174696F6E28293B0D0A0D0A2020202069662028207053726964203D3D2022574753383422202626206C6D6170766965772E676574556E69';
wwv_flow_api.g_varchar2_table(573) := '766572736528292E67657453524944282920213D2038333037202626206C6D6170766965772E676574556E69766572736528292E67657453524944282920213D20343332362029207B0D0A20202020202020202F2F20436F6E7374727563742074686520';
wwv_flow_api.g_varchar2_table(574) := '537472696E67730D0A202020202020202078436F6F726473203D204D6174682E726F756E6428206C62626F782E6765744D696E582829202A203130303030303030303020292E746F537472696E672829202B20223A22202B0D0A20202020202020202020';
wwv_flow_api.g_varchar2_table(575) := '20202020202020204D6174682E726F756E6428206C62626F782E6765744D6178582829202A203130303030303030303020292E746F537472696E672829202B20223A22202B0D0A2020202020202020202020202020202020204D6174682E726F756E6428';
wwv_flow_api.g_varchar2_table(576) := '206C6D63656E7465722E676574582829202A203130303030303030303020292E746F537472696E672829202B20223A22202B0D0A2020202020202020202020202020202020204D6174682E726F756E6428206C6D6C6F632E676574582829202A20313030';
wwv_flow_api.g_varchar2_table(577) := '3030303030303020292E746F537472696E6728293B0D0A202020202020202079436F6F726473203D204D6174682E726F756E6428206C62626F782E6765744D696E592829202A203130303030303030303020292E746F537472696E672829202B20223A22';
wwv_flow_api.g_varchar2_table(578) := '202B0D0A2020202020202020202020202020202020204D6174682E726F756E6428206C62626F782E6765744D6178592829202A203130303030303030303020292E746F537472696E672829202B20223A22202B0D0A202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(579) := '2020204D6174682E726F756E6428206C6D63656E7465722E676574592829202A203130303030303030303020292E746F537472696E672829202B20223A22202B0D0A2020202020202020202020202020202020204D6174682E726F756E6428206C6D6C6F';
wwv_flow_api.g_varchar2_table(580) := '632E676574592829202A203130303030303030303020292E746F537472696E6728293B0D0A20202020202020202F2F20414A41582052657175657374202E2E2E0D0A0D0A20202020202020206C526573756C74506F696E7473203D204A534F4E2E706172';
wwv_flow_api.g_varchar2_table(581) := '7365280D0A202020202020202020202020617065782E7365727665722E706C7567696E280D0A202020202020202020202020202020206765744F72616D617073282070526567696F6E496420292E67506C7567696E4E616D652C0D0A2020202020202020';
wwv_flow_api.g_varchar2_table(582) := '20202020202020207B0D0A2020202020202020202020202020202020202020783031202020203A2078436F6F7264732C0D0A2020202020202020202020202020202020202020783032202020203A2079436F6F7264732C0D0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(583) := '202020202020202020783033202020203A206C6D6170766965772E676574556E69766572736528292E6765745352494428292C0D0A2020202020202020202020202020202020202020783034202020203A20343332362C0D0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(584) := '202020202020202020783130202020203A20275452414E53464F524D272C0D0A2020202020202020202020202020202020202020705F64656275673A2024762820277064656275672720292C0D0A0D0A202020202020202020202020202020207D2C0D0A';
wwv_flow_api.g_varchar2_table(585) := '202020202020202020202020202020207B0D0A20202020202020202020202020202020202020206173796E633A2066616C7365202F2F206E6577206D6574686F64207772697474656E210D0A202020202020202020202020202020207D0D0A2020202020';
wwv_flow_api.g_varchar2_table(586) := '20202020202020292E726573706F6E73655465787420293B0D0A20202020202020202F2F20636F6E736F6C652E6C6F67286C526573756C74506F696E7473293B0D0A20202020202020206C62626F78202020203D206E6577204F4D2E67656F6D65747279';
wwv_flow_api.g_varchar2_table(587) := '2E52656374616E676C65280D0A2020202020202020202020206C526573756C74506F696E74735B2030205D2E782C0D0A2020202020202020202020206C526573756C74506F696E74735B2030205D2E792C0D0A2020202020202020202020206C52657375';
wwv_flow_api.g_varchar2_table(588) := '6C74506F696E74735B2031205D2E782C0D0A2020202020202020202020206C526573756C74506F696E74735B2031205D2E792C0D0A202020202020202020202020343332360D0A2020202020202020293B0D0A20202020202020206C6D63656E74657220';
wwv_flow_api.g_varchar2_table(589) := '3D206E6577204F4D2E67656F6D657472792E506F696E7428207061727365466C6F617428206C526573756C74506F696E74735B2032205D2E7820292C207061727365466C6F617428206C526573756C74506F696E74735B2032205D2E7920292C20343332';
wwv_flow_api.g_varchar2_table(590) := '3620293B0D0A20202020202020206C6D6C6F63202020203D206E6577204F4D2E67656F6D657472792E506F696E7428207061727365466C6F617428206C526573756C74506F696E74735B2033205D2E7820292C207061727365466C6F617428206C526573';
wwv_flow_api.g_varchar2_table(591) := '756C74506F696E74735B2033205D2E7920292C203433323620293B0D0A202020207D0D0A0D0A2020202069662028207054797065203D3D2022584D4C222029207B0D0A20202020202020206C44617461203D20223C4D4150444154413E223B0D0A202020';
wwv_flow_api.g_varchar2_table(592) := '20202020206C44617461203D206C44617461202B20223C42424F583E22202B0D0A20202020202020202020202020202020223C584D494E3E22202B204D6174682E6D696E28206C62626F782E6765744D696E5828292C206C62626F782E6765744D617858';
wwv_flow_api.g_varchar2_table(593) := '28292029202B20223C2F584D494E3E22202B0D0A20202020202020202020202020202020223C594D494E3E22202B204D6174682E6D617828206C62626F782E6765744D696E5828292C206C62626F782E6765744D61785828292029202B20223C2F594D49';
wwv_flow_api.g_varchar2_table(594) := '4E3E22202B0D0A20202020202020202020202020202020223C584D41583E22202B204D6174682E6D696E28206C62626F782E6765744D696E5928292C206C62626F782E6765744D61785928292029202B20223C2F584D41583E22202B0D0A202020202020';
wwv_flow_api.g_varchar2_table(595) := '20202020202020202020223C594D41583E22202B204D6174682E6D617828206C62626F782E6765744D696E5928292C206C62626F782E6765744D61785928292029202B20223C2F594D41583E22202B0D0A20202020202020202020202020202020223C2F';
wwv_flow_api.g_varchar2_table(596) := '42424F583E223B0D0A20202020202020206C44617461203D206C44617461202B20223C43454E5445523E22202B0D0A20202020202020202020202020202020223C583E22202B206C6D63656E7465722E676574582829202B20223C2F583E22202B0D0A20';
wwv_flow_api.g_varchar2_table(597) := '202020202020202020202020202020223C593E22202B206C6D63656E7465722E676574592829202B20223C2F593E22202B0D0A20202020202020202020202020202020223C2F43454E5445523E223B0D0A20202020202020206C44617461203D206C4461';
wwv_flow_api.g_varchar2_table(598) := '7461202B20223C535249443E22202B20287053726964203D3D2022574753383422203F20223433323622203A206C6D6170766965772E676574556E69766572736528292E67657453524944282929202B20223C2F535249443E223B0D0A20202020202020';
wwv_flow_api.g_varchar2_table(599) := '206C44617461203D206C44617461202B20223C5A4F4F4D4C4556454C3E22202B0D0A20202020202020202020202020202020223C43555252454E543E22202B206C6D6170766965772E6765744D61705A6F6F6D4C6576656C2829202B20223C2F43555252';
wwv_flow_api.g_varchar2_table(600) := '454E543E22202B0D0A20202020202020202020202020202020223C4D41583E22202B20286C6D6170766965772E676574556E69766572736528292E6765745A6F6F6D4C6576656C4E756D6265722829202D203129202B20223C2F4D41583E22202B0D0A20';
wwv_flow_api.g_varchar2_table(601) := '202020202020202020202020202020223C2F5A4F4F4D4C4556454C3E223B0D0A20202020202020206C44617461203D206C44617461202B20223C4D4F5553455F4C4F434154494F4E3E22202B0D0A20202020202020202020202020202020223C583E2220';
wwv_flow_api.g_varchar2_table(602) := '2B206C6D6C6F632E676574582829202B20223C2F583E22202B0D0A20202020202020202020202020202020223C593E22202B206C6D6C6F632E676574592829202B20223C2F593E22202B0D0A20202020202020202020202020202020223C2F4D4F555345';
wwv_flow_api.g_varchar2_table(603) := '5F4C4F434154494F4E3E223B0D0A20202020202020206C44617461203D206C44617461202B20223C2F4D4150444154413E223B0D0A202020207D20656C7365207B0D0A20202020202020206C44617461203D204A534F4E2E737472696E6769667928207B';
wwv_flow_api.g_varchar2_table(604) := '0D0A2020202020202020202020202020202020202020202020202020202020202020202020206D6170646174613A207B0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202062626F78202020202020';
wwv_flow_api.g_varchar2_table(605) := '202020203A207B0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020786D696E3A204D6174682E6D696E28206C62626F782E6765744D696E5828292C206C62626F782E6765744D61785828';
wwv_flow_api.g_varchar2_table(606) := '2920292C0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020786D61783A204D6174682E6D617828206C62626F782E6765744D696E5828292C206C62626F782E6765744D61785828292029';
wwv_flow_api.g_varchar2_table(607) := '2C0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020796D696E3A204D6174682E6D696E28206C62626F782E6765744D696E5928292C206C62626F782E6765744D617859282920292C0D0A';
wwv_flow_api.g_varchar2_table(608) := '2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020796D61783A204D6174682E6D617828206C62626F782E6765744D696E5928292C206C62626F782E6765744D617859282920290D0A20202020';
wwv_flow_api.g_varchar2_table(609) := '2020202020202020202020202020202020202020202020202020202020202020202020207D2C0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202063656E74657220202020202020203A207B0D0A20';
wwv_flow_api.g_varchar2_table(610) := '20202020202020202020202020202020202020202020202020202020202020202020202020202020202020783A206C6D63656E7465722E6765745828292C0D0A202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(611) := '2020202020202020793A206C6D63656E7465722E6765745928290D0A202020202020202020202020202020202020202020202020202020202020202020202020202020207D2C0D0A20202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(612) := '20202020202020202020202073726964202020202020202020203A20287053726964203D3D2022574753383422203F20223433323622203A206C6D6170766965772E676574556E69766572736528292E676574535249442829292C0D0A20202020202020';
wwv_flow_api.g_varchar2_table(613) := '2020202020202020202020202020202020202020202020202020202020202020207A6F6F6D6C6576656C20202020203A207B0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202063757272';
wwv_flow_api.g_varchar2_table(614) := '656E743A206C6D6170766965772E6765744D61705A6F6F6D4C6576656C28292C0D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020206D6178202020203A20286C6D6170766965772E676574';
wwv_flow_api.g_varchar2_table(615) := '556E69766572736528292E6765745A6F6F6D4C6576656C4E756D6265722829202D2031290D0A202020202020202020202020202020202020202020202020202020202020202020202020202020207D2C0D0A202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(616) := '202020202020202020202020202020202020202020206D6F7573655F6C6F636174696F6E3A207B0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020783A206C6D6C6F632E676574582829';
wwv_flow_api.g_varchar2_table(617) := '2C0D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020793A206C6D6C6F632E6765745928290D0A202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(618) := '202020207D0D0A2020202020202020202020202020202020202020202020202020202020202020202020207D0D0A20202020202020202020202020202020202020202020202020202020202020207D20293B0D0A202020207D0D0A202020207265747572';
wwv_flow_api.g_varchar2_table(619) := '6E206C446174613B0D0A7D0D0A0D0A66756E6374696F6E206765744F72616D6170735F636972636C6564617461282070526567696F6E49642C2070537269642C207043616C6C6261636B2029207B0D0A20202020766172206C6D617076696577203D2067';
wwv_flow_api.g_varchar2_table(620) := '65744D6170506C7567696E282070526567696F6E496420292E6D6170766965773B0D0A20202020766172206C546F6F6C202020203D206765744D6170506C7567696E282070526567696F6E496420292E636972636C65746F6F6C3B0D0A20202020766172';
wwv_flow_api.g_varchar2_table(621) := '206C47656F6D4F626A3B0D0A0D0A2020202069662028207053726964203D3D2022574753383422202626206C6D6170766965772E676574556E69766572736528292E67657453524944282920213D2038333037202626206C6D6170766965772E67657455';
wwv_flow_api.g_varchar2_table(622) := '6E69766572736528292E67657453524944282920213D20343332362029207B0D0A20202020202020202F2F20436F6E7374727563742074686520537472696E67730D0A202020202020202078436F6F726473203D204D6174682E726F756E6428206C546F';
wwv_flow_api.g_varchar2_table(623) := '6F6C2E67657447656F6D6574727928292E67657443656E746572582829202A203130303030303030303020292E746F537472696E6728293B0D0A202020202020202079436F6F726473203D204D6174682E726F756E6428206C546F6F6C2E67657447656F';
wwv_flow_api.g_varchar2_table(624) := '6D6574727928292E67657443656E746572592829202A203130303030303030303020292E746F537472696E6728293B0D0A0D0A2020202020202020617065782E7365727665722E706C7567696E280D0A2020202020202020202020206765744F72616D61';
wwv_flow_api.g_varchar2_table(625) := '7073282070526567696F6E496420292E67506C7567696E4E616D652C0D0A2020202020202020202020207B0D0A20202020202020202020202020202020783031202020203A2078436F6F7264732C0D0A2020202020202020202020202020202078303220';
wwv_flow_api.g_varchar2_table(626) := '2020203A2079436F6F7264732C0D0A20202020202020202020202020202020783033202020203A206C6D6170766965772E676574556E69766572736528292E6765745352494428292C0D0A20202020202020202020202020202020783034202020203A20';
wwv_flow_api.g_varchar2_table(627) := '343332362C0D0A20202020202020202020202020202020783130202020203A20275452414E53464F524D272C0D0A20202020202020202020202020202020705F64656275673A2024762820277064656275672720292C0D0A202020202020202020202020';
wwv_flow_api.g_varchar2_table(628) := '7D2C0D0A2020202020202020202020207B0D0A20202020202020202020202020202020737563636573733A2066756E6374696F6E20282070446174612029207B0D0A20202020202020202020202020202020202020207043616C6C6261636B280D0A2020';
wwv_flow_api.g_varchar2_table(629) := '202020202020202020202020202020202020202020207B0D0A202020202020202020202020202020202020202020202020202020202263656E746572223A207B0D0A20202020202020202020202020202020202020202020202020202020202020202278';
wwv_flow_api.g_varchar2_table(630) := '223A206765744F72616D6170735F6E756D4F7261546F4A73282070446174615B2030205D2E7820292C0D0A20202020202020202020202020202020202020202020202020202020202020202279223A206765744F72616D6170735F6E756D4F7261546F4A';
wwv_flow_api.g_varchar2_table(631) := '73282070446174615B2030205D2E7920290D0A202020202020202020202020202020202020202020202020202020207D2C0D0A2020202020202020202020202020202020202020202020202020202022726164697573223A206C546F6F6C2E6765745261';
wwv_flow_api.g_varchar2_table(632) := '646975732820226D657465722220292C0D0A2020202020202020202020202020202020202020202020202020202022737269642220203A20343332360D0A2020202020202020202020202020202020202020202020207D0D0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(633) := '202020202020202020293B0D0A202020202020202020202020202020207D0D0A2020202020202020202020207D0D0A2020202020202020293B0D0A202020207D20656C7365207B0D0A20202020202020207043616C6C6261636B280D0A20202020202020';
wwv_flow_api.g_varchar2_table(634) := '207B0D0A2020202020202020202020202263656E746572223A207B0D0A202020202020202020202020202020202278223A206C546F6F6C2E67657447656F6D6574727928292E67657443656E7465725828292C0D0A202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(635) := '202279223A206C546F6F6C2E67657447656F6D6574727928292E67657443656E7465725928290D0A2020202020202020202020207D2C0D0A20202020202020202020202022726164697573223A206C546F6F6C2E6765745261646975732820226D657465';
wwv_flow_api.g_varchar2_table(636) := '722220292C0D0A20202020202020202020202022737269642220203A206C6D6170766965772E676574556E69766572736528292E6765745352494428290D0A20202020202020207D0D0A2020202020202020293B0D0A202020207D0D0A7D0D0A0D0A6675';
wwv_flow_api.g_varchar2_table(637) := '6E6374696F6E206765744F72616D6170735F7265646C696E6567656F6D282070526567696F6E49642C2070547970652029207B0D0A20202020766172206C5265646C696E6547656F6D203D206765744D6170506C7567696E282070526567696F6E496420';
wwv_flow_api.g_varchar2_table(638) := '292E7265646C696E65746F6F6C2E67657447656F6D6574727928293B0D0A0D0A20202020766172206C47656F6D547970653B0D0A20202020766172206C446174613B0D0A0D0A2020202069662028206C5265646C696E6547656F6D2E6765745479706528';
wwv_flow_api.g_varchar2_table(639) := '29203D3D204F4D2E47656F6D54797065732E504F4C59474F4E2029207B0D0A20202020202020206C47656F6D54797065203D20323030333B0D0A202020207D0D0A2020202069662028206C5265646C696E6547656F6D2E676574547970652829203D3D20';
wwv_flow_api.g_varchar2_table(640) := '4F4D2E47656F6D54797065732E504F494E542029207B0D0A20202020202020206C47656F6D54797065203D20323030313B0D0A202020207D0D0A2020202069662028206C5265646C696E6547656F6D2E676574547970652829203D3D204F4D2E47656F6D';
wwv_flow_api.g_varchar2_table(641) := '54797065732E4C494E45535452494E472029207B0D0A20202020202020206C47656F6D54797065203D20323030323B0D0A202020207D0D0A0D0A2020202069662028207054797065203D3D20224A534F4E222029207B0D0A20202020202020206C446174';
wwv_flow_api.g_varchar2_table(642) := '61203D204A534F4E2E737472696E6769667928207B0D0A20202020202020202020202020202020202020202020202020202020202020202020202073646F5F6774797065202020203A20323030332C0D0A20202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(643) := '202020202020202020202020202020202073646F5F7372696420202020203A206C5265646C696E6547656F6D2E6765745352494428292C0D0A20202020202020202020202020202020202020202020202020202020202020202020202073646F5F706F69';
wwv_flow_api.g_varchar2_table(644) := '6E74202020203A206E756C6C2C0D0A20202020202020202020202020202020202020202020202020202020202020202020202073646F5F656C656D5F696E666F3A205B20312C20313030332C2031205D2C0D0A2020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(645) := '2020202020202020202020202020202020202073646F5F6F7264696E617465733A206C5265646C696E6547656F6D2E6765744F7264696E6174657328290D0A20202020202020202020202020202020202020202020202020202020202020207D20293B0D';
wwv_flow_api.g_varchar2_table(646) := '0A202020207D20656C73652069662028207054797065203D3D2022574B54222029207B0D0A202020202020202069662028206C47656F6D54797065203D3D20323030312029207B0D0A2020202020202020202020206C44617461203D2022504F494E5420';
wwv_flow_api.g_varchar2_table(647) := '2822202B206C5265646C696E6547656F6D2E676574582829202B20222022202B206C5265646C696E6547656F6D2E676574592829202B202229223B0D0A20202020202020207D0D0A202020202020202069662028206C47656F6D54797065203D3D203230';
wwv_flow_api.g_varchar2_table(648) := '30322029207B0D0A2020202020202020202020206C44617461203D20224C494E45535452494E47202828223B0D0A202020202020202020202020666F722028207661722069203D20303B2069203C206C5265646C696E6547656F6D2E6765744F7264696E';
wwv_flow_api.g_varchar2_table(649) := '6174657328295B2030205D2E6C656E6774683B2069203D2069202B20322029207B0D0A202020202020202020202020202020206C44617461203D206C44617461202B206C5265646C696E6547656F6D2E6765744F7264696E6174657328295B2030205D5B';
wwv_flow_api.g_varchar2_table(650) := '2069205D202B20222022202B0D0A2020202020202020202020202020202020202020202020206C5265646C696E6547656F6D2E6765744F7264696E6174657328295B2030205D5B2069202B2031205D3B0D0A202020202020202020202020202020206966';
wwv_flow_api.g_varchar2_table(651) := '20282069203C206C5265646C696E6547656F6D2E6765744F7264696E6174657328295B2030205D2E6C656E677468202D20312029207B0D0A20202020202020202020202020202020202020206C44617461203D206C44617461202B20222C223B0D0A2020';
wwv_flow_api.g_varchar2_table(652) := '20202020202020202020202020207D0D0A2020202020202020202020207D0D0A2020202020202020202020206C44617461203D206C44617461202B20222929223B0D0A20202020202020207D0D0A202020202020202069662028206C47656F6D54797065';
wwv_flow_api.g_varchar2_table(653) := '203D3D20323030332029207B0D0A2020202020202020202020206C44617461203D2022504F4C59474F4E202828223B0D0A202020202020202020202020666F722028207661722069203D20303B2069203C206C5265646C696E6547656F6D2E6765744F72';
wwv_flow_api.g_varchar2_table(654) := '64696E6174657328295B2030205D2E6C656E6774683B2069203D2069202B20322029207B0D0A202020202020202020202020202020206C44617461203D206C44617461202B204D6174682E726F756E6428206C5265646C696E6547656F6D2E6765744F72';
wwv_flow_api.g_varchar2_table(655) := '64696E6174657328295B2030205D5B2069205D202A203130303030302029202F20313030303030202B20222022202B0D0A2020202020202020202020202020202020202020202020204D6174682E726F756E6428206C5265646C696E6547656F6D2E6765';
wwv_flow_api.g_varchar2_table(656) := '744F7264696E6174657328295B2030205D5B2069202B2031205D202A203130303030302029202F203130303030303B0D0A20202020202020202020202020202020696620282069203C20286C5265646C696E6547656F6D2E6765744F7264696E61746573';
wwv_flow_api.g_varchar2_table(657) := '28295B2030205D2E6C656E677468202D2032292029207B0D0A20202020202020202020202020202020202020206C44617461203D206C44617461202B20222C223B0D0A202020202020202020202020202020207D0D0A2020202020202020202020207D0D';
wwv_flow_api.g_varchar2_table(658) := '0A2020202020202020202020206C44617461203D206C44617461202B20222929223B0D0A20202020202020207D0D0A202020207D20656C7365207B0D0A20202020202020206C44617461203D20223C53444F5F47454F4D455452593E22202B0D0A202020';
wwv_flow_api.g_varchar2_table(659) := '20202020202020202020202020223C53444F5F47545950453E22202B206C47656F6D54797065202B20223C2F53444F5F47545950453E22202B0D0A20202020202020202020202020202020223C53444F5F535249443E22202B206C5265646C696E654765';
wwv_flow_api.g_varchar2_table(660) := '6F6D2E676574535249442829202B20223C2F53444F5F535249443E223B0D0A202020202020202069662028206C5265646C696E6547656F6D2E676574547970652829203D3D204F4D2E47656F6D54797065732E504F494E542029207B0D0A202020202020';
wwv_flow_api.g_varchar2_table(661) := '2020202020206C44617461203D206C44617461202B20223C53444F5F504F494E543E22202B0D0A2020202020202020202020202020202020202020223C583E22202B206C5265646C696E6547656F6D2E676574582829202B20223C2F583E22202B0D0A20';
wwv_flow_api.g_varchar2_table(662) := '20202020202020202020202020202020202020223C593E22202B206C5265646C696E6547656F6D2E676574592829202B20223C2F593E22202B0D0A2020202020202020202020202020202020202020223C2F53444F5F504F494E543E223B0D0A20202020';
wwv_flow_api.g_varchar2_table(663) := '202020207D0D0A202020202020202069662028206C5265646C696E6547656F6D2E676574547970652829203D3D204F4D2E47656F6D54797065732E504F4C59474F4E2029207B0D0A2020202020202020202020206C44617461203D206C44617461202B20';
wwv_flow_api.g_varchar2_table(664) := '223C53444F5F454C454D5F494E464F3E223B0D0A2020202020202020202020206C44617461203D206C44617461202B20223C4E3E313C2F4E3E223B0D0A2020202020202020202020206C44617461203D206C44617461202B20223C4E3E313030333C2F4E';
wwv_flow_api.g_varchar2_table(665) := '3E223B0D0A2020202020202020202020206C44617461203D206C44617461202B20223C4E3E313C2F4E3E223B0D0A2020202020202020202020206C44617461203D206C44617461202B20223C2F53444F5F454C454D5F494E464F3E223B0D0A2020202020';
wwv_flow_api.g_varchar2_table(666) := '2020207D0D0A202020202020202069662028206C5265646C696E6547656F6D2E676574547970652829203D3D204F4D2E47656F6D54797065732E4C494E45535452494E472029207B0D0A2020202020202020202020206C44617461203D206C4461746120';
wwv_flow_api.g_varchar2_table(667) := '2B20223C53444F5F454C454D5F494E464F3E223B0D0A2020202020202020202020206C44617461203D206C44617461202B20223C4E3E313C2F4E3E223B0D0A2020202020202020202020206C44617461203D206C44617461202B20223C4E3E323C2F4E3E';
wwv_flow_api.g_varchar2_table(668) := '223B0D0A2020202020202020202020206C44617461203D206C44617461202B20223C4E3E313C2F4E3E223B0D0A2020202020202020202020206C44617461203D206C44617461202B20223C2F53444F5F454C454D5F494E464F3E223B0D0A202020202020';
wwv_flow_api.g_varchar2_table(669) := '20207D0D0A202020202020202069662028206C5265646C696E6547656F6D2E676574547970652829203D3D204F4D2E47656F6D54797065732E4C494E45535452494E47207C7C0D0A202020202020202020202020206C5265646C696E6547656F6D2E6765';
wwv_flow_api.g_varchar2_table(670) := '74547970652829203D3D204F4D2E47656F6D54797065732E504F4C59474F4E2029207B0D0A2020202020202020202020206C44617461203D206C44617461202B20223C53444F5F4F5244494E415445533E223B0D0A202020202020202020202020666F72';
wwv_flow_api.g_varchar2_table(671) := '2028207661722069203D20303B2069203C206C5265646C696E6547656F6D2E6765744F7264696E6174657328295B2030205D2E6C656E6774683B20692B2B2029207B0D0A202020202020202020202020202020206C44617461203D206C44617461202B20';
wwv_flow_api.g_varchar2_table(672) := '223C4E3E22202B204D6174682E726F756E6428206C5265646C696E6547656F6D2E6765744F7264696E6174657328295B2030205D5B2069205D202A203130303030302029202F20313030303030202B20223C2F4E3E223B0D0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(673) := '207D0D0A2020202020202020202020206C44617461203D206C44617461202B20223C2F53444F5F4F5244494E415445533E223B0D0A20202020202020207D0D0A20202020202020206C44617461203D206C44617461202B20223C2F53444F5F47454F4D45';
wwv_flow_api.g_varchar2_table(674) := '5452593E223B0D0A202020207D0D0A2020202072657475726E206C446174613B0D0A7D0D0A0D0A66756E6374696F6E206765744F72616D6170735F636C656172436972636C65282070526567696F6E49642029207B0D0A202020206765744D6170506C75';
wwv_flow_api.g_varchar2_table(675) := '67696E282070526567696F6E496420292E636C656172436972636C6528293B0D0A7D0D0A0D0A66756E6374696F6E206765744F72616D6170735F7374617274436972636C65282070526567696F6E49642029207B0D0A202020206765744D6170506C7567';
wwv_flow_api.g_varchar2_table(676) := '696E282070526567696F6E496420292E7374617274436972636C6528293B0D0A7D0D0A0D0A66756E6374696F6E206765744F72616D6170735F66696E697368436972636C65282070526567696F6E49642029207B0D0A202020206765744D6170506C7567';
wwv_flow_api.g_varchar2_table(677) := '696E282070526567696F6E496420292E66696E697368436972636C6528293B0D0A7D0D0A0D0A66756E6374696F6E206765744F72616D6170735F636C6561725265644C696E65282070526567696F6E49642029207B0D0A202020206765744D6170506C75';
wwv_flow_api.g_varchar2_table(678) := '67696E282070526567696F6E496420292E636C6561725265646C696E6528293B0D0A7D0D0A0D0A66756E6374696F6E206765744F72616D6170735F73746172745265644C696E65282070526567696F6E49642029207B0D0A202020206765744D6170506C';
wwv_flow_api.g_varchar2_table(679) := '7567696E282070526567696F6E496420292E73746172745265646C696E696E6728293B0D0A7D0D0A0D0A66756E6374696F6E206765744F72616D6170735F66696E6973685265644C696E65282070526567696F6E49642029207B0D0A202020206765744D';
wwv_flow_api.g_varchar2_table(680) := '6170506C7567696E282070526567696F6E496420292E66696E6973685265646C696E696E6728293B0D0A7D0D0A0D0A66756E6374696F6E206765744F72616D6170735F7374617274526563745A6F6F6D282070526567696F6E49642029207B0D0A202020';
wwv_flow_api.g_varchar2_table(681) := '206765744D6170506C7567696E282070526567696F6E496420292E636C656172416C6C546F6F6C7328293B0D0A202020206765744D6170506C7567696E282070526567696F6E496420292E6D6172717565657A6F6F6D746F6F6C2E737461727428293B0D';
wwv_flow_api.g_varchar2_table(682) := '0A7D0D0A0D0A66756E6374696F6E206765744F72616D6170735F61646A75737453524944282070537269642029207B0D0A20202020766172206C537269643B0D0A2020202069662028207053726964203D3D2022222029207B0D0A20202020202020206C';
wwv_flow_api.g_varchar2_table(683) := '53726964203D206765744D6170506C7567696E282070526567696F6E496420292E6D6170766965772E676574556E69766572736528292E6765745352494428293B0D0A202020207D20656C73652069662028207053726964203D3D20343332362029207B';
wwv_flow_api.g_varchar2_table(684) := '0D0A20202020202020206C53726964203D20383330373B0D0A202020207D20656C7365207B0D0A20202020202020206C53726964203D2070537269643B0D0A202020207D0D0A2020202072657475726E206C537269643B0D0A7D0D0A0D0A66756E637469';
wwv_flow_api.g_varchar2_table(685) := '6F6E206765744F72616D6170735F73657443656E746572282070526567696F6E49642C2070582C2070592C2070537269642029207B0D0A2020202069662028202169734E614E28206765744F72616D6170735F6E756D4F7261546F4A7328207058202920';
wwv_flow_api.g_varchar2_table(686) := '29202626202169734E614E28206765744F72616D6170735F6E756D4F7261546F4A7328207059202920292029207B0D0A20202020202020206765744D6170506C7567696E282070526567696F6E496420292E6D6170766965772E7365744D617043656E74';
wwv_flow_api.g_varchar2_table(687) := '6572280D0A2020202020202020202020206E6577204F4D2E67656F6D657472792E506F696E74280D0A202020202020202020202020202020206765744F72616D6170735F6E756D4F7261546F4A732820705820292C0D0A20202020202020202020202020';
wwv_flow_api.g_varchar2_table(688) := '2020206765744F72616D6170735F6E756D4F7261546F4A732820705920292C0D0A202020202020202020202020202020206765744F72616D6170735F61646A757374535249442820705372696420290D0A202020202020202020202020290D0A20202020';
wwv_flow_api.g_varchar2_table(689) := '20202020293B0D0A202020207D0D0A7D0D0A0D0A66756E6374696F6E206765744F72616D6170735F73657443656E7465725A6F6F6D282070526567696F6E49642C2070582C2070592C2070537269642C20705A6F6F6D2029207B0D0A2020202069662028';
wwv_flow_api.g_varchar2_table(690) := '202169734E614E28206765744F72616D6170735F6E756D4F7261546F4A732820705820292029202626202169734E614E28206765744F72616D6170735F6E756D4F7261546F4A732820705920292029202626202169734E614E28207061727365496E7428';
wwv_flow_api.g_varchar2_table(691) := '20705372696420292029202626202169734E614E28207061727365496E742820705A6F6F6D202920290D0A2020202029207B0D0A20202020202020206765744D6170506C7567696E282070526567696F6E496420292E6D6170766965772E7365744D6170';
wwv_flow_api.g_varchar2_table(692) := '43656E746572416E645A6F6F6D4C6576656C280D0A2020202020202020202020206E6577204F4D2E67656F6D657472792E506F696E74280D0A202020202020202020202020202020206765744F72616D6170735F6E756D4F7261546F4A73282070582029';
wwv_flow_api.g_varchar2_table(693) := '2C0D0A202020202020202020202020202020206765744F72616D6170735F6E756D4F7261546F4A732820705920292C0D0A202020202020202020202020202020206765744F72616D6170735F61646A757374535249442820705372696420290D0A202020';
wwv_flow_api.g_varchar2_table(694) := '202020202020202020292C0D0A2020202020202020202020207061727365496E742820705A6F6F6D20290D0A2020202020202020293B0D0A202020207D0D0A7D0D0A0D0A66756E6374696F6E206765744F72616D6170735F7365745A6F6F6D4C6576656C';
wwv_flow_api.g_varchar2_table(695) := '282070526567696F6E49642C20705A6F6F6D2029207B0D0A2020202069662028202169734E614E28207061727365496E742820705A6F6F6D202920292029207B0D0A20202020202020206765744D6170506C7567696E282070526567696F6E496420292E';
wwv_flow_api.g_varchar2_table(696) := '6D6170766965772E7365744D61705A6F6F6D4C6576656C28207061727365496E742820705A6F6F6D202920293B0D0A202020207D0D0A7D0D0A0D0A66756E6374696F6E206765744F72616D6170735F736574437573746F6D4D61726B6572282070526567';
wwv_flow_api.g_varchar2_table(697) := '696F6E49642C2070582C2070592C2070537269642C20705374796C652C2070546578742029207B0D0A2020202069662028202169734E614E28206765744F72616D6170735F6E756D4F7261546F4A732820705820292029202626202169734E614E282067';
wwv_flow_api.g_varchar2_table(698) := '65744F72616D6170735F6E756D4F7261546F4A732820705920292029202626202169734E614E28207061727365496E7428207053726964202920290D0A2020202029207B0D0A20202020202020206765744F72616D617073282070526567696F6E496420';
wwv_flow_api.g_varchar2_table(699) := '292E616464437573746F6D4D61726B6572280D0A2020202020202020202020206765744F72616D6170735F6E756D4F7261546F4A732820705820292C0D0A2020202020202020202020206765744F72616D6170735F6E756D4F7261546F4A732820705920';
wwv_flow_api.g_varchar2_table(700) := '292C0D0A20202020202020202020202070537269642C0D0A202020202020202020202020705374796C652C0D0A20202020202020202020202070546578740D0A2020202020202020293B0D0A202020207D0D0A7D0D0A0D0A66756E6374696F6E20676574';
wwv_flow_api.g_varchar2_table(701) := '4F72616D6170735F72656D6F7665437573746F6D4D61726B6572282070526567696F6E49642029207B0D0A202020206765744F72616D617073282070526567696F6E496420292E72656D6F7665437573746F6D4D61726B65727328293B0D0A7D0D0A0D0A';
wwv_flow_api.g_varchar2_table(702) := '66756E6374696F6E206765744F72616D6170735F7265667265736853716C464F49282070526567696F6E49642029207B0D0A202020206765744D6170506C7567696E282070526567696F6E496420292E7265667265736853514C466F6928293B0D0A7D0D';
wwv_flow_api.g_varchar2_table(703) := '0A0D0A0D0A66756E6374696F6E206765744D6170506C7567696E282070526567696F6E49642029207B0D0A20202020766172206C506C7567696E203D2067506C7567696E4F626A656374735B2070526567696F6E4964205D3B0D0A202020206966202820';
wwv_flow_api.g_varchar2_table(704) := '216C506C7567696E2029207B0D0A202020202020202068616E646C65446576656C6F7065724572726F722820225468657265206973206E6F204F7261636C65204D61707320526567696F6E207769746820526567696F6E204944205C2222202B20705265';
wwv_flow_api.g_varchar2_table(705) := '67696F6E4964202B20225C222E20436865636B20746865205C2253746174696320526567696F6E2049445C22206F6620796F7572204D617020726567696F6E2E2220293B0D0A202020207D0D0A2020202072657475726E206C506C7567696E3B0D0A7D0D';
wwv_flow_api.g_varchar2_table(706) := '0A0D0A66756E6374696F6E2068616E646C65446576656C6F7065724572726F722820704D6573736167652029207B0D0A20202020636F6E736F6C652E6C6F672820224552524F523A2022202B20704D65737361676520293B0D0A20202020616C65727428';
wwv_flow_api.g_varchar2_table(707) := '20704D65737361676520293B0D0A7D0D0A0D0A66756E6374696F6E206765744F72616D6170735F6E756D4F7261546F4A73282070496E4E756D6265722029207B0D0A2020202072657475726E207061727365466C6F61742820537472696E67282070496E';
wwv_flow_api.g_varchar2_table(708) := '4E756D62657220292E7265706C6163652820222C222C20222E22202920293B0D0A7D0D0A0D0A66756E6374696F6E206765744F72616D6170735F65736361706548544D4C2820737472696E672C20646F69742029207B0D0A2020202076617220656E7469';
wwv_flow_api.g_varchar2_table(709) := '74794D6170203D207B0D0A20202020202020202226223A202226616D703B222C0D0A2020202020202020223C223A2022266C743B222C0D0A2020202020202020223E223A20222667743B222C0D0A20202020202020202722273A20272671756F743B272C';
wwv_flow_api.g_varchar2_table(710) := '0D0A20202020202020202227223A2027262333393B272C0D0A2020202020202020222F223A202726237832463B270D0A202020207D3B0D0A0D0A202020206966202820646F6974203D3D202259222029207B0D0A202020202020202072657475726E2053';
wwv_flow_api.g_varchar2_table(711) := '7472696E672820737472696E6720292E7265706C61636528202F5B263C3E22275C2F5D2F672C2066756E6374696F6E202820732029207B72657475726E20656E746974794D61705B2073205D3B7D20293B0D0A202020207D20656C7365207B0D0A202020';
wwv_flow_api.g_varchar2_table(712) := '202020202072657475726E20737472696E673B0D0A202020207D0D0A7D0D0A';
null;
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(2814509446114580743)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_file_name=>'apx-maps-plugin-html5.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '89504E470D0A1A0A0000000D49484452000000100000002E0802000000AEE10EEB0000000674524E5300FF00FF00FF37581B7D000000097048597300000EC400000EC401952B0E1B000001E849444154789CED94514BDB501CC5CFBD2DA121995868C406';
wwv_flow_api.g_varchar2_table(2) := '43B5699B960C410411344BAD9041DEF7E207F465EFD281087B96321966AD60B4A5A2BEB807D76B8AA5640F29314BB36C1FA0E7E9FECF393FEE857B13E2FB3E0000BEEF5F5FBBDDEED5FDFDA3E77900789E97E5D54643AB54544248502301F0FCFCEBE4E4';
wwv_flow_api.g_varchar2_table(3) := 'CBC3C32392542CAEDAF6C7A5A5773360341A1D1F7F668C25B60309827074F44914450AA0DD3E4D6F03608CB5DBA70068BF3F180EEF623121243C74A8E1F0AEDF1F641DA71B7533994CAB65D6EB1A805EEFEAECECEB743A0D53C7E9664CB335994C42EBE0';
wwv_flow_api.g_varchar2_table(4) := 'E0C3E6E67B4A29A5746545CAE572B7B783301D8FC794B197E80ED5AA9A3232F64229A551EBF5759232524A693EBF1CB5CECF3B29633EBF9C5594B5A7A79FA17579F9C3F3C6BA5E07E0383DD7BD89028AB296D5B4EAC5C5F7A8EBBA37B15E284DAB52592E';
wwv_flow_api.g_varchar2_table(5) := '4A5221318E49920AB25CA400767777FE07086A1480AA6EFC7313492AA8EAC60C208418C65E3A60187BC163995D42A9A4D46A95BFB56BB54AA9A404EBB75B33CD7D8EE3E6DB1CC799E67E38BE01A228369BC63CD06C1AA22826000074BD512EAF479D7279';
wwv_flow_api.g_varchar2_table(6) := '5DD71B51E70F0080651D0A8210AC0541B0ACC358210EF03C6FDB56F001D9B6C5F37CAC40C2BF46549DCE3700DBDB5BF3513290A2F89116C00258000B205DBF012C1199312D6051870000000049454E44AE426082';
null;
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(60647214338831048460)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_file_name=>'m-gray.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '89504E470D0A1A0A0000000D49484452000000100000002E0802000000AEE10EEB0000000674524E5300FF00FF00FF37581B7D000000097048597300000EC400000EC401952B0E1B000001C149444154789CED94BF4AC35014C6BF736E52B598DAC45614';
wwv_flow_api.g_varchar2_table(2) := 'C188B4935D441111519CDD1C2DE2E8A28FE0E42338B8EA2338B838893876111404155C54A4859456106D92EB90687A63883E40BFE99E7BCFEF9CEFE4CF2529250000BE9435475E36FCBBB66CB90090D3503668A9C073263151904601D0F89007F7DEFD5B';
wwv_flow_api.g_varchar2_table(3) := '08C7541AA4DD9228F45108389F72EFDA753A89C9A14C1DFB15CDCC1003387CF0D2B301381D1C3E7800F8AAE9DFB4E24E08A05FCC4D4B5E357DEDA2EE77EFEA84AD49B1542000970D79FCE875BAAA5DD47DEDB6AD94AFDABC3AC2C17A75845C298F1EA38A';
wwv_flow_api.g_varchar2_table(4) := 'B76DC94DD5FDBCC52961B30316AAD90F2F2D14041EED57B64E9EBD9470B41FDA748E9FDE2397E775F9E6BACB450E46AC39CA84D339D61687E9EC5569527364CD51AD7C6B7198B86CB09D4D3C8DCBCEA26C3003581F17FF01823406306BD29F4DEC2C664D';
wwv_flow_api.g_varchar2_table(5) := '0A0122DA98F8A3C9C68420FA0600548678C1FAFDF9845AB0A8321466462FB26A8B81A4360302553B3A88002B439B7602B1690B2B430900809522CFE4156333795A292A394A00607B4AE4F5709DD7B13D15EF19070C9D764A22F881764AC2D0E34F827E6E';
wwv_flow_api.g_varchar2_table(6) := '8D6E9DBE7800D6C612464A065214B7D4037A400FE801E9FA028D268D3D900226DE0000000049454E44AE426082';
null;
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(60647215918908107440)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_file_name=>'m-blue.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '89504E470D0A1A0A0000000D49484452000000100000002E0802000000AEE10EEB0000000674524E5300FF00FF00FF37581B7D000000097048597300000EC400000EC401952B0E1B0000020649444154789CED94BF6B13611CC69FF77DF3F3EED24B734D';
wwv_flow_api.g_varchar2_table(2) := 'DA50A234194C3A8488A544435121080E0E4269EB565AAE42870E5245702E14053B2B747670707328161DAC66B09462D10CEA50C140A1692EE9D9B44D720E17AEE7259EF903F24CEFF7F97E3EBCEF7247344D0300A0A1353E1E6EBD2BE7BE56BF2BF50A00';
wwv_flow_api.g_varchar2_table(3) := '91F9129ED8B59EF465E1222554C7882EEC9DEE3F293CCF577FA05DE29EE8FDF05CC8293585FD5AE9DEEE52B1566A4BEB0938FC4FCF3D921C7E0A60A5B06A4F0328D64A2B8555007453DDD93ECA5BD614848258CAEDA3FCA6BAE3585736CCAD8B38EF86EE';
wwv_flow_api.g_varchar2_table(4) := '5CF7A501BCADE49EEDBD38D14E8DEDBAB2C1C2F317AADAB151C9A1A99BFEAB8C304658CC735E60DC27F5B3B1ADD4557A5057CC3764844B36E3415DA10CCC5C551BC7362303A383AE7E73F5B2F8DA661C74F53B925C7CF7E49751AD95DF971B6AB6E70A80';
wwv_flow_api.g_varchar2_table(5) := '37E50FB9C32DB390E4E2E4CBEF6F0F7E2EA3B33C8E3CA4096F2CEA8E744247DD91843746014C49B73A11748C0248F3A9A1FF5D32E48EA4F954532084CCF48DDB0B337DE38490A60020C50F8F0923FFA2C78491143FAC9FA9D1CE062738EA6DA539EA9D0D';
wwv_flow_api.g_varchar2_table(6) := '4E18E39920397BE5E064AB20072725676F1B014056CC8CF2497333CA27B362C6DCFC25005818980E30513F0798B830306D01AC82C87C8B6159FF8016C3B2C87C1680187F0D735E15D700DC0EDC685DB5176C627D5257E80A5DA12BD8E70F5E5897820A0D';
wwv_flow_api.g_varchar2_table(7) := '33D40000000049454E44AE426082';
null;
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(60647216618483108046)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_file_name=>'m-green.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '89504E470D0A1A0A0000000D49484452000000100000002E0802000000AEE10EEB0000000674524E5300FF00FF00FF37581B7D000000097048597300000EC400000EC401952B0E1B000001DC49444154789CED94BF4B5B5114C7BFE7BC50C106218F6AC8';
wwv_flow_api.g_varchar2_table(2) := 'D2C4254921E40D62088224229245D141118A4D4327DD0A5A8B3F7008A51DBA74C8580A45E85809BA1A02715107A3E860A15BA11042487FE02FECBD1D12F3F292E74BFE807CB773CEF773BEF70EF792941200002904760FC44E0EC7E728FD0600B5079A8F';
wwv_flow_api.g_varchar2_table(3) := 'C787311A22E68A8D2A80FC5914AF3EE0E41B4C15F4F2FB97E47A540564A1249EAEA250327757D4A7F297B7D4A73200B1966AE106502889B51400967B79EC9F368E997177685DFBA7722F6F93E9ACA1DBF580565ED0F83000B99393EF3EE1FAA63694E9AC';
wwv_flow_api.g_varchar2_table(4) := 'B2D1F5181757B516BD4EF0CC18290A290A3DE947CF43E48EF475BFFE308AE5FA001A0B5B9428961936C5D0BABCB22A6D0AC3EDAAEFC88F5B1625DC2E1B8502F2FB0FDDF135F3AFFC9727A300443A8BCC81E184A10089FCB978B68EF6C49B6F98342FFC9E';
wwv_flow_api.g_varchar2_table(5) := 'B6EC7E0F695E06C0F3D36DAD9F9F06C0003032085FAB109F0723835580887871AEC5FAC53922BA4B00281CA4D8D07D6E8A0D51385825F5EE521CF66E13BBBD9B96E27A940E38555A4E98AC5F4E9053350100F054149101833D32C0535183A7611F2717D0';
wwv_flow_api.g_varchar2_table(6) := 'EBA816BD0E4E2E3426CA2689C3B35B6DF6569B158767CD53AAFD1AF5129FB701F0F309932B9902166A7AB81DA00374800E60A9FF9E92AFB9592F9B610000000049454E44AE426082';
null;
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(60647217339975108557)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_file_name=>'m-purple.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '89504E470D0A1A0A0000000D49484452000000100000002E0802000000AEE10EEB0000000674524E5300FF00FF00FF37581B7D000000097048597300000EC400000EC401952B0E1B000001E449444154789CED934D4B1B611485CFBD131469FD0227B49B';
wwv_flow_api.g_varchar2_table(2) := 'EC62101A034A24E0672B2A1808050529155BA460C185BA08649388B8F127B828C5564BE9A20811032E545A2A1145B1B66B5D2A26622C6DBAD1F7759131E324E3243F206735EFBDE739F7CEE292941200002904BE6D88B555FCFA89D40500D4D4C2EDE13E';
wwv_flow_api.g_varchar2_table(3) := '3F3A9F1173C64619409E9E88E9107E1FC2544F1A79668E1E3DD6009938136F86914C98BB33AA53F9DD12A976062066C305DC009209311B06C0727B0B7B3BB96D66DC2EAD6B6F476E6FB18C450DD5B2720A45783DCEEB710A4550567EB729635125525D81';
wwv_flow_api.g_varchar2_table(4) := 'FFE96C892683FC7C90148514855C0DA8AA44FC874EFCB9649C27EF66D0D31E8B27CE930CC56628A5D3564FC5C670380C5B2EBEB778C2E1B051738B3C3ED21D2BCBD79729EE0F0010B128BE6F1A366C6E21717820DEBE4671E2F90526B7074E575176A78B';
wwv_flow_api.g_varchar2_table(5) := 'DC1E06C0A36345C58F8E01600068EF82B3BE507C3DDABB348088787CAA40FCF81411DD4E00C8EBA3EEDEFBDCD4DD4B5E9FF6AD1F50E24CBC1CC0BFBFB9F6070FF9D35752EDDA283D46B5D344D0247E2298751B0000EC0FA0B5C3606FED607FC0C06757D2';
wwv_flow_api.g_varchar2_table(6) := '164B5D885743DA3DD5A9FCE10BD5D41A22649EC4FEEE555BD3555B93D8DFCDEFE64EC8487CFE08805F8C98FC922960A1BCC32D0125A00494004BDD006301BEF26F3A2CDB0000000049454E44AE426082';
null;
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(60647218028698109088)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_file_name=>'m-red.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '89504E470D0A1A0A0000000D49484452000000100000002E0802000000AEE10EEB0000000674524E5300FF00FF00FF37581B7D000000097048597300000EC400000EC401952B0E1B000001B549444154789CED93B14B5B5114C67FE7FA4C083E8D4FA341';
wwv_flow_api.g_varchar2_table(2) := '7954EC12715017C149B050174171712AEDE86C45DAC13DED1FE1A038B94804573717071187D20E2D520735266A485ADABC90DBE13D125FF2FA923F20DF74CF77BE1FE7C2BD47B4D600A07595A7131E8E295D507904302CCC190696E87F25A2DC98B8802E';
wwv_flow_api.g_varchar2_table(3) := 'DFF0E303BF2E0954CF142F3F4B64C4037439CBD73738D9E0B4ABEE6126F62532AC00AEB65BA40127CBD536A074E194E259535F816AF48A67BA706A90CFF85C89F2E223034B000FC7FCFC84FE5BEFE63306A5731F60BF97C4AA774EACEA6A99EB74BD5B3A';
wwv_flow_api.g_varchar2_table(4) := '5738391F60BD0E2B9D9C420C9F55FD1D568AA1888EF9ACDB9DB0323A66D03BCB9FEF752B77A82B05069701F2473C9DF880DE59A9162FF8F68E3695DA55624E134BB5958EA5C49C5600A3EB6D01A3EB78CF195F683D249622BEE0012282BDD102B0374484';
wwv_flow_api.g_varchar2_table(5) := 'DA8791BE39ACC5FFA6AD45E99B738FCF7E98BD49971990EE32B1376B551D9048127B2BE8325B1249060080245688CFFBD2F17949ACF832B59D76A52B8F7C59C3B907E81E62F2400CEB79A0714BC4B0184F7B0B349E6E48074CF0E6DCED01927CDBDC0A06';
wwv_flow_api.g_varchar2_table(6) := '42D4B4B81DA00374800E10AA7F18F87CF19B27F7CD0000000049454E44AE426082';
null;
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(60647218728273109626)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_file_name=>'m-yellow.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '89504E470D0A1A0A0000000D4948445200000001000000010802000000907753DE0000000674524E5300FF00FF00FF37581B7D000000097048597300000EC400000EC401952B0E1B0000000C49444154789C63F8FFFF3F0005FE02FE0DEF46B800000000';
wwv_flow_api.g_varchar2_table(2) := '49454E44AE426082';
null;
wwv_flow_api.component_end;
end;
/
begin
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(60647419344073315830)
,p_plugin_id=>wwv_flow_api.id(61535298363463408228)
,p_file_name=>'transp.png'
,p_mime_type=>'image/png'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
wwv_flow_api.component_end;
end;
/
