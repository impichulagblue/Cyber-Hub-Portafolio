import 'package:flutter/material.dart';
import '../../navigation/app_drawer.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  // Lista de rutas de imágenes locales
  final List<String> imagenes = const [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.jpg',
    'assets/images/image4.jpg',
    'assets/images/image5.jpg',
    'assets/images/image6.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GALERÍA CYBER'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: true,
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
        child: Column(
          children: [
            // Encabezado de la galería
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Icon(Icons.photo_library, size: 30, color: Theme.of(context).colorScheme.secondary),
                  const SizedBox(width: 10),
                  Text(
                    'GALERÍA LOCAL',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            // Grid de imágenes
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,  // 2 columnas
                padding: const EdgeInsets.all(16.0),
                crossAxisSpacing: 16,  // Espacio entre columnas
                mainAxisSpacing: 16,   // Espacio entre filas
                children: imagenes.map((imagen) {
                  return _buildImageCard(context, imagen);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Construye una tarjeta individual para cada imagen
  Widget _buildImageCard(BuildContext context, String imagen) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.purple[800]!, Colors.pink[600]!]),
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: () => _mostrarImagenAmpliada(context, imagen),  // Al tap, amplía imagen
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Contenedor de la imagen
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imagen,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    // Maneja errores si la imagen no se encuentra
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.broken_image, size: 40, color: Colors.white54),
                          SizedBox(height: 8),
                          Text('Imagen no encontrada', style: TextStyle(color: Colors.white54)),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Overlay inferior con nombre del archivo
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    imagen.split('/').last,  // Muestra solo el nombre del archivo
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Muestra la imagen en tamaño completo en un diálogo
  void _mostrarImagenAmpliada(BuildContext context, String imagen) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    // Imagen ampliada
                    Image.asset(
                      imagen,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 300,
                          height: 300,
                          color: Colors.grey[900],
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error, size: 50, color: Colors.red),
                              SizedBox(height: 10),
                              Text('Imagen no encontrada'),
                            ],
                          ),
                        );
                      },
                    ),
                    // Botón de cerrar
                    Positioned(
                      top: 10,
                      right: 10,
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.5),
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                  ],
                ),
                // Pie de foto con nombre del archivo
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: Colors.black.withOpacity(0.8),
                  child: Text(
                    imagen.split('/').last,
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
