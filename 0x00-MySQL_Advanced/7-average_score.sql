-- 7-average_score.sql
DELIMITER //

-- Create the stored procedure to compute and store the average score for a user
CREATE PROCEDURE ComputeAverageScoreForUser(IN user_id INT)
BEGIN
    -- Declare variables for calculations
    DECLARE totalScore FLOAT DEFAULT 0;
    DECLARE totalCount INT DEFAULT 0;
    DECLARE avgScore FLOAT;

    -- Calculate total score and count of projects
    SELECT SUM(score), COUNT(*) INTO totalScore, totalCount
    FROM corrections
    WHERE user_id = user_id;

    -- Calculate average score
    IF totalCount > 0 THEN
        SET avgScore = totalScore / totalCount;
    ELSE
        SET avgScore = 0; -- Default to 0 if no corrections found
    END IF;

    -- Update the user's average_score in the users table
    UPDATE users
    SET average_score = avgScore
    WHERE id = user_id;
    
    -- Select the updated average_score for verification if needed
    SELECT average_score
    FROM users
    WHERE id = user_id;
END//

DELIMITER ;
