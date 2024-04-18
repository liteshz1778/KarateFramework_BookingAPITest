Feature: Test Create Booking API

  Background: 
    * url baseUrl
    * def createRequestPayload = read('classpath:RequestPays/CreateBookingPayload.json')
    # importing DataFaker Class ------->
    * def dataFakerObj = Java.type("Utilities.RandomDataGenerator")
    * def randomFname = dataFakerObj.getRandomFirstName();
    * def randomLname = dataFakerObj.getRandomLastName();
    * def randomTotalPrice = dataFakerObj.getRandomNumber(4);
    * def randomPastDate = dataFakerObj.getRandomPastDate();
    * def randomFutureDate = dataFakerObj.getRandomFutureDate();
    * set createRequestPayload.firstname = randomFname
    * set createRequestPayload.lastname =  randomLname
    * set createRequestPayload.totalprice = randomTotalPrice
    * set createRequestPayload.bookingdates.checkin = randomPastDate
    * set createRequestPayload.bookingdates.checkout = randomFutureDate

  @smoke @regression
  Scenario: Test Create Booking APId
    # Creating User ----------------------------->
    Given path "booking"
    And header Content-Type = ContentType
    And header Accept = AcceptVar
    And request createRequestPayload
    When method post
    Then status 200
    * def bookingid = $.bookingid
    * match $.bookingid == "#present"
    * def firstname = createRequestPayload.firstname
    * def lastname = createRequestPayload.lastname
    * def totalprice = parseInt(createRequestPayload.totalprice)
    * def checkin = createRequestPayload.bookingdates.checkin
    * def checkout = createRequestPayload.bookingdates.checkout
    * def depositpaid = true
    * def additionalneeds = ["Tea", "BreakFast"]
    * def expectedResponse = read('classpath:ResponsePays/CreateBookingResponse.json')
    * match $ == expectedResponse

  @regression
  Scenario: Validate Invalid Method-Type
    # Creating User ----------------------------->
    Given path "bookin"
    And header Content-Type = ContentType
    And request createRequestPayload
    When method post
    Then status 404
    * match $ == "Not Found"

  @regression
  Scenario: Validate Invalid URL
    # Creating User ----------------------------->
    Given path "booking"
    And header Content-Type = ContentType
    And request createRequestPayload
    When method delete
    Then status 404
    * match $ == "Not Found"
