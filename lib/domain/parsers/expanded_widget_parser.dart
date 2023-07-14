import 'package:flutter/widgets.dart';
import 'package:ssrapp/domain/parsers/dynamic_widget_builder.dart';
import 'package:ssrapp/domain/parsers/widget_parser.dart';

class ExpandedWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
  ) {
    return Expanded(
      flex: map.containsKey("flex") ? map["flex"] : 1,
      child: DynamicWidgetBuilder.buildFromMap(map["child"], buildContext)!,
    );
  }

  @override
  String get widgetName => "Expanded";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Expanded;
    return <String, dynamic>{
      "type": widgetName,
      "flex": realWidget.flex,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Type get widgetType => Expanded;
}
