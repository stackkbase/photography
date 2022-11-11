'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "55df65a851aeae0ffb2d405e09363dac",
"index.html": "b7beb9e6b561b519a874deff8bd7be83",
"/": "b7beb9e6b561b519a874deff8bd7be83",
"main.dart.js": "27d3f6950cc311de3707352a20ae1d9d",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "d613defc97afc1b99491081556b99405",
"assets/AssetManifest.json": "b1ecaf1b098d5c9980be16a84e6b94b5",
"assets/NOTICES": "7300351606271c1b2c37f3c3373f45a3",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "aa1ec80f1b30a51d64c72f669c1326a7",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "5178af1d278432bec8fc830d50996d6f",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "b37ae0f14cbc958316fac4635383b6e8",
"assets/packages/flutter_signin_button/assets/logos/google_dark.png": "c32e2778b1d6552b7b4055e49407036f",
"assets/packages/flutter_signin_button/assets/logos/google_light.png": "f71e2d0b0a2bc7d1d8ab757194a02cac",
"assets/packages/flutter_signin_button/assets/logos/2.0x/google_dark.png": "937022ea241c167c8ce463d2ef7ed105",
"assets/packages/flutter_signin_button/assets/logos/2.0x/google_light.png": "8f10eb93525f0c0259c5e97271796b3c",
"assets/packages/flutter_signin_button/assets/logos/2.0x/facebook_new.png": "83bf0093719b2db2b16e2839aee1069f",
"assets/packages/flutter_signin_button/assets/logos/3.0x/google_dark.png": "ac553491f0002941159b405c2d37e8c6",
"assets/packages/flutter_signin_button/assets/logos/3.0x/google_light.png": "fe46d37e7d6a16ecd15d5908a795b4ee",
"assets/packages/flutter_signin_button/assets/logos/3.0x/facebook_new.png": "12531aa3541312b7e5ddd41223fc60cb",
"assets/packages/flutter_signin_button/assets/logos/facebook_new.png": "e1dff5c319a9d7898aee817f624336e3",
"assets/shaders/ink_sparkle.frag": "d6a11031c9a6ca49dfadeb5063650848",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/flutter_login_ui_amir.jpg": "e5476e1f36236702b89b7e3eeb5d6794",
"assets/assets/template_bg.jpg": "458f551f5647e5ea3a671161cef29db2",
"assets/assets/banner.jpeg": "a6154652e8d46a86e82620f3734cb2dd",
"assets/assets/exhibition.png": "b224950336e081df4ad0f67fb1a8d351",
"assets/assets/red-carpet.png": "f17570f905a73a5517f667a2b3742cc9",
"assets/assets/8.jpg": "cf354b2c3fb50d6f853b56ae4eeb1747",
"assets/assets/loading.json": "488fa08b5290a86dcba76b446b53a064",
"assets/assets/9.jpg": "a81b81acb2cf14fd56db661e9c3eda2a",
"assets/assets/14.jpg": "3d2b77a5a1155791b2d1b61aa38710af",
"assets/assets/28.jpg": "9c7cac6ad5886767530363528f628eba",
"assets/assets/file.png": "cbfc4b3c83b6162361b43accf4a4f2e7",
"assets/assets/29.jpg": "33470d4ca35c14c6aab07764797474fb",
"assets/assets/15.jpg": "9442afcfec363234a15bcb56dc096de4",
"assets/assets/17.jpg": "536f63657fde91f24c6e623a0cb36d56",
"assets/assets/fast-delivery.png": "f99e94f23d9eacca1ce1f83d502d31cb",
"assets/assets/16.jpg": "396a104179d2deafd94c2662f8f757f8",
"assets/assets/12.jpg": "4ed492405208c815db694d8a518feccd",
"assets/assets/13.jpg": "0dc31128b2ecffa23e061438cd011d42",
"assets/assets/39.jpg": "99da72cfe019e2eccd2dd0f91af84ef0",
"assets/assets/11.jpg": "036089e7a28ae0b9ea9ec0c9733d595b",
"assets/assets/10.jpg": "4a4b377d71ff834eedf234dac40ddfda",
"assets/assets/38.jpg": "1ccee69ba274520b87b5aebabd8b8fc1",
"assets/assets/21.jpg": "c4485ac9143554723bba36f51388d4a4",
"assets/assets/35.jpg": "58258f6da457f2c77deb0d2df351feb2",
"assets/assets/frame-48.png": "fe04ad1b10d4b5a69104806885b58e6c",
"assets/assets/submit.png": "d355bfcca8b76acdcc3b7c159ca6439d",
"assets/assets/shutdown.png": "ec8b8c4d5f21388e36083ee503e052ce",
"assets/assets/folder.png": "bab784f160b73ebe3b66a4ca7b91c82d",
"assets/assets/34.jpg": "8762cd94618e39d26787e35973c2a8ad",
"assets/assets/20.jpg": "57c3cfc105d0c49abe9f5516d9aade49",
"assets/assets/36.jpg": "3d43b7aee759b1a5fd0b1ccee04e5475",
"assets/assets/22.jpg": "bacdc89c94239cbe13a01161f2232bd1",
"assets/assets/login_01.jpg": "47b0211e4581e962c4f911e12930ec54",
"assets/assets/23.jpg": "8c481317434e5d3df2f99841947bdaae",
"assets/assets/37.jpg": "765502e99e75c3ea5f2dc864294d0926",
"assets/assets/33.jpg": "a5520f33128bca12816ab9b6ed6d60c8",
"assets/assets/27.jpg": "471ed8f595d7246068f56ae7dfecb408",
"assets/assets/26.jpg": "d313943bb88ad396cb829082ae253811",
"assets/assets/32.jpg": "50ca717cafa9cfd0c853ef9e26bea740",
"assets/assets/18.jpg": "dc52fa6c2f5d7424643e23786b32a438",
"assets/assets/24.jpg": "926cbabd8e9bafc25f4f3a287cd6171d",
"assets/assets/30.jpg": "a19ae7301b0e85651357386691354fcc",
"assets/assets/silhoutte.jpg": "ec9ab8e846b88cdc3b140bc0a64d1a1e",
"assets/assets/31.jpg": "8b14adf9ba33f4892f90e25e7fb8abca",
"assets/assets/25.jpg": "af7ac97f3364de2aca069e1b0055e826",
"assets/assets/19.jpg": "42ec8c303280ed66c063e03a2a9afe94",
"assets/assets/4.jpg": "489d4d549cd82fe1aa1814467126676e",
"assets/assets/5.jpg": "a763d1fd75a96866afd81860643f7039",
"assets/assets/7.jpg": "c76ace4595912f9fca4e9ccb1b331bee",
"assets/assets/admin.png": "3a8f5436ee80a6c9e7193d551401d893",
"assets/assets/6.jpg": "28f782afc5262313a662373f7dfc93b5",
"assets/assets/2.jpg": "d399329a620390c3c0684b576640438b",
"assets/assets/bg.jpeg": "0ad10652d9afa15016317f9f75737f6e",
"assets/assets/screen_shot.png": "bac731b268d7be416b08d77921fa7272",
"assets/assets/3.jpg": "578a5f9cdaf8e0f183d3bca997f0303b",
"assets/assets/1.jpg": "a4eaf44f9111c37a7bc8dc7f9c2c1ab1",
"assets/assets/bg.jpg": "01fce08f29be598dd94c6acec2cbd592",
"fav.png": "5dcef449791fa27946b3d35ad8803796",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
