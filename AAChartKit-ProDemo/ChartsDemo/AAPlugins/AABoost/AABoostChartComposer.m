//
//  AABoostChartComposer.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/11.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AABoostChartComposer.h"
#import "AAChartKit-Pro.h"
#import "AAHeatmapChartComposer.h"
#import "AAOptions+boost.h"

@implementation AABoostChartComposer

/**
 function getData(n) {
     const arr = [];
     let a,
         b,
         c,
         spike;
     for (let i = 0; i < n; i = i + 1) {
         if (i % 100 === 0) {
             a = 2 * Math.random();
         }
         if (i % 1000 === 0) {
             b = 2 * Math.random();
         }
         if (i % 10000 === 0) {
             c = 2 * Math.random();
         }
         if (i % 50000 === 0) {
             spike = 10;
         } else {
             spike = 0;
         }
         arr.push([
             i,
             2 * Math.sin(i / 100) + a + b + c + spike + Math.random()
         ]);
     }
     return arr;
 }
 const n = 500000,
     data = getData(n);


 console.time('line');
 Highcharts.chart('container', {

     chart: {
         zooming: {
             type: 'x'
         },
         panning: true,
         panKey: 'shift'
     },

     boost: {
         useGPUTranslations: true
     },

     title: {
         text: 'Highcharts drawing ' + n + ' points'
     },

     subtitle: {
         text: 'Using the Boost module'
     },

     tooltip: {
         valueDecimals: 2
     },

     series: [{
         data: data,
         lineWidth: 0.5
     }]

 });
 console.timeEnd('line');

 */
NSArray<NSArray<NSNumber *> *> *getData(NSUInteger n) {
    NSMutableArray<NSArray<NSNumber *> *> *arr = [NSMutableArray arrayWithCapacity:n];
    double a = 0.0, b = 0.0, c = 0.0, spike;
    
    for (NSUInteger i = 0; i < n; i++) {
        if (i % 100 == 0) {
            a = 2 * arc4random_uniform(1000000) / 1000000.0;
        }
        if (i % 1000 == 0) {
            b = 2 * arc4random_uniform(1000000) / 1000000.0;
        }
        if (i % 10000 == 0) {
            c = 2 * arc4random_uniform(1000000) / 1000000.0;
        }
        if (i % 50000 == 0) {
            spike = 10;
        } else {
            spike = 0;
        }
        
        double value = 2 * sin(i / 100.0) + a + b + c + spike + (arc4random_uniform(1000000) / 1000000.0);
        [arr addObject:@[@(i), @(value)]];
    }
    
    return [arr copy];
}

//配置 AAOptions 实例对象
+ (AAOptions *)lineChart {
    NSUInteger n = 500000;
    NSArray *data = getData(n);
    
    AAOptions *aaOptions = AAOptions.new
        .boostSet(AABoost.new
                  .useGPUTranslationsSet(@true))
        .chartSet(AAChart.new
                  //              .zoomTypeSet(AAChartZoomTypeX)
                  .pinchTypeSet(AAChartZoomTypeX)
                  .panningSet(true)
                  .panKeySet(@"shift"))
        .colorsSet(@[AAColor.redColor])
        .titleSet(AATitle.new
                  .textSet([NSString stringWithFormat:@"Highcharts drawing %ld points", n]))
        .subtitleSet(AASubtitle.new
                     .textSet(@"Using the Boost module"))
        .tooltipSet(AATooltip.new
                    .valueDecimalsSet(@2))
        .seriesSet(@[
            AASeriesElement.new
                .dataSet(data)
                .lineWidthSet(@0.5)
        ]);

    return aaOptions;
}
    
+ (AAOptions *)areaChart {
    AAOptions *aaOptions = [self lineChart];
    aaOptions.chart.type = AAChartTypeArea;
    aaOptions.colors = @[AAColor.greenColor];
    return aaOptions;
}

+ (AAOptions *)columnChart {
    AAOptions *aaOptions = [self lineChart];
    aaOptions.chart.type = AAChartTypeColumn;
    aaOptions.colors = @[AAColor.blueColor];
    return aaOptions;
}

