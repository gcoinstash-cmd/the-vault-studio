-- ====================================================================
-- THE VAULT — PostgreSQL Database Schema & Row-Level Security (RLS)
-- Luxury Tattoo Atelier & Piercing Operating System
-- ====================================================================

-- Enable UUID extension
create extension if not exists "uuid-ossp";

-- 1. RESIDENT ARTISTS TABLE
create table if not exists public.artists (
  id uuid primary key default uuid_generate_v4(),
  name text not null,
  slug text unique not null,
  specialties text[] not null,
  hourly_rate numeric(10,2) not null,
  chamber_number text not null,
  bio text,
  image_url text,
  active boolean default true,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 2. DIGITAL FLASH DESIGNS TABLE
create table if not exists public.flash_designs (
  id uuid primary key default uuid_generate_v4(),
  code text unique not null,
  title text not null,
  artist_id uuid references public.artists(id) on delete set null,
  price numeric(10,2) not null,
  estimated_hours numeric(4,1) not null,
  image_url text not null,
  is_claimed boolean default false,
  claimed_at timestamp with time zone,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 3. CLIENT APPOINTMENTS & RESERVATIONS TABLE
create table if not exists public.appointments (
  id uuid primary key default uuid_generate_v4(),
  booking_code text unique not null,
  client_name text not null,
  client_email text not null,
  client_phone text not null,
  artist_id uuid references public.artists(id) on delete set null,
  artist_name text not null,
  service_type text not null,
  session_date date not null,
  session_time text not null,
  placement text not null,
  reference_image_url text,
  deposit_amount numeric(10,2) default 100.00 not null,
  deposit_paid boolean default true not null,
  status text default 'Pending Review' check (status in ('Pending Review', 'Confirmed', 'In Chair', 'Completed', 'Cancelled')),
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 4. DIGITAL LEGAL & MEDICAL WAIVERS TABLE
create table if not exists public.waivers (
  id uuid primary key default uuid_generate_v4(),
  certificate_code text unique not null,
  appointment_id uuid references public.appointments(id) on delete cascade,
  client_name text not null,
  date_of_birth date not null,
  allergies text default 'None Reported',
  blood_borne_cleared boolean default true not null,
  id_verified boolean default true not null,
  signature_base64 text not null,
  ip_address text,
  signed_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- ====================================================================
-- ROW-LEVEL SECURITY (RLS) POLICIES
-- ====================================================================

alter table public.artists enable row level security;
alter table public.flash_designs enable row level security;
alter table public.appointments enable row level security;
alter table public.waivers enable row level security;

-- Artists & Flash are public read-only
create policy "Artists are publicly viewable"
  on public.artists for select
  using (active = true);

create policy "Flash designs are publicly viewable"
  on public.flash_designs for select
  using (true);

-- Public can submit appointments and waivers
create policy "Public can submit appointment intake"
  on public.appointments for insert
  with check (true);

create policy "Public can submit legal waiver"
  on public.waivers for insert
  with check (true);

-- Service Role / Admin full control
create policy "Admin full access on artists"
  on public.artists for all
  using (auth.role() = 'service_role' or auth.jwt() ->> 'role' = 'admin');

create policy "Admin full access on flash"
  on public.flash_designs for all
  using (auth.role() = 'service_role' or auth.jwt() ->> 'role' = 'admin');

create policy "Admin full access on appointments"
  on public.appointments for all
  using (auth.role() = 'service_role' or auth.jwt() ->> 'role' = 'admin');

create policy "Admin full access on waivers"
  on public.waivers for all
  using (auth.role() = 'service_role' or auth.jwt() ->> 'role' = 'admin');
