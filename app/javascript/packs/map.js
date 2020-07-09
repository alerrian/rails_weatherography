// Sets global variable that is used to determine which state to look closer at
//   Default is the whole US: 37.94, -98.31, 4
var mymap = L.map('map').setView([state_lat, state_lng], state_zoom);

// Uses a MapBox/OpenStreetMap map tile layer to show visuals on the map
L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
    maxZoom: 18,
    id: 'mapbox/streets-v11',
    tileSize: 512,
    zoomOffset: -1,
    accessToken: 'pk.eyJ1Ijoic3RldmVuYWFuZGVyc29uMjAxMiIsImEiOiJja2J1YncxOTIwaWR5MzRtaWdsNWgxajF1In0.O4XNyHXkLnx3fs1jARRbeQ'
}).addTo(mymap);

// Waits for document to load then runs the following script
$(document).ready(function () {
	// Checks is the state_id is not 0(defualt page).
	//   If the state id isn't 0, it prefetches the weather for that state
	//     Weather is cached in Rails on a 3 hour refresh
	if (state_id != 0) {
		// Uses a jQuery get request that hits a Rails endpoint responsible for reaching out
		//  to Open Weather Map API on a 3 hour cache
		$.get('/weather', {state_id}, function(response, status){
			weather = response.data			
		})
	}

	// Waits for a change related to the data-js-search id in index.html.erb
  $('[data-js-search]').change(function (event) {
		//grabs the temp and the weather 
		temp = $(this).val();
		jsonWeather = JSON.parse(weather)
		
		// Removes all of the markers when a state is changed or the temperature is changed
		$(".leaflet-marker-icon").remove();
		$(".leaflet-popup").remove();
		$(".leaflet-pane.leaflet-shadow-pane").remove();

		// Iterates through each key(each city name in the response)
		//   Uses that city name to check data in the API response and place markers
		//     Places markers if the city current temperature is within 10 of the input temp
		Object.keys(jsonWeather).forEach(city_name => {			
			if (jsonWeather[city_name].temp > temp-10 && jsonWeather[city_name].temp < temp+10) {
				marker = L.marker([jsonWeather[city_name].lat, jsonWeather[city_name].long]);
				marker.addTo(mymap);
				marker.bindPopup(`<b>Current Temp:</b> ${jsonWeather[city_name].temp}<br /><b>City Name:</b> ${jsonWeather[city_name].name}`);
			}
    });
  });
})
