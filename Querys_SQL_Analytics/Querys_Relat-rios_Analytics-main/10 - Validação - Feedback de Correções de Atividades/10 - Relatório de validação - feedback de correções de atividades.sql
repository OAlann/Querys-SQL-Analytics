SELECT 
    CONCAT(u.firstname, ' ', u.lastname) AS 'Nome Completo', 
    u.email AS 'Email do Aluno', 
    c.fullname AS 'Nome do Curso', 
    a.name AS 'Nome da Atividade', 
    g.name AS 'Turma (Grupo)', 
    CASE 
        WHEN ag.grade = -1 THEN 'Sem Nota' 
        ELSE FORMAT(ag.grade, 1) 
    END AS 'Nota Obtida', 
    TRIM(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(
                                    REPLACE(
                                        REPLACE(
                                            afc.commenttext, 
                                            '<p dir="ltr" style="text-align: justify;">', ''
                                        ), 
                                        '<p dir="ltr" style="text-align: left;">', ''
                                    ), 
                                    '<p dir="ltr">', ''
                                ), 
                                '<p>', ''
                            ), 
                            '</p>', ''
                        ), 
                        '<span lang="pt" xml:lang="pt">', ''
                    ), 
                    '</span>', ''
                ), 
                '<br>', ''
            ), 
            '&nbsp;', ' '
        )
    ) AS 'Comentário de Feedback', 
    DATE_FORMAT(FROM_UNIXTIME(ag.timemodified), '%d/%m/%Y') AS 'Data de Avaliação' 
FROM 
    mdl_assign_grades ag 
JOIN 
    mdl_user u ON ag.userid = u.id 
JOIN 
    mdl_assign a ON ag.assignment = a.id 
JOIN 
    mdl_course c ON a.course = c.id 
LEFT JOIN 
    mdl_assignfeedback_comments afc ON ag.id = afc.grade 
LEFT JOIN 
    mdl_groups_members gm ON u.id = gm.userid 
LEFT JOIN 
    mdl_groups g ON gm.groupid = g.id 
WHERE 
    ag.grade IS NOT NULL 
    AND ag.timemodified >= 1672531200  -- Data mínima: 01/01/2023 
ORDER BY 
    c.fullname, u.lastname, a.name;
