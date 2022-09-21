const chart = echarts.init(document.getElementById('main'));

option = {
    title: {
      text: 'Expense Proportion',
      subtext: '2022 September',
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
          { value: 1048, name: '食' },
          { value: 2000, name: '衣' },
          { value: 12000, name: '住' },
          { value: 1000, name: '行' },
          { value: 742, name: '育' },
          { value: 2834, name: '樂' },
          { value: 252, name: '其他' }
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
