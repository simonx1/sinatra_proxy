curl -H "Content-Type: application/json" -H "Authorization: 123:345" -d '{"key1":"value1", "key2":"value2"}' -v http://localhost:4567/api/events

ab -p post_loc.txt -T application/json -H 'Authorization: 123:345' -c 10 -n 2000 http://0.0.0.0:4567/api/events

ruby application.rb

