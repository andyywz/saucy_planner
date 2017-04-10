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

  handleCreateEvent = e => {
    e.preventDefault();
    const params = {
      userId: '3',
      name: 'Something',
      date: '01/01/2020',
      description: 'Nothing spectacular here'
    };

    Client.createEvent(params, (data) => {
      console.log(`Got this back ${data}`);
      this.handleEvents();
    });
  }

  render() {
    const { events } = this.state
    const eventRows = events.map((event, idx) => (
      <tr key={idx}>
        <td>{event.name}</td>
        <td>{event.date}</td>
      </tr>
    ));

    return (
      <div className="App">
        <form name="event" onSubmit={this.handleCreateEvent}>
          <input type="text" name="name" />
          <input type="date" name="date" />
          <input type="submit" />
        </form>
        <button onClick={this.handleEvents}>Click me to get all events</button>
        <table>
          <tbody>
            {eventRows}
          </tbody>
        </table>
      </div>
    );
  }
}

export default App;
