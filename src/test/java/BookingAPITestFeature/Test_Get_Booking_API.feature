Feature: Test Get Booking API

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
  Scenario: Validate Get All Booking
    Given path "booking"
    And header Content-Type = ContentType
    When method get
    Then status 200
    * def resBody = response
    * def actualBookingIdLength = resBody.length
    * print actualBookingIdLength
    * match resBody[10].bookingid == "#present"

  @smoke @regression
  Scenario: Test Get Specific Booking API
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
    * def bookingID = $.bookingid
    # Retreving User ----------------------------->
    Given path "booking/" + bookingID
    And header Content-Type = ContentType
    And header Accept = AcceptVar
    When method get
    Then status 200
    * def firstname = createRequestPayload.firstname
    * def lastname = createRequestPayload.lastname
    * def totalprice = parseInt(createRequestPayload.totalprice)
    * def checkin = createRequestPayload.bookingdates.checkin
    * def checkout = createRequestPayload.bookingdates.checkout
    * def depositpaid = true
    * def additionalneeds = ["Tea", "BreakFast"]
    * def expectedResponse = read('classpath:ResponsePays/GetBookingResponse.json')
    * match $ == expectedResponse

  @regression
  Scenario: Validate Invalid URL
    Given path "bookie"
    And header Content-Type = ContentType
    When method get
    Then status 404
    * match $ == "Not Found"

  @regression
  Scenario: Validate Invalid Method-Type
    Given path "booking"
    And header Content-Type = ContentType
    When method post
    Then status 500
    * match $ == "Internal Server Error"
