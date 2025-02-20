import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:marketing_app/components/highlight.dart';
import 'package:marketing_app/controller/single_post_controller.dart';
import 'package:marketing_app/model/marketing_response_model.dart';

class SinglePostView extends StatelessWidget {
  final String postId;

  SinglePostView({required this.postId});

  @override
  Widget build(BuildContext context) {
    final SinglePostController controller = Get.put(SinglePostController());
    controller.fetchPost(postId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon:
                const Icon(Icons.delete_outlined, size: 40, color: Colors.red),
            onPressed: () {
              // Handle delete action
            },
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                colors: [Colors.orange, Colors.pink],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Icon(Icons.share, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (controller.post.value == null) {
            return const Center(child: CircularProgressIndicator());
          }
          final post = controller.post.value!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Info Row
              Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage("assets/image.png"),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              post.userDetails?.name ?? "",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const Icon(Icons.verified,
                                color: Colors.blue, size: 18),
                          ],
                        ),
                        Text(
                          post.userDetails?.designation ?? "",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                        Text("1d ago",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600])),
                      ],
                    ),
                  ),
                  const Icon(Icons.more_vert, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 16),

              // Looking For Section
              const Text(
                "Looking for",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w100,
                    color: Colors.grey),
              ),
              const Row(
                children: [
                  Image(
                    image: AssetImage("assets/image.png"),
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Influencer marketing agency",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Budget & Brand Highlights
              Row(
                children: [
                  Chip(
                    label: Text("₹ Budget: ${"500"}"),
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.transparent),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Chip(
                    label: Text("Brand: ${"Swiggy"}"),
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.transparent),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Job Details
              Text(
                post.description?.trimLeft() ?? 'No description',
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w100,
                    height: 1.5),
              ),

              const SizedBox(height: 12),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade100,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        Fluttertoast.showToast(msg: "Shared on WhatsApp");
                      },
                      icon: const Icon(Icons.abc),
                      label: const Text(
                        "Share via WhatsApp",
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade100,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        Fluttertoast.showToast(msg: "Shared on LinkedIn");
                      },
                      icon: const Icon(Icons.share),
                      label: const Text(
                        "Share on LinkedIn",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Key Highlighted Details
              const Text(
                "Key Highlighted Details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              RequestDetailsWidget(
                  details: RequestDetails(
                cities: ["Bangalore", "Tamilnadu", "Kerala", "Goa"],
                followersRange: FollowersRange(
                    igFollowersMin: "500k", igFollowersMax: "1M"),
                categories: ["Lifestyle", "Fashion"],
                languages: ["Hindi", "Kannada", "Malayalam", "Tamil", "Telugu"],
                platform: ["Instagram", "Youtube"],
              )),

              const SizedBox(height: 16),

              // Expiration Notice
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.grey[700]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Your post will expire on 26 July",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Edit & Close Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        Fluttertoast.showToast(msg: "Post Closed");
                      },
                      child: const Text("Close"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        Fluttertoast.showToast(msg: "Edit Post");
                      },
                      child: const Text("Edit"),
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
