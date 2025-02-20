class JsonHelper {
  // Optimized method for getting a field as a specific type
  static T getParseField<T>(Map<String, dynamic> json, String key,
      {int? index}) {
    if (!json.containsKey(key)) {
      throw FormatException(
          "Error: Index ${index ?? 'N/A'}, Field '$key' is missing");
    }

    var value = json[key];

    if (value is T) {
      return value;
    } else {
      throw FormatException(
          "Error: Index ${index ?? 'N/A'}, Field '$key' expected $T but got ${value.runtimeType}");
    }
  }

  // Specialized methods for different types that just call _getField with specific expected types
  static String getString(Map<String, dynamic> json, String key, {int? index}) {
    return getParseField<String>(json, key, index: index);
  }

  static int getInt(Map<String, dynamic> json, String key, {int? index}) {
    return getParseField<int>(json, key, index: index);
  }

  static double getDouble(Map<String, dynamic> json, String key, {int? index}) {
    return getParseField<double>(json, key, index: index);
  }

  static bool getBool(Map<String, dynamic> json, String key, {int? index}) {
    return getParseField<bool>(json, key, index: index);
  }

  // Corrected method to get a list and parse each item using the provided `fromJson` function
  static List<T> getList<T>(
    Map<String, dynamic> json,
    String key,
    T Function(Map<String, dynamic>, {int? index}) fromJson,
  ) {
    if (!json.containsKey(key)) {
      throw FormatException("Error: Field '$key' is missing");
    }

    var value = json[key];

    if (value is List) {
      return value
          .asMap()
          .map((index, element) {
            if (element is Map<String, dynamic>) {
              // Parse the element as Map<String, dynamic> using fromJson
              return MapEntry(index, fromJson(element, index: index));
            } else {
              throw FormatException(
                  "Error: Index $index, Field '$key' expected a List<Map<String, dynamic>> but got ${element.runtimeType}");
            }
          })
          .values
          .toList();
    } else {
      throw FormatException(
          "Error: Field '$key' expected a List but got ${value.runtimeType}");
    }
  }
}
