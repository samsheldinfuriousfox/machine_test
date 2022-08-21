import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_app/src/feature/image_list/data/models/data_model.dart';
import 'package:image_app/src/feature/image_list/data/models/model.dart';
import 'package:image_app/src/feature/image_list/domain/image_page_repo.dart';

class ImagePageController extends GetxController {
  final ImageRepo _imageRepo;
  ImagePageController(this._imageRepo);
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<Hits> images = [];

  RxString query = "".obs;
  @override
  void onInit() {
    textEditingController.addListener(() {
      query.value = textEditingController.text;
    });
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        fetchPaginatedData();
      }
    });
    super.onInit();
    debounce(query, ((callback) {
      fetchImages();
    }), time: const Duration(milliseconds: 500));
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }

  int page = 1;
  fetchImages() async {
    if (query.value.isEmpty) return;
    images = [];
    page = 1;
    _changeStatus(true, false, false);

    Either<EmptyResponseModel, DataModel?> result =
        await _imageRepo.fetchImages(query.value, page);
    result.fold((l) {
      _changeStatus(false, false, true);
    }, (r) {
      if (r == null) {
        _changeStatus(false, false, true);
      } else {
        images = r.hits ?? [];
        page++;
        _changeStatus(false, true, false);
      }
    });
  }

  fetchPaginatedData() async {
    _changePaginationStatus(true, false, false);

    Either<EmptyResponseModel, DataModel?> result =
        await _imageRepo.fetchImages(query.value, page);
    result.fold((l) {
      _changePaginationStatus(false, false, true);
    }, (r) {
      if (r == null) {
        _changePaginationStatus(false, false, true);
      } else {
        images.addAll(r.hits ?? <Hits>[]);
        page++;

        _changePaginationStatus(false, true, false);
      }
    });
  }

  bool isLoading = false;
  bool isLoaded = false;
  bool isError = false;
  _changeStatus(bool loading, bool loaded, bool error) {
    isLoading = loading;
    isLoaded = loaded;
    isError = error;
    update();
  }

  bool paginationDataLoading = false;
  bool paginationDataLoaded = false;
  bool paginationDataError = false;
  _changePaginationStatus(bool loading, bool loaded, bool error) {
    paginationDataLoading = loading;
    paginationDataLoaded = loaded;
    paginationDataError = error;
    update();
  }
}
