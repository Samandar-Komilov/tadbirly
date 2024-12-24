-- 001_register_user.sql

CREATE OR REPLACE FUNCTION register_user(
    p_username VARCHAR,
    p_email VARCHAR,
    p_password VARCHAR,
    p_phone_number VARCHAR,
    p_country_id INTEGER,
    p_region_id INTEGER,
    p_role_id INTEGER
) RETURNS BOOLEAN AS 
$body$
DECLARE
    v_password_hash VARCHAR;
BEGIN
	-- RAISE NOTICE is for debugging
    RAISE NOTICE 'Registering user: %', p_username;

    v_password_hash := crypt(p_password, gen_salt('bf'));

    RAISE NOTICE 'Password hash: %', v_password_hash;

    INSERT INTO "User" (username, email, password, phone_number, country_id, region_id, role_id)
    VALUES (p_username, p_email, v_password_hash, p_phone_number, p_country_id, p_region_id, p_role_id);

    RAISE NOTICE 'User % successfully registered', p_username;

    RETURN TRUE;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error occurred: %', SQLERRM;
        RETURN FALSE;
END;
$body$
LANGUAGE plpgsql;


select register_user('admin', 'admin@gmail.com', 'admin123', '+998770007941', 240, 93, 1);