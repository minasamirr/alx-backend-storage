-- Set delimiter to // to allow for multi-line trigger definition
DELIMITER //

-- Create a trigger to reset valid_email before an update if the email changes
CREATE TRIGGER reset_valid_email_before_update
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    -- Check if the email has changed
    IF OLD.email != NEW.email THEN
        -- Reset valid_email to 0 if the email has changed
        SET NEW.valid_email = 0;
    END IF;
END//

-- Reset delimiter to ;
DELIMITER ;
