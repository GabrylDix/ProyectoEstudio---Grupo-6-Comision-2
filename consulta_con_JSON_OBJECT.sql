INSERT INTO base_consorcio.conserje (apeynom, tel, fechnac, estciv)
VALUES (JSON_OBJECT('APELLIDO', 'ACUÑA', 'NOMBRE', 'JUAN'), 3497615841, '1990-12-21', 'C');

SELECT JSON_OBJECT('NOMBRE', 'asdas') AS asdsa 
FROM base_consorcio.conserje
WHERE idconserje = 222;

SELECT 
	cons.idconserje,
	JSON_OBJECT('APELLIDO Y NOMBRE', apeynom) AS nombre,
    JSON_OBJECT('TELEFONO', tel) AS telefono,
    cons.fechnac,
    JSON_OBJECT('ESTADO CIVIL', CASE WHEN estciv = 'S' THEN 'SOLTERO' WHEN estciv = 'C' THEN 'CASADO' END) AS estado_civil
FROM base_consorcio.conserje AS cons;