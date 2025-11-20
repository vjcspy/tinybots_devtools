# Hướng dẫn chạy test với Just

## Cách Chạy Qua Just

- Khởi động phụ trợ và xem log khi lên:
  - `just -f devtools/Justfile start-wonkers-graphql`
  - `just -f devtools/Justfile start-megazord-events`
- Chạy test, reset DB sạch, chỉ xem log node, lấy exit code:
  - `just -f devtools/Justfile test-wonkers-graphql`
  - `just -f devtools/Justfile test-megazord-events`
- Xem log phụ trợ:
  - `just -f devtools/Justfile log-wonkers-graphql`
  - `just -f devtools/Justfile log-megazord-events`