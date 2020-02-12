import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

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
        return TransactionItem(
          transaction: transactions[index],
          mediaQuery: mediaQuery,
          deletarTransacao: deletarTransacao
        );
      },
      itemCount: transactions.length,
    );
  }
}