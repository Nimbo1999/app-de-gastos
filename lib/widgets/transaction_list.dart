import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final Function deletarTransacao;

  TransactionList(this.transactions, this.deletarTransacao);

  @override
  Widget build(BuildContext context) {

  final MediaQueryData mediaQuery = MediaQuery.of(context);

    return transactions.isEmpty
    ? LayoutBuilder(builder: (ctx, constraint) {
      return Column(children: <Widget>[
        Text(
          'Não existem Itens!',
          style: Theme.of(context).textTheme.title,
        ),
        SizedBox(height: 20,),
        Container(
          child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,),
          height: constraint.maxHeight * 0.7,
        )
      ],);
    },)
    : ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(5),
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
            trailing: mediaQuery.size.width > 360
              ? FlatButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                  textColor: Theme.of(context).errorColor,
                  onPressed: () => deletarTransacao(transactions[index].id)
                )
              : IconButton(
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => deletarTransacao(transactions[index].id)
                ),
          ),
        );
      },
      itemCount: transactions.length,
    );
  }
}