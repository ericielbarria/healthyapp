import 'package:flutter/material.dart';

void main() {
  runApp(HealthyApp());
}

class HealthyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

// ---------------- HOME ----------------
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HealthyHabits")),
      body: Center(
        child: ElevatedButton(
          child: Text("Evaluar mis hábitos"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormPage()),
            );
          },
        ),
      ),
    );
  }
}

// ---------------- FORM ----------------
class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  int ejercicio = 0;
  String chatarra = "A veces";
  bool sueno = false;

  void calcular() {
    int score = 0;

    if (ejercicio >= 3) score += 2;
    else if (ejercicio >= 1) score += 1;

    if (chatarra == "Nunca") score += 2;
    else if (chatarra == "A veces") score += 1;

    if (sueno) score += 2;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(score: score),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Formulario")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("¿Ejercicio por semana?"),
            Slider(
              value: ejercicio.toDouble(),
              min: 0,
              max: 7,
              divisions: 7,
              label: "$ejercicio",
              onChanged: (value) {
                setState(() {
                  ejercicio = value.toInt();
                });
              },
            ),

            SizedBox(height: 20),

            Text("¿Comes comida chatarra?"),
            DropdownButton<String>(
              value: chatarra,
              items: ["Nunca", "A veces", "Frecuente"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  chatarra = value!;
                });
              },
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("¿Duermes ≥7h?"),
                Switch(
                  value: sueno,
                  onChanged: (value) {
                    setState(() {
                      sueno = value;
                    });
                  },cd
                )
              ],
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: calcular,
              child: Text("Ver resultado"),
            )
          ],
        ),
      ),
    );
  }
}

// ---------------- RESULT ----------------
class ResultPage extends StatelessWidget {
  final int score;

  ResultPage({required this.score});

  String getResultado() {
    if (score >= 5) return "Buenos hábitos 🟢";
    if (score >= 3) return "Hábitos regulares 🟡";
    return "Necesitas mejorar 🔴";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Resultado")),
      body: Center(
        child: Text(
          getResultado(),
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}