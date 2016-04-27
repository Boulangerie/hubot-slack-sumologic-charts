$(function () {
  $('#container').highcharts({
    chart: {
      type: 'line',
      forExport: true,
      width: 600,
      height: 400
    },
    title: {
      text: 'Player'
    },
    xAxis: {
      type: "datetime",
      min: 1458880560000,
      max: 1458923760000
    },
    // For building series seems, Build an array for each fields[].keyField:false
    // On each point, x should be keyField:true and y the value, then push to field array
    series: [{
      name: 'videothirdquartile',
      data: [{
        x: 1458923400000,
        y: 4753
      }, {
        x: 1458922500000,
        y: 13238
      }]
    }, {
      name: 'loaded',
      data: [{
        x: 1458923400000,
        y: 23586
      }, {
        x: 1458922500000,
        y: 67521
      }]
    }, {
      name: 'videomidpoint',
      data: [{
        x: 1458923400000,
        y: 5787
      }, {
        x: 1458922500000,
        y: 16398
      }]
    }, {
      name: 'videofirstquartile',
      data: [{
        x: 1458923400000,
        y: 7554
      }, {
        x: 1458922500000,
        y: 21489
      }]
    }, {
      name: 'videostart',
      data: [{
        x: 1458923400000,
        y: 13588
      }, {
        x: 1458922500000,
        y: 38344
      }]
    }, {
      name: 'videocomplete',
      data: [{
        x: 1458923400000,
        y: 4035
      }, {
        x: 1458922500000,
        y: 11147
      }]
    }, {
      name: 'clickthru',
      data: [{
        x: 1458923400000,
        y: 107
      }, {
        x: 1458922500000,
        y: 274
      }]
    }]
  });
});
