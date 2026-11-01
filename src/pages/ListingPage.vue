<script setup lang="ts">
import { computed, ref, watch } from 'vue';
import { useRoute } from 'vue-router';
import { getListing, type Listing } from '../listings';
import { formatNumber } from '../utils';

const route = useRoute();
const listing = ref<Listing | null>(null);

watch(() => route.params.id, async (vin) => {
  listing.value = await getListing(String(vin));
}, { immediate: true });

const listedDate = computed(() => {
  if(!listing.value) return ''
  return new Date(listing.value.created_at.replace(' ', 'T')).toLocaleDateString('en-US', { month: '2-digit', day: '2-digit', year: '2-digit' })
})

const listedMiles = computed(() => {
  if(!listing.value) return 0;
  return new Intl.NumberFormat('en-US').format(listing.value.mileage)
});
</script>

<template>
  <div v-if="listing" class="listing">
    <div class="image-panel">
      <img class="backdrop" :src="listing.image_url ?? undefined"/>
      <img class="photo" :src="listing.image_url ?? undefined" :alt="listing.title"/>

      <RouterLink to="/browse" class="close-button" aria-label="Back to browse">
        <span class="mdi mdi-close"></span>
      </RouterLink>
    </div>

    <div class="details-panel">
      <h2 style="margin-bottom: 0;">{{ listing.title }}</h2>
      <h3 style="margin-top: 0;">${{ formatNumber(Number(listing.listing_price)) }}</h3>
      <div class="list-age-location">Listed {{ listedDate }} in {{ listing.city }}, {{ listing.state }}</div>
      
      <hr/>
      <h3>About this vehicle</h3>
      <div class="details-container">
        <div class="details-cell">
          <span class="mdi mdi-factory details-icon"></span>
          <span>Make: {{ listing.make }}</span>
        </div>
        <div class="details-cell">
          <span class="mdi mdi-car-info details-icon"></span>
          <span>Model: {{ listing.model }}</span>
        </div>
        <div class="details-cell">
          <span class="mdi mdi-calendar details-icon"></span>
          <span>Year: {{ listing.year }}</span>
        </div>
        <div class="details-cell">
          <span class="mdi mdi-car-side details-icon"></span>
          <span>Body type: {{ listing.body_type }}</span>
        </div>
        <div class="details-cell">
          <span class="mdi mdi-palette details-icon"></span>
          <span>Exterior color: {{ listing.exterior_color }}</span>
        </div>
        <div class="details-cell">
          <span class="mdi mdi-palette details-icon"></span>
          <span>Interior color: {{ listing.interior_color }}</span>
        </div>
        <div class="details-cell">
          <span class="mdi mdi-speedometer details-icon"></span>
          <span>Driven {{ listedMiles }} miles</span>
        </div>
        <div class="details-cell">
          <span class="mdi mdi-car-shift-pattern details-icon"></span>
          <span>{{ listing.transmission }} transmission</span>
        </div>
        <div class=details-cell>
          <span class="mdi mdi-car-traction-control details-icon"></span>
          <span>{{ listing.drivetrain }} drivetrain</span>
        </div>
        <div class="details-cell">
          <span class="mdi mdi-gas-station details-icon"></span>
          <span>Fuel type: {{ listing.fuel_type }}</span>
        </div>
        <div class="details-cell">
          <span class="mdi mdi-file-certificate details-icon"></span>
          <span>{{ listing.papers }} title</span>
        </div>
        <div class="details-cell">
          <span class="mdi mdi-account-multiple details-icon"></span>
          <span>{{ listing.owners }} owner(s)</span>
        </div>
      </div>

      <div v-if="listing.description">
        <hr/>
        <h3>Seller's description</h3>
        <p>{{ listing.description }}</p>
      </div>
    </div>
  </div>
</template>

<style scoped>
.listing {
  display: flex;
  height: 100%;
}

.close-button {
  position: absolute;
  top: 1rem;
  left: 1rem;
  z-index: 1;

  display: flex;
  align-items: center;
  justify-content: center;
  width: 2.5rem;
  border-radius: 50%;

  background-color: rgba(0, 0, 0, 0.5);
  color: white;
  font-size: 1.5rem;
  text-decoration: none;
}

.close-button:hover {
  background-color: rgba(0, 0, 0, 0.3);
}

.list-age-location {
  font-size: 1rem;
  opacity: 0.5;
}

.details-container {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
}

.details-cell {
  display: flex;
  flex-direction: row;
  justify-content: left;
  align-items: center;
  padding: 0.5rem;
  min-height: 2rem;
  gap: 1rem;
}

.details-icon {
  font-size: 1.5rem;
}

.image-panel {
  flex: 2;
  min-width: 0;
  position: relative;
  overflow: hidden;
  background-color: black;
}

.details-panel {
  flex: 1;
  min-width: 0;
  overflow-y: auto;
  padding: 1rem;
  background-color: var(--canvas-dark);
}

.backdrop {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  filter: blur(0.5rem) brightness(0.5);
  transform: scale(1.25);
}

.photo {
  position: relative;
  display: block;
  width: 100%;
  height: 100%;
  object-fit: contain;
}

.description {
  white-space: pre-line;
}
</style>