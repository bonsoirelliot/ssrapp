import 'package:flutter/widgets.dart';
import 'package:ssrapp/domain/parsers/dynamic_widget_builder.dart';
import 'package:ssrapp/domain/parsers/widget_parser.dart';

class PageViewWidgetParser extends WidgetParser {
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext) {
    var scrollDirection = Axis.vertical;

    if (map.containsKey("scrollDirection") &&
        "horizontal" == map["scrollDirection"]) {
      scrollDirection = Axis.horizontal;
    }

    return PageView(
      scrollDirection: scrollDirection,
      reverse: map.containsKey("reverse") ? map["reverse"] : false,
      pageSnapping:
          map.containsKey("pageSnapping") ? map["pageSnapping"] : true,
      children: DynamicWidgetBuilder.buildWidgets(
        map['children'],
        buildContext,
      ),
    );
  }

  @override
  String get widgetName => "PageView";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as PageView;
    String scrollDirection = "vertical";
    if (realWidget.scrollDirection == Axis.horizontal) {
      scrollDirection = "horizontal";
    }
    var children = realWidget.childrenDelegate as SliverChildListDelegate;
    return <String, dynamic>{
      "type": "PageView",
      "scrollDirection": scrollDirection,
      "reverse": realWidget.reverse,
      "pageSnapping": realWidget.pageSnapping,
      "children":
          DynamicWidgetBuilder.exportWidgets(children.children, buildContext)
    };
  }

  @override
  Type get widgetType => PageView;
}
