CREATE VIEW provincia_localidad AS
SELECT 
	loc.idprovincia,
    prov.descripcion AS nombre_provincia,
    loc.idlocalidad,
    loc.descripcion AS nombre_localidad
FROM base_consorcio.localidad AS loc
INNER JOIN base_consorcio.provincia AS prov
	ON loc.idprovincia = prov.idprovincia;
    
CREATE VIEW consorcios_por_zona AS
SELECT 
	z.*,
    count(*) AS total_consorcios
FROM zona AS z
INNER JOIN consorcio AS c 
	ON z.idzona = c.idzona
GROUP BY z.idzona
ORDER BY COUNT(*) DESC;