find_program(bossac "bossac" HINTS ${flash_program_path})
if(NOT bossac)
	message([warning] "bossac not found.This program is nessecery to flash the Arduino Due chip. Please install this program and add it to your path or set flash_program_path in your CMakeLists.txt before continuing.")
endif()
set(DEVICE_LOCATION
    "ttyACM0"
    CACHE STRING
    "Serial device name"
)

if(bossac)
    if(WIN32)
        add_custom_target(flash DEPENDS ${PROJECT_NAME}.bin
                COMMAND ${PROJECT_SOURCE_DIR}/targets/arm32/cm3/atmel/sam3x/sam3x8e/flashscripts/arduino_due.bat
                COMMAND ${bossac} -p ${DEVICE_LOCATION} -U false -e -w -v -b ${PROJECT_NAME}.bin -R
                # ^ erease -> write -> verify -> boot -> reset
        )
    else(WIN32)
        add_custom_target(flash DEPENDS ${PROJECT_NAME}.bin
                COMMAND stty 1200 -F /dev/${DEVICE_LOCATION}
                COMMAND ${bossac} -p ${DEVICE_LOCATION} -U false -e -w -v -b ${PROJECT_NAME}.bin -R
                # ^ erease -> write -> verify -> boot -> reset
        )
    endif(WIN32)
endif()
