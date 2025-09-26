import 'package:flutter/material.dart';

// Widget personalizado para el panel de navegación lateral (Drawer)
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key}); // Constructor con clave opcional

  @override
  Widget build(BuildContext context) {
    // Retorna un Drawer estándar de Material Design
    return Drawer(
      // Fondo del drawer usando el color de superficie del tema actual
      backgroundColor: Theme.of(context).colorScheme.surface,
      // Lista scrollable de elementos del drawer
      child: ListView(
        padding: EdgeInsets.zero, // Elimina el padding por defecto
        children: [
          // Encabezado del drawer con degradado
          Container(
            height: 180, // Altura fija para el encabezado
            decoration: BoxDecoration(
              // Degradado que usa los colores primario y secundario del tema
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
                begin: Alignment.topLeft, // Inicio del degradado en esquina superior izquierda
                end: Alignment.bottomRight, // Fin del degradado en esquina inferior derecha
              ),
            ),
            // Contenido centrado verticalmente dentro del encabezado
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centrado vertical
              children: [
                // Ícono principal del drawer
                Icon(
                  Icons.terminal, // Ícono de terminal/consola (temática cyber)
                  size: 50, // Tamaño grande del ícono
                  color: Colors.white, // Color blanco para contraste con el degradado
                ),
                const SizedBox(height: 10), // Espacio entre ícono y texto
                // Título principal del drawer
                const Text(
                  'CYBER-HUB',
                  style: TextStyle(
                    color: Colors.white, // Texto blanco
                    fontSize: 24, // Tamaño grande de fuente
                    fontWeight: FontWeight.bold, // Negrita para destacar
                    letterSpacing: 2, // Espaciado entre letras para estilo moderno
                  ),
                ),
                // Versión de la aplicación
                Text(
                  'v1.0.0', // Versión actual de la app
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8), // Blanco semitransparente
                    fontSize: 12, // Tamaño pequeño de fuente
                  ),
                ),
              ],
            ),
          ),
          
          // Elemento del drawer para navegar al Inicio
          _buildDrawerItem(
            context,
            icon: Icons.home, // Ícono de hogar/inicio
            title: 'Inicio', // Texto descriptivo
            route: '/', // Ruta hacia la pantalla principal
          ),
          
          // Elemento del drawer para navegar al Índice de Prácticas
          _buildDrawerItem(
            context,
            icon: Icons.list_alt, // Ícono de lista/tareas
            title: 'Índice de Prácticas', // Texto descriptivo
            route: '/practices', // Ruta hacia el índice de prácticas
          ),
          
          // Elemento del drawer para navegar al Proyecto Kit Offline
          _buildDrawerItem(
            context,
            icon: Icons.rocket_launch, // Ícono de cohete/proyecto
            title: 'Proyecto - Kit Offline', // Texto descriptivo
            route: '/project', // Ruta hacia el proyecto
          ),
          
          // Elemento del drawer para navegar a Ajustes
          _buildDrawerItem(
            context,
            icon: Icons.settings, // Ícono de configuración/ajustes
            title: 'Ajustes', // Texto descriptivo
            route: '/settings', // Ruta hacia ajustes
          ),
        ],
      ),
    );
  }

  // Método auxiliar para construir elementos individuales del drawer
  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon, // Ícono requerido para el elemento
    required String title, // Texto requerido para el elemento
    required String route, // Ruta requerida para la navegación
  }) {
    return Container(
      // Margen alrededor de cada elemento para separación visual
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      // Decoración con bordes redondeados
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Esquinas redondeadas
        color: Theme.of(context).colorScheme.surface, // Color de fondo del tema
      ),
      // Elemento de lista interactivo
      child: ListTile(
        // Ícono a la izquierda del texto
        leading: Icon(
          icon, 
          color: Theme.of(context).colorScheme.secondary, // Color secundario del tema
        ),
        // Título/texto del elemento
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white, // Texto blanco
            fontWeight: FontWeight.w500, // Peso de fuente medio (semi-negrita)
          ),
        ),
        // Acción al hacer tap en el elemento
        onTap: () {
          // Cierra el drawer primero
          Navigator.pop(context);
          // Navega a la ruta especificada reemplazando la pantalla actual
          Navigator.pushReplacementNamed(context, route);
        },
        // Forma con bordes redondeados para el área de tap
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
