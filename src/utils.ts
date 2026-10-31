export function formatNumber(value: number, decimals: number = 2): string {
	if(isNaN(value)) return '0';
	return new Intl.NumberFormat('en-US', { minimumFractionDigits: decimals, maximumFractionDigits: decimals }).format(value);
}
