# RQpedia --- Full MediaWiki Installation & Developer Guide for Jules

**Purpose:** Give an autonomous agent (Jules) a complete, runnable
checklist, scripts, and developer workflow to install, configure,
extend, and maintain a production-ready MediaWiki instance for the
RQpedia project (GitHub: `RQpediaMediaWiki`).

------------------------------------------------------------------------

## Table of contents

1.  Goals & scope
2.  System requirements (recommended)
3.  Repository layout (RQpediaMediaWiki)
4.  Quickstart (Docker Compose)
5.  Manual LAMP/LEMP install (step-by-step)
6.  Post-install configuration (LocalSettings and essentials)
7.  Recommended extensions and how to install them
8.  Archaeology-specific data & templates (starter templates)
9.  Data import workflows (CSV, GeoJSON, Wikibase import)
10. Search, caching, and performance (CirrusSearch + Elasticsearch,
    caching)
11. Media storage & uploads (local vs S3)
12. CI/CD, backups, and upgrades
13. Security & hardening
14. Monitoring, metrics & logs
15. Developer workflow for Jules (automation, scripts, tests)
16. Troubleshooting & common commands
17. Appendix: sample files (docker-compose.yml, LocalSettings.php
    excerpt, nginx, sample Compose volumes)

------------------------------------------------------------------------

## 1. Goals & scope

-   Deploy a stable, extensible MediaWiki instance named **RQpedia**.
-   Provide automated Docker-based development and production deployment
    paths.
-   Enable structured data via **Semantic MediaWiki / Wikibase** for
    archaeological records.
-   Provide ingestion pipelines for CSV / GeoJSON / BibTeX and templates
    tailored for archaeological sites (e.g., Jebel Irhoud).
-   Make the agent Jules able to perform installs, upgrades, extension
    installs, imports, and backups autonomously.

## 2. System requirements (recommended)

-   Linux server: Debian/Ubuntu/CentOS/Rocky recommended
-   CPU: 2+ cores
-   RAM: 2 GB minimum (4+ GB recommended)
-   Disk: 20 GB minimum
-   PHP: 8.1+
-   Database: MariaDB 10.3+ or MySQL 5.7+
-   Web server: Apache 2.4+ or Nginx
-   Composer
-   Docker & Docker Compose

## 3. Repository layout (`RQpediaMediaWiki`)

    RQpediaMediaWiki/
    ├─ docker/
    │  └─ docker-compose.yml
    ├─ ops/
    │  ├─ backups.sh
    │  ├─ restore.sh
    │  └─ migrate.sh
    ├─ mediawiki/
    ├─ extensions/
    ├─ skins/
    ├─ docs/
    ├─ templates/
    ├─ scripts/
    └─ README.md

## 4. Quickstart (Docker Compose)

``` yaml
version: '3.8'
services:
  mediawiki:
    image: mediawiki
    ports:
      - '8080:80'
    volumes:
      - ./mediawiki_data:/var/www/html
    depends_on:
      - db

  db:
    image: mariadb:10.5
    environment:
      MYSQL_ROOT_PASSWORD: change-me
      MYSQL_DATABASE: mediawiki
      MYSQL_USER: mediawiki
      MYSQL_PASSWORD: mwpass

  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.17.13
    environment:
      - discovery.type=single-node
```

## 5. Manual LAMP/LEMP install

Install PHP, Apache/Nginx, MariaDB, Composer. Clone MediaWiki, set
permissions, run installer.

## 6. Post-install configuration

-   Store LocalSettings.php securely
-   Configure uploads, caching, email, job queue

## 7. Recommended extensions

-   Semantic MediaWiki
-   Wikibase
-   VisualEditor
-   Cite
-   CirrusSearch + Elasticsearch
-   Page Forms
-   Maps
-   Scribunto

## 8. Archaeology templates

Define infobox template & SMW properties for archaeological sites.

## 9. Data import workflows

-   CSV import scripts
-   GeoJSON mapping
-   Wikibase data model

## 10--17 (Performance, security, CI/CD, automation scripts, troubleshooting, appendices)

Extensive details include: - Redis caching - S3 storage - Backups &
monitoring - Job queue runner - Import scripts for Jules
