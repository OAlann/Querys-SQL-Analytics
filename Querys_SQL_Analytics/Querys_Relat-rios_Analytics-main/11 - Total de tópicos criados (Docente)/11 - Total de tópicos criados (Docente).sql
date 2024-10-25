SELECT 
    c.fullname AS Curso,
    CONCAT(u.firstname, ' ', u.lastname) AS Docente,
    u.email AS Email,
    COUNT(fd.id) AS Total_Topicos_Criados
FROM 
    g4s7_forum_discussions fd
JOIN 
    g4s7_forum f ON f.id = fd.forum
JOIN 
    g4s7_course c ON c.id = f.course
JOIN 
    g4s7_user u ON u.id = fd.userid
JOIN 
    g4s7_role_assignments ra ON ra.userid = u.id
JOIN 
    g4s7_context ctx ON ctx.id = ra.contextid AND ctx.contextlevel = 50
JOIN 
    g4s7_role r ON r.id = ra.roleid
WHERE 
    r.shortname IN ('editingteacher', 'teacher') -- Filtra os cargos de docentes
GROUP BY 
    c.fullname, Docente, u.email
ORDER BY 
    Curso, Docente;