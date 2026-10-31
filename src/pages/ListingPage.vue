<script setup lang="ts">
import { computed } from 'vue'
import { useRoute } from 'vue-router'
import { listings } from '../listings'
import { formatNumber } from '../utils'

const route = useRoute()
const listing = computed(() => listings.find((l) => l.id === Number(route.params.id)))
</script>

<template>
  <div v-if="listing" class="listing">
    <div class="image-panel">
      <img class="backdrop" :src="listing.image"/>
      <img class="photo" :src="listing.image"/>
    </div>

    <div class="details-panel">
      <div>{{ listing.title }}</div>
      <div>${{ formatNumber(listing.price) }}</div>
      <div>Listed 3 weeks ago in {{ listing.city }}, {{ listing.state }}</div>
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
</style>