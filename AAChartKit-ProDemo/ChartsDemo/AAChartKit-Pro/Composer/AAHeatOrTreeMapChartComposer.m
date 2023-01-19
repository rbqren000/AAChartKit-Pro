//
//  AATreeOrHeatMapChartComposer.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import "AAHeatOrTreeMapChartComposer.h"
#import "AAChartKit-Pro.h"
#import "AAOptionsCSV.h"
#import "NSString+toPureJSString.h"
#import "AAOptionsData.h"

@implementation AAHeatOrTreeMapChartComposer


+ (AAOptions *)heatmapChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeHeatmap))
    .titleSet(AATitle.new
              .textSet(@"Sales per employee per weekday"))
    .xAxisSet(AAXAxis.new
              .visibleSet(true)
              .categoriesSet(@[
                  @"Alexander", @"Marie", @"Maximilian", @"Sophia",
                  @"Lukas", @"Maria", @"Leon", @"Anna", @"Tim", @"Laura"
                             ]))
    .yAxisSet(AAYAxis.new
              .visibleSet(true)
              .categoriesSet(@[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday"])
              .titleSet(AAAxisTitle.new
                        .textSet(@"")))
    .colorAxisSet(AAColorAxis.new
                  .minSet(@0)
                  .minColorSet(AAColor.whiteColor)
                  .maxColorSet(@"#7cb5ec"))
    .legendSet(AALegend.new
               .enabledSet(true)
               .alignSet(AAChartAlignTypeRight)
               .layoutSet(AAChartLayoutTypeVertical)
               .verticalAlignSet(AAChartVerticalAlignTypeTop)
               .ySet(@25))
    .tooltipSet(AATooltip.new
                .enabledSet(true)
                .formatterSet(@AAJSFunc(function () {
                    return '<b>' + this.series.xAxis.categories[this.point.x] + '</b> sold <br><b>' +
                        this.point.value + '</b> items on <br><b>' + this.series.yAxis.categories[this.point.y] + '</b>';
                })))
    .seriesSet(@[
        AASeriesElement.new
        .nameSet(@"Sales")
        .borderWidthSet(@1)
        .dataSet(AAOptionsData.heatmapData)
        .dataLabelsSet(AADataLabels.new
                       .enabledSet(true)
                       .colorSet(AAColor.redColor))
               ]);
}

+ (AAOptions *)tilemapChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeTilemap))
    .titleSet(AATitle.new
              .textSet(@"U.S. states by population in 2016"))
    .xAxisSet(AAXAxis.new
              .visibleSet(false))
    .yAxisSet(AAYAxis.new
              .visibleSet(false))
    .colorAxisSet(AAColorAxis.new
                  .dataClassesSet(@[
                    AADataClassesElement.new
                        .fromSet(@0)
                        .toSet(@1000000)
                        .colorSet(@"#F9EDB3")
                        .nameSet(@"< 1M"),
                    AADataClassesElement.new
                        .fromSet(@1000000)
                        .toSet(@5000000)
                        .colorSet(@"#FFC428")
                        .nameSet(@"1M - 5M"),
                    AADataClassesElement.new
                        .fromSet(@5000000)
                        .toSet(@20000000)
                        .colorSet(@"#F9EDB3")
                        .nameSet(@"5M - 20M"),
                    AADataClassesElement.new
                        .fromSet(@20000000)
                        .colorSet(@"#FF2371")
                        .nameSet(@"> 20M"),
                  ]))
    .tooltipSet(AATooltip.new
                .enabledSet(true)
                .headerFormatSet(@"")
                .valueSuffixSet(@"The population of <b> {point.name}</b> is <b>{point.value}</b>"))
    .plotOptionsSet(AAPlotOptions.new
                    .seriesSet(AASeries.new
                               .dataLabelsSet(AADataLabels.new
                                              .enabledSet(true)
                                              .formatSet(@"{point.hc-a2}")
                                              .colorSet(AAColor.whiteColor)
                                              .styleSet(AAStyle.new
                                                        .textOutlineSet(@"none")))))
    .seriesSet(@[
        AASeriesElement.new
        .nameSet(@"Height")
        .colorByPointSet(@true)
        .dataSet(AAOptionsData.tilemapData)
               ]);
}

+ (AAOptions *)treemapWithColorAxisData {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeTreemap))
    .titleSet(AATitle.new
              .textSet(@"矩形树图"))
    .colorAxisSet(AAColorAxis.new
                  .minColorSet(AAColor.whiteColor)
                  .maxColorSet(AAColor.redColor))
    .seriesSet(@[
        AASeriesElement.new
        .dataSet(AAOptionsData.treemapWithColorAxisData)
               ]);
}

+ (AAOptions *)treemapWithLevelsData {
    return AAOptions.new
    .titleSet(AATitle.new
              .textSet(@"Fruit Consumption Situation"))
    .legendSet(AALegend.new
               .enabledSet(false))
    .seriesSet(@[
        AASeriesElement.new
        .typeSet(AAChartTypeTreemap)
        .levelsSet(@[
            AALevelsElement.new
            .levelSet(@1)
            .layoutAlgorithmSet(@"sliceAndDice")
            .dataLabelsSet(AADataLabels.new
                           .enabledSet(true)
                           .alignSet(AAChartAlignTypeLeft)
                           .verticalAlignSet(AAChartVerticalAlignTypeTop)
                           .styleSet(AAStyleColorSizeWeight(AAColor.whiteColor, 15, AAChartFontWeightTypeBold)))
                   ])
        .dataSet(AAOptionsData.treemapWithLevelsData)]);
}

