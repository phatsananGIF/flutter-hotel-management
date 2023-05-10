extension ListDataExtension on List {
  int getLengthForList() {
    if (this.isNotEmpty) {
      return this.length;
    }
    return 1;
  }
}
