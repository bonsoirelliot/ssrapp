import 'package:flutter/widgets.dart';
import 'package:ssrapp/domain/parsers/dynamic_widget_builder.dart';
import 'package:ssrapp/domain/parsers/utils_parser.dart';
import 'package:ssrapp/domain/parsers/widget_parser.dart';

class ClipRRectWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
  ) {
    var radius = map['borderRadius'].toString().split(",");
    double topLeft = double.parse(radius[0]);
    double topRight = double.parse(radius[1]);
    double bottomLeft = double.parse(radius[2]);
    double bottomRight = double.parse(radius[3]);
    var clipBehaviorString = map['clipBehavior'];
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft),
          topRight: Radius.circular(topRight),
          bottomLeft: Radius.circular(bottomLeft),
          bottomRight: Radius.circular(bottomRight)),
      clipBehavior: parseClipBehavior(clipBehaviorString),
      child: DynamicWidgetBuilder.buildFromMap(
        map["child"],
        buildContext,
      ),
    );
  }

  @override
  String get widgetName => "ClipRRect";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as ClipRRect;
    // Convert [BorderRadiusGeometry] into a [BorderRadius]
    var borderRadius = realWidget.borderRadius!.resolve(
      Directionality.of(buildContext!),
    );
    return <String, dynamic>{
      "type": widgetName,
      "borderRadius":
          "${borderRadius.topLeft.x},${borderRadius.topRight.x},${borderRadius.bottomLeft.x},${borderRadius.bottomRight.x}",
      "clipBehavior": exportClipBehavior(realWidget.clipBehavior),
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Type get widgetType => ClipRRect;
}
