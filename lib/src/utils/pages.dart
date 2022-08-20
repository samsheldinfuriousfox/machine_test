import 'package:get/get.dart';
import 'package:image_app/src/feature/image_list/image_page_binding.dart';
import 'package:image_app/src/feature/image_list/images_page.dart';

abstract class AppPages {
  static const String imageList = "/imageList";
  static const String fullScreenImage = "/fullScreenImage";
}

abstract class GetPages {
  static List<GetPage> get getPages => [
        GetPage(
            name: AppPages.imageList,
            page: () => const ImagesPage(),
            binding: ImagePageBinding()),
        GetPage(
            name: AppPages.fullScreenImage,
            page: () => const ImagesPage(),
            binding: ImagePageBinding())
      ];
}
