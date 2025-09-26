import 'package:flutter/material.dart'; // Importa el paquete de Flutter para construir la interfaz
import '../navigation/app_drawer.dart'; // Importa el Drawer de navegación

class KitOfflineScreen extends StatelessWidget {
  const KitOfflineScreen({super.key}); // Constructor de la clase

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KIT OFFLINE - CYBER MODULES'), // Título de la AppBar
        backgroundColor: Theme.of(context).colorScheme.primary, // Color de fondo de la AppBar
        automaticallyImplyLeading: true, // Muestra el botón de retroceso
      ),
      drawer: const AppDrawer(), // Añade el Drawer de navegación
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient( // Degradado de fondo
            begin: Alignment.topCenter, // Comienza en la parte superior
            end: Alignment.bottomCenter, // Termina en la parte inferior
            colors: [
              Theme.of(context).colorScheme.background, // Color de fondo
              Theme.of(context).colorScheme.surface, // Color de superficie
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Espaciado interior
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Alineación de los hijos hacia la izquierda
            children: [
              const SizedBox(height: 20), // Espacio en la parte superior
              _buildHeader(context), // Método para construir el encabezado
              const SizedBox(height: 30), // Espacio entre el encabezado y el grid
              Expanded( // Expande el GridView para ocupar el espacio restante
                child: GridView.count(
                  crossAxisCount: 2, // Número de columnas en el grid
                  crossAxisSpacing: 16, // Espaciado entre columnas
                  mainAxisSpacing: 16, // Espaciado entre filas
                  children: [
                    // Tarjetas de módulos
                    _buildModuleCard(
                      context,
                      title: 'NOTAS RÁPIDAS', // Título del módulo
                      subtitle: 'Editor temporal', // Subtítulo del módulo
                      icon: Icons.note_alt, // Ícono del módulo
                      colors: [Colors.purple, Colors.pink], // Colores del degradado
                      route: '/notes', // Ruta de navegación
                    ),
                    _buildModuleCard(
                      context,
                      title: 'CALCULADORA IMC',
                      subtitle: 'Salud digital',
                      icon: Icons.monitor_heart,
                      colors: [Colors.blue, Colors.cyan],
                      route: '/imc',
                    ),
                    _buildModuleCard(
                      context,
                      title: 'GALERÍA LOCAL',
                      subtitle: 'Visualizador de assets',
                      icon: Icons.photo_library,
                      colors: [Colors.green, Colors.teal],
                      route: '/gallery',
                    ),
                    _buildModuleCard(
                      context,
                      title: 'PAR O IMPAR',
                      subtitle: 'Juego vs CPU',
                      icon: Icons.casino,
                      colors: [Colors.orange, Colors.red],
                      route: '/evenodd',
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

  // Método para construir el encabezado
  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Alineación hacia la izquierda
      children: [
        Row(
          children: [
            Icon(
              Icons.offline_bolt, // Ícono de módulo offline
              size: 40, // Tamaño del ícono
              color: Theme.of(context).colorScheme.secondary, // Color del ícono
            ),
            const SizedBox(width: 10), // Espacio entre el ícono y el texto
            Text(
              'MÓDULOS OFFLINE', // Título del encabezado
              style: TextStyle(
                fontSize: 28, // Tamaño de fuente
                fontWeight: FontWeight.bold, // Negrita
                color: Theme.of(context).colorScheme.secondary, // Color del texto
                letterSpacing: 2, // Espaciado entre letras
              ),
            ),
          ],
        ),
        const SizedBox(height: 8), // Espacio entre el título y la descripción
        Text(
          '4 herramientas funcionales sin conexión a internet', // Descripción
          style: TextStyle(
            fontSize: 14, // Tamaño de fuente
            color: Colors.grey[400], // Color del texto
            letterSpacing: 1, // Espaciado entre letras
          ),
        ),
      ],
    );
  }

  // Método para construir una tarjeta de módulo
  Widget _buildModuleCard(BuildContext context, {
    required String title, // Título del módulo
    required String subtitle, // Subtítulo del módulo
    required IconData icon, // Ícono del módulo
    required List<Color> colors, // Colores del degradado
    required String route, // Ruta de navegación
  }) {
    return Card(
      elevation: 12, // Elevación de la tarjeta
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Esquinas redondeadas
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient( // Degradado de fondo
            colors: colors, // Colores del degradado
            begin: Alignment.topLeft, // Comienza en la esquina superior izquierda
            end: Alignment.bottomRight, // Termina en la esquina inferior derecha
          ),
          borderRadius: BorderRadius.circular(20), // Esquinas redondeadas
          boxShadow: [ // Sombra de la tarjeta
            BoxShadow(
              color: colors.first.withOpacity(0.4), // Color de sombra
              blurRadius: 10, // Difuminado de la sombra
              offset: const Offset(0, 4), // Desplazamiento de la sombra
            ),
          ],
        ),
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, route), // Navega a la ruta al hacer clic
          borderRadius: BorderRadius.circular(20), // Esquinas redondeadas
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Espaciado interior
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centra el contenido
              children: [
                Container(
                  padding: const EdgeInsets.all(12), // Espaciado interior
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2), // Color de fondo
                    shape: BoxShape.circle, // Forma circular
                  ),
                  child: Icon(icon, size: 30, color: Colors.white), // Ícono del módulo
                ),
                const SizedBox(height: 12), // Espacio entre ícono y título
                Text(
                  title, // Título del módulo
                  style: const TextStyle(
                    fontSize: 14, // Tamaño de fuente
                    fontWeight: FontWeight.bold, // Negrita
                    color: Colors.white, // Color del texto
                    letterSpacing: 1, // Espaciado entre letras
                  ),
                  textAlign: TextAlign.center, // Alineación del texto
                ),
                const SizedBox(height: 4), // Espacio entre título y subtítulo
                Text(
                  subtitle, // Subtítulo del módulo
                  style: TextStyle(
                    fontSize: 10, // Tamaño de fuente
                    color: Colors.white.withOpacity(0.8), // Color del texto
                  ),
                  textAlign: TextAlign.center, // Alineación del texto
                ),
                const SizedBox(height: 8), // Espacio entre subtítulo y flecha
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), // Espaciado
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2), // Color de fondo
                    borderRadius: BorderRadius.circular(10), // Esquinas redondeadas
                  ),
                  child: const Icon(Icons.arrow_forward, size: 12, color: Colors.white), // Ícono de flecha
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
