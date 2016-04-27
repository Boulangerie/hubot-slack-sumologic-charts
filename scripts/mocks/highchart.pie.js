$(function () {
  $('#container').highcharts({
    chart: {
      type: 'pie',
      forExport: true,
      width: 600,
      height: 400
    },
    title: {
      text: 'Pie column chart'
    },
    plotOptions: {
      pie: {
        dataLabels: {
          enabled: false
        },
        showInLegend: true
      }
    },
    // For building series seems, Build an array for each fields[].keyField:false
    // On each point, x should be keyField:true and y the value, then push to field array
    series: [{
      name: 'toto',
      colorByPoint: true,
      data:[{
        name: 'V1',
        y: 17
      },{
        name: 'V2',
        y: 2920
      },{
        name: 'V3',
        y: 14479
      }]
    }]
  });
});
