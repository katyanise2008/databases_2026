DO $$
BEGIN
    INSERT INTO "Course"
        (title, description, price, instructor_id, created_at)
    VALUES
        ('Курс с неправильной ценой',
         'Демонстрация нарушения CHECK',
         -100.00,
         1,
         CURRENT_TIMESTAMP);

EXCEPTION
    WHEN others THEN
        RAISE NOTICE
            'Ошибка: цена курса не может быть отрицательной. Курс должен иметь цену 0 или выше. Текст ошибки СУБД: %',
            SQLERRM;
END;
$$;


DO $$
BEGIN
    INSERT INTO "Course"
        (title, description, price, instructor_id, created_at)
    VALUES
        ('Курс с несуществующим преподавателем',
         'Демонстрация нарушения FOREIGN KEY',
         1000.00,
         999999,
         CURRENT_TIMESTAMP);

EXCEPTION
    WHEN others THEN
        RAISE NOTICE
            'Ошибка: нельзя создать курс, если указанный преподаватель не существует в системе. Текст ошибки СУБД: %',
            SQLERRM;
END;
$$;


DO $$
BEGIN
    INSERT INTO "User"
        (email, full_name, role, created_at)
    VALUES
        ('katyanise789@gmail.com',
         'Первый пользователь',
         'student',
         CURRENT_TIMESTAMP);

    INSERT INTO "User"
        (email, full_name, role, created_at)
    VALUES
        ('katyanise789@gmail.com',
         'Второй пользователь',
         'student',
         CURRENT_TIMESTAMP);

EXCEPTION
    WHEN others THEN
        RAISE NOTICE
            'Ошибка: пользователь с таким email уже существует. Один email может принадлежать только одному пользователю. Текст ошибки СУБД: %',
            SQLERRM;
END;
$$;


DO $$
BEGIN
    INSERT INTO "User"
        (email, full_name, role, created_at)
    VALUES
        ('kate@gmail.com',
         NULL,
         'student',
         CURRENT_TIMESTAMP);

EXCEPTION
    WHEN others THEN
        RAISE NOTICE
            'Ошибка: невозможно создать пользователя без указания имени. Имя пользователя является обязательным полем. Текст ошибки СУБД: %',
            SQLERRM;
END;
$$;


DO $$
BEGIN
    INSERT INTO "Course"
        (course_id, title, description, price, instructor_id, created_at)
    VALUES
        (1,
         'Курс с повторяющимся ID',
         'Демонстрация нарушения PRIMARY KEY',
         500.00,
         1,
         CURRENT_TIMESTAMP);

EXCEPTION
    WHEN others THEN
        RAISE NOTICE
            'Ошибка: невозможно создать курс с уже существующим идентификатором. ID курса должен быть уникальным. Текст ошибки СУБД: %',
            SQLERRM;
END;
$$;