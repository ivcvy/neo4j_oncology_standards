MATCH (target:Attribute)
UNWIND target.StandardValuesList AS value
WITH target, apoc.text.replace(value, '\\s*\\{.*\\}', '') AS extractedValue
MERGE (child:StandardValue {value: extractedValue})
MERGE (target)-[:HAS_STANDARD_VALUE]->(child);