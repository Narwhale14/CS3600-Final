export interface Listing {
  vin: string,
  title: string,
  description: string | null,
  make: string,
  model: string,
  year: number,
  mileage: number,
  listing_price: string, // decimal in php is string
  status: 'Available' | 'Sold' | 'Pending',
  city: string,
  state: string,
  body_type: string,
  image_url: string | null,
  exterior_color: string,
  interior_color: string,
  fuel_type: string,
  transmission: string,
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