WITH 'jdbc:postgresql://localhost:5432/{dbname}?user={user}&password={password}' as url
CALL apoc.load.jdbc(url, "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' AND table_type = 'BASE TABLE'") YIELD row
MERGE (t:Table {name: row.table_name})
WITH t, url

CALL apoc.load.jdbc(url, "SELECT column_name, data_type, is_nullable, column_default FROM information_schema.columns WHERE table_schema = 'public' AND table_name = '" + t.name + "'") YIELD row
MERGE (c:Column {name: row.column_name, table: t.name})
SET c.data_type = row.data_type, c.is_nullable = row.is_nullable, c.column_default = row.column_default
MERGE (t)-[:HAS_FIELD]->(c)

WITH t, url
CALL apoc.load.jdbc(url, "SELECT indexname, indexdef FROM pg_indexes WHERE schemaname = 'public' AND tablename = '" + t.name + "'") YIELD row
MATCH (t:Table)
SET t.index_name = row.indexname, t.index_def = row.indexdef

WITH t, url
CALL apoc.load.jdbc(url, "
    SELECT
        tc.constraint_name, 
        kcu.column_name
    FROM 
        information_schema.table_constraints AS tc 
        JOIN information_schema.key_column_usage AS kcu
        ON tc.constraint_name = kcu.constraint_name
    WHERE 
        tc.constraint_type = 'PRIMARY KEY' 
        AND tc.table_schema = 'public' 
        AND tc.table_name = '" + t.name + "'
") YIELD row
MATCH (t:Table)
SET t.primary_key_name = row.column_name, t.primary_key_constraint = row.constraint_name

WITH t, url
CALL apoc.load.jdbc(url, "
    SELECT
        tc.constraint_name, 
        kcu.column_name, 
        ccu.table_name AS foreign_table_name,
        ccu.column_name AS foreign_column_name
    FROM 
        information_schema.table_constraints AS tc 
        JOIN information_schema.key_column_usage AS kcu
        ON tc.constraint_name = kcu.constraint_name
        JOIN information_schema.constraint_column_usage AS ccu
        ON ccu.constraint_name = tc.constraint_name
    WHERE 
        tc.constraint_type = 'FOREIGN KEY' 
        AND tc.table_schema = 'public' 
        AND tc.table_name = '" + t.name + "'
") YIELD row
MATCH (t:Table)
SET t.target_foreign_key_name = row.column_name, t.source_foreign_key_name = row.foreign_column_name, t.source_foreign_table = row.foreign_table_name, t.foreign_key_constraint = row.constraint_name;

// add relationship to foreign table
MATCH (sourceNode), (targetNode)
WHERE sourceNode.name = targetNode.source_foreign_table
MERGE (sourceNode)-[:SOURCE_TABLE_OF]->(targetNode);

// add relationship to foreign key
MATCH (sourceNode), (targetNode)
WHERE sourceNode.name = targetNode.name AND id(sourceNode) <> id(targetNode)
MERGE (sourceNode)-[:PRIMARY_KEY_OF]->(targetNode);