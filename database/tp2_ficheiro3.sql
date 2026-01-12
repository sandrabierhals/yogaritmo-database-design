/*******************************************************************************
   Studio Yogaritmo Database - Version 1.7
   Script: Yogaritmo_PostgreSql.sql
   Description: Queries to answer business questions, trigger and store procedure.
   DB Server: PostgreSql
   Author: Sandra Bierhals 
********************************************************************************/


/*******************************************************************************
   Questions, queries and outputs
********************************************************************************/
-- 1) How many classes were taught by each instructor?
SELECT "Professor"."Nome",
    (SELECT COUNT("ID_Aula") 
	 FROM "Aula" 
	 WHERE "ID_Prof" = "Professor"."ID_Prof") AS "QuantidadeAulas"
FROM "Professor";

-- Output
"Nome","QuantidadeAulas"
"David Hogan                                                 ","0"
"Sarah Smith                                                 ","1"
"Samuel Wilson                                               ","2"
"Mr. Daniel Morris                                           ","1"
"Crystal Brewer                                              ","1"
"Lúcia Fernandes                                             ","0"
"Ana Pereira                                                 ","2"
"Sarah Lee                                                   ","2"
"Stanley Chandler                                            ","1"
"Brandy Lee                                                  ","3"
"Elizabeth Yoder                                             ","2"
"Katelyn Mcgrath                                             ","1"
"Billy Valencia                                              ","1"
"Jared Martinez                                              ","1"
"Lydia Santana                                               ","0"
"Shari Blair                                                 ","1"
"Peter Evans                                                 ","1"
"Latasha Sandoval                                            ","2"
"Megan Moore                                                 ","2"
"Michael Smith                                               ","1"

-- 2) Which classes have an average feedback score lower than 3?
SELECT "Aula"."ID_Aula", "Aula"."Data", "Aula"."Hora", "TipoDeAula"."Tipo"
FROM "Aula"
JOIN "TipoDeAula" ON "Aula"."ID_TipoDeAula" = "TipoDeAula"."ID_TipoDeAula"
WHERE (
    SELECT AVG("Nota")
    FROM "Feedback"
    WHERE "ID_Aula" = "Aula"."ID_Aula") < ANY (SELECT 3);
	
--Output
"ID_Aula","Data","Hora","Tipo"
2,"2023-06-30","14:30:00","Iyengar Yoga                            "
6,"2023-09-30","15:30:00","Pilates                                 "
9,"2023-11-26","18:00:00","Hatha Yoga                              "
15,"2023-07-06","16:30:00","Yin Yoga                                "
17,"2023-02-21","18:30:00","Hot Yoga                                "
22,"2023-01-30","15:00:00","Chanting                                "
25,"2023-06-08","18:00:00","Yin Yoga                                "

-- 3) What is the average age of clients for each type of class?
SELECT "TipoDeAula"."Tipo", ROUND(AVG("Cliente"."Idade")) AS "MediaIdadeClientes"
FROM "Cliente"
	JOIN "Feedback" ON "Cliente"."ID_Cliente" = "Feedback"."ID_Cliente"
	JOIN "Aula" ON "Feedback"."ID_Aula" = "Aula"."ID_Aula"
	JOIN "TipoDeAula" ON "Aula"."ID_TipoDeAula" = "TipoDeAula"."ID_TipoDeAula"
GROUP BY "TipoDeAula"."Tipo";

--Output
"Tipo","MediaIdadeClientes"
"Chanting                                ","35"
"Pilates                                 ","56"
"Ashtanga Yoga                           ","27"
"Hatha Yoga                              ","38"
"Iyengar Yoga                            ","29"
"Hot Yoga                                ","39"
"Yin Yoga                                ","53"
"Vinyasa Yoga                            ","62"

-- 4) Which instructors teach Yin Yoga on Friday mornings?
SELECT "Professor"."Nome"
FROM "Professor"
	JOIN "Aula" ON "Professor"."ID_Prof" = "Aula"."ID_Prof"
	JOIN "TipoDeAula" ON "Aula"."ID_TipoDeAula" = "TipoDeAula"."ID_TipoDeAula"
WHERE "TipoDeAula"."Tipo" = 'Yin Yoga'
    AND EXTRACT(DOW FROM "Aula"."Data") = 6 /* Filters classes that take place on Fridays. DOW = “Day of Week”: Sunday = 0, Monday = 1, etc. */
    AND "Aula"."Hora" < '12:00:00'; /* Filters classes that start in the morning. */

-- Output
"Nome"
"Megan Moore                                                 "

-- 5) What is the total revenue generated in this quarter?
SELECT SUM("Preco") AS "ReceitaTotal"
FROM "Pagamento"
WHERE "Data" BETWEEN '2023-10-01' AND '2023-12-31';

