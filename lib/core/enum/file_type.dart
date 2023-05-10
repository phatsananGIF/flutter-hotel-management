enum FileTypies {
  png,
  jpeg,
}

extension FileTypiesExtension on FileTypies {
  name() {
    switch (this) {
      case FileTypies.jpeg:
        return 'jpeg';
      case FileTypies.png:
        return 'png';
      default:
        return 'jpeg';
    }
  }
}
