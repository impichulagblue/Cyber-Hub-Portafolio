import 'package:flutter/material.dart'; // Importa el paquete de Flutter para construir la interfaz
import '../navigation/app_drawer.dart'; // Importa el Drawer de navegación

class IMCCalculatorScreen extends StatefulWidget {
  const IMCCalculatorScreen({super.key}); // Constructor de la clase

  @override
  State<IMCCalculatorScreen> createState() => _IMCCalculatorScreenState(); // Crea el estado de la pantalla
}

class _IMCCalculatorScreenState extends State<IMCCalculatorScreen> {
  final _formKey = GlobalKey<FormState>(); // Clave global para el formulario
  final _heightController = TextEditingController(); // Controlador para el campo de altura
  final _weightController = TextEditingController(); // Controlador para el campo de peso
  double? _lastIMC; // Variable para almacenar el último IMC calculado
  String? _lastCategory; // Variable para almacenar la última categoría del IMC

  // Método para determinar la categoría del IMC
  String _categoriaIMC(double imc) {
    if (imc < 18.5) return 'BAJO PESO'; // Bajo peso
    if (imc < 25) return 'NORMAL'; // Peso normal
    if (imc < 30) return 'SOBREPESO'; // Sobrepeso
    return 'OBESIDAD'; // Obesidad
  }

