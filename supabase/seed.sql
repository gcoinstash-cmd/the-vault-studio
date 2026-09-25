-- ====================================================================
-- THE VAULT — Starter Demo Data & Master Records
-- ====================================================================

-- Insert Resident Artists
insert into public.artists (name, slug, specialties, hourly_rate, chamber_number, bio, image_url) values
(
  'Soren Vex',
  'soren-vex',
  array['Dark Surrealism', 'Heavy Blackwork', 'Anatomy'],
  250.00,
  '01',
  'Trained in Berlin and Tokyo, Soren constructs expansive mythological and occult backpieces with architectural precision.',
  'https://images.unsplash.com/photo-1542385151-efd9000785a0?auto=format&fit=crop&w=800&q=80'
),
(
  'Kaelen Cross',
  'kaelen-cross',
  array['Single-Needle', 'Classical Micro-Realism', 'Statuary'],
  280.00,
  '02',
  'Kaelen utilizes 0.18mm custom single needles to recreate museum-grade Italian Renaissance masterworks and fine marble statues.',
  'https://images.unsplash.com/photo-1579783900882-c0d3dad7b119?auto=format&fit=crop&w=800&q=80'
),
(
  'Mireille Noir',
  'mireille-noir',
  array['Luxury Piercing', '18K Solid Gold', 'Botanical Ink'],
  200.00,
  '03',
  'Certified APP member with 9 years in bespoke ear curations. Specializing in high-end titanium and 18K solid gold needle piercings.',
  'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?auto=format&fit=crop&w=800&q=80'
),
(
  'Ryker Dane',
  'ryker-dane',
  array['Geometric Blackwork', 'Cyber-Sigilism', 'Dotwork'],
  220.00,
  '04',
  'Ryker combines computational algorithmic patterns with traditional ceremonial stippling to create flowing sacred geometry.',
  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=800&q=80'
);

-- Insert Sample Flash Archive Designs
insert into public.flash_designs (code, title, price, estimated_hours, image_url, is_claimed) values
(
  'VF-01',
  'Obsidian Dagger',
  350.00,
  2.5,
  'https://images.unsplash.com/photo-1562962230-16e4623d36e6?auto=format&fit=crop&w=600&q=80',
  false
),
(
  'VF-02',
  'Solar Eclipse Serpent',
  420.00,
  3.0,
  'https://images.unsplash.com/photo-1590246814883-57833737b587?auto=format&fit=crop&w=600&q=80',
  false
),
(
  'VF-03',
  'Gothic Rose Sigil',
  380.00,
  2.0,
  'https://images.unsplash.com/photo-1560707303-4e980ce876ad?auto=format&fit=crop&w=600&q=80',
  false
);

-- Insert Starter Appointments
insert into public.appointments (booking_code, client_name, client_email, client_phone, artist_name, service_type, session_date, session_time, placement, deposit_amount, deposit_paid, status) values
(
  'VB-8092',
  'Julian Vance',
  'j.vance@atelier-arch.com',
  '+1 (310) 882-9411',
  'Soren Vex (Dark Surrealism)',
  'Custom Bespoke Tattoo',
  current_date + interval '2 days',
  '14:00',
  'Full Outer Forearm',
  100.00,
  true,
  'Confirmed'
),
(
  'VB-8093',
  'Elena Rostova',
  'elena@novacrest.io',
  '+1 (415) 309-1188',
  'Kaelen Cross (Micro-Realism)',
  'Exclusive Flash Claim (#VF-02)',
  current_date + interval '4 days',
  '16:30',
  'Upper Ribcage',
  100.00,
  true,
  'Confirmed'
);
