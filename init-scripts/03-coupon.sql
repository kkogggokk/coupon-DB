-- 'FIRST_COME_FIRST_SERVED' : 선착순 쿠폰
USE `coupon`;
INSERT INTO coupons (`title`, `coupon_type`, `total_quantity`, `issued_quantity`, `discount_amount`, `min_available_amount`, `date_issue_start`, `date_issue_end`)
VALUES
    ('5만원 이상 구매 시 5천원 할인', 'FIRST_COME_FIRST_SERVED', 30000, 0, 5000, 50000, DATE_SUB(NOW(), INTERVAL 1 WEEK), DATE_ADD(NOW(), INTERVAL 1 WEEK)),
    ('3만원 이상 구매 시 3천원 할인', 'FIRST_COME_FIRST_SERVED', 30000, 0, 3000, 30000, DATE_SUB(NOW(), INTERVAL 1 WEEK), DATE_ADD(NOW(), INTERVAL 1 WEEK)),
    ('2만원 이상 구매 시 2천원 할인', 'FIRST_COME_FIRST_SERVED', 30000, 0, 2000, 20000, DATE_SUB(NOW(), INTERVAL 1 WEEK), DATE_ADD(NOW(), INTERVAL 1 WEEK)),
    ('1만원 이상 구매 시 1천원 할인', 'FIRST_COME_FIRST_SERVED', 30000, 0, 1000, 10000, DATE_SUB(NOW(), INTERVAL 1 WEEK), DATE_ADD(NOW(), INTERVAL 1 WEEK));
