function getAllEvents (cb) {
  return fetch('/events', {
    accept: 'application/json',
  }).then(checkStatus)
    .then(parseJSON)
    .then(cb);
}

function createEvent (params, cb) {
  return fetch(`/users/${params.userId}/events`, {
    method: 'POST',
    accept: 'application/json',
    body: JSON.stringify(params),
    headers: {
      'Content-Type': 'application/json'
    }
  }).then(checkStatus)
    .then(parseJSON)
    .then(cb);
}

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

const Client = { getAllEvents, createEvent };
export default Client;
