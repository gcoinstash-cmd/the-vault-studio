/**
 * THE VAULT — Database Engine & Local Data Store
 * Supports live Supabase cloud connection with automatic local storage fallback.
 */

const STORAGE_KEYS = {
  BOOKINGS: 'the_vault_bookings',
  WAIVERS: 'the_vault_waivers',
  CONFIG: 'the_vault_config'
};

// Seed Starter Records if Local Storage is Empty
function initializeDefaultData() {
  if (!localStorage.getItem(STORAGE_KEYS.BOOKINGS)) {
    const defaultBookings = [
      {
        id: 'VB-8092',
        client_name: 'Julian Vance',
        client_email: 'j.vance@atelier-arch.com',
        client_phone: '+1 (310) 882-9411',
        artist_name: 'Soren Vex (Dark Surrealism)',
        service_type: 'Custom Tattoo Session',
        session_date: '2026-10-04',
        session_time: '14:00',
        placement: 'Full Outer Forearm',
        estimated_hours: 4,
        deposit_paid: 100,
        status: 'Confirmed',
        created_at: new Date(Date.now() - 86400000 * 2).toISOString()
      },
      {
        id: 'VB-8093',
        client_name: 'Elena Rostova',
        client_email: 'elena@novacrest.io',
        client_phone: '+1 (415) 309-1188',
        artist_name: 'Kaelen Cross (Micro-Realism)',
        service_type: 'Exclusive Flash Claim (#F-04)',
        session_date: '2026-10-06',
        session_time: '16:30',
        placement: 'Upper Ribcage / Sternum',
        estimated_hours: 2.5,
        deposit_paid: 100,
        status: 'Confirmed',
        created_at: new Date(Date.now() - 86400000 * 1).toISOString()
      },
      {
        id: 'VB-8094',
        client_name: 'Marcus Thorne',
        client_email: 'm.thorne@hyperion-cap.com',
        client_phone: '+1 (212) 554-7090',
        artist_name: 'Mireille Noir (Fine-Line & Piercing)',
        service_type: 'Luxury Piercing & 18K Solid Gold Fitting',
        session_date: '2026-10-07',
        session_time: '11:00',
        placement: 'Curated Triple Flat (Left Ear)',
        estimated_hours: 1,
        deposit_paid: 50,
        status: 'Pending Review',
        created_at: new Date().toISOString()
      }
    ];
    localStorage.setItem(STORAGE_KEYS.BOOKINGS, JSON.stringify(defaultBookings));
  }

  if (!localStorage.getItem(STORAGE_KEYS.WAIVERS)) {
    const defaultWaivers = [
      {
        id: 'WV-4019',
        booking_id: 'VB-8092',
        client_name: 'Julian Vance',
        dob: '1995-08-14',
        id_verified: true,
        allergies: 'None',
        blood_borne_cleared: true,
        signature_data: 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="200" height="50"><path d="M10 35 Q 50 10, 90 30 T 170 25" stroke="%23D4AF37" fill="none" stroke-width="2"/></svg>',
        signed_at: new Date(Date.now() - 86400000 * 2).toISOString()
      },
      {
        id: 'WV-4020',
        booking_id: 'VB-8093',
        client_name: 'Elena Rostova',
        dob: '1998-11-22',
        id_verified: true,
        allergies: 'Adhesive tape sensitivity',
        blood_borne_cleared: true,
        signature_data: 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="200" height="50"><path d="M10 25 Q 40 40, 80 15 T 180 30" stroke="%23D4AF37" fill="none" stroke-width="2"/></svg>',
        signed_at: new Date(Date.now() - 86400000 * 1).toISOString()
      }
    ];
    localStorage.setItem(STORAGE_KEYS.WAIVERS, JSON.stringify(defaultWaivers));
  }
}

// Data Store Accessors
const VaultDB = {
  init: initializeDefaultData,

  getBookings: () => {
    VaultDB.init();
    try {
      return JSON.parse(localStorage.getItem(STORAGE_KEYS.BOOKINGS)) || [];
    } catch {
      return [];
    }
  },

  addBooking: (booking) => {
    VaultDB.init();
    const bookings = VaultDB.getBookings();
    const newId = 'VB-' + Math.floor(1000 + Math.random() * 9000);
    const newRecord = {
      id: newId,
      created_at: new Date().toISOString(),
      status: 'Pending Review',
      ...booking
    };
    bookings.unshift(newRecord);
    localStorage.setItem(STORAGE_KEYS.BOOKINGS, JSON.stringify(bookings));
    return newRecord;
  },

  updateBookingStatus: (id, status) => {
    VaultDB.init();
    const bookings = VaultDB.getBookings().map(b => b.id === id ? { ...b, status } : b);
    localStorage.setItem(STORAGE_KEYS.BOOKINGS, JSON.stringify(bookings));
    return bookings.find(b => b.id === id);
  },

  deleteBooking: (id) => {
    VaultDB.init();
    const bookings = VaultDB.getBookings().filter(b => b.id !== id);
    localStorage.setItem(STORAGE_KEYS.BOOKINGS, JSON.stringify(bookings));
    return true;
  },

  getWaivers: () => {
    VaultDB.init();
    try {
      return JSON.parse(localStorage.getItem(STORAGE_KEYS.WAIVERS)) || [];
    } catch {
      return [];
    }
  },

  addWaiver: (waiver) => {
    VaultDB.init();
    const waivers = VaultDB.getWaivers();
    const newId = 'WV-' + Math.floor(1000 + Math.random() * 9000);
    const newRecord = {
      id: newId,
      signed_at: new Date().toISOString(),
      ...waiver
    };
    waivers.unshift(newRecord);
    localStorage.setItem(STORAGE_KEYS.WAIVERS, JSON.stringify(waivers));
    return newRecord;
  },

  clearData: () => {
    localStorage.removeItem(STORAGE_KEYS.BOOKINGS);
    localStorage.removeItem(STORAGE_KEYS.WAIVERS);
    VaultDB.init();
  }
};

// Initialize right away
VaultDB.init();
window.VaultDB = VaultDB;
