<script setup lang="ts">
import { BODY_TYPES, PAPERS, FUEL_TYPES, TRANSMISSIONS, DRIVETRAINS, STATUSES } from './cars.ts';

const dropdowns = [
  { label: 'Body Style', options: BODY_TYPES },
  { label: 'Title', options: PAPERS },
  { label: 'Fuel Type', options: FUEL_TYPES },
  { label: 'Transmission', options: TRANSMISSIONS },
  { label: 'Drivetrain', options: DRIVETRAINS },
  { label: 'Status', options: STATUSES }
];
</script>

<template>
  <div class="sidebar">
    <fieldset>
      <legend>Price</legend>
      <input type="number" placeholder="Min">
      <input type="number" placeholder="Max">
    </fieldset>

    <fieldset>
      <legend>Year</legend>
      <input type="number" placeholder="Min">
      <input type="number" placeholder="Max">
    </fieldset>

    <label>
      Max Milage
      <input type="number">
    </label>

    <label>
      Max Owners
      <input type="number">
    </label>

    <label>
      Make
      <input>
    </label>

    <label>
      Model
      <input>
    </label>

    <label>
      State
      <input maxlength="2">
    </label>

    <label>
      Exterior Color
      <input>
    </label>

    <label>
      Interior Color
      <input>
    </label>

    <label v-for="d in dropdowns" :key="d.label">
      {{ d.label }}
      <select>
        <option>Any</option>
        <option v-for="option in d.options" :key="option">{{ option }}</option>
      </select>
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
  gap: 1rem;
  padding: 1rem;
  box-sizing: border-box;
  overflow-y: auto;
}

.sidebar input, .sidebar select {
  width: 100%;
  box-sizing: border-box;
}

.sidebar fieldset {
  min-width: 0;
}
</style>