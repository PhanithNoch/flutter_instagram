import 'package:dio/dio.dart';
import 'package:flutter_instagram/app/models/comment_res_model.dart';
import 'package:flutter_instagram/app/models/post_res_model.dart';
import 'package:flutter_instagram/app/models/user_res_profile_model.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:io';

import '../models/login_res_model.dart';

class APIHelper {
  final dio = Dio();
  final box = GetStorage();
  // String baseUrl = "http://localhost:8000/api";
  String baseUrl = "http://10.0.2.2:8000/api";

  Future<String> registerUser({
    required String name,
    required String email,
    required String password,
    File? profile,
  }) async {
    var _formData = FormData.fromMap({
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": password,
      "profile":
          profile != null ? await MultipartFile.fromFile(profile.path) : null,
    });
    final response = await dio.post(
      "$baseUrl/auth/register",
      data: _formData,
      options: Options(
        headers: {"Accept": "application/json"},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    print(response.data);
    if (response.statusCode == 200) {
      return "Success register user";
    } else {
      throw Exception("Failed to register user");
    }
  }

  Future<LoginResModel> login(
      {required String email, required String password}) async {
    try {
      final response = await dio.post(
        "$baseUrl/auth/login",
        data: {"email": email, "password": password},
        options: Options(
          headers: {"Accept": "application/json"},
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        return LoginResModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else {
        throw Exception("Failed to login");
      }
    } catch (e) {
      throw Exception("Failed to login : $e");
    }
  }

  Future<String> logout({required String accessToken}) async {
    try {
      final res = await dio.post(
        "$baseUrl/auth/logout",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $accessToken",
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      print("logout : ${res.data}");
      print("logout : ${res.statusCode}");
      if (res.statusCode == 200) {
        return "Success logout";
      } else if (res.statusCode == 401) {
        throw Exception("Unauthorized");
      } else {
        throw Exception(res.statusMessage);
      }
    } catch (e) {
      throw Exception("Failed to logout : $e");
    }
  }

  Future<UserProfileResModel> getCurrentUser({required String token}) async {
    try {
      final response = await dio.get(
        "$baseUrl/auth/me",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        return UserProfileResModel.fromJson(response.data);
      } else {
        throw Exception("Failed to login");
      }
    } catch (e) {
      throw Exception("Failed to login : $e");
    }
  }

  Future<PostResModel> getAllPost({required String token}) async {
    try {
      final response = await dio.get(
        "$baseUrl/posts",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      print("res $response");
      if (response.statusCode == 200) {
        return PostResModel.fromJson(response.data);
      } else {
        throw Exception("Failed to login");
      }
    } catch (e) {
      throw Exception("Failed to login : $e");
    }
  }

  Future<bool> likeToggle(
      {required String token, required String postId}) async {
    try {
      final response = await dio.post(
        "$baseUrl/toggleLike/$postId",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      print("res $response");
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Failed to login");
      }
    } catch (e) {
      throw Exception("Failed to login : $e");
    }
  }

  Future<CommentResModel> getCommentByPost({required int postId}) async {
    try {
      final token = box.read("access_token");
      print("token $token");
      final response = await dio.get(
        "$baseUrl/comments/$postId",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      print("res $response");
      if (response.statusCode == 200) {
        return CommentResModel.fromJson(response.data);
      } else {
        throw Exception("Failed to get comment");
      }
    } catch (e) {
      throw Exception("Failed to get comment : $e");
    }
  }

  Future<String> comment(
      {required String postId, required String comment}) async {
    try {
      final token = box.read("access_token");

      final response = await dio.post(
        "$baseUrl/comment/$postId",
        data: {"text": comment},
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      print("res $response");
      if (response.statusCode == 200) {
        return "Success comment";
      } else {
        throw Exception("Failed to login");
      }
    } catch (e) {
      throw Exception("Failed to login : $e");
    }
  }

  Future<bool> deleteComment({required String cmtId}) async {
    try {
      final token = box.read("access_token");

      final res = await dio.delete(
        "$baseUrl/comment/$cmtId",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      print("res $res");
      if (res.statusCode == 200) {
        return true;
      } else {
        throw Exception("Failed to delete comment");
      }
    } catch (e) {
      throw Exception("Failed to delete comment : $e");
    }
  }

  Future<String> createPost(
      {required String caption, required File photo}) async {
    try {
      final token = box.read("access_token");
      var _formData = FormData.fromMap({
        "title": caption,
        "photo": await MultipartFile.fromFile(photo.path,
            filename: photo.path.split("/").last),
      });
      final response = await dio.post(
        "$baseUrl/post",
        data: _formData,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        return "Post created";
      } else {
        throw Exception("Failed to login");
      }
    } catch (e) {
      throw Exception("Failed to login : $e");
    }
  }

  Future<bool> deletePost({required String postId}) async {
    try {
      final token = box.read("access_token");

      final res = await dio.delete(
        "$baseUrl/post/$postId",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      print("res $res");
      if (res.statusCode == 200) {
        return true;
      } else {
        throw Exception("Failed to delete comment");
      }
    } catch (e) {
      throw Exception("Failed to delete comment : $e");
    }
  }
}
