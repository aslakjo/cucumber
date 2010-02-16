Feature: cucumber codegeneratoin
  In order to get support in cuke4nuke
  Developers should have there attributes generated for them

  Scenario: Run codegeneration for cuke4nuke
    When I run rake generate
    Then "steps.cs" should match "public class GittAttribute : GivenAttribute"