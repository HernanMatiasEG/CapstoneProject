prompt --application/shared_components/security/app_access_control/test
begin
--   Manifest
--     ACL ROLE: Test
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_acl_role(
 p_id=>wwv_flow_api.id(331333472479068827)
,p_static_id=>'TEST'
,p_name=>'Test'
);
wwv_flow_api.component_end;
end;
/
