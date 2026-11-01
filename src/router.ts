import { createRouter, createWebHistory } from "vue-router";
import BrowserPage from "./pages/BrowserPage.vue";
import ListingPage from "./pages/ListingPage.vue"

export default createRouter({
    history: createWebHistory(),
    routes: [
        { path: '/', redirect: '/browse' },
        { path: '/browse', component: BrowserPage },
        { path: '/listing/:id', component: ListingPage }
    ]
});