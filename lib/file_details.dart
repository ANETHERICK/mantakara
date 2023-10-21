class FileDetails {
  final int id;
  final String officer;
  final String forAction;
  final String initial;
  final String date;
  final String actionTakenVide;

  FileDetails({
    required this.id,
    required this.officer,
    required this.forAction,
    required this.initial,
    required this.date,
    required this.actionTakenVide,
  });

  static int _nextId = 1;

  factory FileDetails.create({
    required String officer,
    required String forAction,
    required String initial,
    required String date,
    required String actionTakenVide,
  }) {
    final fileDetails = FileDetails(
      id: _nextId,
      officer: officer,
      forAction: forAction,
      initial: initial,
      date: date,
      actionTakenVide: actionTakenVide,
    );
    _nextId++;
    return fileDetails;
  }
}
