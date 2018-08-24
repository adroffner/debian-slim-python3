#! /bin/bash
#
# Build SQL/GIS "spatialite" for Python 3.x.x from source on CentOS Linux.
# =============================================================================

SPATIALITE_VERSION="4.3.0a"

# =============================================================================
# Restore the package index.
# =============================================================================
apt-get update

# spatialite: Install SQL/GIS libraries before building.
apt-get -y install binutils libproj-dev libgeos-dev gdal-bin libxml2-dev libfreexl-dev

# Download and build spatialite SQL/GIS *.so $SPATIALITE_VERSION
# =============================================================================
cd /usr/src

wget http://www.gaia-gis.it/gaia-sins/libspatialite-sources/libspatialite-${SPATIALITE_VERSION}.tar.gz
tar -xzf libspatialite-${SPATIALITE_VERSION}.tar.gz
cd libspatialite-${SPATIALITE_VERSION}

# spatialite needs GEOS and PROJ.4 *.so libraries.
export CFLAGS="-I/usr/local/include -I/usr/proj49/include/ -L/usr/local/lib -L/usr/proj49/lib"
./configure
make
make install

rm /usr/src/libspatialite-${SPATIALITE_VERSION}.tar.gz
rm -R /usr/src/libspatialite-${SPATIALITE_VERSION}

# =============================================================================
# Clean up the package index.
# =============================================================================
rm -r /var/lib/apt/lists/*
