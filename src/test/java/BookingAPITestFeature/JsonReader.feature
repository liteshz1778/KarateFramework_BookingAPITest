Feature: Read Json Object & Json Array

  @regression
  Scenario: Read Json Array
    * def jsonArray =
      """
      [
      {	
      	"name" : "Litesh",
      	"city" : "Pune",
      	"age" : "25"
      },
      {	
      	"name" : "Suman",
      	"city" : "Mumbai",
      	"age" : "23"
      },
      {	
      	"name" : "Ruchi",
      	"city" : "Nashik",
      	"age" : "22"
      }
      ]
      """
    * print jsonArray
    * print jsonArray[1].name +" "+ jsonArray[1].city +" "+ jsonArray[1].age

  @regression
  Scenario: Read Json Object
    * def jsonObject =
      """
      {
      "glossary": {
      "title": "example glossary",
      "GlossDiv": {
      	"title": "S",
      	"GlossList": {
      		"GlossEntry": {
      			"ID": "SGML",
      			"SortAs": "SGML",
      			"GlossTerm": "Standard Generalized Markup Language",
      			"Acronym": "SGML",
      			"Abbrev": "ISO 8879:1986",
      			"GlossDef": {
      				"para": "A meta-markup language, used to create markup languages such as DocBook.",
      				"GlossSeeAlso": [
      					"GML",
      					"XML"
      				]
      			},
      			"GlossSee": "markup"
      		}
      	}
      }
      }
      }
      """
    * print jsonObject
    * print jsonObject.glossary
    * print jsonObject.glossary.GlossDiv
    * print jsonObject.glossary.GlossDiv.GlossList.GlossEntry
    * print jsonObject.glossary.GlossDiv.GlossList.GlossEntry.GlossDef.GlossSeeAlso[1]
    * print jsonObject.glossary.GlossDiv.GlossList.GlossEntry.GlossSee

  @regression
  Scenario: Extraing JSON Object using karate.get method
    * def jsonObject02 =
      """
      {
      "Student_Info": [
      {
      "name": "Litesh",
      "city": "Pune",
      "age": "25"
      },
      {
      "name": "Suman",
      "city": "Mumbai",
      "age": "23"
      },
      {
      "name": "Ruchi",
      "city": "Nashik",
      "age": "22"
      }
      ]
      }
      """
    * print karate.get('jsonObject02.Student_Info[1].name')
    * def city = karate.jsonPath(jsonObject02, '$.Student_Info[1].city')
    * print city
    