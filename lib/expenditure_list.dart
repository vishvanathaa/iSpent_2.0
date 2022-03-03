import 'package:flutter/material.dart';
import 'package:ispent/category_expense.dart';
import 'database/model/expenditure.dart';
import "dart:collection";
import 'package:ispent/utilities.dart';
class ExpenditureList extends StatelessWidget {
  final List<Expenditure> expenses;
  final int mode;
  final int year;
  final int monthNumber;

  ExpenditureList(
    this.expenses,
    this.mode,
    this.year,
    this.monthNumber, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var expenseList = getConsolidatedList(expenses);
    return ConstrainedBox(
        constraints: new BoxConstraints(
          //minHeight: 300.0,
          maxHeight: MediaQuery.of(context).size.height * 0.50,
        ),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: expenseList == null ? 0 : expenseList.length,
          itemBuilder: (context, index) {
            return Container(
                padding: EdgeInsets.only(left: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Padding(
                        padding: EdgeInsets.only(left: 0.0),
                        child: IconButton(
                            icon: new Icon(
                              getIconName(
                                  expenseList[index].icon),
                              color: Colors.greenAccent,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoryExpense(
                                        mode, year, monthNumber, expenseList[index].itemName)),
                              );
                            })),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          //data[index].itemName,
                          expenseList[index].itemName,
                          style: new TextStyle(
                            // fontFamily: "Quicksand",
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 35.0),
                        child: Text(
                          expenseList[index].amount.toStringAsFixed(2),
                          style: new TextStyle(
                            //fontFamily: "Quicksand",
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                decoration: new BoxDecoration(
                    border: new Border(
                        bottom: new BorderSide(
                  color: Colors.grey[700],
                ))));
          },
        ));
  }
}

List<Expenditure> getConsolidatedList(List<Expenditure> expenses) {
  var _categoryExpense = new List<Expenditure>();
  if (expenses != null) {
    var seen = Set<String>();
    List<Expenditure> distinctCategory = expenses.where((i) => seen.add(i.itemName)).toList();
    for (var j = 0; j < distinctCategory.length; j++) {
      double totalAmount =
          getCategoryAmount(expenses, distinctCategory[j].itemName);
      _categoryExpense.add(new Expenditure(
          totalAmount, distinctCategory[j].itemName, null, distinctCategory[j].icon, ""));
    }
  }
  return _categoryExpense;
}

double getCategoryAmount(List<Expenditure> source, String categoryName) {
  double totalAmount = 0;
  for (int i = 0; i < source.length; i++) {
    if (source[i].itemName == categoryName) {
      totalAmount = totalAmount + source[i].amount;
    }
  }
  return totalAmount;
}
