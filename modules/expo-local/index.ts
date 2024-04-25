//import { EventEmitter, Subscription } from 'expo-modules-core';
import ExpoCobraModule from './src/ExpoCobraModule';

export function stopCobra(): void {
  ExpoCobraModule.stopCobra();
}

export function getCobra(): string {
  return ExpoCobraModule.getCobra();
}

export function setCobra(cobra: string): void {
  return ExpoCobraModule.setCobra(cobra);
}