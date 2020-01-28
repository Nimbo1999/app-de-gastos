import 'package:flutter/material.dart';

import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/card_inputs.dart';
import './widgets/chart.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Gerenciador de Gastos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.redAccent,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            title: TextStyle(
              fontSize: 20,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold
            )
          )
        ),
        textTheme: TextTheme(
          title: TextStyle(
            fontSize: 18,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold
          ),
          button: TextStyle(
            color: Colors.white
          )
        ),
        errorColor: Colors.redAccent
      ),
      home: HomeApp()
    );
  }
}

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {

  /**
   * Essa lista é responsável por segurar todas as transações.
   */
  final List<Transaction> _userTransactions = [];

  /**
   * Esse método get retorna as transações mais recente de 7 dias atraz.
   */
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx){
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(days: 7))
      );
    }).toList();
  }

  /**
   * Esse método Insere uma nova transação na minha lista de transações.
   * Parâmetros obrigatórios:
   * - Título da transação: Esse parâmetro se refere ao título da transação, ou
   * qualquer outro nome que identifique a transação.
   * - Valor da transação: Esse parâmetro representa quanto que custou essa transação.
   * - Data da transação: Esse parâmetro representa a data dessa transação.
   */
  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: txDate,
      id: DateTime.now().toString()
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  /**
   * Método para deletar uma transação da lista.
   */
  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  /**
   * Método responsável por apresentar o modal da entrada de dados do usuário.
   */
  void _showTransactionModal(BuildContext ctx){
    showModalBottomSheet(
      context: ctx,
      builder: (_){
        return GestureDetector(
          child: CardInputs(
            _addNewTransaction
          ),
          onTap: (){},
          behavior: HitTestBehavior.opaque,
        );
      }
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciador de Gastos'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showTransactionModal(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showTransactionModal(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}