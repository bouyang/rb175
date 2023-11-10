require 'socket'

server = TCPServer.new('localhost', 3003)
loop do
  client = server.accept

  request_line = client.gets
  next if !request_line || request_line =~ /favicon/
  puts request_line

  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/plain\r\n\r\n"
  client.puts request_line

  request_line_arr = request_line.split

  http_method = request_line_arr[0]
  client.puts "http_method: #{http_method}"

  path = request_line_arr[1].split('?')[0]
  client.puts "path: #{path}"

  query_parameters = request_line_arr[1].split('?')[1].split('&')
  
  query_parameters_hash = Hash.new()
  query_parameters.each do |pair|
    query_parameters_hash[pair.split('=')[0]] = pair.split('=')[1]
  end

  client.puts "query parameters hash: #{query_parameters_hash}"

  rolls = query_parameters_hash['rolls'].to_i
  sides = query_parameters_hash['sides'].to_i

  rolls.times do
    roll = rand(sides) + 1
    client.puts "You rolled: #{roll}"
  end

  client.close
end