//
// Copyright 2019-2021 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
// manages profile of device

import Toybox.BluetoothLowEnergy;

class ProfileManager {
    // 32-byte service UUID = Vendor specific 32-byte base UUID with the 2nd and 3rd bytes (when using big endian to view the bytes) swapped out for the 4-byte service UUID
    // Here (notes in big endian):
    //         32-byte Base UUID = f364adc9-00b0-4240-ba50-05ca45bf8abc
    //       4-byte Service UUID =     1400
    //      32-byte Service UUID = f3641400-00b0-4240-ba50-05ca45bf8abc
    public const DUKE_CUSTOM_SERVICE = BluetoothLowEnergy.stringToUuid("7DEF8317-7300-4EE6-8849-46FACE74CA2A");
    
    // 32-byte characteristic UUID = Vendor specific 32-byte base UUID with the 2nd and 3rd bytes (when using big endian to view the bytes) swapped out for the 4-byte characteristic UUID
    // Here (notes in big endian):
    //                32-byte Base UUID = f364adc9-00b0-4240-ba50-05ca45bf8abc
    //       4-byte Characteristic UUID =     1401
    //      32-byte Characteristic UUID = f3641401-00b0-4240-ba50-05ca45bf8abc
    public const DUKE_CUSTOM_CHARACTERISTIC = BluetoothLowEnergy.stringToUuid("7DEF8317-7301-4EE6-8849-46FACE74CA2A");

    // 32-byte characteristic UUID = Vendor specific 32-byte base UUID with the 2nd and 3rd bytes (when using big endian to view the bytes) swapped out for the 4-byte characteristic UUID
    // Here (notes in big endian):
    //                32-byte Base UUID = f364adc9-00b0-4240-ba50-05ca45bf8abc
    //       4-byte Characteristic UUID =     1402
    //      32-byte Characteristic UUID = f3641402-00b0-4240-ba50-05ca45bf8abc
    //DUKE_CUSTOM_CHARACTERISTIC
    public const DUKE_GPIO_CHARACTERISTIC = BluetoothLowEnergy.stringToUuid("7DEF8317-7302-4EE6-8849-46FACE74CA2A");

        private const _envProfileDef = {
            :uuid => DUKE_CUSTOM_SERVICE,
            :characteristics => [
                {
                :uuid => DUKE_CUSTOM_CHARACTERISTIC,
                :descriptors => [BluetoothLowEnergy.cccdUuid()]
                },
                {
                :uuid => DUKE_GPIO_CHARACTERISTIC,
                :descriptors => [BluetoothLowEnergy.cccdUuid()]
                }]
        };

    //! Register the bluetooth profile
    public function registerProfiles() as Void {
        BluetoothLowEnergy.registerProfile(_envProfileDef);
    }
}
