set shell := ["bash", "-cu"]

compose := "docker compose -f ./docker-compose.yaml"

# db
start-db:
    aws ecr get-login-password \
        --region eu-central-1 \
    | docker login \
        --username AWS \
        --password-stdin https://693338167548.dkr.ecr.eu-central-1.amazonaws.com
    {{compose}} up -d \
          mysql-typ-e-db typ-e mysql-wonkers-db wonkers-db

# ------------------------------------- wonkers-ecd -------------------------------------
test-wonkers-ecd:
    {{compose}} rm -sf mysql-wonkers-db
    {{compose}} up -d \
     mysql-wonkers-db wonkers-db mailcatcher kryten
    {{compose}} run --rm --use-aliases wonkers-ecd

# ------------------------------------- m-o-triggers -------------------------------------
test-m-o-triggers:
    {{compose}} rm -sf mysql-typ-e-db mysql-wonkers-db localstack
    {{compose}} up -d \
      mysql-typ-e-db mysql-wonkers-db localstack checkpoint prowl
    {{compose}} run --rm --use-aliases m-o-triggers

# ------------------------------------- azi-3-status-check-jobs -------------------------------------
dev-azi-3-status-check-jobs:
    {{compose}} run --rm --service-ports  --use-aliases --entrypoint "sh -c 'corepack enable && yarn dev'" azi-3-status-check-jobs

# ------------------------------------- Megazord Events. -------------------------------------
dev-megazord-events:
    {{compose}} run --rm --service-ports  --use-aliases --entrypoint "sh -c 'corepack enable && yarn start'" megazord-events

start-megazord-events:
    {{compose}} up -d \
      mysql-typ-e-db typ-e mysql-wonkers-db wonkers-db localstack checkpoint prowl wonkers wonkers-account
    -{{compose}} logs -f \
      mysql-typ-e-db typ-e mysql-wonkers-db wonkers-db localstack checkpoint prowl wonkers wonkers-account

test-megazord-events:
    {{compose}} rm -sf mysql-typ-e-db mysql-wonkers-db localstack
    {{compose}} up -d \
      mysql-typ-e-db mysql-wonkers-db localstack checkpoint prowl wonkers wonkers-account wonkers-db
    {{compose}} run --rm --use-aliases megazord-events

log-megazord-events:
    -{{compose}} logs -f \
          mysql-typ-e-db typ-e mysql-wonkers-db wonkers-db localstack checkpoint prowl wonkers wonkers-account

#. ------------------------------------- Wonkers GraphQL -------------------------------------
start-wonkers-graphql:
    {{compose}} up -d \
      mysql-typ-e-db typ-e mysql-wonkers-db wonkers-db wonkers wonkers-account
    -{{compose}} logs -f \
      mysql-typ-e-db typ-e mysql-wonkers-db wonkers-db wonkers wonkers-account

test-wonkers-graphql:
    {{compose}} rm -sf mysql-typ-e-db mysql-wonkers-db
    {{compose}} up -d \
          mysql-typ-e-db typ-e mysql-wonkers-db wonkers-db wonkers wonkers-account
    {{compose}} run --rm  --use-aliases wonkers-graphql

log-wonkers-graphql:
    {{compose}} logs -f \
      mysql-typ-e-db typ-e mysql-wonkers-db wonkers-db wonkers wonkers-account