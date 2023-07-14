import 'package:flutter/widgets.dart';
import 'package:ssrapp/domain/parsers/dynamic_widget_builder.dart';
import 'package:ssrapp/domain/parsers/utils_parser.dart';
import 'package:ssrapp/domain/parsers/widget_parser.dart';


class AlignWidgetParser extends WidgetParser {
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext) {
    return Align(
      alignment: map.containsKey("alignment")
          ? parseAlignment(map["alignment"])!
          : Alignment.center,
      widthFactor: map.containsKey("widthFactor")
          ? map["widthFactor"]?.toDouble()
          : null,
      heightFactor: map.containsKey("heightFactor")
          ? map["heightFactor"]?.toDouble()
          : null,
      child: DynamicWidgetBuilder.buildFromMap(map["child"], buildContext),
    );
  }

  @override
  String get widgetName => "Align";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Align;
    Map<String, dynamic> json = {
      "type": widgetName,
      "alignment": exportAlignment(realWidget.alignment as Alignment?),
      "widthFactor": realWidget.widthFactor,
      "heightFactor": realWidget.heightFactor,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
    return json;
  }

  @override
  Type get widgetType => Align;
}
