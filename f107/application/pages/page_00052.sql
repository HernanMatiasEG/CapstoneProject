prompt --application/pages/page_00052
begin
--   Manifest
--     PAGE: 00052
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
 p_id=>52
,p_user_interface_id=>wwv_flow_api.id(46757782309074001702)
,p_tab_set=>'TS1'
,p_name=>'All Addresses'
,p_alias=>'ALL-ADDRESSES'
,p_step_title=>'All Addresses'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'ON'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.address-block {',
'    float: left;',
'    border: 1px solid #E0E0E0;',
'    border-radius: 4px;',
'    padding: 8px;',
'    background: #F8F8F8;',
'    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);',
'    margin: 0 8px 8px 0;',
'}',
'.address-block:hover {',
'    border-color: #9DB3D4;',
'    background-color: #EFF3FA;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_nav_list_template_options=>'#DEFAULT#'
,p_help_text=>'No help is available for this page.'
,p_last_upd_yyyymmddhh24miss=>'20200924024447'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(2142735629809906470)
,p_name=>'Addresses'
,p_template=>wwv_flow_api.id(2134510792919489250)
,p_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Region--hideHeader'
,p_component_template_options=>'#DEFAULT#:u-colors:t-Cards--displaySubtitle:t-Cards--basic:t-Cards--displayInitials:t-Cards--4cols:t-Cards--desc-3ln:t-Cards--animColorFill'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'apex_util.prepare_url(''f?p=''||:APP_ID||'':51:''||:APP_SESSION||'':::51:P51_ID:''||c.id) card_link,',
'  c.id,',
'  c.addr_name card_title,',
'  c.addr_street ||  '' '' ||',
'  c.addr_city || '' '' ||',
'  c.addr_state || '' '' ||',
'  cn.country_name || '' '' ||',
'  c.addr_postal_code as card_text,',
'  initcap( addr_type ) as card_subtitle,',
'  case when',
'    addr_location is null then ''[No Location]'' ',
'    else eba_spatial_sample.geom_to_string(addr_location) ',
'  end as card_subtext,',
'decode(instr(addr_name,'' ''),',
'                 0, ',
'                 substr(addr_name,1,2),',
'                 substr(addr_name,1,1)||substr(addr_name,instr(addr_name,'' '')+1,1)',
'           ) card_initials',
'from eba_spatial_addresses c, eba_spatial_countries cn',
'where cn.code=c.addr_country'))
,p_display_when_condition=>'P52_VIEW'
,p_display_when_cond2=>'C'
,p_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(2134519208002489274)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2142737082823906484)
,p_query_column_id=>1
,p_column_alias=>'CARD_LINK'
,p_column_display_sequence=>6
,p_column_heading=>'Card link'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2142735724834906471)
,p_query_column_id=>2
,p_column_alias=>'ID'
,p_column_display_sequence=>1
,p_column_heading=>'Id'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2142736595508906479)
,p_query_column_id=>3
,p_column_alias=>'CARD_TITLE'
,p_column_display_sequence=>2
,p_column_heading=>'Card title'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2142736781372906481)
,p_query_column_id=>4
,p_column_alias=>'CARD_TEXT'
,p_column_display_sequence=>4
,p_column_heading=>'Card text'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(230694325489241457)
,p_query_column_id=>5
,p_column_alias=>'CARD_SUBTITLE'
,p_column_display_sequence=>7
,p_column_heading=>'Card Subtitle'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2142736650886906480)
,p_query_column_id=>6
,p_column_alias=>'CARD_SUBTEXT'
,p_column_display_sequence=>3
,p_column_heading=>'Card subtext'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2142736888779906482)
,p_query_column_id=>7
,p_column_alias=>'CARD_INITIALS'
,p_column_display_sequence=>5
,p_column_heading=>'Card initials'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2430100811667098770)
,p_plug_name=>'Addresses'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'DEFAULT'
,p_plug_template=>wwv_flow_api.id(2134508943311489244)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id, addr_name, addr_street, addr_city, addr_country, addr_postal_code, initcap(addr_type) addr_type,    ',
'       case when',
'           addr_location is null then null',
'       else eba_spatial_sample.geom_to_string(addr_location) ',
'       end as location',
' from eba_spatial_addresses',
' ',
' ',
' '))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P52_VIEW'
,p_plug_display_when_cond2=>'I'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(2430100934100098771)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLSX:PDF:RTF'
,p_owner=>'JOEL'
,p_internal_uid=>2196829232852347902
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2430101109793098773)
,p_db_column_name=>'ID'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2430101628499098778)
,p_db_column_name=>'ADDR_NAME'
,p_display_order=>30
,p_column_identifier=>'G'
,p_column_label=>'Address Name'
,p_column_link=>'f?p=&APP_ID.:51:&SESSION.::&DEBUG.:RP:P51_ID:#ID#'
,p_column_linktext=>'#ADDR_NAME#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2430101725407098779)
,p_db_column_name=>'ADDR_STREET'
,p_display_order=>40
,p_column_identifier=>'H'
,p_column_label=>'Street'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2430101858562098780)
,p_db_column_name=>'ADDR_CITY'
,p_display_order=>50
,p_column_identifier=>'I'
,p_column_label=>'City'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2430101958632098781)
,p_db_column_name=>'ADDR_COUNTRY'
,p_display_order=>60
,p_column_identifier=>'J'
,p_column_label=>'Country'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2430102066399098782)
,p_db_column_name=>'ADDR_POSTAL_CODE'
,p_display_order=>70
,p_column_identifier=>'K'
,p_column_label=>'Postal Code'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2430102179125098783)
,p_db_column_name=>'LOCATION'
,p_display_order=>80
,p_column_identifier=>'L'
,p_column_label=>'Location'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(230694230186241456)
,p_db_column_name=>'ADDR_TYPE'
,p_display_order=>90
,p_column_identifier=>'M'
,p_column_label=>'Type'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(2430108169717103162)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'21968365'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ADDR_TYPE:ADDR_NAME:ADDR_STREET:ADDR_CITY:ADDR_COUNTRY:ADDR_POSTAL_CODE:LOCATION:'
,p_sort_column_1=>'ADDR_NAME'
,p_sort_direction_1=>'ASC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2430102264583098784)
,p_plug_name=>'Button Bar'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--noPadding:t-ButtonRegion--noUI'
,p_plug_template=>wwv_flow_api.id(2134500010129489219)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2264977520500156783)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(2276914398625662372)
,p_button_name=>'NEW_ADDRESS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(2134538875032489354)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'New Address'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>'f?p=&APP_ID.:51:&SESSION.::&DEBUG.:RP,51::'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2430102327255098785)
,p_name=>'P52_VIEW'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(2430102264583098784)
,p_prompt=>'View'
,p_source=>'C'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'VIEW OPTIONS'
,p_lov=>'.'||wwv_flow_api.id(2430119217531199555)||'.'
,p_cHeight=>1
,p_tag_css_classes=>'mnw100'
,p_field_template=>wwv_flow_api.id(2134537883145489340)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'REDIRECT_SET_VALUE'
);
wwv_flow_api.component_end;
end;
/
