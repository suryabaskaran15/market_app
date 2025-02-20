class MarketplaceResponse {
  final bool ok;
  final List<MarketplaceRequest> marketplaceRequests;
  final Pagination pagination;

  MarketplaceResponse({
    required this.ok,
    required this.marketplaceRequests,
    required this.pagination,
  });

  factory MarketplaceResponse.fromJson(Map<String, dynamic> json) {
    return MarketplaceResponse(
      ok: json['ok'],
      marketplaceRequests: (json['marketplace_requests'] as List)
          .map((item) => MarketplaceRequest.fromJson(item))
          .toList(),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class MarketplaceRequest {
  final String idHash;
  final UserDetails userDetails;
  final bool isHighValue;
  final String createdAt;
  final String description;
  final String status;
  final String serviceType;
  final String targetAudience;
  final bool isOpen;
  final bool isPanIndia;
  final bool anyLanguage;
  final bool isDealClosed;
  final String slug;
  final RequestDetails? requestDetails;

  MarketplaceRequest({
    required this.idHash,
    required this.userDetails,
    required this.isHighValue,
    required this.createdAt,
    required this.description,
    required this.status,
    required this.serviceType,
    required this.targetAudience,
    required this.isOpen,
    required this.isPanIndia,
    required this.anyLanguage,
    required this.isDealClosed,
    required this.slug,
    this.requestDetails,
  });

  factory MarketplaceRequest.fromJson(Map<String, dynamic> json) {
    return MarketplaceRequest(
      idHash: json['id_hash'],
      userDetails: UserDetails.fromJson(json['user_details']),
      isHighValue: json['is_high_value'],
      createdAt: json['created_at'],
      description: json['description'],
      status: json['status'],
      serviceType: json['service_type'],
      targetAudience: json['target_audience'],
      isOpen: json['is_open'],
      isPanIndia: json['is_pan_india'],
      anyLanguage: json['any_language'],
      isDealClosed: json['is_deal_closed'],
      slug: json['slug'],
      requestDetails: json['request_details'] != null
          ? RequestDetails.fromJson(json['request_details'])
          : null,
    );
  }
}

class UserDetails {
  final String name;
  final String? profileImage;
  final String company;
  final String designation;

  UserDetails({
    required this.name,
    required this.profileImage,
    required this.company,
    required this.designation,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      name: json['name'],
      profileImage: json['profile_image'],
      company: json['company'],
      designation: json['designation'],
    );
  }
}

class RequestDetails {
  final List<String> cities;
  final FollowersRange? followersRange;
  final List<String> categories;
  final List<String> languages;
  final List<String> platform;

  RequestDetails({
    required this.cities,
    required this.followersRange,
    required this.categories,
    required this.languages,
    required this.platform,
  });

  // Factory method to create an instance from JSON
  factory RequestDetails.fromJson(Map<String, dynamic> json) {
    return RequestDetails(
      cities: List<String>.from(json['cities'] ?? []),
      followersRange: json['followers_range'] != null
          ? FollowersRange.fromJson(json['followers_range'])
          : null,
      categories: List<String>.from(json['categories'] ?? []),
      languages: List<String>.from(json['languages'] ?? []),
      platform: List<String>.from(json['platform'] ?? []),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'cities': cities,
      'followers_range': followersRange?.toJson(),
      'categories': categories,
      'languages': languages,
      'platform': platform,
    };
  }
}

class FollowersRange {
  final String igFollowersMin;
  final String igFollowersMax;

  FollowersRange({
    required this.igFollowersMin,
    required this.igFollowersMax,
  });

  factory FollowersRange.fromJson(Map<String, dynamic> json) {
    return FollowersRange(
      igFollowersMin: json['ig_followers_min'] ?? '',
      igFollowersMax: json['ig_followers_max'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ig_followers_min': igFollowersMin,
      'ig_followers_max': igFollowersMax,
    };
  }
}

class Pagination {
  final bool hasMore;
  final int total;
  final int count;
  final int perPage;
  final int currentPage;
  final int totalPages;
  final String? nextPageUrl;
  final String? previousPageUrl;
  final String url;

  Pagination({
    required this.hasMore,
    required this.total,
    required this.count,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
    this.nextPageUrl,
    this.previousPageUrl,
    required this.url,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      hasMore: json['has_more'],
      total: json['total'],
      count: json['count'],
      perPage: json['per_page'],
      currentPage: json['current_page'],
      totalPages: json['total_pages'],
      nextPageUrl: json['next_page_url'],
      previousPageUrl: json['previous_page_url'],
      url: json['url'],
    );
  }
}