/**
 function getData(n) {
     const arr = [];
     let a,
         b,
         c,
         spike;
     for (let i = 0; i < n; i = i + 1) {
         if (i % 100 === 0) {
             a = 2 * Math.random();
         }
         if (i % 1000 === 0) {
             b = 2 * Math.random();
         }
         if (i % 10000 === 0) {
             c = 2 * Math.random();
         }
         if (i % 50000 === 0) {
             spike = 0;
         } else {
             spike = 0;
         }
         arr.push([
             i,
             2 * Math.sin(i / 100) + a + b + c + spike + Math.random()
         ]);
     }
     return arr;
 }

 function getSeries(n, s) {
     let i = 0;
     const r = [];

     for (; i < s; i++) {
         r.push({
             data: getData(n),
             lineWidth: 2,
             boostThreshold: 1
         });
     }

     return r;
 }

 const n = 1000,
     s = 600,
     series = getSeries(n, s);


 console.time('line');
 Highcharts.chart('container', {

     chart: {
         zooming: {
             type: 'x'
         }
     },

     title: {
         text:
             'Highcharts drawing ' + (n * s) + ' points across ' + s + ' series'
     },

     legend: {
         enabled: false
     },

     boost: {
         useGPUTranslations: true
     },

     xAxis: {
         min: 0,
         max: 120,
         ordinal: false
     },

     navigator: {
         xAxis: {
             ordinal: false,
             min: 0,
             max: 10
         }
     },

     // yAxis: {
     //     min: 0,
     //     max: 8
     // },

     subtitle: {
         text: 'Using the Boost module'
     },

     tooltip: {
         valueDecimals: 2
     },

     series: series

 });
 console.timeEnd('line');
 */
//生成 data 数组
+ (NSArray *)getData:(NSInteger)n {
    NSMutableArray *arr = [NSMutableArray array];
    CGFloat a = 0.0, b = 0.0, c = 0.0, spike;
    for (NSInteger i = 0; i < n; i = i + 1) {
        if (i % 100 == 0) {
            a = 2 * (float)arc4random_uniform(100);
        }
        if (i % 1000 == 0) {
            b = 2 * (float)arc4random_uniform(100);
        }
        if (i % 10000 == 0) {
            c = 2 * (float)arc4random_uniform(100);
        }
        if (i % 50000 == 0) {
            spike = 0;
        } else {
            spike = 0;
        }
        [arr addObject:@[
            @(i),
            @(2 * sin(i / 100) + a + b + c + spike + (float)arc4random_uniform(100))
        ]];
    }
    return arr;
}

//生成 series 数组
+ (NSArray *)getSeries:(NSInteger)n s:(NSInteger)s {
    NSMutableArray *r = [NSMutableArray array];
    for (NSInteger i = 0; i < s; i++) {
        [r addObject:@{
            @"data": [self getData:n],
            @"lineWidth": @2,
            @"boostThreshold": @1
        }];
    }
    return r;
}

//配置 AAOptions 实例对象
+ (AAOptions *)lineChartWithHundredsOfSeries {
    NSInteger n = 1000;
    NSInteger s = 600;
    NSArray *series = [self getSeries:n s:s];
    
    AAOptions *aaOptions = AAOptions.new
    .chartSet(AAChart.new
//              .zoomTypeSet(AAChartZoomTypeX)
              .pinchTypeSet(AAChartZoomTypeX)
              )
    .titleSet(AATitle.new
              .textSet([NSString stringWithFormat:@"Highcharts drawing %ld points across %ld series", n * s, s]))
    .legendSet(AALegend.new
               .enabledSet(false))
    .boostSet(AABoost.new
              .useGPUTranslationsSet(@true))
    .xAxisSet(AAXAxis.new
              .minSet(@0)
              .maxSet(@120)
//              .ordinalSet(false)
              )
//    .navigatorSet(AANavigator.new
//                  .xAxisSet(AAXAxis.new
//                            .ordinalSet(false)
//                            .minSet(@0)
//                            .maxSet(@10)))
    .subtitleSet(AASubtitle.new
                 .textSet(@"Using the Boost module"))
    .tooltipSet(AATooltip.new
                .valueDecimalsSet(@2))
    .seriesSet(series);
    
    return aaOptions;
;
}


