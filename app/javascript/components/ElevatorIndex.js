import React, { useState, useEffect } from "react"
import PropTypes from "prop-types"
import ElevatorBank from './ElevatorBank'
import Elevator from './Elevator'
import consumer from '../channels/consumer'

function ElevatorIndex(props) {
  const [elevators, setElevator] = useState(props.elevators)

  useEffect(() => {
    consumer.subscriptions.create("ElevatorChannel", {
      received(data) {
        setElevator(data)
      }
    })
  })

  let activeFloors = []
  const elevatorComponents = elevators.map((elevator, i) => {
    activeFloors = activeFloors.concat(elevator.queue)
    return (
      <div key={ i } className='elevator-shaft'>
        <Elevator { ...{ ...props, elevator } } />
      </div>
    )
  })
  return (
    <div>
      <ElevatorBank { ...{ ...props, activeFloors } } />
      { elevatorComponents }
    </div>
  )
}

export default ElevatorIndex

