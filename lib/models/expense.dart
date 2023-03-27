class Expense {
  String uuid;
  double value;
  String? description;
  DateTime createdOn;

  Expense({
    required this.uuid,
    required this.value,
    required this.description,
    required this.createdOn,
  });

  factory Expense.fromMap(Map<String, dynamic> data) {
    final uuid = data["uuid"];
    final value = data["value"];
    final description = data["description"];
    final createdOn = DateTime.fromMillisecondsSinceEpoch(data["createdOn"]);

    return Expense(
      uuid: uuid,
      value: value,
      description: description,
      createdOn: createdOn,
    );
  }

  Map<String, dynamic> toMap() => {
        "uuid": uuid,
        "value": value,
        "description": description,
        "createdOn": createdOn.millisecondsSinceEpoch,
      };
}
