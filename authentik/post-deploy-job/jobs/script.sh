* using HTTP/2
* h2h3 [:method: POST]
* h2h3 [:path: /api/v3/core/users/23/set-password/]
* h2h3 [:scheme: https]
* h2h3 [:authority: authentik.example.com]
* h2h3 [user-agent: curl/7.88.1]
* h2h3 [content-type: application/json]
* h2h3 [accept: application/json]
* h2h3 [authorization: Bearer **REDACTED**]
* h2h3 [content-length: 16]
* Using Stream ID: 1 (easy handle 0x56f3ca5e3ce0)
} [5 bytes data]
> POST /api/v3/core/users/23/set-password/ HTTP/2
> Host: authentik.example.com
> user-agent: curl/7.88.1
> content-type: application/json
> accept: application/json
> authorization: Bearer **REDACTED**
> content-length: 16
>
{ [5 bytes data]
* TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
{ [122 bytes data]
* We are completely uploaded and fine
{ [5 bytes data]
< HTTP/2 405
< allow: GET, HEAD, OPTIONS
< content-type: text/html; charset=utf-8
< date: Fri, 31 Jan 2025 10:49:00 GMT
< referrer-policy: same-origin
< vary: Accept-Encoding
< vary: Cookie
< x-authentik-id: 20232da84fb0598d8fc3fe7adc746f40
< x-content-type-options: nosniff
< x-frame-options: DENY
< x-powered-by: authentik