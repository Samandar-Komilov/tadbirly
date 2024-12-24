-- functions/000_load_csv_data.sql

-- The code did not work, because we did not specify the filename in postgres server's appropriate path

CREATE OR REPLACE FUNCTION load_csv_data(tablename varchar, filepath varchar)
RETURNS void AS $$
BEGIN
    EXECUTE format(
        'COPY %I FROM %L DELIMITER '','' CSV HEADER',
        tablename,
        filepath
    );
END;
$$ LANGUAGE plpgsql;


select load_csv_data('Country','/home/Projects/DB/tadbirly/seeds/country.csv');