@smoke
Feature: Home Page Title

    @epam
    Scenario: Page title epam

        Given I open "https://www.epam.com/" url
        Then Page title should be "EPAM | Software Engineering & Product Development Services"
        And Page title should not be "EPAM | Software Engineering & Product Development Services-s"
        When I wait "3" seconds

    @mobile
    @bash
    Scenario: Page title bash

        Given I open "https://www.bash.im/" url
        Then Page title should be "Цитатник Рунета"
        When I wait "3" seconds

    @mobile
    @medium
    Scenario: Page title medium

        Given I open "https://medium.com/" url
        Then Page title should be "Medium: Human stories and ideas."
        When I wait "3" seconds

    @Sc
    Scenario Outline: Page titles <URL>

        Given I open "<URL>" url
        Then Page title should be "<Title>."
        When I wait "3" seconds

        Examples:
            | URL                   | Title                                                                 |
            | https://medium.com/   | Цитатник Рунета                                                       |
            | https://www.epam.com/ | EPAM            \|Software Engineering & Product Development Services |