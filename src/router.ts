import { createRouter, createWebHistory } from "vue-router";
import BrowserPage from "./pages/BrowserPage.vue";
import ListingPage from "./pages/ListingPage.vue"
import ProfileSettingsPage from "./pages/ProfileSettingsPage.vue";
import PreferencesPage from "./pages/PreferencesPage.vue";
import SavedPage from "./pages/SavedPage.vue";
import PurchasesPage from "./pages/PurchasesPage.vue";
import LogInPage from "./pages/LogInPage.vue";
import SignUpPage from "./pages/SignUpPage.vue";

export default createRouter({
    history: createWebHistory(),
    routes: [
        { path: '/', redirect: '/browse' },
        { path: '/browse', component: BrowserPage },
        { path: '/listing/:id', component: ListingPage },
        { path: '/settings', component: ProfileSettingsPage },
        { path: '/preferences', component: PreferencesPage },
        { path: '/saved', component: SavedPage },
        { path: '/purchases', component: PurchasesPage },
        { path: '/login', component: LogInPage },
        { path: '/signup', component: SignUpPage }
    ]
});