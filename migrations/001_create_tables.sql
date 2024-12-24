-- migrations/001_create_tables.sql


-- Country and Region tables (referenced from User)
create table if not exists "Country" (
	"id" serial primary key,
	"name" varchar(50) not null
);

create table if not exists "Region" (
	"id" serial primary key,
	"name" varchar(50) not null,
	"country_id" integer references "Country"("id")
);

-- Role and Permission tables (referenced from User)
create table if not exists "Role" (
	"id" serial primary key,
	"name" varchar(50) not null
);

create table if not exists "Permission" (
	"id" serial primary key,
	"name" varchar(50) not null
);

create table if not exists "RolePermission" (
	"role_id" integer references "Role"("id") on delete cascade,
	"permission_id" integer references "Permission"("id") on delete cascade,
	primary key ("role_id", "permission_id")
);


-- Users Table
create table if not exists "User" (
    "id" serial primary key,
    "username" varchar(255) not null,
    "email" varchar(255) not null unique,
    "password" varchar(255) not null,
	"phone_number" varchar(20) not null,
	"first_name" varchar(50),
	"last_name" varchar(50),
	"country_id" integer references "Country"("id"),
	"region_id" integer references "Region"("id"),
	"address" varchar(255),
	"role_id" integer references "Role"("id"),
	"created_at" timestamp default current_timestamp not null,
	"last_login" timestamp not null,
	"is_active" boolean default true not null
);


-- EventCategory and Event tables
create table if not exists "EventCategory" (
	"id" serial primary key,
	"name" varchar(50) not null,
	"description" text
);

create table if not exists "Event" (
	"id" serial primary key,
	"name" varchar(100) not null,
	"description" text,
	"category_id" integer references "EventCategory"("id") on delete restrict not null,
	"organizer_id" integer references "User"(id) on delete restrict not null,
	"start_time" timestamp not null,
	"end_time" timestamp not null,
	"country_id" integer references "Country"("id"),
	"region_id" integer references "Region"("id"),
	"address" varchar(100) not null,
	"seats" integer check("seats" >= 0),
	"created_at" timestamp default current_timestamp not null,
	"is_active" boolean default true
);


-- Ticket and Review tables

create table if not exists "Ticket" (
	"id" serial primary key,
	"event_id" integer references "Event"("id") on delete restrict not null,
	"seat_number" integer check ("seat_number" > 0) not null,
	"create_date" timestamp default current_timestamp not null,
	"user_id" integer references "User"("id") on delete restrict not null,
	"purchase_date" timestamp,
	"price" integer not null
);

create table if not exists "Review" (
	"id" serial primary key,
	"event_id" integer references "Event"("id") on delete restrict not null,
	"user_id" integer references "User"("id") on delete restrict not null,
	"rating" integer check ("rating">=0 and "rating"<=5),
	"comment" varchar(255),
	"created_at" timestamp default current_timestamp not null
);


-- Log table

create table if not exists "AuditLog" (
	"id" serial primary key,
	"user_id" integer references "User"("id"),
	"action" varchar(255) not null,
	"action_time" timestamp default current_timestamp not null,
	"details" text
);