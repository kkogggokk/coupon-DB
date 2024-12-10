-- 3만건 사용자 계정 생성 SQL 프로시저
-- 데이터베이스 선택
-- 프로시저 수정 필요. (시스템 계정 말고 다른 계정으로도 삭제 할제 할수 있는 수준으로 해야할듯..
USE `coupon`;

SHOW PROCEDURE STATUS WHERE Db = 'coupon';  -- coupon DB에 존재하는 프로시저 확인
DROP PROCEDURE IF EXISTS CreateUserAccounts; -- 기존 프로시저 삭제

-- 새 프로시저 생성
DELIMITER $$
CREATE PROCEDURE CreateUserAccounts()
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

-- 프로시저 실행
CALL CreateUserAccounts();
-- 약 30초 정도 걸린 듯

-- 사용자 총 수 확인
SELECT COUNT(*) AS total_users FROM `user_tb`;


