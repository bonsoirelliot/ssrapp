import 'package:flutter/widgets.dart';

class WidgetsProvider extends InheritedWidget {
  const WidgetsProvider({
    required super.child,
    required this.widgets,
    super.key,
  });

  final Map<String, dynamic> widgets;

  static WidgetsProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WidgetsProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant WidgetsProvider oldWidget) {
    return widgets != oldWidget.widgets;
  }
}
