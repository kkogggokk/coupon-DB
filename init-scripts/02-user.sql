
USE `coupon`;

-- 비번: 1q2w3e4r!!
INSERT INTO `user_tb` (email, password, username, roles) VALUES ('admin@mail.com', '{bcrypt}$2a$10$cqnXrXnXY128eA6cZbEA.uep.OHPteHElepW0AS4eH5R9B1XfTFAC', 'admin', 'ROLE_USER');
INSERT INTO `user_tb` (email, password, username, roles) VALUES ('test@mail.com', '{bcrypt}$2a$10$cqnXrXnXY128eA6cZbEA.uep.OHPteHElepW0AS4eH5R9B1XfTFAC', 'test', 'ROLE_USER');

SELECT COUNT(*) AS total_users FROM `user_tb`;
