CC = g++
SRC = main.cpp FuncA.cpp
TARGET = main

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(SRC) -o $(TARGET)

clean:
	rm -f $(TARGET)