+ (AAOptions *)drilldownLargeDataTreemapChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeTreemap))
    .titleSet(AATitle.new
              .textSet(@"2012年，全球每10w人口死亡率"))
    .subtitleSet(AASubtitle.new
                 .textSet(@"点击下钻"))
    .plotOptionsSet(AAPlotOptions.new
                    .treemapSet(AATreemap.new
                                .allowTraversingTreeSet(true)
                                .layoutAlgorithmSet(@"squarified")))
    .seriesSet(@[
        AASeriesElement.new
        .typeSet(AAChartTypeTreemap)
        .levelsSet(@[
            AALevelsElement.new
            .levelSet(@1)
            .dataLabelsSet(AADataLabels.new
                           .enabledSet(true))
            .borderWidthSet(@3)
                   ])
        .dataSet(AAOptionsData.drilldownTreemapData)
               ]);
}

+ (AAOptions *)largeDataHeatmapChart {
    NSString *csvStr = AAOptionsCSV.csvData[@"csv"];
    return AAOptions.new
        .dataSet(AAData.new
                 .csvSet([self aa_toPureJSString2WithString:csvStr])
                 .parsedSet(@AAJSFunc(function () {
                     start = +new Date();
                 })))
        .chartSet(AAChart.new
            .typeSet(AAChartTypeHeatmap)
            .marginSet(@[@60, @10, @80, @50]))
        .titleSet(AATitle.new
            .textSet(@"大型热力图")
            .alignSet(AAChartAlignTypeLeft)
            .xSet(@40))
        .subtitleSet(AASubtitle.new
            .textSet(@"2013每天每小时的热力变化")
            .alignSet(AAChartAlignTypeLeft)
            .xSet(@40))
        .xAxisSet(AAXAxis.new
            .typeSet(AAChartAxisTypeDatetime)
            .minSet(@1356998400000)
            .maxSet(@1388534400000)
            .labelsSet(AALabels.new
                .alignSet(AAChartAlignTypeLeft)
                .xSet(@5)
                .ySet(@14)
                .formatSet(@"{value:%B}"))
//            .showLastLabelSet(false)
            .tickLengthSet(@16))
        .yAxisSet(AAYAxis.new
            .titleSet(AAAxisTitle.new
                .textSet((id)NSNull.new))
            .labelsSet(AALabels.new
                .formatSet(@"{value}:00"))
            .minPaddingSet(@0)
            .maxPaddingSet(@0)
            .startOnTickSet(false)
            .endOnTickSet(false)
            .tickPositionsSet(@[@0, @6, @12, @18, @24])
            .tickWidthSet(@1)
            .minSet(@0)
            .maxSet(@23)
            .reversedSet(true))
        .colorAxisSet(AAColorAxis.new
            .stopsSet(@[
                @[@0, @"#3060cf", ],
                @[@0.5, @"#fffbbc", ],
                @[@0.9, @"#c4463a", ],
                @[@1, @"#c4463a", ]
                ])
            .minSet(@-15)
            .maxSet(@25)
            .startOnTickSet(false)
            .endOnTickSet(false)
            .labelsSet(AALabels.new
                .formatSet(@"{value}℃"))
                      )
        .seriesSet(@[
            AAHeatmap.new
                .borderWidthSet(@0)
                .colsizeSet(@86400000)
                .tooltipSet(AATooltip.new
                    .headerFormatSet(@"Temperature")
//                    .pointFormatSet(@"{point.x:%e %b, %Y} {point.y}:00: {point.value} ℃")
            )
                .turboThresholdSet(@1.7976931348623157e+308)
            ]);
}

//    static func simpleTilemapWithHexagonTileShape() -> AAOptions {
//        AAOptions()
//            .chart(AAChart()
//                .type(.tilemap)
//                .marginTop(15)
////                .height("65%")
//            )
//            .title(AATitle()
//                .text("Idea map"))
//            .subtitle(AASubtitle()
//                .text("Hover over tiles for details"))
//            .colors([
//                "#fed",
//                "#ffddc0",
//                "#ecb",
//                "#dba",
//                "#c99",
//                "#b88",
//                "#aa7577",
//                "#9f6a66"
//            ])
//                    .xAxis(AAXAxis()
//                        .visible(false))
//                    .yAxis(AAYAxis()
//                        .visible(false))
//                    .legend(AALegend()
//                        .enabled(false))
//                    .tooltip(AATooltip()
//                        .headerFormat("")
//                        .backgroundColor("rgba(247,247,247,0.95)")
////                        .pointFormat("<span style=\"color: {point.color}\">●</span>" +
////                                     "<span style=\"font-size: 13px; font-weight: bold\"> {point.name}" +
////                                     "</span><br>{point.desc}")
//                            .style(AAStyle()
//                                .width(170))
//                                .padding(10)
//        //                        .hideDelay(1000000)
//                    )
//                    .plotOptions(AAPlotOptions()
//                        .series(AASeries()
//                            .keys(["x", "y", "name", "desc"])
//                            .tileShape(.hexagon)
//                            .dataLabels(AADataLabels()
//                                .enabled(true)
//                                .format("{point.name}")
//                                .color("#000000")
//                                .style(AAStyle()
////                                    .textOutline(false)
//                                ))))
//                    .series([
//                        AASeriesElement()
//                            .name("Main idea")
////                            .pointPadding(10)
//                            .data([
//                                [5, 3, "Main idea",
//                                 "The main idea tile outlines the overall theme of the idea map."]
//                            ])
//                            .color("#7eb"),
//                        AASeriesElement()
//                            .name("Steps")
//                            .colorByPoint(true)
//                            .data(AAOptionsData.simpleTilemapData)
//                    ])
//    }

