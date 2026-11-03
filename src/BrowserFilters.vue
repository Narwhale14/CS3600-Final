<script setup lang="ts">
import { reactive, watch } from 'vue';
import {
  BODY_TYPES, PAPERS, FUEL_TYPES,
  TRANSMISSIONS, DRIVETRAINS, STATUSES,
  type CarFilters
} from './cars.ts';
import { formatNumber } from './utils.ts';

const filters = defineModel<CarFilters>({ required: true });

const dropdowns = [
  { label: 'Body Style', key: 'bodyType', options: BODY_TYPES },
  { label: 'Fuel Type', key: 'fuelType', options: FUEL_TYPES },
  { label: 'Transmission', key: 'transmission', options: TRANSMISSIONS },
  { label: 'Drivetrain', key: 'drivetrain', options: DRIVETRAINS },
  { label: 'Status', key: 'status', options: STATUSES },
  { label: 'Title', key: 'papers', options: PAPERS }
] as const;

interface Range {
  min: number;
  max: number;
  low: number;
  high: number;
}

function range(min: number, max: number): Range {
  return reactive({ min, max, low: min, high: max });
}

const price = range(Math.log10(1000), Math.log10(5000000));
const year = range(1960, new Date().getFullYear());

function toPrice(exponent: number) {
  return Number((10 ** exponent).toPrecision(2));
}

function setLow(range: Range, event: Event) {
  const input = event.target as HTMLInputElement;
  range.low = Math.min(Number(input.value), range.high);
  input.value = String(range.low);
}

function setHigh(range: Range, event: Event) {
  const input = event.target as HTMLInputElement;
  range.high = Math.max(Number(input.value), range.low);
  input.value = String(range.high);
}

function lowOnTop(range: Range) {
  return range.low > (range.min + range.max) / 2;
}

function digitsOnly(event: KeyboardEvent) {
  if (['-', '+', 'e', 'E', '.'].includes(event.key)) {
    event.preventDefault();
  }
}

// Update filter state whenever sliders move.
watch(
  [
    () => price.low,
    () => price.high,
    () => year.low,
    () => year.high
  ],
  () => {
    filters.value = {
      ...filters.value,
      minPrice: price.low === price.min
        ? undefined : toPrice(price.low),
      maxPrice: price.high === price.max
        ? undefined : toPrice(price.high),
      minYear: year.low === year.min
        ? undefined : year.low,
      maxYear: year.high === year.max
        ? undefined : year.high
    };
  }
);

function clearFilters() {
  price.low = price.min;
  price.high = price.max;
  year.low = year.min;
  year.high = year.max;
  filters.value = {};
}
</script>

<template>
  <div class="sidebar">
    <span class="sidebar-title">Filters</span>

    <div class="slider">
      Price
      <div class="slider-values">
        <span>${{ formatNumber(toPrice(price.low), 0) }}</span>
        <span>${{ formatNumber(toPrice(price.high), 0) }}</span>
      </div>
      <div class="range-container">
        <input
          type="range"
          :min="price.min"
          :max="price.max"
          step="any"
          :value="price.low"
          @input="setLow(price, $event)"
          :class="{ 'on-top': lowOnTop(price) }"
        >
        <input
          type="range"
          :min="price.min"
          :max="price.max"
          step="any"
          :value="price.high"
          @input="setHigh(price, $event)"
        >
      </div>
    </div>

    <div class="slider">
      Year
      <div class="slider-values">
        <span>{{ year.low }}</span>
        <span>{{ year.high }}</span>
      </div>
      <div class="range-container">
        <input
          type="range"
          :min="year.min"
          :max="year.max"
          step="1"
          :value="year.low"
          @input="setLow(year, $event)"
          :class="{ 'on-top': lowOnTop(year) }"
        >
        <input
          type="range"
          :min="year.min"
          :max="year.max"
          step="1"
          :value="year.high"
          @input="setHigh(year, $event)"
        >
      </div>
    </div>

    <label>
      Make
      <input v-model="filters.make">
    </label>

    <label>
      Model
      <input v-model="filters.model">
    </label>

    <label>
      Max Mileage
      <input
        v-model="filters.maxMileage"
        type="number"
        min="0"
        @keydown="digitsOnly"
      >
    </label>

    <label>
      Max Owners
      <input
        v-model="filters.maxOwners"
        type="number"
        min="0"
        @keydown="digitsOnly"
      >
    </label>

    <label v-for="d in dropdowns" :key="d.key">
      {{ d.label }}
      <select v-model="filters[d.key]">
        <option value="">Any</option>
        <option
          v-for="option in d.options"
          :key="option"
          :value="option"
        >
          {{ option }}
        </option>
      </select>
    </label>

    <label>
      State
      <input v-model="filters.state" maxlength="2">
    </label>

    <label>
      City
      <input v-model="filters.city">
    </label>

    <label>
      Exterior Color
      <input v-model="filters.exteriorColor">
    </label>

    <label>
      Interior Color
      <input v-model="filters.interiorColor">
    </label>

    <button @click="clearFilters">Clear Filters</button>
  </div>
</template>

<style scoped>
.sidebar {
  display: flex;
  flex-direction: column;
  position: fixed;
  top: 6.5rem;
  bottom: 0;
  left: 0;
  width: var(--logo-width);
  background-color: var(--gray);
  color: var(--beige);
  gap: 1rem;
  padding: 0 1rem 1rem 1rem;
  box-sizing: border-box;
  overflow-y: auto;
  color-scheme: dark;
}

.sidebar input:not([type="range"]), .sidebar select {
  width: 100%;
  box-sizing: border-box;
  background-color: var(--gray);
  border: 2px solid var(--beige);
  border-radius: 2px;
  color: var(--beige);
}

.sidebar fieldset {
  min-width: 0;
  outline: 0;
  border: 0;
  padding: 0;
}

.slider-values {
  display: flex;
  justify-content: space-between;
}

.range-container {
  position: relative;
  height: 1rem;
}

.range-container::before {
  content: '';
  position: absolute;
  left: 0;
  right: 0;
  top: calc(50% - 1px);
  height: 2px;
  background: var(--beige);
}

.range-container input {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  margin: 0;
  appearance: none;
  background: none;
  pointer-events: none;
}

.range-container input::-webkit-slider-thumb {
  appearance: none;
  pointer-events: auto;
  width: 1rem;
  height: 1rem;
  border-radius: 50%;
  background: var(--beige);
}

.range-container input::-moz-range-thumb {
  pointer-events: auto;
  width: 1rem;
  height: 1rem;
  border: none;
  border-radius: 50%;
  background: var(--beige);
}

.range-container .on-top {
  z-index: 1;
}

.sidebar-title {
  font-size: 2rem;
  margin-top: 0;
}
</style>
