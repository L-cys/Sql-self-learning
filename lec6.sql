DELIMITER $$
CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total + NEW.amount
    WHERE invoice_id = NEW.invoice_id;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER payment_after_delete
	AFTER DELETE ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total - OLD.amount
    WHERE invoice_id = OLD.invoice_id;
END $$
DELIMITER ;

SHOW TRIGGERS LIKE 'paymenys%'
DROP TRIGGER IF EXISTS payments_after_insert;


-- Log in changes.
DELIMITER $$

DROP TRIGGER IF EXISTS payments_after_insert;

CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total + NEW.amount
    WHERE invoice_id = NEW.invoice_id;
    
    INSERT INTO payments_audit
    VALUES(NEW.client_id,NEW.date, NEW.amount, 'Insert', NOW());
END $$
DELIMITER ;

-- Event
SHOW variables LIKE 'event%';
SET GLOBAL event_scheduler = ON


DELIMITER $$

CREATE EVENT yearly_delete_stale_audit_rows
ON SCHEDULE
	-- AT '2019-05-01'
    EVERY 1 YEAR STARTS '2019-01-1' ENDS '2029-01-01'
DO BEGIN
	DELETE FROM payments_audit
    WHERE action_date < NOW() - INTERVAL 1 YEAR;
END $$
DELIMITER ;

SHOW EVENTS LIKE 'yearly%';
DROP EVENT IF EXISTS

ALTER EVENT yearly_delete_stale_audit_rows ENABLE;