+ (AAOptions *)simpleTilemapWithHexagonTileShape {
    return AAOptions.new
        .chartSet(AAChart.new
            .typeSet(AAChartTypeTilemap)
            .marginTopSet(@15))
        .titleSet(AATitle.new
            .textSet(@"Idea map"))
        .subtitleSet(AASubtitle.new
            .textSet(@"Hover over tiles for details"))
        .colorsSet(@[
            @"#fed",
            @"#ffddc0",
            @"#ecb",
            @"#dba",
            @"#c99",
            @"#b88",
            @"#aa7577",
            @"#9f6a66"
        ])
        .xAxisSet(AAXAxis.new
            .visibleSet(false))
        .yAxisSet(AAYAxis.new
            .visibleSet(false))
        .legendSet(AALegend.new
            .enabledSet(false))
        .tooltipSet(AATooltip.new
            .headerFormatSet(@"")
            .backgroundColorSet(@"rgba(247,247,247,0.95)")
            .styleSet(AAStyle.new
//                .widthSet(@170)
//            .paddingSet(@10)
            ))
        .plotOptionsSet(AAPlotOptions.new
            .seriesSet(AASeries.new
                .keysSet(@[@"x", @"y", @"name", @"desc"])
//                .tileShapeSet(AATileShapeTypeHexagon)
                .dataLabelsSet(AADataLabels.new
                    .enabledSet(true)
                    .formatSet(@"{point.name}")
                    .colorSet(@"#000000")
                    .styleSet(AAStyle.new
                        .textOutlineSet(false)))))
        .seriesSet(@[
            AASeriesElement.new
                .nameSet(@"Main idea")
                .dataSet(@[
                    @[@5, @3, @"Main idea",
                      @"The main idea tile outlines the overall theme of the idea map."]
                ])
                .colorSet(@"#7eb"),
            AASeriesElement.new
                .nameSet(@"Steps")
//                .colorByPointSet(true)
                .dataSet(AAOptionsData.simpleTilemapData)
        ]);
}

//    static func simpleTilemapWithCircleTileShape() -> AAOptions {
//        let aaOptions = simpleTilemapWithHexagonTileShape()
//        aaOptions.plotOptions?.series?
//                .tileShape(.circle)
//        return aaOptions
//    }
//
//    static func simpleTilemapWithDiamondTileShape() -> AAOptions {
//        let aaOptions = simpleTilemapWithHexagonTileShape()
//        aaOptions.plotOptions?.series?
//                .tileShape(.diamond)
//        return aaOptions
//    }
//
//    static func simpleTilemapWithSquareTileShape() -> AAOptions {
//        let aaOptions = simpleTilemapWithHexagonTileShape()
//        aaOptions.plotOptions?.series?
//                .tileShape(.square)
//        return aaOptions
//    }

+ (AAOptions *)simpleTilemapWithCircleTileShape {
    AAOptions *aaOptions = [self simpleTilemapWithHexagonTileShape];
    aaOptions.plotOptions.series
            .tileShapeSet(AAChartTileShapeTypeCircle);
    return aaOptions;
}

+ (AAOptions *)simpleTilemapWithDiamondTileShape {
    AAOptions *aaOptions = [self simpleTilemapWithHexagonTileShape];
    aaOptions.plotOptions.series
            .tileShapeSet(AAChartTileShapeTypeDiamond);
    return aaOptions;
}

+ (AAOptions *)simpleTilemapWithSquareTileShape {
    AAOptions *aaOptions = [self simpleTilemapWithHexagonTileShape];
    aaOptions.plotOptions.series
            .tileShapeSet(AAChartTileShapeTypeSquare);
    return aaOptions;
}


+ (NSString *)aa_toPureJSString2WithString:(NSString *)string {
    //https://stackoverflow.com/questions/34334232/why-does-function-not-work-but-function-does-chrome-devtools-node
    NSString *pureJSStr = [NSString stringWithFormat:@"(%@)",string];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\0" withString:@""];
//    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\f" withString:@"\\f"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\u2028" withString:@"\\u2028"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\u2029" withString:@"\\u2029"];
    return pureJSStr;
}

@end
