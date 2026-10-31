<script setup lang="ts">
import { formatNumber } from './utils';

const props = defineProps<{
  price: number,
  title: string,
  city: string,
  state: string,
  image: string
}>();
</script>

<template>
  <div class="card">
    <img class="image" :src="image" loading="lazy"></img>
    <div class="info">
      <span class="price">${{ formatNumber(price) }}</span>
      <span class="title">{{ title }}</span>
      <span class="location">{{ city }}, {{ state }}</span>
    </div>
  </div>
</template>

<style scoped>
.card {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  cursor: pointer;
}

.image {
  aspect-ratio: 1/1;
  width: 100%;
  border-radius: 0.5rem;
  object-fit: cover;
  background-color: white; /* placeholder */
}

.info {
  display: flex;
  flex-direction: column;
}

.price {
  font-weight: bold;
  font-size: 1.05rem;
}

.title,
.location {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>
