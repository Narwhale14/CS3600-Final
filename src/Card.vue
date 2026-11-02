<script setup lang="ts">
import { formatNumber } from './utils';

const props = defineProps<{
  price: number,
  title: string,
  city: string,
  state: string,
  image?: string
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
  cursor: pointer;
  border: 5px solid var(--gray);
  border-radius: 0.5rem;
}

.image {
  aspect-ratio: 1/1;
  width: 100%;
  border-bottom: 2px solid var(--gray);
  border-radius: 0.5rem 0.5rem 0 0;
  object-fit: cover;
  background-color: white; /* placeholder */
}

.info {
  display: flex;
  flex-direction: column;
  padding: 0.5rem;
}

.title {
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  overflow: hidden;
  min-height: 2lh;
}

.location {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.price {
  align-self: flex-start;
  margin: -0.5rem 0 0 -0.5rem;
  padding: 0.1rem 1.25rem 0.1rem 0.5rem;
  font-weight: bold;
  font-size: 1.05rem;
  color: var(--gray);
  background: var(--accent-gradient);

  clip-path: polygon(0 0, 100% 0, calc(100% - 0.75rem) 100%, 0 100%);
}
</style>
