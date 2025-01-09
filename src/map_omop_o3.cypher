MATCH (source), (target:StandardValue)
WHERE toLower(target.value) = toLower(source.label) AND id(source) <> id(target) AND NOT (source:StandardValue) AND NOT (source:Column)
MERGE (source)-[:DIRECT_MATCH]->(target);

MATCH (n)-[r:DIRECT_MATCH]->(m)<-[:HAS_STANDARD_VALUE]-(o:Attribute)
WHERE n.label IN ["Japanese", "Korean", "testosterone", "water", "Revision", "Lithotomy"] OR (n.label IN ["Fluoroscopy", "Positron emission tomography"] AND o.StringCode = "Image_Type")
DELETE r
RETURN n.domain_id, n.label, o.StringCode