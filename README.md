# 🎓 StudyTrack - Student Task & Assignment Tracker MVP

A clean, responsive, and student-focused task and assignment tracker built with **React**, **Node.js + Express**, and **Supabase / PostgreSQL**.

---

## ✨ Features Implemented

1. **Task CRUD (Create, Read, Update, Delete)**:
   - **Create**: Add assignments and personal tasks with title, course/subject, category, priority, due date & time, and notes.
   - **Read**: View tasks in a clean card layout with course tags, priority indicators, and relative due dates (*"Due in 2 days"*, *"Due Today"*, *"Overdue"*).
   - **Update**: Edit modal prefilled with current task details, including validation.
   - **Delete**: Protected delete with confirmation dialog to avoid losing homework items.
   - **Mark Complete**: Instant one-click toggle with visual strikethrough, badge updates, and completion percentage metric.

2. **Status Filters & Categories**:
   - Filter by status: **All**, **Pending / To-Do**, **Completed**.
   - Filter by category: **Assignment**, **Personal Task**, **Project**, **Exam Prep**.
   - Live search by title, subject/course, or keywords.
   - Sort by **Due Date (Earliest / Latest)**, **Priority (High to Low)**, or **Recently Added**.

3. **Validation & Helpful Error Handling**:
   - Title required (minimum 2 characters, maximum 255 characters).
   - Valid due date & time required.
   - Real-time inline form validation warnings.
   - Visual floating toast notifications for user actions (create, edit, complete, delete).
   - Server health check & error alert banner if backend is unreachable.

4. **Dual-Mode Database Architecture (Supabase / In-Memory Mock)**:
   - **Immediate Out-of-the-Box Operation**: Runs with preloaded student sample data without requiring any initial setup!
   - **Full Supabase / PostgreSQL Support**: Simply paste your Supabase Project URL and Key into `backend/.env` to switch to cloud PostgreSQL persistence.

---

## 📁 Project Structure

```text
student/
├── backend/
│   ├── src/
│   │   ├── db.js                 # Dual-mode Supabase client & In-Memory fallback store
│   │   ├── server.js             # Express app setup, CORS, JSON parser, routes
│   │   ├── routes/
│   │   │   └── taskRoutes.js     # RESTful CRUD endpoints (/api/tasks)
│   │   └── middleware/
│   │       ├── errorHandler.js   # Centralized error handler & 404 handler
│   │       └── validate.js       # Payload validation & descriptive error messages
│   ├── schema.sql                # Supabase / PostgreSQL table schema and starter seeds
│   ├── .env                      # Environment variables
│   ├── .env.example              # Example environment config
│   └── package.json              # Backend dependencies (@supabase/supabase-js, express, cors)
│
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   │   ├── Navbar.jsx             # Top bar with DB badge and "New Task" trigger
│   │   │   ├── StatsOverview.jsx      # Metric cards (Total, Pending, Completed, Overdue)
│   │   │   ├── FilterBar.jsx          # Live search, status tabs, category & sort controls
│   │   │   ├── TaskCard.jsx           # Individual assignment card with complete toggle
│   │   │   ├── TaskModal.jsx          # Create & Edit modal form with validation
│   │   │   ├── DeleteConfirmModal.jsx # Delete confirmation prompt
│   │   │   └── Toast.jsx              # Floating success/error notification banners
│   │   ├── api.js                     # Centralized API service & error parser
│   │   ├── App.jsx                    # Core state coordinator
│   │   ├── index.css                  # Modern student-focused CSS design system
│   │   └── main.jsx                   # React DOM entry
│   ├── vite.config.js                 # Vite config with /api proxy to port 5000
│   ├── index.html                     # HTML5 template
│   └── package.json                   # Frontend dependencies (React, Vite, Lucide-react)
│
├── start.bat                     # Windows one-click launcher
├── start.ps1                     # PowerShell one-click launcher
├── package.json                  # Root npm scripts
└── README.md
```

---

## 🚀 Quick Start Guide

### 1. Launching the App

You can start both backend and frontend using the provided launcher:

- **Windows Batch**: Double-click `start.bat`
- **PowerShell**: Run `./start.ps1`

Or run them in separate terminals:

#### Terminal 1: Backend (Express)
```bash
cd backend
npm start
```
*API will run at:* `http://localhost:5000`

#### Terminal 2: Frontend (React + Vite)
```bash
cd frontend
npm run dev
```
*App will run at:* `http://localhost:3000`

---

## 🗄️ Supabase / PostgreSQL Setup (Optional)

If you'd like to link to your live Supabase cloud database:

1. Open your [Supabase Dashboard](https://supabase.com).
2. Go to **SQL Editor** and run the contents of [`backend/schema.sql`](file:///c:/Users/Maddineni%20Lasya/OneDrive/Desktop/student/backend/schema.sql).
3. Copy your project URL and `anon` public key from **Project Settings > API**.
4. Paste them into [`backend/.env`](file:///c:/Users/Maddineni%20Lasya/OneDrive/Desktop/student/backend/.env):
   ```env
   PORT=5000
   SUPABASE_URL=https://xyzcompany.supabase.co
   SUPABASE_KEY=eyJh...
   ```
5. Restart the backend. The top bar in the React UI will automatically switch to **"Supabase Active"**!

---

## 🧪 API Endpoints

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/api/tasks` | Get all tasks (supports `?status=`, `?category=`, `?search=`, `?sortBy=`) |
| `GET` | `/api/tasks/:id` | Get single task details |
| `POST` | `/api/tasks` | Create a new task (validated) |
| `PUT` | `/api/tasks/:id` | Update an existing task |
| `PATCH` | `/api/tasks/:id/toggle-status` | Toggle task completion status |
| `DELETE` | `/api/tasks/:id` | Delete task |
| `GET` | `/api/tasks/stats/summary` | Get counts (total, pending, completed, overdue) |
| `GET` | `/api/health` | Health check & active database mode |
