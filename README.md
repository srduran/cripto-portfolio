# Crypto Portfolio API - Rack App
API creada para convertir portafolios de criptomonedas a monedas fiat utilizando precios en tiempo real de la API de Buda. Esta API permite consultar precios de criptomonedas, calcular valores de portafolios y documentación OpenAPI compatible con Swagger.

---

## Requisitos
- Ruby `>= 2.7`
- Bundler (`gem install bundler` en caso de no tenerlo)

---

## Instalación
```bash
$ git clone https://github.com/srduran/crypto-portfolio.git
$ cd crypto-portfolio
$ bundle install
```

---

## Cómo levantar el servidor
```bash
$ rackup
```
Esto iniciará el servidor en: http://localhost:9292

---

## Documentación API
- La API está documentada en formato OpenAPI. Se puede visualizar en Swagger Editor online (editor.swagger.io)
- Es necesario tener corriendo la app para poder conectarse a través de localhost.

### Conversión de Portafolio
La API permite convertir portafolios de criptomonedas a monedas fiat usando precios en tiempo real:

```bash  
    POST /convert
    URL: http://localhost:9292/convert
    Body (JSON):
    {
      "portfolio": {
        "BTC": 0.5,
        "ETH": 2.0,
        "USDT": 1000
      },
      "fiat_currency": "CLP"
    }
    Respuesta esperada:
    {
      "amount": "$1060000.0 CLP"
    }
```

---

## Endpoints para probar

### Localmente
**GET** `/` \
Página de bienvenida de la API \
`curl http://localhost:9292/`

**POST** `/convert` \
Convierte un portafolio de criptomonedas a moneda fiat \
`curl -X POST http://localhost:9292/convert -H "Content-Type: application/json" -d '{"portfolio":{"BTC":0.5,"ETH":2.0,"USDT":1000},"fiat_currency":"CLP"}'`

**GET** `/openapi.yaml` \
Especificación OpenAPI en formato YAML \
`curl http://localhost:9292/openapi.yaml`

### En producción (Heroku)
**GET** `/` \
Página de bienvenida de la API \
`curl https://crypto-portfolio-api-233b6507668d.herokuapp.com/`

**POST** `/convert` \
Convierte un portafolio de criptomonedas a moneda fiat \
`curl -X POST https://crypto-portfolio-api-233b6507668d.herokuapp.com/convert -H "Content-Type: application/json" -d '{"portfolio":{"BTC":0.5,"ETH":2.0,"USDT":1000},"fiat_currency":"CLP"}'`

**GET** `/openapi.yaml` \
Especificación OpenAPI en formato YAML \
`curl https://crypto-portfolio-api-233b6507668d.herokuapp.com/openapi.yaml`

### Ejemplos de respuesta

#### Endpoint raíz (GET /)
```json
{
  "message": "crypto-portfolio welcome page"
}
```

#### Conversión exitosa (POST /convert)
```json
{
  "amount": "$1060000.0 CLP"
}
```

#### Error de validación (POST /convert)
```json
{
  "error": "Missing required fields: portfolio and fiat_currency"
}
```

---

## CORS
El proyecto incluye un middleware para permitir solicitudes desde navegadores o Swagger UI externo.

---

## Monedas Soportadas

### Criptomonedas
- BTC (Bitcoin)
- ETH (Ethereum) 
- USDT (Tether)
- Y todas las disponibles en la API de Buda

### Monedas Fiat
- CLP (Peso Chileno)
- PEN (Sol Peruano)
- COP (Peso Colombiano)
- Y todas las disponibles en la API de Buda

---

## Testing
Debemos estar en la carpeta raiz
```bash
$ ruby test/currency_converter_test.rb
```

### Tests incluidos
- Conversión exitosa con múltiples criptomonedas
- Manejo de errores de la API externa
- Cálculos correctos de valores

---

## Supuestos y Consideraciones
- **Disponibilidad**: Se asume que todos los pares de trading solicitados están disponibles
- **Errores**: Si falla cualquier criptomoneda, toda la operación falla