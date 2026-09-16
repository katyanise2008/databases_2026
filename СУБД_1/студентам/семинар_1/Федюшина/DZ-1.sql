DROP TABLE IF EXISTS "Review" CASCADE;
DROP TABLE IF EXISTS "Enrollment" CASCADE;
DROP TABLE IF EXISTS "Lesson" CASCADE;
DROP TABLE IF EXISTS "Course" CASCADE;
DROP TABLE IF EXISTS "User" CASCADE;

CREATE TABLE "User" (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL,
    created_at TIMESTAMP NOT NULL
);


CREATE TABLE "Course" (
    course_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    instructor_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL,

    FOREIGN KEY (instructor_id)
        REFERENCES "User"(user_id)
);


CREATE TABLE "Lesson" (
    lesson_id SERIAL PRIMARY KEY,
    course INTEGER NOT NULL,
    title VARCHAR(200) NOT NULL,
    order_num INTEGER NOT NULL,
    duration_min INTEGER,

    FOREIGN KEY (course)
        REFERENCES "Course"(course_id)
);


CREATE TABLE "Enrollment" (
    enrollment_id SERIAL PRIMARY KEY,
    course_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    enrolled_at TIMESTAMP NOT NULL,
    completed_at TIMESTAMP,
    progress INTEGER NOT NULL,

    FOREIGN KEY (course_id)
        REFERENCES "Course"(course_id),

    FOREIGN KEY (user_id)
        references "User"(user_id)
);


CREATE TABLE "Review" (
    review_id SERIAL PRIMARY KEY,
    course_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    rating INTEGER NOT NULL,
    comment TEXT,
    created_at TIMESTAMP NOT NULL,

    FOREIGN KEY (course_id)
        REFERENCES "Course"(course_id),

    FOREIGN KEY (user_id)
        REFERENCES "User"(user_id)
);

