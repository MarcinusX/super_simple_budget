const String columnId = "_id";
const String columnValue = "_value";
const String columnDate = "_date";
const String columnComment = "_comment";

class Expense {
  int id;
  double value;
  DateTime dateTime;
  String comment;

  Expense(this.value, this.dateTime);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      columnValue: value,
      columnDate: dateTime.millisecondsSinceEpoch,
      columnComment: comment,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Expense.fromMap(Map map)
      : id = map[columnId],
        value = map[columnValue],
        dateTime = new DateTime.fromMillisecondsSinceEpoch(map[columnDate]),
        comment = map[columnComment];
}
