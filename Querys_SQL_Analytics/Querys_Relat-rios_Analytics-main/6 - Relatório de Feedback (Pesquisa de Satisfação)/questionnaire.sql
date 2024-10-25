SELECT 
    CONCAT(mu.firstname, ' ', mu.lastname) AS Nome, 
    mc.shortname AS Curso, 
    mq.name AS Pesquisa, 
    mu.email AS Email, 
    g.name AS Turma, 

    -- Perfil
    (
        SELECT mqqc.content 
        FROM g4s7_questionnaire_resp_single mqrs
        JOIN g4s7_questionnaire_quest_choice mqqc ON mqqc.id = mqrs.choice_id
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrs.question_id
        WHERE mqq.type_id = 4 
          AND mqq.deleted = 'n'
          AND mqq.name = 'q1 perfil'
          AND mqrs.response_id = mqr.id
    ) AS "1_Perfil",

    -- Nome da instituição
    (
        SELECT mqrt.response 
        FROM g4s7_questionnaire_response_text mqrt
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrt.question_id
        WHERE mqq.type_id = 2 
          AND mqq.deleted = 'n'
          AND mqq.name = 'q2 Nome da instituição'
          AND mqrt.response_id = mqr.id
    ) AS "2_Nome_da_instituição",

    -- Formatos dos objetos educacionais
    (
        SELECT mqqc.content 
        FROM g4s7_questionnaire_resp_single mqrs
        JOIN g4s7_questionnaire_quest_choice mqqc ON mqqc.id = mqrs.choice_id
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrs.question_id
        WHERE mqq.type_id = 4 
          AND mqq.deleted = 'n'
          AND mqq.name = 'Os formatos dos objetos educac'
          AND mqrs.response_id = mqr.id
    ) AS "3_Formatos_dos_objetos_educacionais",

    -- Qualidade do conteúdo
    (
        SELECT mqqc.content 
        FROM g4s7_questionnaire_resp_single mqrs
        JOIN g4s7_questionnaire_quest_choice mqqc ON mqqc.id = mqrs.choice_id
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrs.question_id
        WHERE mqq.type_id = 4 
          AND mqq.deleted = 'n'
          AND mqq.name = 'A qualidade do conteúdo dos ma'
          AND mqrs.response_id = mqr.id
    ) AS "4_Qualidade_do_conteúdo",

    -- Comentários sobre os recursos didáticos
    (
        SELECT mqrt.response 
        FROM g4s7_questionnaire_response_text mqrt
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrt.question_id
        WHERE mqq.type_id = 3 
          AND mqq.deleted = 'n'
          AND mqq.name = 'Comentários sobre os recursos'
          AND mqrt.response_id = mqr.id
    ) AS "5_Comentários_sobre_os_recursos_didático_pedagógicos",

    -- Avaliações do tutor
    (
        SELECT mqqc.content 
        FROM g4s7_questionnaire_resp_single mqrs
        JOIN g4s7_questionnaire_quest_choice mqqc ON mqqc.id = mqrs.choice_id
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrs.question_id
        WHERE mqq.type_id = 4 
          AND mqq.deleted = 'n'
          AND mqq.name = 'O tutor apresentou o conteúdo'
          AND mqrs.response_id = mqr.id
    ) AS "6_O_tutor_apresentou_o_conteúdo_de_forma_segura?",

        -- Frequência do tutor
    (
        SELECT mqqc.content 
        FROM g4s7_questionnaire_resp_single mqrs
        JOIN g4s7_questionnaire_quest_choice mqqc ON mqqc.id = mqrs.choice_id
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrs.question_id
        WHERE mqq.type_id = 4 
          AND mqq.deleted = 'n'
          AND mqq.name = 'A frequência do tutor na plata'
          AND mqrs.response_id = mqr.id
    ) AS "7_A_frequência_do_tutor_foi_suficiente?",

    -- Capacidade de motivar
    (
        SELECT mqqc.content 
        FROM g4s7_questionnaire_resp_single mqrs
        JOIN g4s7_questionnaire_quest_choice mqqc ON mqqc.id = mqrs.choice_id
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrs.question_id
        WHERE mqq.type_id = 4 
          AND mqq.deleted = 'n'
          AND mqq.name = 'Demostrou capacidade de motiva'
          AND mqrs.response_id = mqr.id
    ) AS "8_Demonstrou_capacidade_de_motivar_o_interesse?",

    -- Feedback e esclarecimento de dúvidas
    (
        SELECT mqqc.content 
        FROM g4s7_questionnaire_resp_single mqrs
        JOIN g4s7_questionnaire_quest_choice mqqc ON mqqc.id = mqrs.choice_id
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrs.question_id
        WHERE mqq.type_id = 4 
          AND mqq.deleted = 'n'
          AND mqq.name = 'Apresentou feedback e esclarec'
          AND mqrs.response_id = mqr.id
    ) AS "9_Apresentou_feedback_e_esclareceu_dúvidas?",

    -- Postura ético-profissional
    (
        SELECT mqqc.content 
        FROM g4s7_questionnaire_resp_single mqrs
        JOIN g4s7_questionnaire_quest_choice mqqc ON mqqc.id = mqrs.choice_id
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrs.question_id
        WHERE mqq.type_id = 4 
          AND mqq.deleted = 'n'
          AND mqq.name = 'Demonstrou postura ético-profi'
          AND mqrs.response_id = mqr.id
    ) AS "10_Demonstrou_postura_ético_profissional?",

    -- Comentários sobre o instrutor
    (
        SELECT mqrt.response 
        FROM g4s7_questionnaire_response_text mqrt
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrt.question_id
        WHERE mqq.type_id = 3 
          AND mqq.deleted = 'n'
          AND mqq.name = 'Comentários sobre o instrutor:'
          AND mqrt.response_id = mqr.id
    ) AS "11_Comentários_sobre_o_instrutor",

    -- Carga horária adequada
    (
        SELECT mqqc.content 
        FROM g4s7_questionnaire_resp_single mqrs
        JOIN g4s7_questionnaire_quest_choice mqqc ON mqqc.id = mqrs.choice_id
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrs.question_id
        WHERE mqq.type_id = 4 
          AND mqq.deleted = 'n'
          AND mqq.name = 'A carga horária do curso foi a'
          AND mqrs.response_id = mqr.id
    ) AS "12_A_carga_horária_foi_adequada?",

    -- Formato do curso atendeu expectativas
    (
        SELECT mqqc.content 
        FROM g4s7_questionnaire_resp_single mqrs
        JOIN g4s7_questionnaire_quest_choice mqqc ON mqqc.id = mqrs.choice_id
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrs.question_id
        WHERE mqq.type_id = 4 
          AND mqq.deleted = 'n'
          AND mqq.name = 'O formato do curso atendeu às'
          AND mqrs.response_id = mqr.id
    ) AS "13_O_formato_do_curso_atendeu_suas_expectativas?",

    -- Formas de avaliação foram adequadas
    (
        SELECT mqqc.content 
        FROM g4s7_questionnaire_resp_single mqrs
        JOIN g4s7_questionnaire_quest_choice mqqc ON mqqc.id = mqrs.choice_id
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrs.question_id
        WHERE mqq.type_id = 4 
          AND mqq.deleted = 'n'
          AND mqq.name = 'As formas de avaliação (lições'
          AND mqrs.response_id = mqr.id
    ) AS "14_As_formas_de_avaliação_foram_adequadas?",

    -- Comentários sobre o curso
    (
        SELECT mqrt.response 
        FROM g4s7_questionnaire_response_text mqrt
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrt.question_id
        WHERE mqq.type_id = 3 
          AND mqq.deleted = 'n'
          AND mqq.name = 'Comentários sobre o curso:'
          AND mqrt.response_id = mqr.id
    ) AS "15_Comentários_sobre_o_curso",

    -- Usabilidade da plataforma
    (
        SELECT mqqc.content 
        FROM g4s7_questionnaire_resp_single mqrs
        JOIN g4s7_questionnaire_quest_choice mqqc ON mqqc.id = mqrs.choice_id
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrs.question_id
        WHERE mqq.type_id = 4 
          AND mqq.deleted = 'n'
          AND mqq.name = 'Como avalia a usabilidade da p'
          AND mqrs.response_id = mqr.id
    ) AS "16_Como_avalia_a_usabilidade_da_plataforma?",

    -- Avaliação do visual da plataforma
    (
        SELECT mqqc.content 
        FROM g4s7_questionnaire_resp_single mqrs
        JOIN g4s7_questionnaire_quest_choice mqqc ON mqqc.id = mqrs.choice_id
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrs.question_id
        WHERE mqq.type_id = 4 
          AND mqq.deleted = 'n'
          AND mqq.name = 'Avalie o visual da plataforma.'
          AND mqrs.response_id = mqr.id
    ) AS "17_Como_avalia_o_visual_da_plataforma?",

    -- Avaliação do suporte técnico
    (
        SELECT mqqc.content 
        FROM g4s7_questionnaire_resp_single mqrs
        JOIN g4s7_questionnaire_quest_choice mqqc ON mqqc.id = mqrs.choice_id
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrs.question_id
        WHERE mqq.type_id = 4 
          AND mqq.deleted = 'n'
          AND mqq.name = 'Indique o nível de satisfação'
          AND mqrs.response_id = mqr.id
    ) AS "18_Avaliação_do_suporte_técnico",

    -- Avaliação dos encontros online
    (
        SELECT mqqc.content 
        FROM g4s7_questionnaire_resp_single mqrs
        JOIN g4s7_questionnaire_quest_choice mqqc ON mqqc.id = mqrs.choice_id
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrs.question_id
        WHERE mqq.type_id = 4 
          AND mqq.deleted = 'n'
          AND mqq.name = 'Encontro online'
          AND mqrs.response_id = mqr.id
    ) AS "19_Avaliação_dos_encontros_online",

    -- Comentários sobre a plataforma e recursos
    (
        SELECT mqrt.response 
        FROM g4s7_questionnaire_response_text mqrt
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrt.question_id
        WHERE mqq.type_id = 3 
          AND mqq.deleted = 'n'
          AND mqq.name = 'Comentários sobre a interface:'
          AND mqrt.response_id = mqr.id
    ) AS "20_Comentários_sobre_plataforma_e_recursos",

    -- Conhecimentos úteis no trabalho
    (
        SELECT mqqc.content 
        FROM g4s7_questionnaire_resp_single mqrs
        JOIN g4s7_questionnaire_quest_choice mqqc ON mqqc.id = mqrs.choice_id
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrs.question_id
        WHERE mqq.type_id = 4 
          AND mqq.deleted = 'n'
          AND mqq.name = 'Os conhecimentos serão úteis n'
          AND mqrs.response_id = mqr.id
    ) AS "21_Conhecimentos_serão_úteis_no_trabalho?",

    -- Nível de satisfação geral
    (
        SELECT mqqc.content 
        FROM g4s7_questionnaire_resp_single mqrs
        JOIN g4s7_questionnaire_quest_choice mqqc ON mqqc.id = mqrs.choice_id
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrs.question_id
        WHERE mqq.type_id = 4 
          AND mqq.deleted = 'n'
          AND mqq.name = 'Seu nível de satisfação geral'
          AND mqrs.response_id = mqr.id
    ) AS "22_Nível_de_satisfação_geral",

    -- Probabilidade de indicar o curso
    (
        SELECT mqqc.content 
        FROM g4s7_questionnaire_resp_single mqrs
        JOIN g4s7_questionnaire_quest_choice mqqc ON mqqc.id = mqrs.choice_id
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrs.question_id
        WHERE mqq.type_id = 4 
          AND mqq.deleted = 'n'
          AND mqq.name = 'Qual a probabilidade de você in'
          AND mqrs.response_id = mqr.id
    ) AS "23_Probabilidade_de_indicar_o_curso",

    -- Espaço para comentários adicionais
    (
        SELECT mqrt.response 
        FROM g4s7_questionnaire_response_text mqrt
        JOIN g4s7_questionnaire_question mqq ON mqq.id = mqrt.question_id
        WHERE mqq.type_id = 3 
          AND mqq.deleted = 'n'
          AND mqq.name = 'Espaço para comentários:'
          AND mqrt.response_id = mqr.id
    ) AS "24_Espaço_para_comentários"


FROM 
    g4s7_course mc
JOIN 
    g4s7_enrol me ON me.courseid = mc.id
JOIN 
    g4s7_context ctx ON mc.id = ctx.instanceid
JOIN 
    g4s7_role_assignments AS ra ON ra.contextid = ctx.id
JOIN 
    g4s7_user AS mu ON mu.id = ra.userid
JOIN 
    g4s7_user_enrolments mue ON mue.userid = mu.id AND mue.enrolid = me.id
JOIN 
    g4s7_questionnaire mq ON mq.course = mc.id
JOIN 
    g4s7_questionnaire_response mqr ON mqr.questionnaireid = mq.id AND mqr.userid = mu.id
LEFT JOIN 
    g4s7_groups_members gm ON gm.userid = mu.id
LEFT JOIN 
    g4s7_groups g ON g.id = gm.groupid

WHERE 
    ra.roleid = 5 
    AND me.enrol = 'manual' 
    AND mue.status = 0 
    AND mqr.complete = 'y';
