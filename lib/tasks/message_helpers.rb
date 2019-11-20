module MessageHelpers
  def self.as_json(id, elevator)
    door_held = elevator.try(:door).try(:held_open) || false
    requested_floors = elevator.try(:requested_floors) || elevator.instance_variable_get('@requested_floors') || [elevator.instance_variable_get('@requested_floor')].compact
    if id == 1 && elevator.respond_to?(:haunted)
      elevator.haunted = true
    end

    { id: id, floor: elevator.floor, status: elevator.status, is_open: elevator.open?, queue: requested_floors, door_held: door_held, haunted: elevator.try(:haunted) || false }
  end

  def self.parse_message(msg)
    split_msg = msg.chomp("\n").split(' ')
    return [split_msg[0], split_msg[1..-1]]
  end
end
