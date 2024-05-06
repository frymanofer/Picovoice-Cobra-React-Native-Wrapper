
const withCobra = (config, { apiKey } = {}) => {
  if (!config.ios) {
      config.ios = {};
    }
    if (!config.ios.infoPlist) {
      config.ios.infoPlist = {};
    }    
    return config;
};

module.exports.withCobra = withCobra;
//module.exports = createRunOncePlugin(withCobra, 'withCobra', '1.0.0');
/*


const { createRunOncePlugin, withPlugins, AndroidConfig, IOSConfig } = require('@expo/config-plugins');

const withCobra = (config, { apiKey } = {}) => {
    return withPlugins(config, [
        // Android-specific config modifications
        [AndroidConfig.Manifest.permission, { name: 'android.permission.RECORD_AUDIO' }],
        // iOS-specific config modifications
        [IOSConfig.InfoPlist, {
            usesDescription: {
                'NSMicrophoneUsageDescription': 'This app uses the microphone to process audio via Cobra.',
            }
        }],
        // Any other configurations
    ]);
};

module.exports.withCobra = withCobra;
//module.exports = createRunOncePlugin(withCobra, 'withCobra', '1.0.0');
*/