import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  final List<String> locations;
  final String followers;
  final List<String> categories;

  const LocationWidget({
    Key? key,
    required this.locations,
    required this.followers,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int maxVisible = 3; // Max locations to display before showing "+more"
    bool showMore = locations.length > maxVisible;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row for Locations
        if (locations.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.grey),
                const SizedBox(width: 5),
                Text(
                  locations.take(maxVisible).join(", ") +
                      (showMore
                          ? " +" +
                              (locations.length - maxVisible).toString() +
                              " more"
                          : ""),
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),

        const SizedBox(height: 4), // Spacing

        // Row for Followers Count
        Row(
          children: [
            if (followers.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.camera_alt, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(followers,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black)),
                  ],
                ),
              ),
              const SizedBox(width: 8), // Spacing
            ],
            if (categories.isNotEmpty) ...[
              // Row for Categories
              Container(
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.category, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(categories.join(", "),
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black)),
                  ],
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
