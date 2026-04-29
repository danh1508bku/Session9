EXPLAIN ANALYZE
SELECT *
FROM Users
WHERE email = 'example@example.com';

CREATE INDEX idx_users_email_hash
ON Users USING HASH (email);

EXPLAIN ANALYZE
SELECT *
FROM Users
WHERE email = 'example@example.com';
