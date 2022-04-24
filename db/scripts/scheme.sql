CREATE TABLE IF NOT EXISTS body
(
    id SERIAL PRIMARY KEY,
    type TEXT NOT NULL
);

INSERT INTO body(type) VALUES ('Sedan');
INSERT INTO body(type) VALUES ('Coupe');
INSERT INTO body(type) VALUES ('Hatchback');
INSERT INTO body(type) VALUES ('Minivan');
INSERT INTO body(type) VALUES ('Truck');
INSERT INTO body(type) VALUES ('Wagon');
INSERT INTO body(type) VALUES ('SUV');

CREATE TABLE IF NOT EXISTS brand
(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

INSERT INTO brand(name) VALUES ('Lada');
INSERT INTO brand(name) VALUES ('BMV');
INSERT INTO brand(name) VALUES ('Audi');
INSERT INTO brand(name) VALUES ('Kia');
INSERT INTO brand(name) VALUES ('Toyota');
INSERT INTO brand(name) VALUES ('Volkswagen');

CREATE TABLE IF NOT EXISTS engine
(
    id SERIAL PRIMARY KEY,
    type TEXT NOT NULL,
    horsepower INT NOT NULL
);

INSERT INTO engine(type, horsepower) VALUES ('Petrol', 90);
INSERT INTO engine(type, horsepower) VALUES ('Petrol', 100);
INSERT INTO engine(type, horsepower) VALUES ('Petrol', 110);
INSERT INTO engine(type, horsepower) VALUES ('Petrol', 120);
INSERT INTO engine(type, horsepower) VALUES ('Diesel', 90);
INSERT INTO engine(type, horsepower) VALUES ('Diesel', 100);
INSERT INTO engine(type, horsepower) VALUES ('Diesel', 110);
INSERT INTO engine(type, horsepower) VALUES ('Diesel', 120);
INSERT INTO engine(type, horsepower) VALUES ('Electro', 90);
INSERT INTO engine(type, horsepower) VALUES ('Electro', 100);
INSERT INTO engine(type, horsepower) VALUES ('Electro', 110);
INSERT INTO engine(type, horsepower) VALUES ('Electro', 120);

CREATE TABLE IF NOT EXISTS car
(
    id SERIAL PRIMARY KEY,
    brand_id INT NOT NULL REFERENCES brand(id),
    engine_id INT NOT NULL REFERENCES engine(id),
    body_id INT NOT NULL REFERENCES body(id),
    vin VARCHAR UNIQUE NOT NULL
);

INSERT INTO car(brand_id, engine_id, body_id, vin) VALUES (1, 1, 1, '1');
INSERT INTO car(brand_id, engine_id, body_id, vin) VALUES (1, 1, 3, '2');
INSERT INTO car(brand_id, engine_id, body_id, vin) VALUES (1, 1, 1, '3');
INSERT INTO car(brand_id, engine_id, body_id, vin) VALUES (1, 7, 7, '4');
INSERT INTO car(brand_id, engine_id, body_id, vin) VALUES (2, 1, 1, '5');
INSERT INTO car(brand_id, engine_id, body_id, vin) VALUES (2, 2, 3, '6');
INSERT INTO car(brand_id, engine_id, body_id, vin) VALUES (2, 3, 1, '7');
INSERT INTO car(brand_id, engine_id, body_id, vin) VALUES (2, 4, 7, '8');
INSERT INTO car(brand_id, engine_id, body_id, vin) VALUES (3, 5, 1, '9');
INSERT INTO car(brand_id, engine_id, body_id, vin) VALUES (3, 6, 2, '10');
INSERT INTO car(brand_id, engine_id, body_id, vin) VALUES (3, 7, 3, '11');
INSERT INTO car(brand_id, engine_id, body_id, vin) VALUES (3, 8, 4, '12');

CREATE TABLE IF NOT EXISTS users
(
    id SERIAL PRIMARY KEY,
    name TEXT,
    email VARCHAR UNIQUE,
    password TEXT
);

INSERT INTO users(name, email, password) VALUES ('ivan', 'ivan@ivan.ivan', '123456');
INSERT INTO users(name, email, password) VALUES ('sergey', 'sergey@sergey.sergey', '123456');
INSERT INTO users(name, email, password) VALUES ('petr', 'petr@petr.petr', '123456');

CREATE TABLE IF NOT EXISTS post
(
    id SERIAL PRIMARY KEY,
    description TEXT,
    car_id INT NOT NULL REFERENCES car(id),
    user_id INT NOT NULL REFERENCES users(id),
    photo BYTEA,
    created TIMESTAMP,
    visible BOOLEAN
);

INSERT INTO post(description, car_id, user_id, photo, created, visible) VALUES ('desc1', 1, 1, NULL, current_timestamp, true);
INSERT INTO post(description, car_id, user_id, photo, created, visible) VALUES ('desc1', 2, 2, NULL, current_timestamp, true);
INSERT INTO post(description, car_id, user_id, photo, created, visible) VALUES ('desc1', 3, 3, NULL, current_timestamp, true);

CREATE TABLE IF NOT EXISTS history_owner
(
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(id),
    car_id INT NOT NULL REFERENCES car(id)
);

INSERT INTO history_owner(user_id, car_id) VALUES (1, 1);
INSERT INTO history_owner(user_id, car_id) VALUES (2, 2);
INSERT INTO history_owner(user_id, car_id) VALUES (3, 3);