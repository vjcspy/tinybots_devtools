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
