-- --------------------------------------------------------

--
-- Nodes
--

CREATE TABLE IF NOT EXISTS Route (
  "id" BIGINT,
  "active" INTEGER,
  "entry" INTEGER,
  "exit" INTEGER,
);

CREATE TABLE IF NOT EXISTS Segment (
  "id" BIGINT,
  "length" INTEGER NOT NULL DEFAULT 1,
);

CREATE TABLE IF NOT EXISTS Sensor (
  "id" BIGINT,
);

CREATE TABLE IF NOT EXISTS Semaphore (
  "id" BIGINT,
  "segment" INTEGER NOT NULL, -- inverse of the "semaphores" edge
  "signal" VARCHAR NOT NULL,
);

CREATE TABLE IF NOT EXISTS Switch (
  "id" BIGINT,
  "currentPosition" VARCHAR NOT NULL,
);

CREATE TABLE IF NOT EXISTS SwitchPosition (
  "id" BIGINT,
  "route" INTEGER, -- inverse of the "follows" edge
  "target" INTEGER,
  "position" VARCHAR NOT NULL,
);

CREATE TABLE IF NOT EXISTS TrackElement (
  "id" BIGINT
);

--
-- Edges
--

CREATE TABLE IF NOT EXISTS connectsTo (
  "TrackElement1_id" INTEGER NOT NULL,
  "TrackElement2_id" INTEGER NOT NULL,
);

CREATE TABLE IF NOT EXISTS monitoredBy (
  "TrackElement_id" INTEGER NOT NULL,
  "Sensor_id" INTEGER NOT NULL,
);

CREATE TABLE IF NOT EXISTS requires (
  "Route_id" INTEGER NOT NULL,
  "Sensor_id" INTEGER NOT NULL,
);
