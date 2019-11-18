class Elevator
  class << self
    def status(id)
      socket_request("elevator_status #{id}")
    end

    def call_to_floor(id, floor)
      socket_request("elevator_call #{id} #{floor}")
    end

    def step(id)
      socket_request("elevator_step #{id}")
    end

    def socket_request(msg)
      socket do |sock|
        sock.write(msg)
        sock.close_write
        JSON.parse(sock.read)
      end
    end

    def socket(&block)
      UNIXSocket.open('/tmp/elevator.sock', &block)
    end
  end
end
