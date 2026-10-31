<script setup lang="ts">
import Header from './Header.vue'
</script>

<template>
  <div class="app">
    <Header></Header>

    <div class="main-page">
      <RouterView/>
    </div>
  </div>
</template>

<style scoped>
.app {
  display: flex;
  flex-direction: column;
  height: 100vh;
}

.main-page {
  flex: 1;
  min-height: 0;
  overflow-y: auto;
}
</style>
