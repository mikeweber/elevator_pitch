module MessageHelpers
  def self.as_json(id, elevator)
    { id: id, floor: elevator.floor, status: elevator.status, is_open: elevator.open?, queue: elevator.requested_floors }
  end

  def self.parse_message(msg)
    split_msg = msg.chomp("\n").split(' ')
    return [split_msg[0], split_msg[1..-1]]
  end
end
