#! /bin/bash
#
# Debian Slim with Python 3.6 on Docker
# =============================================================================
# Build docker image
# =============================================================================

# OPTIONAL Install SQL/GIS "spatialite" when non-empty string
GIS_SPATIALITE=""

REGISTRY="dockercentral.it.example.com:5100"
NAMESPACE="com.example.dev"
IMAGE_NAME="debian-slim-python3"
TAG="3.7.3"

if [ -n "${GIS_SPATIALITE}" ]; then
	echo "Adding SQL/GIS spatialite support ..."
	IMAGE_NAME="${IMAGE_NAME}-sqlgis"
	DOCKERFILE=Dockerfile.sqlgis
else
	# Just build main project.
	DOCKERFILE=Dockerfile
fi

FULL_IMAGE_NAME="${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:${TAG}"

docker login -u user@example.com -p password ${REGISTRY}

docker build -t $FULL_IMAGE_NAME ./ \
    --build-arg http_proxy=$http_proxy \
    --build-arg https_proxy=$https_proxy \
    -f ${DOCKERFILE}