/**
 // Prepare the data
 const data = [],
     n = 1000000;

 for (let i = 0; i < n; i += 1) {
     data.push([
         Math.pow(Math.random(), 2) * 100,
         Math.pow(Math.random(), 2) * 100
     ]);
 }

 if (!Highcharts.Series.prototype.renderCanvas) {
     throw 'Module not loaded';
 }

 console.time('scatter');
 Highcharts.chart('container', {

     chart: {
         zooming: {
             type: 'xy'
         },
         height: '100%'
     },

     boost: {
         useGPUTranslations: true,
         usePreAllocated: true
     },

     xAxis: {
         min: 0,
         max: 100,
         gridLineWidth: 1
     },

     yAxis: {
         // Renders faster when we don't have to compute min and max
         min: 0,
         max: 100,
         minPadding: 0,
         maxPadding: 0,
         title: {
             text: null
         }
     },

     title: {
         text: 'Scatter chart with ' +
             Highcharts.numberFormat(data.length, 0, ' ') + ' points'
     },

     legend: {
         enabled: false
     },

     series: [{
         type: 'scatter',
         color: 'rgb(152, 0, 67)',
         fillOpacity: 0.1,
         data: data,
         marker: {
             radius: 1
         },
         tooltip: {
             followPointer: false,
             pointFormat: '[{point.x:.1f}, {point.y:.1f}]'
         }
     }]

 });
 console.timeEnd('scatter');
 */

//配置 AAOptions 实例对象
+ (AAOptions *)scatterChartOptions {
    NSMutableArray *data = [NSMutableArray array];
    NSInteger n = 1000000;
    for (NSInteger i = 0; i < n; i += 1) {
        [data addObject:@[
            @(powf((float)arc4random_uniform(100), 2) * 100),
            @(powf((float)arc4random_uniform(100), 2) * 100)
        ]];
    }
    
    AAOptions *aaOptions = AAOptions.new
    .chartSet(AAChart.new
//              .zoomTypeSet(AAChartZoomTypeXY)
              .pinchTypeSet(AAChartZoomTypeXY)
//              .heightSet(@"100%")
              )
    .boostSet(AABoost.new
              .useGPUTranslationsSet(@true)
              .usePreallocatedSet(@true))
//    .xAxisSet(AAXAxis.new
//              .minSet(@0)
//              .maxSet(@100)
//              .gridLineWidthSet(@1))
//    .yAxisSet(AAYAxis.new
//              .minSet(@0)
//              .maxSet(@100)
//              .minPaddingSet(@0)
//              .maxPaddingSet(@0)
//              .titleSet(AAAxisTitle.new
//                        .textSet(@"")))
    .titleSet(AATitle.new
              .textSet([NSString stringWithFormat:@"Scatter chart with %ld points", (long)data.count]))
    .legendSet(AALegend.new
               .enabledSet(false))
    .seriesSet(@[
        AASeriesElement.new
        .typeSet(AAChartTypeScatter)
        .colorSet(@"rgb(152, 0, 67)")
        .fillOpacitySet(@0.1)
        .dataSet(data)
        .markerSet(AAMarker.new
                   .radiusSet(@1))
        .tooltipSet(AATooltip.new
                    .followPointerSet(false)
                    .pointFormatSet(@"[{point.x:.1f}, {point.y:.1f}]"))
    ]);
    
    return aaOptions;
}

/**
 function getData(n) {
     const arr = [];
     let a,
         b,
         c,
         low,
         spike;
     for (let i = 0; i < n; i = i + 1) {
         if (i % 100 === 0) {
             a = 2 * Math.random();
         }
         if (i % 1000 === 0) {
             b = 2 * Math.random();
         }
         if (i % 10000 === 0) {
             c = 2 * Math.random();
         }
         if (i % 50000 === 0) {
             spike = 10;
         } else {
             spike = 0;
         }
         low = 2 * Math.sin(i / 100) + a + b + c + spike + Math.random();
         arr.push([
             i,
             low,
             low + 5 + 5 * Math.random()
         ]);
     }
     return arr;
 }
 const n = 500000,
     data = getData(n);


 console.time('arearange');
 Highcharts.chart('container', {

     chart: {
         type: 'arearange',
         zooming: {
             type: 'x'
         },
         panning: true,
         panKey: 'shift'
     },

     boost: {
         useGPUTranslations: true
     },

     title: {
         text: 'Highcharts drawing ' + n + ' points'
     },

     xAxis: {
         crosshair: true
     },

     subtitle: {
         text: 'Using the Boost module'
     },

     tooltip: {
         valueDecimals: 2
     },

     series: [{
         data: data
     }]

 });
 console.timeEnd('arearange');
 */
