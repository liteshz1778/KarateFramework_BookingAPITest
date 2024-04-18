Feature: Print & Arithmetic Operations

  @regression
  Scenario: Print Hello world
    * print "helloworld"

  @regression
  Scenario: Print Balance
    * def balance = 20
    * def fee = 20
    * print "Balance is:---->" + (balance + fee)

  @regression
  Scenario: Prnt Multiplication
    * def a = 200
    * def b = 45
    * print "Multiplication is:=========>" + a * b

  @regression
  Scenario Outline: Print Firstname & Lastname
    * print "<firstname>" +" & "+ "<lastname>"

    Examples: 
      | firstname | lastname |
      | Litesh    | Zadane   |
      | Sunil     | Zadane   |

  @regression
  Scenario Outline: calculate percentage
    * print "<remainingAmount>" / "<totalAmount>" * 100

    Examples: 
      | remainingAmount | totalAmount |
      |              95 |         500 |
      |             167 |         344 |

  @regression
  Scenario Outline: Data Driven Test on JSON
    * def jsonObject =
      """
      {
      	"id": <idValue>,
      	"name": "<nameValue>",
      	"isManager": <isManageValue>
      	
      }
      """
    * print jsonObject
    * print __row
    * print __num

    Examples: 
      | idValue | nameValue | isManageValue |
      |     101 | RAM       | true          |
      |     102 | Sham      | false         |

  @regression
  Scenario: Embedded Expressions
    * def employee1 = {id: 101, name:"Litesh"}
    * def id = 101
    * def name = "Litesh"
    * def employee2 = {"id": #(id), "name": "#(name)"}
    * print employee1
    * print employee2
    * match employee1 == employee2
