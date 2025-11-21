# Hướng dẫn chạy test với Just

## Cách Chạy Qua Just

- Start Tinybots stack
  - `just -f devtools/Justfile start-wonkers-graphql`
  - `just -f devtools/Justfile start-megazord-events`
- Run test
  - `just -f devtools/Justfile test-wonkers-graphql`
  - `just -f devtools/Justfile test-megazord-events`
- Check dependencies log
  - `just -f devtools/Justfile log-wonkers-graphql`
  - `just -f devtools/Justfile log-megazord-events`