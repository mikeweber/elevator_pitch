import React from "react"
import PropTypes from "prop-types"

function Elevator(props) {
  const { shaft, elevator } = props

  const totalFloors = shaft.floors
  const floorIndex  = elevator.floor
  const floorNumber = shaft.min_floor + floorIndex
  const floorName   = (shaft.floor_names || [])[floorIndex] || floorNumber
  const translate   = (totalFloors - (floorNumber + 2)) * 150
  const style       = { top: translate }

  return (
    <div className='elevator' style={ style }>
      <div className='ceiling'></div>
      <div className={ 'down-floor-indicator' + (elevator.status === 'going_down' ? ' active' : '') }>V</div>
      <div className='floor-indicator'>{ floorName }</div>
      <div className={ 'up-floor-indicator' + (elevator.status === 'going_up' ? ' active' : '') }>^</div>
      <div className={ 'door-opening' + (elevator.is_open ? ' open' : '') }>
        <div className={ (elevator.haunted ? 'haunted' : '') }>
          <div className='door-panel left-door'></div>
          <div className='door-panel right-door'></div>
        </div>
        <div className='floor'></div>
      </div>
    </div>
  )
}

Elevator.propTypes = {
  shaft:    PropTypes.object.isRequired,
  elevator: PropTypes.object.isRequired,
}

export default Elevator
