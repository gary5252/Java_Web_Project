const chart = echarts.init(document.getElementById('main'));
var eat = document.getElementById('eat').value;
var cloth = document.getElementById('cloth').value;
var live = document.getElementById('live').value;
var traffic = document.getElementById('traffic').value;
var teach = document.getElementById('teach').value;
var fun = document.getElementById('fun').value;
var others = document.getElementById('others').value;
var year = document.getElementById('year').value;

option = {
    title: {
      text: 'Expense Proportion',
      subtext: year + 'September',
      left: 'center'
    },
    tooltip: {
      trigger: 'item'
    },
    legend: {
      orient: 'vertical',
      left: 'left'
    },
    series: [
      {
        name: 'Expenses From(NTD)',
        type: 'pie',
        radius: '50%',
        data: [
          { value: eat, name: '食' },
          { value: cloth, name: '衣' },
          { value: live, name: '住' },
          { value: traffic, name: '行' },
          { value: teach, name: '育' },
          { value: fun, name: '樂' },
          { value: others, name: '其他' }
        ],
        emphasis: {
          itemStyle: {
            shadowBlur: 10,
            shadowOffsetX: 0,
            shadowColor: 'rgba(0, 0, 0, 0.5)'
          }
        }
      }
    ]
  };
chart.setOption(option);

window.onresize = function () {
    chart.resize();
};
