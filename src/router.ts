import { createRouter, createWebHistory } from "vue-router";
import Browser from "./pages/Browser.vue";
import ListingPage from "./pages/ListingPage.vue"

export default createRouter({
    history: createWebHistory(),
    routes: [
        { path: '/', redirect: '/browse' },
        { path: '/browse', component: Browser },
        { path: '/listing/:id', component: ListingPage }
    ]
});