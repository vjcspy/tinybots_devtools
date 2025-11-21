set shell := ["bash", "-cu"]

compose := "docker compose -f ./docker-compose.yaml"

# Megazord Events
start-megazord-events:
    {{compose}} up -d \
      mysql-typ-e-db typ-e mysql-wonkers-db wonkers-db localstack checkpoint prowl wonkers wonkers-account
    -{{compose}} logs -f \
      mysql-typ-e-db typ-e mysql-wonkers-db wonkers-db localstack checkpoint prowl wonkers wonkers-account

test-megazord-events:
    {{compose}} rm -sf mysql-typ-e-db mysql-wonkers-db
    {{compose}} up -d \
      mysql-typ-e-db mysql-wonkers-db localstack checkpoint prowl wonkers wonkers-account wonkers-db
    {{compose}} run --rm --no-deps --use-aliases node-megazord-events

log-megazord-events:
    -{{compose}} logs -f \
          mysql-typ-e-db typ-e mysql-wonkers-db wonkers-db localstack checkpoint prowl wonkers wonkers-account

# Wonkers GraphQL
start-wonkers-graphql:
    {{compose}} up -d \
      mysql-typ-e-db mysql-wonkers-db typ-e wonkers-db wonkers wonkers-account
    {{compose}} logs -f \
      mysql-typ-e-db mysql-wonkers-db typ-e wonkers-db wonkers wonkers-account

test-wonkers-graphql:
    {{compose}} rm -sf mysql-typ-e-db mysql-wonkers-db
    {{compose}} up -d \
      mysql-typ-e-db mysql-wonkers-db typ-e wonkers-db wonkers wonkers-account
    {{compose}} run --rm --no-deps --use-aliases --entrypoint sh node-wonkers-graphql -lc "export COREPACK_ENABLE_DOWNLOAD_PROMPT=0; corepack enable; yarn install --json; yarn generate; yarn test"

log-wonkers-graphql:
    {{compose}} logs -f \
      mysql-typ-e-db mysql-wonkers-db typ-e wonkers-db wonkers wonkers-account