CREATE OR REPLACE TABLE Region (id BIGINT);
CREATE OR REPLACE TABLE Route (id BIGINT, active BOOLEAN);
CREATE OR REPLACE TABLE Segment (id BIGINT, length INTEGER);
CREATE OR REPLACE TABLE Semaphore (id BIGINT, signal VARCHAR);
CREATE OR REPLACE TABLE Sensor (id BIGINT);
CREATE OR REPLACE TABLE Switch (id BIGINT, currentPosition VARCHAR);
CREATE OR REPLACE TABLE SwitchPosition (id BIGINT, position VARCHAR);
CREATE OR REPLACE TABLE connectsTo (TrackElement1_id BIGINT, TrackElement2_id BIGINT);
CREATE OR REPLACE TABLE entry (Route_id BIGINT, Semaphore_id BIGINT);
CREATE OR REPLACE TABLE exit (Route_id BIGINT, Semaphore_id BIGINT);
CREATE OR REPLACE TABLE follows (Route_id BIGINT, SwitchPosition_id BIGINT);
CREATE OR REPLACE TABLE monitoredBy (TrackElement_id BIGINT, Sensor_id BIGINT);
CREATE OR REPLACE TABLE requires (Route_id BIGINT, Sensor_id BIGINT);
CREATE OR REPLACE TABLE target (SwitchPosition_id BIGINT, Switch_id BIGINT);

COPY Region         FROM 'data/railway-repair-4096-Region.csv'         (HEADER true, DELIMITER ',', QUOTE '"');
COPY Route          FROM 'data/railway-repair-4096-Route.csv'          (HEADER true, DELIMITER ',', QUOTE '"');
COPY Segment        FROM 'data/railway-repair-4096-Segment.csv'        (HEADER true, DELIMITER ',', QUOTE '"');
COPY Semaphore      FROM 'data/railway-repair-4096-Semaphore.csv'      (HEADER true, DELIMITER ',', QUOTE '"');
COPY Sensor         FROM 'data/railway-repair-4096-Sensor.csv'         (HEADER true, DELIMITER ',', QUOTE '"');
COPY Switch         FROM 'data/railway-repair-4096-Switch.csv'         (HEADER true, DELIMITER ',', QUOTE '"');
COPY SwitchPosition FROM 'data/railway-repair-4096-SwitchPosition.csv' (HEADER true, DELIMITER ',', QUOTE '"');
COPY connectsTo     FROM 'data/railway-repair-4096-connectsTo.csv'     (HEADER true, DELIMITER ',', QUOTE '"');
COPY entry          FROM 'data/railway-repair-4096-entry.csv'          (HEADER true, DELIMITER ',', QUOTE '"');
COPY exit           FROM 'data/railway-repair-4096-exit.csv'           (HEADER true, DELIMITER ',', QUOTE '"');
COPY follows        FROM 'data/railway-repair-4096-follows.csv'        (HEADER true, DELIMITER ',', QUOTE '"');
COPY monitoredBy    FROM 'data/railway-repair-4096-monitoredBy.csv'    (HEADER true, DELIMITER ',', QUOTE '"');
COPY requires       FROM 'data/railway-repair-4096-requires.csv'       (HEADER true, DELIMITER ',', QUOTE '"');
COPY target         FROM 'data/railway-repair-4096-target.csv'         (HEADER true, DELIMITER ',', QUOTE '"');

DROP TABLE IF EXISTS Region; -- region is not used

CREATE OR REPLACE TABLE Route AS
    SELECT id, active, entry.Semaphore_id AS entry, exit.Semaphore_id AS exit
    FROM Route
    LEFT JOIN entry ON entry.Route_id = id
    LEFT JOIN exit ON exit.Route_id = id;

CREATE OR REPLACE TABLE SwitchPosition AS
    SELECT id, follows.Route_id AS route, Switch_id AS target, position
    FROM SwitchPosition
    JOIN follows ON follows.SwitchPosition_id = id
    JOIN target ON target.SwitchPosition_id = id;