-- Output
"ReceitaTotal"
115

-- 6) What is the average feedback score for Pilates classes?
SELECT ROUND(AVG("Feedback"."Nota"),2) AS "MediaFeedbackPilates"
FROM "Feedback" 
	JOIN "Aula" ON "Feedback"."ID_Aula" = "Aula"."ID_Aula"
	JOIN "TipoDeAula" ON "Aula"."ID_TipoDeAula" = "TipoDeAula"."ID_TipoDeAula"
WHERE "TipoDeAula"."Tipo" = 'Pilates';

-- Output
"MediaFeedbackPilates"
1.00

/*******************************************************************************
   Trigger
********************************************************************************/
-- Trigger to update the TotalAlunosPorProfessor table whenever a new record is inserted into Reserva.

-- Creates a table to store the total number of students per instructor per month.
CREATE TABLE IF NOT EXISTS "TotalAlunosPorProfessor" (
    "ID_Prof" INT,
    "Ano" INT,
    "Mes" INT,
    "TotalAlunos" INT,
    PRIMARY KEY ("ID_Prof", "Ano", "Mes"),
    FOREIGN KEY ("ID_Prof") REFERENCES "Professor"("ID_Prof")
);

-- Updates the table with existing historical data
INSERT INTO "TotalAlunosPorProfessor" ("ID_Prof", "Ano", "Mes", "TotalAlunos")
SELECT A."ID_Prof",
       EXTRACT(YEAR FROM R."Data") AS "Ano",
       EXTRACT(MONTH FROM R."Data") AS "Mes",
       COUNT(*) AS "TotalAlunos"
FROM "Reserva" R
	JOIN "Aula" A ON R."ID_Aula" = A."ID_Aula"
GROUP BY
    A."ID_Prof", EXTRACT(YEAR FROM R."Data"), EXTRACT(MONTH FROM R."Data")
ON CONFLICT ("ID_Prof", "Ano", "Mes") DO UPDATE
SET "TotalAlunos" = "TotalAlunosPorProfessor"."TotalAlunos" + EXCLUDED."TotalAlunos";

-- Checks the table
SELECT *
FROM "TotalAlunosPorProfessor";

-- Output
"ID_Prof","Ano","Mes","TotalAlunos"
7,2023,6,1
16,2023,3,1
4,2023,6,1
3,2023,3,2
19,2023,7,1
19,2023,1,4
10,2023,2,3
19,2023,2,1
5,2023,10,1
11,2023,12,1
11,2023,5,1
3,2023,10,1
13,2023,4,1
11,2023,11,1
17,2023,7,1
18,2023,12,1
3,2023,1,1
8,2023,9,1
4,2023,10,1
20,2023,5,1

-- Creates the trigger function
CREATE OR REPLACE FUNCTION atualiza_total_alunos_por_professor()
RETURNS TRIGGER AS $$
DECLARE
    ano_reserva INT;
BEGIN
    -- Extract the year of the reservation date
    ano_reserva := EXTRACT(YEAR FROM NEW."Data");

    -- Check if there is already a record for the instructor and month
    IF EXISTS (
        SELECT 1 
        FROM "TotalAlunosPorProfessor" 
        WHERE "ID_Prof" = (SELECT "ID_Prof" FROM "Aula" WHERE "ID_Aula" = NEW."ID_Aula")
          AND "Ano" = ano_reserva
          AND "Mes" = EXTRACT(MONTH FROM NEW."Data")
    ) THEN
        -- If it exists, increment the total number of students
        UPDATE "TotalAlunosPorProfessor"
        SET "TotalAlunos" = "TotalAlunos" + 1
        WHERE "ID_Prof" = (SELECT "ID_Prof" FROM "Aula" WHERE "ID_Aula" = NEW."ID_Aula")
          AND "Ano" = ano_reserva
          AND "Mes" = EXTRACT(MONTH FROM NEW."Data");
    ELSE
        -- If it does not exist, create a new record with total = 1
        INSERT INTO "TotalAlunosPorProfessor" ("ID_Prof", "Ano", "Mes", "TotalAlunos")
        VALUES ((SELECT "ID_Prof" FROM "Aula" WHERE "ID_Aula" = NEW."ID_Aula"), ano_reserva, EXTRACT(MONTH FROM NEW."Data"), 1);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Creates the trigger that calls the function after an INSERT on "Reserva"
CREATE TRIGGER atualiza_total_alunos_trigger
AFTER INSERT ON "Reserva"
FOR EACH ROW
EXECUTE FUNCTION atualiza_total_alunos_por_professor();

