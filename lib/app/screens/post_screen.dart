import 'package:flutter/material.dart';
import 'package:flutter_instagram/app/constant/constant.dart';
import 'package:flutter_instagram/app/controllers/post_controller.dart';
import 'package:flutter_instagram/app/controllers/profile_controller.dart';
import 'package:flutter_instagram/app/screens/select_photo_screen.dart';
import 'package:flutter_instagram/app/screens/show_comment_screen.dart';
import 'package:flutter_instagram/app/utils/date_util.dart';
import 'package:get/get.dart';

class PostScreen extends StatelessWidget {
  PostScreen({super.key});
  final controller = Get.find<PostController>();
  TextStyle style =
      TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            GetBuilder<ProfileController>(
              init: ProfileController(),
              builder: (con) {
                if (con.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                print("$displayProfile/${con.currentUser.profileUrl}");
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                            "$displayProfile/${con.currentUser.profileUrl}"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "What's on your mind?",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.dialog(
                      SelectPhotoScreen(),
                    ).then((value) {
                      if (value != null) {
                        controller.getAllPosts();
                      }
                    });
                    // Get.to(
                    //   () => SelectPhotoScreen(),
                    //   transition: Transition.rightToLeft,
                    // );
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.photo,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Photo",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.video_call,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Live",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
                ),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            GetBuilder<PostController>(
              builder: (_) {
                if (controller.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (controller.posts.isEmpty) {
                  return Center(
                    child: Text("No posts"),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    key: PageStorageKey("post"),
                    itemCount: controller.posts.length,
                    itemBuilder: (context, index) {
                      final post = controller.posts[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "${displayProfile}/${post.user!.profileUrl}"),
                            ),
                            title: Text("${post.user!.name}"),
                            subtitle: Text(
                                "${DateUtil.convertToAgo(DateTime.parse(post.createdAt!))}"),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.more_horiz),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text("${post.title}"),
                          ),
                          SizedBox(height: 10),
                          post.imageUrl != null
                              ? Image.network(
                                  "${displayPost}/${post.imageUrl}",
                                  width: double.infinity,
                                  height: 300,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: double.infinity,
                                  height: 300,
                                  child: Text("No image"),
                                  alignment: Alignment.center,
                                ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${post.likesCount} likes",
                                  style: style,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (post.commentsCount == 0) return;
                                    controller.currentPostId = post.id;
                                    controller.getComment(
                                      postId: post.id!,
                                    );
                                    // Get.to(() => ShowCommentScreen());
                                    // show ShowCommentScreen as bottom sheet
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return ShowCommentScreen();
                                      },
                                    );
                                  },
                                  child: Text(
                                    "${post.commentsCount} Comments",
                                    style: style,
                                  ),
                                ),
                                Text(
                                  "20 Shares",
                                  style: style,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.likeToggle(
                                    postId: post.id.toString(),
                                  );
                                },
                                icon: post.liked!
                                    ? Icon(
                                        Icons.thumb_up,
                                        color: Colors.blue,
                                      )
                                    : Icon(Icons.thumb_up_outlined),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.currentPostId = post.id;
                                  controller.getComment(
                                    postId: post.id!,
                                  );
                                  // Get.to(() => ShowCommentScreen());
                                  // show ShowCommentScreen as bottom sheet
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return ShowCommentScreen();
                                    },
                                  );
                                },
                                icon: Icon(Icons.comment),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.share),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
