# Validación del Dockerfile

# Pasos para Validar el Dockerfile

# 1. Preparar un entorno de prueba local:
	# Crea un directorio para el proyecto e incluye el archivo `Dockerfile`.

# 2. Construir la imagen:
   docker build -t pest-php:latest --build-arg PEST_VERSION=3 .
	# Repite la construcción con `PEST_VERSION=2` para validar ambas versiones.

# 3. Ejecutar un contenedor:
   docker run --rm pest-php:latest pest --version
   
	# Verifica que Pest esté instalado y la versión coincida con la esperada.

# 4. Prueba de extensiones PHP:
	# Ejecuta un comando como este dentro del contenedor para listar las extensiones instaladas:
     docker run --rm pest-php:latest php -m
     

# 5. Verificación de Xdebug:
	# Asegúrate de que `XDEBUG_MODE` esté configurado correctamente.
	docker run --rm pest-php:latest php -i | grep XDEBUG_MODE