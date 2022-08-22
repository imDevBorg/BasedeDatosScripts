-- -------------------------------------------------------
--             TABLE
-- -------------------------------------------------------

CREATE TABLE personasTutorial (
    idPersonas NUMBER(10),
    nombre VARCHAR2(100),
    apellido VARCHAR2(100),
    estado NUMBER(10),
    CONSTRAINT personasTuto PRIMARY KEY (idPersonas)
);

-- -------------------------------------------------------
--             SEQUENCE
-- -------------------------------------------------------
CREATE SEQUENCE personas_tuto_seq START WITH 1;

-- -------------------------------------------------------
--             TRIGGER SEQUENCE
-- -------------------------------------------------------
CREATE OR REPLACE TRIGGER personasTuto_id
BEFORE INSERT ON personasTutorial
FOR EACH ROW
BEGIN
    SELECT personas_tuto_seq.NEXTVAL
    INTO :new.idPersonas
    from dual;
END;

-- -------------------------------------------------------
--             INSERT
-- -------------------------------------------------------

INSERT INTO personasTutorial (nombre, apellido, estado) VALUES ('Mario','Perez',1);
INSERT INTO personasTutorial (nombre, apellido, estado) VALUES ('Carlos','Fuentes',1);
INSERT INTO personasTutorial (nombre, apellido, estado) VALUES ('Pedro','Araya',1);
COMMIT;

-- -------------------------------------------------------
--             STORE PROCEDURE->Procedimiento Almacenado
-- -------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertPersonasTuto(
    vnombre in personasTutorial.nombre%type,
    vapellido in personasTutorial.apellido%type,
    vestado in personasTutorial.estado%type
)
as
BEGIN
    INSERT INTO personasTutorial (nombre, apellido, estado) VALUES (vnombre,vapellido,vestado);
    COMMIT;
END;

-- -------------------------------------------------------
--                          Cursor
-- -------------------------------------------------------
CREATE OR REPLACE PACKAGE types
AS
    TYPE ref_cursor_t IS REF CURSOR;
END;

-- -------------------------------------------------------
--                          Función
-- -------------------------------------------------------
CREATE OR REPLACE FUNCTION finAllTutoPersonas
return types.ref_cursor_t
as
    find_persona types.ref_cursor_t;
BEGIN
    open find_persona for
    SELECT idPersonas, nombre, apellido, estado from personasTutorial;
return find_persona;
END;

-- -------------------------------------------------------
--                          SELECT
-- -------------------------------------------------------
SELECT *FROM personasTutorial;
