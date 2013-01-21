all:
	g++ -o tests/test -Isrc tests/test.cpp
	g++ -o tests/test_class -Isrc tests/test_class.cpp

clean:
	rm tests/test tests/test_class
