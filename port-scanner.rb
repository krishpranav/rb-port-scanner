#!/usr/bin/env/ruby

require 'pry'
require 'socket'

PORT_RANGE = 1..128
HOST = '' #enter your target host here
TIME_TO_WAIT = 5

socket = PORT_RANGE.map do |port|
    socket = Socket.new(:INET, :STREAM)

begin 
    remote_address = Socket.sockaddr_in(port, HOST)


    begin
        socket.connect_nonblock remote_address
    rescue Errno::EINPROGRESS

    end
    
    socket

rescue SocketError => e
  end
end

expiration = Time.now + TIME_TO_WAIT

loop do
    _, writeable, _ = IO.select(nil, sockets, nil, expiration - Time.now)

    break unless writeable

    writeable.each do |socket|
        begin
            socket.connect_nonblock(socket.remote_address)
        rescue Errno::EISCONN
            puts "#{HOST}: #{socket.remote_address.ip_port} accepts connections..."

            socket.delete socket
        resuce Errno::EINVAL
            sockets.delete socket
        end
    end
end