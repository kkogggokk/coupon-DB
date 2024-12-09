-- 데이터베이스 : coupon
-- 테이블 : 총 8개
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
DROP TABLE IF EXISTS `coupon_issues`;
DROP TABLE IF EXISTS `coupons`;
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

-- 쿠폰 테이블 생성
CREATE TABLE IF NOT EXISTS `coupons` (
    `id` INT(20) NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(255) NOT NULL COMMENT '쿠폰명',
    `coupon_type` VARCHAR(255) NOT NULL COMMENT '쿠폰 타입 (선착순 쿠폰 등)',
    `total_quantity` INT NULL COMMENT '쿠폰 발급 최대 수량',
    `issued_quantity` INT NOT NULL COMMENT '발급된 쿠폰 수량',
    `discount_amount` INT NOT NULL COMMENT '할인 금액',
    `min_available_amount` INT NOT NULL COMMENT '최소 사용 금액',
    `date_issue_start` DATETIME(6) NOT NULL COMMENT '발급 시작 일시',
    `date_issue_end` DATETIME(6) NOT NULL COMMENT '발급 종료 일시',
    `date_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성 일시',
    `date_updated` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정 일시',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT '쿠폰 정책';

-- 쿠폰 발급 내역 테이블 생성
CREATE TABLE IF NOT EXISTS `coupon_issues` (
    `id` INT(20) NOT NULL AUTO_INCREMENT,
    `coupon_id` INT(20) NOT NULL COMMENT '쿠폰 ID',
    `user_id` INT(11) NOT NULL COMMENT ' ID',
    `date_issued` DATETIME(6) NOT NULL COMMENT '발급 일시',
    `date_used` DATETIME(6) NULL COMMENT '사용 일시',
    `date_created` DATETIME(6) NOT NULL COMMENT '생성 일시',
    `date_updated` DATETIME(6) NOT NULL COMMENT '수정 일시',
    PRIMARY KEY (`id`),
    FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`user_id`) REFERENCES `user_tb` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci comment '쿠폰 발급 내역';

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
    KEY `cart_option_id_idx` (`option_id`),
    CONSTRAINT `fk_cart_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`id`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_cart_option_id` FOREIGN KEY (`option_id`) REFERENCES `option_tb`(`id`)
        ON DELETE CASCADE ON UPDATE CASCADE
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