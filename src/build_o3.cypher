CALL apoc.load.jsonArray("file:///O3_20240221.json") YIELD value
UNWIND value AS key
MERGE (n:KeyElement {name: key.KeyElementName})
SET n += key.keyelementdetail
WITH key, n
UNWIND key.list_attributes AS attr
MERGE (a:Attribute {id: attr.NumericCode})
SET a += attr
MERGE (n)-[r:HAS_ATTRIBUTE]->(a);

CALL apoc.load.jsonArray("file:///O3_20240221.json") YIELD value
UNWIND value.list_relationships AS item
MATCH (s) WHERE (s:KeyElement OR s:Attribute) AND s.StringCode = item.SubjectElement
MATCH (p) WHERE (p:KeyElement OR p:Attribute) AND p.StringCode = item.PredicateElement
WITH item, REPLACE(item.RelationshipCategory, '-', '_') AS relationshipType, s, p
CALL apoc.create.relationship(s, relationshipType, {}, p) YIELD rel
SET rel = item;