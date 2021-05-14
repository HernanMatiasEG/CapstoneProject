prompt --application/shared_components/user_interface/themes
begin
--   Manifest
--     THEME: 107
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_theme(
 p_id=>wwv_flow_api.id(2134541102067489387)
,p_theme_id=>42
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_ui_type_name=>'DESKTOP'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_is_locked=>false
,p_default_page_template=>wwv_flow_api.id(2134494653367489202)
,p_default_dialog_template=>wwv_flow_api.id(2134491283082489196)
,p_error_template=>wwv_flow_api.id(2134485553389489184)
,p_printer_friendly_template=>wwv_flow_api.id(2134494653367489202)
,p_breadcrumb_display_point=>'REGION_POSITION_01'
,p_sidebar_display_point=>'REGION_POSITION_02'
,p_login_template=>wwv_flow_api.id(2134485553389489184)
,p_default_button_template=>wwv_flow_api.id(2134538875032489354)
,p_default_region_template=>wwv_flow_api.id(2134510792919489250)
,p_default_chart_template=>wwv_flow_api.id(2134510792919489250)
,p_default_form_template=>wwv_flow_api.id(2134510792919489250)
,p_default_reportr_template=>wwv_flow_api.id(2134510792919489250)
,p_default_tabform_template=>wwv_flow_api.id(2134510792919489250)
,p_default_wizard_template=>wwv_flow_api.id(2134510792919489250)
,p_default_menur_template=>wwv_flow_api.id(2134515349771489257)
,p_default_listr_template=>wwv_flow_api.id(2134510792919489250)
,p_default_irr_template=>wwv_flow_api.id(2134508943311489244)
,p_default_report_template=>wwv_flow_api.id(2134522634660489284)
,p_default_label_template=>wwv_flow_api.id(2134537883145489340)
,p_default_menu_template=>wwv_flow_api.id(2134538960698489357)
,p_default_calendar_template=>wwv_flow_api.id(2134539024530489360)
,p_default_list_template=>wwv_flow_api.id(2134531176795489315)
,p_default_nav_list_template=>wwv_flow_api.id(2134536183167489330)
,p_default_top_nav_list_temp=>wwv_flow_api.id(2134536183167489330)
,p_default_side_nav_list_temp=>wwv_flow_api.id(2134534886556489324)
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>wwv_flow_api.id(2134500010129489219)
,p_default_dialogr_template=>wwv_flow_api.id(2134499814373489217)
,p_default_option_label=>wwv_flow_api.id(2134537883145489340)
,p_default_required_label=>wwv_flow_api.id(2134538094671489343)
,p_default_page_transition=>'NONE'
,p_default_popup_transition=>'NONE'
,p_default_navbar_list_template=>wwv_flow_api.id(2134534684302489322)
,p_file_prefix => nvl(wwv_flow_application_install.get_static_theme_file_prefix(42),'#IMAGE_PREFIX#themes/theme_42/1.6/')
,p_files_version=>64
,p_icon_library=>'FONTAPEX'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#THEME_IMAGES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_IMAGES#css/Core#MIN#.css?v=#APEX_VERSION#'
);
wwv_flow_api.component_end;
end;
/
