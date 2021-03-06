import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  const TransactionList(
      {Key? key, required this.transactions, required this.deleteTransaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return SizedBox(
              height: constraints.maxHeight * 0.6,
              child: Column(
                children: [
                  Text(
                    'No transactions added yet',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Image.asset('assets/images/waiting.png', fit: BoxFit.cover)
                ],
              ),
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        '\$${transactions[index].amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transactions[index].title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          DateFormat('dd MMM yyyy')
                              .format(transactions[index].date),
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: MediaQuery.of(context).size.width > 460
                            ? TextButton.icon(
                                onPressed: () =>
                                    deleteTransaction(transactions[index].id),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                label: const Text(
                                  'DELETE',
                                  style: TextStyle(color: Colors.red),
                                ))
                            : IconButton(
                                onPressed: () =>
                                    deleteTransaction(transactions[index].id),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                      ),
                    )
                  ],
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
