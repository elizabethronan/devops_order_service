# Order Service

A Node.js/Express REST API for managing orders in the ecommerce platform.
Communicates internally with the product service to validate products.

## Technology Stack
- Node.js 22
- Express.js
- PostgreSQL
- Docker

## Local Development

### Prerequisites
- Node.js 22+
- npm
- PostgreSQL
- Product service running on port 3001

### Install Dependencies
```bash
npm install
```

### Run Development Server
```bash
node src/index.js
```

Service runs on `http://localhost:3002`

### Run Tests
```bash
npm test
```

## API Endpoints
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | /orders | Get all orders |
| GET | /orders/:id | Get order by ID |
| POST | /orders | Create an order |
| PUT | /orders/:id | Update an order |
| DELETE | /orders/:id | Delete an order |
| GET | /health | Health check |

## Docker

### Build Image
```bash
docker build -t eronan22/order-service:latest .
```

### Run Container
```bash
docker run -p 3002:3002 eronan22/order-service:latest
```

## Environment Variables
| Variable | Description | Default |
|----------|-------------|---------|
| PORT | Service port | 3002 |
| DB_HOST | Database host | database |
| DB_PORT | Database port | 5432 |
| DB_NAME | Database name | ecommerce |
| DB_USER | Database user | admin |
| DB_PASSWORD | Database password | - |
| PRODUCT_SERVICE_URL | Product service URL | http://product-service:3001 |

## CI/CD
This service uses a Jenkins pipeline defined in `Jenkinsfile`.
Pipeline stages: PR Validation → Build → Test → Security Scan → 
Container Build & Push → Deploy

## Docker Hub
```
eronan22/order-service
```