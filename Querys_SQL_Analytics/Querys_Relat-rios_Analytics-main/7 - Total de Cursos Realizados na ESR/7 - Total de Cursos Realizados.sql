SELECT DISTINCT 
    CONCAT(u.firstname, ' ', u.lastname) AS aluno, 
    u.email, 
    c.fullname AS curso, 
    COALESCE(g.name, 'Sem turma') AS turma, 
    FROM_UNIXTIME(c.startdate, '%d/%m/%y') AS data_inicio, 
    FROM_UNIXTIME(cc.timecompleted, '%d/%m/%y') AS data_termino, 
    CASE 
        WHEN final_grade.finalgrade >= grade_items.gradepass THEN 'Aprovado' 
        ELSE 'Reprovado' 
    END AS status_aprovacao 
FROM 
    mdl_course_completions cc 
JOIN 
    mdl_user u ON cc.userid = u.id 
JOIN 
    mdl_course c ON cc.course = c.id 
LEFT JOIN (
    SELECT 
        gm.userid, 
        MAX(g.name) AS name, 
        g.courseid 
    FROM 
        mdl_groups_members gm 
    LEFT JOIN 
        mdl_groups g ON gm.groupid = g.id 
    GROUP BY 
        gm.userid, g.courseid
) AS g ON g.userid = u.id AND g.courseid = c.id 
LEFT JOIN 
    mdl_grade_grades final_grade ON final_grade.userid = u.id 
LEFT JOIN 
    mdl_grade_items grade_items ON grade_items.courseid = c.id AND final_grade.itemid = grade_items.id 
WHERE 
    cc.timecompleted IS NOT NULL 
    AND grade_items.itemtype = 'course' 
ORDER BY 
    aluno, c.fullname;
