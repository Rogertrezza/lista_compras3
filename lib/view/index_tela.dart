import 'package:flutter/material.dart';
import 'package:lista_compras3/widgets/navBar.dart';

class index_tela extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 15,),
            Align(alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => navBar()
                    ));
                },
                child: Text(
                  "Sem Login",
                  style: TextStyle(
                    color: Color(0xFF7165D6),
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(padding: EdgeInsets.all(10),child: Image.asset(
              "lib/img/logo.png",
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),),
            SizedBox(height: 20),
            Text(
              "Aplicativo lista de compras",
              style: TextStyle(
                color: Color(0xFF7165d6),
                fontSize: 25,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                wordSpacing: 2
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Seu aplicativo de compras particular",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.w500
              ),
            ),
            SizedBox( height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Material(
                color: Color(0xFF7165d6),
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: (){
                    Navigator.pushNamed(
                      context, 
                      'login',
                      );
                  },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: Text(
                    "Logar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                ),
                ),
                ),
                Material(
                color: Color(0xFF7165d6),
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: (){
                    Navigator.pushNamed(
                      context, 
                      'cadastro',
                      );
                  },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: Text(
                    "Registrar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                ),
                ),
                ),
              ],
            ),
          ],
        ),
        ),
    );
  }
}