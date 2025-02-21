import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketing_app/model/marketing_response_model.dart';

class RequestDetailsWidget extends StatelessWidget {
  final RequestDetails details;

  const RequestDetailsWidget({Key? key, required this.details})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle("Key Highlighted Details"),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 3,
              children: [
                _buildDetailRow("Category", details.categories.join(", ")),
                _buildDetailRow("Platform", details.platform.join(", ")),
                _buildDetailRow("Language", details.languages.join(", ")),
                _buildDetailRow("Location", details.cities.join(", ")),
                _buildDetailRow("Required count", "15 - 20"),
                _buildDetailRow("Our Budget", "₹1,45,000"),
                _buildDetailRow("Brand collab with", "Swiggy"),
              ],
            ),
            _buildFollowerRequirement(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$label",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFollowerRequirement() {
    if (details.followersRange == null) return const SizedBox.shrink();
    String followers =
        "${details.followersRange!.igFollowersMin} - ${details.followersRange!.igFollowersMax}+";

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          const Text(
            "Required followers: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(width: 4),
          const FaIcon(FontAwesomeIcons.instagram,
              size: 16, color: Colors.black54),
          const SizedBox(width: 4),
          Text(followers,
              style: const TextStyle(fontSize: 14, color: Colors.black54)),
        ],
      ),
    );
  }
}
