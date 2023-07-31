import 'package:flutter/material.dart';
import 'package:flutter_instagram/app/constant/constant.dart';
import 'package:flutter_instagram/app/controllers/post_controller.dart';
import 'package:get/get.dart';

class ShowCommentScreen extends StatelessWidget {
  ShowCommentScreen({super.key});

  final controller = Get.find<PostController>();
  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: GetBuilder<PostController>(
              id: "comment",
              init: controller,
              builder: (context) {
                if (controller.commentLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 8,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: controller.comments.data!.length,
                          itemBuilder: (context, index) {
                            final comment = controller.comments.data![index];
                            return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "${displayProfile}/${comment.user!.profileUrl}"),
                                ),
                                title: Text("${comment.user!.name}"),
                                subtitle: Text("${comment.text}"),
                                trailing: IconButton(
                                  onPressed: () {
                                    controller.deleteComment(
                                        cmtId: '${comment.id}', index: index);
                                  },
                                  icon: Icon(Icons.delete),
                                ));
                          }),
                    ),
                    // Spacer(),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search",
                                  prefixIcon: Icon(Icons.comment),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                controller: commentController,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.comment(
                                    postId: '${controller.currentPostId}',
                                    comment: '${commentController.text}');
                                commentController.clear();
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
