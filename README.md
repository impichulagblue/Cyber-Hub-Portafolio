# AppHub Portfolio + Kit Offline

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)
![Dart](https://img.shields.io/badge/Dart-2.19+-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Platform](https://img.shields.io/badge/Platform-Android-lightgrey.svg)

**Una aplicación portfolio que integra prácticas de desarrollo Flutter con módulos offline funcionales**

</div>

## 📱 Descripción General

AppHub Portfolio es una aplicación móvil desarrollada en Flutter que sirve como hub central para navegar entre prácticas de desarrollo y un kit de herramientas offline. La aplicación demuestra habilidades en navegación, gestión de estado, UI/UX y desarrollo de componentes modulares.

### 🎯 Características Principales

- **🏠 Hub Centralizado**: Navegación unificada con Drawer y rutas
- **📚 Portfolio de Prácticas**: Integración de 4 prácticas anteriores
- **🛠️ Kit Offline**: 4 módulos funcionales sin necesidad de conexión
- **🎨 UI Consistente**: Diseño material design con tema claro/oscuro
- **💾 Estado en Memoria**: Gestión local sin bases de datos externas

## 🏗️ Arquitectura del Proyecto
lib/
├── main.dart # Punto de entrada de la aplicación
├── hub/ # Pantalla principal del hub
│ └── hub_screen.dart
├── navigation/ # Sistema de navegación
│ └── app_drawer.dart
├── practices/ # Prácticas integradas
│ ├── practices_index_screen.dart
│ ├── practice1.dart # Mostrar/ocultar 10 elementos
│ ├── practice2.dart # Agregar elementos incrementalmente
│ ├── practice3.dart # Formulario de registro con validaciones
│ └── practice4.dart # Juego Piedra, Papel o Tijera
├── project/ # Kit Offline - Módulos principales
│ ├── kit_offline_screen.dart
│ ├── notes/ # Módulo 1: Notas rápidas
│ │ └── notes_screen.dart
│ ├── imc/ # Módulo 2: Calculadora IMC
│ │ └── imc_calculator_screen.dart
│ ├── gallery/ # Módulo 3: Galería local
│ │ └── gallery_screen.dart
│ └── game/ # Módulo 4: Juego Par/Impar
│ └── even_odd_game_screen.dart
└── settings/ # Configuración y tema
└── settings_screen.dart


## 🎮 Módulos del Kit Offline

### 1. 📝 Notas Rápidas
- Lista dinámica de notas temporales
- Agregar nuevas notas con FAB
- Eliminar notas individuales o en lote
- Feedback visual con SnackBars

### 2. ⚖️ Calculadora IMC
- Formulario con validaciones avanzadas
- Cálculo automático de Índice de Masa Corporal
- Clasificación por categorías de peso
- Botón de limpieza y reset

### 3. 🖼️ Galería Local
- Grid de imágenes desde assets locales
- Visualización ampliada con diálogo modal
- Navegación táctil intuitiva
- Manejo de errores elegante

### 4. 🎯 Juego Par o Impar
- Juego interactivo contra la CPU
- Sistema de marcador persistente
- Generación aleatoria de números
- Reinicio de estadísticas

## 🚀 Cómo Ejecutar el Proyecto

flutter pub get
flutter run
flutter build apk

Pantalla de inicio:
![Imagen de WhatsApp 2025-09-26 a las 00 49 10_ec1f3cc4](https://github.com/user-attachments/assets/a2f94add-dd84-4d38-8895-d34cece583b9)
