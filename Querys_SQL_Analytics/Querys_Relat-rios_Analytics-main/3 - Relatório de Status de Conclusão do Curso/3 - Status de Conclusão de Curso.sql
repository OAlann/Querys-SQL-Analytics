SELECT 
    CONCAT(u.firstname, ' ', u.lastname) AS "Aluno", 
    u.email AS "Email", 
    c.fullname AS "Curso", 
    COALESCE(g.name, 'Sem Turma') AS "Turma", 
    COALESCE(
        (
            SELECT GROUP_CONCAT(
                DISTINCT CASE m.name 
                    WHEN 'assign' THEN (SELECT a.name FROM mdl_assign a WHERE a.id = cm.instance) 
                    WHEN 'assignment' THEN (SELECT ass.name FROM mdl_assignment ass WHERE ass.id = cm.instance) 
                    WHEN 'bigbluebuttonbn' THEN (SELECT bbb.name FROM mdl_bigbluebuttonbn bbb WHERE bbb.id = cm.instance) 
                    WHEN 'book' THEN (SELECT b.name FROM mdl_book b WHERE b.id = cm.instance) 
                    WHEN 'chat' THEN (SELECT ch.name FROM mdl_chat ch WHERE ch.id = cm.instance) 
                    WHEN 'choice' THEN (SELECT chs.name FROM mdl_choice chs WHERE chs.id = cm.instance) 
                    WHEN 'data' THEN (SELECT d.name FROM mdl_data d WHERE d.id = cm.instance) 
                    WHEN 'feedback' THEN (SELECT fb.name FROM mdl_feedback fb WHERE fb.id = cm.instance) 
                    WHEN 'folder' THEN (SELECT fdr.name FROM mdl_folder fdr WHERE fdr.id = cm.instance) 
                    WHEN 'forum' THEN (SELECT f.name FROM mdl_forum f WHERE f.id = cm.instance) 
                    WHEN 'glossary' THEN (SELECT gss.name FROM mdl_glossary gss WHERE gss.id = cm.instance) 
                    WHEN 'h5pactivity' THEN (SELECT h5p.name FROM mdl_h5pactivity h5p WHERE h5p.id = cm.instance) 
                    WHEN 'imscp' THEN (SELECT imscp.name FROM mdl_imscp imscp WHERE imscp.id = cm.instance) 
                    WHEN 'label' THEN (SELECT l.name FROM mdl_label l WHERE l.id = cm.instance) 
                    WHEN 'lesson' THEN (SELECT ls.name FROM mdl_lesson ls WHERE ls.id = cm.instance) 
                    WHEN 'lti' THEN (SELECT lti.name FROM mdl_lti lti WHERE lti.id = cm.instance) 
                    WHEN 'page' THEN (SELECT p.name FROM mdl_page p WHERE p.id = cm.instance) 
                    WHEN 'quiz' THEN (SELECT q.name FROM mdl_quiz q WHERE q.id = cm.instance) 
                    WHEN 'resource' THEN (SELECT r.name FROM mdl_resource r WHERE r.id = cm.instance) 
                    WHEN 'scorm' THEN (SELECT sc.name FROM mdl_scorm sc WHERE sc.id = cm.instance) 
                    WHEN 'survey' THEN (SELECT sv.name FROM mdl_survey sv WHERE sv.id = cm.instance) 
                    WHEN 'url' THEN (SELECT url.name FROM mdl_url url WHERE url.id = cm.instance) 
                    WHEN 'wiki' THEN (SELECT wk.name FROM mdl_wiki wk WHERE wk.id = cm.instance) 
                    WHEN 'workshop' THEN (SELECT ws.name FROM mdl_workshop ws WHERE ws.id = cm.instance) 
                    ELSE CONCAT('Atividade desconhecida (ID: ', cm.instance, ')') 
                END 
                ORDER BY cm.instance ASC 
                SEPARATOR ', '
            ) 
            FROM mdl_course_modules cm 
            JOIN mdl_modules m ON cm.module = m.id 
            LEFT JOIN mdl_course_modules_completion cmc ON cmc.coursemoduleid = cm.id AND cmc.userid = u.id 
            WHERE cm.course = c.id AND cmc.completionstate = 1
        ), 'Nenhuma Atividade Concluida'
    ) AS "Atividades Concluidas", 
    CASE 
        WHEN cc.timecompleted IS NOT NULL AND cc.timecompleted > 0 THEN 'Concluido' 
        ELSE 'Nao Concluido' 
    END AS "Status de Conclusao do curso", 
    CASE 
        WHEN cc.timecompleted IS NOT NULL AND cc.timecompleted > 0 THEN FROM_UNIXTIME(cc.timecompleted, '%d-%m-%Y') 
        ELSE 'Nao Concluido' 
    END AS "Data de Conclusao do curso" 
FROM 
    mdl_user u 
JOIN mdl_user_enrolments ue ON u.id = ue.userid 
JOIN mdl_enrol e ON ue.enrolid = e.id 
JOIN mdl_course c ON e.courseid = c.id 
LEFT JOIN mdl_groups_members gm ON u.id = gm.userid 
LEFT JOIN mdl_groups g ON gm.groupid = g.id 
LEFT JOIN mdl_course_completions cc ON u.id = cc.userid AND c.id = cc.course 
WHERE 
    u.deleted = 0 
    AND c.visible = 1  -- Apenas cursos ativos 
    AND (cc.timecompleted IS NULL OR cc.timecompleted >= UNIX_TIMESTAMP('2023-01-01 00:00:00')) 
GROUP BY 
    u.id, c.id 
ORDER BY 
    "Atividades Concluidas" ASC;
