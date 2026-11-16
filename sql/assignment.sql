-- A1. Create the parent table.
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- A2. Create the child table.
-- One user can have many calculations.
-- users.id: parent primary key.
-- calculations.id: child primary key.
-- calculations.user_id: foreign key referencing users.id.
-- ON DELETE CASCADE removes a user's calculations when that user is deleted.
CREATE TABLE calculations (
    id SERIAL PRIMARY KEY,
    operation VARCHAR(20) NOT NULL,
    operand_a FLOAT NOT NULL,
    operand_b FLOAT NOT NULL,
    result FLOAT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- B1. Insert users. Expected: 2 rows, IDs 1 and 2 in fresh tables.
INSERT INTO users (username, email)
VALUES
    ('alice', 'alice@example.com'),
    ('bob', 'bob@example.com');

-- B2. Insert calculations. Expected: 3 rows.
-- These IDs assume the fresh tables created above.
INSERT INTO calculations (operation, operand_a, operand_b, result, user_id)
VALUES
    ('add', 2, 3, 5, 1),
    ('divide', 10, 2, 5, 1),
    ('multiply', 4, 5, 20, 2);

-- C1. Retrieve users. Expected: Alice and Bob.
SELECT * FROM users ORDER BY id;

-- C2. Retrieve calculations. Expected: 3 rows before update/deletion.
SELECT * FROM calculations ORDER BY id;

-- C3. Join the foreign key to the parent primary key.
-- Expected: Alice has 2 calculations; Bob has 1.
SELECT u.username, c.operation, c.operand_a, c.operand_b, c.result
FROM calculations c
JOIN users u ON c.user_id = u.id
ORDER BY c.id;

-- D1. Demonstrate UPDATE. Expected: 1 returned row, result = 6.
-- This deliberately changes the stored result for the assignment;
-- 6 is not the correct mathematical result of 2 + 3. So the operation is also changed to multiply.
UPDATE calculations
SET operation='multiply', result = 6
WHERE id = 1;

-- E1. Demonstrate DELETE. Expected: calculation 2 is removed.
DELETE FROM calculations
WHERE id = 2;

-- No user is deleted here; ON DELETE CASCADE is defined but not exercised.

