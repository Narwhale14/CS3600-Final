<template>
  <div class="header">
    <h1 class="logo">WheelSteal</h1>

    <div class="header-nav">
      <button class="shard">Popular</button>
      <button class="shard">Recent Sales</button>
      <button class="shard">Saved</button>
      <button class="shard">My Purchases</button>

      <div class="profile-shard">
        <button class="profile-button pi pi-user"></button>
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
}

.logo {
  display: flex;
  align-items: center;
  margin: 0;
  padding: 0 3rem 0 1rem;
  background: var(--accent-gradient);
  width: var(--logo-width);
  color: var(--gray);
  font-weight: bold;
  clip-path: polygon(0 0, calc(100% - 2rem) 0, 100% 100%, 0 100%);
  box-sizing: border-box;
  flex-shrink: 0;
}

.header-nav {
  flex: 1;
  display: flex;
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

.profile-shard {
  display: flex;
  align-items: center;
  margin-left: -1.5rem;
  background: var(--gray);
  padding: 0 1rem 0 3rem;
  clip-path: polygon(0 0, 100% 0, 100% 100%, 2rem 100%);
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
