import { EventEmitter, Subscription } from 'expo-modules-core';
import ExpoCobraModule from './ExpoCobraModule';

/*
const emitter = new EventEmitter(ExpoCobraModule);

export type ThemeChangeEvent = {
  cobra: string;
};

export function addCobraListener(listener: (event: ThemeChangeEvent) => void): Subscription {
  return emitter.addListener<ThemeChangeEvent>('onChangeCobra', listener);
}
*/

export function stopCobra(): void {
   ExpoCobraModule.stopCobra();
}

export function getCobra(): string {
  return ExpoCobraModule.getCobra();
}

export function setCobra(cobra: string): void {
  return ExpoCobraModule.setCobra(cobra);
}