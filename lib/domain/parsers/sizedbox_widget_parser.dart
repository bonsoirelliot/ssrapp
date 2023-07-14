import 'package:flutter/widgets.dart';
import 'package:ssrapp/domain/parsers/dynamic_widget_builder.dart';
import 'package:ssrapp/domain/parsers/widget_parser.dart';

//Creates a box that will become as large as its parent allows.
class ExpandedSizedBoxWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
  ) {
    return SizedBox.expand(
      child: DynamicWidgetBuilder.buildFromMap(
        map["child"],
        buildContext,
      ),
    );
  }

  @override
  String get widgetName => "ExpandedSizedBox";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    throw UnimplementedError();
  }

  /// user SizedBoxWidgetParser for ExpandedSizedBox
  @override
  Type get widgetType => UnimplementedType;
}

class SizedBoxWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
  ) {
    return SizedBox(
      width: map["width"]?.toDouble(),
      height: map["height"]?.toDouble(),
      child: DynamicWidgetBuilder.buildFromMap(
        map["child"],
        buildContext,
      ),
    );
  }

  @override
  String get widgetName => "SizedBox";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as SizedBox;
    return <String, dynamic>{
      "type": "SizedBox",
      "width": realWidget.width,
      "height": realWidget.height,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Type get widgetType => SizedBox;
}

class UnimplementedType {}
