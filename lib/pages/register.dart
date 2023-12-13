import 'package:flutter/material.dart';
import 'package:login/pages/login.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF22372e)),
      ),
      body: Column(
        children: [
          Image.asset('assets/images/Logo.png', width: 100, height: 100),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Inscription",
                style: TextStyle(
                  color: Color(0xFF22372e),
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Card(
                elevation: 5,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 200),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            labelText: "Nom",
                            labelStyle: TextStyle(color: Color(0xFF22372e)),
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.0),
                          // Couleur du texte
                        ),
                        SizedBox(height: 8.0),
                        TextField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            labelText: "Prénom",
                            labelStyle: TextStyle(color: Color(0xFF22372e)),
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 8.0),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(color: Color(0xFF22372e)),
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 8.0),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Mot de passe",
                            labelStyle: TextStyle(color: Color(0xFF22372e)),
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 1.0),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: ElevatedButton(
                            onPressed: () {
                              String lastName = _lastNameController.text;
                            },
                            child: Text("S'inscrire"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text("Déjà un compte?"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: Text(
                              "Connectez-vous",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xFF22372e),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
