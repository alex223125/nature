import { Controller } from '@hotwired/stimulus';
import mapboxgl from 'mapbox-gl'

export default class extends Controller {

    static targets = [
        'mapArea',
        'sidebar',
        'occurrencesList'
    ]

    initialize() {
        this.initializeMap()
    }

    // PRIVATE
    initializeMap(){
        const key = this.mapAreaTarget.dataset.key
        mapboxgl.accessToken = key
        this.map = new mapboxgl.Map({
            container: this.mapAreaTarget,
            accessToken: key,
            style: 'mapbox://styles/mapbox/dark-v11',
            projection: 'globe',
            zoom: 6,
            center: [179.30, -16.29]
        })

        this.map.on('load', () => {
            this.addLayers()
        })
    }

    addMouseListeners(){
        const mouseEventTarget = 'clusters'
        this.map.on('mouseenter', mouseEventTarget, () => {
            this.map.getCanvas().style.cursor = 'pointer'
        })
        this.map.on('mouseleave', mouseEventTarget, () => {
            this.map.getCanvas().style.cursor = ''
        })
    }

    addLayers(){
        var that = this
        const url = "/api/v1/species/map"
        Rails.ajax({
            type: "GET",
            url: url,
            dataType: "json",
            success: function (geojsonSource) {
                console.log(geojsonSource)
                that.addGeoDataset(geojsonSource.occurrences)
                that.drawClusters()
                that.setInspectClusterListener()
                that.setInspectUnclusteredPointListener()
                that.addMouseListeners()
            },
            error: function(xhr, status, error){
                var errorMessage = xhr.status + ': ' + xhr.statusText
                alert('Error - ' + errorMessage);
            },
        });
    }

    addGeoDataset (geojsonSource) {
        this.map.addSource('geospatial-dataset', {
            type: 'geojson',
            data: geojsonSource,
            cluster: true,
            clusterMaxZoom: 14,
            clusterRadius: 50
        })
    }

    drawClusters () {
        this.drawClusterCircles()
        this.drawClusterCount()
        this.drawUnclusteredPoints()
    }

    drawClusterCircles () {
        this.map.addLayer({
            id: 'clusters',
            type: 'circle',
            source: 'geospatial-dataset',
            filter: ['has', 'point_count'],
            paint: {
                'circle-color': [
                    'step',
                    ['get', 'point_count'],
                    '#51bbd6',
                    100,
                    '#f1f075',
                    750,
                    '#f28cb1'
                ],
                'circle-radius': [
                    'step',
                    ['get', 'point_count'],
                    20,
                    100,
                    30,
                    750,
                    40
                ]
            }
        })
    }

    drawClusterCount () {
        this.map.addLayer({
            id: 'cluster-count',
            type: 'symbol',
            source: 'geospatial-dataset',
            filter: ['has', 'point_count'],
            layout: {
                'text-field': ['get', 'point_count_abbreviated'],
                'text-font': ['DIN Offc Pro Medium', 'Arial Unicode MS Bold'],
                'text-size': 12
            }
        })
    }

    drawUnclusteredPoints () {
        const drawUnderLayer = 'clusters'
        this.map.addLayer({
            id: 'geospatial-unclustered-circle',
            type: 'circle',
            source: 'geospatial-dataset',
            paint: {
                'circle-color': '#4264fb',
                'circle-radius': 8,
                'circle-stroke-width': 2,
                'circle-stroke-color': '#ffffff'
            }
        }, drawUnderLayer)
    }

    setInspectClusterListener () {
        const target = 'clusters'
        this.map.on('click', target, (e) => {
            const features = this.map.queryRenderedFeatures(e.point, {
                layers: ['clusters']
            })
            const clusterId = features[0].properties.cluster_id
            this.map.getSource('geospatial-dataset').getClusterExpansionZoom(
                clusterId,
                (err, zoom) => {
                    if (err) { return }

                    this.map.easeTo({
                        center: features[0].geometry.coordinates,
                        zoom
                    })
                }
            )
        })
    }

    setInspectUnclusteredPointListener () {
        const target = 'geospatial-unclustered-circle'
        this.map.on('click', target, (e) => {
            if (this.isClusterClicked(e)) { return }
            const featuresList = this.createFeaturesList(e.features)
            this.showSidebar()
            this.insertList(featuresList)
        })
    }

    createFeaturesList (features) {
        let featuresList = []
        features.map((feature) => {
            const featureElement = this.createFeatureElement(feature)
            featuresList.push(featureElement)
        })
        return featuresList
    }

    showSidebar () {
        this.sidebarTarget.style.display = ''
    }

    insertList (featuresList) {
        this.occurrencesListTarget.innerHTML = "";
        this.occurrencesListTarget.insertAdjacentHTML('beforeend', featuresList)
    }

    createFeatureElement (feature) {
        const description = this.setDescriptionData(feature)
        const template = this.createFeatureTemplate(description)
        return template
    }

    createFeatureTemplate (description) {
        const template = `
        <li>
            <div class="block max-w-sm p-6 bg-white border border-gray-200 rounded-lg shadow hover:bg-gray-100 dark:bg-gray-800 dark:border-gray-700 dark:hover:bg-gray-700">
                <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">${description.scientificName}</h5>
                <p class="font-normal text-gray-700 dark:text-gray-400">${description.genusName}</p>
                <p class="font-normal text-gray-700 dark:text-gray-400">${description.family}</p>
                <p class="font-normal text-gray-700 dark:text-gray-400">${description.locality}</p>
                <p class="font-normal text-gray-700 dark:text-gray-400">${description.scientificNameAuthorship}</p>
            </div>
        </li>`
        return template
    }

    isClusterClicked (e) {
        return e.features[0].properties.id === undefined
    }

    setDescriptionData (feature) {
        var description = {
          scientificName: `Scientific name: ${feature.properties.scientificName}`,
          genusName: `Genus name: ${feature.properties.genus}`,
          family: `Family: ${feature.properties.family}`,
          locality: `Locality: ${feature.properties.locality}`,
          scientificNameAuthorship: `Scientific name authorship: ${feature.properties.scientificNameAuthorship}`
        };
        return description
    }

}