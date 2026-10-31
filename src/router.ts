import { createRouter, createWebHistory } from "vue-router";
import CardContainer from "./CardContainer.vue";
import ListingPage from "./pages/ListingPage.vue"

export default createRouter({
    history: createWebHistory(),
    routes: [
        { path: '/', component: CardContainer },
        { path: '/listing/:id', component: ListingPage }
    ]
});