import 'package:flutter/material.dart';
import 'package:ssrapp/domain/providers/widgets_provider.dart';
import 'package:ssrapp/domain/parsers/dynamic_widget_builder.dart';
import 'package:ssrapp/domain/parsers/widget_parser.dart';

class CustomParser extends WidgetParser {
  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    return null;
  }

  @override
  bool matchWidgetForExport(Widget? widget) => widget.runtimeType == widgetType;

  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
  ) =>
      DynamicWidgetBuilder.buildFromMap(
        WidgetsProvider.of(buildContext).widgets[map['name']],
        buildContext,
      )!;

  @override
  String get widgetName => 'Ref';

  @override
  Type get widgetType => Widget;
}
