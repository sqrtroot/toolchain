find_program(bossac "bossac")
if(NOT bossac)
	message([warning] "bossac not found. This program is nessecery to flash the Arduino Due chip. Please install this program and add it to your path before continuing.")
endif()

set(DEVICE_LOCATION
    "ttyACM0"
    CACHE STRING
    "Serial device name"
)

if(bossac)
        add_custom_target(flash DEPENDS ${PROJECT_NAME}.bin
                COMMAND bossac -p ${DEVICE_LOCATION} -U false -e -w -v -b ${PROJECT_NAME}.bin -R
                # ^ erease -> write -> verify -> boot -> reset
        )
endif()
