export interface Cars {
  vin: string;
  title: string;
  description: string | null;
  seller_id: number;
  make: string;
  model: string;
  year: number;
  mileage: number;
  owners: number;
  papers: typeof PAPERS[number];
  listing_price: string;
  status: typeof STATUSES[number];
  city: string;
  state: string;
  body_type: typeof BODY_TYPES[number];
  image_url: string | null;
  exterior_color: string;
  interior_color: string;
  fuel_type: typeof FUEL_TYPES[number];
  transmission: typeof TRANSMISSIONS[number];
  drivetrain: typeof DRIVETRAINS[number];
  created_at: string;
}

export const PAPERS = ['Clean', 'Rebuilt', 'Salvage', 'Flood', 'Lemon', 'Junk', 'Other', 'Unknown'] as const;
export const STATUSES = ['Available', 'Sold', 'Pending'] as const;
export const BODY_TYPES = ['Sedan', 'Hatchback', 'Coupe', 'Full-Size SUV', 'Mid-Size SUV', 'Compact SUV', 'Pickup', 'Heavy-Duty Pickup', 'Commercial Truck', 'Other', 'Unknown'] as const;
export const FUEL_TYPES = ['Diesel', 'Gas', 'Hybrid', 'EV', 'Other', 'Unknown'] as const;
export const TRANSMISSIONS = ['Manual', 'Automatic', 'Other', 'Unknown'] as const;
export const DRIVETRAINS = ['FWD', 'RWD', 'AWD', '4WD', 'Other', 'Unknown'] as const;

export interface CarFilters {
  minPrice?: number;
  maxPrice?: number;
  minYear?: number;
  maxYear?: number;
  make?: string;
  model?: string;
  maxMileage?: string;
  maxOwners?: string;
  bodyType?: string;
  fuelType?: string;
  transmission?: string;
  drivetrain?: string;
  status?: string;
  papers?: string;
  state?: string;
  city?: string;
  exteriorColor?: string;
  interiorColor?: string;
}

export interface CarRelaxation {
  requested: string;
  level: 'siblings' | 'root';
  shownTypes: string[];
}

export interface CarSearchResult {
  cars: Cars[];
  relaxation: CarRelaxation | null;
}

export async function getCars(
  filters: CarFilters = {},
  signal?: AbortSignal
): Promise<CarSearchResult> {
  const params = new URLSearchParams();

  for (const [key, value] of Object.entries(filters)) {
    if (value !== undefined && value !== null && value !== '') {
      params.set(key, String(value));
    }
  }

  const query = params.toString();
  const url = query ? `/api/cars?${query}` : '/api/cars';

  const res = await fetch(url, { signal });

  if (!res.ok) {
    throw new Error(`Failed to fetch cars: ${res.status}`);
  }

  return res.json();
}

export async function getCar(vin: string): Promise<Cars | null> {
  const res = await fetch(
    `/api/cars?vin=${encodeURIComponent(vin)}`
  );

  if (!res.ok) {
    throw new Error(`Failed to fetch car: ${res.status}`);
  }

  return res.json();
}
