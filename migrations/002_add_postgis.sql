-- migrations/002_add_postgis.sql


-- Add PostGIS extension
CREATE EXTENSION IF NOT EXISTS postgis;


-- Add location column to User table
ALTER TABLE "User" ADD COLUMN "location" point;