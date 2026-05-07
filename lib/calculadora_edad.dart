import 'package:flutter/material.dart';

void main() => runApp(const AppEdad());

class AppEdad extends StatelessWidget {
  const AppEdad({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Edad',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const PantallaEdad(),
    );
  }
}

class PantallaEdad extends StatefulWidget {
  const PantallaEdad({super.key});

  @override
  State<PantallaEdad> createState() => _PantallaEdadState();
}

class _PantallaEdadState extends State<PantallaEdad> {
  final TextEditingController _controller = TextEditingController();

  int? _edad;
  String? _error;

  void _calcularEdad() {
    final texto = _controller.text.trim();
    final anioNacimiento = int.tryParse(texto);
    final anioActual = DateTime.now().year;

    setState(() {
      if (texto.isEmpty) {
        _error = 'El campo no puede estar vacío';
        _edad = null;
      } else if (anioNacimiento == null) {
        _error = 'Ingresa un año válido';
        _edad = null;
      } else if (anioNacimiento < 1900 || anioNacimiento > anioActual) {
        _error = 'El año debe estar entre 1900 y $anioActual';
        _edad = null;
      } else {
        _error = null;
        _edad = anioActual - anioNacimiento;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Edad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Año de nacimiento',
                hintText: 'Ejemplo: 2005',
                errorText: _error,
                prefixIcon: const Icon(Icons.cake),
              ),
            ),

            const SizedBox(height: 16),

            FilledButton.icon(
              onPressed: _calcularEdad,
              icon: const Icon(Icons.calculate),
              label: const Text('Calcular edad'),
            ),

            const SizedBox(height: 24),

            if (_edad != null)
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Tu edad es de $_edad años',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}