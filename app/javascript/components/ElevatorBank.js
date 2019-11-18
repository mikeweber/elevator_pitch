import React from "react"
import PropTypes from "prop-types"

function ElevatorBank(props) {
  const { shaft, elevator }  = props
  const floorComponents = []

  for (let i = 0; i < shaft.floors; i++) {
    const floorIndex = shaft.floors - i - 1
    floorComponents.push(
      <div key={ i } className='call-button-container'>
      <a href={ `/elevators/1/call_to_floor/${floorIndex}` } data-remote='true' className={ 'call-button' + (elevator.queue.indexOf(floorIndex) > -1 ? ' active' : '') }>
          { shaft.max_floor - i }
        </a>
      </div>
    )
  }

  return (
    <div className='call-buttons'>
      <a href='/elevators/1/step' data-remote='true'>Step</a>
      { floorComponents }
    </div>
  )
}

export default ElevatorBank
