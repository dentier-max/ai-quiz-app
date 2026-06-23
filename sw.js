// 题宝 TiBo Service Worker - 离线缓存
const CACHE_NAME = 'tibo-v1';
const ASSETS = [
  './',
  './index.html',
  './tibo-mascot.png',
  './splash-video.mp4',
  './tibo-mascot.mp4',
  './manifest.json'
];

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache => cache.addAll(ASSETS)).then(() => self.skipWaiting())
  );
});

self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(keys => Promise.all(
      keys.filter(k => k !== CACHE_NAME).map(k => caches.delete(k))
    )).then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request).then(cached => {
      return cached || fetch(event.request).then(response => {
        if (response.ok && event.request.url.startsWith(self.location.origin)) {
          caches.open(CACHE_NAME).then(cache => cache.put(event.request, response.clone()));
        }
        return response;
      }).catch(() => event.request.destination === 'document' ? caches.match('./index.html') : new Response('离线', {status: 503}));
    })
  );
});
