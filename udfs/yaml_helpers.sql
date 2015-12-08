/*
YAML helpers
These are meant to help acccess the values of one-level-deep persisted ruby hashes with symbol keys.

For example:

warehouse=# SELECT yaml_timestamp(ruby_persisted_hash, 'activity_time') FROM some_table WHERE ruby_persisted_hash LIKE '%activity_time%' LIMIT 1;
   yaml_timestamp
---------------------
 2012-12-01 03:25:49
(1 row)

In order to make this work, you must upload this directory https://github.com/yaml/pyyaml/tree/master/lib/yaml
(zipped) to S3 and reference its location in the CREATE LIBRARY call below.
*/

CREATE LIBRARY yaml LANGUAGE plpythonu FROM 'xxxxxxxxxx' CREDENTIALS 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxx';

CREATE OR REPLACE FUNCTION yaml_timestamp(raw_yaml VARCHAR, key_name VARCHAR)
  RETURNS TIMESTAMP
  STABLE AS $$
    import yaml
    from yaml.constructor import SafeConstructor
    yaml.add_constructor('!ruby/object:DateTime', SafeConstructor.construct_yaml_timestamp)
    hash = yaml.load(raw_yaml)
    symbol_key = ':' + key_name
    return hash[symbol_key]
  $$ LANGUAGE plpythonu;


CREATE OR REPLACE FUNCTION yaml_float(raw_yaml VARCHAR, key_name VARCHAR)
  RETURNS REAL
  STABLE AS $$
    import yaml
    from yaml.constructor import SafeConstructor
    yaml.add_constructor('!ruby/object:DateTime', SafeConstructor.construct_yaml_timestamp)
    hash = yaml.load(raw_yaml)
    symbol_key = ':' + key_name
    return hash[symbol_key]
  $$ LANGUAGE plpythonu;

CREATE OR REPLACE FUNCTION yaml_string(raw_yaml VARCHAR, key_name VARCHAR)
  RETURNS VARCHAR
  STABLE AS $$
    import yaml
    from yaml.constructor import SafeConstructor
    yaml.add_constructor('!ruby/object:DateTime', SafeConstructor.construct_yaml_timestamp)
    hash = yaml.load(raw_yaml)
    symbol_key = ':' + key_name
    return hash[symbol_key]
  $$ LANGUAGE plpythonu;
