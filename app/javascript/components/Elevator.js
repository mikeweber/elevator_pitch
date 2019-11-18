import React, { useState, useEffect } from "react"
import PropTypes from "prop-types"
import consumer from '../channels/consumer'

function Elevator(props) {
  const shaft = props.shaft
  const [elevator, setElevator] = useState(props.elevator)

  const totalFloors = shaft.floors
  const floorIndex  = elevator.floor
  const floor       = shaft.min_floor + floorIndex
  const translate   = (totalFloors - (floor + 2)) * 150
  const style       = { top: translate }

  useEffect(() => {
    consumer.subscriptions.create("ElevatorChannel", {
      received(data) {
        setElevator(data)
      }
    })
  }, [props.elevator.id])

  return (
    <div className='elevator' style={ style }>
      <div className={ 'down-floor-indicator' + (elevator.status === 'going_down' ? ' active' : '') }>V</div>
      <div className='floor-indicator'>{ floor }</div>
      <div className={ 'up-floor-indicator' + (elevator.status === 'going_up' ? ' active' : '') }>^</div>
      <div className={ 'door-opening' + (elevator.is_open ? ' open' : '') }>
        <div className='door-panel left-door'></div>
        <div className='door-panel right-door'></div>
      </div>
    </div>
  )
}

Elevator.propTypes = {
  shaft:    PropTypes.object.isRequired,
  elevator: PropTypes.object.isRequired,
}

export default Elevator
