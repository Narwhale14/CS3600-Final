export interface Listing {
  vin: string,
  title: string,
  description: string | null,
  seller_id: number,
  make: string,
  model: string,
  year: number,
  mileage: number,
  owners: number,
  papers: typeof PAPERS[number],
  listing_price: string,
  status: typeof STATUSES[number],
  city: string,
  state: string,
  body_type: typeof BODY_TYPES[number],
  image_url: string | null,
  exterior_color: string,
  interior_color: string,
  fuel_type: typeof FUEL_TYPES[number],
  transmission: typeof TRANSMISSIONS[number],
  drivetrain: typeof DRIVETRAINS[number],
  created_at: string
};

export const PAPERS = ['Clean', 'Rebuilt', 'Salvage', 'Flood', 'Lemon', 'Junk', 'Other', 'Unknown'] as const;
export const STATUSES = ['Available', 'Sold', 'Pending'] as const;
export const BODY_TYPES = ['Sedan', 'Hatchback', 'Coupe', 'Full-Size SUV', 'Mid-Size SUV', 'Compact SUV', 'Pickup', 'Heavy-Duty Pickup', 'Commercial Truck', 'Other', 'Unknown'] as const;
export const FUEL_TYPES = ['Diesel', 'Gas', 'Hybrid', 'EV', 'Other', 'Unknown'] as const;
export const TRANSMISSIONS = ['Manual', 'Automatic', 'Other', 'Unknown'] as const;
export const DRIVETRAINS = ['FWD', 'RWD', 'AWD', '4WD', 'Other', 'Unknown'] as const;

export async function getListings(): Promise<Listing[]> {
  const res = await fetch('/api/listings');
  return res.json();
}

export async function getListing(vin: string): Promise<Listing | null> {
  const res = await fetch(`/api/listings?vin=${encodeURIComponent(vin)}`);
  return res.json();
}