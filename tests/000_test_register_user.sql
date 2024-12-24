-- tests/000_test_register_user.sql


-- PGTAP extension for testing
create extension if not exists "pgtap";

-- Number of tests
SELECT plan(2);

/*
    T1: Check if the function returns TRUE on successful user registration
*/
BEGIN;
SELECT is(
    register_user('admin', 'admin@gmail.com', 'admin123', '+998770007941', 240, 93, 1),
    TRUE,
    'register_user should return TRUE on successful registration'
);
ROLLBACK;


/*
    T2: Verify user is inserted into the "User" table after registration
*/
BEGIN;
SELECT is(
    (SELECT count(*) FROM "User" WHERE email = 'admin@gmail.com'),
    1,
    'There should be 1 user with the email admin@gmail.com'
);
ROLLBACK;

SELECT * FROM finish();