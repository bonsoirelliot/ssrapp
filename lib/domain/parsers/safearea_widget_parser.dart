import 'package:flutter/widgets.dart';
import 'package:ssrapp/domain/parsers/dynamic_widget_builder.dart';
import 'package:ssrapp/domain/parsers/utils_parser.dart';
import 'package:ssrapp/domain/parsers/widget_parser.dart';

class SafeAreaWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
  ) {
    var left = map.containsKey("left") ? map["left"] : true;
    var right = map.containsKey("right") ? map["right"] : true;
    var top = map.containsKey("top") ? map["top"] : true;
    var bottom = map.containsKey("bottom") ? map["bottom"] : true;
    var edgeInsets = map.containsKey("minimum")
        ? parseEdgeInsetsGeometry(map['minimum'])!
        : EdgeInsets.zero;
    var maintainBottomViewPadding = map.containsKey("maintainBottomViewPadding")
        ? map["maintainBottomViewPadding"]
        : false;
    return SafeArea(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      minimum: edgeInsets as EdgeInsets,
      maintainBottomViewPadding: maintainBottomViewPadding,
      child: DynamicWidgetBuilder.buildFromMap(
        map["child"],
        buildContext,
      )!,
    );
  }

  @override
  String get widgetName => "SafeArea";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as SafeArea;
    var minimum = realWidget.minimum;
    return <String, dynamic>{
      "type": "SafeArea",
      "left": realWidget.left,
      "right": realWidget.right,
      "top": realWidget.top,
      "bottom": realWidget.bottom,
      "minimum": minimum != null
          ? "${minimum.left},${minimum.top},${minimum.right},${minimum.bottom}"
          : null,
      "maintainBottomViewPadding": realWidget.maintainBottomViewPadding,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Type get widgetType => SafeArea;
}
