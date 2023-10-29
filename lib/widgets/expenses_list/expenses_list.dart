//CONTAINS THE LIST OF EXPENSES WHICH ARE SHOWN IN THE expenses.dart file ....on the UI

//Creating a widget
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses; //Modals class wala Expense hai <> iske ander
  final void Function(Expense expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    //listView is automatically scrollable
    return ListView.builder(
      itemCount:
          expenses.length, //helps flutter know how many items will be displayed
      itemBuilder: (ctx, index) {
        //this function will be called as many no.of times in itemCount
        //this index will be 0 as list begins from 0 then 1 then 2 and so on ..
        return Dismissible(
          //dissmissible se humlog expenses slide krke remove kr skte hain
          key: ValueKey(
              expenses[index]), //uniquely identifies the data to be deleted
          background: Container(
            color: Theme.of(context)
                .colorScheme
                .error
                .withOpacity(0.75), //shows red color when the expense is remove
            margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal,
            ),
          ),
          onDismissed: (direction) {
            //direction is left to right or right to left
            onRemoveExpense(expenses[index]);
          }, //with this we are remving the content from the memory also
          child: ExpenseItem(expenses[index]),
        ); //each item which we get through index is sent to the expense_item.dart file
      },
    );
  }
}
