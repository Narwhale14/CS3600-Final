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

const listedAgo = computed(() => {
  if(!listing.value) return '';

  const days = Math.floor((Date.now() - Date.parse(listing.value.created_at.replace(' ', 'T'))) / 86400000);
  const rtf = new Intl.RelativeTimeFormat('en', { numeric: 'auto' });
  
  if(days < 7) 
    return rtf.format(-days, 'day');
  if(days < 30) 
    return rtf.format(-Math.floor(days / 7), 'week');
  
  return rtf.format(-Math.floor(days / 30), 'month');
})
</script>

<template>
  <div v-if="listing" class="listing">
    <div class="image-panel">
      <img class="backdrop" :src="listing.image_url ?? undefined"/>
      <img class="photo" :src="listing.image_url ?? undefined" :alt="listing.title"/>
    </div>

    <div class="details-panel">
      <h1>{{ listing.title }}</h1>
      <div>${{ formatNumber(Number(listing.listing_price)) }}</div>
      <div>Listed {{ listedAgo }} in {{ listing.city }}, {{ listing.state }}</div>
      <p v-if="listing.description" class="description">{{ listing.description }}</p>
    </div>
  </div>
</template>

<style scoped>
.listing {
  display: flex;
  height: 100%;
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