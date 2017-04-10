import React, { Component } from 'react';
import Client from './Client';
import './App.css';

class App extends Component {
  state = {
    events: []
  };

  handleEvents = () => {
    Client.getAllEvents(events => {
      this.setState({ events });
    });
  };

  // handleCreateEvent = e => {
  //   const data = e.target.

  //   Client.createEvent(data => {
  //     this.setState({ events });
  //   });
  // }

  render() {
    const { events } = this.state
    const eventRows = events.map((event, idx) => (
      <li key={idx}>
        <td>{event.name}</td>
        <td>{event.date}</td>
      </li>
    ));

    return (
      <div className="App">
        <div className="App-header">
          <button onClick={this.handleEvents}>Click me to get all events</button>
        </div>
        <ul>
          {eventRows}
        </ul>
      </div>
    );
  }
}

export default App;
