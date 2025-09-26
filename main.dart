// Importaciones de paquetes de Flutter y archivos locales
import 'package:flutter/material.dart';
import 'hub/hub_screen.dart';
import 'practices/practices_index_screen.dart';
import 'practices/practice1.dart';
import 'practices/practice2.dart';
import 'practices/practice3.dart';
import 'practices/practice4.dart';
import 'project/kit_offline_screen.dart';
import 'settings/settings_screen.dart';
import 'project/notes/notes_screen.dart';
import 'project/imc/imc_calculator_screen.dart';
import 'project/gallery/gallery_screen.dart';
import 'project/game/even_odd_game_screen.dart';

// Función principal que inicia la aplicación Flutter
void main() {
  runApp(const MyApp()); // Ejecuta la aplicación con el widget MyApp como raíz
}

// Widget principal de la aplicación que es Stateful (tiene estado mutable)
class MyApp extends StatefulWidget {
  const MyApp({super.key}); // Constructor con clave opcional

  @override
  State<MyApp> createState() => _MyAppState(); // Crea el estado asociado a este widget
}

// Estado de la aplicación que maneja el tema y la configuración
class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark; // Estado inicial: tema oscuro

  // Método para cambiar entre tema claro y oscuro
  void _changeTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light; // Actualiza el estado del tema
    });
  }

  @override
  Widget build(BuildContext context) {
    // Configuración principal de la aplicación MaterialApp
    return MaterialApp(
      title: 'CYBER-HUB Portfolio', // Título de la aplicación
      debugShowCheckedModeBanner: false, // Oculta la etiqueta de debug
      theme: _buildLightTheme(), // Tema para modo claro
      darkTheme: _buildDarkTheme(), // Tema para modo oscuro
      themeMode: _themeMode, // Tema actual activo (claro/oscuro/automático)
      initialRoute: '/', // Ruta inicial al iniciar la app
      routes: {
        // Definición de todas las rutas de navegación de la aplicación
        '/': (context) => HubScreen(), // Pantalla principal/inicio
        '/practices': (context) => PracticesIndexScreen(), // Índice de prácticas
        '/practice1': (context) => Practice1(), // Práctica 1
        '/practice2': (context) => Practice2(), // Práctica 2
        '/practice3': (context) => Practice3(), // Práctica 3
        '/practice4': (context) => Practice4(), // Práctica 4
        '/project': (context) => KitOfflineScreen(), // Proyecto kit offline
        '/settings': (context) => SettingsScreen(onThemeChange: _changeTheme), // Configuraciones
        '/notes': (context) => NotesScreen(), // Pantalla de notas
        '/imc': (context) => IMCCalculatorScreen(), // Calculadora de IMC
        '/gallery': (context) => GalleryScreen(), // Galería de imágenes
        '/evenodd': (context) => EvenOddGameScreen(), // Juego par/impar
      },
    );
  }

  // Método para construir el tema claro personalizado
  ThemeData _buildLightTheme() {
    return ThemeData.light().copyWith(
      primaryColor: Colors.blue[800], // Color primario azul oscuro
      colorScheme: ColorScheme.light(
        primary: Colors.blue[800]!, // Color primario del esquema
        secondary: Colors.cyan[600]!, // Color secundario cyan
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue[900], // Fondo de AppBar azul muy oscuro
        foregroundColor: Colors.white, // Color del texto/icons en AppBar
      ),
      cardTheme: CardTheme( // CORREGIDO: CardTheme en lugar de CardThemeData
        elevation: 8, // Elevación/sombra de las tarjetas
        shadowColor: Colors.blue.withOpacity(0.3), // Color de la sombra con transparencia
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bordes redondeados
      ),
    );
  }

  // Método para construir el tema oscuro personalizado
  ThemeData _buildDarkTheme() {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.cyan[800], // Color primario cyan oscuro
      colorScheme: ColorScheme.dark(
        primary: Colors.cyan[800]!, // Color primario del esquema
        secondary: Colors.purple[400]!, // Color secundario morado
        surface: const Color(0xFF1A1A2E), // Color de superficie azul oscuro
        background: const Color(0xFF0F0F23), // Color de fondo azul muy oscuro
      ),
      scaffoldBackgroundColor: const Color(0xFF0F0F23), // Fondo principal de las pantallas
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.purple[900], // Fondo de AppBar morado oscuro
        foregroundColor: Colors.white, // Color del texto/icons en AppBar
      ),
      cardTheme: CardTheme( // CORREGIDO: CardTheme en lugar de CardThemeData
        elevation: 12, // Mayor elevación/sombra que en tema claro
        shadowColor: Colors.purple.withOpacity(0.5), // Sombra morada con transparencia
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Bordes más redondeados
          side: BorderSide(color: Colors.cyan.withOpacity(0.3), width: 1), // Borde cyan sutil
        ),
      ),
      dialogTheme: DialogTheme( // CORREGIDO: DialogTheme en lugar de DialogThemeData
        backgroundColor: const Color(0xFF1A1A2E), // Fondo de diálogos azul oscuro
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Bordes muy redondeados
          side: BorderSide(color: Colors.cyan.withOpacity(0.5), width: 2), // Borde cyan más marcado
        ),
      ),
    );
  }
}
