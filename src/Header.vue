<script setup lang="ts">
import { computed, ref } from 'vue';

const menuOpen = ref(false);
const signedIn = ref(true); // replace later

const navItems = ['Popular', 'Recent Sales'];
const profileItems = computed(() => signedIn.value ? ['Profile Settings', 'Preferences', 'Saved', 'Purchases'] : ['Sign In', 'Sign Up']);
</script>

<template>
  <div class="header">
    <RouterLink to="/browse" class="logo">
      <h1>WheelSteal</h1>
    </RouterLink>

    <div class="header-nav" :class="{ 'menu-open': menuOpen }">
      <div class="shard-track" :style="{ '--slots': navItems.length }">
        <button v-for="(label, i) in navItems" :key="label" class="shard nav-shard" :style="{ '--i': navItems.length - 1 - i }">
          {{ label }}
        </button>

        <div class="profile-menu">
          <button v-for="(label, i) in profileItems" :key="label" class="shard menu-shard" :style="{ '--i': profileItems.length - 1 - i }">
            {{ label }}
          </button>
        </div>
      </div>

      <div class="profile-shard" @click="menuOpen = !menuOpen">
        <button class="profile-button pi" :class="menuOpen ? 'pi-times' : 'pi-user'"></button>
      </div>
    </div>
  </div>
</template>

<style scoped>
.header {
  display: flex;
  flex-shrink: 0;
  height: 5rem;
  padding-bottom: 0.5rem;
  border-bottom: 1rem solid var(--gray);
  overflow: hidden;
}

.logo {
  position: relative;
  z-index: 2;
  display: flex;
  align-items: center;
  margin: 0;
  padding: 0 3rem 0 1rem;
  background: var(--accent-gradient);
  width: var(--logo-width);
  color: var(--gray);
  font-weight: bold;
  text-decoration: none;
  clip-path: polygon(0 0, calc(100% - 2rem) 0, 100% 100%, 0 100%);
  box-sizing: border-box;
  flex-shrink: 0;
}

.logo h1 {
  margin: 0;
}

.header-nav {
  flex: 1;
  display: flex;
}

.shard-track {
  flex: 1;
  display: flex;
  position: relative;
}

.shard {
  flex: 1;
  margin-left: -1.5rem;
  background-color: var(--gray);
  padding: 0 2.5rem;
  color: var(--beige);
  cursor: pointer;
  clip-path: polygon(0 0, calc(100% - 2rem) 0, 100% 100%, 2rem 100%);
  font-size: 1.25rem;
}

.shard:hover, .profile-shard:hover {
  background: color-mix(in oklab, var(--gray), white 10%);
}

.nav-shard, .menu-shard {
  transition-property: transform, opacity, visibility;
  transition-duration: 450ms;
  transition-timing-function: cubic-bezier(0.22, 1, 0.36, 1);
}

.nav-shard {
  transition-delay: calc(var(--i) * 50ms);
}

.menu-open .nav-shard {
  transform: translateX(-40%);
  opacity: 0;
  visibility: hidden;
}

.profile-menu {
  position: absolute;
  inset: 0;
  display: flex;
  justify-content: flex-end;
  pointer-events: none;
}

.menu-shard {
  flex: 0 1 calc(100% / var(--slots) + 1.5rem);
  pointer-events: auto;
  transform: translateX(calc((var(--i) + 1) * 100%));
  visibility: hidden;
}

.menu-open .menu-shard {
  transform: none;
  visibility: visible;
}

.profile-shard {
  position: relative;
  z-index: 2;
  display: flex;
  align-items: center;
  margin-left: -1.5rem;
  background: var(--gray);
  padding: 0 1rem 0 3rem;
  clip-path: polygon(0 0, 100% 0, 100% 100%, 2rem 100%);
  cursor: pointer;
}

.profile-button {
  width: 2.5rem;
  height: 2.5rem;
  border-radius: 50%;
  border: none;
  background: var(--accent-gradient);
  color: var(--gray);
  cursor: pointer;
  font-size: x-large;
}
</style>