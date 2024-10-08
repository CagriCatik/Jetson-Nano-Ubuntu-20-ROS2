#!/usr/bin/python3

import smbus
import time
import math

# MPU9250 Registers and their Address
MPU9250_ADDR = 0x68
PWR_MGMT_1 = 0x6B
ACCEL_XOUT_H = 0x3B
GYRO_XOUT_H = 0x43
MAG_XOUT_H = 0x03

def read_raw_data(bus, addr, reg):
    # Read data from the given register
    high = bus.read_byte_data(addr, reg)
    low = bus.read_byte_data(addr, reg + 1)
    
    # Combine the two bytes
    value = (high << 8) | low
    
    # Convert to signed value
    if value > 32768:
        value = value - 65536
    return value

def init_MPU9250(bus, addr):
    # Wake up the MPU9250 as it starts in sleep mode
    bus.write_byte_data(addr, PWR_MGMT_1, 0)

def get_accel_gyro(bus, addr):
    # Accelerometer data
    acc_x = read_raw_data(bus, addr, ACCEL_XOUT_H)
    acc_y = read_raw_data(bus, addr, ACCEL_XOUT_H + 2)
    acc_z = read_raw_data(bus, addr, ACCEL_XOUT_H + 4)
    
    # Gyroscope data
    gyro_x = read_raw_data(bus, addr, GYRO_XOUT_H)
    gyro_y = read_raw_data(bus, addr, GYRO_XOUT_H + 2)
    gyro_z = read_raw_data(bus, addr, GYRO_XOUT_H + 4)
    
    return (acc_x, acc_y, acc_z), (gyro_x, gyro_y, gyro_z)

def main():
    bus = smbus.SMBus(1)  # I2C bus on Jetson
    init_MPU9250(bus, MPU9250_ADDR)
    
    while True:
        accel_data, gyro_data = get_accel_gyro(bus, MPU9250_ADDR)
        
        print(f"Accelerometer: X={accel_data[0]}, Y={accel_data[1]}, Z={accel_data[2]}")
        print(f"Gyroscope: X={gyro_data[0]}, Y={gyro_data[1]}, Z={gyro_data[2]}")
        
        # Wait for 1 second before reading again
        time.sleep(1)

if __name__ == "__main__":
    main()
