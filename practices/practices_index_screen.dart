import 'package:flutter/material.dart';
import '../navigation/app_drawer.dart';
import 'practice1.dart';
import 'practice2.dart';
import 'practice3.dart';
import 'practice4.dart';

// Pantalla que muestra la lista de prácticas disponibles
class PracticesIndexScreen extends StatelessWidget {
  const PracticesIndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Índice de Prácticas'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: true,  // Muestra botón de menú
      ),
      drawer: const AppDrawer(),  // Drawer de navegación
      body: Container(
        // Fondo con gradiente
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Título principal
              Text(
                'PRÁCTICAS DISPONIBLES',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              // Subtítulo descriptivo
              Text(
                'Selecciona una práctica para verla',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 30),
              // Lista de prácticas
              Expanded(
                child: ListView(
                  children: [
                    // Tarjeta para Práctica 1
                    PracticeCard(
                      title: 'Práctica 1',
                      subtitle: 'Agregar Hola Mundos',
                      icon: Icons.code,
                      number: '01',
                      gradient: LinearGradient(colors: [Colors.blue[800]!, Colors.cyan[600]!]),
                      onTap: () => Navigator.pushNamed(context, '/practice1'),
                    ),
                    const SizedBox(height: 16),
                    // Tarjeta para Práctica 2
                    PracticeCard(
                      title: 'Práctica 2',
                      subtitle: 'Lista dinámica con botones',
                      icon: Icons.list_alt,
                      number: '02',
                      gradient: LinearGradient(colors: [Colors.purple[800]!, Colors.pink[600]!]),
                      onTap: () => Navigator.pushNamed(context, '/practice2'),
                    ),
                    const SizedBox(height: 16),
                    // Tarjeta para Práctica 3
                    PracticeCard(
                      title: 'Práctica 3',
                      subtitle: 'Formulario de registro con validación',
                      icon: Icons.app_registration,
                      number: '03',
                      gradient: LinearGradient(colors: [Colors.green[800]!, Colors.teal[600]!]),
                      onTap: () => Navigator.pushNamed(context, '/practice3'),
                    ),
                    const SizedBox(height: 16),
                    // Tarjeta para Práctica 4
                    PracticeCard(
                      title: 'Práctica 4',
                      subtitle: 'Juego: Piedra, Papel o Tijera',
                      icon: Icons.sports_esports,
                      number: '04',
                      gradient: LinearGradient(colors: [Colors.orange[800]!, Colors.red[600]!]),
                      onTap: () => Navigator.pushNamed(context, '/practice4'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget personalizado para las tarjetas de práctica
class PracticeCard extends StatelessWidget {
  final String title;        // Título de la práctica
  final String subtitle;     // Descripción
  final IconData icon;       // Ícono representativo
  final String number;       // Número de práctica
  final Gradient gradient;   // Gradiente de colores
  final VoidCallback onTap;  // Función al hacer tap

  const PracticeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.number,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,  // Sombra de la tarjeta
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,  // Aplica el gradiente
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          // Ícono a la izquierda
          leading: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),  // Fondo semitransparente
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white),
          ),
          // Título principal
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
          // Subtítulo
          subtitle: Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.8))),
          // Número a la derecha
          trailing: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Text(number, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          onTap: onTap,  // Navegación al hacer tap
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
