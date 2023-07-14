import 'package:flutter/material.dart';

/// extends this class to make a Flutter widget parser.
abstract class WidgetParser {
  /// parse the json map into a flutter widget.
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
  );

  /// the widget type name for example:
  /// {"type" : "Text", "data" : "Denny"}
  /// if you want to make a flutter Text widget, you should implement this
  /// method return "Text", for more details, please see
  /// @TextWidgetParser
  String get widgetName;

  /// export the runtime widget to json
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext);

  /// match current widget
  Type get widgetType;

  bool matchWidgetForExport(Widget? widget) => widget.runtimeType == widgetType;
}
