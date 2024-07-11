-- 101-average_weighted_score.sql
-- Drop existing procedure if it exists
DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUsers;

-- Set delimiter to //
DELIMITER //

-- Create procedure to compute average weighted scores for all users
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    -- Declare variables for cursor control
    DECLARE done INT DEFAULT 0;
    DECLARE user_id INT;
    
    -- Declare cursor to iterate over all user ids
    DECLARE user_cursor CURSOR FOR
    SELECT id FROM users;
    
    -- Declare handler to set done variable when cursor reaches end
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    -- Open cursor
    OPEN user_cursor;
    
    -- Loop through each user and compute their average weighted score
    read_loop: LOOP
        FETCH user_cursor INTO user_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Call procedure to compute average score for current user
        CALL ComputeAverageWeightedScoreForUser(user_id);
    END LOOP;
    
    -- Close cursor
    CLOSE user_cursor;
END //

-- Reset delimiter to ;
DELIMITER ;
