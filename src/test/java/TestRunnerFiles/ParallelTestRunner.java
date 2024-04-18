package TestRunnerFiles;

import static org.junit.Assert.assertTrue;

import org.junit.jupiter.api.Test;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;

public class ParallelTestRunner {

	@Test
	public void testParallel() {
		Results results = Runner.path("classpath:BookingAPITestFeature").tags("@regression").parallel(5);
		assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
	}
}
