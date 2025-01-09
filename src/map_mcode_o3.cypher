MATCH (source {label: "RTCourseTarget_VolumeName"}), (target {label: "Radiotherapy Treatment Location Value Set"})
MERGE (source)-[:VALUE_REFERENCED_FROM]->(target);

MATCH (source {label: "RTPhase_Modality"}), (target {label: "Modality and Technique > Modality"})
MERGE (source)-[:VALUE_REFERENCED_FROM]->(target);

MATCH (source {label: "RTPhaseTarget_VolumeName"}), (target {label: "Radiotherapy Treatment Location Value Set"})
MERGE (source)-[:VALUE_REFERENCED_FROM]->(target);

MATCH (source {label: "RTPrescriptionTarget_VolumeName"}), (target {label: "Radiotherapy Treatment Location Value Set"})
MERGE (source)-[:VALUE_REFERENCED_FROM]->(target);

MATCH (source {label: "RTTreatedPlan_Modality"}), (target {label: "Modality and Technique > Modality"})
MERGE (source)-[:VALUE_REFERENCED_FROM]->(target);

MATCH (source {label: "RTTreatedPlanTarget_VolumeName"}), (target {label: "Radiotherapy Treatment Location Value Set"})
MERGE (source)-[:VALUE_REFERENCED_FROM]->(target);

MATCH (source {label: "RTTreatedPlanDetailsXRT_Technique"}), (target {label: "Photon Beam Technique Value Set"})
MERGE (source)-[:VALUE_REFERENCED_FROM]->(target);

MATCH (source {label: "RTTreatedPlanDetailsXRT_Technique"}), (target {label: "Proton Beam Technique Value Set"})
MERGE (source)-[:VALUE_REFERENCED_FROM]->(target);

MATCH (source {label: "RTTreatedPlanDetailsXRT_Technique"}), (target {label: "Neutron Beam Technique Value Set"})
MERGE (source)-[:VALUE_REFERENCED_FROM]->(target);

MATCH (source {label: "RTTreatedPlanDetailsXRT_Technique"}), (target {label: "Electron Beam Technique Value Set"})
MERGE (source)-[:VALUE_REFERENCED_FROM]->(target);

MATCH (source {label: "RTTreatedPlanDetailsXRT_Technique"}), (target {label: "Carbon Ion Beam Technique Value Set"})
MERGE (source)-[:VALUE_REFERENCED_FROM]->(target);

MATCH (source {label: "RTTreatedPlanDetailsBrachytherapy_Technique"}), (target {label: "Brachytherapy Low Dose Rate Temporary Radation Technique Value Set"})
MERGE (source)-[:VALUE_REFERENCED_FROM]->(target);

MATCH (source {label: "RTTreatedPlanDetailsBrachytherapy_Technique"}), (target {label: "Brachytherapy High Dose Rate Technique Value Set"})
MERGE (source)-[:VALUE_REFERENCED_FROM]->(target);

MATCH (source {label: "RTTreatedPlanDetailsBrachytherapy_Technique"}), (target {label: "Brachytherapy High Dose Rate Electronic Technique Value Set"})
MERGE (source)-[:VALUE_REFERENCED_FROM]->(target);

MATCH (source {label: "RTTreatedPlanDetailsBrachytherapy_Technique"}), (target {label: "Brachytherapy Pulsed Dose Rate Technique Value Set"})
MERGE (source)-[:VALUE_REFERENCED_FROM]->(target);

MATCH (source {label: "RTTreatedPlanDetailsBrachytherapy_Technique"}), (target {label: "Brachytherapy Permanent Seeds Technique Value Set"})
MERGE (source)-[:VALUE_REFERENCED_FROM]->(target);

MATCH (source {label: "RTTreatedPlanDetailsRadiopharmaceutical_Technique"}), (target {label: "Brachytherapy Radiopharmaceutical Technique Value Set"})
MERGE (source)-[:VALUE_REFERENCED_FROM]->(target);

MATCH (source:ValueSetElement), (target: Attribute)
UNWIND target.StandardValuesList AS value
WITH source, target, value, apoc.text.replace(value, '\\s*\\{.*\\}', '') AS extractedValue
WHERE toLower(extractedValue) = toLower(source.label) AND id(source) <> id(target)
MERGE (source)-[:DIRECT_MATCH]->(target)