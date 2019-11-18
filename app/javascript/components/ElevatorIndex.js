import React, { useState, useEffect } from "react"
import PropTypes from "prop-types"
import ElevatorBank from './ElevatorBank'
import Elevator from './Elevator'
import consumer from '../channels/consumer'

function ElevatorIndex(props) {
  const [elevator, setElevator] = useState(props.elevator)

  useEffect(() => {
    consumer.subscriptions.create("ElevatorChannel", {
      received(data) {
        setElevator(data)
      }
    })
  }, [props.elevator.id])

  return (
    <div className='elevator-shaft'>
      <ElevatorBank { ...{ ...props, elevator } } />
      <Elevator { ...{ ...props, elevator } } />
    </div>
  )
}

export default ElevatorIndex

