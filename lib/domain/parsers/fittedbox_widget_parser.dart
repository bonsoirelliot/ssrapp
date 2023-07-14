import 'package:flutter/widgets.dart';
import 'package:ssrapp/domain/parsers/dynamic_widget_builder.dart';
import 'package:ssrapp/domain/parsers/utils_parser.dart';
import 'package:ssrapp/domain/parsers/widget_parser.dart';

class FittedBoxWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
  ) {
    return FittedBox(
      alignment: map.containsKey("alignment")
          ? parseAlignment(map["alignment"])!
          : Alignment.center,
      fit: map.containsKey("fit") ? parseBoxFit(map["fit"])! : BoxFit.contain,
      child: DynamicWidgetBuilder.buildFromMap(map["child"], buildContext),
    );
  }

  @override
  String get widgetName => "FittedBox";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as FittedBox;
    return <String, dynamic>{
      "type": widgetName,
      "alignment": exportAlignment(realWidget.alignment as Alignment?),
      "fit": exportBoxFit(realWidget.fit),
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Type get widgetType => FittedBox;
}
