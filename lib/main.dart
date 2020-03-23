import 'package:flutter/material.dart';

void main () {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override 
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home>{

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  
  final _formKey = GlobalKey<FormState>();

  String _Info = "Informe seus Dados";

  void _resetFields() {
    setState(() {
      weightController.clear();
    heightController.clear();
    _Info = "Informe seus Dados";
    
    });
  }

  void _calcularIMC(){
    setState(() {
      double weight = double.parse(weightController.text);
   double height = double.parse(heightController.text) / 100;
   double imc = weight / (height * height);
   if(imc < 18.6){
     _Info = "Abaixo do Peso (IMC ${imc.toStringAsPrecision(3)})";
   } else if(imc >= 18.6 && imc < 24.9){
     _Info = "Peso ideal (IMC ${imc.toStringAsPrecision(3)})";
   } else if(imc >= 24.9 && imc < 29.9){
     _Info = "Levemente Acima do Peso (IMC ${imc.toStringAsPrecision(3)})";
   }else if(imc >= 29.9 && imc < 34.9){
     _Info = "Obesidade Grau I (IMC ${imc.toStringAsPrecision(3)})";
   } else if(imc >= 34.9 && imc < 39.9){
     _Info = "Obesidade grau II (IMC ${imc.toStringAsPrecision(3)})";
   } else if(imc >= 40.0){
     _Info = "Obesidade Grau III (IMC ${imc.toStringAsPrecision(3)})";
   }
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Calculadora de IMC",),
    backgroundColor: Colors.lightBlue,centerTitle: true,
    actions: <Widget>[
      IconButton(icon: Icon(Icons.refresh,color: Colors.white,), onPressed: () {_resetFields();},)
    ],
    ),

    backgroundColor: Colors.white,

    body: SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Form(
        key: _formKey,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
      Icon(Icons.person_outline,size: 120,color: Colors.lightBlue),

      TextFormField(keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: "Peso (Kg)",labelStyle: TextStyle(color: Colors.lightBlue),
      ),
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.lightBlue, fontSize: 20),
      controller: weightController,
      validator:(value) {
        if (value.isEmpty) {
          return "Campo Obrigatório";
        }
        return null;
      } ),

      TextFormField(keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: "Altura (cm)",labelStyle: TextStyle(color: Colors.lightBlue),
      ),
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.lightBlue, fontSize: 20),
      controller: heightController,
      validator: (value) {
        if (value.isEmpty) {
          return "Campo Obrigatório";
        }
        return null; 
      },
      ),
      

      Padding(
        padding: EdgeInsets.only(top: 12, bottom: 12),
        child: Container(
        height: 50,
        child: RaisedButton(onPressed: () {
          if(_formKey.currentState.validate()){
            _calcularIMC();
          }
        },
      child: Text("Calcular", style: TextStyle(color: Colors.white,fontSize: 20)), 
      color: Colors.lightBlue,),
      ),
      ),

      Text(_Info,textAlign: TextAlign.center, style: TextStyle(color: Colors.lightBlue,fontSize: 20),)
    ],
    ),
    )
    
    ),
    );
  }
}