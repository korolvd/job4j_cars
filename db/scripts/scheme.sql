CREATE TABLE IF NOT EXISTS body
(
    id SERIAL PRIMARY KEY,
    type TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS brand
(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS car
(
    id SERIAL PRIMARY KEY,
    brand_id INT NOT NULL REFERENCES brand(id),
    body_id INT NOT NULL REFERENCES body(id),
    vin VARCHAR UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS users
(
    id SERIAL PRIMARY KEY,
    name TEXT,
    email VARCHAR UNIQUE,
    password TEXT
);

CREATE TABLE IF NOT EXISTS post
(
    id SERIAL PRIMARY KEY,
    description TEXT,
    car_id INT NOT NULL REFERENCES car(id),
    user_id INT NOT NULL REFERENCES users(id),
    photo BYTEA,
    visible BOOLEAN
);

CREATE TABLE IF NOT EXISTS history_owner
(
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(id),
    car_id INT NOT NULL REFERENCES car(id)
);