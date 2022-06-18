// ignore_for_file: unnecessary_this

extension StringExtension on String {
    String toTitleCase() {
      return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
    }
}