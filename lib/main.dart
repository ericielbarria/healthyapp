import 'package:flutter/material.dart';

void main() {
  runApp(const HealthyApp());
}

class HealthyApp extends StatelessWidget {
  const HealthyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HealthyHabits"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Evaluar hábitos"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FormPage extends StatefulWidget {
  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  double ejercicio = 0;
  String chatarra = "A veces";
  bool sueno = false;

  void calcularResultado() {
    int score = 0;

    if (ejercicio >= 3) score += 2;
    if (chatarra == "Nunca") score += 2;
    if (sueno) score += 2;

    String resultado;

    if (score >= 5) {
      resultado = "Buenos hábitos 🟢";
    } else if (score >= 3) {
      resultado = "Hábitos regulares 🟡";
    } else {
      resultado = "Necesitas mejorar 🔴";
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(resultado),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulario"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const Text("¿Cuántos días haces ejercicio?"),

            Slider(
              value: ejercicio,
              min: 0,
              max: 7,
              divisions: 7,
              label: ejercicio.toString(),
              onChanged: (value) {
                setState(() {
                  ejercicio = value;
                });
              },
            ),

            const SizedBox(height: 20),

            DropdownButton<String>(
              value: chatarra,
              items: ["Nunca", "A veces", "Frecuente"]
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  chatarra = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                const Text("¿Duermes más de 7h?"),

                Switch(
                  value: sueno,
                  onChanged: (bool value) {
                    setState(() {
                      sueno = value;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: calcularResultado,
              child: const Text("Ver resultado"),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {

  final String resultado;

  const ResultPage(this.resultado, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resultado"),
      ),
      body: Center(
        child: Text(
          resultado,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}