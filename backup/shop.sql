-- 데이터베이스 : coupon / 테이블 총 8개 : coupons, coupon_issues
-- 데이터베이스 스키마 생성
CREATE SCHEMA IF NOT EXISTS `coupon` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- 스키마 사용
USE `coupon`;

-- 데이터 초기화
SET FOREIGN_KEY_CHECKS = 0;

-- 기존 테이블 삭제 (존재할 경우)
DROP TABLE IF EXISTS `item_tb`;
DROP TABLE IF EXISTS `order_tb`;
DROP TABLE IF EXISTS `cart_tb`;
DROP TABLE IF EXISTS `option_tb`;
DROP TABLE IF EXISTS `product_tb`;
DROP TABLE IF EXISTS `user_tb`;

-- 유저 테이블 생성
CREATE TABLE IF NOT EXISTS `user_tb` (
                                         `id` INT(11) NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(100) NOT NULL,
    `password` VARCHAR(256) NOT NULL,
    `username` VARCHAR(45) NOT NULL,
    `roles` VARCHAR(30) DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `email_UNIQUE` (`email`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 제품 테이블 생성
CREATE TABLE IF NOT EXISTS `product_tb` (
                                            `id` INT(11) NOT NULL AUTO_INCREMENT,
    `product_name` VARCHAR(500) NOT NULL,
    `description` VARCHAR(1000) DEFAULT NULL,
    `image` VARCHAR(500) DEFAULT NULL,
    `price` INT(11) DEFAULT NULL,
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 장바구니 테이블 생성
CREATE TABLE IF NOT EXISTS `cart_tb` (
                                         `id` INT(11) NOT NULL AUTO_INCREMENT,
    `user_id` INT(11) NOT NULL,
    `option_id` INT(11) NOT NULL,
    `quantity` INT(11) NOT NULL,
    `price` INT(11) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_cart_option_user` (`option_id`, `user_id`),
    KEY `cart_user_id_idx` (`user_id`),
    KEY `cart_option_id_idx` (`option_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 옵션 테이블 생성
CREATE TABLE IF NOT EXISTS `option_tb` (
                                           `id` INT(11) NOT NULL AUTO_INCREMENT,
    `product_id` INT(11) DEFAULT NULL,
    `option_name` VARCHAR(100) NOT NULL,
    `price` INT(11) NOT NULL,
    PRIMARY KEY (`id`),
    KEY `option_product_id_idx` (`product_id`),
    CONSTRAINT `option_product_id` FOREIGN KEY (`product_id`) REFERENCES `product_tb` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 주문 테이블 생성
CREATE TABLE IF NOT EXISTS `item_tb` (
                                         `id` INT(11) NOT NULL AUTO_INCREMENT,
    `option_id` INT(11) NOT NULL,
    `quantity` INT(11) NOT NULL,
    `price` INT(11) NOT NULL,
    `order_id` INT(11) NOT NULL,
    PRIMARY KEY (`id`),
    KEY `item_option_id_idx` (`option_id`),
    CONSTRAINT `item_option_id` FOREIGN KEY (`option_id`) REFERENCES `option_tb` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    KEY `item_order_id_idx` (`order_id`),
    CONSTRAINT `item_order_id` FOREIGN KEY (`order_id`) REFERENCES `order_tb` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 아이템 테이블 생성
CREATE TABLE IF NOT EXISTS `order_tb` (
                                          `id` INT(11) NOT NULL AUTO_INCREMENT,
    `user_id` INT(11) NOT NULL,
    PRIMARY KEY (`id`),
    KEY `order_user_id_idx` (`user_id`),
    CONSTRAINT `order_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_tb` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--비번: 1q2w3e4r!!
INSERT INTO user_tb (email, password, username, roles)
VALUES ('admin@mail.com', '{bcrypt}$2a$10$cqnXrXnXY128eA6cZbEA.uep.OHPteHElepW0AS4eH5R9B1XfTFAC', 'admin', 'ROLE_USER');
INSERT INTO user_tb (email, password, username, roles)
VALUES ('test@mail.com', '{bcrypt}$2a$10$cqnXrXnXY128eA6cZbEA.uep.OHPteHElepW0AS4eH5R9B1XfTFAC', 'test', 'ROLE_USER');

-- ALTER TABLE product_tb MODIFY product_name VARCHAR(500);
INSERT INTO `product_tb` (`id`, `product_name`, `description`, `image`, `price`)
VALUES (1, '기본에 슬라이딩 지퍼백 크리스마스/플라워에디션 에디션 외 주방용품 특가전', '', '/images/1.jpg', 1000),
       (2, '[황금약단밤 골드]2022년산 햇밤 칼집밤700g외/군밤용/생율', '', '/images/2.jpg', 2000),
       (3, '삼성전자 JBL JR310 외 어린이용/성인용 헤드셋 3종!', '', '/images/3.jpg', 30000),
       (4, '바른 누룽지맛 발효효소 2박스 역가수치보장 / 외 7종', '', '/images/4.jpg', 4000),
       (5, '[더주] 컷팅말랑장족, 숏다리 100g/300g 외 주전부리 모음 /중독성 최고/마른안주', '', '/images/5.jpg', 5000),
       (6, '굳지않는 앙금절편 1,050g 2팩 외 우리쌀떡 모음전', '', '/images/6.jpg', 15900),
       (7, 'eoe 이너딜리티 30포, 오렌지맛 고 식이섬유 보충제', '', '/images/7.jpg', 26800),
       (8, '제나벨 PDRN 크림 2개. 피부보습/진정 케어', '', '/images/8.jpg', 25900),
       (9, '플레이스테이션 VR2 호라이즌 번들. 생생한 몰입감', '', '/images/9.jpg', 797000),
       (10, '통영 홍 가리비 2kg, 2세트 구매시 1kg 추가증정', '', '/images/10.jpg', 8900),
       (11, '아삭한 궁채 장아찌 1kg 외 인기 반찬 모음전', '', '/images/11.jpg', 6900),
       (12, '깨끗한나라 순수소프트 30롤 2팩. 무형광, 도톰 3겹', '', '/images/12.jpg', 28900),
       (13, '생활공작소 초미세모 칫솔 12입 2개+가글 증정', '', '/images/13.jpg', 9900),
       (14, '경북 영천 샤인머스켓 가정용 1kg 2수 내외', '', '/images/14.jpg', 9900),
       (15, '[LIVE][5%쿠폰] 홈카페 Y3.3 캡슐머신 베이직 세트', '', '/images/15.jpg', 148000);

INSERT INTO `option_tb` (`id`, `product_id`, `option_name`, `price`)
VALUES (1, 1, '01. 슬라이딩 지퍼백 크리스마스에디션 4종', 10000),
       (2, 1, '02. 슬라이딩 지퍼백 플라워에디션 5종', 10900),
       (3, 1, '고무장갑 베이지 S(소형) 6팩', 9900),
       (4, 1, '뽑아쓰는 키친타올 130매 12팩', 16900),
       (5, 1, '2겹 식빵수세미 6매', 8900),
       (6, 2, '22년산 햇단밤 700g(한정판매)', 9900),
       (7, 2, '22년산 햇단밤 1kg(한정판매)', 14500),
       (8, 2, '밤깎기+다회용 구이판 세트', 5500),
       (9, 3, 'JR310 (유선 전용) - 블루', 29900),
       (10, 3, 'JR310BT (무선 전용) - 레드', 49900),
       (11, 3, 'JR310BT (무선 전용) - 그린', 49900),
       (12, 3, 'JR310BT (무선 전용) - 블루', 49900),
       (13, 3, 'T510BT (무선 전용) - 블랙', 52900),
       (14, 3, 'T510BT (무선 전용) - 화이트', 52900),
       (15, 4, '선택01_바른곡물효소 누룽지맛 2박스', 17900),
       (16, 4, '선택02_바른곡물효소누룽지맛 6박스', 50000),
       (17, 4, '선택03_바른곡물효소3박스+유산균효소3박스', 50000),
       (18, 4, '선택04_바른곡물효소3박스+19종유산균3박스', 50000),
       (19, 5, '01. 말랑컷팅장족 100g', 4900),
       (20, 5, '02. 말랑컷팅장족 300g', 12800),
       (21, 5, '03. 눌린장족 100g', 4900),
       (22, 6, '굳지않는 쑥 앙금 절편 1050g', 15900),
       (23, 6, '굳지않는 흑미 앙금 절편 1050g', 15900),
       (24, 6, '굳지않는 흰 가래떡 1050g', 15900),
       (25, 7, '이너딜리티 1박스', 26800),
       (26, 7, '이너딜리티 2박스+사은품 2종', 49800),
       (27, 8, '제나벨 PDRN 자생크림 1+1', 25900),
       (28, 9, '플레이스테이션 VR2 호라이즌 번들', 839000),
       (29, 9, '플레이스테이션 VR2', 797000),
       (30, 10, '홍가리비2kg(50미이내)', 8900),
       (31, 11, '궁채 절임 1kg', 6900),
       (32, 11, '양념 깻잎 1kg', 8900),
       (33, 11, '된장 깻잎 1kg', 8900),
       (34, 11, '간장 깻잎 1kg', 7900),
       (35, 11, '고추 무침 1kg', 8900),
       (36, 11, '파래 무침 1kg', 9900),
       (37, 12, '01_순수소프트 27m 30롤 2팩', 28900),
       (38, 12, '02_벚꽃 프리미엄 27m 30롤 2팩', 32900),
       (39, 13, '(증정) 초미세모 칫솔 12개 x 2개', 11900),
       (40, 13, '(증정) 잇몸케어 치약 100G 3개 x 2개', 16900),
       (41, 13, '(증정) 구취케어 치약 100G 3개 x 2개', 16900),
       (42, 13, '(증정)화이트케어 치약 100G 3개 x 2개', 19900),
       (43, 13, '(증정) 어린이 칫솔 12EA', 9900),
       (44, 14, '[가정용] 샤인머스켓 1kg 2수내외', 9900),
       (45, 14, '[특품] 샤인머스켓 1kg 1-2수', 12900),
       (46, 14, '[특품] 샤인머스켓 2kg 2-3수', 23900),
       (47, 15, '화이트', 148000),
       (48, 15, '블랙', 148000);

INSERT INTO `cart_tb` (`id`, `user_id`, `option_id`, `quantity`, `price`)
VALUES (1, 1, 1, 5, 50000),
       (2, 1, 2, 1, 10900),
       (3, 1, 16, 5, 250000);

INSERT INTO `order_tb` (`id`, `user_id`) VALUES (1, 1);

INSERT INTO `item_tb` (`id`, `option_id`, `quantity`, `price`, `order_id`)
VALUES (1, 1, 5, 50000, 1),
       (2, 2, 1, 10900, 1),
       (3, 16, 5, 250000, 1);
