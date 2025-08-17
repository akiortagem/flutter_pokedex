// lib/src/router/path_pattern.dart
class PathPattern {
  PathPattern(this.pattern)
      : _paramNames = _extractParamNames(pattern),
        _regex = RegExp(
          '^${pattern.replaceAllMapped(
            RegExp(r':([A-Za-z_][A-Za-z0-9_]*)'),
            (m) => '(?<${m.group(1)!}>[^/]+)',
          )}/?\$', // optional trailing slash
        );

  final String pattern;
  final RegExp _regex;
  final List<String> _paramNames;

  static List<String> _extractParamNames(String p) =>
      RegExp(r':([A-Za-z_][A-Za-z0-9_]*)')
          .allMatches(p)
          .map((m) => m.group(1)!)
          .toList(growable: false);

  /// Returns decoded params if matched; otherwise null.
  Map<String, String>? match(String path) {
    final m = _regex.firstMatch(path);
    if (m == null) return null;

    final out = <String, String>{};
    for (final name in _paramNames) {
      final v = m.namedGroup(name);
      if (v != null) out[name] = Uri.decodeComponent(v);
    }
    return out;
  }

  /// Build a concrete path by substituting params (values are URI-encoded).
  String build(Map<String, String> params) {
    var out = pattern;
    for (final name in _paramNames) {
      final value = params[name];
      if (value == null) {
        throw ArgumentError('Missing param "$name" for pattern "$pattern".');
      }
      out = out.replaceAll(':$name', Uri.encodeComponent(value));
    }
    return out;
  }
}
