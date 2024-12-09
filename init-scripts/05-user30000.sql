-- 3만건 사용자 계정 생성 SQL 프로시저
USE `coupon`;

DELIMITER $$
CREATE PROCEDURE CreateUserAccounts()   -- 사용자 생성 프로시저 정의
BEGIN
    DECLARE i INT DEFAULT 3; -- 시작 번호 3
    WHILE i <= 30000 DO
        INSERT IGNORE INTO `user_tb` (email, password, username, roles)
        VALUES (
            CONCAT(i, '@mail.com'),
            '{bcrypt}$2a$10$cqnXrXnXY128eA6cZbEA.uep.OHPteHElepW0AS4eH5R9B1XfTFAC',
            CONCAT('user', i),
            'ROLE_USER'
        );
        SET i = i + 1; -- 다음 번호로 증가
END WHILE;
END$$
DELIMITER ;

CALL CreateUserAccounts();  -- 프로시저 실행
SELECT COUNT(*) AS total_users FROM `user_tb`;

-- 참고
# SHOW PROCEDURE STATUS WHERE Db = 'coupon';  -- coupon DB에 존재하는 프로시저 확인
# DROP PROCEDURE IF EXISTS CreateUserAccounts; -- 기존 프로시저 삭제



