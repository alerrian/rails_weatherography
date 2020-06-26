var mymap = L.map('map').setView([state_lat, state_lng], state_zoom);

L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
    maxZoom: 18,
    id: 'mapbox/streets-v11',
    tileSize: 512,
    zoomOffset: -1,
    accessToken: 'pk.eyJ1Ijoic3RldmVuYWFuZGVyc29uMjAxMiIsImEiOiJja2J1YncxOTIwaWR5MzRtaWdsNWgxajF1In0.O4XNyHXkLnx3fs1jARRbeQ'
}).addTo(mymap);

var weather = JSON.parse(state_weather);

Object.keys(weather).forEach(city_name => {
    marker = L.marker([weather[city_name].lat, weather[city_name].long]).addTo(mymap);
    marker.bindPopup(`Current Temperature: ${weather[city_name].temp}`)
});
