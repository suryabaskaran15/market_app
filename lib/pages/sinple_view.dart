import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SinglePostView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Single Post View"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Row
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150'), // Replace with real image URL
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Angel Rosser ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.verified, color: Colors.blue, size: 18),
                        ],
                      ),
                      Text(
                        "Senior Sales Manager",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      Text(
                        "1d ago",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.more_vert, color: Colors.grey),
              ],
            ),

            SizedBox(height: 16),

            // Looking For Section
            Row(
              children: [
                Icon(Icons.campaign, color: Colors.red, size: 18),
                SizedBox(width: 6),
                Text(
                  "Looking for",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              "Influencer marketing agency",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
            ),

            SizedBox(height: 12),

            // Budget & Brand Highlights
            Row(
              children: [
                Chip(
                  label: Text("₹ Budget: 1,50,000"),
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                SizedBox(width: 8),
                Chip(
                  label: Text("Brand: Swiszy"),
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ],
            ),

            SizedBox(height: 12),

            // Job Details
            Text(
              "Budget: ₹1,50,000\n"
              "Brand: Wanderfit Luggage\n"
              "Location: Goa & Kerala\n"
              "Type: Lifestyle & Adventure travel content\n"
              "Language: English and Hindi\n\n"
              "Looking for a travel influencer who can showcase our premium luggage line in scenic beach and nature destinations. "
              "Content should emphasize ease of travel and durability of the product.",
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),

            SizedBox(height: 12),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      Fluttertoast.showToast(msg: "Shared on WhatsApp");
                    },
                    icon: Icon(Icons.abc),
                    label: Text("Share via WhatsApp"),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      Fluttertoast.showToast(msg: "Shared on LinkedIn");
                    },
                    icon: Icon(Icons.share),
                    label: Text("Share on LinkedIn"),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Key Highlighted Details
            Text(
              "Key Highlighted Details",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            // Details Grid
            Column(
              children: [
                _detailRow(Icons.category, "Category", "Lifestyle, Fashion"),
                _detailRow(Icons.public, "Platform", "Instagram, YouTube"),
                _detailRow(
                    Icons.language, "Language", "Hindi, Kannada, English"),
                _detailRow(
                    Icons.place, "Location", "Bangalore, Tamil Nadu, Kerala"),
                _detailRow(Icons.people, "Required count", "5 - 20"),
                _detailRow(Icons.handshake, "Brand collab with", "Swiggy"),
                _detailRow(Icons.monetization_on, "Our Budget", "₹1,50,000"),
                _detailRow(Icons.person_add, "Required followers", "50k - 1M+"),
              ],
            ),

            SizedBox(height: 16),

            // Expiration Notice
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.grey[700]),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Your post will expire on 26 July",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12),

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
                    child: Text("Close"),
                  ),
                ),
                SizedBox(width: 8),
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
                    child: Text("Edit"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Detail Row Widget
  Widget _detailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[700]),
          SizedBox(width: 8),
          Text(
            "$title: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
