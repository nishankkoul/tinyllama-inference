import http from 'k6/http';

export const options = {
  scenarios: {
    constant_rps: {
      executor: 'constant-arrival-rate',
      rate: 5,                    // 5 iterations (requests) per second
      timeUnit: '1s',             // per second
      duration: '1m',             // total test duration
      preAllocatedVUs: 100,         // initial VUs to allocate
      maxVUs: 200,                 // k6 can scale up if requests take longer
    },
  },
};

export default function () {
  const url = 'http://<lb-ip>/completion';

  const payload = JSON.stringify({
    prompt: 'Once upon a time',
    max_tokens: 20
  });

  const params = {
    headers: { 'Content-Type': 'application/json' },
  };

  http.post(url, payload, params);
}
