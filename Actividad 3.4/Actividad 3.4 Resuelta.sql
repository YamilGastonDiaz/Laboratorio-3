USE LAB3_ACTIVIDAD_3_1

GO
CREATE TRIGGER TR_AGREGAR_VIAJE ON VIAJES
AFTER INSERT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            DECLARE @IDTARJETA BIGINT
            DECLARE @IMPORTE SMALLMONEY
            DECLARE @SALDOACTUAL MONEY
            DECLARE @ESTADO BIT

            -- Obtener IDTarjeta e Importe del registro insertado en VIAJES
            SELECT @IDTARJETA = IDTARJETA, @IMPORTE = IMPORTE
            FROM inserted

            -- Obtener el saldo y el estado actual de la tarjeta
            SELECT @SALDOACTUAL = SALDO, @ESTADO = ESTADO
            FROM TARJETAS
            WHERE @IDTARJETA = IDTARJETA

            -- Verificar si la tarjeta está activa
            IF @ESTADO <> 1
            BEGIN
                RAISERROR ('LA TAJETA NO SE ENCUENTRA ACTIVA', 16, 1)
                ROLLBACK TRANSACTION
            END

            -- Verificar si el saldo es suficiente para el viaje
            IF @SALDOACTUAL < @IMPORTE
            BEGIN
                RAISERROR('SALDO INSUFICIENTE PARA REALIZAR EL VIAJE', 16, 1)
                ROLLBACK TRANSACTION
            END

            INSERT INTO MOVIMIENTOS (FECHA, IDTARJETA, IMPORTE, TIPO)
            VALUES (GETDATE(), @IDTARJETA, @IMPORTE, 'D')
        

            UPDATE TARJETAS SET SALDO = SALDO - @IMPORTE
            WHERE @IDTARJETA = IDTARJETA

        IF @@TRANCOUNT > 0
        BEGIN
            COMMIT TRANSACTION
        END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION
        END    
    END CATCH
END

GO
CREATE TRIGGER TR_NUEVO_USUARIO ON USUARIOS
AFTER INSERT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            DECLARE @IDUSUARIO BIGINT

            -- Obtener el ID del usuario recién insertado
            SELECT @IDUSUARIO = IDUSUARIO
            FROM inserted

            -- Insertar una nueva tarjeta
            INSERT INTO TARJETAS (IDUSUARIO, FECHA_ALTA, SALDO, ESTADO)
            VALUES (@IDUSUARIO, GETDATE(), 0, 1)

        IF @@TRANCOUNT > 0
        BEGIN    
            COMMIT TRANSACTION
        END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION
        END
    END CATCH
END

GO
CREATE TRIGGER TR_NUEVA_TARJETA ON TARJETAS
AFTER INSERT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            DECLARE @IDUSUARIO BIGINT
            DECLARE @IDTARJETANUEVA BIGINT
            DECLARE @SALDOANTIGUO MONEY

            -- Obtener el ID del usuario Y ID de la tarjeta nueva insertada
            SELECT @IDUSUARIO = IDUSUARIO, @IDTARJETANUEVA = IDTARJETA
            FROM inserted

            IF (SELECT COUNT(*) FROM TARJETAS WHERE @IDUSUARIO = IDUSUARIO AND ESTADO = 1) = 1
            BEGIN
                -- Obtener el saldo de la tarjeta activa del usuario
                SELECT @SALDOANTIGUO = SALDO
                FROM TARJETAS
                WHERE @IDUSUARIO = IDUSUARIO

                -- Cambiar el estado de la tarjeta a inactiva
                UPDATE TARJETAS
                SET ESTADO = 0
                WHERE @IDUSUARIO = IDUSUARIO

                -- Actualizo la tarjeta nueva con el saldo de la vieja tarjeta y la fecha de alta que deberá ser la del sistema
                UPDATE TARJETAS
                SET SALDO = @SALDOANTIGUO, FECHA_ALTA = GETDATE()
                WHERE @IDTARJETANUEVA = IDTARJETA
            END
        IF @@TRANCOUNT > 0
        BEGIN
            COMMIT TRANSACTION
        END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION
        END
    END CATCH
END

GO
CREATE TRIGGER TR_ELIMIAR_CLIENTE ON USUARIOS
INSTEAD OF DELETE
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            DECLARE @IDUSUARIO BIGINT
            DECLARE @IDTARJETA BIGINT

            SELECT @IDUSUARIO = IDUSUARIO FROM deleted

            SELECT @IDTARJETA = IDTARJETA
            FROM TARJETAS
            WHERE @IDUSUARIO = IDUSUARIO

            DELETE FROM USUARIOS
            WHERE @IDUSUARIO = IDUSUARIO

            DELETE FROM TARJETAS
            WHERE @IDUSUARIO = IDUSUARIO
            
            DELETE FROM MOVIMIENTOS
            WHERE @IDTARJETA = IDTARJETA

            DELETE FROM VIAJES
            WHERE @IDTARJETA = IDTARJETA            

        IF @@TRANCOUNT > 0
        BEGIN
            COMMIT TRANSACTION
        END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION
        END
    END CATCH
END