# ckanext-aemet

CKAN extension for visualizing AEMET (Spanish Meteorological Agency) weather prediction data.

## Overview

This extension provides custom visualization tools for weather prediction data from Spain's AEMET (Agencia Estatal de Meteorología). It includes resource views optimized for displaying weather forecasts with temperature, precipitation, wind, and other meteorological variables.

## Requirements

- **CKAN**: 2.11.0 or higher
- **Python**: 3.7, 3.8, 3.9, or 3.10
- **PostgreSQL**: 12 or higher
- **Docker & Docker Compose**: For development environment

## Installation

### Development Setup with Docker

1. **Clone the repository** (if not already done):
   ```bash
   cd /home/oriol/projects/altres/ckanext-aemet
   ```

2. **Create Python virtual environment**:
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   ```

3. **Install development dependencies**:
   ```bash
   pip install -r requirements.txt
   pip install -e .
   ```

4. **Generate a secure SECRET_KEY**:
   ```bash
   python -c 'import secrets; print(secrets.token_hex(32))'
   ```

5. **Update docker-compose.yml**:
   - Replace `changeme-generate-a-secure-key-here` with the generated SECRET_KEY

6. **Start Docker containers**:
   ```bash
   docker-compose up -d
   ```

7. **Wait for services to initialize** (this may take a few minutes on first run):
   ```bash
   docker-compose logs -f ckan
   ```

8. **Access CKAN**:
   - Open your browser to: http://localhost:5000
   - Default admin credentials will be shown in logs on first run

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

The `tmp/prediccion.json` file contains sample AEMET weather prediction data. To use it:

1. **Create a dataset** in CKAN through the web interface
2. **Add a resource** and upload the `prediccion.json` file
3. **Select the AEMET visualization** when viewing the resource (future feature)

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
# Activate virtual environment
source venv/bin/activate

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
│       ├── public/            # Static assets (CSS, JS)
│       ├── logic/             # Custom actions and auth functions
│       └── tests/             # Unit and integration tests
├── docker/
│   └── init-db.sh            # Database initialization
├── tmp/
│   └── prediccion.json       # Sample weather data
├── docker-compose.yml         # Docker development environment
├── setup.py                   # Python package configuration
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

### Phase 2: Visualization (Next)
- [ ] Implement custom resource view for weather data
- [ ] Create temperature chart component
- [ ] Create precipitation probability visualization
- [ ] Add wind direction/speed display

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
