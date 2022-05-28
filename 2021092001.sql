SELECT _t.* FROM (
 SELECT id , js_search_key , js_search_value , 
        REPLACE(json_extract(form_json,js_search_key),'"','') AS column_key,
        REPLACE(json_extract(form_json,js_search_value),'"','') AS column_value
	FROM (
		SELECT id , form_json , 
		json_extract(json_extract(form_json,'$.fields'),'$[*].__vModel__')AS js_key ,
		json_extract(json_extract(form_json,'$.fields'),'$[*].__config__')AS js_value,
		REPLACE(json_search(form_json,'one','DH'),'"','') AS js_search_key,
		REPLACE(REPLACE(json_search(form_json,'one','DH'),'"',''),'__vModel__','__config__.defaultValue') AS js_search_value
		FROM archive_reorginze 
	)t
 UNION ALL
 SELECT id , js_search_key , js_search_value , 
        REPLACE(json_extract(form_json,js_search_key),'"','') AS column_key,
        REPLACE(json_extract(form_json,js_search_value),'"','') AS column_value
	FROM (
	SELECT id , form_json , 
		json_extract(json_extract(form_json,'$.fields'),'$[*].__vModel__')AS js_key ,
		json_extract(json_extract(form_json,'$.fields'),'$[*].__config__')AS js_value,
		REPLACE(json_search(form_json,'one','GDND'),'"','') AS js_search_key,
		REPLACE(REPLACE(json_search(form_json,'one','GDND'),'"',''),'__vModel__','__config__.defaultValue') AS js_search_value
	FROM archive_reorginze )t
)_t
WHERE 1 > 0

GROUP BY id