import 'package:flutter/material.dart';

import 'package:ssrapp/domain/parsers/dynamic_widget_builder.dart';
import 'package:ssrapp/domain/parsers/utils_parser.dart';
import 'package:ssrapp/domain/parsers/widget_parser.dart';

class AppBarWidgetParser extends WidgetParser {
  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as AppBar;

    return <String, dynamic>{
      "type": widgetName,
      "title": realWidget.title == null
          ? null
          : DynamicWidgetBuilder.export(realWidget.title, buildContext),
      "leading": realWidget.leading == null
          ? null
          : DynamicWidgetBuilder.export(realWidget.leading, buildContext),
      "actions": realWidget.actions == null
          ? null
          : DynamicWidgetBuilder.exportWidgets(
              realWidget.actions!, buildContext),
      "centerTitle": realWidget.centerTitle,
      "backgroundColor": realWidget.backgroundColor == null
          ? null
          : realWidget.backgroundColor!.value.toRadixString(16),
    };
  }

  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
  ) {
    var appBarWidget = AppBar(
      title: map.containsKey("title")
          ? DynamicWidgetBuilder.buildFromMap(
              map["title"],
              buildContext,
            )
          : null,
      leading: map.containsKey("leading")
          ? DynamicWidgetBuilder.buildFromMap(
              map["leading"],
              buildContext,
            )
          : null,
      actions: map.containsKey("actions")
          ? DynamicWidgetBuilder.buildWidgets(
              map["actions"],
              buildContext,
            )
          : null,
      centerTitle:
          map.containsKey("centerTitle") ? map["centerTitle"] as bool? : false,
      backgroundColor: map.containsKey("backgroundColor")
          ? parseHexColor(map["backgroundColor"])
          : null,
    );

    return appBarWidget;
  }

  @override
  String get widgetName => "AppBar";

  @override
  Type get widgetType => AppBar;
}
