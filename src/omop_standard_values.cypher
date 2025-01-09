CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.domain_id = "Gender" AND row.standard_concept = "S"
   CREATE (n:Gender) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

MATCH (parent:Column {name: "gender_concept_id"}), (child:Gender)
MERGE (parent)-[:HAS_STANDARD_VALUE]->(child);

CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.domain_id = "Race" AND row.standard_concept = "S"
   CREATE (n:Race) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

MATCH (parent:Column {name: "race_concept_id"}), (child:Race)
MERGE (parent)-[:HAS_STANDARD_VALUE]->(child);

CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.domain_id = "Ethnicity" AND row.standard_concept = "S"
   CREATE (n:Ethnicity) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

MATCH (parent:Column {name: "ethnicity_concept_id"}), (child:Ethnicity)
MERGE (parent)-[:HAS_STANDARD_VALUE]->(child);

CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.domain_id = "Type Concept" AND row.standard_concept = "S"
   CREATE (n:TypeConcept) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

MATCH (parent:Column), (child:TypeConcept)
WHERE parent.name IN ["period_type_concept_id", "visit_type_concept_id", "visit_detail_type_concept_id", "condition_type_concept_id", "drug_type_concept_id", "procedure_type_concept_id", "device_type_concept_id", "measurement_type_concept_id", "observation_type_concept_id", "death_type_concept_id", "note_type_concept_id", "specimen_type_concept_id", "episode_type_concept_id"]
MERGE (parent)-[:HAS_STANDARD_VALUE]->(child);

CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.domain_id = "Visit" AND row.standard_concept = "S"
   CREATE (n:Visit) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

MATCH (parent:Column), (child:Visit)
WHERE parent.name IN ["visit_concept_id", "admitted_from_concept_id", "discharged_to_concept_id", "visit_detail_concept_id", "place_of_service_concept_id"]
MERGE (parent)-[:HAS_STANDARD_VALUE]->(child);

CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.domain_id = "Condition" AND row.standard_concept = "S"
   CREATE (n:Condition) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

MATCH (parent:Column {name: "condition_concept_id"}), (child:Condition)
MERGE (parent)-[:HAS_STANDARD_VALUE]->(child);

CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.domain_id = "Condition Status" AND row.standard_concept = "S"
   CREATE (n:ConditionStatus) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

MATCH (parent:Column {name: "condition_status_concept_id"}), (child:ConditionStatus)
MERGE (parent)-[:HAS_STANDARD_VALUE]->(child);

CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.domain_id = "Drug" AND row.standard_concept = "S"
   CREATE (n:Drug) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'MATCH (parent:Column {name: "drug_concept_id"}), (child:Drug) RETURN parent, child',
  'MERGE (parent)-[:HAS_STANDARD_VALUE]->(child)',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.domain_id = "Procedure" AND row.standard_concept = "S"
   CREATE (n:Procedure) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'MATCH (parent:Column {name: "procedure_concept_id"}), (child:Procedure) RETURN parent, child',
  'MERGE (parent)-[:HAS_STANDARD_VALUE]->(child)',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.concept_class_id IN ["CPT4 Modifier", "HCPCS Modifier"] AND row.standard_concept = "S"
   CREATE (n:Modifier) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'MATCH (parent:Column {name: "modifier_concept_id"}), (child:Modifier) RETURN parent, child',
  'MERGE (parent)-[:HAS_STANDARD_VALUE]->(child)',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.domain_id = "Device" AND row.standard_concept = "S"
   CREATE (n:Device) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'MATCH (parent:Column {name: "device_concept_id"}), (child:Device) RETURN parent, child',
  'MERGE (parent)-[:HAS_STANDARD_VALUE]->(child)',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.domain_id = "Measurement" AND row.standard_concept = "S"
   CREATE (n:Measurement) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'MATCH (parent:Column {name: "measurement_type_concept_id"}), (child:Measurement) RETURN parent, child',
  'MERGE (parent)-[:HAS_STANDARD_VALUE]->(child)',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.domain_id = "Meas Value Operator" AND row.standard_concept = "S"
   CREATE (n:Operator) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'MATCH (parent:Column {name: "operator_concept_id"}), (child:Operator) RETURN parent, child',
  'MERGE (parent)-[:HAS_STANDARD_VALUE]->(child)',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.concept_class_id IN ["Doc Kind", "Doc Role", "Doc Setting", "Doc Subject Matter", "Doc Type of Service"] AND row. domain_id = "Meas Value" AND row.standard_concept = "S"
   CREATE (n:NoteClass) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'MATCH (parent:Column {name: "note_class_concept_id"}), (child:NoteClass) RETURN parent, child',
  'MERGE (parent)-[:HAS_STANDARD_VALUE]->(child)',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.domain_id = "Specimen" AND row.standard_concept = "S"
   CREATE (n:Specimen) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'MATCH (parent:Column {name: "specimen_concept_id"}), (child:Specimen) RETURN parent, child',
  'MERGE (parent)-[:HAS_STANDARD_VALUE]->(child)',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.domain_id = "Unit" AND row.standard_concept = "S"
   CREATE (n:Unit) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'MATCH (parent:Column {name: "unit_concept_id"}), (child:Unit) RETURN parent, child',
  'MERGE (parent)-[:HAS_STANDARD_VALUE]->(child)',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.concept_class_id = "Body Structure" AND row. domain_id = "Spec Anatomic Site" AND row.standard_concept = "S"
   CREATE (n:AnatomicSite) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'MATCH (parent:Column {name: "anatomic_site_concept_id"}), (child:AnatomicSite) RETURN parent, child',
  'MERGE (parent)-[:HAS_STANDARD_VALUE]->(child)',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.domain_id = "Provider" AND row.standard_concept = "S"
   CREATE (n:Provider) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'MATCH (parent:Column {name: "specialty_concept_id"}), (child:Provider) RETURN parent, child',
  'MERGE (parent)-[:HAS_STANDARD_VALUE]->(child)',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.domain_id = "Payer" AND row.standard_concept = "S"
   CREATE (n:Payer) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'MATCH (parent:Column {name: "payer_concept_id"}), (child:Payer) RETURN parent, child',
  'MERGE (parent)-[:HAS_STANDARD_VALUE]->(child)',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.domain_id = "Plan" AND row.standard_concept = "S"
   CREATE (n:Plan) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'MATCH (parent:Column {name: "plan_concept_id"}), (child:Plan) RETURN parent, child',
  'MERGE (parent)-[:HAS_STANDARD_VALUE]->(child)',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.domain_id = "Sponsor" AND row.standard_concept = "S"
   CREATE (n:Sponsor) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'MATCH (parent:Column {name: "sponsor_concept_id"}), (child:Sponsor) RETURN parent, child',
  'MERGE (parent)-[:HAS_STANDARD_VALUE]->(child)',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.domain_id = "Plan Stop Reason" AND row.standard_concept = "S"
   CREATE (n:PlanStopReason) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'MATCH (parent:Column {name: "stop_reason_concept_id"}), (child:PlanStopReason) RETURN parent, child',
  'MERGE (parent)-[:HAS_STANDARD_VALUE]->(child)',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.domain_id = "Episode"
   CREATE (n:Episode) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'MATCH (parent:Column {name: "episode_concept_id"}), (child:Episode) RETURN parent, child',
  'MERGE (parent)-[:HAS_STANDARD_VALUE]->(child)',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'LOAD CSV with headers FROM "file:///omop/all/all.csv" AS row FIELDTERMINATOR "\t"
   RETURN row',
  'WITH row WHERE row.concept_class_id = "Field" AND row.vocabulary_id = "CDM"
   CREATE (n:EpisodeEvent) 
   SET n += row',
  {batchSize: 1000, iterateList: true, parallel: true}
);

CALL apoc.periodic.iterate(
  'MATCH (parent:Column {name: "episode_event_field_concept_id"}), (child:EpisodeEvent) RETURN parent, child',
  'MERGE (parent)-[:HAS_STANDARD_VALUE]->(child)',
  {batchSize: 1000, iterateList: true, parallel: true}
);