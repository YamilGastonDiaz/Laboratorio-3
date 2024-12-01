USE ModeloExamen20242C

GO
CREATE TRIGGER TR_REGISTRO ON PlantaDocente
INSTEAD OF INSERT 
AS 
BEGIN
    DECLARE @anioIngreso INT;
    DECLARE @anio INT;
    DECLARE @cargo TINYINT;
    DECLARE @materia BIGINT;
    DECLARE @legajo BIGINT;

    SELECT @anio = Año, @cargo = ID_Cargo, @materia = ID_Materia, @legajo = Legajo
    FROM inserted

    -- Obtenemos el año de ingreso desde la tabla Docentes con Legajo
    SELECT @anioIngreso = AñoIngreso 
    From Docentes
    WHERE @legajo = Legajo

    -- Verificamos si el cargo es de profesor 
    IF(@cargo = 1) 
    BEGIN
        IF(@año - @añoIngreso ) < 5 
        BEGIN
            RAISERROR ('El Docente no tiene la antiguedad sufiente para el Cargo Profesor', 16, 1)
            ROLLBACK TRANSACTION
            RETURN
        END

        -- Verificar que no exista otro docente
        IF(SELECT COUNT(*) FROM PlantaDocente WHERE @materia = ID_Materia AND @año = Año AND @cargo = ID_Cargo) = 1 
        BEGIN 
            RAISERROR('Ya existe un Docente con el mismo Cargo para la materia y año', 16, 1)
            ROLLBACK TRANSACTION
            RETURN
        END
    END 

    --Si no se cumple ninguna de las condiciones anteriores, insertamos el registro
    INSERT INTO PlantaDocente(Legajo, ID_Materia, ID_Cargo, Año)
    VALUES(@legajo, @materia, @cargo, @año)
END

GO
CREATE FUNCTION FN_CANT_HORA_SEMANALES
(
    @LEGAJO BIGINT,
    @ANIO INT
) RETURNS INT
AS
BEGIN
    DECLARE @CALCULARHORAXSEMANA INT

    SET @CALCULARHORAXSEMANA = 0

    SELECT @CALCULARHORAXSEMANA = COALESCE(SUM(M.HorasSemanales), 0)
    FROM Materias AS M
    INNER JOIN PlantaDocente AS PD ON M.ID_Materia = PD.ID_Materia
    WHERE @LEGAJO = PD.Legajo AND @ANIO = PD.Año

    RETURN @CALCULARHORAXSEMANA
END

GO
CREATE PROCEDURE SP_CANTIDAD_DOCENTES
(
    @ID_MATERIA BIGINT
)
AS
BEGIN
    SELECT COUNT(*) AS CANTIDAD_DOCENTES
    FROM PlantaDocente AS PD
    INNER JOIN  Materias AS M ON PD.ID_Materia = M.ID_Materia
    WHERE @ID_MATERIA = PD.ID_Materia
END