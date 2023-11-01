SELECT 
	cons.nombre AS nombre_consorcio,
    IFNULL(JSON_UNQUOTE(JSON_EXTRACT(cons.direccion, '$.CALLE')) , cons.direccion) AS calle,
    JSON_UNQUOTE(JSON_EXTRACT(cons.direccion, '$.N°')) AS numero,
    prov.descripcion AS nombre_provincia,
    loc.descripcion AS nombre_localidad,
    concat(JSON_UNQUOTE(JSON_EXTRACT(conser.apeynom, '$.NOMBRE')), ', ',JSON_UNQUOTE(JSON_EXTRACT(conser.apeynom, '$.APELLIDO') )) AS nombre_conserje,
	concat(JSON_UNQUOTE(JSON_EXTRACT(admin.apeynom, '$.NOMBRE')), ', ', JSON_UNQUOTE(JSON_EXTRACT(admin.apeynom, '$.APELLIDO') ) ) AS nombre_administrador
FROM base_consorcio.consorcio AS cons
INNER JOIN base_consorcio.administrador AS admin
	ON cons.idadmin = admin.idadmin
INNER JOIN base_consorcio.provincia AS prov
	ON cons.idprovincia = prov.idprovincia
INNER JOIN base_consorcio.localidad AS loc
	ON cons.idlocalidad = loc.idlocalidad 
	AND loc.idprovincia = prov.idprovincia
INNER JOIN base_consorcio.conserje AS conser
	on cons.idconserje = conser.idconserje
WHERE cons.idadmin = 175;