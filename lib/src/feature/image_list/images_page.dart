import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_app/src/components/network_image.dart';
import 'package:image_app/src/components/text_field.dart';
import 'package:image_app/src/feature/image_list/image_page_controller.dart';

class ImagesPage extends StatelessWidget {
  const ImagesPage({Key? key}) : super(key: key);

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
                  controller: _.scrollController,
                  itemCount: _.images.length + 1,
                  itemBuilder: (context, index) {
                    if (index < _.images.length) {
                      return InkWell(
                        onTap: (() {
                          showImageViewer(
                              context,
                              Image.network(
                                _.images[index].largeImageURL ?? "",
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  return const CircularProgressIndicator();
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    alignment: Alignment.center,
                                    color: Colors.white,
                                    child: const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                      size: 15,
                                    ),
                                  );
                                },
                              ).image,
                              swipeDismissible: true);
                        }),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                              margin: const EdgeInsets.all(20),
                              child: CustomNetworkImage(
                                  _.images[index].largeImageURL)),
                        ),
                      );
                    }
                    if (_.paginationDataLoading) {
                      return const Center(child: CircularProgressIndicator())
                          .marginAll(50);
                    }
                    if (_.isError) {
                      return Center(
                        child: TextButton(
                            onPressed: () => _.fetchPaginatedData(),
                            child: const Text("Retry")),
                      ).marginAll(50);
                    }
                    return Container();
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
