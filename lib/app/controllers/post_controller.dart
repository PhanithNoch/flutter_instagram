import 'dart:convert';
import 'dart:io';

import 'package:flutter_instagram/app/models/comment_res_model.dart';
import 'package:flutter_instagram/app/models/post_res_model.dart';
import 'package:flutter_instagram/app/services/api_helper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class PostController extends GetxController {
  final api = APIHelper();
  final box = GetStorage();
  PostResModel _posts = PostResModel();
  CommentResModel comments = CommentResModel();
  int? currentPostId;
  final _imagePicker = ImagePicker();
  File? photoPost;

  /// get,set posts
  List<DataPost> get posts => _posts.data?.data ?? [];
  bool commentLoading = false;

  @override
  void onInit() {
    // getAllPosts();
    super.onInit();
  }

  bool isLoading = false;
  void getAllPosts() async {
    isLoading = true;
    update();
    try {
      final res = await api.getAllPost();
      _posts = res;
      isLoading = false;
      update();
      update(['comment']);
    } catch (e) {
      isLoading = false;
      update();
      Get.snackbar(
        "getAllPosts",
        e.toString(),
      );
    }
  }

  void likeToggle({required String postId}) async {
    try {
      final token = box.read("access_token");
      print("token $token");
      final res = await api.likeToggle(token: token, postId: postId);
      print("like toggle ${jsonEncode(res)}");
      getAllPosts();
    } catch (e) {
      Get.snackbar(
        "likeToggle",
        e.toString(),
      );
    }
  }

  void getComment({required int postId}) async {
    try {
      commentLoading = true;
      update(['comment']);
      final res = await api.getCommentByPost(postId: postId);
      print("get comment ${jsonEncode(res)}");
      comments = res;
      commentLoading = false;
      update(['comment']);
    } catch (e) {
      commentLoading = false;
      update(['comment']);
      Get.snackbar(
        "getComment",
        e.toString(),
      );
    }
  }

  void comment({required String postId, required String comment}) async {
    try {
      final res = await api.comment(
        postId: postId,
        comment: comment,
      );
      getComment(postId: int.parse(postId));
    } catch (e) {
      Get.snackbar(
        "comment",
        e.toString(),
      );
    }
  }

  void deleteComment({required String cmtId, required int index}) async {
    try {
      final res = await api.deleteComment(cmtId: cmtId);
      if (res) {
        /// delete by index
        comments.data!.removeAt(index);
        Get.snackbar(
          "deleteComment",
          "Delete comment success",
        );
        update(['comment']);
      }
      // getAllPosts();
    } catch (e) {
      Get.snackbar(
        "deleteComment",
        e.toString(),
      );
    }
  }

  void selectPostPhoto() async {
    try {
      final pickedFile =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        photoPost = File(pickedFile.path);
        update();
        print("photo profile selected");
      } else {
        print("no photo profile selected");
      }
    } catch (e) {
      print(e);
    }
  }

  void createPost({required String caption}) async {
    try {
      await api.createPost(caption: caption, photo: photoPost!);
      // print("create post ${jsonEncode(res)}");
      Get.back(result: true);
    } catch (e) {
      Get.snackbar(
        "createPost",
        e.toString(),
      );
    }
  }

  void deletePost({required String postId}) async {
    try {
      final res = await api.deletePost(postId: postId);
      print("delete post ${jsonEncode(res)}");
      getAllPosts();
      Get.back(result: true);
    } catch (e) {
      Get.snackbar(
        "deletePost",
        e.toString(),
      );
    }
  }
}
