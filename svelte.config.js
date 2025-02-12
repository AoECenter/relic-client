// Tauri doesn't have a Node.js server to do proper SSR
// so we will use adapter-static to prerender the app (SSG)
// See: https://beta.tauri.app/start/frontend/sveltekit/ for more info
import adapter from "@sveltejs/adapter-static";

/** @type {import('@sveltejs/kit').Config} */
const config = {
    kit: {
        adapter: adapter(),
        csrf: {
            checkOrigin: true,
        },
        files: {
            assets: "static",
            routes: "src/js/routes",
            appTemplate: "src/js/app.html",
            errorTemplate: "src/js/error.html",
        }
    },
};

export default config;
