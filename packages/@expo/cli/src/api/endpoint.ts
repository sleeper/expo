import { env } from '../utils/env';
import { getFreePortAsync } from '../utils/port';

/** Get the URL for the expo.dev API. */
export function getExpoApiBaseUrl(): string {
  if (env.EXPO_STAGING) {
    return `https://staging-api.expo.dev`;
  } else if (env.EXPO_LOCAL) {
    return `http://127.0.0.1:3000`;
  } else {
    return `https://api.expo.dev`;
  }
}

/** Get the URL for the expo.dev website. */
export function getExpoWebsiteBaseUrl(): string {
  if (env.EXPO_STAGING) {
    return `https://staging.expo.dev`;
  } else if (env.EXPO_LOCAL) {
    return `http://expo.test`;
  } else {
    return `https://expo.dev`;
  }
}

export async function getSsoLocalServerPortAsync(): Promise<number> {
  let startPort: number;
  if (process.env.SSO_LOCAL_SERVER_PORT) {
    startPort = Number(process.env.SSO_LOCAL_SERVER_PORT);
  } else {
    startPort = 19200;
  }
  const port = await getFreePortAsync(startPort);
  return port;
}
