import 'package:flutter/material.dart';

class MarketplaceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Info
              Row(
                children: [
                  // CircleAvatar(
                  //   radius: 24,
                  //   backgroundImage: NetworkImage(
                  //       "https://your-profile-image-url.com"), // Replace with actual image
                  // ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Angel Rosser",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Sales Manager at Meesho",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey)
                ],
              ),
              SizedBox(height: 10),

              // Request Title
              Row(
                children: [
                  Icon(Icons.campaign, color: Colors.red, size: 16),
                  SizedBox(width: 6),
                  Text(
                    "Looking for Influencer marketing agency",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.red),
                  ),
                ],
              ),
              SizedBox(height: 8),

              // Request Details
              Text(
                "Budget: ₹1,50,000\n"
                "Brand: WanderFit Luggage\n"
                "Location: Goa & Kerala\n"
                "Type: Lifestyle & Adventure travel content\n"
                "with a focus on young, urban audiences\n"
                "Language: English and Hindi\n\n"
                "Looking for a travel influencer who can showcase our premium luggage line in scenic beach and nature destinations. Content should emphasize ease of travel and durability of the product.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              SizedBox(height: 10),

              // Tags
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.grey[700]),
                  SizedBox(width: 4),
                  Text(
                    "Bangalore, Tamilnadu, Kerala +1more",
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                ],
              ),
              SizedBox(height: 8),

              Row(
                children: [
                  Icon(Icons.groups, size: 16, color: Colors.grey[700]),
                  SizedBox(width: 4),
                  Text(
                    "10k - 100k",
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.style, size: 16, color: Colors.grey[700]),
                  SizedBox(width: 4),
                  Text(
                    "Lifestyle, Fashion",
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
