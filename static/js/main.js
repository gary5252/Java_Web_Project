const chart = echarts.init(document.getElementById('main'));
var jan = document.getElementById('jan').value;
var feb = document.getElementById('feb').value;
var mar = document.getElementById('mar').value;
var apr = document.getElementById('apr').value;
var may = document.getElementById('may').value;
var jun = document.getElementById('jun').value;
var jul = document.getElementById('jul').value;
var aug = document.getElementById('aug').value;
var sep = document.getElementById('sep').value;
var oct = document.getElementById('oct').value;
var nov = document.getElementById('nov').value;
var dec = document.getElementById('dec').value;

var janIn = document.getElementById('janIn').value;
var febIn = document.getElementById('febIn').value;
var marIn = document.getElementById('marIn').value;
var aprIn = document.getElementById('aprIn').value;
var mayIn = document.getElementById('mayIn').value;
var junIn = document.getElementById('junIn').value;
var julIn = document.getElementById('julIn').value;
var augIn = document.getElementById('augIn').value;
var sepIn = document.getElementById('sepIn').value;
var octIn = document.getElementById('octIn').value;
var novIn = document.getElementById('novIn').value;
var decIn = document.getElementById('decIn').value;

option = {
    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'cross',
        crossStyle: {
          color: '#999'
        }
      }
    },
    toolbox: {
      feature: {
        dataView: { show: true, readOnly: true },
        magicType: { show: true, type: ['line', 'bar'] },
        restore: { show: true },
        saveAsImage: { show: true }
      }
    },
    legend: {
      data: ['收入', '支出']
    },
    xAxis: [
      {
        type: 'category',
        data: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul','Aug','Sep','Oct','Nov','Dec'],
        axisPointer: {
          type: 'shadow'
        }
      }
    ],
    yAxis: [
      {
        type: 'value',
        name: 'Amount',
        min: 0,
        max: 100000,
        interval: 10000,
        axisLabel: {
          formatter: '{value} NTD'
        }
      }
    ],
    dataZoom: [
        {
          show: true,
          start: 0,
          end: 100
        },
        {
          type: 'inside',
          start: 0,
          end: 100
        },
        {
          show: true,
          yAxisIndex: 0,
          filterMode: 'empty',
          width: 30,
          height: '80%',
          showDataShadow: false,
          left: '93%'
        }
      ],
    series: [
      {
        name: '收入',
        type: 'bar',
        tooltip: {
          valueFormatter: function (value) {
            return value + ' NTD';
          }
        },
        data: [
           janIn,febIn,marIn,aprIn,mayIn,junIn,julIn,augIn,sepIn,octIn,novIn,decIn
        ]
      },
      {
        name: '支出',
        type: 'bar',
        tooltip: {
          valueFormatter: function (value) {
            return value + ' NTD';
          }
        },
        data: [
          jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec
        ]
      }
    ]
  };
chart.setOption(option);

window.onresize = function () {
    chart.resize();
};
