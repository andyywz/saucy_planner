function getAllEvents () {
  return fetch('/api/events', {
    accept: 'application/json',
  }).then(checkStatus)
    .then(parseJSON);
}

// function createEvent (data) {
//   return fetch('http://localhost:3001/events', {
//     method: 'POST',
//     accept: 'application/json',
//     body: JSON.stringify(data),
//     headers: {
//       'Content-Type': 'application/json'
//     }
//   }).then(checkStatus)
//     .then(parseJSON);
// }

function checkStatus (response) {
  if (response.status >= 200 && response.status < 300) {
    return response;
  }
  const error = new Error(`HTTP Error ${response.statusText}`);
  error.status = response.statusText;
  error.response = response;
  console.log(error); // eslint-disable-line no-console
  throw error;
}

function parseJSON (response) {
  return response.json();
}

const Client = { getAllEvents };
export default Client;
