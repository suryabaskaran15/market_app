import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:marketing_app/constant/colors.dart';
import 'package:marketing_app/model/marketing_response_model.dart';
import 'package:marketing_app/pages/sinple_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MarketplaceScreen(),
    );
  }
}

class MarketplaceScreen extends StatefulWidget {
  @override
  _MarketplaceScreenState createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  final Dio _dio = Dio();
  final ScrollController _scrollController = ScrollController();
  List<MarketplaceRequest> posts = [];
  int page = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPosts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchPosts();
      }
    });
  }

  Future<void> fetchPosts() async {
    if (isLoading) return;
    setState(() => isLoading = true);
    try {
      final response = await _dio.get(
          'https://staging3.hashfame.com/api/v1/interview.mplist?page=$page');
      if (response.statusCode == 200) {
        final data = MarketplaceResponse.fromJson(response.data);
        setState(() {
          posts.addAll(data.marketplaceRequests ?? []);
          page++;
        });
      }
    } catch (e) {
      print('Error fetching posts: $e');
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Marketplace"),
        backgroundColor: Colors.redAccent,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(10), // Adjust the margin as needed
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/image.png"),
                    radius: 20,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                hintText: "Type your requirement here...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Container(
                  // width: width - 30,
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.all(2.0),
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
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 36,
                            backgroundImage: NetworkImage(
                                post.userDetails.profileImage ??
                                    'https://via.placeholder.com/150'),
                          ),
                          title: Text(
                            post.userDetails.name ?? 'Unknown',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w800,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          subtitle: Text(
                              '${post.userDetails.designation} at ${post.userDetails.company}'),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                        ),
                        // const Text('No title',
                        //     style: TextStyle(fontWeight: FontWeight.bold)),
                        // const SizedBox(height: 4),
                        // Text(post.description ?? 'No description'),
                        // const SizedBox(height: 10),
                        // const Row(
                        //   children: [
                        //     Icon(Icons.location_on,
                        //         size: 16, color: Colors.grey),
                        //     SizedBox(width: 4),
                        //     Expanded(child: Text('Unknown Location')),
                        //   ],
                        // ),
                        // const SizedBox(height: 10),
                        // Row(
                        //   children: [
                        //     ElevatedButton(
                        //       onPressed: () {
                        //         Get.to(SinglePostView());
                        //         Fluttertoast.showToast(msg: "Button Clicked");
                        //       },
                        //       child: const Text("Apply"),
                        //     )
                        //   ],
                        // )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
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
        currentIndex: 1,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.explore), label: "Explore"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.store), label: "Marketplace"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.search), label: "Search"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Activity"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
