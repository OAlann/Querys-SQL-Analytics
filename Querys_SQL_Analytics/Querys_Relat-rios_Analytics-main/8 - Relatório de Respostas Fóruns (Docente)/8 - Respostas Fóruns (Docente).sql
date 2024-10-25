SELECT 
    CONCAT(u.firstname, ' ', u.lastname) AS Nome_Completo, 
    u.email AS Email, 
    c.fullname AS Curso, 
    fp.subject AS Titulo_Resposta, 
    REGEXP_REPLACE(fp.message, '<[^>]*>', '') AS Resposta_Forum, 
    FROM_UNIXTIME(fp.created) AS Data_Resposta 
FROM 
    mdl_forum_posts fp 
JOIN 
    mdl_forum_discussions fd ON fd.id = fp.discussion 
JOIN 
    mdl_course c ON c.id = fd.course 
JOIN 
    mdl_user u ON u.id = fp.userid 
JOIN 
    mdl_role_assignments ra ON ra.userid = u.id 
JOIN 
    mdl_context ctx ON ra.contextid = ctx.id AND ctx.contextlevel = 50  -- Contexto de curso
JOIN 
    mdl_role r ON ra.roleid = r.id 
WHERE 
    r.shortname IN ('editingteacher', 'teacher')  -- Verifica se o usuário tem o papel de professor
    AND fp.created >= UNIX_TIMESTAMP(NOW() - INTERVAL 360 DAY)  -- Filtra apenas respostas dos últimos 360 dias
ORDER BY 
    fp.created DESC;
