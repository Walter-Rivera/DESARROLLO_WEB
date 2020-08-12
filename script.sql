/*Creando tablas con solo llave primaria
EL sigueinte DDL estará orientado a una base de datos
mysql

Restricciones:
1.- El nombre de las llaves primarias irá compuesto por las iniciales
de cada palabra del nombre de la tabla
    * Se es primaria se agregará al inicio PK_
    *SI es foránea se agregará al inicio FK_
    *Si es una llave primaria compuesta, se agregará al inicio PKC_
    *Si es una llave foránea compuesta, se agregará al inici FKC_.

*/

CREATE TABLE ESTADO_PERITO
(
    ID_ESTADO_PERITO INT(3),
    NOMBRE VARCHAR(100)
);

/*AGREGANDO LLAVE PRIMARIA*/
ALTER TABLE ESTADO_PERITO ADD CONSTRAINT PK_EP PRIMARY KEY(ID_ESTADO_PERITO);
/*VOLVIENDO LA LLAVE PRIMARIA COMO CAMPO AUTOINCREMENTABLE*/
ALTER TABLE ESTADO_PERITO MODIFY COLUMN ID_ESTADO_PERITO INT(3) AUTO_INCREMENT;



CREATE TABLE ESTADO_GESTION
(
    ID_ESTADO_GESTION INT(3),
    NOMBRE VARCHAR(100)
);
ALTER TABLE ESTADO_GESTION ADD CONSTRAINT PK_EG PRIMARY KEY(ID_ESTADO_GESTION);
ALTER TABLE ESTADO_GESTION MODIFY COLUMN ID_ESTADO_GESTION INT(3) AUTO_INCREMENT;



CREATE TABLE TIPO_MOVIMIENTO_GESTION
(
    ID_TIPO_MOV INT(3),
    DESCRIPCION VARCHAR(100)
);
ALTER TABLE TIPO_MOVIMIENTO_GESTION ADD CONSTRAINT PK_TMG PRIMARY KEY(ID_TIPO_MOV);
ALTER TABLE TIPO_MOVIMIENTO_GESTION MODIFY COLUMN ID_TIPO_MOV INT(3) AUTO_INCREMENT;




CREATE TABLE CAMPO_AFECTADO_GESTION
(
    ID_CAMPO INT(3),
    NOMBRE VARCHAR(100)
);
ALTER TABLE CAMPO_AFECTADO_GESTION ADD CONSTRAINT PK_CAG PRIMARY KEY(ID_CAMPO);
ALTER TABLE CAMPO_AFECTADO_GESTION MODIFY COLUMN ID_CAMPO INT(3) AUTO_INCREMENT;




CREATE TABLE ESTADO_USUARIO
(
    ID_ESTADO_USR INT(3),
    NOMBRE VARCHAR(100)
);
ALTER TABLE ESTADO_USUARIO ADD CONSTRAINT PK_EU PRIMARY KEY(ID_ESTADO_USR);
ALTER TABLE ESTADO_USUARIO MODIFY COLUMN ID_ESTADO_USR INT(3) AUTO_INCREMENT;




CREATE TABLE ROL_USUARIO
(
    ID_ROL INT(3),
    DESCRIPCION VARCHAR(100)
);
ALTER TABLE ROL_USUARIO ADD CONSTRAINT PK_RU PRIMARY KEY(ID_ROL);
ALTER TABLE ROL_USUARIO MODIFY COLUMN ID_ROL INT(3) AUTO_INCREMENT;




CREATE TABLE SECCION
(
    ID_SECCION INT(3),
    NOMBRE VARCHAR(100)
);
ALTER TABLE SECCION ADD CONSTRAINT PK_SEC PRIMARY KEY(ID_SECCION);
ALTER TABLE SECCION MODIFY COLUMN ID_SECCION INT(3) AUTO_INCREMENT;



CREATE TABLE CLASE_GESTION
(
    ID_CLASE_GESTION INT(3),
    NOMBRE VARCHAR(100)
);
ALTER TABLE CLASE_GESTION ADD CONSTRAINT PK_CS PRIMARY KEY(ID_CLASE_GESTION);
ALTER TABLE CLASE_GESTION MODIFY COLUMN ID_CLASE_GESTION INT(3) AUTO_INCREMENT;



/*en esta parte inician las tables con llaves primareas y foráneas*/


/* En el caso de la tabla PERITO, no se definirá como autoincrementable
el campo del id_perito, a causa que este número será el Número de Identificación
Personal (NIP) que posee cada colaborador el cual es designado por la unidad
de Recrusos humanos*/
CREATE TABLE PERITO
(
    ID_PERITO INT(6),
    NOMBRES VARCHAR(200),
    APELLIDOS VARCHAR(100),
    FECHA_CREACION TIMESTAMP,
    ID_ESTADO_PERITO INT(3)
);
ALTER TABLE PERITO ADD CONSTRAINT PK_PER PRIMARY KEY(ID_PERITO);
ALTER TABLE PERITO ADD CONSTRAINT FK_EP FOREIGN KEY(ID_ESTADO_PERITO) 
REFERENCES ESTADO_PERITO(ID_ESTADO_PERITO);


