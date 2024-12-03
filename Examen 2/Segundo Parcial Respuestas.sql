USE SegundoParcial20242C

SELECT * FROM Importaciones
SELECT * FROM Clientes
SELECT * FROM Provincias
SELECT * FROM Envios


GO
CREATE TRIGGER TR_AGREGARARANCEL 
ON Importaciones
AFTER INSERT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
                DECLARE @idCliente INT
                DECLARE @valorImportacion INT
                DECLARE @fechaImportacion DATE
                DECLARE @impuestoProvincial INT
                DECLARE @idprovincia INT
                DECLARE @arancel MONEY
                DECLARE @AcumuladoAnual MONEY


                SELECT @idCliente = ID_Cliente, @valorImportacion = Valor, @fechaImportacion = Fecha
                FROM INSERTED

                SELECT @idprovincia = ID_Provincia
                FROM Clientes
                WHERE ID_Cliente = @idCliente

                SELECT @impuestoProvincial = ImpuestoImportacion
                FROM Provincias
                WHERE ID_Provincia = @idprovincia

                IF(SELECT COUNT(*) FROM Clientes WHERE ID_Cliente = @idCliente) > 0
                BEGIN
                    SELECT @AcumuladoAnual = ISNULL(SUM(Valor), 0)  
                    FROM Importaciones 
                    WHERE ID_Cliente = @idCliente AND YEAR(Fecha) = YEAR(@fechaImportacion)

                        IF(@AcumuladoAnual < 50000)
                        BEGIN
                            SET @arancel = @valorImportacion * 0.05
                        END
                        ELSE
                        BEGIN
                            SET @arancel = @valorImportacion * 0.10
                            IF @impuestoProvincial IS NOT NULL
                            BEGIN
                                SET @arancel = @arancel + (@arancel * @impuestoProvincial / 100)
                            END
                        END

                        UPDATE Importaciones SET Arancel = @arancel
                        WHERE ID_Cliente = @idCliente AND Fecha = @fechaImportacion
                      
                END
                ELSE
                BEGIN
                    RAISERROR('EL CLIENTE NO EXISTE', 16, 1)
                    ROLLBACK TRANSACTION
                END    
        IF @@TRANCOUNT > 0
        BEGIN
            COMMIT TRANSACTION
        END    
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
    END CATCH
END

GO
CREATE PROCEDURE SP_ClientesConImportacionesEnAnio
(
    @anio INT
)
AS
BEGIN
    SELECT C.Apellidos, C.Nombres
    FROM Clientes C
    INNER JOIN Importaciones I  ON C.ID_Cliente = I.ID_Cliente
    LEFT JOIN Envios E ON I.ID_Importacion = E.ID_Importacion
    WHERE YEAR(I.Fecha) = @anio
    GROUP BY C.Apellidos, C.Nombres
    HAVING COUNT(I.ID_Importacion) > 0 AND COUNT(DISTINCT I.ID_Importacion) = COUNT(DISTINCT E.ID_Importacion)
END

GO
CREATE FUNCTION FN_CalcularArancelesPendientes
(
    @idCliente INT
)
RETURNS MONEY
AS
BEGIN
    DECLARE @tatalAdeudado MONEY

    SELECT @tatalAdeudado = coalesce(SUM(Arancel), 0)
    FROM Importaciones
    WHERE ID_Cliente = @idCliente AND Pagado = 0;

    RETURN @tatalAdeudado
END

GO
CREATE TRIGGER TR_AgregarEnvio ON Envios
AFTER INSERT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            DECLARE @idCliente INT
            DECLARE @idImportacion bigint
            DECLARE @arancel MONEY
            DECLARE @costoEnvio MONEY
            DECLARE @Total money

            SELECT  @idImportacion = ID_Importacion
            FROM INSERTED

            SELECT @idCliente = ID_Cliente, @arancel = Arancel
            FROM Importaciones
            WHERE ID_Importacion = @idImportacion
             
            SET  @Total = dbo.FN_CalcularArancelesPendientes(@idCliente)

            IF @Total = 0
            BEGIN
                SET @costoEnvio = @arancel * 0.50
            END
            ELSE
            BEGIN
                SET @costoEnvio = @arancel * 2
                SET @costoEnvio = @arancel + (@Total * 0.01)
            END

            UPDATE Envios SET Costo = @costoEnvio
            WHERE ID_Importacion = @idImportacion
        IF @@TRANCOUNT > 0
        BEGIN    
            COMMIT TRANSACTION
        END
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
    END CATCH
END
