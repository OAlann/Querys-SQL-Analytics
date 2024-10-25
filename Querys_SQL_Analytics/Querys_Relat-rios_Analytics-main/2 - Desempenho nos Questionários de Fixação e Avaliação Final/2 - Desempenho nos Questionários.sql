SELECT 
    CONCAT(u.firstname, ' ', u.lastname) AS Aluno, 
    u.email AS Email, 
    c.fullname AS Curso, 
    g.name AS Turma, 
    q.name AS Questionario, 
    CASE 
        WHEN qg.grade IS NOT NULL THEN FORMAT(qg.grade, 2) 
        ELSE 'Sem Nota' 
    END AS Nota_Final, 
    CASE 
        WHEN quiza.timemodified IS NOT NULL THEN FROM_UNIXTIME(quiza.timemodified, '%d/%m/%Y %H:%i') 
        ELSE 'Sem Data' 
    END AS Data_de_Conclusao, 
    CASE 
        WHEN q.timeclose IS NOT NULL AND q.timeclose >= UNIX_TIMESTAMP('2023-01-01 00:00:00') 
        THEN FROM_UNIXTIME(q.timeclose, '%d/%m/%Y %H:%i') 
        ELSE 'Nao definido' 
    END AS Data_Final, 
    FROM_UNIXTIME(quiza.timestart, '%d/%m/%Y %H:%i') AS Data_de_Inicio, 
    quiza.attempt AS Tentativa 
FROM 
    mdl_quiz_attempts quiza 
JOIN 
    mdl_quiz q ON q.id = quiza.quiz 
JOIN 
    mdl_user u ON u.id = quiza.userid 
JOIN 
    mdl_course c ON c.id = q.course 
JOIN 
    mdl_groups_members gm ON gm.userid = u.id 
JOIN 
    mdl_groups g ON g.id = gm.groupid AND g.courseid = c.id 
LEFT JOIN 
    mdl_quiz_grades qg ON qg.quiz = q.id AND qg.userid = u.id 
WHERE 
    quiza.sumgrades IS NOT NULL 
    AND quiza.timemodified >= UNIX_TIMESTAMP('2023-01-01 00:00:00') 
    AND c.visible = 1 
ORDER BY 
    u.firstname, q.name, quiza.attempt;
