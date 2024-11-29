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
        'dateTime': dateTime,
        'isDone': isDone,
      };

  TodoDM.formFireStore(Map<String, dynamic> date)
      : this(
          id: date['id'],
          title: date['title'],
          description: date['description'],
          dateTime: date['dateTime'].toDate(),
          isDone: date['isDone'],
        );
}
