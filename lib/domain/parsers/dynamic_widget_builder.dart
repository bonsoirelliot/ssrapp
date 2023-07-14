import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ssrapp/domain/parsers/align_widget_parser.dart';
import 'package:ssrapp/domain/parsers/appbar_widget_parser.dart';
import 'package:ssrapp/domain/parsers/button_widget_parser.dart';
import 'package:ssrapp/domain/parsers/center_widget_parser.dart';
import 'package:ssrapp/domain/parsers/container_parser.dart';
import 'package:ssrapp/domain/parsers/custom_parser.dart';
import 'package:ssrapp/domain/parsers/expanded_widget_parser.dart';
import 'package:ssrapp/domain/parsers/fittedbox_widget_parser.dart';
import 'package:ssrapp/domain/parsers/image_widget_parser.dart';
import 'package:ssrapp/domain/parsers/listtile_widget_parser.dart';
import 'package:ssrapp/domain/parsers/opacity_widget_parser.dart';
import 'package:ssrapp/domain/parsers/padding_widget_parser.dart';
import 'package:ssrapp/domain/parsers/row_column_widget_parser.dart';
import 'package:ssrapp/domain/parsers/safearea_widget_parser.dart';
import 'package:ssrapp/domain/parsers/scaffold_widget_parser.dart';
import 'package:ssrapp/domain/parsers/scrolling/listview_widget_parser.dart';
import 'package:ssrapp/domain/parsers/scrolling/pageview_widget_parser.dart';
import 'package:ssrapp/domain/parsers/sizedbox_widget_parser.dart';
import 'package:ssrapp/domain/parsers/text_parser.dart';
import 'package:ssrapp/domain/parsers/wrap_widget_parser.dart';
import 'package:ssrapp/domain/parsers/widget_parser.dart';

class DynamicWidgetBuilder {
  // static final Logger log = Logger('DynamicWidget');

  static final _parsers = [
    ContainerWidgetParser(),
    TextWidgetParser(),
    RowWidgetParser(),
    ColumnWidgetParser(),
    AssetImageWidgetParser(),
    NetworkImageWidgetParser(),
    ListViewWidgetParser(),
    PageViewWidgetParser(),
    ExpandedWidgetParser(),
    PaddingWidgetParser(),
    CenterWidgetParser(),
    AlignWidgetParser(),
    FittedBoxWidgetParser(),
    ExpandedSizedBoxWidgetParser(),
    SizedBoxWidgetParser(),
    OpacityWidgetParser(),
    WrapWidgetParser(),
    SafeAreaWidgetParser(),
    ListTileWidgetParser(),
    ScaffoldWidgetParser(),
    AppBarWidgetParser(),
    TextButtonParser(),
    CustomParser(),
  ];

  static final _widgetNameParserMap = <String, WidgetParser>{};

  static bool _defaultParserInited = false;

  // use this method for adding your custom widget parser
  static void addParser(WidgetParser parser) {
    // log.info(
    //     "add custom widget parser, make sure you don't overwirte the widget type.");
    _parsers.add(parser);
    _widgetNameParserMap[parser.widgetName] = parser;
  }

  static void initDefaultParsersIfNess() {
    if (!_defaultParserInited) {
      for (var parser in _parsers) {
        _widgetNameParserMap[parser.widgetName] = parser;
      }
      _defaultParserInited = true;
    }
  }

  static Widget? build(String json, BuildContext buildContext) {
    initDefaultParsersIfNess();
    var map = jsonDecode(json);
    // ClickListener _listener =
    //     listener == null ? new NonResponseWidgetClickListener() : listener;
    var widget = buildFromMap(map, buildContext);
    return widget;
  }

  static Widget? buildFromMap(
    Map<String, dynamic>? map,
    BuildContext buildContext,
  ) {
    initDefaultParsersIfNess();
    if (map == null) {
      return null;
    }

    if (map['main'] != null) {
      return buildFromMap(map['main'], buildContext);
    }

    String? widgetName = map['type'];
    if (widgetName == null) {
      return null;
    }
    var parser = _widgetNameParserMap[widgetName];
    if (parser != null) {
      return parser.parse(map, buildContext);
    }

    return null;
  }

  static List<Widget> buildWidgets(
      List<dynamic> values, BuildContext buildContext) {
    initDefaultParsersIfNess();
    List<Widget> rt = [];
    for (var value in values) {
      var buildFromMap2 = buildFromMap(value, buildContext);
      if (buildFromMap2 != null) {
        rt.add(buildFromMap2);
      }
    }
    return rt;
  }

  static Map<String, dynamic>? export(
      Widget? widget, BuildContext? buildContext) {
    initDefaultParsersIfNess();
    var parser = _findMatchedWidgetParserForExport(widget);
    if (parser != null) {
      return parser.export(widget, buildContext);
    }
    // log.warning(
    //     "Can't find WidgetParser for Type ${widget.runtimeType} to export.");
    return null;
  }

  static List<Map<String, dynamic>?> exportWidgets(
      List<Widget?> widgets, BuildContext? buildContext) {
    initDefaultParsersIfNess();
    List<Map<String, dynamic>?> rt = [];
    for (var widget in widgets) {
      rt.add(export(widget, buildContext));
    }
    return rt;
  }

  static WidgetParser? _findMatchedWidgetParserForExport(Widget? widget) {
    for (var parser in _parsers) {
      if (parser.matchWidgetForExport(widget)) {
        return parser;
      }
    }
    return null;
  }
}
