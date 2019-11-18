import React from "react"
import PropTypes from "prop-types"

function Elevator(props) {
  const { shaft, elevator } = props

  const totalFloors = shaft.floors
  const floorIndex  = elevator.floor
  const floor       = shaft.min_floor + floorIndex
  const translate   = (totalFloors - (floor + 2)) * 150
  const style       = { top: translate }

  return (
    <div className='elevator' style={ style }>
      <div className={ 'down-floor-indicator' + (status === 'going_down' ? ' active' : '') }>V</div>
      <div className='floor-indicator'>{ floor }</div>
      <div className={ 'up-floor-indicator' + (status === 'going_up' ? ' active' : '') }>^</div>
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
