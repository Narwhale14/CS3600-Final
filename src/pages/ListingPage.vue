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
    <img :src="listing.image" :alt="listing.title"/>
    <h1>{{ listing.title }}</h1>
    <span>${{ formatNumber(listing.price) }}</span>
    <span>{{ listing.city }}, {{ listing.state }}</span>
    <RouterLink to="/browse">Back</RouterLink>
  </div>
  <p v-else>Listing not found.</p>
</template>

<style scoped>
.listing {
  display: flex;
  flex-direction: column;
}
</style>