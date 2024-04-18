package Utilities;

import java.util.concurrent.TimeUnit;

import net.datafaker.Faker;

public class RandomDataGenerator {

	public static Faker fk = new Faker();

	public static String getRandomNumber(int size) {
		return fk.number().digits(size);
	}

	public static String getRandomFirstName() {
		return fk.name().firstName();
	}

	public static String getRandomLastName() {
		return fk.name().lastName();
	}

	public static String getRandomPastDate() {
		return fk.date().past(1, TimeUnit.DAYS, "YYYY-MM-dd");
	}

	public static String getRandomFutureDate() {
		return fk.date().future(1, TimeUnit.DAYS, "YYYY-MM-dd");
	}
}
