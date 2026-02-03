import 'package:intl/intl.dart';

class DateFormatter {
  static String formatPublishedDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return 'Unknown date';
    }

    try {
      final DateTime date = DateTime.parse(dateString);
      final DateFormat formatter = DateFormat('MMM d, yyyy');
      return formatter.format(date);
    } catch (e) {
      return dateString;
    }
  }

  static String formatRelativeTime(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return 'Unknown date';
    }

    try {
      final DateTime date = DateTime.parse(dateString);
      final DateTime now = DateTime.now();
      final Duration difference = now.difference(date);

      if (difference.inDays > 365) {
        final years = (difference.inDays / 365).floor();
        return '$years ${years == 1 ? 'year' : 'years'} ago';
      } else if (difference.inDays > 30) {
        final months = (difference.inDays / 30).floor();
        return '$months ${months == 1 ? 'month' : 'months'} ago';
      } else if (difference.inDays > 0) {
        return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return dateString;
    }
  }
}