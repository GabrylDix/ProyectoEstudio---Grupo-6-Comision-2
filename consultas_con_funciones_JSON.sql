USE base_consorcio;

SELECT * FROM base_consorcio.conserje 
WHERE JSON_VALID(apeynom);

SELECT JSON_UNQUOTE(JSON_EXTRACT(apeynom, '$.NOMBRE')) AS nombre
FROM base_consorcio.conserje
WHERE idconserje = 222;

SELECT * FROM base_consorcio.conserje WHERE idconserje = 222;

INSERT INTO base_consorcio.conserje (apeynom, tel, fechnac, estciv) 
VALUES ('{"APELLIDO": "GAUNA", "NOMBRE": "PEDRO"}', 3794651348, '1998-12-12', 'S');

UPDATE base_consorcio.conserje
SET apeynom =  JSON_REMOVE(apeynom, '$.NOMBRE') 
WHERE idconserje = 222;

UPDATE base_consorcio.conserje
SET apeynom = JSON_INSERT(apeynom, '$.NOMBRE', 'PEDRO') 
WHERE idconserje = 222;

UPDATE base_consorcio.conserje
SET apeynom = JSON_REPLACE(apeynom, '$.NOMBRE', 'SERGIO') 
WHERE idconserje = 222;