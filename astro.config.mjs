import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
  site: 'https://ossfe.github.io',
  base: '/OSSFE_2027/',
  vite: { plugins: [tailwindcss()] },
});