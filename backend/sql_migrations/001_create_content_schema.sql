-- Create schema
CREATE SCHEMA content AUTHORIZATION admin;

-- Create content table
CREATE TABLE content.notes (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);


----------
--DROP TABLE content.notes;
