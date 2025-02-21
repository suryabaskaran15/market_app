import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:marketing_app/components/appbar.dart';
import 'package:marketing_app/components/location.dart';
import 'package:marketing_app/components/search.dart';
import 'package:marketing_app/constant/colors.dart';
import 'package:marketing_app/model/marketing_response_model.dart';
import 'package:marketing_app/pages/single_view.dart';
import 'package:marketing_app/service/market_services.dart';
import '../utils/global_helper.dart';

class MarketplaceScreen extends StatefulWidget {
  @override
  _MarketplaceScreenState createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  final ScrollController _scrollController = ScrollController();
  final MarketServices marketServices = MarketServices();
  List<MarketplaceRequest> posts = [];
  int page = 1;
  bool isLoading = false;
  int selectedTab = 0; // Track the selected tab

  @override
  void initState() {
    super.initState();
    if (selectedTab == 1) fetchPosts();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      fetchPosts();
    }
  }

  Future<void> fetchPosts() async {
    if (isLoading) return;
    setState(() => isLoading = true);

    final response = await marketServices.getPosts(page: page);
    if (response != null && response.marketplaceRequests != null) {
      setState(() {
        posts.addAll(response.marketplaceRequests!);
        page++;
      });
    }
    setState(() => isLoading = false);
  }

  void updateTab(int index) {
    setState(() {
      selectedTab = index;
      if (selectedTab == 1 && posts.isEmpty) fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(),
      body: Column(
        children: [
          if (selectedTab == 1) // Show search only in Tab 1
            Padding(padding: const EdgeInsets.all(10), child: Search()),
          const SizedBox(height: 8),
          Expanded(
            child: selectedTab == 1
                ? _buildMarketplaceList()
                : const Center(
                    child: Text(
                      "No Items Found",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () => Fluttertoast.showToast(msg: "Post Request Clicked"),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedTab,
        onTap: updateTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(
              icon: Icon(Icons.store), label: "Marketplace"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Activity"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildMarketplaceList() {
    if (posts.isEmpty && isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (posts.isEmpty) {
      return const Center(
        child: Text(
          "No Items Found",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: posts.length + 1, // Extra item for loader
      itemBuilder: (context, index) {
        if (index == posts.length) {
          return isLoading
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox();
        }

        final post = posts[index];
        return _buildPostItem(post);
      },
    );
  }

  Widget _buildPostItem(MarketplaceRequest post) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.shadowColor.withOpacity(0.5),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: GlobalHelper.getImageProvider(
                  post.userDetails.profileImage ?? ""),
            ),
            title: Text(
              post.userDetails.name ?? 'Unknown',
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              '${post.userDetails.designation ?? ''} at ${post.userDetails.company ?? ''}',
              style: const TextStyle(color: Colors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              onPressed: () => Get.to(SinglePostView(postId: post.idHash),
                  arguments: {"id": post.idHash}),
              icon: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Looking for Influencer Marketing Agency',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 4),
                Text(
                  post.description?.trimLeft() ?? 'No description',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                if (post.requestDetails != null)
                  LocationWidget(
                    locations: post.requestDetails!.cities,
                    followers: post.requestDetails!.followersRange != null
                        ? '${post.requestDetails!.followersRange!.igFollowersMin} - ${post.requestDetails!.followersRange!.igFollowersMax}'
                        : "",
                    categories: post.requestDetails?.categories ?? [],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
