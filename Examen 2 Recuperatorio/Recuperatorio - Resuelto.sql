USE RecuperatorioSegundoParcial2024C

GO
--PUNTO 1
CREATE TRIGGER CalcularDescuentoEnVenta
ON Ventas
AFTER INSERT
AS
BEGIN
  BEGIN TRY
    BEGIN TRANSACTION
      DECLARE @AnioActual INT = 2024;

      DECLARE @ID_Venta INT
      DECLARE @ID_Cliente INT
      DECLARE @ID_Juguete INT
      DECLARE @CantidadVendida INT
      DECLARE @FechaVenta DATE

      SELECT @ID_Venta = ID_Venta, @ID_Cliente = ID_Cliente, @ID_Juguete = ID_Juguete, @CantidadVendida = CantidadVendida, @FechaVenta = FechaVenta 
      FROM inserted

      DECLARE @Valor MONEY
      DECLARE @ID_Edicion INT

      SELECT @Valor = Valor, @ID_Edicion = ID_Edicion
      FROM Juguetes
      WHERE ID_Juguete = @ID_Juguete

      DECLARE @NombreEdicion VARCHAR(50)

      SELECT @NombreEdicion = NombreEdicion
      FROM Edicion
      WHERE ID_Edicion = @ID_Edicion

      DECLARE @CantidadComprada INT
      DECLARE @Descuento MONEY
      DECLARE @total MONEY

      SELECT @CantidadComprada = COALESCE(SUM(CantidadVendida), 0)
      FROM Ventas
      WHERE ID_Cliente = @ID_Cliente AND YEAR(FechaVenta) = @AnioActual

      SELECT @total = @Valor * @CantidadVendida

      IF @CantidadComprada <= 5
      BEGIN
        SET @Descuento = @total * 0.075
      END
      ELSE
      BEGIN
        IF @CantidadComprada > 5 AND @CantidadComprada < 10
        BEGIN
          SET @Descuento = @total * 0.10
        END
        ELSE
        BEGIN
          SET @Descuento = @total * 0.125
        END
      END

      IF @NombreEdicion = 'Especial'
      BEGIN
        SET @Descuento = @Descuento + (@total * 0.05)
      END

      PRINT 'Descuento: ' + CAST(@Descuento AS VARCHAR(50))

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
--PUNTO 2
CREATE PROCEDURE aumentarPrecio
@NombreEdicion VARCHAR(50),
@PorcentajeAumento DECIMAL(6, 2)
AS
BEGIN
    IF @PorcentajeAumento < 0 OR @PorcentajeAumento > 999.99
    BEGIN
      RAISERROR('El valor debe estar entre 0 y 999,99', 16, 1)
      RETURN
    END

    IF NOT EXISTS (SELECT 1 FROM Edicion WHERE NombreEdicion = @NombreEdicion)
    BEGIN
        RAISERROR('El nombre de esa edición no existe', 16, 1)
        RETURN
    END

    UPDATE Juguetes
    SET Valor = Valor + (Valor * @PorcentajeAumento / 100)
    WHERE ID_Edicion = 
    (SELECT ID_Edicion 
    FROM Edicion 
    WHERE NombreEdicion = @NombreEdicion)
END

GO
--PUNTO 3
SELECT J.Nombre, SUM(V.CantidadVendida) AS 'Cantidad de unidades vendidas'
FROM Juguetes AS J
INNER JOIN Ventas AS V ON J.ID_Juguete = V.ID_Juguete
WHERE YEAR(FechaVenta) = YEAR(GETDATE()) AND YEAR(FechaVenta) != YEAR(GETDATE()) - 1
GROUP BY J.Nombre


