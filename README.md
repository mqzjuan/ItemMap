# ItemMap - Sistema de Ubicación de Artículos

Aplicación web para gestionar y ubicar artículos rápidamente en estantes, muebles o cualquier sistema de almacenamiento organizado por filas y columnas.

## Descripción

**ItemMap** permite:

- **Crear artículos** con código, descripción, tipo de medida (blister, caja, unidad, etc.) y asignarlos a una ubicación.
- **Buscar artículos** en tiempo real por código o descripción, con filtro por ubicación.
- **Gestionar ubicaciones** con código, descripción, color, fila y columna.
- **Mapa visual** que replica tu mueble/estante real como una grilla de Fila × Columna. Al buscar un artículo en el mapa, la ubicación donde se encuentra **se ilumina y pulsa en verde** para encontrarlo al instante.
- **Fila × Columna**: cada ubicación tiene su coordenada (ej: `F3×C2`) para que sepas exactamente dónde ir a buscar en tu mueble físico.

## Requisitos

- **XAMPP** (o cualquier servidor con Apache + PHP + MySQL)
  - PHP 7.4 o superior (con extensión PDO MySQL)
  - MySQL 5.7 o superior / MariaDB 10.3+
- Un navegador web moderno (Chrome, Firefox, Edge)

> **No se requiere**: Node.js, Composer, ni ninguna dependencia externa. Todo funciona con PHP vanilla y JavaScript puro.

## Instalación

### 1. Clonar el repositorio

```bash
git clone https://github.com/mqzjuan/ItemMap.git
cd ItemMap
```

### 2. Ubicar en el servidor web

Copiar o clonar directamente dentro de la carpeta de tu servidor web:

```
# XAMPP (Windows)
C:\xampp\htdocs\ItemMap\

# XAMPP (Linux/Mac)
/opt/lampp/htdocs/ItemMap/
```

### 3. Configurar la base de datos

Copiar el archivo de configuración de entorno:

```bash
cp .env.example .env
```

Editar `.env` con tus credenciales de MySQL:

```env
DB_HOST=localhost
DB_PORT=3306
DB_NAME=estantes_db
DB_USER=root
DB_PASS=
```

### 4. Crear la base de datos

Importar el esquema SQL desde phpMyAdmin o por terminal:

```bash
mysql -u root < database.sql
```

O desde la terminal de XAMPP:

```bash
c:\xampp\mysql\bin\mysql.exe -u root < database.sql
```

Esto creará la base de datos `estantes_db` con las tablas necesarias y ubicaciones de ejemplo.

### 5. Abrir la aplicación

Iniciar Apache y MySQL desde el panel de XAMPP, luego abrir en el navegador:

```
http://localhost/ItemMap/
```

## Estructura del proyecto

```
ItemMap/
├── index.html      # Frontend completo (HTML + CSS + JS)
├── api.php         # API REST en PHP
├── config.php      # Conexión a base de datos (lee .env)
├── database.sql    # Esquema SQL + datos de ejemplo
├── .env            # Variables de entorno (no se sube al repo)
├── .env.example    # Plantilla de variables de entorno
├── .htaccess       # Protege el archivo .env de acceso web
└── README.md
```

## Uso

### Artículos
- Crear, editar y eliminar artículos
- Asignar tipo de medida: Blister, Caja, Unidad, Paquete, Bolsa, Frasco, Tubo, Sobre
- Asignar a una ubicación existente
- Buscar por código o descripción con filtro por ubicación

### Ubicaciones
- Crear ubicaciones con código libre (A1, B2, MESA1, etc.)
- Asignar fila y columna para el mapa visual
- Color personalizable por ubicación

### Mapa Visual
- Grilla que replica tu mueble con encabezados Fila/Columna
- Buscador: escribe el código o nombre de un artículo y la ubicación se ilumina en verde
- Click en una tarjeta para ver los artículos que contiene

## Tecnologías

- **Frontend**: HTML5, CSS3, JavaScript (vanilla, sin frameworks)
- **Backend**: PHP (PDO para consultas seguras)
- **Base de datos**: MySQL / MariaDB
- **Servidor**: Apache (XAMPP)

## Repositorio

[https://github.com/mqzjuan/ItemMap.git](https://github.com/mqzjuan/ItemMap.git)

## Licencia

MIT
