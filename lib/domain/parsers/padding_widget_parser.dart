import 'package:flutter/widgets.dart';
import 'package:ssrapp/domain/parsers/dynamic_widget_builder.dart';
import 'package:ssrapp/domain/parsers/utils_parser.dart';
import 'package:ssrapp/domain/parsers/widget_parser.dart';

class PaddingWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
  ) {
    return Padding(
      padding: map.containsKey("padding")
          ? parseEdgeInsetsGeometry(map["padding"])!
          : EdgeInsets.zero,
      child: DynamicWidgetBuilder.buildFromMap(
        map["child"],
        buildContext,
      ),
    );
  }

  @override
  String get widgetName => "Padding";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Padding;
    var padding = realWidget.padding as EdgeInsets;
    return <String, dynamic>{
      "type": widgetName,
      "padding": padding != null
          ? "${padding.left},${padding.top},${padding.right},${padding.bottom}"
          : null,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Type get widgetType => Padding;
}
