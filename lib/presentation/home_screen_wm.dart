import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:ssrapp/domain/services/executor.dart';
import 'package:ssrapp/presentation/home_screen.dart';
import 'package:ssrapp/presentation/home_screen_model.dart';

class HomeScreenWM extends WidgetModel<HomeScreen, HomeScreenModel> {
  HomeScreenWM(super.model);

  final _data = EntityStateNotifier<Map<String, dynamic>>();

  ListenableState<EntityState<Map<String, dynamic>>> get data => _data;

  @override
  void initWidgetModel() {
    loadData();
    super.initWidgetModel();
  }

  void doStuff() {
    debugPrint('ВОТ ЭТО ПРИКОЛ!!1');
  }

  Future<void> loadData() async {
    await execute(
      model.loadData,
      before: _data.loading,
      onSuccess: (str) {
        _data.content(str!);
      },
      onError: _data.error,
    );
  }
}

HomeScreenWM createHomeScreenWM(BuildContext _) =>
    HomeScreenWM(HomeScreenModel());
