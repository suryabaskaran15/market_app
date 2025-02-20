import 'package:get/get.dart';
import 'package:marketing_app/model/marketing_response_model.dart';
import 'package:marketing_app/service/api_service.dart';
import 'package:marketing_app/service/market_services.dart';

class SinglePostController extends GetxController {
  final MarketServices _marketService = MarketServices();
  final Rxn<MarketplaceRequest> post =
      Rxn<MarketplaceRequest>(); // Observing post data
  final isLoading = true.obs; // Loading state

  void fetchPost(String postId) async {
    try {
      isLoading(true);
      var fetchedPost = await _marketService.getPostsById(postId);
      if (fetchedPost != null) {
        post.value = fetchedPost;
      }
    } finally {
      isLoading(false);
    }
  }
}