NSArray<NSArray<NSNumber *> *> *getAreaRangeChartData(NSUInteger n) {
    NSMutableArray<NSArray<NSNumber *> *> *arr = [NSMutableArray arrayWithCapacity:n];
    double a = 0.0, b = 0.0, c = 0.0, low, spike;

    for (NSUInteger i = 0; i < n; i++) {
        if (i % 100 == 0) {
            a = 2 * arc4random_uniform(UINT32_MAX) / (double)UINT32_MAX;
        }
        if (i % 1000 == 0) {
            b = 2 * arc4random_uniform(UINT32_MAX) / (double)UINT32_MAX;
        }
        if (i % 10000 == 0) {
            c = 2 * arc4random_uniform(UINT32_MAX) / (double)UINT32_MAX;
        }
        if (i % 50000 == 0) {
            spike = 10;
        } else {
            spike = 0;
        }
        
        low = 2 * sin(i / 100.0) + a + b + c + spike + (arc4random_uniform(UINT32_MAX) / (double)UINT32_MAX);
        double high = low + 5 + 5 * (arc4random_uniform(UINT32_MAX) / (double)UINT32_MAX);

        [arr addObject:@[@(i), @(low), @(high)]];
    }

    return [arr copy];
}

//配置 AAOptions 实例对象
+ (AAOptions *)areaRangeChart {
    NSInteger n = 500000;
    NSArray *data = getAreaRangeChartData(n);
    
    AAOptions *aaOptions = AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeArearange)
//              .zoomTypeSet(AAChartZoomTypeX)
                .pinchTypeSet(AAChartZoomTypeX)
                .panningSet(true)
                .panKeySet(@"shift"))
    .boostSet(AABoost.new
              .useGPUTranslationsSet(@true))
    .titleSet(AATitle.new
              .textSet([NSString stringWithFormat:@"Highcharts drawing %ld points", n]))
    .xAxisSet(AAXAxis.new
              .crosshairSet(AACrosshair.new
                            .colorSet(AAColor.greenColor)))
    .subtitleSet(AASubtitle.new
                 .textSet(@"Using the Boost module"))
    .tooltipSet(AATooltip.new
                .valueDecimalsSet(@2))
    .colorsSet(@[AAColor.redColor])
    .seriesSet(@[
        AASeriesElement.new
        .dataSet(data)
    ]);
 
    return aaOptions;
}

//配置 AAOptions 实例对象
+ (AAOptions *)columnRangeChart {
    AAOptions *aaOptions = [self areaRangeChart];
    aaOptions.chart.type = AAChartTypeColumnrange;
    aaOptions.colors = @[AAColor.yellowColor];
    return aaOptions;
}

/**
 // Prepare the data
 const data = [],
     n = 50000;

 for (let i = 0; i < n; i += 1) {
     data.push([
         Math.pow(Math.random(), 2) * 100,
         Math.pow(Math.random(), 2) * 100,
         Math.pow(Math.random(), 2) * 100
     ]);
 }

 if (!Highcharts.Series.prototype.renderCanvas) {
     throw 'Module not loaded';
 }

 console.time('bubble');
 Highcharts.chart('container', {

     chart: {
         zooming: {
             type: 'xy'
         }
     },

     xAxis: {
         gridLineWidth: 1,
         minPadding: 0,
         maxPadding: 0,
         startOnTick: false,
         endOnTick: false
     },

     yAxis: {
         minPadding: 0,
         maxPadding: 0,
         startOnTick: false,
         endOnTick: false
     },

     title: {
         text: 'Bubble chart with ' +
             Highcharts.numberFormat(data.length, 0, ' ') + ' points'
     },

     legend: {
         enabled: false
     },

     boost: {
         useGPUTranslations: true,
         usePreallocated: true
     },

     series: [{
         type: 'bubble',
         boostBlending: 'alpha',
         color: 'rgb(152, 0, 67)',
         fillOpacity: 0.1,
         data: data,
         minSize: 1,
         maxSize: 10,
         tooltip: {
             followPointer: false,
             pointFormat: '[{point.x:.1f}, {point.y:.1f}]'
         }
     }]

 });
 console.timeEnd('bubble');
 */

//生成 bubbleChartData 数组
+ (NSArray *)getBubbleChartData:(NSInteger)n {
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < n; i += 1) {
        [arr addObject:@[
            @(powf((float)arc4random_uniform(100), 2) * 100),
            @(powf((float)arc4random_uniform(100), 2) * 100),
            @(powf((float)arc4random_uniform(100), 2) * 100)
        ]];
    }
    return arr;
}

//配置 AAOptions 实例对象
+ (AAOptions *)bubbleChart {
    NSInteger n = 50000;
    NSArray *data = [self getBubbleChartData:n];
    
    AAOptions *aaOptions = AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeBubble)
