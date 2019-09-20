import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

void main() => runApp(ByteBankApp());


class ByteBankApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context){
   return MaterialApp(
    home: Scaffold(
      body: ListaTransferencias(),
    ),
  );
  }
}


class ListaTransferencias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final List<Transferencia> _transferencias = List();
//    _transferencias.add(Transferencia(100.0, 100));

    return Scaffold (
          appBar: AppBar(title: Text('APP do Jefeson')),
          body: ListView.builder(
            itemCount: _transferencias.length,
            itemBuilder: (context, indice) {
              final transferencia = _transferencias[indice];
              return ItemTransferencia(transferencia);
            },
          ),


        floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () { 
             final Future<Transferencia> future = Navigator.push(context, MaterialPageRoute (
               builder: (contex) {
                 return ForumlarioTransferencia();
               }
             ));
             future.then((trasnferenciaRecebida){
               debugPrint('Chegou no then do future:');
               debugPrint('$trasnferenciaRecebida');
               _transferencias.add(trasnferenciaRecebida);
             });
             
        },
        
        ),
    );
  }

  

}


class ForumlarioTransferencia extends StatelessWidget {
  final _controladorCampoNumeroConta = TextEditingController();
  final _controladorCampoValor = TextEditingController();

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Criando nova transferência'),),
      body: Column(
        children: <Widget>[
          Editor(controlador: _controladorCampoNumeroConta, dica: '00000',rotulo: 'Número da conta',),
          Editor(controlador: _controladorCampoValor, rotulo: 'Valor', dica: '00.0', icone: Icons.monetization_on,),
          RaisedButton(
            child: Text('Confirmar'),
            onPressed: () {
              _criaTransferencia(context);
            },            
          )
        ],
      ),
    );
  }

  void _criaTransferencia(context) {
    
    final int numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double valor = double.tryParse(_controladorCampoValor.text);
    
    if (numeroConta != null && valor != null){
      final trasnferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint('Criando transferencia');
      debugPrint(trasnferenciaCriada.toString());
      Navigator.pop(context, trasnferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {
  
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;

  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override 
  Widget build(BuildContext context){
    return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controlador ,
              style: TextStyle(fontSize: 24.0),
                decoration: InputDecoration(
                  icon: icone != null ? Icon(icone) : null,
                  labelText: rotulo,
                  hintText: dica,
                ),
                keyboardType: TextInputType.number,
            ),
          );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;
  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context){
    return Card(
            child: ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text(_transferencia.valor.toString()),
              subtitle: Text(_transferencia.numeroConta.toString()),
              ),
            );
    }
}

class Transferencia {
  final double valor;
  final int numeroConta;
  Transferencia(this.valor, this.numeroConta);

  @override 
  String toString(){
    return 'Transferencia valor $valor Transferencia conta $numeroConta';
  }
}


