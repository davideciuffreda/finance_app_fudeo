import 'package:finance_app_fudeo/models/expense.dart';
import 'package:finance_app_fudeo/models/store.dart';
import 'package:finance_app_fudeo/widgets/expense_edit.dart';
import 'package:flutter/material.dart';

class EditExpensePage extends StatefulWidget {
  final Expense expense;
  const EditExpensePage(this.expense);

  @override
  State<EditExpensePage> createState() => _EditExpensePageState();
}

class _EditExpensePageState extends State<EditExpensePage> {
  void onSubmit({
    required double value,
    required String? description,
  }) {
    store.value
        .editExpense(widget.expense, value: value, description: description);
    Navigator.pop(context);
  }

  void onDelete() {
    store.value.deleteExpense(widget.expense);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ExpenseEdit(
      initialValue: widget.expense.value,
      initialDescription: widget.expense.description,
      floatingActionButtonIcon: Icons.delete,
      onFloatingActionButtonPressed: onDelete,
      onSubmit: onSubmit,
    );
  }
}
