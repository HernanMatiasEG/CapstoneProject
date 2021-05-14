prompt --application/shared_components/logic/application_items/licenseterms
begin
--   Manifest
--     APPLICATION ITEM: LICENSETERMS
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_flow_item(
 p_id=>wwv_flow_api.id(3013437804631082652)
,p_name=>'LICENSETERMS'
,p_protection_level=>'I'
);
wwv_flow_api.component_end;
end;
/