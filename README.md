# ckanext-aemet

CKAN extension for visualizing AEMET (Spanish Meteorological Agency) weather prediction data.

## Overview

This extension provides custom visualization tools for weather prediction data from Spain's AEMET (Agencia Estatal de Meteorología). It includes resource views optimized for displaying weather forecasts with temperature, precipitation, wind, and other meteorological variables.

## Requirements

- **CKAN**: 2.10 or higher
- **Python**: 3.10 or higher
- **PostgreSQL**: 14 or higher
- **Docker & Docker Compose**: For development environment

## Installation

### Development Setup with Docker

1. **Clone the repository** (if not already done):
   ```bash
   cd /path/to/ckanext-aemet
   ```

2. **Create `.env` file** from the example and generate a secure key:
   ```bash
   cp .env.example .env
   python3 -c 'import secrets; print("CKAN_SECRET_KEY=" + secrets.token_hex(32))' > .env
   ```

3. **Start Docker containers**:
   ```bash
   docker-compose up -d
   ```

4. **Wait for services to initialize** (this may take a few minutes on first run):
   ```bash
   docker-compose logs -f ckan
   ```

5. **Access CKAN**:
   - Open your browser to: http://localhost:5000
   - A sysadmin user (`admin` / `admin123`) is created automatically via environment variables

### Manual Installation (Production)

1. **Activate your CKAN virtual environment**:
   ```bash
   . /usr/lib/ckan/default/bin/activate
   ```

2. **Install the extension**:
   ```bash
   cd /path/to/ckanext-aemet
   pip install -e .
   ```

3. **Add the plugin to your CKAN config** (`/etc/ckan/default/ckan.ini`):
   ```ini
   ckan.plugins = ... aemet
   ```

4. **Restart CKAN**:
   ```bash
   sudo systemctl restart apache2  # or your web server
   ```

## Configuration

Currently, the extension works out-of-the-box with default settings. Future versions will include configurable options for:

- Custom color schemes for weather visualizations
- API integration settings for AEMET data
- Display preferences for meteorological variables

## Usage

### Loading Weather Data

Sample AEMET weather prediction data is available in `ckanext/aemet/tests/fixtures/prediccion.json`. To use it:

1. **Create a dataset** in CKAN through the web interface
2. **Add a resource** and upload the `prediccion.json` file
3. **Set the resource format** to `aemet-json` (required for the view to appear)
4. **Select the AEMET visualization** when viewing the resource

> **Note:** The resource data is fetched client-side by the browser, so the resource must be publicly accessible (not restricted to logged-in users only).

### Data Format

The extension expects JSON data in AEMET's prediction format:
- `origen`: Data source metadata
- `nombre`, `provincia`: Location information
- `prediccion.dia[]`: Array of daily forecasts
  - `temperatura`: Temperature data (max, min, hourly values)
  - `probPrecipitacion`: Precipitation probability
  - `estadoCielo`: Sky conditions
  - `viento`: Wind data
  - `humedadRelativa`: Relative humidity
  - `uvMax`: Maximum UV index

## Development

### Running Tests

```bash
# Create and activate a virtual environment (outside Docker)
python3 -m venv venv
source venv/bin/activate

# Install development dependencies
pip install -e ".[dev]"

# Run tests
pytest ckanext/aemet/tests/
```

### Project Structure

```
ckanext-aemet/
├── ckanext/
│   ├── __init__.py
│   └── aemet/
│       ├── __init__.py
│       ├── plugin.py          # Main plugin class
│       ├── templates/          # Jinja2 templates
│       └── tests/             # Unit and integration tests
├── docker/
│   └── init-db.sh            # Database initialization
├── docker-compose.yml         # Docker development environment
├── requirements.txt           # Development dependencies
└── README.md
```

## Docker Services

The development environment includes:

- **CKAN** (port 5000): Main application
- **PostgreSQL** (port 5432): Database with DataStore support
- **Solr** (port 8983): Search engine
- **Redis** (port 6379): Background jobs and caching

### Docker Commands

```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f ckan

# Stop services
docker-compose down

# Rebuild after changes
docker-compose up -d --build

# Access CKAN container shell
docker exec -it ckan-aemet bash

# Reset everything (WARNING: deletes all data)
docker-compose down -v
```

## Roadmap

### Phase 1: Basic Setup ✅
- [x] Create extension skeleton
- [x] Docker Compose development environment
- [x] Basic plugin registration

### Phase 2: Visualization ✅
- [x] Implement custom resource view for weather data
- [x] Create temperature chart component
- [x] Create precipitation probability visualization
- [x] Add wind direction/speed display

### Phase 3: Data Processing
- [ ] AEMET API integration
- [ ] Automatic data refresh
- [ ] DataStore integration for querying

### Phase 4: Advanced Features
- [ ] Interactive maps with geographic data
- [ ] Multi-day forecast comparison
- [ ] Export visualizations as images
- [ ] Mobile-responsive design

## License

AGPL-3.0 - See LICENSE file for details

## Author

Desidedatum

## Support

For issues and feature requests, please use the GitHub issue tracker.
