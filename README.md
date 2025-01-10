# neo4j_oncology_standards
Load real-world oncology standards in Neo4j.

# basic queries

## setup
### test apoc extension
```cypher
CALL apoc.help('load')
```
### load driver manually
```cypher
CALL apoc.load.driver('org.postgresql.Driver')
```

## counts
### count entities
```cypher
MATCH (n)
RETURN count(n) AS nodeCount
```
### count relations
```cypher
MATCH ()-[r]->()
RETURN count(r) AS relationshipCount
```
### count triples
```cypher
MATCH (s)-[p]->(o)
RETURN count(*) AS tripleCount
```
### count values
```cypher
/// o3
MATCH (n:StandardValue)
RETURN count(n)

// omop
MATCH (n)
WHERE any(label IN labels(n) WHERE label IN ["AnatomicSite", "Condition", "ConditionStatus", "Device", "Drug", "Episode", "EpisodeEvent", "Ethnicity", "Gender", "Measurement", "Modifier", "NoteClass", "Operator", "Payer", "Plan", "PlanStopReason", "Procedure", "Provider", "Race", "Specimen", "Sponsor", "TypeConcept", "Unit", "Visit"])
RETURN count(n)

// mcode
MATCH (n:ValueSetElement)
RETURN count(n)
```
## export
### custom csv export query
```cypher
MATCH (p)-[r1]-(n)-[r2]-(m)-[r3]-(o) WHERE n.label={LABEL}
WITH collect(distinct p) + collect(distinct n) + collect(distinct m) + collect(distinct o) AS nodes, collect(distinct r1) + collect(distinct r2) + collect(distinct r3) AS relationships
CALL apoc.export.csv.data([], relationships, 'edges.csv', {}) YIELD file as edgefile
CALL apoc.export.csv.data(nodes, [], 'nodes.csv', {}) YIELD file as nodefile
RETURN edgefile, nodefile
```
### export database jsonl
Excluding relationship.
```cypher
CALL apoc.export.json.all("all.json",{useTypes:true});
```
### import database jsonl
```cypher
CALL apoc.load.json("file:///all.json")
```
## remove
### clear database
```cypher
MATCH (n) DETACH DELETE n
```
### batch clear database
```cypher
CALL apoc.periodic.commit(
  "MATCH (n)
   WITH n LIMIT 10000
   DETACH DELETE n
   RETURN count(n)",
  {}
)
```

# mapping
## map omop and mcode
```cypher
// full query
CALL apoc.cypher.runFiles(["build_mcode.cypher", "build_omop.cypher", "omop_standard_values.cypher", "add_global_property.cypher", "map_mcode_omop.cypher"]);
```
```cypher
// get matched standard values
MATCH (m:ValueSet)-[r]-(n:ValueSetElement)<-[:DIRECT_MATCH]-(o)
RETURN m.label, n.label, o.domain_id

// non mapped values in mcode
MATCH (m:ValueSet)-[r]-(n:ValueSetElement)
WHERE NOT (n)<-[:DIRECT_MATCH]-()
RETURN m.label, n.label
```
## map omop and o3
```cypher
// full query
CALL apoc.cypher.runFiles(["build_o3.cypher", "o3_standard_values.cypher", "build_omop.cypher", "omop_standard_values.cypher", "add_global_property.cypher", "map_omop_o3.cypher"]);
```
```cypher
// get the domain and concepts
MATCH p=(n)-[r:DIRECT_MATCH]->(m)<-[:HAS_STANDARD_VALUE]-(o:Attribute) RETURN n.domain_id, n.concept_name, o.StringCode

// non mapped values in o3
MATCH (m:Attribute)-[r]-(n:StandardValue)
WHERE NOT (n)<-[:DIRECT_MATCH]-()
RETURN m.label, n.label
ORDER BY m.label
```
## map o3 and mcode
```cypher
// full query
CALL apoc.cypher.runFiles(["build_o3.cypher", "o3_standard_values.cypher", "build_mcode.cypher", "add_global_property.cypher", "map_mcode_o3.cypher"]);
```
```cypher
// find mentions of mcode
MATCH (n)-[r]-(m) WHERE toLower(m.ReferenceSystemForValues) CONTAINS "mcode"  RETURN m.StringCode
```