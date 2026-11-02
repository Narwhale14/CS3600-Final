<script setup lang="ts">
import { reactive } from 'vue';
import { BODY_TYPES, PAPERS, FUEL_TYPES, TRANSMISSIONS, DRIVETRAINS, STATUSES } from './cars.ts';
import { formatNumber } from './utils.ts';

const dropdowns = [
  { label: 'Body Style', options: BODY_TYPES },
  { label: 'Fuel Type', options: FUEL_TYPES },
  { label: 'Transmission', options: TRANSMISSIONS },
  { label: 'Drivetrain', options: DRIVETRAINS },
  { label: 'Status', options: STATUSES },
  { label: 'Title', options: PAPERS },
];

interface Range { min: number, max: number, low: number, high: number };

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
  if(['-', '+', 'e', 'E', '.'].includes(event.key)) event.preventDefault();
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
        <input type="range" :min="price.min" :max="price.max" step="any" :value="price.low" @input="setLow(price, $event)" :class="{ 'on-top': lowOnTop(price) }">
        <input type="range" :min="price.min" :max="price.max" step="any" :value="price.high" @input="setHigh(price, $event)">
      </div>
    </div>

    <div class="slider">
      Year
      <div class="slider-values">
        <span>{{ year.low }}</span>
        <span>{{ year.high }}</span>
      </div>

      <div class="range-container">
        <input type="range" :min="year.min" :max="year.max" step="1" :value="year.low" @input="setLow(year, $event)" :class="{ 'on-top': lowOnTop(year) }">
        <input type="range" :min="year.min" :max="year.max" step="1" :value="year.high" @input="setHigh(year, $event)">
      </div>
    </div>

    <label>
      Make
      <input>
    </label>

    <label>
      Model
      <input>
    </label>

    <label>
      Max Milage
      <input type="number" min="0" @keydown="digitsOnly">
    </label>

    <label>
      Max Owners
      <input type="number" min="0" @keydown="digitsOnly">
    </label>

    <label v-for="d in dropdowns" :key="d.label">
      {{ d.label }}
      <select>
        <option>Any</option>
        <option v-for="option in d.options" :key="option">{{ option }}</option>
      </select>
    </label>

    <label>
      State
      <input maxlength="2">
    </label>

    <label>
      City
      <input>
    </label>

    <label>
      Exterior Color
      <input>
    </label>

    <label>
      Interior Color
      <input>
    </label>

    <button>Clear Filters</button>
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
  color: var(--beige)
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