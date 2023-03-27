import 'package:finance_app_fudeo/models/expense.dart';
import 'package:finance_app_fudeo/repositories/database_repository.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

final store = Store().obs;

class Store {
  List<Expense> expenses = [];

  Future<void> initialize() async {
    expenses = await GetIt.instance<DatabaseRepository>().allExpenses();
  }

  double get totalExpenseToday {
    final currentDate = DateTime.now();
    final firstDayOfMonth = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
    );
    return expenses.where((expense) {
      return expense.createdOn.isAfter(firstDayOfMonth);
    }).fold(0.0, (acc, expense) {
      return acc + expense.value;
    });
  }

  double get totalExpenseWeek {
    final currentDate = DateTime.now();
    final firstDayOfWeek = currentDate.subtract(Duration(
      days: currentDate.weekday,
    ));

    return expenses.where((expense) {
      return expense.createdOn.isAfter(firstDayOfWeek);
    }).fold(0.0, (acc, expense) {
      return acc + expense.value;
    });
  }

  double get totalExpenseMonth {
    final currentDate = DateTime.now();
    final firstDayOfMonth = DateTime(
      currentDate.year,
      currentDate.month,
      0,
    );
    return expenses.where((expense) {
      return expense.createdOn.isAfter(firstDayOfMonth);
    }).fold(0.0, (acc, expense) {
      return acc + expense.value;
    });
  }

  double get totalExpenseYear {
    final currentDate = DateTime.now();
    final firstDayOfYear = DateTime(
      currentDate.year,
      0,
      0,
    );
    return expenses.where((expense) {
      return expense.createdOn.isAfter(firstDayOfYear);
    }).fold(0.0, (acc, expense) {
      return acc + expense.value;
    });
  }

  void createExpense({
    required double value,
    required String? description,
  }) {
    final expense = Expense(
      uuid: Uuid().v4(),
      value: value,
      description: description,
      createdOn: DateTime.now(),
    );
    expenses.insert(0, expense);
    GetIt.instance<DatabaseRepository>().createExpense(expense);
    store.refresh();
  }

  void editExpense(
    Expense expense, {
    required double value,
    required String? description,
  }) {
    expense.value = value;
    expense.description = description;
    GetIt.instance<DatabaseRepository>().updateExpense(expense);
    store.refresh();
  }

  void deleteExpense(Expense expense) {
    expenses.remove(expense);
    GetIt.instance<DatabaseRepository>().deleteExpense(expense);
    store.refresh();
  }
}
