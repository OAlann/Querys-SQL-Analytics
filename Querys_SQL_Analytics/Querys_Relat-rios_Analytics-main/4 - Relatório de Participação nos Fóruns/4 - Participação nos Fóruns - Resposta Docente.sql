SELECT 
    CONCAT(u.firstname, ' ', u.lastname) AS aluno, 
    u.email, 
    c.fullname AS curso, 
    (
        SELECT g.name 
        FROM mdl_groups_members gm 
        JOIN mdl_groups g ON gm.groupid = g.id 
        WHERE gm.userid = u.id 
        AND g.courseid = c.id 
        LIMIT 1
    ) AS turma, 
    fd.name AS nome_discussao, 
    REGEXP_REPLACE(fp.message, '<[^>]*>', '') AS comentario_aluno, 
    FROM_UNIXTIME(fp.created, '%d-%m-%Y %H:%i:%s') AS data, 
    COALESCE(
        REGEXP_REPLACE(fp_prof.message, '<[^>]*>', ''), 
        'sem retorno'
    ) AS comentario_professor, 
    COALESCE(
        FROM_UNIXTIME(fp_prof.created, '%d-%m-%Y %H:%i:%s'), 
        'sem retorno'
    ) AS data_comentario_professor 
FROM 
    mdl_forum_posts fp 
JOIN 
    mdl_user u ON fp.userid = u.id 
JOIN 
    mdl_forum_discussions fd ON fp.discussion = fd.id 
JOIN 
    mdl_forum f ON fd.forum = f.id 
JOIN 
    mdl_course c ON f.course = c.id 
LEFT JOIN 
    mdl_forum_posts fp_prof ON fp_prof.discussion = fp.discussion 
    AND fp_prof.parent = fp.id 
    AND fp_prof.userid != fp.userid 
    AND fp_prof.created = (
        SELECT MIN(fp_prof_inner.created) 
        FROM mdl_forum_posts fp_prof_inner 
        WHERE fp_prof_inner.parent = fp.id 
        AND fp_prof_inner.userid != fp.userid
    ) 
WHERE 
    c.visible = 1 
ORDER BY 
    aluno, curso, nome_discussao, data;
