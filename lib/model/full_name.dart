class FullName {
  String first;
  String last;
  FullName({
    required this.first,
    required this.last,
  });

  FullName copyWith({
    String? first,
    String? last,
  }) {
    return FullName(
      first: first ?? this.first,
      last: last ?? this.last,
    );
  }
}