/*al igual que la tabla PERITO, la tabla USUARIO_SISTEMA
no poseerá en su id de llave primaria la característica de ser 
autoncrementable, pues el ID_USUARIO será ingresado conforme 
la asignación del NIP (Número de identifiacción Personal) 
al personal

El campo de contraseña (acceso) será encriptado posteriormente
cuando se inserten los datos a traves del algoritmo y funcion
que dota mysql SHA*
*/

CREATE TABLE USUARIO_SISTEMA
(
    ID_USUARIO INT(6),
    NOMBRES VARCHAR(200),
    APELLIDOS VARCHAR(100),
    FECHA_CREACION TIMESTAMP,
    ID_ESTADO_USR INT(3),
    ID_ROL INT(3),
    ACCESSO VARCHAR(200)
);
ALTER TABLE USUARIO_SISTEMA ADD CONSTRAINT PK_US PRIMARY KEY(ID_USUARIO);
ALTER TABLE USUARIO_SISTEMA ADD CONSTRAINT FK_IEU FOREIGN KEY(ID_ESTADO_USR)
REFERENCES ESTADO_USUARIO(ID_ESTADO_USR);
ALTER TABLE USUARIO_SISTEMA ADD CONSTRAINT FK_IDR FOREIGN KEY(ID_ROL)
REFERENCES ROL_USUARIO(ID_ROL);



CREATE TABLE TIPO_GESTION
(
    ID_TIPO_GESTION INT(3),
    NOMBRE VARCHAR(100),
    ID_CLASE_GESTION INT(3)
);
ALTER TABLE TIPO_GESTION ADD CONSTRAINT PK_TG PRIMARY KEY(ID_TIPO_GESTION);
ALTER TABLE TIPO_GESTION MODIFY COLUMN ID_TIPO_GESTION INT(3) AUTO_INCREMENT;
ALTER TABLE TIPO_GESTION ADD CONSTRAINT FK_ICG FOREIGN KEY(ID_CLASE_GESTION)
REFERENCES CLASE_GESTION(ID_CLASE_GESTION);



/*tabla principal sobre la cual será el ingreso de información
continua
    * EL campo correlativo será la llave primaria combinada
    con el campo anio, pero no sererá autoincrementable pues 
    como se detalló anteriormente, este numero se reinicia al 
    concluir cada año y es por esta causa que debe combinarse
    la restricción de llave primaria entre los 2 campos.
*/

CREATE TABLE GESTION
(
    CORRELATIVO INT(6),
    ANIO INT(4),
    ID_SECCION INT(3),
    ID_PERITO_RESPONSABLE INT(6),
    FECHA_INGRESO TIMESTAMP,
    FECHA_EGRESO DATETIME,
    ID_ESTADO_GESTION INT(3),
    ID_TIPO_GESTION INT(3),
    OBSERVACIONES VARCHAR(600),
    IMAGEN_ARCHIVO BLOB
);
ALTER TABLE GESTION ADD CONSTRAINT PK_GEST PRIMARY KEY(CORRELATIVO,ANIO);
ALTER TABLE GESTION ADD CONSTRAINT FK_IDSEC FOREIGN KEY(ID_SECCION)
REFERENCES SECCION(ID_SECCION);
ALTER TABLE GESTION ADD CONSTRAINT FK_IDPRESP FOREIGN KEY(ID_PERITO_RESPONSABLE)
REFERENCES PERITO(ID_PERITO);
ALTER TABLE GESTION ADD CONSTRAINT FK_IEG FOREIGN KEY(ID_ESTADO_GESTION) REFERENCES
ESTADO_GESTION(ID_ESTADO_GESTION);
ALTER TABLE GESTION ADD CONSTRAINT FK_ITG FOREIGN KEY(ID_TIPO_GESTION) REFERENCES
TIPO_GESTION(ID_TIPO_GESTION);



/*A Continuación la tabla que jugará el papel de 
bitácora en el sistema para garantizar el no repudio 
de operaciones por parte de los usuarios del sistema
*/
CREATE TABLE BITACORA_GESTION
(
    ID_TRANSACCION INT(6),
    CORRELATIVO_AFECTADO INT(6),
    ANIO INT(4),
    ID_TIPO_MOV INT(3),
    ID_CAMPO_AFECTADO INT(3),
    FECHA_MOVIMIENTO TIMESTAMP,
    ID_USUARIO_RESP INT(6),
    VALOR_ANTERIOR VARCHAR(100),
    VALOR_NUEVO VARCHAR(100)
);
ALTER TABLE BITACORA_GESTION ADD CONSTRAINT PK_BG PRIMARY KEY(ID_TRANSACCION);
ALTER TABLE BITACORA_GESTION ADD CONSTRAINT FK_GEST FOREIGN KEY(CORRELATIVO_AFECTADO,ANIO)
REFERENCES GESTION(CORRELATIVO,ANIO);
ALTER TABLE BITACORA_GESTION ADD CONSTRAINT FK_ITM FOREIGN KEY(ID_TIPO_MOV)
REFERENCES TIPO_MOVIMIENTO_GESTION(ID_TIPO_MOV);
ALTER TABLE BITACORA_GESTION ADD CONSTRAINT FK_ICA FOREIGN KEY(ID_CAMPO_AFECTADO)
REFERENCES CAMPO_AFECTADO_GESTION(ID_CAMPO);
ALTER TABLE BITACORA_GESTION ADD CONSTRAINT FK_IUR FOREIGN KEY(ID_USUARIO_RESP)
REFERENCES USUARIO_SISTEMA(ID_USUARIO);








