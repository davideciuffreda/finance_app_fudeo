import 'package:finance_app_fudeo/models/expense.dart';
import 'package:finance_app_fudeo/routing/router_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;

  const ExpenseTile(this.expense);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          editExpensePageRoute,
          arguments: expense,
        );
      },
      leading: AspectRatio(
        aspectRatio: 5 / 3,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              "${expense.value.toStringAsFixed(2)}€",
              style: TextStyle(
                color: Colors.green.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
      title: Text(DateFormat("dd MMMM").format(expense.createdOn)),
      subtitle: Text(expense.description ?? '-'),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey.shade300,
      ),
    );
  }
}
