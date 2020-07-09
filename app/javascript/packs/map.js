var mymap = L.map('map').setView([state_lat, state_lng], state_zoom);

L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
    maxZoom: 18,
    id: 'mapbox/streets-v11',
    tileSize: 512,
    zoomOffset: -1,
    accessToken: 'pk.eyJ1Ijoic3RldmVuYWFuZGVyc29uMjAxMiIsImEiOiJja2J1YncxOTIwaWR5MzRtaWdsNWgxajF1In0.O4XNyHXkLnx3fs1jARRbeQ'
}).addTo(mymap);

$(document).ready(function () {
	if (state_id != 0) {
		$.get('/weather', {state_id}, function(data, status){
			weather = data
		})
	}
  $('[data-js-search]').change(function (event) {
		temp = parseInt($(this).val(), 10);
		jsonWeather = JSON.parse(weather.data)
		
		$(".leaflet-marker-icon").remove();
		$(".leaflet-popup").remove();
		$(".leaflet-pane.leaflet-shadow-pane").remove();

		Object.keys(jsonWeather).forEach(city_name => {			
			if (jsonWeather[city_name].temp > temp-10 && jsonWeather[city_name].temp < temp+10) {
				marker = L.marker([jsonWeather[city_name].lat, jsonWeather[city_name].long]);
				marker.addTo(mymap);
				marker.bindPopup(`<b>Current Temp:</b> ${jsonWeather[city_name].temp}<br /><b>City Name:</b> ${jsonWeather[city_name].name}`)
			}
    });
  });
})
