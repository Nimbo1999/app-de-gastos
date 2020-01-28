import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
      ? Column(children: <Widget>[
        Text(
          'Não existem Itens!',
          style: Theme.of(context).textTheme.title,
        ),
        SizedBox(height: 20,),
        Container(
          child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,),
          height: 200,
        )
      ],)
      : ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(5),
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: FittedBox(
                    child: Text('\$${transactions[index].amount}')
                  ),
                ),
              ),
              title: Text(
                transactions[index].title,
                style: Theme.of(context).textTheme.title,
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(transactions[index].date),
                ),
            ),
          );
          // return Card(
          //   child: Row(
          //     children: <Widget>[
          //       Container(
          //         margin: EdgeInsets.symmetric(
          //           vertical: 10,
          //           horizontal: 10
          //         ),
          //         padding: EdgeInsets.symmetric(
          //           vertical: 10,
          //           horizontal: 5
          //         ),
          //         decoration: BoxDecoration(
          //           border: Border.all(
          //             width: 2,
          //             color: Theme.of(context).primaryColorDark
          //           )
          //         ),
          //         child: Text(
          //           "R\$${transactions[index].amount.toStringAsFixed(2)}",
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             fontSize: 20,
          //             color: Theme.of(context).primaryColorDark
          //           ),
          //         ),
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: <Widget>[
          //           Text(
          //             transactions[index].title,
          //             style: Theme.of(context).textTheme.title,
          //           ),
          //           Text(
          //             DateFormat('dd/MM/yyyy').format(transactions[index].date),
          //             style: TextStyle(
          //               fontSize: 14,
          //               color: Colors.grey
          //             ),
          //           )
          //         ],
          //       )
          //     ],
          //   ),
          // );
        },
        itemCount: transactions.length,
      ),
    );
  }
}