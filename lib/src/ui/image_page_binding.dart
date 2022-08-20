import 'package:get/get.dart';
import 'package:image_app/src/feature/image_list/data/image_page_repo_impl.dart';
import 'package:image_app/src/feature/image_list/image_page_controller.dart';
import 'package:image_app/src/utils/network_client.dart';

class ImagePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiClient("https://pixabay.com", false));
    Get.lazyPut(() => ImageRepoImpl(Get.find()));
    Get.lazyPut(() => ImagePageController(Get.find<ImageRepoImpl>()));
  }
}
