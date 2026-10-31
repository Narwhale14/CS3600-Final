<script setup lang="ts">
import Card from '../Card.vue'
import { listings } from '../listings'
</script>

<template>
  <div class="container">
    <RouterLink v-for="card in listings" :key="card.id" :to="`/listing/${card.id}`" class="link">
      <Card :title="card.title" :price="card.price" :city="card.city" :state="card.state" :image="card.image"></Card>
    </RouterLink>
  </div>
</template>

<style scoped>
.container {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(15rem, 1fr));
  gap: 1.5rem 0.75rem;
}

.link {
  color: inherit;
  text-decoration: none;
}
</style>
