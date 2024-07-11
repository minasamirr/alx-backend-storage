-- 7-average_score.sql
-- Delimiter for defining stored procedure
DELIMITER //

-- Create the stored procedure ComputeAverageScoreForUser
CREATE PROCEDURE ComputeAverageScoreForUser(IN user_id INT)
BEGIN
    DECLARE totalScore FLOAT DEFAULT 0;
    DECLARE totalProjects INT DEFAULT 0;
    DECLARE avgScore FLOAT;

    -- Calculate total score and count of projects for the user
    SELECT SUM(score), COUNT(*) INTO totalScore, totalProjects
    FROM corrections
    WHERE user_id = user_id;

    -- Calculate average score
    IF totalProjects > 0 THEN
        SET avgScore = totalScore / totalProjects;
    ELSE
        SET avgScore = 0; -- Default to 0 if no corrections found
    END IF;

    -- Update the average_score in the users table for the specified user
    UPDATE users
    SET average_score = avgScore
    WHERE id = user_id;

    -- Select the updated average_score for verification if needed
    SELECT average_score
    FROM users
    WHERE id = user_id;
END //

-- Reset delimiter to default
DELIMITER ;
