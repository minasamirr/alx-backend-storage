-- Set delimiter to // to allow for multi-line trigger definition
DELIMITER //

-- Create a trigger to decrease the quantity of an item after a new order is added
CREATE TRIGGER decrease_quantity_after_order
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    -- Update the quantity of the item in the items table
    UPDATE items
    SET quantity = quantity - NEW.number
    WHERE name = NEW.item_name;
END//

-- Reset delimiter to ;
DELIMITER ;
