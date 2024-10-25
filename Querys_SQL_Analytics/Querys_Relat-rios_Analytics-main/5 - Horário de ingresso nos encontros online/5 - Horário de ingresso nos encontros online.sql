SELECT 
    CONCAT(u.firstname, ' ', u.lastname) AS "Nome", 
    u.email AS "E-mail", 
    c.fullname AS "Curso", 
    (
        SELECT g.name 
        FROM prefix_groups_members gm 
        JOIN prefix_groups g ON gm.groupid = g.id 
        WHERE gm.userid = u.id AND g.courseid = c.id 
        LIMIT 1
    ) AS "Turma",
    DATE_FORMAT(FROM_UNIXTIME(att.sessdate), '%d/%m/%Y %H:%i') AS "Registro de presença (manual)",
    (
        SELECT GROUP_CONCAT(g.name SEPARATOR ', ')
        FROM prefix_groups_members gm
        JOIN prefix_groups g ON gm.groupid = g.id
        WHERE gm.userid = u.id AND g.courseid = c.id
    ) AS "Grupos",
    IFNULL(
        DATE_FORMAT(FROM_UNIXTIME(lsl.timecreated), '%d/%m/%Y %H:%i:%s'), 
        'Sem registros'
    ) AS "Horário de Ingresso (via link)"
FROM 
    prefix_attendance_sessions AS att
JOIN 
    prefix_attendance_log AS attlog ON att.id = attlog.sessionid
JOIN 
    prefix_attendance_statuses AS attst ON attlog.statusid = attst.id
JOIN 
    prefix_attendance AS a ON att.attendanceid = a.id
JOIN 
    prefix_course AS c ON a.course = c.id
JOIN 
    prefix_user AS u ON attlog.studentid = u.id
LEFT JOIN 
    prefix_logstore_standard_log lsl ON lsl.userid = u.id
    AND lsl.courseid = c.id
    AND lsl.component = 'mod_page'
    AND lsl.action IN ('clicked', 'viewed', 'view', 'access')
LEFT JOIN 
    prefix_page p ON lsl.contextinstanceid = p.id
    AND p.name LIKE '%Sala virtual%'
WHERE 
    attst.acronym = 'Pr'
ORDER BY 
    c.fullname, lsl.timecreated