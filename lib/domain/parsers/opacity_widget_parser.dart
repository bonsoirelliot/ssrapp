import 'package:flutter/widgets.dart';
import 'package:ssrapp/domain/parsers/dynamic_widget_builder.dart';
import 'package:ssrapp/domain/parsers/widget_parser.dart';
class OpacityWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
  ) {
    return Opacity(
      opacity: map["opacity"]?.toDouble(),
      alwaysIncludeSemantics: map.containsKey("alwaysIncludeSemantics")
          ? map["alwaysIncludeSemantics"]
          : false,
      child: DynamicWidgetBuilder.buildFromMap(map["child"], buildContext),
    );
  }

  @override
  String get widgetName => "Opacity";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Opacity;
    return <String, dynamic>{
      "type": widgetName,
      "opacity": realWidget.opacity,
      "alwaysIncludeSemantics": realWidget.alwaysIncludeSemantics,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Type get widgetType => Opacity;
}
