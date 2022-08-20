import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_app/src/components/network_image.dart';
import 'package:image_app/src/components/text_field.dart';
import 'package:image_app/src/feature/image_list/image_page_controller.dart';

class ImageListPage extends StatelessWidget {
  const ImageListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Pixabay"),
        ),
        body: Column(children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(),
            child: TextFieldType1(
                Get.find<ImagePageController>().textEditingController,
                hintText: "Search images ",
                prefixIcon: Image.asset("assets/images/search.png")),
          ),
          Expanded(
            child: GetBuilder<ImagePageController>(builder: (_) {
              if (_.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (_.isLoaded) {
                if (_.images.isEmpty) {
                  return const Center(child: Text("No Images found"));
                }
                return ListView.builder(
                  itemCount: _.images.length,
                  itemBuilder: (context, index) {
                    return AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                          margin: const EdgeInsets.all(20),
                          child: CustomNetworkImage(
                              _.images[index].largeImageURL)),
                    );
                  },
                );
              }
              if (_.isError) {
                return Center(
                  child: TextButton(
                      onPressed: () => _.fetchImages(),
                      child: const Text("Retry")),
                );
              }
              return Container();
            }),
          ),
        ]));
  }
}
