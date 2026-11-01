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
  papers: 'Clean' | 'Rebuilt' | 'Salvage' | 'Flood' | 'Lemon' | 'Junk' | 'Other' | 'Unknown',
  listing_price: string, // decimal in php is string
  status: 'Available' | 'Sold' | 'Pending',
  city: string,
  state: string,
  body_type: 'Sedan' | 'Hatchback' | 'Coupe' | 'Full-Size SUV' | 'Mid-Size SUV' | 'Compact SUV' | 'Pickup' | 'Heavy-Duty Pickup' | 'Commercial Truck' | 'Other' | 'Unknown',
  image_url: string | null,
  exterior_color: string,
  interior_color: string,
  fuel_type: 'Diesel' | 'Gas' | 'Hybrid' | 'EV' | 'Other' | 'Unknown',
  transmission: 'Manual' | 'Automatic' | 'Other' | 'Unknown',
  drivetrain: 'FWD' | 'RWD' | 'AWD' | '4WD' | 'Other' | 'Unknown',
  created_at: string
};

export async function getListings(): Promise<Listing[]> {
  const res = await fetch('/api/listings');
  return res.json();
}

export async function getListing(vin: string): Promise<Listing | null> {
  const res = await fetch(`/api/listings?vin=${encodeURIComponent(vin)}`);
  return res.json();
}