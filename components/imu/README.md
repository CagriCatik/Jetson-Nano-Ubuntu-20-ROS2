# Jetson MPU9250 IMU Data Reader

This project demonstrates how to interface with the MPU9250 IMU sensor on a Jetson board to obtain accelerometer, gyroscope, and optionally magnetometer data. The script communicates via the I2C protocol and processes the raw sensor data for further use in determining the car's direction and other metrics.

## Features

- **Read accelerometer and gyroscope data** from the MPU9250 sensor.
- **I2C communication** via the `smbus2` library.
- Basic **data processing** with the option for future filtering or transformation.

## Requirements

To run this project, you will need:

- A Jetson board with I2C support.
- An MPU9250 IMU sensor connected to the I2C bus.
- Python 3 installed on your Jetson board.

## Installation

1. Clone the repository to your Jetson board:

   ```bash
   git clone https://github.com/your-username/jetson-mpu9250.git
   cd jetson-mpu9250
   ```

2. Install the required Python packages:

   ```bash
   pip install -r requirements.txt
   ```

   The `requirements.txt` file includes the following packages:
   - `smbus2`: For I2C communication with the MPU9250.
   - `numpy`: For numerical data processing (optional).
   - `matplotlib`: For data visualization (optional).

## Running the Script

To read the accelerometer and gyroscope data from the MPU9250 sensor, simply run the following command:

```bash
python mpu9250.py
```

This will continuously read data from the MPU9250 and print it to the console.

### Sample Output

The script will output the raw data from the accelerometer and gyroscope:

```
Accelerometer: X=16000, Y=2000, Z=-12000
Gyroscope: X=-500, Y=300, Z=120
...
```

## Customization

- The current script reads accelerometer and gyroscope data from the MPU9250. If you need to read the magnetometer data or perform further data processing (like calculating orientation), you can extend the script by adding magnetometer registers or implementing appropriate algorithms.

- You can adjust the data read frequency by modifying the sleep interval in the main loop (`time.sleep(1)`).
