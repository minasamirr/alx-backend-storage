-- 101-average_weighted_score.sql
-- Drop existing procedure if it exists
DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUsers;

-- Set delimiter to //
DELIMITER //

-- Create procedure to compute average weighted scores for all users
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    -- Declare variables to hold weighted sum and total weight
    DECLARE weighted_sum FLOAT;
    DECLARE total_weight INT;

    -- Loop through each user and compute their average weighted score
    DECLARE user_cursor CURSOR FOR SELECT id FROM users;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    DECLARE done INT DEFAULT 0;
    OPEN user_cursor;
    
    read_loop: LOOP
        FETCH user_cursor INTO user_id;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Initialize variables for each user
        SET weighted_sum = 0;
        SET total_weight = 0;

        -- Calculate the weighted sum of scores and total weight for the current user
        SELECT SUM(c.score * p.weight), SUM(p.weight)
        INTO weighted_sum, total_weight
        FROM corrections c
        JOIN projects p ON c.project_id = p.id
        WHERE c.user_id = user_id;

        -- If total weight is greater than 0, update user's average score
        IF total_weight > 0 THEN
            UPDATE users
            SET average_score = weighted_sum / total_weight
            WHERE id = user_id;
        ELSE
            -- If total weight is 0, set user's average score to 0
            UPDATE users
            SET average_score = 0
            WHERE id = user_id;
        END IF;
    END LOOP;

    CLOSE user_cursor;
END //

-- Reset delimiter to ;
DELIMITER ;
