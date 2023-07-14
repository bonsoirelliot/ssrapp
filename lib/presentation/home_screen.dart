import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:ssrapp/domain/parsers/dynamic_widget_builder.dart';
import 'package:ssrapp/domain/providers/data_provider.dart';
import 'package:ssrapp/domain/providers/widgets_provider.dart';
import 'package:ssrapp/presentation/home_screen_wm.dart';

class HomeScreen extends ElementaryWidget<HomeScreenWM> {
  const HomeScreen({super.key}) : super(createHomeScreenWM);

  @override
  Widget build(HomeScreenWM wm) {
    return EntityStateNotifierBuilder<Map<String, dynamic>>(
      listenableEntityState: wm.data,
      loadingBuilder: (_, __) => const Center(
        child: CircularProgressIndicator(),
      ),
      builder: (_, code) {
        return _Body(
            // code: code!,
            // data: const <String, dynamic>{
            //   'hello': 'это данные1',
            // },
            );
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    super.key,
    // required this.code,
    // required this.data,
  });

  // final Map<String, dynamic> code;
  // final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    // return WidgetsProvider(
    //   widgets: code,
    //   child: Builder(
    //     builder: (_) {
    //       return DataProvider(
    //         data: data,
    //         child: Builder(
    //           builder: (_) {
    //             return DynamicWidgetBuilder.buildFromMap(
    //                   code,
    //                   _,
    //                 ) ??
    //                 const SizedBox();
    //           },
    //         ),
    //       );
    //     },
    //   ),
    // );
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 250,
            child: PageView.builder(
              itemBuilder: (_, i) => Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              itemCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}