-- Test for trigger functionality with new reservations
INSERT INTO "Reserva" ("ID_Reserva", "Data", "Hora", "ID_Cliente", "ID_Aula")
VALUES 
   (21, '2023-01-15', '10:00', 1, 1),  -- Cliente 1 reserva aula 1 ID_Prof 19
   (22, '2023-02-20', '14:30', 2, 2),  -- Cliente 2 reserva aula 2 ID_Prof 10
   (23, '2023-01-05', '09:00', 3, 1);  -- Cliente 3 reserva aula 1 ID_Prof 19
   
-- 
"ID_Prof","Ano","Mes","TotalAlunos"
7,2023,6,1
16,2023,3,1
4,2023,6,1
3,2023,3,2
19,2023,7,1
19,2023,1,6
10,2023,2,4
19,2023,2,1
5,2023,10,1
11,2023,12,1
11,2023,5,1
3,2023,10,1
13,2023,4,1
11,2023,11,1
17,2023,7,1
18,2023,12,1
3,2023,1,1
8,2023,9,1
4,2023,10,1
20,2023,5,1

/*******************************************************************************
   Store Procedure
********************************************************************************/
-- Requirements:
-- Validate that the client and the class exist.
-- Ensure that the client attended the class before allowing feedback.
-- Insert feedback only if there is no previous feedback from the same client for the same class.
-- Return meaningful error/success messages.

-- Creates or replaces the function as a "Stored Procedure"
CREATE OR REPLACE FUNCTION InserirFeedback(
    p_ID_Cliente INT,
    p_ID_Aula INT,
    p_Nota INT,
    p_DataFeedback TIMESTAMP
)
RETURNS VOID AS $$
DECLARE
    v_ID_Feedback INT;
BEGIN
    -- Validate that the client exists
    IF NOT EXISTS (SELECT 1 FROM "Cliente" WHERE "ID_Cliente" = p_ID_Cliente) THEN
        RAISE EXCEPTION 'Cliente não encontrado.';
        RETURN;
    END IF;

     -- Validate that the class exists
    IF NOT EXISTS (SELECT 1 FROM "Aula" WHERE "ID_Aula" = p_ID_Aula) THEN
        RAISE EXCEPTION 'Aula não encontrada.';
        RETURN;
    END IF;

    -- Validate that the client attended the class
    IF NOT EXISTS (SELECT 1 FROM "Reserva" WHERE "ID_Cliente" = p_ID_Cliente AND "ID_Aula" = p_ID_Aula) THEN
        RAISE EXCEPTION 'Não há registro de que o cliente assistiu a esta aula.';
        RETURN;
    END IF;

    -- Validate that no previous feedback exists
    IF EXISTS (SELECT 1 FROM "Feedback" WHERE "ID_Cliente" = p_ID_Cliente AND "ID_Aula" = p_ID_Aula) THEN
        RAISE EXCEPTION 'Feedback já foi fornecido por este cliente para esta aula.';
        RETURN;
    END IF;

    -- Inserir o feedback
    BEGIN
        INSERT INTO "Feedback" ("ID_Cliente", "ID_Aula", "Nota", "Data", "Hora")
        VALUES (p_ID_Cliente, p_ID_Aula, p_Nota, p_DataFeedback, CURRENT_TIME)
        RETURNING "ID_Feedback" INTO v_ID_Feedback;

        IF v_ID_Feedback IS NOT NULL THEN
            RAISE NOTICE 'Feedback inserido com sucesso. ID_Feedback: %', v_ID_Feedback;
        ELSE
            RAISE EXCEPTION 'Falha ao inserir o feedback.';
        END IF;
    END;
END;
$$ LANGUAGE plpgsql;

-- Query feedbacks from a specific client:
SELECT "ID_Feedback", "ID_Aula", "Nota", "Data"
FROM "Feedback"
WHERE "ID_Cliente" = 2;

-- Output 
"ID_Feedback","ID_Aula","Nota","Data"
13,8,5,"2023-11-02"

-- Query all feedback for a specific class:
SELECT "ID_Feedback", "ID_Cliente", "Nota", "Data"
FROM "Feedback"
WHERE "ID_Aula" = 5; 

-- Output
"ID_Feedback","ID_Cliente","Nota","Data"
2,12,1,"2023-05-18"

-- Check whether a client attended a specific class:
SELECT 1
FROM "Reserva"
WHERE "ID_Cliente" = 5 AND "ID_Aula" = 1; 

-- Output
"?column?"
1 -- Não há registro para o cliente 5 na aula 1

-- List all clients who attended a specific class:
SELECT r."ID_Cliente", c."Nome"
FROM "Reserva" r
JOIN "Cliente" c ON r."ID_Cliente" = c."ID_Cliente"
WHERE r."ID_Aula" = 1;

-- Output
"ID_Cliente","Nome"
1,"Beth Barnett                                                "
3,"Jennifer Ramirez                                            "
18,"Michael Harris                                             "
20,"Michael Perry                                              "



