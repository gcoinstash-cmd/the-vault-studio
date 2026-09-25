# THE VAULT — 3-Minute Supabase Database Setup

Connect your production-grade Supabase PostgreSQL database to **THE VAULT** in 3 simple steps.

---

### Step 1: Create a Free Supabase Project (60 Seconds)
1. Go to [https://supabase.com](https://supabase.com) and click **"New Project"**.
2. Name your project (e.g. `the-vault-studio`) and choose a database password.

---

### Step 2: Run the SQL Schema & Seeds (60 Seconds)
1. In your Supabase dashboard, click on the **SQL Editor** tab on the left sidebar.
2. Click **"New Query"** and paste the entire contents of [`supabase/schema.sql`](./supabase/schema.sql).
3. Click **"Run"** (Ctrl+Enter / Cmd+Enter). This creates all 4 tables (`artists`, `flash_designs`, `appointments`, `waivers`) and applies Row-Level Security (RLS) policies.
4. *(Optional Starter Data)*: Open a new query, paste [`supabase/seed.sql`](./supabase/seed.sql), and click **"Run"** to load the resident artists and starter bookings.

---

### Step 3: Link Your Credentials (60 Seconds)
1. Navigate to **Project Settings > API**.
2. Copy your **Project URL** and **anon public API Key**.
3. In `assets/js/db.js`, populate your credentials:

```javascript
const SUPABASE_CONFIG = {
  url: 'https://YOUR_PROJECT_ID.supabase.co',
  anonKey: 'YOUR_ANON_PUBLIC_KEY'
};
```

---

### Protected Admin Portal
- **Path**: `/admin`
- **Default Demo Passcode**: `vault2026`
- **Features**: Real-time chamber radar, live client waiver signatures, deposit tracking, and 1-click CSV exports.
