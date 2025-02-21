import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:marketing_app/components/highlight.dart';
import 'package:marketing_app/controller/single_post_controller.dart';
import 'package:marketing_app/model/marketing_response_model.dart';
import 'package:marketing_app/utils/global_helper.dart';

class SinglePostView extends StatelessWidget {
  final String postId;

  SinglePostView({required this.postId});

  @override
  Widget build(BuildContext context) {
    final SinglePostController controller = Get.put(SinglePostController());
    controller.fetchPost(postId);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.post.value == null) {
          return const Center(child: Text("No Data Available"));
        }
        return Padding(
          padding: const EdgeInsets.all(16),
          child: GetBuilder<SinglePostController>(
            builder: (controller) {
              final post = controller.post.value;
              if (post == null)
                return const Center(child: CircularProgressIndicator());

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildUserInfo(post),
                    const SizedBox(height: 16),
                    _buildSectionTitle("Looking for"),
                    _buildHighlightText("Influencer marketing agency"),
                    const SizedBox(height: 12),
                    _buildChips(["₹ Budget: 500", "Brand: Swiggy"]),
                    const SizedBox(height: 12),
                    _buildDescription(post.description),
                    const SizedBox(height: 12),
                    _buildActionButtons(),
                    const SizedBox(height: 16),
                    _buildSectionTitle("Key Highlighted Details"),
                    const SizedBox(height: 8),
                    _buildKeyHighlights(),
                    const SizedBox(height: 16),
                    _buildExpirationNotice(),
                    const SizedBox(height: 12),
                    _buildFooterButtons(),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.delete_outlined, size: 40, color: Colors.red),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
        _buildGradientIcon(Icons.share),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildUserInfo(MarketplaceRequest post) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: GlobalHelper.getImageProvider(
              post.userDetails.profileImage ?? ""),
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
                  const Icon(Icons.verified, color: Colors.blue, size: 18),
                ],
              ),
              Text(
                post.userDetails?.designation ?? "",
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              Text("1d ago",
                  style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
        ),
        const Icon(Icons.more_vert, color: Colors.grey),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
    );
  }

  Widget _buildHighlightText(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  Widget _buildChips(List<String> labels) {
    return Row(
      children: labels
          .map(
            (label) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Chip(
                label: Text(label),
                backgroundColor: Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildDescription(String? description) {
    return Text(
      description?.trimLeft() ?? 'No description',
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        _buildElevatedButton(
          "Share via WhatsApp",
          Icons.abc,
          Colors.green.shade100,
          Colors.green,
          () => Fluttertoast.showToast(msg: "Shared on WhatsApp"),
        ),
        const SizedBox(width: 8),
        _buildElevatedButton(
          "Share on LinkedIn",
          Icons.share,
          Colors.blue.shade100,
          Colors.blue,
          () => Fluttertoast.showToast(msg: "Shared on LinkedIn"),
        ),
      ],
    );
  }

  Widget _buildKeyHighlights() {
    return RequestDetailsWidget(
      details: RequestDetails(
        cities: ["Bangalore", "Tamilnadu", "Kerala", "Goa"],
        followersRange:
            FollowersRange(igFollowersMin: "500k", igFollowersMax: "1M"),
        categories: ["Lifestyle", "Fashion"],
        languages: ["Hindi", "Kannada", "Malayalam", "Tamil", "Telugu"],
        platform: ["Instagram", "Youtube"],
      ),
    );
  }

  Widget _buildExpirationNotice() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Expanded(
            child: Text("Your post will expire on 26 July",
                style: TextStyle(color: Colors.grey[700])),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterButtons() {
    return Row(
      children: [
        _buildElevatedButton(
            "Close", Icons.close, Colors.redAccent, Colors.white, () {
          Fluttertoast.showToast(msg: "Post Closed");
        }),
        const SizedBox(width: 8),
        _buildElevatedButton("Edit", Icons.edit, Colors.orange, Colors.white,
            () {
          Fluttertoast.showToast(msg: "Edit Post");
        }),
      ],
    );
  }

  Widget _buildElevatedButton(
    String text,
    IconData icon,
    Color backgroundColor,
    Color textColor,
    VoidCallback onPressed,
  ) {
    return Expanded(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        icon: Icon(icon, color: textColor),
        label: Text(text, style: TextStyle(color: textColor)),
      ),
    );
  }

  Widget _buildGradientIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [Colors.orange, Colors.pink],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}
