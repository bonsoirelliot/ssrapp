import 'package:elementary/elementary.dart';

class HomeScreenModel extends ElementaryModel {
  Future<Map<String, dynamic>> loadData() async {
    // final rh = RequestHandler();

    // final baseRes =
    //     BaseResponseRepository.fromJson((await rh.get<Map<String, dynamic>>(
    //   '/ssrTest/',
    // ))
    //         .data!);

    // return baseRes.data as Map<String, dynamic>;
    Future<void>.delayed(const Duration(seconds: 2));

    return <String, dynamic>{
      "con": {
        "type": "Container",
        "alignment": "center",
        "width": 100,
        "height": 100,
        "padding": "16,16,16,16",
        "child": {"type": "Text", "data": "\${hello}"},
        "decoration": {"borderRadius": "12,12,12,12", "color": "#eba834"}
      },
      "main": {
        "type": "Scaffold",
        "body": {
          "type": "Column",
          "children": [
            {
              "type": "SizedBox",
              "height": 250,
              "child": {
                "type": "PageView",
                "scrollDirection": "horizontal",
                "children": [
                  {"type": "Ref", "name": "con"},
                  {"type": "Ref", "name": "con"},
                  {"type": "Ref", "name": "con"}
                ]
              }
            },
            {"type": "Ref", "name": "con"}
          ]
        }
      }
    };
  }
}
