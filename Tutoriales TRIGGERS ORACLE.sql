DROP TRIGGER empleados_Tutorial_Trigger_id;
DROP TRIGGER update_history_log_tutorial;
DROP SEQUENCE empleados_tuto_trigger_seq;
Drop TABLE empleadosTutorialTriggers;
DROP TABLE history_log_tutorial;

--crear tabla
CREATE TABLE empleadosTutorialTriggers(
   idEmpleado NUMBER(10),
   nombre VARCHAR2(100),
   email VARCHAR2(100),
   puesto VARCHAR2(100),
   estado NUMBER(10),
   createdAt DATE DEFAULT SYSDATE,
   CONSTRAINT empleados_pk PRIMARY KEY(idEmpleado)
);



--Trigger de secuencia Oracle para PK

-- para oracle se crea una secuencia 
CREATE SEQUENCE empleados_tuto_trigger_seq START WITH 1;
--Trigger Secuencia 
create or replace TRIGGER empleados_Tutorial_Trigger_id 
BEFORE INSERT ON empleadosTutorialTriggers 
FOR EACH ROW

BEGIN
  SELECT empleados_tuto_trigger_seq.NEXTVAL
  INTO   :new.idEmpleado
  FROM   dual;
END;

--Insert table empleadosTutorialTriggers
INSERT INTO empleadosTutorialTriggers (nombre, email, puesto, estado, createdAt) Values('MARIO CASTRO','MARIOCASTRO@HOTMAIL.COM', 'PROGRAMADOR',1, SYSDATE);
INSERT INTO empleadosTutorialTriggers (nombre, email, puesto, estado, createdAt) Values('JUAN FUENTES','JUANFUENTES@HOTMAIL.COM', 'PROGRAMADOR',1, SYSDATE);
INSERT INTO empleadosTutorialTriggers (nombre, email, puesto, estado, createdAt) Values('PEDRO HERNANDEZ','PEDROHERNANDEZ@HOTMAIL.COM', 'PROGRAMADOR',1, SYSDATE);
COMMIT;

Select * from empleadosTutorialTriggers;


--TABLA HISTORICO 
CREATE TABLE history_log_tutorial(
   idEmpleado NUMBER(9),
   nombre VARCHAR2(100),
   puesto VARCHAR2(100),
   fechaContrato DATE,
   fechaUpdtDel DATE,
   accionStatement VARCHAR2(100)
);


CREATE OR REPLACE TRIGGER update_history_log_tutorial
 AFTER UPDATE OF estado OR DELETE ON empleadosTutorialTriggers
 FOR EACH ROW
BEGIN
 IF :OLD.estado = 1 THEN
   INSERT INTO history_log_tutorial(idEmpleado,nombre,puesto,fechaContrato,fechaUpdtDel,accionStatement) VALUES (:OLD.idEmpleado,:OLD.nombre,:OLD.puesto,:OLD.createdAt,SYSDATE,'UPDATE-ACTIVO');

 ELSIF :OLD.estado = 0 THEN
   INSERT INTO history_log_tutorial(idEmpleado,nombre,puesto,fechaContrato,fechaUpdtDel,accionStatement) VALUES (:OLD.idEmpleado,:OLD.nombre,:OLD.puesto,:OLD.createdAt,SYSDATE,'UPDATE-INACTIVO');

 ELSE
    INSERT INTO history_log_tutorial(idEmpleado,nombre,puesto,fechaContrato,fechaUpdtDel,accionStatement) VALUES (:OLD.idEmpleado,:OLD.nombre,:OLD.puesto,:OLD.createdAt,SYSDATE,'DELETE');
 END IF;

END;


UPDATE empleadosTutorialTriggers SET estado = 0 WHERE idEmpleado = 1;
UPDATE empleadosTutorialTriggers SET estado = -1 WHERE idEmpleado = 2;
COMMIT;

SELECT *FROM history_log_tutorial;
