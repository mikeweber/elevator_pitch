require 'socket'
require_relative '../../../elevators/lib/elevator'

namespace :elevators do
  desc 'Run the elevator bank wrapped in a UNIX socket'
  task run_single: :environment do
    server = UNIXServer.new('/tmp/elevator.sock')
    Kernel.trap('INT') do
      puts 'INTERRUPT'
      server.close
      FileUtils.rm('/tmp/elevator.sock')
      exit
    end
    elevator = Elevator.new

    puts "Running a single elevator"
    loop do
      Thread.start(server.accept) do |client|
        method, args = parse_message(client.read)
        puts "Received method: #{method} with args #{args.inspect}"
        msg = nil

        case method
        when 'status', 'elevator_status'
          msg = as_json(args[0], elevator)
        when 'elevator_call'
          elevator.call_to_floor(args[1].to_i)
          msg = as_json(args[0], elevator)
        when 'elevator_step'
          elevator.step!
          msg = as_json(args[0], elevator)
        else
          msg = { error: "#{method} not recognized" }
        end

        ElevatorChannel.broadcast_to('status', msg)
        puts "broadcast message to elevator channel"
        client.puts msg.to_json
        client.close_write
        puts "Sent message: #{msg}"

        client.close
        puts "Connection closed"
      end
    end
  end

  def as_json(id, elevator)
    { id: id, floor: elevator.floor, status: elevator.status, is_open: elevator.open?, queue: elevator.requested_floors }
  end

  def parse_message(msg)
    split_msg = msg.chomp("\n").split(' ')
    return [split_msg[0], split_msg[1..-1]]
  end
end
