import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<int> numsFinal = new List();
  List<TextEditingController> _controllers = new List();

  bool podeOrdenar = false;
  int n = 0;
  bool gerarCampos = false;
  final _nController = TextEditingController();

  ///Reseta os valores e inicia um novo ciclo de ordenação
  void resetaValores(){
    gerarCampos = false;
    podeOrdenar = false;
    numsFinal..removeRange(0, numsFinal.length);
    _controllers.clear();
  }

  ///Ordena a lista com as informações dos TextFields
  ///Sem repetição de item
  void ordenaLista(){
    for(var controller in _controllers){
      if(controller.text != ""){
        int numDigitado = int.parse(controller.text);
        if(numDigitado >= -1000 && numDigitado <= 1000){
          numsFinal.add(numDigitado);
        }
      }
    }

    numsFinal.sort();
    numsFinal = numsFinal.toSet().toList();
  }

  ///Mostra a lista ordenada e sem repetição no App
  Widget listaOrdenada(){
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: numsFinal.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 30,
            child: Text(numsFinal[index].toString()),
          );
        }
    );
  }


  ///Gera o total de campos informados para a variável N
  Widget _buildPerguntas(BuildContext context) {
    return ListView.builder(
        itemCount: n,
        itemBuilder: (context, index){
        return Padding(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: TextField(
            controller: _controllers[index],
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: ""),
          ),
        );
      });
  }

  ///Iniciando a variável N, com a quantidade de números que serão inseridos
  Widget buildInicio(){
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20,right: 20),
          child:  TextField(
            controller: _nController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Digite um valor para N"),
            onChanged: (text) {
              int numDigitado = int.parse(text).toInt();
              setState(() {
                  n = numDigitado;
              });
            },
          ),
        ),

        new RaisedButton(
          padding: const EdgeInsets.all(8.0),
          textColor: Colors.white,
          color: Colors.blue,
          onPressed: (){
            print(n.toString());
            if(n >=1 && n <= 1000){
              setState(() {
                  gerarCampos = true;
                  for(var i=0;i <n;i++){
                    var textController = TextEditingController();
                    _controllers.add(textController);
                  }
              });
            }
          },
          child: new Text("Ir"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ordenar Inteiros"),
      ),
      body: !gerarCampos ? buildInicio() : Column(
        children: <Widget>[
          !podeOrdenar ? Expanded(
            child: _buildPerguntas(context),
          ): Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: listaOrdenada(),
            ),
          ),
          !podeOrdenar ? Padding(
            padding: EdgeInsets.only(left: 20,right: 20,bottom: 30),
            child:  new RaisedButton(
              padding: const EdgeInsets.all(8.0),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: (){
                _nController.clear();
                setState(() {
                  ordenaLista();
                  podeOrdenar = true;
                });
              },
              child: new Text("Ordenar"),
            ),
          ):Padding(
            padding: EdgeInsets.only(left: 20,right: 20,bottom: 30),
            child:  new RaisedButton(
              padding: const EdgeInsets.all(8.0),
              textColor: Colors.white,
              color: Colors.red,
              onPressed: (){
                setState(() {
                  resetaValores();
                });
              },
              child: new Text("Resetar"),
            ),
          ),
        ],
      ),

    );
  }

}