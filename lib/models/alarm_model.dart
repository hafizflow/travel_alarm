class AlarmModel {
  final String id;
  final DateTime dateTime;
  bool isEnabled;

  AlarmModel({required this.id, required this.dateTime, this.isEnabled = true});

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateTime': dateTime.toIso8601String(),
      'isEnabled': isEnabled,
    };
  }

  // Create from JSON
  factory AlarmModel.fromJson(Map<String, dynamic> json) {
    return AlarmModel(
      id: json['id'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      isEnabled: json['isEnabled'] as bool? ?? true,
    );
  }

  // Copy with method for updating
  AlarmModel copyWith({String? id, DateTime? dateTime, bool? isEnabled}) {
    return AlarmModel(
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  // Get formatted time (e.g., "7:10 pm")
  String get formattedTime {
    final hour = dateTime.hour > 12
        ? dateTime.hour - 12
        : (dateTime.hour == 0 ? 12 : dateTime.hour);
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'pm' : 'am';
    return '$hour:$minute $period';
  }

  // Get formatted date (e.g., "Fri 21 Mar 2025")
  String get formattedDate {
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${weekdays[dateTime.weekday - 1]} ${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}';
  }
}
