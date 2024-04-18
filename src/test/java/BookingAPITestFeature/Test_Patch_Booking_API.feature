Feature: Test Patch Booking API

  Background: 
    * url baseUrl
    * def accesTokenRequestPayload = read('classpath:RequestPays/AccessToken.json')
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
    # Accessing Access Token Feature File ------------------------>
    * def accessTokenData = call read('AccessToken_API.feature')
    * def accessToken = accessTokenData.response.token

  @smoke @regression
  Scenario: Test Patch Booking API
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
    # Patching/Upating User ----------------------------->
    Given path "booking/" + bookingID
    And header Content-Type = ContentType
    And header Accept = AcceptVar
    And header Cookie = "token=" + accessToken
    * def patchRequestPayload =
      """
      {
      "firstname" : "David",
      "lastname" : "Warner"
      }
      """
    And request patchRequestPayload
    When method patch
    Then status 200
    * def firstname = patchRequestPayload.firstname
    * def lastname = patchRequestPayload.lastname
    * def totalprice = parseInt(createRequestPayload.totalprice)
    * def checkin = createRequestPayload.bookingdates.checkin
    * def checkout = createRequestPayload.bookingdates.checkout
    * def depositpaid = true
    * def additionalneeds = ["Tea", "BreakFast"]
    * def expectedResponse = read('classpath:ResponsePays/GetBookingResponse.json')
    * match $ == expectedResponse
    # Retreving User ----------------------------->
    Given path "booking/" + bookingID
    And header Content-Type = ContentType
    And header Accept = AcceptVar
    When method get
    Then status 200
    * def firstname = patchRequestPayload.firstname
    * def lastname = patchRequestPayload.lastname
    * def totalprice = parseInt(createRequestPayload.totalprice)
    * def checkin = createRequestPayload.bookingdates.checkin
    * def checkout = createRequestPayload.bookingdates.checkout
    * def depositpaid = true
    * def additionalneeds = ["Tea", "BreakFast"]
    * def expectedResponse = read('classpath:ResponsePays/GetBookingResponse.json')
    * match $ == expectedResponse

  @regression
  Scenario: Validate Invalid URL
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
    # Patching/Upating User ----------------------------->
    Given path "bookin/" + bookingID
    And header Content-Type = ContentType
    And header Accept = AcceptVar
    And header Cookie = "token=" + accessToken
    * def patchRequestPayload =
      """
      {
      "firstname" : "David",
      "lastname" : "Warner"
      }
      """
    And request patchRequestPayload
    When method patch
    Then status 404
    * match $ == "Not Found"
