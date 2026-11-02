<script setup lang="ts">
import Card from '../Card.vue'
import BrowserFilters from '../BrowserFilters.vue'
import { ref, onMounted } from 'vue';
import { getCars, type Cars } from '../cars.ts';

const listings = ref<Cars[]>([]);
onMounted(async () => {
  listings.value = await getCars();
});
</script>

<template>
  <div class="container">
    <RouterLink v-for="listing in listings" :key="listing.vin" :to="`/listing/${listing.vin}`" class="link">
      <Card :title="listing.title" :price="Number(listing.listing_price)" :city="listing.city" :state="listing.state" :image="listing.image_url ?? undefined"></Card>
    </RouterLink>
  </div>

  <BrowserFilters></BrowserFilters>
</template>

<style scoped>
.container {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(15rem, 1fr));
  gap: 1.5rem 0.75rem;
  padding: 3rem;
  margin-left: var(--logo-width);
}

.link {
  color: inherit;
  text-decoration: none;
}
</style>
