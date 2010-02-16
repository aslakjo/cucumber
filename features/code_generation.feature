Feature: cucumber codegeneratoin
  In order to get support in cuke4nuke
  Developers should have there attributes generated for them

  Scenario: Class def for norwegian
    Given that there is no "steps.cs" file
    When I run generate cuke4nuke code
    Then "steps.cs" should match "public class GittAttribute : GivenAttribute"

  Scenario: norwegian step namespace
    Given that there is no "steps.cs" file
    When I run generate cuke4nuke code
    Then "steps.cs" should match "namespace Cuke4Nuke.Framework.Languages.Norwegian"