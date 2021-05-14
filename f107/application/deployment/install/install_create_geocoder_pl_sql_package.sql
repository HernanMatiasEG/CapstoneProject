prompt --application/deployment/install/install_create_geocoder_pl_sql_package
begin
--   Manifest
--     INSTALL: INSTALL-Create Geocoder PL/SQL Package
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1191909882484463
,p_default_application_id=>107
,p_default_id_offset=>21836620500956796
,p_default_owner=>'BILL_AND_COLL'
);
wwv_flow_api.create_install_script(
 p_id=>wwv_flow_api.id(2950762789259393610)
,p_install_id=>wwv_flow_api.id(46757835926195345171)
,p_name=>'Create Geocoder PL/SQL Package'
,p_sequence=>40
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create or replace package eba_spatial_gcdr_pkg is',
'  function ajax_elocation_geocoder (',
'    p_dynamic_action in apex_plugin.t_dynamic_action,',
'    p_plugin         in apex_plugin.t_plugin ',
'  ) return apex_plugin.t_dynamic_action_ajax_result;',
'',
'  function render_elocation_geocoder(',
'    p_dynamic_action in apex_plugin.t_dynamic_action,',
'    p_plugin         in apex_plugin.t_plugin )',
'    return apex_plugin.t_dynamic_action_render_result;',
'',
'  function check_geocoder_http_access return varchar2;',
'end eba_spatial_gcdr_pkg;',
'/',
'',
'begin',
'execute immediate ''create or replace package body eba_spatial_gcdr_pkg wrapped ''||chr(10)||',
'''a000000''||chr(10)||',
'''1''||chr(10)||',
'''abcd''||chr(10)||',
'''abcd''||chr(10)||',
'''abcd''||chr(10)||',
'''abcd''||chr(10)||',
'''abcd''||chr(10)||',
'''abcd''||chr(10)||',
'''abcd''||chr(10)||',
'''abcd''||chr(10)||',
'''abcd''||chr(10)||',
'''abcd''||chr(10)||',
'''abcd''||chr(10)||',
'''abcd''||chr(10)||',
'''abcd''||chr(10)||',
'''abcd''||chr(10)||',
'''abcd''||chr(10)||',
'''b''||chr(10)||',
'''270d e21''||chr(10)||',
'''kHzw3ed1NlNtqeDm3Ek7oszD2sowg5Wr9scTlw1Pc9Vh8rup6N/xbld4YYZobVCjZjVnOFIG''||chr(10)||',
'''KfUE6WZlxwFp+0OzHuT+QUxwk2dhQ4CwkuBwcviKQoqTBeUzNaQLIaBgnBbOek7rgVaZF9Wq''||chr(10)||',
'''rQ8U+ZLQbCVV7cdyd+NIWFoQZD+bLTjexRCBxrQl2POfyDQHyM3Q0S4y5fa87B0epiCGrrx5''||chr(10)||',
'''MAtVw1oLEE/uXW1N5A24mwft0cB8CG6YPpJZeluYQTVNtIkO7vanOM6mQIjWmT2zG+XHFp2K''||chr(10)||',
'''v+6BXXRCYfCkvj7tUdMGfYTQcJ0kfUFvoOjFsxteaTqzoMutYtebWQZxknuv68azI/reJozz''||chr(10)||',
'''Tc0iNzzV3NlpoTUXmEq/aYjSrfOl1O/00tAMZgvXSZzfYLJm1lUNIx2jPS53FDObpbGxncBV''||chr(10)||',
'''TH4KSvJWsMv1WogZSTPzF4Henv3LRr+lJOyKh4H4ygBp8Rn5M3MjArw5oavUs5MXDtLaFuOL''||chr(10)||',
'''CGZfpxeQfPAoGTSteyIE9Wns11GVfpSAr5PBgMifPxLE6kDZBQEvHfKPSa+deDXs++0R80kX''||chr(10)||',
'''kHCUcqhKhk1e+x3Ofi1arCGB6jjs9JlLjmAeLoucEYHpvHGPjB6T352bZDdOk8GVmRyUlof1''||chr(10)||',
'''7OOpRfS8271wka/h14YuiWwkFisttT7/bR8Cv3RVNmYgEuHyDPGHLolAb+0FPTAFBeJzBYdq''||chr(10)||',
'''47sa7EmQ+Hq9P1bMcmFCgbXuJDaKpzhh+qQ2s+fJYNVUBk/D5iSBQZXmxFQHHY0yFf52jKyt''||chr(10)||',
'''xbIwjQEe0hqxhvLVUmUTZOEBHA+c2LcZwEE5vVRhBjsxrPt+HSVPoaUEl/MvAASldbwdJ1BZ''||chr(10)||',
'''KPUdRdeK3UaJ3AXI4BhXe9PSPZfFNiTXS0BsAtMOo+na6qDr7ajoY0vdBO5reCvoyr2JIFiz''||chr(10)||',
'''DXMGlJDthNOW600htb1VGKFAjun3M5l0HQ9wHUGmhMoKNeEswfZw4seZqcfN0seoltbcy6lX''||chr(10)||',
'''0acvWHADLWxnwaM2zB3gapXEN1jhda3hK18LslCvYWsnVIss/vfD2SQlIsCWTAHm/5SKJw73''||chr(10)||',
'''uyfCacSYVj27Z7eVW2mE41QiMi10qi4ge0YYx6jqXMIFRKWGhoazUnNJzQyzxYGM1zLIRseq''||chr(10)||',
'''PyrWYpA1h1e3FAEP8RpVbGuvEpwU6SYQ8RQusfmBP5pInKcXMhtSBR/D4C1OKZ8TLnRjLmvb''||chr(10)||',
'''QegSxx0njgg9Of7n5w4/wyE9bCJUB4Bj3lPiQ8gYo0htIdzCA3I4IQw/zgNLIabmLElFN07b''||chr(10)||',
'''4Tl972rCimaZwtDd8nhMBufS2+g37bQCIgI1DAloQM0U4cNMILQb9rvvWPNXhSnAFXrjHGcK''||chr(10)||',
'''5tHmHm9+ERfom1BmtvW5VOuSI0yC88y/997zkSNAUgfoSBweDZZ4eFCeXAFJnlCxMScdbPJR''||chr(10)||',
'''DM1z63BoRBYm6xJJVehB9sFZr1+qgOkuDnx3DToFeTH1nM9FQTVr0KdNim1N4T6S02A4I5RW''||chr(10)||',
'''3FCW3vcRN1SdoL0vCv031opB8JMii2u4IMM8g9Xena+d1ehosImclhM9nvsPw2GCOPJ5DsrN''||chr(10)||',
'''xXW1NbJEeaQdpkkHbXz4zDxrRVLysyzMjFDLoVwTV8BPyQwmQdb7q0ER+QoOmJcEtuNJVXYP''||chr(10)||',
'''TUBo3IMNM9B5o7xxMH0IMyGGIBGkFKAf6NQLRiIGqJF2weaxfMDAYdAKixHQmUlQw9TDwCiE''||chr(10)||',
'''ZpBwlBq4jfPffK+w2vvZ1uIV/4N3ZaN2ATWJpMgsHmeDpCyKikM2yR6BxUe6FRn+1iCavKRp''||chr(10)||',
'''XnZ+8ZTaPkSZJnwttMD74G1yw3OpKXs+Oo0cDrLezcYzT7Rkp+iQL+akYBs844TyYUPTSM8G''||chr(10)||',
'''TegSy1SiT+DZ747gUJbqKamVLCWHSwZ32LqlVvanvQGcd+HO7z+MmG8AKIMdJk11roNUw4hX''||chr(10)||',
'''bUwPIFEVvHreACOCAK4ZWrFSiTnpBrRBpFMKLGwWg9XpY9aobiyGKlsKuEDE3b9KFyfSvqON''||chr(10)||',
'''AogJ/t69CW3qCnD/inMMGN0G9Xdv+YBLI0xc//5S5UG6y6vrWKPRT20mYOktUt7KdavRbSig''||chr(10)||',
'''9wuQMIz8HeeWvAMcg7AYiQ9LhqmVnpAecB/d56tR8R9SfBtDBdubcXH1SzTSNcomYPBFbb1/''||chr(10)||',
'''pY4TdlJ9KTkIfg9EIFKfQSb2RTure75WnZPLBBJpHdWj3Ny6H6AE8C1k0LT9HkIRsmkHOSAd''||chr(10)||',
'''FO7OEyBym4TQ1zUaCVs9MmtZ5ypGu3fRH2ql6OjZBYwlvTq6SNM/w1xrvbfAb+2aXuz8jELd''||chr(10)||',
'''+L2vC9cIBHYKHoXPBMrgH7np/gsfCx37voOZ/vqQrhhNLTbSg9TzMJ2537PWFPS2tasjCjHC''||chr(10)||',
'''Yme82VCQjsD7vOZ3lfRnyprxTa3EV34mLCBlOGg2SoXxyoU28gafSNw+uxr1lCAlqUHZIltR''||chr(10)||',
'''keYWDluzusa4NA8qeUwCs4SUssJ+lHGE+x9N9KjOyidPeO7FBdhzk9NHoiSe7vjKI9jAAvaF''||chr(10)||',
'''QTT0fkb5aqDwt+nIdOwGlN4LHjaS3MCVbl7S1ofUq+9ZcgjWuWHI3jqo2MbcQeJQ7T6MoUlU''||chr(10)||',
'''Vh0kcV0x5W0is2bMkLgTlPP/Wy8OfoXdrkk9wD9Pwjuif1M/qmcfAppUJrGmOfW04YOjqxZ9''||chr(10)||',
'''2W99pxivyg8NrcSevR16J/tICpZ00jKZ9boxOA6dYWfEw+85OuhiTRlQQ1NEwg1dCbQ1nWKG''||chr(10)||',
'''p/JHZwX/3omABXjERUuzZXxL6LYK7ndUJiOe31gn8OgYOo5FIGdcC86b0UABcptf5IP98ooE''||chr(10)||',
'''zjG+dhZZ4zu0wtIXW/FSYaHaSU2GI+w5HB7kR3ITlS7or8FFjnOnE1x7ZYvEZMumFQhRslxh''||chr(10)||',
'''TyidqVVznm9DAEfRsUsCbr4jEopmMzriOE+70zM64nBPu+Ez+urIcsDW+HT+xHIwEvZdxMrI''||chr(10)||',
'''di5RTx5puaPqWgafdgslooVEI7uLLj2n1Xo+By9kAVAdMzAyKl5Sra3W6inZG5fQEsAfc6Gw''||chr(10)||',
'''hNLv5gMypUz6ZAOJgScDdO++o6KkKYvoYyGQx+aLBmfhKs47c+mlQgN6Nar4xb88ir7rVZyi''||chr(10)||',
'''5xEOgVZTQNaBJFhF1wp268Do5cwTM+pF55b14AU+OUwNpuCZ+E1xCgKiSsMZpmtMKU6QaA7X''||chr(10)||',
'''xLBneE8PUe2Y507R8pLqARNP+FFcRLctaluQ3F0iiR2l7nb/qgjFaSsI0xmuWO/WZFAU1ZPT''||chr(10)||',
'''0Zw1ZpYGOkCf18rNerwzTgpZTxl5i7Veak2fRbAk9rmheE6toN6UeBRkgAN+OVYsrwvzgPsB''||chr(10)||',
'''qBb6LJiwlYZyg+LqGQof5QqtRS7Ph1Ki+FWjRUhiDLDmzSUbVPhpsjy0IS4BAS0Uo0Bs+HKk''||chr(10)||',
'''1K9hWbTV0vnS9a5f/837cUBwOv4phpe17t3T9KsicOBCBUeba799XAfHmnEDbkzfrQYmLtEQ''||chr(10)||',
'''/HaTfZxh12fQl2D0c6SysNHbu2mtsMH7DuCt5cc+6ouP/jc9eurATn0WHRAFK5F41vXaGbzr''||chr(10)||',
'''EYLpqKVpgUxX1SnFLqnvxsQkXymDD/mZG0P9Kw==''||chr(10)||chr(10);',
'end;',
'/',
''))
);
wwv_flow_api.create_install_object(
 p_id=>wwv_flow_api.id(1893130484876738313)
,p_script_id=>wwv_flow_api.id(2950762789259393610)
,p_object_owner=>'#OWNER#'
,p_object_type=>'PACKAGE'
,p_object_name=>'EBA_SPATIAL_GCDR_PKG'
,p_last_updated_on=>to_date('20141219062107','YYYYMMDDHH24MISS')
,p_created_on=>to_date('20141219062107','YYYYMMDDHH24MISS')
);
wwv_flow_api.component_end;
end;
/
