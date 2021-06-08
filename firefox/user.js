// Settings for FlyingFox
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true); 
user_pref("layers.acceleration.force-enabled", true);
user_pref("gfx.webrender.all", true);
user_pref("gfx.webrender.enabled", true);
user_pref("svg.context-properties.content.enabled", true);
user_pref("layout.css.backdrop-filter.enabled", true);
user_pref("browser.compactmode.show", true);
user_pref("browser.proton.contextmenus.enabled", false);
user_pref("browser.proton.doorhangers.enabled", false);
user_pref("browser.proton.enabled", false);
user_pref("browser.proton.modals.enabled", false);
user_pref("browser.proton.places-tooltip.enabled", false);

// ** Useful Options ***********************************************************
// Integrated calculator at urlbar
user_pref("browser.urlbar.suggest.calculator", true);

// For performance
user_perf("dom.image-lazy-loading.enabled", true);
user_perf("browser.sessionstore.restore_tabs_lazily", true);
user_perf("browser.sessionstore.restore_on_demand", true);
user_perf("browser.startup.preXulSkeletonUI", false);

// Startup Settings

user_pref("browser.newtab.preload", false);

// disable Activity Stream Telemetry
user_pref("browser-newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser-newtabpage.activity-stream.telemetry", false);

// disable Activity Stream Snippets
// A part code retrived from the server after a specific time.
user_perf("browser.newtabpage.activity-stream-feeds.snippets", false);

// disable Activity Stream Top Stories, Pocket-based and/or sponsored content
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.feeds.discoverystreamfeed", false);

// 0105e: clear default topsites
user_pref("browser.newtabpage.activity-stream.default.sites", "");

// disable Location-Aware Browsing
user_pref("geo.enabled", false);

// set a default permission for Location
user_pref("permissions.default.geo", 2);

// use Mozilla geolocation service instead of Google when geolocation is enabled
user_pref("geo.provider.network.url", "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%");
user_pref("geo.provider.network.logging.enabled", false);

// disable using the OS's geolocation service
user_pref("geo.provider.ms-windows-location", false); // [WINDOWS]
user_pref("geo.provider.use_corelocation", false); // [MAC]
user_pref("geo.provider.use_gpsd", false); // [LINUX]

// disable region updates
user_pref("browser.region.network.url", ""); // [FF78+]
user_pref("browser.region.update.enabled", false); // [[FF79+]

// preferred language for displaying web pages
user_pref("intl.accept_languages", "en-US, en");

// disable auto-INSTALLING Firefox updates
user_pref("app.update.auto", false);

// disable search engine updates
user_pref("browser.search.update", false)

// disable "about:addons" Recommendations pane - use Google Analytics
user_perf("extensions.getAddons.showPane", false);

// disable "about:addons" recommendations for Extensions and Themes
user_perf("extensions.htmlaboutaddons.recommendations.enabled", false);

// disable telemetry
user_perf("toolkit.telemetry.unified", false);
user_perf("toolkit.telemetry.enabled", false);
user_perf("toolkit.telemetry.server", "data:,");
user_perf("toolkit.telemetry.archive.enabled", false);
ser_pref("toolkit.telemetry.newProfilePing.enabled", false); // [FF55+]
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false); // [FF55+]
user_pref("toolkit.telemetry.updatePing.enabled", false); // [FF56+]
user_pref("toolkit.telemetry.bhrPing.enabled", false); // [FF57+] Background Hang Reporter
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false); // [FF57+]

// disable Telemetry Coverage
user_pref("toolkit.telemetry.coverage.opt-out", true); // [HIDDEN PREF]
user_pref("toolkit.coverage.opt-out", true); // [FF64+] [HIDDEN PREF]
user_pref("toolkit.coverage.endpoint.base", "");

// disable Health Reports
user_pref("datareporting.healthreport.uploadEnabled", false);

// disable new data submission, master kill switch [FF41+]
user_pref("datareporting.policy.dataSubmissionEnabled", false);

// disable Studies (see 0503)
user_pref("app.shield.optoutstudies.enabled", false);

