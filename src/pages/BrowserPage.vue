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
  <div class="content">
    <div class="search-bar">
      <label class="search">
        <span class="pi pi-search"></span>
        <input type="search" placeholder="Search by make, model, title, etc.">
      </label>
    </div>

    <div class="container">
      <RouterLink v-for="listing in listings" :key="listing.vin" :to="`/listing/${listing.vin}`" class="link">
        <Card :title="listing.title" :price="Number(listing.listing_price)" :city="listing.city" :state="listing.state" :image="listing.image_url ?? undefined"></Card>
      </RouterLink>
    </div>
  </div>

  <BrowserFilters></BrowserFilters>
</template>

<style scoped>
.content {
  display: flex;
  flex-direction: column;
  height: 100%;
  margin-left: var(--logo-width);
}

.container {
  flex: 1;
  min-height: 0;
  overflow-y: auto;
  padding: 1.5rem 2rem 2rem;
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(15rem, 1fr));
  align-content: start;
  gap: 1.5rem 0.75rem;
}

.search-bar {
  padding: 0rem 1rem 1rem 1rem;
  background: var(--gray);
}

.search {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.5rem 0.75rem;
  color: var(--beige);
  border: 2px solid var(--beige);
  border-radius: 2px;
}

.search input {
  flex: 1;
  min-width: 0;
  background: none;
  color: inherit;
}

.link {
  color: inherit;
  text-decoration: none;
}
</style>
