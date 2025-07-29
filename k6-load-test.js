import http from 'k6/http';
import { sleep } from 'k6';

export const options = {
  stages: [
    { duration: '1m', target: 5 }, // maintain 5 VUs for 1 minute
  ],
  vus: 5,
};

export default function () {
  const url = 'http://<lb-ip>:8080/completion';

  const payload = JSON.stringify({
    prompt: 'Once upon a time',
    max_tokens: 20
  });

  const params = {
    headers: {
      'Content-Type': 'application/json',
    },
  };

  http.post(url, payload, params);

  sleep(1); // 1 request per second per VU => 5 RPS
}
