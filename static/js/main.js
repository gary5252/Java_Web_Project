const chart = echarts.init(document.getElementById('main'));
// var jan = document.getElementById('jan').value;
// var feb = document.getElementById('feb').value;
// var mar = document.getElementById('mar').value;
// var apr = document.getElementById('apr').value;
// var may = document.getElementById('may').value;
// var jun = document.getElementById('jun').value;
// var jul = document.getElementById('jul').value;
// var aug = document.getElementById('aug').value;
// var sep = document.getElementById('sep').value;
// var oct = document.getElementById('oct').value;
// var nov = document.getElementById('nov').value;
// var dec = document.getElementById('dec').value;

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
        dataView: { show: true, readOnly: false },
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
        name: 'Amount(2022)',
        min: 0,
        max: 50,
        interval: 10,
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
        //   jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec
        0,1,2,3,4,5,6,7,8,9,10,50
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
          2,3,4,5,6,7,8,1,5,4,7,2
        ]
      }
    ]
  };
chart.setOption(option);

window.onresize = function () {
    chart.resize();
};
