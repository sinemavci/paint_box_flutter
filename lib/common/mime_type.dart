enum MimeType {
  jpeg('jpeg'),
  png('png'),
  gif('gif'),
  tif('tif'),
  bmp('bmp'),
  pdf('pdf');

  final String value;

  static MimeType fromValue(String value) {
    return MimeType.values.firstWhere((mimeType) => mimeType.value == value, orElse: () => MimeType.png);
  }

  const MimeType(this.value);
}