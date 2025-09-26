import 'package:flutter/material.dart';
import 'dart:math';  // Para números aleatorios
import '../../navigation/app_drawer.dart';

class EvenOddGameScreen extends StatefulWidget {
  const EvenOddGameScreen({super.key});

  @override
  State<EvenOddGameScreen> createState() => _EvenOddGameScreenState();
}

class _EvenOddGameScreenState extends State<EvenOddGameScreen> {
  int usuarioPuntos = 0;      // Puntos del usuario
  int cpuPuntos = 0;          // Puntos de la CPU
  String resultado = 'ELIGE PAR O IMPAR Y UN NÚMERO';
  String? eleccionUsuario;    // 'PAR' o 'IMPAR'
  int? numeroUsuario;         // Número elegido por usuario (0-5)
  int? numeroCPU;             // Número aleatorio de CPU (0-5)
  Random random = Random();   // Generador de números aleatorios
  bool _isAnimating = false;  // Controla animaciones

  // Lógica principal del juego
  void jugar(bool usuarioEligePar, int numeroElegido) {
    setState(() {
      _isAnimating = true;  // Inicia animación
    });

    int numeroCPU = random.nextInt(6);  // Número aleatorio 0-5
    int suma = numeroElegido + numeroCPU;
    bool esPar = suma % 2 == 0;  // Verifica si la suma es par

    // Retrasa la actualización para efecto visual
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        eleccionUsuario = usuarioEligePar ? 'PAR' : 'IMPAR';
        numeroUsuario = numeroElegido;
        this.numeroCPU = numeroCPU;

        // Determina ganador
        if (esPar == usuarioEligePar) {
          usuarioPuntos++;
          resultado = '¡VICTORIA! $numeroElegido + $numeroCPU = $suma (${esPar ? 'PAR' : 'IMPAR'})';
        } else {
          cpuPuntos++;
          resultado = 'DERROTA. $numeroElegido + $numeroCPU = $suma (${esPar ? 'PAR' : 'IMPAR'})';
        }
        _isAnimating = false;
      });

      // Muestra snackbar con resultado
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(esPar == usuarioEligePar ? Icons.celebration : Icons.mood_bad, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(child: Text(resultado)),
            ],
          ),
          backgroundColor: esPar == usuarioEligePar ? Colors.green[800] : Colors.red[800],
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

  // Reinicia el juego
  void reiniciar() {
    setState(() {
      usuarioPuntos = 0;
      cpuPuntos = 0;
      resultado = 'ELIGE PAR O IMPAR Y UN NÚMERO';
      eleccionUsuario = null;
      numeroUsuario = null;
      numeroCPU = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PAR O IMPAR - CYBER GAME'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: reiniciar,
            tooltip: 'Reiniciar juego',
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Marcador de puntos
              Card(
                color: Colors.black.withOpacity(0.3),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text('JUGADOR', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.cyan)),
                          Text('$usuarioPuntos', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.cyan)),
                        ],
                      ),
                      Container(width: 2, height: 60, color: Colors.white.withOpacity(0.3)),
                      Column(
                        children: [
                          const Text('CPU', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.pink)),
                          Text('$cpuPuntos', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.pink)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Muestra elección actual si existe
              if (eleccionUsuario != null)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.purple[800]!, Colors.blue[800]!]),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, color: Colors.cyan),
                      const SizedBox(width: 10),
                      Text('Elegiste: $eleccionUsuario - Número: $numeroUsuario', 
                           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      if (numeroCPU != null) ...[
                        const SizedBox(width: 20),
                        Icon(Icons.computer, color: Colors.pink),
                        const SizedBox(width: 10),
                        Text('CPU: $numeroCPU', style: const TextStyle(color: Colors.white)),
                      ],
                    ],
                  ),
                ),

              const SizedBox(height: 20),

              // Muestra resultado del juego
              Card(
                color: Colors.black.withOpacity(0.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    resultado,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: resultado.contains('VICTORIA')
                          ? Colors.green[400]
                          : resultado.contains('DERROTA')
                          ? Colors.red[400]
                          : Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Botones para elegir Par o Impar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildChoiceButton(
                    context,
                    isPar: true,
                    icon: Icons.check_circle,
                    label: 'ELEGIR PAR',
                    colors: [Colors.green[800]!, Colors.teal[600]!],
                  ),
                  _buildChoiceButton(
                    context,
                    isPar: false,
                    icon: Icons.cancel,
                    label: 'ELEGIR IMPAR',
                    colors: [Colors.red[800]!, Colors.orange[600]!],
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Botón para reiniciar
              OutlinedButton.icon(
                onPressed: reiniciar,
                icon: const Icon(Icons.restart_alt),
                label: const Text('REINICIAR SISTEMA'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Theme.of(context).colorScheme.secondary),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Construye botones de elección (Par/Impar)
  Widget _buildChoiceButton(BuildContext context, {
    required bool isPar,
    required IconData icon,
    required String label,
    required List<Color> colors,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      transform: _isAnimating ? (Matrix4.identity()..scale(0.95)) : Matrix4.identity(),
      child: ElevatedButton.icon(
        onPressed: _isAnimating ? null : () => _mostrarSelectorNumeros(isPar),
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.first,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  // Muestra diálogo para seleccionar número
  void _mostrarSelectorNumeros(bool esPar) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.purple[900]!, Colors.blue[900]!]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('SELECCIONA UN NÚMERO (0-5)', 
                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1)),
                const SizedBox(height: 10),
                Text('Para: ${esPar ? 'PAR' : 'IMPAR'}', 
                     style: TextStyle(fontSize: 16, color: esPar ? Colors.green[400] : Colors.red[400], fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                // Botones numéricos 0-5
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(6, (numero) {
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        jugar(esPar, numero);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(50, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text('$numero', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('CANCELAR', style: TextStyle(color: Colors.white70)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
