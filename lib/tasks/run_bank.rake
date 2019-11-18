require 'socket'
require_relative './message_helpers'
require_relative '../../../elevators/lib/bank'
include MessageHelpers

namespace :elevators do
  desc 'Run the elevator bank wrapped in a UNIX socket'
  task run_bank: :environment do
    server = UNIXServer.new('/tmp/elevator.sock')
    Kernel.trap('INT') do
      puts 'Cleaning up and shutting down elevator'
      server.close
      FileUtils.rm('/tmp/elevator.sock')
      exit
    end
    bank = Bank.new([Elevator.new(floor: 2), Elevator.new(floor: 2), Elevator.new(floor: 4)])

    puts "Running an elevator bank"
    loop do
      Thread.start(server.accept) do |client|
        method, args = MessageHelpers.parse_message(client.read)
        puts "Received method: #{method} with args #{args.inspect}"
        msg = nil

        case method
        when 'status', 'elevator_status'
          msg = bank_message(bank)
        when 'elevator_call'
          bank.call_to_floor(args[0].to_i, direction(args[1] || 'up'))
          msg = bank_message(bank)
        when 'elevator_send'
          bank.elevators[args[0].to_i].call_to_floor(args[1].to_i)
          msg = bank_message(bank)
        when 'elevator_step'
          if args[0]
            bank.elevators[args[0].to_i].step!
          else
            bank.step!
          end
          msg = bank_message(bank)
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

  def bank_message(bank)
    bank.elevators.map.with_index { |el, i| MessageHelpers.as_json(i, el) }
  end

  def direction(dir)
    {
      'up':   :up,
      'down': :down
    }
  end
end
