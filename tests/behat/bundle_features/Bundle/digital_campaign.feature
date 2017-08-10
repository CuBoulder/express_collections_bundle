Feature: Digital Campaign Bundle

  @api @digital_campaign @embed_templates
  Scenario Outline: Access Embed Templates Overview Page.
    Given  CU - I am logged in as a user with the <role> role
      And am on "admin/content/embeds"
    Then I should see <message>

    Examples:
      | role            | message         |
      | site_owner      | "Add Embeds"    |
      | administrator   | "Add Embeds"    |
      | developer       | "Add Embeds"    |
      | edit_my_content | "Access Denied" |
      | content_editor  | "Access Denied" |

  @api @digital_campaign @embed_templates
  Scenario: Create Tracking Pixel.
    Given  CU - I am logged in as a user with the "site_owner" role
      And I am on "admin/content/embeds/add/facebook"
      And I fill in "Label" with "Facebook Tracking Pixel"
      And I fill in "Path" with "node/1"
      And I fill in "ID" with "123456"
      And I select "Published" from "Status"
    When I press the "Save" button
      And I am on "node/1"
    Then the response should contain "https://www.facebook.com/tr?id=123456&ev=PageView&noscript=1"

  @api @digital_campaign @embed_templates @javascript
  Scenario: Create An A/B test.
    Given  CU - I am logged in as a user with the "site_owner" role
    # Enable module in .travis.yml since there is a memory exhaustion error.
    # When I enable the "cu_ab_test" module
    When I am on "block/add/a-b-block"
      And I fill in "Label" with "A/B Block"
      #And I fill in "edit-field-block-option-und-0-field-block-und-0-target-id" with "Text Block A (Text Block A) (1)"
      And I select "Text Block A (Text Block A)" from "field_block_option[und][0][field_block][und]"
      And I fill in "edit-field-block-option-und-0-field-percentage-und-0-value" with "100"
      And I press "Add another item"
      And I wait 3 seconds
      #And I fill in "edit-field-block-option-und-1-field-block-und-0-target-id" with "Text Block B (Text Block B) (2)"
      And I select "Text Block B (Text Block B)" from "field_block_option[und][1][field_block][und]"
      And I fill in "edit-field-block-option-und-1-field-percentage-und-0-value" with "0"
    When I press "Save"
    Then I should see "A/B Block"
      And I should see "Text Block A Content AAA"
    When I click "Edit Block"
      And I fill in "edit-field-block-option-und-0-field-percentage-und-0-value" with "0"
      And I fill in "edit-field-block-option-und-1-field-percentage-und-0-value" with "100"
    When I press "Save"
    Then I should see "A/B Block"
      And I should see "Text Block B Content BBB"
