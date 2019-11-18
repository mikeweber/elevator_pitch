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
    const panel = []
    for (let f = props.shaft.min_floor; f <= props.shaft.max_floor; f++) {
      let floorIndex = f - props.shaft.min_floor
      let floorName  = props.shaft.floor_names[floorIndex] || f
      panel.push(
        <a
          key={ f }
          href={ `/elevators/${i}/send_to_floor/${floorIndex}` }
          className={ 'panel-button' + (elevator.queue.indexOf(floorIndex) > -1 ? ' active' : '') }
          data-remote='true'
          data-method='post'
        >{ floorName }</a>
      )
    }
    return (
      <div key={ i } className='elevator-shaft'>
        <div className='elevator-panel'>
          { panel }
        </div>
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

