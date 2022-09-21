const chart = echarts.init(document.getElementById('main'));


option = {
    graphic: {
        elements: [
            {
                type: 'text',
                left: 'center',
                top: 'center',
                style: {
                    text: 'Register',
                    fontSize: 80,
                    fontWeight: 'bold',
                    lineDash: [0, 200],
                    lineDashOffset: 0,
                    fill: 'transparent',
                    stroke: '#000',
                    lineWidth: 1
                },
                keyframeAnimation: {
                    duration: 4000,
                    loop: false,
                    keyframes: [
                        {
                            percent: 0.6,
                            style: {
                                fill: 'transparent',
                                lineDashOffset: 200,
                                lineDash: [200, 0]
                            }
                        },
                        {
                            // Stop for a while.
                            percent: 0.8,
                            style: {
                                fill: 'transparent'
                            }
                        },
                        {
                            percent: 1,
                            style: {
                                fill: 'black'
                            }
                        }
                    ]
                }
            }
        ]
    }
};
chart.setOption(option);

window.onresize = function () {
    chart.resize();
};

// 讓點擊上一頁也能使網站重新refresh
window.onpageshow = function (event) {
    if (event.persisted) {
        window.location.reload()
    }
};