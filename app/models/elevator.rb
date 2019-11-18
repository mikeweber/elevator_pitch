class Elevator
  class << self
    def status
      socket_request("elevator_status")
    end

    def call_to_floor(floor)
      socket_request("elevator_call #{floor}")
    end

    def send_to_floor(id, floor)
      socket_request("elevator_send #{id} #{floor}")
    end

    def step(id = nil)
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
