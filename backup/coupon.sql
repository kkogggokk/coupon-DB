CREATE TABLE `coupon`.`coupons`
(
    `id`                   BIGINT(20) NOT NULL AUTO_INCREMENT,
    `title`                VARCHAR(255) NOT NULL COMMENT '쿠폰명',
    `coupon_type`          VARCHAR(255) NOT NULL COMMENT '쿠폰 타입 (선착순 쿠폰, ..)',
    `total_quantity`       INT NULL COMMENT '쿠폰 발급 최대 수량',
    `issued_quantity`      INT          NOT NULL COMMENT '발급된 쿠폰 수량',
    `discount_amount`      INT          NOT NULL COMMENT '할인 금액',
    `min_available_amount` INT          NOT NULL COMMENT '최소 사용 금액',
    `date_issue_start`     datetime(6) NOT NULL COMMENT '발급 시작 일시',
    `date_issue_end`       datetime(6) NOT NULL COMMENT '발급 종료 일시',
    `date_created`         datetime(6) NOT NULL COMMENT '생성 일시',
    `date_updated`         datetime(6) NOT NULL COMMENT '수정 일시',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
    COMMENT '쿠폰 정책';

drop table coupon.coupons;
drop table coupon.coupon_issues;
select * from coupon.coupons;    -- 왜 2개가 생성되는거지??, data.sql을 지우니깐 한번만 생성됨.
select * from coupon.coupon_issues;

CREATE TABLE `coupon`.`coupon_issues`
(
    `id`           BIGINT(20) NOT NULL AUTO_INCREMENT,
    `coupon_id`    BIGINT(20) NOT NULL COMMENT '쿠폰 ID',
    `user_id`      BIGINT(20) NOT NULL COMMENT '유저 ID',
    `date_issued`  datetime(6) NOT NULL COMMENT '발급 일시',
    `date_used`    datetime(6) NULL COMMENT '사용 일시',
    `date_created` datetime(6) NOT NULL COMMENT '생성 일시',
    `date_updated` datetime(6) NOT NULL COMMENT '수정 일시',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
    COMMENT '쿠폰 발급 내역';

ALTER TABLE coupon.coupons
    MODIFY COLUMN date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY COLUMN date_updated DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE coupon.coupon_issues
    MODIFY COLUMN date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY COLUMN date_updated DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;


DESCRIBE coupon.coupons;
DESCRIBE coupon.coupon_issues;

-- 데이터 입력 : 쿠폰 발급 날짜를 현재기준으로 일주일 전/후
INSERT INTO coupon.coupons (
    title,
    coupon_type,
    total_quantity,
    issued_quantity,
    discount_amount,
    min_available_amount,
    date_issue_start,
    date_issue_end
)
VALUES (
           '네고왕선착순쿠폰',
           'FIRST_COME_FIRST_SERVED',
           30000,
           0,
           100000,
           110000,
           DATE_SUB(NOW(), INTERVAL 1 WEEK ), -- 현재 날짜 기준 일주일 전
           DATE_ADD(NOW(), INTERVAL 1 WEEK ) -- 현재 날짜 기준 일주일 후
       );


--

show databases;
use coupon;
show tables;



select * from coupon.coupons where id = 1;



