MATCH (n:AnatomicSite)
SET n.label = n.concept_name;

MATCH (n:Attribute)
SET n.label = n.StringCode;

MATCH (n:CodeSystem)
SET n.label = n.title;

MATCH (n:Column)
SET n.label = n.name;

MATCH (n:Condition)
SET n.label = n.concept_name;

MATCH (n:ConditionStatus)
SET n.label = n.concept_name;

MATCH (n:Device)
SET n.label = n.concept_name;

CALL apoc.periodic.iterate(
  'MATCH (n:Drug) RETURN n',
  'SET n.label = n.concept_name',
  {batchSize: 1000, iterateList: true, parallel: true}
);

MATCH (n:Episode)
SET n.label = n.concept_name;

MATCH (n:EpisodeEvent)
SET n.label = n.concept_name;

MATCH (n:Ethnicity)
SET n.label = n.concept_name;

MATCH (n:Extension)
SET n.label = n.title;

MATCH (n:Gender)
SET n.label = n.concept_name;

MATCH (n:KeyElement)
SET n.label = n.StringCode;

MATCH (n:Measurement)
SET n.label = n.concept_name;

MATCH (n:Modifier)
SET n.label = n.concept_name;

MATCH (n:NoteClass)
SET n.label = n.concept_name;

MATCH (n:Operator)
SET n.label = n.concept_name;

MATCH (n:Payer)
SET n.label = n.concept_name;

MATCH (n:Plan)
SET n.label = n.concept_name;

MATCH (n:PlanStopReason)
SET n.label = n.concept_name;

MATCH (n:Procedure)
SET n.label = n.concept_name;

MATCH (n:Profile)
SET n.label = n.title;

MATCH (n:ProfileElement)
SET n.label = n["Data Element Name"];

MATCH (n:Provider)
SET n.label = n.concept_name;

MATCH (n:Race)
SET n.label = n.concept_name;

MATCH (n:Specimen)
SET n.label = n.concept_name;

MATCH (n:Sponsor)
SET n.label = n.concept_name;

MATCH (n:StandardValue)
SET n.label = n.value;

MATCH (n:Table)
SET n.label = n.name;

MATCH (n:TypeConcept)
SET n.label = n.concept_name;

MATCH (n:Unit)
SET n.label = n.concept_name;

MATCH (n:ValueSet)
SET n.label = n.title;

MATCH (n:ValueSetElement)
SET n.label = n["Code description"];

MATCH (n:Visit)
SET n.label = n.concept_name;