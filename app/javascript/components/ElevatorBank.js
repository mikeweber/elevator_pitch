import React from "react"
import PropTypes from "prop-types"

function ElevatorBank(props) {
  const { shaft, activeFloors }  = props
  const floorComponents = []

  for (let i = 0; i < shaft.floors; i++) {
    const floorIndex  = shaft.floors - i - 1
    const floorNumber = shaft.min_floor + floorIndex
    const floorName   = (shaft.floor_names || [])[floorIndex] || floorNumber

    floorComponents.push(
      <div key={ i } className='call-button-container'>
      <a href={ `/elevators/call_to_floor/${floorIndex}` } data-remote='true' className={ 'call-button' + (activeFloors.indexOf(floorIndex) > -1 ? ' active' : '') } data-method='post'>
          { floorName }
        </a>
      </div>
    )
  }

  return (
    <div className='call-buttons'>
      <a href='/elevators/step' data-remote='true' data-method='post'>Step</a>
      { floorComponents }
    </div>
  )
}

ElevatorBank.propTypes = {
  shaft:        PropTypes.object.isRequired,
  activeFloors: PropTypes.arrayOf(PropTypes.number).isRequired
}

export default ElevatorBank
