import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ssrapp/domain/parsers/dynamic_widget_builder.dart';
import 'package:ssrapp/domain/parsers/utils_parser.dart';
import 'package:ssrapp/domain/parsers/widget_parser.dart';

class ScaffoldWidgetParser extends WidgetParser {
  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Scaffold;

    return <String, dynamic>{
      "type": widgetName,
      "body": DynamicWidgetBuilder.export(realWidget.body, buildContext),
      "appBar": DynamicWidgetBuilder.export(realWidget.appBar, buildContext),
      "floatingActionButton": DynamicWidgetBuilder.export(
          realWidget.floatingActionButton, buildContext),
      "backgroundColor": realWidget.backgroundColor != null
          ? realWidget.backgroundColor!.value.toRadixString(16)
          : null,
    };
  }

  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
  ) {
    var scaffoldWidget = Scaffold(
      appBar: map.containsKey("appBar")
          ? DynamicWidgetBuilder.buildFromMap(
              map["appBar"],
              buildContext,
            ) as PreferredSizeWidget?
          : null,
      body: map.containsKey("body")
          ? DynamicWidgetBuilder.buildFromMap(
              map["body"],
              buildContext,
            )
          : null,
      floatingActionButton: map.containsKey("floatingActionButton")
          ? DynamicWidgetBuilder.buildFromMap(
              map["floatingActionButton"],
              buildContext,
            )
          : null,
      backgroundColor: map.containsKey("backgroundColor")
          ? parseHexColor(map["backgroundColor"])
          : null,
    );

    return scaffoldWidget;
  }

  @override
  String get widgetName => "Scaffold";

  @override
  Type get widgetType => Scaffold;
}
