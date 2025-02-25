const { getDefaultConfig } = require('@react-native/metro-config');
const os = require('os');

// Check if `os.availableParallelism` exists, otherwise, use `os.cpus().length`
if (!os.availableParallelism) {
    os.availableParallelism = () => os.cpus().length;
}

module.exports = getDefaultConfig(__dirname);
