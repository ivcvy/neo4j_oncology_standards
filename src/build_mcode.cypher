CALL apoc.load.jsonArray("file:///mCODEDataDictionary-STU4.json") YIELD value
UNWIND value.profiles AS profile
CREATE (n:Profile)
SET n += profile;

CALL apoc.load.json("file:///mCODEDataDictionary-STU4.json") YIELD value
UNWIND value.profileElements AS element
CREATE (n:ProfileElement)
SET n += element

WITH n
MATCH (p:Profile)
WHERE p.title = n["Profile Title"]
MERGE (p)-[:HAS_PROFILE_ELEMENT]->(n);

CALL apoc.load.json("file:///mCODEDataDictionary-STU4.json") YIELD value
UNWIND value.valueSets AS set
CREATE (n:ValueSet)
SET n += set

WITH n
MATCH (e:ProfileElement)
WHERE e["Value Set URI"] = n.url
MERGE (e)-[:HAS_VALUE_SET]->(n);

CALL apoc.load.json("file:///mCODEDataDictionary-STU4.json") YIELD value
UNWIND value.valueSetElements AS sete
CREATE (n:ValueSetElement)
SET n += sete

WITH n
MATCH (s:ValueSet)
WHERE s.url = n["Value set URI"]
MERGE (s)-[:HAS_VALUE_SET_ELEMENT]->(n);

CALL apoc.load.json("file:///mCODEDataDictionary-STU4.json") YIELD value
UNWIND value.extensions AS ext
CREATE (n:Extension)
SET n += ext;

CALL apoc.load.json("file:///mCODEDataDictionary-STU4.json") YIELD value
UNWIND value.codeSystems AS sys
CREATE (n:CodeSystem)
SET n += sys;