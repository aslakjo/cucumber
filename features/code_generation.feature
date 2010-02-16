Feature: cucumber codegeneratoin
  In order to get support in cuke4nuke
  Developers should have there attributes generated for them

  Scenario: Class def for norwegian
    When I generate cuke4nuke code
    Then the generated code should include "public class GittAttribute : GivenAttribute"

  Scenario: Norwegian step namespace
    When I generate cuke4nuke code
    Then the generated code should include "namespace Cuke4Nuke.Framework.Languages.Norwegian"

  Scenario: None of the standard keywords should be included
    When I generate cuke4nuke code
    Then the generated code should not include "public void Given"
    And the generated code should not include "public void When"
    And the generated code should not include "public void Then"
