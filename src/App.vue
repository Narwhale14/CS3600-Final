<script setup lang="ts">
import Header from './Header.vue'
</script>

<template>
  <Header></Header>

  <div class="main-page">
    <RouterView/>
  </div>
</template>

<style scoped>
.main-page {
  padding: 3rem;
}
</style>
