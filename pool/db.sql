-- open pg shell
\l lists all the databases

-- change password
alter user postgres password '<myPassword>';

-- to create database
CREATE DATABASE yummybites;

-- switch to new database 
\c yummybites

-- display tables
\d

--display table columns
\d <table name>



-- this is to create the table
CREATE TABLE "customer" (
    id SERIAL not null primary key,
    "firstName" varchar(50) not null,
    "lastName" varchar(50) not null,
    "homeAddress" varchar(255) not null,
	"cellPhone" varchar(50) not null
);

--to delete table
DROP TABLE "customer";

-- populate customer table with some data
INSERT INTO "customer" ("firstName","lastName","homeAddress","cellPhone") VALUES ('John','Lennon','345 Penny Lane, United Kingdom', '0934-652-6435');
INSERT INTO "customer" ("firstName","lastName","homeAddress","cellPhone") VALUES ('Paul','McCartney','262 Strawberry Fields, United Kingdom', '0935-652-6775');

-- check to see if data is in
SELECT * FROM "customer";


--creating products table, integer as the type for id didn't automatically create the default nextval sequence. had to do it manually with
CREATE SEQUENCE product_id_seq START 1;
ALTER TABLE product ALTER COLUMN id SET DEFAULT nextval('product_id_seq');



CREATE TABLE "product" (
    "id" SERIAL NOT NULL PRIMARY KEY,
    "name" VARCHAR(100) NOT NULL,
    "price" INTEGER NOT NULL,
    "imageUrl" VARCHAR(500) NOT NULL
);

---- populate product table with some data
INSERT INTO "product" ("name","price","imageUrl") VALUES ('dozen Chicken Empanada','150','https://www.curiouscuisiniere.com/wp-content/uploads/2018/09/Fried-Bolivian-Chicken-Empanadas.jpg.webp');
INSERT INTO "product" ("name","price","imageUrl") VALUES ('box Kutsinta','200','https://4.bp.blogspot.com/-sgxcgr2z5vo/WMbQCoYNPoI/AAAAAAAADvI/QALCKMlkfd4t_0hWAGchen_A0g4h3LGnQCLcB/s1600/Snapshot%25281264%2529.bmp');


CREATE TABLE "order" (
    "id" SERIAL NOT NULL PRIMARY KEY,
    "customerId" INTEGER NOT NULL REFERENCES "customer"(id),
    --might be easier to just do varchar than json
    "items" json NOT NULL,
    "deliveryAddress" VARCHAR(255) NOT NULL,
    "deliveryTime" TIMESTAMPTZ NOT NULL,
    "dateOrdered" TIMESTAMPTZ NOT NULL,
    "isPending" BOOLEAN NOT NULL,
    "isPaid" BOOLEAN NOT NULL
);

--insert order
INSERT INTO "order" 
(
    "customerId",
    "items",
    "deliveryAddress",
    "deliveryTime",
    "dateOrdered",
    "isPending",
    "isPaid"
) 
VALUES 
(
    '1',
    --make sure not to indent it here then copy paste into cmd
    '[{ "productId": 1, "quantity": 3 },{ "productId": 2,"quantity": 2 }]',
    'pick-up',
    '2022-03-02T17:37:51.834Z',
    '2022-02-02T17:37:51.834Z',
    'true',
    'false'
);

--insert another order
INSERT INTO "order" 
(
    "customerId",
    "items",
    "deliveryAddress",
    "deliveryTime",
    "dateOrdered",
    "isPending",
    "isPaid"
) 
VALUES 
(
    '2',
    '[{ "productId": 1, "quantity": 6 },{ "productId": 2, "quantity": 12 }]',
    '262 Strawberry Fields, United Kingdom',
    '2022-09-02T17:37:51.834Z',
    '2022-01-02T17:37:51.834Z',
    'false',
    'true'
);


--to empty a table
TRUNCATE "order";

--changing deliveryTime type to include timezone
ALTER TABLE "order" ALTER COLUMN "deliveryTime" TYPE TIMESTAMPTZ;

--to change column type that cant automatically changed to another
ALTER TABLE "order" ALTER COLUMN "items" TYPE json[] USING ("items"::json[]);


--to add a column
ALTER TABLE "order"
ADD COLUMN items json ;

--to drop column
ALTER TABLE "order"
DROP COLUMN items;


--because i put double quotes on everything, i have to do it when making queries. i think i needed double quotes though because order might be a built in name


--to rename table
ALTER TABLE "product3"
RENAME TO "product";


-- exit out of database
\q

-- exit out of regular system user
exit

-- select *
-- from doctors
--     left join(
--         select doctor_id,
--             count(*),
--             TRUNC(AVG(rating), 1) as average_rating
--         from reviews
--         group by doctor_id
--     ) reviews on doctors.id = reviews.doctor_id;


-- CREATE TABLE heat (
--     id BIGSERIAL NOT NULL PRIMARY KEY,
--     -- user_id BIGINT NOT NULL REFERENCES user(id),
--     title VARCHAR(50) NOT NULL,
--     body VARCHAR(255) NOT NULL,
--     rank INT NOT NULL check( rank > 0 )
-- );


--