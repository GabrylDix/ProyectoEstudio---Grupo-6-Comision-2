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

/* Muestra los datos de los consorcios (provincia, localidad, nombres, dirección y zona) que
pertenezcan a las dos zonas con mayor cantidad de consorcios.*/

SELECT prov.descripcion, loc.descripcion, c.nombre, c.direccion, c.idzona, zon.descripcion
FROM consorcio c 
INNER JOIN localidad loc ON c.idprovincia= loc.idProvincia AND c.idlocalidad= loc.idlocalidad
INNER JOIN provincia prov ON loc.idprovincia = prov.idprovincia
INNER JOIN zona zon ON c.idzona= zon.idzona
INNER JOIN (
    SELECT z.idzona
    FROM zona z
    INNER JOIN consorcio c ON z.idzona = c.idzona
    GROUP BY z.idzona
    ORDER BY COUNT(*) DESC
    LIMIT 2
) top_zonas ON c.idzona = top_zonas.idzona;

/*Seleccionar los consorcios que pertenezcan a la provincia con mayor número de habitantes, y 
mostrar los datos de los conserjes mayores a 50 años (ordenados de mayor a menor por edad)
que no estén asignados a estos consorcios. */

SELECT consj.apeynom,consj.tel,consj.estciv, YEAR(CURDATE())-YEAR(consj.fechnac) as 'Edad' FROM conserje consj where  YEAR(CURDATE())-YEAR(consj.fechnac) > 50  AND 
consj.idconserje NOT IN (SELECT cons.idconserje FROM consorcio cons where cons.idprovincia = (SELECT prov.idprovincia FROM provincia prov order by prov.poblacion desc limit 1))
ORDER BY YEAR(CURDATE())-YEAR(consj.fechnac) desc;