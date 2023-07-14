import 'package:flutter/material.dart';

class DataProvider extends InheritedWidget {
  const DataProvider({
    super.key,
    required super.child,
    required this.data,
  });

  final Map<String, dynamic> data;

  static DataProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DataProvider>()!;

  @override
  bool updateShouldNotify(covariant DataProvider oldWidget) =>
      data != oldWidget.data;
}