  // Método para obtener el color según la categoría
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'NORMAL':
        return Colors.green; // Verde para normal
      case 'BAJO PESO':
        return Colors.blue; // Azul para bajo peso
      case 'SOBREPESO':
        return Colors.orange; // Naranja para sobrepeso
      case 'OBESIDAD':
        return Colors.red; // Rojo para obesidad
      default:
        return Colors.grey; // Gris por defecto
    }
  }

  // Método para calcular el IMC
  void _calcularIMC() {
    if (_formKey.currentState!.validate()) { // Valida el formulario
      final height = double.parse(_heightController.text); // Obtiene la altura
      final weight = double.parse(_weightController.text); // Obtiene el peso
      final imc = weight / (height * height); // Calcula el IMC
      final category = _categoriaIMC(imc); // Determina la categoría del IMC

      setState(() {
        _lastIMC = imc; // Actualiza el último IMC
        _lastCategory = category; // Actualiza la última categoría
      });

      // Muestra un SnackBar con el resultado
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.monitor_heart,
                color: _getCategoryColor(category), // Color según la categoría
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'IMC: ${imc.toStringAsFixed(2)} - $category', // Muestra el IMC y la categoría
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.black.withOpacity(0.8), // Fondo del SnackBar
          duration: const Duration(seconds: 5), // Duración del SnackBar
          behavior: SnackBarBehavior.floating, // Comportamiento flotante
        ),
      );
    }
  }

  // Método para limpiar el formulario
  void _limpiarFormulario() {
    _formKey.currentState!.reset(); // Reinicia el formulario
    _heightController.clear(); // Limpia el campo de altura
    _weightController.clear(); // Limpia el campo de peso
    setState(() {
      _lastIMC = null; // Reinicia el último IMC
      _lastCategory = null; // Reinicia la última categoría
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CALCULADORA IMC'), // Título de la AppBar
        backgroundColor: Theme.of(context).colorScheme.primary, // Color de fondo de la AppBar
        automaticallyImplyLeading: true, // Muestra el botón de retroceso
      ),
      drawer: const AppDrawer(), // Añade el Drawer de navegación
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // Inicio del degradado
            end: Alignment.bottomCenter, // Fin del degradado
            colors: [
              Theme.of(context).colorScheme.background, // Color de fondo
              Theme.of(context).colorScheme.surface, // Color de superficie
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Espaciado interior
          child: Column(
            children: [
              // Resultado anterior
              if (_lastIMC != null) // Si hay un último IMC calculado
                Card(
                  color: Colors.black.withOpacity(0.3), // Color de la tarjeta
                  child: Padding(
                    padding: const EdgeInsets.all(16.0), // Espaciado interior
                    child: Column(
                      children: [
                        const Text(
                          'ÚLTIMO RESULTADO:', // Título del resultado
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70, // Color del texto
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${_lastIMC!.toStringAsFixed(2)}', // Muestra el último IMC
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: _getCategoryColor(_lastCategory!), // Color según la categoría
                          ),
                        ),
                        Text(
                          _lastCategory!, // Muestra la última categoría
                          style: TextStyle(
                            fontSize: 18,
                            color: _getCategoryColor(_lastCategory!), // Color según la categoría
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 20), // Espacio entre elementos

              // Formulario
              Expanded(
                child: Form(
                  key: _formKey, // Asocia la clave del formulario
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _heightController, // Controlador para el campo de altura
                        decoration: InputDecoration(
                          labelText: 'Estatura (metros)', // Etiqueta del campo
                          hintText: 'Ej: 1.75', // Texto de sugerencia
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12), // Esquinas redondeadas
                          ),
                          filled: true, // Campo relleno
                          fillColor: Colors.white.withOpacity(0.1), // Color de fondo del campo
                          prefixIcon: const Icon(Icons.height), // Ícono en el campo
                        ),
                        keyboardType: TextInputType.number, // Tipo de teclado numérico
                        validator: (value) { // Validador del campo
                          if (value == null || value.isEmpty) {
                            return 'Ingrese la estatura'; // Mensaje de error
                          }
                          final height = double.tryParse(value); // Intenta convertir el valor a double
                          if (height == null || height <= 0) {
                            return 'Ingrese un número válido'; // Mensaje de error
                          }
                          if (height > 3) {
                            return 'Estatura poco realista'; // Mensaje de error
                          }
                          return null; // Todo está bien
                        },
                      ),
                      const SizedBox(height: 16), // Espacio entre campos
                      TextFormField(
                        controller: _weightController, // Controlador para el campo de peso
                        decoration: InputDecoration(
                          labelText: 'Peso (kg)', // Etiqueta del campo
                          hintText: 'Ej: 70.5', // Texto de sugerencia
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12), // Esquinas redondeadas
                          ),
                          filled: true, // Campo relleno
                          fillColor: Colors.white.withOpacity(0.1), // Color de fondo del campo
                          prefixIcon: const Icon(Icons.monitor_weight), // Ícono en el campo
                        ),
                        keyboardType: TextInputType.number, // Tipo de teclado numérico
                        validator: (value) { // Validador del campo
                          if (value == null || value.isEmpty) {
                            return 'Ingrese el peso'; // Mensaje de error
                          }
                          final weight = double.tryParse(value); // Intenta convertir el valor a double
                          if (weight == null || weight <= 0) {
                            return 'Ingrese un número válido'; // Mensaje de error
                          }
                          if (weight > 300) {
                            return 'Peso poco realista'; // Mensaje de error
                          }
                          return null; // Todo está bien
                        },
                      ),
                      const SizedBox(height: 30), // Espacio entre campos
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _calcularIMC, // Acción del botón
                              icon: const Icon(Icons.calculate), // Ícono en el botón
                              label: const Text('CALCULAR IMC'), // Texto del botón
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 15), // Espaciado interior
                                backgroundColor: Theme.of(context).colorScheme.secondary, // Color de fondo
                              ),
                            ),
                          ),
                          const SizedBox(width: 10), // Espacio entre botones
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _limpiarFormulario, // Acción del botón
                              icon: const Icon(Icons.cleaning_services), // Ícono en el botón
                              label: const Text('LIMPIAR'), // Texto del botón
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 15), // Espaciado interior
                                side: BorderSide(color: Theme.of(context).colorScheme.secondary), // Borde del botón
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _heightController.dispose(); // Libera el controlador de altura
    _weightController.dispose(); // Libera el controlador de peso
    super.dispose(); // Llama al método dispose de la clase padre
  }
}
