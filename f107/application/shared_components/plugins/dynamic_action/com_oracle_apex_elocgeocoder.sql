prompt --application/shared_components/plugins/dynamic_action/com_oracle_apex_elocgeocoder
begin
--   Manifest
--     PLUGIN: COM.ORACLE.APEX.ELOCGEOCODER
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
 p_id=>wwv_flow_api.id(59803783233658005964)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'COM.ORACLE.APEX.ELOCGEOCODER'
,p_display_name=>'Oracle Elocation Geocoder'
,p_category=>'MISC'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('DYNAMIC ACTION','COM.ORACLE.APEX.ELOCGEOCODER'),'')
,p_api_version=>1
,p_render_function=>'eba_spatial_gcdr_pkg.render_elocation_geocoder'
,p_ajax_function=>'eba_spatial_gcdr_pkg.ajax_elocation_geocoder'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'20140707'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(59803784424588025344)
,p_plugin_id=>wwv_flow_api.id(59803783233658005964)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Collection Name'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'GEOCODER_RESULTS'
,p_display_length=>30
,p_max_length=>30
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'Enter the name of a collection to store the geocoding results here. The collection can be queried as follows:',
'</p>',
'<pre>',
'select ',
'     c001 as street,',
'     c002 as house_number,',
'     c003 as postal_code,',
'     c004 as settlement,',
'     c005 as builtup_area,',
'     c006 as municipality,',
'     c007 as order1_area,',
'     c008 as side,',
'     c009 as error_message,',
'     c010 as match_vector,',
'     c011 as country,',
'     n001 as sequence,',
'     n002 as longitude,',
'     n003 as latitude,',
'     n004 as edge_id',
'    from apex_collections where collection_name = ''<i>{Collection Name}</i>''',
'    order by seq_id',
'</pre>',
'<p>',
' To display geocoding results, create a Report based on that query and add another <i>true action</i> to this dynamic action, in order to refresh that report.',
'</p>',
''))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(59803799912214395822)
,p_plugin_id=>wwv_flow_api.id(59803783233658005964)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Geocoder match mode'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'DEFAULT'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(59801622908892547608)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'NORMAL'
,p_lov_type=>'STATIC'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Match Modes for Geocoding Operations</p>',
'<table cellspacing="0" cellpadding="3" border="1" dir="ltr" >',
'<tr valign="top" align="left">',
'<th valign="bottom" align="left" >Match Mode</th>',
'<th valign="bottom" align="left" >Description</th>',
'</tr>',
'<tr valign="top" align="left">',
'<td align="left" headers="r1c1-t3" >',
'<p>EXACT</p>',
'</td>',
'<td align="left" headers="r2c1-t3 r1c2-t3">',
'<p>All attributes of the input address must match the data used for geocoding. However, if the house or building number, base name (street name), street type, street prefix, and street suffix do not all match the geocoding data, a location in the fir'
||'st match found in the following is returned: postal code, city or town (settlement) within the state, and state. For example, if the street name is incorrect but a valid postal code is specified, a location in the postal code is returned.</p>',
'</td>',
'</tr>',
'<tr valign="top" align="left">',
'<td align="left" headers="r1c1-t3" >',
'<p>RELAX_BASE_NAME</p>',
'</td>',
'<td align="left" headers="r6c1-t3 r1c2-t3">',
'<p>The base name of the street, the house or building number, and the street type can be different from the data used for geocoding. For example, if <i>Pleasant Valley</i> is the base name of a street in the data used for geocoding, <i>Pleasant Vale<'
||'/i> would also match as long as there were no ambiguities or other matches in the data.</p>',
'</td>',
'</tr>',
'<tr valign="top" align="left">',
'<td align="left" headers="r1c1-t3" >',
'<p>RELAX_POSTAL_CODE</p>',
'</td>',
'<td align="left" headers="r7c1-t3 r1c2-t3">',
'<p>The postal code (if provided), base name, house or building number, and street type can be different from the data used for geocoding.</p>',
'</td>',
'</tr>',
'<tr valign="top" align="left">',
'<td align="left" headers="r1c1-t3" >',
'<p>DEFAULT</p>',
'</td>',
'<td align="left" headers="r8c1-t3 r1c2-t3">',
'<p>The address can be outside the city specified as long as it is within the same county. Also includes the characteristics of RELAX_POSTAL_CODE.</p>',
'</td>',
'</tr>',
'</table>'))
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(59803800329671402864)
,p_plugin_attribute_id=>wwv_flow_api.id(59803799912214395822)
,p_display_sequence=>10
,p_display_value=>'Do only exact matches'
,p_return_value=>'EXACT'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(59803800722985405957)
,p_plugin_attribute_id=>wwv_flow_api.id(59803799912214395822)
,p_display_sequence=>20
,p_display_value=>'Relax Postal Code'
,p_return_value=>'RELAX_POSTAL_CODE'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(59803801119750407547)
,p_plugin_attribute_id=>wwv_flow_api.id(59803799912214395822)
,p_display_sequence=>30
,p_display_value=>'Relax Base Name'
,p_return_value=>'RELAX_BASE_NAME'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(59803801514359410042)
,p_plugin_attribute_id=>wwv_flow_api.id(59803799912214395822)
,p_display_sequence=>40
,p_display_value=>'Use Server Default'
,p_return_value=>'DEFAULT'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(59801641710354461529)
,p_plugin_id=>wwv_flow_api.id(59803783233658005964)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Item containing Country Code'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>true
,p_default_value=>'PX_GEOCODER_COUNTRY'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(59801622908892547608)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'NORMAL'
,p_help_text=>'Enter the name of the item containing the country code for the Geocoder.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(59801642288356471763)
,p_plugin_id=>wwv_flow_api.id(59803783233658005964)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Item containing address lines'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>true
,p_default_value=>'PX_GEOCODER_ADDRESS'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(59801622908892547608)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'NORMAL'
,p_help_text=>'Enter the name of the item containing the address to geocode.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(59803786429425175135)
,p_plugin_id=>wwv_flow_api.id(59803783233658005964)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Separator for address elements'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>','
,p_display_length=>2
,p_max_length=>2
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(59801622908892547608)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'NORMAL'
,p_help_text=>'Enter the character which separates the parts of an address.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(59801622908892547608)
,p_plugin_id=>wwv_flow_api.id(59803783233658005964)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>5
,p_prompt=>'Geocoding type'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'NORMAL'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Specify the kind of geocoding here. <b>Geocoding</b> is converting a postal address to a coordinate - <b>Reverse Geocoding</b> is determining the postal address from the coordinate.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(59801623207167548366)
,p_plugin_attribute_id=>wwv_flow_api.id(59801622908892547608)
,p_display_sequence=>10
,p_display_value=>'Geocoding'
,p_return_value=>'NORMAL'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(59801623605657549137)
,p_plugin_attribute_id=>wwv_flow_api.id(59801622908892547608)
,p_display_sequence=>20
,p_display_value=>'Reverse Geocoding'
,p_return_value=>'REVERSE'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(59801624215134559929)
,p_plugin_id=>wwv_flow_api.id(59803783233658005964)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>90
,p_prompt=>'Item containing Longitude value'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(59801622908892547608)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'REVERSE'
,p_help_text=>'Specify the APEX item containing the longitude value here.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(59801624506507563900)
,p_plugin_id=>wwv_flow_api.id(59803783233658005964)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>100
,p_prompt=>'Item containing Latitude value'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(59801622908892547608)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'REVERSE'
,p_help_text=>'Specify the item containing the Latitude value.'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(2010443277075144573)
,p_plugin_id=>wwv_flow_api.id(59803783233658005964)
,p_name=>'com_oracle_eloc_gcdr_done'
,p_display_name=>'elocation_geocoder_success'
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(2010442880920144567)
,p_plugin_id=>wwv_flow_api.id(59803783233658005964)
,p_name=>'com_oracle_eloc_gcdr_error'
,p_display_name=>'elocation_geocoder_error'
);
wwv_flow_api.component_end;
end;
/
