import http from 'k6/http';
import { sleep } from 'k6';
export const options = {
  vus: 20,
  duration: '300s',
};

export default function () {
  http.get('http:// hello.p.cloudacode.com/v2');
  sleep(1);
}

