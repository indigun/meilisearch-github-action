#!/bin/sh

# Map input values from the GitHub Actions workflow to shell variables
MEILISEARCH_VERSION=$1
MEILISEARCH_PORT=$2
MEILISEARCH_API_KEY=$3

if [ -z "$MEILISEARCH_API_KEY" ]; then
  echo "::group::Starting Meilisearch server"
  echo "  - port [$MEILISEARCH_PORT]"
  echo "  - version [$MEILISEARCH_VERSION]"
  echo ""

  docker run --name meilisearch --publish $MEILISEARCH_PORT:$MEILISEARCH_PORT -e MEILI_NO_ANALYTICS=true --detach --volume "$(pwd)/meili_data:/meili_data" getmeili/meilisearch:$MEILISEARCH_VERSION
  echo "::endgroup::"

  return
fi

echo "::group::Starting Meilisearch server"
echo "  - port [$MEILISEARCH_PORT]"
echo "  - version [$MEILISEARCH_VERSION]"
echo "  - api key [$MEILISEARCH_API_KEY]"
echo ""

docker run --name meilisearch --publish $MEILISEARCH_PORT:$MEILISEARCH_PORT -e MEILI_MASTER_KEY="$MEILISEARCH_API_KEY" -e MEILI_NO_ANALYTICS=true --detach --volume "$(pwd)/meili_data:/meili_data" getmeili/meilisearch:$MEILISEARCH_VERSION
echo "::endgroup::"
