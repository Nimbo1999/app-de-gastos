import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardInputs extends StatefulWidget {

  final Function addTx;

  CardInputs(this.addTx);

  @override
  _CardInputsState createState() => _CardInputsState();
}

class _CardInputsState extends State<CardInputs> {
  final _titleInput = TextEditingController();
  final _amountInput = TextEditingController();
  DateTime _selectDate;

  void _submitData() {

    if(_amountInput.text.isEmpty) return;
    final enteredTitle = _titleInput.text;
    final amountTypeParse = double.parse(_amountInput.text);

    if(enteredTitle.isEmpty || amountTypeParse <= 0 || _selectDate == null) return;

    widget.addTx(
      enteredTitle,
      amountTypeParse,
      _selectDate
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now()
    ).then((value) {
      if(value == null) return;
      setState(() {
        _selectDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            left: 10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Título'
                ),
                controller: _titleInput,
                keyboardType: TextInputType.text,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Preço'
                ),
                controller: _amountInput,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectDate == null
                          ? 'Selecione uma data!'
                          : 'Data: ${DateFormat('dd/MM/yyyy').format(_selectDate)}'
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColorDark,
                      child: Text(
                        'Escolha uma data.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      onPressed: _presentDatePicker,
                    )
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Adicionar no Orçamento'),
                onPressed: _submitData,
                textColor: Theme.of(context).textTheme.button.color,
                color: Theme.of(context).primaryColorDark,
              )
            ],
          ),
        )
      ),
    );
  }
}