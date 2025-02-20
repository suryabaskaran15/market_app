import 'package:marketing_app/model/marketing_response_model.dart';
import 'package:marketing_app/service/api_service.dart';

class MarketServices extends ApiService {
  Future<MarketplaceResponse?> getPosts({int page = 1}) async {
    final response = await apiRequest(
        path: "/interview.mplist?page=$page",
        fromJson: MarketplaceResponse.fromJson);
    return response;
  }

  Future<MarketplaceRequest?> getPostsById(String id) async {
    final response = await apiRequest(
        path: "/interview.mplist?id_hash=$id",
        fromJson: (json) =>
            MarketplaceRequest.fromJson(json["web_marketplace_requests"]));
    return response;
  }
}
