module MessageHelpers
  def self.as_json(id, elevator)
    door_held = false
    door_held = elevator.door.held_open if elevator.respond_to?(:door) && elevator.door.respond_to?(:held_open)
    { id: id, floor: elevator.floor, status: elevator.status, is_open: elevator.open?, queue: elevator.requested_floors, door_held: door_held }
  end

  def self.parse_message(msg)
    split_msg = msg.chomp("\n").split(' ')
    return [split_msg[0], split_msg[1..-1]]
  end
end
