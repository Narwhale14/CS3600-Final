<script setup lang="ts">
import Card from '../Card.vue';
import BrowserFilters from '../BrowserFilters.vue';
import { ref, watch } from 'vue';
import { getCars, type Cars, type CarFilters, type CarRelaxation } from '../cars.ts';

const listings = ref<Cars[]>([]);
const filters = ref<CarFilters>({});
const relaxation = ref<CarRelaxation | null>(null);
const loading = ref(false);
const error = ref('');

watch(filters, (currentFilters, _, onCleanup) => {
    const controller = new AbortController();
    const selectedFilters = { ...currentFilters };

    loading.value = true;
    error.value = '';

    // Debounce requests while the user adjusts filters.
    const timeout = setTimeout(async () => {
      try {
        const result = await getCars(
          selectedFilters,
          controller.signal
        );

        if (!controller.signal.aborted) {
          listings.value = result.cars;
          relaxation.value = result.relaxation;
          loading.value = false;
        }
      } catch (err) {
        if (!controller.signal.aborted) {
          console.error(err);
          error.value = 'Failed to load vehicle listings.';
          relaxation.value = null;
          loading.value = false;
        }
      }
    }, 250);

    // Prevent outdated requests from replacing newer results.
    onCleanup(() => {
      clearTimeout(timeout);
      controller.abort();
    });
  },
  {
    deep: true,
    immediate: true
  }
);
</script>

<template>
  <div class="content">
    <div class="search-bar">
      <label class="search">
        <span class="pi pi-search"></span>
        <input v-model="filters.search" type="search" placeholder="Search by make, model, title, etc.">
      </label>
    </div>

    <!-- Inform the user when TAH relaxation is used. -->
    <div v-if="!loading && !error && relaxation" class="relaxation-notice">
      <strong>No {{ relaxation.requested }} listings matched.</strong>

      <span v-if="relaxation.level === 'siblings'">
        Showing related body types:
        {{ relaxation.shownTypes.join(', ') }}.
      </span>

      <span v-else>
        No matching vehicles were found in the same category.
        Showing alternatives from other body-type categories:
        {{ relaxation.shownTypes.join(', ') }}.
      </span>
    </div>

    <div class="container">
      <p v-if="loading">Loading vehicles...</p>
      <p v-else-if="error">{{ error }}</p>
      <p v-else-if="listings.length === 0">
        No vehicles match your selected filters.
      </p>

      <template v-else>
        <RouterLink v-for="listing in loading || error ? [] : listings" :key="listing.vin" :to="`/listing/${listing.vin}`" class="link">
          <Card :title="listing.title" :price="Number(listing.listing_price)" :city="listing.city" :state="listing.state" :image="listing.image_url ?? undefined"></Card>
        </RouterLink>
      </template>
    </div>
  </div>

  <BrowserFilters v-model="filters"></BrowserFilters>
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

.relaxation-notice {
  display: flex;
  flex-direction: column;
  gap: 0.35rem;
  padding: 1rem 1.5rem;
  margin: 1rem 2rem 0;
  border: 1px solid var(--beige);
  border-radius: 4px;
  color: var(--beige);
}
</style>
