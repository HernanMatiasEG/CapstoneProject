prompt --application/pages/page_00201
begin
--   Manifest
--     PAGE: 00201
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_page(
 p_id=>201
,p_user_interface_id=>wwv_flow_api.id(46757782309074001702)
,p_name=>'Help'
,p_alias=>'HELP'
,p_step_title=>'Help'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_page_template_options=>'#DEFAULT#'
,p_last_upd_yyyymmddhh24miss=>'20190114110914'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2278959853853721600)
,p_plug_name=>'Help Container'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(2134510792919489250)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2950690299911997668)
,p_plug_name=>'Terms of Use'
,p_parent_plug_id=>wwv_flow_api.id(2278959853853721600)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(2134499814373489217)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h2>Terms of Use</h2>',
'<p>',
'&LICENSE_TERMS.',
'</p>',
'<p>',
'&LEGAL_NOTICE.',
'</p>'))
,p_plug_query_headings_type=>'QUERY_COLUMNS'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_query_show_nulls_as=>' - '
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(26534122309972431948)
,p_plug_name=>'About this Application'
,p_parent_plug_id=>wwv_flow_api.id(2278959853853721600)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(2134499814373489217)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h2>About this Application</h2>',
'<p>',
' This application demonstrates Spatial capabilities of the Oracle database. It has 2 main areas: Addresses and Areas Of Interest.</p>',
'<ul>',
'<li>The <b>Addresses</b> section allows to add postal addresses ("Customers" and "Suppliers") which can be geocoded (converted to a coordinate) and then be displayed on the map.</li>',
'<li><b>Areas Of Interest</b> are polygons which can be drawn on the map and then be stored into the database</li>',
'</ul>',
'<p>',
'Based on this data, the application offers 3 kinds of spatial analysis',
'</p> ',
'<ul>',
'<li><b>Within Distance Search</b>: After clicking a position on the map and adjusting the "distance slider", the application will return all addresses, which are located within that area.</li>',
'<li><b>Nearest Neighbor Search</b>: After selecting a "Supplier" address, a maximum distance and the maximum number of results, the application will show the closest N "Customer" addresses.</li>',
'<li><b>Area Of Interest Search</b>: Allows to choose one of the previously created Areas Of Interest - the application will return all addresses within that area.</li>',
'</ul>'))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(26534122534769431950)
,p_plug_name=>'Oracle Database functionality utilized in this application'
,p_parent_plug_id=>wwv_flow_api.id(2278959853853721600)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(2134499814373489217)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h2>Oracle Database Technologies Used</h2>',
'<p>',
' The application uses the following key database technologies:',
'</p>',
'<ul style="list-style: disc outside none; padding-left: 5mm">',
'<li><b>Store Location: Oracle Locator:</b><br/>',
'<p>',
'The location of address is being stored in a table column of Oracle''s <b>SDO_GEOMETRY</b> type. SDO_GEOMETRY represents spatial information as geometric primitives like points, linestrings or polygons. For the addresses, the location is stored as poi'
||'nts. SDO_GEOMETRY allows to create spatial indexes and to perform spatial queries to find addresses within a given area.',
'</p>',
'<p>More information on Oracle Locator can be found on the <a href="http://www.oracle.com/us/products/database/options/spatial/overview/index.html" target="_blank">Oracle Spatial Page</a> and within the <a href="http://docs.oracle.com/cd/E16655_01/app'
||'dev.121/e17896/toc.htm" target="_blank">Oracle Documentation: Spatial and Graph Developers Guide</a>.',
'</p>',
'</li>',
'<li><b>Geocoding: Oracle Spatial Option:</b><br/>',
'<p>',
'The Oracle Database contains a Geocoding Engine to convert a postal address into a coordinate (and vice-versa). This is being used on the <b>Edit Address</b> Page. For normal, production installations, the Geocoder requires a reference data set to be'
||' installed in the database; these datasets can be obtained from vendors like <a href="http://corporate.navteq.com/customer-collaboration_oracle.htm" target="_blank">Here</a> or <a href="http://www.tomtom.com/en_gb/licensing/products/maps/geospatial-o'
||'racle/" target="_blank">TomTom</a>. This application uses an Oracle Demonstration Server. ',
'</p>',
'<p>More information on Oracle Spatial and Geocoding can be found in the <a href="http://download.oracle.com/otndocs/products/spatial/pdf/spatial11gr2_geocoder_twp.pdf" target="_blank">Oracle Spatial Geocoder Whitepaper</a> and within the <a href="htt'
||'p://docs.oracle.com/database/121/SPATL/sdo_geocode_concepts.htm#SPATL045" target="_blank">Oracle Documentation: Geocoding Address Data</a>.',
'</p>',
'</li>',
'<li><b>Map Display: Oracle Mapviewer / Oracle Maps:</b><br/>',
'<p>',
'For Map Display, this application uses an APEX Plugin for integrate Oracle Maps. Oracle Maps is a part of Oracle Fusion Middleware, which is able to render spatial data stored in the database as a map. Oracle Maps can be integrated into any applicati'
||'on by using a JavaScript API to display and configure the map as well as to react on user interactions like zooming in or out or using map features. This APEX application encapsulates the Oracle Maps JavaScript Code in a set of APEX Region and Dynami'
||'c Action Plugins, which makes the usage of Oracle Maps very simple and intuitive. ',
'</p>',
'<p>',
'The map server used by this sample application is Oracle''s eLocation Service (aka ''maps.oracle.com''). As an alternative, you might deploy Oracle Maps within your own IT infrastructure. In that case, the maps can be customized in much more detail - e.'
||'g. the map design. More information on Oracle MapViewer and Oracle Maps can be found on the <a href="http://www.oracle.com/technetwork/middleware/mapviewer/overview/index.html" target="_blank">Oracle MapViewer OTN Page</a>.',
'</p>',
'</ul>'))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'N'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(2278959953963721601)
,p_name=>'&APP_NAME.'
,p_template=>wwv_flow_api.id(2134505980352489239)
,p_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_css_classes=>'t-HeroRegion--featured'
,p_icon_css_classes=>'app-sample-geolocation'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-AVPList--rightAligned'
,p_new_grid_row=>false
,p_grid_column_span=>4
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select aa.version app_version,',
'       to_char(aa.pages,''999G999G990'') pages,',
'       ''Oracle'' vendor',
'from apex_applications aa',
'where aa.application_id = :APP_ID'))
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(2134524329494489286)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2278960056342721602)
,p_query_column_id=>1
,p_column_alias=>'APP_VERSION'
,p_column_display_sequence=>1
,p_column_heading=>'App version'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2278960179650721603)
,p_query_column_id=>2
,p_column_alias=>'PAGES'
,p_column_display_sequence=>2
,p_column_heading=>'Pages'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2278960237486721604)
,p_query_column_id=>3
,p_column_alias=>'VENDOR'
,p_column_display_sequence=>3
,p_column_heading=>'Vendor'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.component_end;
end;
/
