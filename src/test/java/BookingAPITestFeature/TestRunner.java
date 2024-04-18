package BookingAPITestFeature;

import com.intuit.karate.junit5.Karate;

public class TestRunner {

	@Karate.Test
	Karate testPostAPI() {
		return Karate.run("Test_Create_Booking_API").tags("@regression").relativeTo(getClass());
	}

	@Karate.Test
	Karate testGetAPI() {
		return Karate.run("Test_Get_Booking_API").tags("@regression").relativeTo(getClass());
	}

	@Karate.Test
	Karate testPutAPI() {
		return Karate.run("Test_Update_Booking_API").tags("@regression").relativeTo(getClass());
	}

	@Karate.Test
	Karate testPatchAPI() {
		return Karate.run("Test_Patch_Booking_API").tags("@regression").relativeTo(getClass());
	}

	@Karate.Test
	Karate testDeleteAPI() {
		return Karate.run("Test_Delete_Booking_API").tags("@regression").relativeTo(getClass());
	}
}
