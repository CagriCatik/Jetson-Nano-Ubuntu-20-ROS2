# Jetson MPU9250 IMU Data Reader

This project demonstrates how to interface with the MPU9250 IMU sensor on a Jetson board via I2C to obtain accelerometer and gyroscope data. The project provides a Python script to communicate with the sensor, process the raw data, and print it to the console.

## Features

- **I2C Communication**: Use the I2C bus to read data from the MPU9250 sensor.
- **Read Accelerometer and Gyroscope Data**: Capture and display raw sensor data.
- **Extendable**: Add additional features such as reading magnetometer data or sensor calibration.

## Hardware Requirements

- **Jetson Board** (e.g., Jetson Nano, Jetson Xavier NX, etc.)
- **MPU9250 IMU Sensor** (connected over I2C)
- Jumper wires for connections

## Software Requirements

- Python 3
- Required Python packages (see `requirements.txt`)

## Wiring the MPU9250 to the Jetson Board

### Jetson GPIO Pinout (I2C Interface)

- **I2C SDA (Pin 3)** on the Jetson connects to **SDA** on the MPU9250.
- **I2C SCL (Pin 5)** on the Jetson connects to **SCL** on the MPU9250.
- **3.3V Power (Pin 1)** connects to **VCC** on the MPU9250.
- **Ground (Pin 6)** connects to **GND** on the MPU9250.
- Optional: Connect **AD0** on the MPU9250 to **Ground** to use the I2C address `0x68` (or to **VCC** for `0x69`).

### Pin Mapping

| MPU9250 Pin | Jetson Pin (GPIO Header) | Description               |
|-------------|--------------------------|----------------------------|
| VCC         | 3.3V (Pin 1)             | Power supply               |
| GND         | GND (Pin 6)              | Ground                     |
| SDA         | SDA (Pin 3)              | I2C data line              |
| SCL         | SCL (Pin 5)              | I2C clock line             |
| AD0         | GND (optional)           | I2C address selection (0x68)|

## Setup Instructions

### 1. Enable I2C on Jetson

Check that the I2C interface is enabled by listing the available I2C buses:

```bash
ls /dev/i2c-*
```

Typically, the I2C bus used will be `/dev/i2c-1`.

### 2. Install Required Python Libraries

Install the required Python packages using the `requirements.txt` file:

```bash
pip install -r requirements.txt
```

The required packages include:
- **smbus2**: For I2C communication with the sensor.
- **numpy**: For data processing (optional).
- **matplotlib**: For visualizing data (optional).

### 3. Verify I2C Connection with `i2cdetect`

To ensure that the MPU9250 sensor is properly connected, use `i2cdetect` to scan for devices on the I2C bus:

```bash
sudo apt-get install -y i2c-tools  # If i2c-tools is not already installed
sudo i2cdetect -y 1
```

You should see the address `0x68` (or `0x69` if `AD0` is high) in the output grid. Example output:

```
     0 1 2 3 4 5 6 7 8 9 a b c d e f
00:          -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- 68 -- -- -- --
```

### 4. Run the Python Script

Now that the MPU9250 is connected and detected, run the Python script to read accelerometer and gyroscope data:

```bash
python mpu9250.py
```

The output will look something like this:

```
Accelerometer: X=16000, Y=2000, Z=-12000
Gyroscope: X=-500, Y=300, Z=120
...
```

The script will continuously output sensor data until interrupted.

## Customization

- **Sampling Rate**: You can modify the sampling rate by adjusting the `time.sleep()` duration in the main loop.
- **Magnetometer Data**: The script can be extended to read the magnetometer data by addressing the magnetometer registers (accessible via I2C).
- **Data Visualization**: You can use `matplotlib` to visualize the sensor data in real time.

## Troubleshooting

- **No I2C Device Found**: Double-check the wiring, especially the SDA and SCL lines, and ensure the sensor is powered.
- **Permission Errors**: Run the script with `sudo` if you encounter permission issues accessing I2C devices.
- **Incorrect Sensor Address**: Ensure that `AD0` is correctly connected to set the appropriate I2C address (`0x68` or `0x69`).
