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
export function stopCobra() {
    ExpoCobraModule.stopCobra();
}
export function getCobra() {
    return ExpoCobraModule.getCobra();
}
export function setCobra(cobra) {
    return ExpoCobraModule.setCobra(cobra);
}
//# sourceMappingURL=index.js.map