// disable personalized Extension Recommendations in about:addons and AMO [FF65+]
user_pref("browser.discovery.enabled", false);

// disable Crash Reports
user_pref("breakpad.reportURL", "");
user_pref("browser.tabs.crashReporting.sendReport", false); // [FF44+]

// enforce no submission of backlogged Crash Reports [FF58+]
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);

// disable Captive Portal detection
user_pref("captivedetect.canonicalURL", "");
user_pref("network.captive-portal-service.enabled", false); // [FF52+]

// disable Network Connectivity checks [FF65+]
user_pref("network.connectivity-service.enabled", false);

// BLOCKLISTS

// enforce Firefox blocklist
user_pref("extensions.blocklist.enabled", true); 

// disable SB checks for downloads (remote)
user_pref("browser.safebrowsing.downloads.remote.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.url", "");

// SYSTEM ADD-ONS / EXPERIMENTS

// disable Normandy/Shield [FF60+]
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");

// disable System Add-on updates
user_pref("extensions.systemAddon.update.enabled", false);
user_pref("extensions.systemAddon.update.url", "");

// disable PingCentre telemetry (used in several System Add-ons) [FF57+]
user_pref("browser.ping-centre.telemetry", false);

// disable Form Autofill
user_pref("extensions.formautofill.addresses.enabled", false); // [FF55+]
user_pref("extensions.formautofill.available", "off"); // [FF56+]
user_pref("extensions.formautofill.creditCards.available", false); // [FF57+]
user_pref("extensions.formautofill.creditCards.enabled", false); // [FF56+]
user_pref("extensions.formautofill.heuristics.enabled", false); // [FF55+]

// enforce disabling of Web Compatibility Reporter [FF56+]
user_pref("extensions.webcompat-reporter.enabled", false);

// BLOCK IMPLICIT OUTBOUND

// disable link prefetching
user_pref("network.prefetch-next", false);

// disable DNS prefetching
user_pref("network.dns.disablePrefetch", true);

// disable predictor / prefetching
user_pref("network.predictor.enabled", false);

// disable HTTP Alternative Services
user_pref("network.http.altsvc.enabled", false);
user_pref("network.http.altsvc.oe", false);

// disable GIO as a potential proxy bypass vector
user_pref("network.gio.supported-protocols", "");

// LOCATION BAR / SEARCH BAR / SUGGESTIONS / HISTORY / FORMS

// disable location bar using search
user_pref("keyword.enabled", false);

// disable location bar domain guessing
user_pref("browser.fixup.alternate.enabled", false);

// display all parts of the url in the location bar
user_pref("browser.urlbar.trimURLs", false);

// disable coloring of visited links - CSS history leak
user_pref("layout.css.visited_links_enabled", false);

// disable location bar making speculative connections
user_pref("browser.urlbar.speculativeConnect.enabled", false);

// disable location bar leaking single words to a DNS provider **after searching**
user_pref("browser.urlbar.dnsResolveSingleWordsAfterSearch", 0);

// disable location bar suggestion types
user_pref("browser.urlbar.suggest.bookmark", false);
user_pref("browser.urlbar.suggest.openpage", false);
user_pref("browser.urlbar.suggest.topsites", false);

// disable search and form history
user_pref("browser.formfill.enable", false);

// FAVICONS

// disable favicons in shortcuts
user_pref("browser.shell.shortcutFavicons", false);

// disable favicons in history and bookmarks
user_pref("browser.chrome.site_icons", false);

// disable favicons in web notifications
user_pref("alerts.showFavicons", false);

// HTTPS (SSL/TLS / OCSP / CERTS / HPKP / CIPHERS)

// require safe negotiation
user_pref("security.ssl.require_safe_negotiation", true);

// enforce TLS 1.0 and 1.1 downgrades as session only
user_pref("security.tls.version.enable-deprecated", false);

// user_pref("security.tls.version.enable-deprecated", false);
user_pref("security.ssl.disable_session_identifiers", true);

// disable TLS1.3 0-RTT
user_pref("security.tls.enable_0rtt_data", false);
