import 'dart:io';

import 'package:flutter/material.dart';

class GlobalHelper {
  static ImageProvider getImageProvider(String imageUrl) {
    if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
      // For server URLs, use NetworkImage
      return NetworkImage(imageUrl);
    } else if (imageUrl.startsWith('/data/user/')) {
      // For local file paths, use FileImage
      return FileImage(File(imageUrl));
    } else {
      // Default fallback to an asset image
      return const AssetImage('assets/profile.jpg');
    }
  }
}
