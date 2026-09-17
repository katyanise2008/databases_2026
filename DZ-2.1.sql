DROP TABLE IF EXISTS "CoursePrerequisite" CASCADE;
DROP TABLE IF EXISTS "LearningPath" CASCADE;
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
    created_at TIMESTAMP NOT NULL,
    CHECK (role IN ('student', 'instructor', 'admin'))
);


CREATE TABLE "Course" (
    course_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    instructor_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL,
    FOREIGN KEY (instructor_id)
        REFERENCES "User"(user_id),
    CHECK (price >= 0)
);


CREATE TABLE "Lesson" (
    lesson_id SERIAL PRIMARY KEY,
    course_id INTEGER NOT NULL,
    title VARCHAR(200) NOT NULL,
    order_num INTEGER NOT NULL,
    duration_min INTEGER,
    FOREIGN KEY (course_id)
        REFERENCES "Course"(course_id),
    CHECK (order_num > 0),
    CHECK (duration_min IS NULL OR duration_min > 0)
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
        REFERENCES "User"(user_id),
    CHECK (progress BETWEEN 0 AND 100),
    UNIQUE (course_id, user_id)
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
        REFERENCES "User"(user_id),
    CHECK (rating BETWEEN 1 AND 5),
    UNIQUE (course_id, user_id)
);

CREATE TABLE "LearningPath" (
    path_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    difficulty VARCHAR(20) NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)
        REFERENCES "User"(user_id)
        ON DELETE CASCADE,
    CHECK (difficulty IN ('beginner', 'intermediate', 'advanced')),
    CHECK (status IN ('active', 'completed', 'paused'))
);

CREATE TABLE "CoursePrerequisite" (
    course_id INTEGER NOT NULL,
    prerequisite_course_id INTEGER NOT NULL,
    CHECK (course_id <> prerequisite_course_id),
    PRIMARY KEY (course_id, prerequisite_course_id),
    FOREIGN KEY (course_id)
        REFERENCES "Course"(course_id)
        ON DELETE CASCADE,
    FOREIGN KEY (prerequisite_course_id)
        REFERENCES "Course"(course_id)
        ON DELETE CASCADE
);


CREATE INDEX idx_learningpath_user
ON "LearningPath"(user_id);

CREATE INDEX idx_courseprerequisite_prerequisite
ON "CoursePrerequisite"(prerequisite_course_id);

CREATE INDEX idx_course_instructor
ON "Course"(instructor_id);

CREATE INDEX idx_lesson_course
ON "Lesson"(course_id);

CREATE INDEX idx_enrollment_course
ON "Enrollment"(course_id);

CREATE INDEX idx_enrollment_user
ON "Enrollment"(user_id);

CREATE INDEX idx_review_course
ON "Review"(course_id);

CREATE INDEX idx_review_user
ON "Review"(user_id);
