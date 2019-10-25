ab -p ~/post_loc.txt -T application/json -H 'Authorization: SThMamNwVjZOcWI4Y0MxM05oQ2N1Tlh6eUdBYW5VbHk1SWJnSzNUblVrMA==' -c 10 -n 2000 http://0.0.0.0:7654/acme-inc-21/events

curl -H "Content-Type: application/json" -H "Authorization: SThMamNwVjZOcWI4Y0MxM05oQ2N1Tlh6eUdBYW5VbHk1SWJnSzNUblVrMA==" -d '{"key1":"value1", "key2":"value2"}'  http://0.0.0.0:7654/acme-inc-21/events -v

ruby application.rb -s Puma -p 7654

