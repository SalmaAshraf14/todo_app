class TodoDM {
  static const String collectionName = 'todo';
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;

  TodoDM(
      {required this.id,
      required this.title,
      required this.description,
      required this.dateTime,
      required this.isDone});

  Map<String, dynamic> toFireStore() => {
        'id': id,
        'title': title,
        'description': description,
        'dateTime': dateTime.millisecondsSinceEpoch,
        'isDone': isDone,
      };

  TodoDM.formFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'],
          title: data['title'],
          description: data['description'],
          dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
          isDone: data['isDone'],
        );
}

