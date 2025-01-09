MATCH (source), (target:ValueSetElement)
WHERE toLower(source.label) = toLower(target.label) AND id(source) <> id(target) AND NOT (source:ValueSetElement)
MERGE (source)-[:DIRECT_MATCH]->(target);

MATCH (m:ValueSet)-[]-(n:ValueSetElement)<-[r:DIRECT_MATCH]-(o)
WHERE n.label IN ["Wound", "Whole blood", "Bone", "Skin", "Tumor"]
DELETE r
RETURN m.label, n.label, o.domain_id;