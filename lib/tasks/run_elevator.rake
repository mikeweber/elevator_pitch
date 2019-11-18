require 'socket'
require_relative './message_helpers'
require_relative '../../../elevators/lib/elevator'

namespace :elevators do
  desc 'Run a single elevator wrapped in a UNIX socket'
  task run_single: :environment do
    server = UNIXServer.new('/tmp/elevator.sock')
    Kernel.trap('INT') do
      puts 'Cleaning up and shutting down elevator'
      server.close
      FileUtils.rm('/tmp/elevator.sock')
      exit
    end
    elevator = Elevator.new

    puts "Running a single elevator"
    loop do
      Thread.start(server.accept) do |client|
        method, args = MessageHelpers.parse_message(client.read)
        puts "Received method: #{method} with args #{args.inspect}"
        msg = nil

        case method
        when 'status', 'elevator_status'
          msg = [MessageHelpers.as_json(0, elevator)]
        when 'elevator_call'
          elevator.call_to_floor(args[0].to_i)
          msg = [MessageHelpers.as_json(0, elevator)]
        when 'elevator_step'
          elevator.step!
          msg = [MessageHelpers.as_json(args[0] || 0, elevator)]
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
end
