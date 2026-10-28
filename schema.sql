-- ====================================================================
-- Student Task and Assignment Tracker - Supabase / PostgreSQL Schema
-- ====================================================================

-- 1. Create tasks table
CREATE TABLE IF NOT EXISTS tasks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    category VARCHAR(50) NOT NULL DEFAULT 'Assignment' CHECK (category IN ('Assignment', 'Personal', 'Project', 'Exam Prep')),
    due_date TIMESTAMPTZ NOT NULL,
    priority VARCHAR(20) NOT NULL DEFAULT 'Medium' CHECK (priority IN ('Low', 'Medium', 'High', 'Urgent')),
    status VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'completed')),
    course_name VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 2. Indexes for fast filtering and sorting
CREATE INDEX IF NOT EXISTS idx_tasks_status ON tasks(status);
CREATE INDEX IF NOT EXISTS idx_tasks_due_date ON tasks(due_date);
CREATE INDEX IF NOT EXISTS idx_tasks_category ON tasks(category);

-- 3. Disable Row Level Security for smooth college project development
ALTER TABLE tasks DISABLE ROW LEVEL SECURITY;

-- 4. Trigger to update updated_at timestamp automatically
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = timezone('utc'::text, now());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_tasks_updated_at ON tasks;
CREATE TRIGGER trigger_tasks_updated_at
BEFORE UPDATE ON tasks
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- 4. Sample initial student data
INSERT INTO tasks (title, description, category, due_date, priority, status, course_name)
VALUES
    ('CS101: Data Structures Lab 3', 'Implement a balanced binary search tree in Python with unit tests.', 'Assignment', NOW() + INTERVAL '2 days', 'High', 'pending', 'CS101 - Computer Science'),
    ('Calculus II Problem Set 4', 'Complete exercises 14 through 28 on Integration by Parts.', 'Assignment', NOW() + INTERVAL '4 days', 'Medium', 'pending', 'MATH201 - Calculus II'),
    ('Buy textbook for Physics lab', 'Get University Physics 15th Edition from campus bookstore or library reserve.', 'Personal', NOW() + INTERVAL '1 day', 'Low', 'pending', 'Personal'),
    ('Prepare presentation slides for History term paper', 'Draft 10 slides on the Industrial Revolution and economic reform.', 'Project', NOW() + INTERVAL '6 days', 'High', 'pending', 'HIST110 - World History'),
    ('Review Chapter 1-3 Lecture Notes', 'Go over flashcards and past quiz questions for midterms.', 'Exam Prep', NOW() - INTERVAL '1 day', 'Urgent', 'completed', 'BIO105 - Biology')
ON CONFLICT DO NOTHING;
