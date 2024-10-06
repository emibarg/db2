CREATE TABLE ej1_cuenta (
  
  id_cuenta int AUTO_INCREMENT PRIMARY KEY,

  saldo int not null

);






INSERT INTO ej1_cuenta (saldo) values (20),(25);

DELIMITER //

CREATE PROCEDURE transferir(IN pidCuenta INT, IN pidDestinatario INT, IN pMonto INT)
BEGIN
    -- Label to allow exiting the procedure early
    proc_label: BEGIN

        DECLARE saldoInicialEmisor INT DEFAULT 0;
        DECLARE saldoInicialReceptor INT DEFAULT 0;

        -- Error handler for SQL exceptions
        DECLARE EXIT HANDLER FOR SQLEXCEPTION 
        BEGIN
            ROLLBACK;
            SELECT 'Error en transaccion' AS message;
        END;

        -- Fetch the initial balances
        SELECT c.saldo INTO saldoInicialEmisor
        FROM ej1_cuenta AS c
        WHERE c.id_cuenta = pidCuenta;

        SELECT c.saldo INTO saldoInicialReceptor
        FROM ej1_cuenta AS c
        WHERE c.id_cuenta = pidDestinatario;

        -- Debugging: show the balances
        SELECT saldoInicialEmisor AS 'Saldo Inicial Emisor', saldoInicialReceptor AS 'Saldo Inicial Receptor';

        -- Start transaction
        START TRANSACTION;

        -- Check if ids are the same
        IF pidCuenta =pidDestinatario THEN
          SELECT 'No podes tener plata infinita';
          ROLLBACK;
          LEAVE proc_label;
        END IF;

        IF pMonto<=0 THEN 
          SELECT 'no podes robar';
          ROLLBACK;
          LEAVE proc_label;
          END IF;






        -- Check if there are sufficient funds
        IF pMonto > saldoInicialEmisor THEN
            SELECT 'FALTAN FONDOS' AS message;
            ROLLBACK;
            LEAVE proc_label;  -- Exiting the procedure if insufficient funds
        ELSE
            -- Update the accounts
            UPDATE ej1_cuenta
            SET saldo = saldoInicialEmisor - pMonto
            WHERE id_cuenta = pidCuenta;

            UPDATE ej1_cuenta
            SET saldo = saldoInicialReceptor + pMonto
            WHERE id_cuenta = pidDestinatario;

            -- Debugging: confirm the updates
            SELECT 'Transaccion Exitosa' AS message;

            -- Commit the transaction
            COMMIT;
        END IF;

        SELECT id_cuenta, saldo as 'Saldo final'
        FROM ej1_cuenta WHERE id_cuenta = pidCuenta OR  id_cuenta = pidDestinatario;

    END proc_label;
END//
DELIMITER ;

