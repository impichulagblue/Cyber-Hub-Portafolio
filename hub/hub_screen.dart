// Importaciones de paquetes Flutter y widgets locales
import 'package:flutter/material.dart';
import '../navigation/app_drawer.dart'; // Drawer de navegación personalizado
import '../practices/practices_index_screen.dart'; // Pantalla de índice de prácticas
import '../project/kit_offline_screen.dart'; // Pantalla del proyecto kit offline
import '../settings/settings_screen.dart'; // Pantalla de ajustes

// Pantalla principal del hub/dashboard de la aplicación
class HubScreen extends StatelessWidget {
  const HubScreen({super.key}); // Constructor con clave opcional

  @override
  Widget build(BuildContext context) {
    // Estructura principal de la pantalla con Scaffold
    return Scaffold(
      // Barra de aplicación superior
      appBar: AppBar(
        title: const Text('CYBER-HUB Portfolio'), // Título de la app
        automaticallyImplyLeading: true, // Muestra el ícono de menú automáticamente
        backgroundColor: Theme.of(context).colorScheme.primary, // Color del tema actual
      ),
      drawer: const AppDrawer(), // Panel de navegación lateral
      // Cuerpo de la pantalla con fondo degradado
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // Inicio del degradado en la parte superior
            end: Alignment.bottomCenter, // Fin del degradado en la parte inferior
            colors: [
              Theme.of(context).colorScheme.background, // Color de fondo del tema
              Theme.of(context).colorScheme.surface, // Color de superficie del tema
            ],
          ),
        ),
        // Widget que permite hacer scroll en el contenido
        child: SingleChildScrollView( // ← AQUÍ SE AGREGA EL SCROLL
          padding: const EdgeInsets.all(20.0), // Espaciado interno alrededor del contenido
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Ocupa todo el ancho disponible
            children: [
              const SizedBox(height: 20), // Espacio en la parte superior
              _buildHeader(context), // Encabezado personalizado
              const SizedBox(height: 40), // Espacio entre encabezado y tarjetas
              // Tarjeta de navegación a prácticas
              DashboardCard(
                title: 'PRÁCTICAS',
                subtitle: 'Ver todas las prácticas realizadas',
                icon: Icons.code, // Ícono representativo
                gradient: _buildGradient(Colors.blue, Colors.cyan), // Degradado azul-cyan
                onTap: () => Navigator.pushNamed(context, '/practices'), // Navegación a prácticas
              ),
              const SizedBox(height: 20), // Espacio entre tarjetas
              // Tarjeta de navegación al proyecto kit offline
              DashboardCard(
                title: 'PROYECTO - KIT OFFLINE',
                subtitle: '4 módulos útiles sin conexión',
                icon: Icons.rocket_launch, // Ícono de proyecto/lanzamiento
                gradient: _buildGradient(Colors.purple, Colors.pink), // Degradado morado-rosa
                onTap: () => Navigator.pushNamed(context, '/project'), // Navegación a proyecto
              ),
              const SizedBox(height: 20), // Espacio entre tarjetas
              // Tarjeta de navegación a ajustes
              DashboardCard(
                title: 'AJUSTES',
                subtitle: 'Configuración y información',
                icon: Icons.settings, // Ícono de configuración
                gradient: _buildGradient(Colors.green, Colors.teal), // Degradado verde-teal
                onTap: () => Navigator.pushNamed(context, '/settings'), // Navegación a ajustes
              ),
              const SizedBox(height: 20), // ← Espacio extra al final para seguridad al hacer scroll
            ],
          ),
        ),
      ),
    );
  }

  // Método privado para construir el encabezado de la pantalla
  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        // Ícono principal grande
        Icon(
          Icons.security, // Ícono de seguridad/cyber
          size: 60, // Tamaño grande del ícono
          color: Theme.of(context).colorScheme.secondary, // Color del tema actual
        ),
        const SizedBox(height: 16), // Espacio entre ícono y texto
        // Título principal
        Text(
          'CYBER-HUB PORTFOLIO',
          style: TextStyle(
            fontSize: 28, // Tamaño grande de fuente
            fontWeight: FontWeight.bold, // Negrita para destacar
            color: Theme.of(context).colorScheme.secondary, // Color del tema
            letterSpacing: 2, // Espaciado entre letras para estilo moderno
          ),
          textAlign: TextAlign.center, // Centrado horizontal
        ),
        const SizedBox(height: 8), // Espacio entre título y subtítulo
        // Subtítulo descriptivo
        Text(
          'Sistema de Prácticas Flutter',
          style: TextStyle(
            fontSize: 16, // Tamaño normal de fuente
            color: Colors.grey[400], // Color gris claro
            letterSpacing: 1, // Espaciado sutil entre letras
          ),
          textAlign: TextAlign.center, // Centrado horizontal
        ),
      ],
    );
  }

  // Método auxiliar para crear degradados lineales
  LinearGradient _buildGradient(Color color1, Color color2) {
    return LinearGradient(
      colors: [color1, color2], // Colores del degradado
      begin: Alignment.topLeft, // Inicio en esquina superior izquierda
      end: Alignment.bottomRight, // Fin en esquina inferior derecha
    );
  }
}

// Widget personalizado para las tarjetas del dashboard
class DashboardCard extends StatelessWidget {
  // Propiedades requeridas para la tarjeta
  final String title; // Título principal de la tarjeta
  final String subtitle; // Subtítulo descriptivo
  final IconData icon; // Ícono a mostrar
  final Gradient gradient; // Degradado de fondo
  final VoidCallback onTap; // Función a ejecutar al hacer tap

  // Constructor que requiere todas las propiedades
  const DashboardCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Tarjeta con elevación y forma redondeada
    return Card(
      elevation: 16, // Sombra pronunciada para efecto de elevación
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Esquinas muy redondeadas
      ),
      // Contenedor con degradado de fondo
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient, // Degradado personalizado
          borderRadius: BorderRadius.circular(20), // Mismo radio que la tarjeta
        ),
        // Área clickeable con efecto de ripple
        child: InkWell(
          onTap: onTap, // Acción al hacer tap
          borderRadius: BorderRadius.circular(20), // Radio para el efecto de ripple
          // Contenido interno de la tarjeta
          child: Padding(
            padding: const EdgeInsets.all(20.0), // Espaciado interno
            child: Row( // Diseño en fila horizontal
              children: [
                // Contenedor circular para el ícono
                Container(
                  padding: const EdgeInsets.all(12), // Espaciado interno del círculo
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2), // Fondo blanco semitransparente
                    shape: BoxShape.circle, // Forma circular
                  ),
                  child: Icon(icon, size: 30, color: Colors.white), // Ícono blanco
                ),
                const SizedBox(width: 16), // Espacio entre ícono y texto
                // Columna con texto expandible
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Alineación izquierda
                    children: [
                      // Título de la tarjeta
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Texto blanco para contraste
                          letterSpacing: 1, // Espaciado entre letras
                        ),
                      ),
                      const SizedBox(height: 4), // Espacio pequeño entre título y subtítulo
                      // Subtítulo de la tarjeta
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8), // Blanco semitransparente
                        ),
                      ),
                    ],
                  ),
                ),
                // Ícono de flecha indicadora
                Container(
                  padding: const EdgeInsets.all(8), // Espaciado interno pequeño
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2), // Círculo semitransparente
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_forward, size: 16, color: Colors.white), // Flecha pequeña
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
