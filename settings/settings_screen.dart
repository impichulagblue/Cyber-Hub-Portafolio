import 'package:flutter/material.dart'; // Importa el paquete de Flutter para construir la interfaz
import '../navigation/app_drawer.dart'; // Importa el Drawer de navegación

class SettingsScreen extends StatefulWidget {
  final Function(bool) onThemeChange; // Callback para manejar el cambio de tema

  const SettingsScreen({super.key, required this.onThemeChange}); // Constructor de la clase

  @override
  State<SettingsScreen> createState() => _SettingsScreenState(); // Crea el estado de la pantalla
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _temaOscuro = true; // Variable que indica si el tema oscuro está activado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PANEL DE CONTROL'), // Título de la AppBar
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
          padding: const EdgeInsets.all(20.0), // Espaciado interno
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Alineación de los hijos hacia la izquierda
            children: [
              const SizedBox(height: 20), // Espacio en la parte superior
              _buildHeader(), // Método para construir el encabezado
              const SizedBox(height: 30), // Espacio entre el encabezado y la lista
              Expanded( // Expande la lista para ocupar el espacio restante
                child: ListView(
                  children: [
                    // Tarjeta para cambiar el tema
                    _buildSettingCard(
                      icon: Icons.dark_mode, // Ícono de modo oscuro
                      title: 'MODO CYBER', // Título de la tarjeta
                      subtitle: 'Activar/Desactivar tema oscuro', // Subtítulo
                      child: SwitchListTile( // Interruptor para seleccionar el modo
                        title: const Text('Tema Cyberpunk'), // Título del interruptor
                        subtitle: Text(_temaOscuro ? 'Activado' : 'Desactivado'), // Estado actual
                        value: _temaOscuro, // Valor del interruptor
                        onChanged: (value) { // Callback al cambiar el interruptor
                          setState(() {
                            _temaOscuro = value; // Actualiza el estado
                          });
                          widget.onThemeChange(value); // Llama al callback para notificar el cambio
                          ScaffoldMessenger.of(context).showSnackBar( // Muestra un SnackBar
                            SnackBar(
                              content: Row(
                                children: [
                                  Icon(
                                    value ? Icons.nightlight_round : Icons.wb_sunny, // Ícono según el estado
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 10), // Espacio entre ícono y texto
                                  Text('Modo ${value ? 'Cyberpunk' : 'Claro'} activado'), // Mensaje
                                ],
                              ),
                              backgroundColor: value ? Colors.purple[800] : Colors.blue[800], // Color del fondo
                            ),
                          );
                        },
                        activeColor: Colors.cyan, // Color del interruptor cuando está activo
                      ),
                    ),
                    const SizedBox(height: 20), // Espacio entre tarjetas
                    // Tarjeta para información del sistema
                    _buildSettingCard(
                      icon: Icons.info, // Ícono de información
                      title: 'INFORMACIÓN DEL SISTEMA', // Título de la tarjeta
                      subtitle: 'Detalles de la aplicación', // Subtítulo
                      child: ListTile(
                        leading: const Icon(Icons.verified_user), // Ícono de usuario verificado
                        title: const Text('Versión del Sistema'), // Título de la lista
                        subtitle: const Text('CYBER-HUB v1.0.0'), // Subtítulo con versión
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // Espaciado
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.2), // Fondo del contenedor
                            borderRadius: BorderRadius.circular(10), // Esquinas redondeadas
                            border: Border.all(color: Colors.green), // Borde del contenedor
                          ),
                          child: const Text('STABLE', style: TextStyle(color: Colors.green, fontSize: 10)), // Estado
                        ),
                        onTap: () { // Acción al tocar la tarjeta
                          showAboutDialog( // Muestra el diálogo de información
                            context: context,
                            applicationName: 'CYBER-HUB Portfolio', // Nombre de la aplicación
                            applicationVersion: 'v1.0.0', // Versión de la aplicación
                            applicationIcon: Container( // Ícono de la aplicación
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                gradient: LinearGradient( // Degradado del ícono
                                  colors: [Colors.cyan, Colors.purple],
                                ),
                                shape: BoxShape.circle, // Forma circular
                              ),
                              child: const Icon(Icons.security, color: Colors.white), // Ícono de seguridad
                            ),
                            children: [ // Contenido del diálogo
                              const SizedBox(height: 10), // Espacio
                              const Text(
                                'Sistema de Prácticas Flutter', // Descripción del sistema
                                style: TextStyle(fontWeight: FontWeight.bold), // Estilo en negrita
                              ),
                              const SizedBox(height: 5), // Espacio
                              const Text('Desarrollado con tecnología avanzada'), // Descripción adicional
                              const SizedBox(height: 10), // Espacio
                              Container(
                                padding: const EdgeInsets.all(8), // Espaciado interno
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.1), // Fondo del contenedor
                                  borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
                                ),
                                child: const Text(
                                  '🔒 Sistema Offline Seguro\n🚀 4 Módulos Funcionales\n🎯 Navegación Optimizada', // Texto descriptivo
                                  textAlign: TextAlign.center, // Alineación centrada
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20), // Espacio entre tarjetas
                    // Tarjeta para el estado del sistema
                    _buildSettingCard(
                      icon: Icons.developer_mode, // Ícono de estado del sistema
                      title: 'ESTADO DEL SISTEMA', // Título de la tarjeta
                      subtitle: 'Métricas y estadísticas', // Subtítulo
                      child: Column( // Contenido de la tarjeta
                        children: [
                          // Métricas del sistema
                          _buildMetricItem('Módulos Cargados', '4/4', Icons.check_circle, Colors.green), // Módulos cargados
                          _buildMetricItem('Estado Offline', 'Activo', Icons.offline_bolt, Colors.cyan), // Estado offline
                          _buildMetricItem('Rendimiento', 'Óptimo', Icons.speed, Colors.blue), // Rendimiento
                          _buildMetricItem('Seguridad', 'Máxima', Icons.security, Colors.purple), // Seguridad
                        ],
                      ),
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
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Alineación hacia la izquierda
      children: [
        Row(
          children: [
            Icon(
              Icons.settings, // Ícono de configuración
              size: 35, // Tamaño del ícono
              color: Theme.of(context).colorScheme.secondary, // Color del ícono
            ),
            const SizedBox(width: 10), // Espacio entre ícono y texto
            Text(
              'PANEL DE CONTROL', // Título del encabezado
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
          'Configuración y estado del sistema', // Descripción
          style: TextStyle(
            fontSize: 14, // Tamaño de fuente
            color: Colors.grey[400], // Color del texto
            letterSpacing: 1, // Espaciado entre letras
          ),
        ),
      ],
    );
  }

  // Método para construir una tarjeta de configuración
  Widget _buildSettingCard({
    required IconData icon, // Ícono de la tarjeta
    required String title, // Título de la tarjeta
    required String subtitle, // Subtítulo de la tarjeta
    required Widget child, // Contenido de la tarjeta
  }) {
    return Card(
      elevation: 8, // Elevación de la tarjeta
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Esquinas redondeadas
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient( // Degradado de fondo
            colors: [Colors.purple[900]!, Colors.blue[900]!], // Colores del degradado
            begin: Alignment.topLeft, // Comienza en la esquina superior izquierda
            end: Alignment.bottomRight, // Termina en la esquina inferior derecha
          ),
          borderRadius: BorderRadius.circular(16), // Esquinas redondeadas
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Espaciado interno
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Alineación hacia la izquierda
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8), // Espaciado interno
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2), // Color de fondo
                      shape: BoxShape.circle, // Forma circular
                    ),
                    child: Icon(icon, size: 20, color: Colors.white), // Ícono de la tarjeta
                  ),
                  const SizedBox(width: 10), // Espacio entre ícono y texto
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Alineación hacia la izquierda
                      children: [
                        Text(
                          title, // Título de la tarjeta
                          style: const TextStyle(
                            fontSize: 16, // Tamaño de fuente
                            fontWeight: FontWeight.bold, // Negrita
                            color: Colors.white, // Color del texto
                            letterSpacing: 1, // Espaciado entre letras
                          ),
                        ),
                        Text(
                          subtitle, // Subtítulo de la tarjeta
                          style: TextStyle(
                            fontSize: 12, // Tamaño de fuente
                            color: Colors.white.withOpacity(0.7), // Color del texto
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10), // Espacio entre el encabezado y el contenido
              child, // Contenido de la tarjeta
            ],
          ),
        ),
      ),
    );
  }

  // Método para construir un elemento de métrica
  Widget _buildMetricItem(String title, String value, IconData icon, Color color) {
    return ListTile(
      leading: Icon(icon, color: color), // Ícono de la métrica
      title: Text(title, style: const TextStyle(color: Colors.white70)), // Título de la métrica
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), // Espaciado
        decoration: BoxDecoration(
          color: color.withOpacity(0.2), // Fondo del contenedor
          borderRadius: BorderRadius.circular(10), // Esquinas redondeadas
          border: Border.all(color: color), // Borde del contenedor
        ),
        child: Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold)), // Valor de la métrica
      ),
    );
  }
}
