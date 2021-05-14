--------------------------------------------------------
--  DDL for Package EBA_SPATIAL_GCDR_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "EBA_SPATIAL_GCDR_PKG" is
  function ajax_elocation_geocoder (
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin         in apex_plugin.t_plugin 
  ) return apex_plugin.t_dynamic_action_ajax_result;
  function render_elocation_geocoder(
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin         in apex_plugin.t_plugin )
    return apex_plugin.t_dynamic_action_render_result;
  function check_geocoder_http_access return varchar2;
end eba_spatial_gcdr_pkg;

/
