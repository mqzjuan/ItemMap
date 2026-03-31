<?php
require_once __DIR__ . '/config.php';

header('Content-Type: application/json; charset=utf-8');

$method = $_SERVER['REQUEST_METHOD'];
$action = $_GET['action'] ?? '';

switch ($action) {
    // ── ARTÍCULOS ──
    case 'listar':
        $buscar = $_GET['q'] ?? '';
        $ubicacion = $_GET['ubicacion'] ?? '';

        $sql = "SELECT a.*, a.medida, u.codigo AS ubicacion_codigo, u.descripcion AS ubicacion_desc, u.color AS ubicacion_color, u.fila AS ubicacion_fila, u.columna AS ubicacion_columna
                FROM articulos a
                LEFT JOIN ubicaciones u ON a.ubicacion_id = u.id
                WHERE 1=1";
        $params = [];

        if ($buscar !== '') {
            $sql .= " AND (a.codigo LIKE :q OR a.descripcion LIKE :q2)";
            $params[':q'] = "%$buscar%";
            $params[':q2'] = "%$buscar%";
        }
        if ($ubicacion !== '') {
            $sql .= " AND u.codigo = :ub";
            $params[':ub'] = $ubicacion;
        }

        $sql .= " ORDER BY a.descripcion ASC";
        $stmt = $pdo->prepare($sql);
        $stmt->execute($params);
        echo json_encode($stmt->fetchAll());
        break;

    case 'crear':
        if ($method !== 'POST') { http_response_code(405); exit; }
        $data = json_decode(file_get_contents('php://input'), true);

        $codigo = trim($data['codigo'] ?? '');
        $descripcion = trim($data['descripcion'] ?? '');
        $medida = trim($data['medida'] ?? '');
        $ubicacion_id = $data['ubicacion_id'] ?: null;
        $notas = trim($data['notas'] ?? '');

        if ($codigo === '' || $descripcion === '') {
            http_response_code(400);
            echo json_encode(['error' => 'Código y descripción son obligatorios']);
            exit;
        }

        $stmt = $pdo->prepare("INSERT INTO articulos (codigo, descripcion, medida, ubicacion_id, notas) VALUES (:c, :d, :m, :u, :n)");
        $stmt->execute([':c' => $codigo, ':d' => $descripcion, ':m' => $medida, ':u' => $ubicacion_id, ':n' => $notas]);
        echo json_encode(['id' => $pdo->lastInsertId(), 'mensaje' => 'Artículo creado']);
        break;

    case 'actualizar':
        if ($method !== 'POST') { http_response_code(405); exit; }
        $data = json_decode(file_get_contents('php://input'), true);

        $id = intval($data['id'] ?? 0);
        $codigo = trim($data['codigo'] ?? '');
        $descripcion = trim($data['descripcion'] ?? '');
        $medida = trim($data['medida'] ?? '');
        $ubicacion_id = $data['ubicacion_id'] ?: null;
        $notas = trim($data['notas'] ?? '');

        if ($id <= 0 || $codigo === '' || $descripcion === '') {
            http_response_code(400);
            echo json_encode(['error' => 'Datos inválidos']);
            exit;
        }

        $stmt = $pdo->prepare("UPDATE articulos SET codigo=:c, descripcion=:d, medida=:m, ubicacion_id=:u, notas=:n WHERE id=:id");
        $stmt->execute([':c' => $codigo, ':d' => $descripcion, ':m' => $medida, ':u' => $ubicacion_id, ':n' => $notas, ':id' => $id]);
        echo json_encode(['mensaje' => 'Artículo actualizado']);
        break;

    case 'eliminar':
        if ($method !== 'POST') { http_response_code(405); exit; }
        $data = json_decode(file_get_contents('php://input'), true);
        $id = intval($data['id'] ?? 0);

        if ($id <= 0) {
            http_response_code(400);
            echo json_encode(['error' => 'ID inválido']);
            exit;
        }

        $stmt = $pdo->prepare("DELETE FROM articulos WHERE id = :id");
        $stmt->execute([':id' => $id]);
        echo json_encode(['mensaje' => 'Artículo eliminado']);
        break;

    // ── UBICACIONES ──
    case 'ubicaciones':
        $stmt = $pdo->query("SELECT u.*, COUNT(a.id) AS total_articulos
                             FROM ubicaciones u
                             LEFT JOIN articulos a ON a.ubicacion_id = u.id
                             GROUP BY u.id
                             ORDER BY u.codigo ASC");
        echo json_encode($stmt->fetchAll());
        break;

    case 'ubicacion_crear':
        if ($method !== 'POST') { http_response_code(405); exit; }
        $data = json_decode(file_get_contents('php://input'), true);

        $codigo = trim($data['codigo'] ?? '');
        $descripcion = trim($data['descripcion'] ?? '');
        $color = trim($data['color'] ?? '#3b82f6');
        $fila = isset($data['fila']) && $data['fila'] !== '' ? intval($data['fila']) : null;
        $columna = isset($data['columna']) && $data['columna'] !== '' ? intval($data['columna']) : null;

        if ($codigo === '') {
            http_response_code(400);
            echo json_encode(['error' => 'Código de ubicación obligatorio']);
            exit;
        }

        $stmt = $pdo->prepare("INSERT INTO ubicaciones (codigo, descripcion, color, fila, columna) VALUES (:c, :d, :co, :f, :cl)");
        $stmt->execute([':c' => $codigo, ':d' => $descripcion, ':co' => $color, ':f' => $fila, ':cl' => $columna]);
        echo json_encode(['id' => $pdo->lastInsertId(), 'mensaje' => 'Ubicación creada']);
        break;

    case 'ubicacion_actualizar':
        if ($method !== 'POST') { http_response_code(405); exit; }
        $data = json_decode(file_get_contents('php://input'), true);

        $id = intval($data['id'] ?? 0);
        $codigo = trim($data['codigo'] ?? '');
        $descripcion = trim($data['descripcion'] ?? '');
        $color = trim($data['color'] ?? '#3b82f6');
        $fila = isset($data['fila']) && $data['fila'] !== '' ? intval($data['fila']) : null;
        $columna = isset($data['columna']) && $data['columna'] !== '' ? intval($data['columna']) : null;

        if ($id <= 0 || $codigo === '') {
            http_response_code(400);
            echo json_encode(['error' => 'Datos inválidos']);
            exit;
        }

        $stmt = $pdo->prepare("UPDATE ubicaciones SET codigo=:c, descripcion=:d, color=:co, fila=:f, columna=:cl WHERE id=:id");
        $stmt->execute([':c' => $codigo, ':d' => $descripcion, ':co' => $color, ':f' => $fila, ':cl' => $columna, ':id' => $id]);
        echo json_encode(['mensaje' => 'Ubicación actualizada']);
        break;

    case 'ubicacion_eliminar':
        if ($method !== 'POST') { http_response_code(405); exit; }
        $data = json_decode(file_get_contents('php://input'), true);
        $id = intval($data['id'] ?? 0);

        if ($id <= 0) {
            http_response_code(400);
            echo json_encode(['error' => 'ID inválido']);
            exit;
        }

        $stmt = $pdo->prepare("DELETE FROM ubicaciones WHERE id = :id");
        $stmt->execute([':id' => $id]);
        echo json_encode(['mensaje' => 'Ubicación eliminada']);
        break;

    // ── MAPA VISUAL ──
    case 'mapa':
        $stmt = $pdo->query("SELECT u.id, u.codigo, u.descripcion, u.color, u.fila, u.columna, u.pos_x, u.pos_y, COUNT(a.id) AS total_articulos
                             FROM ubicaciones u
                             LEFT JOIN articulos a ON a.ubicacion_id = u.id
                             GROUP BY u.id
                             ORDER BY u.fila ASC, u.columna ASC, u.codigo ASC");
        echo json_encode($stmt->fetchAll());
        break;

    case 'mapa_posicion':
        if ($method !== 'POST') { http_response_code(405); exit; }
        $data = json_decode(file_get_contents('php://input'), true);
        $id = intval($data['id'] ?? 0);
        $pos_x = intval($data['pos_x'] ?? 0);
        $pos_y = intval($data['pos_y'] ?? 0);

        if ($id <= 0) {
            http_response_code(400);
            echo json_encode(['error' => 'ID inválido']);
            exit;
        }

        $stmt = $pdo->prepare("UPDATE ubicaciones SET pos_x = :x, pos_y = :y WHERE id = :id");
        $stmt->execute([':x' => $pos_x, ':y' => $pos_y, ':id' => $id]);
        echo json_encode(['mensaje' => 'Posición guardada']);
        break;

    default:
        http_response_code(400);
        echo json_encode(['error' => 'Acción no válida']);
}
