-- 101-average_weighted_score.sql
DELIMITER //

-- Create the stored procedure to compute and store the average weighted score for all users
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE userId INT;
    DECLARE cur CURSOR FOR SELECT id FROM users;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO userId;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Calculate the total weighted score and total weight for the current user
        UPDATE users
        SET average_score = (
            SELECT SUM(c.score * p.weight) / SUM(p.weight)
            FROM corrections c
            JOIN projects p ON c.project_id = p.id
            WHERE c.user_id = userId
        )
        WHERE id = userId;
    END LOOP;

    CLOSE cur;
END//

DELIMITER ;
