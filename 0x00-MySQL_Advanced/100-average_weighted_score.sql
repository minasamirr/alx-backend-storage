-- 100-average_weighted_score.sql
-- Drop existing procedure if it exists
DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUser;

-- Set delimiter to //
DELIMITER //

-- Create procedure to compute average weighted score for a specific user
CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    -- Declare variables to hold weighted sum and total weight
    DECLARE weighted_sum FLOAT DEFAULT 0;
    DECLARE total_weight INT DEFAULT 0;
    
    -- Calculate the weighted sum of scores and total weight for the specified user
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
END //

-- Reset delimiter to ;
DELIMITER ;
