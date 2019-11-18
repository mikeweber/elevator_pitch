import consumer from '../channels/consumer'

const actions = {
  received(data) {
    const elevator = document.getElementByID('elevator1')
    this.appendLine(data)
  }
}

consumer.subscriptions.create({ channel: 'ElevatorChannel' }, actions)
