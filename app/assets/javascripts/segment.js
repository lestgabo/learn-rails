
!function(){
  var analytics=window.analytics=window.analytics||[];
  if(!analytics.initialize)
  if(analytics.invoked)window.console&&console.error&&console.error("Segment snippet included twice.");
  else{analytics.invoked=!0;analytics.methods=["trackSubmit","trackClick","trackLink","trackForm","pageview","identify","reset","group","track","ready","alias","debug","page","once","off","on"];
  analytics.factory=function(t){
    return function(){
      var e=Array.prototype.slice.call(arguments);e.unshift(t);analytics.push(e);
      return analytics}};for(var t=0;t<analytics.methods.length;t++){
        var e=analytics.methods[t];analytics[e]=analytics.factory(e)}
        analytics.load=function(t){
          var e=document.createElement("script");e.type="text/javascript";e.async=!0;e.src=("https:"===document.location.protocol?"https://":"http://")+"cdn.segment.com/analytics.js/v1/"+t+"/analytics.min.js";
          var n=document.getElementsByTagName("script")[0];n.parentNode.insertBefore(e,n)};analytics.SNIPPET_VERSION="4.0.0";

analytics.load("mPoszhYCNXyU7So8EtMvXIxXYpJbtX9E");

}}();

// accommodate Turbolinks
// track page views and form submissions
$(document).on('turbolinks:load', function() {
  console.log('page loaded');
  analytics.page();
  analytics.trackForm($('#new_visitor'), 'Signed Up');
  analytics.trackForm($('#new_contact'), 'Contact Request');
})

// Analytics work, unfortunately the ublock extension blocks it
// everyone uses ublock, how would I check if there are any analytics? LOL