//              .zoomTypeSet(AAChartZoomTypeXY)
                .pinchTypeSet(AAChartZoomTypeXY)
              )
    .xAxisSet(AAXAxis.new
                .gridLineWidthSet(@1)
                .minPaddingSet(@0)
                .maxPaddingSet(@0)
                .startOnTickSet(false)
                .endOnTickSet(false))
    .yAxisSet(AAYAxis.new
                .minPaddingSet(@0)
                .maxPaddingSet(@0)
                .startOnTickSet(false)
                .endOnTickSet(false))
    .titleSet(AATitle.new
                .textSet([NSString stringWithFormat:@"Bubble chart with %ld points", (long)data.count]))
    .legendSet(AALegend.new
                .enabledSet(false))
    .boostSet(AABoost.new
              .useGPUTranslationsSet(@true)
              .usePreallocatedSet(@true))
    .plotOptionsSet(AAPlotOptions.new
                    .bubbleSet(AABubble.new
                               .minSizeSet(@1)
                               .maxSizeSet(@10)))
    .seriesSet(@[
        AASeriesElement.new
        .typeSet(AAChartTypeBubble)
//        .boostBlendingSet(AAChartBoostBlendingAlpha)
        .colorSet(@"rgb(152, 0, 67)")
        .fillOpacitySet(@0.1)
        .dataSet(data)
//        .minSizeSet(@1)
//        .maxSizeSet(@10)
        .tooltipSet(AATooltip.new
                    .followPointerSet(false)
                    .pointFormatSet(@"[{point.x:.1f}, {point.y:.1f}]"))
    ]);
    
    return aaOptions;
}

+ (AAOptions *)heatMapChart {
    AAOptions *aaOptions = [AAHeatmapChartComposer largeDataHeatmapChart];
    aaOptions.boostSet(AABoost.new
                       .useGPUTranslationsSet(@true));
    return aaOptions;
}

/**
 function getData(n) {
     const arr = [];
     let a,
         b,
         c,
         spike;
     for (let i = 0; i < n; i = i + 1) {
         if (i % 100 === 0) {
             a = 2 * Math.random();
         }
         if (i % 1000 === 0) {
             b = 2 * Math.random();
         }
         if (i % 10000 === 0) {
             c = 2 * Math.random();
         }
         if (i % 50000 === 0) {
             spike = 10;
         } else {
             spike = 0;
         }
         arr.push([
             i,
             2 * Math.sin(i / 100) + a + b + c + spike + Math.random()
         ]);
     }
     return arr;
 }
 const data1 = getData(25000),
     data2 = getData(25000);

 console.time('area');
 Highcharts.chart('container', {

     chart: {
         type: 'area',
         zooming: {
             type: 'x'
         }
     },

     boost: {
         useGPUTranslations: true
     },

     title: {
         text: 'Highcharts drawing ' + (data1.length + data2.length) + ' points'
     },

     subtitle: {
         text: 'Using the Boost module'
     },

     tooltip: {
         valueDecimals: 2
     },

     plotOptions: {
         area: {
             stacking: true
         }
     },

     series: [{
         data: data1
     }, {
         data: data2
     }]

 });
 console.timeEnd('area');

 */

//配置堆积面积图
+ (AAOptions *)stackingAreaChart {
    AAOptions *aaOptions = AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeArea)
//              .zoomTypeSet(AAChartZoomTypeX)
                .pinchTypeSet(AAChartZoomTypeX)
              )
    .boostSet(AABoost.new
              .useGPUTranslationsSet(@true))
    .titleSet(AATitle.new
              .textSet(@"Highcharts drawing 50000 points"))
    .subtitleSet(AASubtitle.new
                 .textSet(@"Using the Boost module"))
    .tooltipSet(AATooltip.new
                .valueDecimalsSet(@2))
    .plotOptionsSet(AAPlotOptions.new
                    .seriesSet(AASeries.new
                             .stackingSet(AAChartStackingTypePercent)))
    .colorsSet(@[
        AAColor.redColor,
        AAColor.yellowColor
    ])
    .seriesSet(@[
        AASeriesElement.new
        .dataSet(getData(25000)),
        AASeriesElement.new
        .dataSet(getData(25000))
    ]);

    return aaOptions;
}

//配置堆积柱形图
+ (AAOptions *)stackingColumnChart {
    AAOptions *aaOptions = [self stackingAreaChart];
    aaOptions.chart.typeSet(AAChartTypeColumn);
    aaOptions.colors = @[
        AAColor.greenColor,
        AAColor.purpleColor
    ];
    return aaOptions;
}

@end
