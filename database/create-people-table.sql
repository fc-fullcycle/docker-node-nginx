CREATE TABLE IF NOT EXISTS nodedb.people (
    id INT NOT NULL auto_increment,
    name VARCHAR(255) NOT NULL,

    PRIMARY KEY (id),
    CONSTRAINT UC_NAME UNIQUE (name)
);
