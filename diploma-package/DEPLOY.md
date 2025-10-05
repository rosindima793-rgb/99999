# DEPLOY.md

This document explains how to deploy the project to Netlify and how to verify CSP + nonce behavior.

1) Prerequisites
   - GitHub repository where you will push code (e.g. https://github.com/rosindima793-rgb/99999.git)
   - Netlify account with Team access
   - Node.js 18+ LTS installed locally

2) Push to GitHub
   - Create a new repository or use the target one.
   - Push all project files (including `netlify.toml`) to the repository.

3) Setup Netlify site
   - Connect the repository in Netlify.
   - Ensure the "Build command" is `npm run build` and "Publish directory" is `.netlify/output/public`.
   - Install the Netlify Next.js plugin (the project already references `@netlify/plugin-nextjs`).
   - (Optional) Install the Netlify Content Security Policy extension if you prefer Netlify-managed nonces. If you use it, disable nonce generation in `middleware.ts` to avoid duplicate headers.

4) Verify CSP + nonce on production
   - After deploy, check response headers for `Content-Security-Policy` and `x-nonce`.
   - Confirm HTML contains `nonce="..."` on internal script tags.
   - If mismatch found, check Netlify build logs and the plugin status.

5) Troubleshooting
   - If Netlify injects a static CSP header without nonce, remove it from `netlify.toml`.
   - If middleware doesn't run, ensure Next plugin is active and middleware matcher covers the routes.

6) Security checks
   - Fix high-severity npm audit issues as needed. The project includes `npm audit` in the postbuild step and will fail CI on critical vulnerabilities by default.
