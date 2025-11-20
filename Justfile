set shell := ["bash", "-cu"]

compose := "docker compose -f ./docker-compose.yaml"

# Megazord Events
start-megazord-events:
    {{compose}} up -d \
      mysql-type-db mysql-dashboard-db localstack checkpoint prowl wonkers wonkers-account wonkers-db
    {{compose}} logs -f \
      mysql-type-db mysql-dashboard-db localstack checkpoint prowl wonkers wonkers-account wonkers-db

test-megazord-events:
    {{compose}} rm -sf mysql-type-db mysql-dashboard-db
    {{compose}} up -d \
      mysql-type-db mysql-dashboard-db localstack checkpoint prowl wonkers wonkers-account wonkers-db
    {{compose}} run --rm --no-deps --use-aliases node-megazord-events

log-megazord-events:
    {{compose}} logs -f \
      mysql-type-db mysql-dashboard-db localstack checkpoint prowl wonkers wonkers-account wonkers-db

# Wonkers GraphQL
start-wonkers-graphql:
    {{compose}} up -d \
      mysql-type-db mysql-dashboard-db typ-e wonkers-db wonkers wonkers-account
    {{compose}} logs -f \
      mysql-type-db mysql-dashboard-db typ-e wonkers-db wonkers wonkers-account

test-wonkers-graphql:
    {{compose}} rm -sf mysql-type-db mysql-dashboard-db
    {{compose}} up -d \
      mysql-type-db mysql-dashboard-db typ-e wonkers-db wonkers wonkers-account
    {{compose}} run --rm --no-deps --use-aliases --entrypoint sh node-wonkers-graphql -lc "export COREPACK_ENABLE_DOWNLOAD_PROMPT=0; corepack enable; yarn install --json; yarn generate; yarn test"

log-wonkers-graphql:
    {{compose}} logs -f \
      mysql-type-db mysql-dashboard-db typ-e wonkers-db wonkers wonkers-account