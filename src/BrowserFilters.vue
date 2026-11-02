<script setup lang="ts">
import { BODY_TYPES, PAPERS, FUEL_TYPES, TRANSMISSIONS, DRIVETRAINS, STATUSES } from './cars.ts';

const dropdowns = [
  { label: 'Body Style', options: BODY_TYPES },
  { label: 'Fuel Type', options: FUEL_TYPES },
  { label: 'Transmission', options: TRANSMISSIONS },
  { label: 'Drivetrain', options: DRIVETRAINS },
  { label: 'Status', options: STATUSES },
  { label: 'Title', options: PAPERS },
];
</script>

<template>
  <div class="sidebar">
    <div class="slider">
      <div class="slider-values">
        <span id="price-min-val">$5,000</span>
        <span id="price-max-val">$50,000</span>
      </div>

      <div class="range-container">
        <input type="range" id="price-min" min="0" max="1000000" value="5000" step="100">
        <input type="range" id="price-max" min="0" max="1000000" value="50000" step="100">
      </div>
    </div>

    <div class="slider">
      <div class="slider-values">
        <span id="year-min-val">1950</span>
        <span id="year-max-val">2026</span>
      </div>

      <div class="range-container">
        <input type="range" id="year-min" min="1960" max="2026" value="2005" step="1">
        <input type="range" id="year-max" min="1960" max="2026" value="2026" step="1">
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
      <input type="number">
    </label>

    <label>
      Max Owners
      <input type="number">
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
  padding: 1rem;
  box-sizing: border-box;
  overflow-y: auto;
}

.sidebar input, .sidebar select {
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
</style>