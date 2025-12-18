
@feature_user_registration
Feature: UserRegistrationProcess

  Background: 
    Given the user is on the Registration Page

  @valid-registration
  Scenario Outline: User Registration Process
    Given the user navigates to the registration URL "https://app.example.com/register"
    When the user enters "<email>" in the email field
    And the user enters "<password>" in the password field
    And the user enters "<confirmPassword>" in the confirm password field
    And the user clicks the Register button
    Then the current URL should contain "/confirmation"
    And the email field should contain "<email>"
    And the password field should not be empty
    And the confirm password field should match the password
    And the confirmation message should be displayed

    Examples:
      | email                     | password           | confirmPassword      |
      | test_user@example.com     | SecurePass123!     | SecurePass123!       |
      | invalid-email             | ValidPass123!      | ValidPass123!        |
      |                           | ValidPass123!      | ValidPass123!        |
      | test_user@example.com     |                     |                      |
      | test_user@example.com     | short               | short                |
      | test_user@example.com     | SecurePass123!     | DifferentPass456!    |

  @valid-registration
  Scenario Outline: User Registration Process
    Given the user navigates to the registration URL
    When the user enters "<email>" in the email field
    And the user enters "<password>" in the password field
    And the user enters "<confirmPassword>" in the confirm password field
    And the user clicks the Register button
    Then the user should see a confirmation message
    And the current URL should contain "/confirmation"
    And the email field should contain "<email>"
    And the password field should not be empty
    And the confirm password field should match the password

    Examples:
      | email                     | password                     | confirmPassword               |
      | unique_user@example.com   | AnotherSecurePass123!        | AnotherSecurePass123!        |

  @feature_user_registration
  @confirmation_email_sent
  Scenario Outline: User Registration Process
    Given the user navigates to the registration URL "https://app.example.com/register"
    When the user enters email "<email>" in the email field
    And the user enters password "<password>" in the password field
    And the user enters password "<confirmPassword>" in the confirm password field
    And the user clicks the Register button
    Then the user should be redirected to a URL containing "/confirmation"
    And the email field should contain "<email>"
    And the password field should not be empty
    And the confirm password field should match the password
    And the Register button is clicked with no errors
    And a confirmation email should be logged as sent to "<email>"

    Examples:
      | email                   | password        | confirmPassword   |
      | test_email@example.com  | Password123!    | Password123!      |

  @valid-registration
  Scenario Outline: User Registration Process
    When I enter "<email>" in the email field
    And I enter "<password>" in the password field
    And I enter "<confirmPassword>" in the confirm password field
    And I click the Register button
    Then the current URL should contain "/confirmation"
    And the email field should contain "<email>"
    And the password field should not be empty
    And the confirm password field should match password
    And the confirmation message should be displayed

    Examples:
      | email                     | password          | confirmPassword     |
      | valid_user@example.com    | ValidPass456!     | ValidPass456!       |

@missing-email
Scenario Outline: User Registration Process Without Email
  Given the user is on the Registration Page
  When the user enters "<email>" in the email field
  And the user enters "<password>" in the password field
  And the user enters "<confirmPassword>" in the confirm password field
  And the user clicks the Register button
  Then the error message element should be displayed
  And the error message text should be "Email is required"

  Examples:
    | email | password        | confirmPassword  |
    |       | Password123!    | Password123!     |

  @missing-password
  Scenario Outline: User Registration with Missing Password
    Given the user is on the Registration Page
    When I enter "<email>" in the email field
    And I enter "<password>" in the password field
    And I enter "<confirmPassword>" in the confirm password field
    And I click the Register button
    Then the user should see the error message "Password is required"

    Examples:
      | email                     | password | confirmPassword |
      | test_user@example.com     |          |                  |

  @password_mismatch_error
  Scenario Outline: User Registration Process with Mismatched Passwords
    Given the user is on the Registration Page
    When I enter "<email>" in the email field
    And I enter "<password>" in the password field
    And I enter "<confirmPassword>" in the confirm password field
    And the user clicks the Register button
    Then the current URL should be "https://app.example.com/register"
    And the email field should contain "<email>"
    And the password field should contain "<password>"
    And the confirm password field should contain "<confirmPassword>"
    And the Register button should be clicked
    Then the error message text should equal "Passwords do not match"

    Examples:
      | email                   | password       | confirmPassword       |
      | test_user@example.com   | Password123!   | DifferentPassword456!  |

  @invalid-email
  Scenario Outline: User Registration Process with Invalid Email
    Given the user is on the Registration Page
    When the user enters "<email>" in the email field
    And the user enters "<password>" in the password field
    And the user enters "<confirmPassword>" in the confirm password field
    And the user clicks the Register button
    Then the error message element should be displayed
    And the error message text should equal "Please enter a valid email address"

    Examples:
      | email           | password          | confirmPassword    |
      | invalid-email   | ValidPass123!     | ValidPass123!      |

  @duplicate-email-registration
  Scenario Outline: User Registration Process with Existing Email
    When I enter "<email>" in the email field
    And I enter "<password>" in the password field
    And I enter "<confirmPassword>" in the confirm password field
    And I click the Register button
    Then the error message should be displayed
    And the error message text should be "<errorMessage>"

    Examples:
      | email                     | password          | confirmPassword     | errorMessage             |
      | existing_user@example.com | ValidPass123!     | ValidPass123!       | Email already exists      |

  @short_password
  Scenario Outline: User Registration Process with Short Password
    Given the user is on the Registration Page
    When I enter "<email>" in the email field
    And I enter "<password>" in the password field
    And I enter "<confirmPassword>" in the confirm password field
    And the user clicks the Register button
    Then the current URL should be "https://app.example.com/register"
    And the email field should contain "<email>"
    And the password field should contain "<password>"
    And the confirm password field should contain "<confirmPassword>"
    And the user should see the error message "Password must be at least 8 characters"

    Examples:
      | email                    | password | confirmPassword |
      | test_user@example.com    | short    | short           |

  @feature_user_registration
  @invalid-password
  Scenario Outline: User Registration Process with Invalid Password
    Given the user is on the Registration Page
    When I enter "<email>" in the email field
    And I enter "<password>" in the password field
    And I enter "<confirmPassword>" in the confirm password field
    And the user clicks the Register button
    Then the user should see an error message "Password must contain at least one special character"

    Examples:
      | email                     | password              | confirmPassword        |
      | test_user@example.com    | NoSpecialChar123      | NoSpecialChar123       |

  @feature_user_registration
  @invalid-password-test
  Scenario Outline: User Registration with Invalid Password
    Given the user is on the Registration Page
    When the user enters "<email>" in the email field
    And the user enters "<password>" in the password field
    And the user enters "<confirmPassword>" in the confirm password field
    And the user clicks the Register button
    Then the error message should display "<errorMessage>"

    Examples:
      | email                    | password             | confirmPassword       | errorMessage                             |
      | test_user@example.com    | NoNumbersHere!       | NoNumbersHere!        | Password must contain at least one number |

  @invalid-email-format
  Scenario Outline: User Registration Process with Invalid Email Format
    Given the user is on the Registration Page
    When I enter "<email>" in the email field
    And I enter "<password>" in the password field
    And I enter "<confirmPassword>" in the confirm password field
    And I click the Register button
    Then the error message should be displayed
    And the error message text should equal "Please enter a valid email address"

    Examples:
      | email          | password          | confirmPassword    |
      | invalid-email  | ValidPass123!     | ValidPass123!      |

  @duplicate_email_registration
  Scenario Outline: User Registration Process with Existing Email
    Given the user is on the Registration Page
    When I enter "<email>" in the email field
    And I enter "<password>" in the password field
    And I enter "<confirmPassword>" in the confirm password field
    And the user clicks the Register button
    Then the error message element should be displayed
    And the error message text should equal "Email already exists"

    Examples:
      | email                     | password          | confirmPassword     |
      | existing_user@example.com | ValidPass123!    | ValidPass123!       |

  @empty-email
  Scenario Outline: User Registration Without Email
    Given the user is on the Registration URL
    When I enter "<email>" in the email field
    And I enter "<password>" in the password field
    And I enter "<confirmPassword>" in the confirm password field
    And I click the Register button
    Then the error message should be displayed
    And the error message text should be "Email is required"

    Examples:
      | email | password        | confirmPassword  |
      |       | Password123!    | Password123!     |

  @empty_password
  Scenario Outline: User attempts registration without entering a password
    Given the user navigates to the registration URL
    When the user enters "<email>" in the email field
    And the user enters "<password>" in the password field
    And the user enters "<confirmPassword>" in the confirm password field
    And the user clicks the Register button
    Then the user should see the error message element displayed
    And the error message text equals "Password is required"

    Examples:
      | email                     | password | confirmPassword |
      | test_user@example.com    |          |                 |

@password-mismatch
Scenario Outline: User Registration Process
  Given the user navigates to the registration URL
  When the user enters "<email>" in the email field
  And the user enters "<password>" in the password field
  And the user enters "<confirmPassword>" in the confirm password field
  And the user clicks the Register button
  Then the user should see the error message "Passwords do not match"

  Examples:
    | email                  | password       | confirmPassword          |
    | test_user@example.com  | Password123!   | DifferentPassword456!    |

  @short-password
  Scenario Outline: User Registration Process with Short Password
    Given the user is on the Registration Page
    When I enter "<email>" in the email field
    And I enter "<password>" in the password field
    And I enter "<confirmPassword>" in the confirm password field
    And I click the Register button
    Then the error message text equals "Password must be at least 8 characters"

    Examples:
      | email                 | password | confirmPassword |
      | test_user@example.com | short    | short           |

  @feature_user_registration
  @password_validation_error
  Scenario Outline: User Registration Process
    Given the user is on the Registration Page
    When the user enters "<email>" in the email field
    And the user enters "<password>" in the password field
    And the user enters "<confirmPassword>" in the confirm password field
    And the user clicks the Register button
    Then the user should see an error message that says "Password must contain at least one special character"

    Examples:
      | email                      | password            | confirmPassword       |
      | test_user@example.com     | NoSpecialChar123    | NoSpecialChar123      |

@password_without_numbers
Scenario Outline: User Registration Process
  Given the user is on the Registration Page
  When the user enters "<email>" in the email field
  And the user enters "<password>" in the password field
  And the user enters "<confirmPassword>" in the confirm password field
  And the user clicks the Register button
  Then the user should see the error message "Password must contain at least one number"

  Examples:
    | email                     | password            | confirmPassword       |
    | test_user@example.com     | NoNumbersHere!      | NoNumbersHere!        |

  @max-length-email-registration
  Scenario Outline: User Registration Process
    Given the user is on the Registration Page
    When I enter "<email>" in the email field
    And I enter "<password>" in the password field
    And I enter "<confirmPassword>" in the confirm password field
    And I click the Register button
    Then the confirmation message should be displayed

    Examples:
      | email                                                         | password           | confirmPassword     |
      | aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa@example.com | SecurePass123! | SecurePass123! |

  @valid-registration
  Scenario Outline: User Registration Process
    Given the user navigates to the registration URL
    When the user enters "<email>" in the email field
    And the user enters "<password>" in the password field
    And the user enters "<confirmPassword>" in the confirm password field
    And the user clicks the Register button
    Then the user should be directed to the confirmation page
    And the email field should contain "<email>"
    And the password field should not be empty
    And the confirm password field should match password
    And the confirmation message should be displayed

    Examples:
      | email                   | password   | confirmPassword |
      | test_user@example.com   | P@ssw0rd   | P@ssw0rd        |

  @valid-registration
  Scenario Outline: User Registration Process
    Given the user is on the Registration Page
    When the user enters "<email>" in the email field
    And the user enters "<password>" in the password field
    And the user enters "<confirmPassword>" in the confirm password field
    And the user clicks the Register button
    Then the user should be redirected to the confirmation URL
    And the email field should contain "<email>"
    And the password field should not be empty
    And the confirm password field should match the password
    And the confirmation message should be displayed

    Examples:
      | email                        | password          | confirmPassword     |
      | test_user+tag@example.com   | SecurePass123!    | SecurePass123!      |

  @valid-registration
  Scenario Outline: User Registration Process
    Given the user navigates to the registration URL "https://app.example.com/register"
    When the user enters "<email>" in the email field
    And the user enters "<password>" in the password field
    And the user enters "<confirmPassword>" in the confirm password field
    And the user clicks the Register button
    Then the user should see the confirmation message

    Examples:
      | email                     | password         | confirmPassword    |
      | test123_user@example.com  | SecurePass123!   | SecurePass123!     |

@successful_registration
Scenario Outline: User Registration Process
  When I navigate to registration URL "https://app.example.com/register"
  And I enter email "<email>" in email field
  And I enter password "<password>" in password field
  And I enter password "<confirmPassword>" in confirm password field
  And I click Register button
  Then the current URL should contain "/confirmation"
  And the email field should contain "<email>"
  And the password field should not be empty
  And the confirm password field should match password
  And the Register button should be clicked and no errors should occur
  And the confirmation message should be displayed

  Examples:
    | email                    | password           | confirmPassword      |
    | Test_User@example.com    | SecurePass123!     | SecurePass123!       |

  @valid-registration
  Scenario Outline: User Registration Process
    Given the user navigates to the registration URL
    When the user enters "<email>" in the email field
    And the user enters "<password>" in the password field
    And the user enters "<confirmPassword>" in the confirm password field
    And the user clicks the Register button
    Then the confirmation message should be displayed

    Examples:
      | email                   | password           | confirmPassword     |
      | test.user@example.com   | SecurePass123!     | SecurePass123!      |

  @valid_registration
  Scenario Outline: User Registration Process
    Given the user is on the Registration Page
    When I enter "<email>" in the email field
    And I enter "<password>" in the password field
    And I enter "<confirmPassword>" in the confirm password field
    And I click the Register button
    Then the current URL should contain "/confirmation"
    And the email field should contain "<email>"
    And the password field should not be empty
    And the confirm password field matches the password
    And a confirmation message should be displayed

    Examples:
      | email                     | password            | confirmPassword       |
      | test-user@example.com     | SecurePass123!      | SecurePass123!        |

  @successful-registration
  Scenario Outline: User Registration Process
    Given the user navigates to the registration URL "https://app.example.com/register"
    When the user enters "<email>" in the email field
    And the user enters "<password>" in the password field
    And the user enters "<confirmPassword>" in the confirm password field
    And the user clicks the Register button
    Then the current URL should contain "/confirmation"
    And the email field should contain "<email>"
    And the password field should not be empty
    And the confirm password field should match the password
    And the confirmation message should be displayed

    Examples:
      | email                  | password         | confirmPassword    |
      | test_user@example.com  | SecurePass123!   | SecurePass123!     |

@valid-registration
Scenario Outline: User Registration with Valid Email and Password
  Given the user is on the Registration Page
  When I enter "<email>" in the email field
  And I enter "<password>" in the password field
  And I enter "<confirmPassword>" in the confirm password field
  And I click the Register button
  Then the current URL should contain "/confirmation"
  And the email field should contain "<email>"
  And the password field should not be empty
  And the confirm password field should match the password
  And a confirmation message should be displayed

  Examples:
    | email                     | password            | confirmPassword      |
    | test_user@example.com     | SecurePass123!     | SecurePass123!       |
    | invalid-email             | ValidPass123!      | ValidPass123!        |
    |                           | ValidPass123!      | ValidPass123!        |
    | test_user@example.com     |                      |                       |
    | test_user@example.com     | short               | short                |
    | test_user@example.com     | SecurePass123!     | DifferentPass456!    |

  @valid-registration
  Scenario Outline: User Registration Process
    Given the user navigates to the registration URL
    When the user enters "<email>" in the email field
    And the user enters "<password>" in the password field
    And the user enters "<confirmPassword>" in the confirm password field
    And the user clicks the Register button
    Then the user should see a confirmation message

    Examples:
      | email                     | password                   | confirmPassword           |
      | unique_user@example.com   | AnotherSecurePass123!      | AnotherSecurePass123!      |

  @successful_registration
  Scenario Outline: User Registration Process
    Given the user is on the Registration Page
    When the user enters "<email>" in the email field
    And the user enters "<password>" in the password field
    And the user enters "<confirmPassword>" in the confirm password field
    And the user clicks the Register button
    Then the current URL should contain "/confirmation"
    And the email field should contain "<email>"
    And the password field should not be empty
    And the confirm password field should match the password
    And the Register button should be clicked and no errors occur
    And the confirmation email should be logged as sent to "<email>"

    Examples:
      | email                      | password        | confirmPassword   |
      | test_email@example.com     | Password123!    | Password123!      |

@valid-registration
Scenario Outline: User Registration Process
  Given the user is on the Registration Page
  When I enter "<email>" in the email field
  And I enter "<password>" in the password field
  And I enter "<confirmPassword>" in the confirm password field
  And I click the Register button
  Then the confirmation message should be displayed
  And the current URL should contain "/confirmation"
  And the email field should contain "<email>"
  And the password field should not be empty
  And the confirm password field should match the password

  Examples:
    | email                    | password          | confirmPassword     |
    | valid_user@example.com   | ValidPass456!     | ValidPass456!       |

@empty_email_registration
Scenario Outline: User Registration with Empty Email Field
  Given the user is on the Registration Page
  When I enter "<email>" in the email field
  And I enter "<password>" in the password field
  And I enter "<confirmPassword>" in the confirm password field
  And the user clicks the Register button
  Then the current URL should be "https://app.example.com/register"
  And the email field should be empty
  And the password field should not be empty
  And the Register button should be clicked
  And the error message element should be displayed
  And the error message text should equal "Email is required"

  Examples:
    | email | password        | confirmPassword  |
    |       | Password123!    | Password123!     |

  @missing_password_error
  Scenario Outline: User Registration Process with Missing Password
    Given the user is on the Registration Page
    When I enter "<email>" in the email field
    And I enter "<password>" in the password field
    And I enter "<confirmPassword>" in the confirm password field
    And I click the Register button
    Then the current URL should be "https://app.example.com/register"
    And the email field should contain "<email>"
    And the password field should be empty
    And the error message element should be displayed
    And the error message text should equal "Password is required"

    Examples:
      | email                   | password | confirmPassword |
      | test_user@example.com   |          |                 |

  @password-mismatch-error
  Scenario Outline: User Registration Process
    Given the user is on the Registration Page
    When the user enters "<email>" in the email field
    And the user enters "<password>" in the password field
    And the user enters "<confirmPassword>" in the confirm password field
    And the user clicks the Register button
    Then the user should see the error message "Passwords do not match"

    Examples:
      | email                      | password         | confirmPassword           |
      | test_user@example.com     | Password123!     | DifferentPassword456!     |

@invalid-email-registration
Scenario Outline: User Registration Process with Invalid Email
  When I enter "<email>" in the email field
  And I enter "<password>" in the password field
  And I enter "<confirmPassword>" in the confirm password field
  And I click the Register button
  Then the error message should be displayed
  And the error message text should be "Please enter a valid email address"

  Examples:
    | email          | password           | confirmPassword     |
    | invalid-email  | ValidPass123!      | ValidPass123!       |

@duplicate-email-error
Scenario Outline: User Registration with Existing Email
  Given the user is on the Registration Page
  When the user enters "<email>" in the email field
  And the user enters "<password>" in the password field
  And the user enters "<confirmPassword>" in the confirm password field
  And the user clicks the Register button
  Then the current URL should be "https://app.example.com/register"
  And the email field should contain "<email>"
  And the password field should not be empty
  And the error message should be displayed
  And the error message text should equal "Email already exists"

  Examples:
    | email                        | password           | confirmPassword     |
    | existing_user@example.com    | ValidPass123!      | ValidPass123!       |

  @short-password-error
  Scenario Outline: User Registration Process with Short Password
    Given the user is on the Registration Page
    When I enter "<email>" in the email field
    And I enter "<password>" in the password field
    And I enter "<confirmPassword>" in the confirm password field
    And I click the Register button
    Then the error message text should equal "Password must be at least 8 characters"

    Examples:
      | email                    | password | confirmPassword |
      | test_user@example.com    | short    | short           |

  @invalid-password
  Scenario Outline: User Registration with Invalid Password
    Given the user is on the Registration Page
    When the user enters "<email>" in the email field
    And the user enters "<password>" in the password field
    And the user enters "<confirmPassword>" in the confirm password field
    And the user clicks the Register button
    Then the error message text equals "Password must contain at least one special character"

    Examples:
      | email                      | password             | confirmPassword        |
      | test_user@example.com     | NoSpecialChar123     | NoSpecialChar123       |

  @invalid-password
  Scenario Outline: User Registration Process with No Numbers in Password
    Given the user is on the Registration Page
    When the user enters email "<email>"
    And the user enters password "<password>"
    And the user enters password "<confirmPassword>"
    And the user clicks the Register button
    Then the user should see the error message "<errorMessage>"

    Examples:
      | email                   | password            | confirmPassword       | errorMessage                                   |
      | test_user@example.com   | NoNumbersHere!      | NoNumbersHere!        | Password must contain at least one number      |

@invalid-email-format
Scenario Outline: User Registration Process with Improperly Formatted Email
  Given the user is on the Registration Page
  When I enter "<email>" in the email field
  And I enter "<password>" in the password field
  And I enter "<confirmPassword>" in the confirm password field
  And the user clicks the Register button
  Then the error message element should be displayed
  And the error message text equals "Please enter a valid email address"

  Examples:
    | email            | password          | confirmPassword    |
    | invalid-email    | ValidPass123!     | ValidPass123!      |

  @duplicate_email_registration
  Scenario Outline: User Registration Process with Existing Email
    When I enter "<email>" in the email field
    And I enter "<password>" in the password field
    And I enter "<confirmPassword>" in the confirm password field
    And I click the Register button
    Then the current URL should be "https://app.example.com/register"
    And the email field should contain "<email>"
    And the password field should not be empty
    And the Register button should be clicked
    And the error message element should be displayed
    And the error message text should equal "Email already exists"

    Examples:
      | email                       | password          | confirmPassword     |
      | existing_user@example.com   | ValidPass123!     | ValidPass123!       |

  @empty_email_registration
  Scenario Outline: User Registration with Empty Email
    Given the user is on the Registration Page
    When I enter "<email>" in the email field
    And I enter "<password>" in the password field
    And I enter "<confirmPassword>" in the confirm password field
    And I click the Register button
    Then the user should see an error message saying "Email is required"

    Examples:
      | email | password        | confirmPassword  |
      |       | Password123!    | Password123!     |

@empty_password
Scenario Outline: User Registration Process without Password
  Given the user is on the Registration Page
  When the user enters "<email>" in the email field
  And the user enters "<password>" in the password field
  And the user enters "<confirmPassword>" in the confirm password field
  And the user clicks the Register button
  Then the user should see the error message element
  And the error message text should be "Password is required"

  Examples:
    | email                   | password | confirmPassword |
    | test_user@example.com   |          |                 |

  @password-mismatch
  Scenario Outline: User Registration Process with Mismatched Passwords
    Given the user is on the Registration Page
    When I enter "<email>" in the email field
    And I enter "<password>" in the password field
    And I enter "<confirmPassword>" in the confirm password field
    And I click the Register button
    Then the user should see the error message "Passwords do not match"

    Examples:
      | email                    | password        | confirmPassword         |
      | test_user@example.com    | Password123!    | DifferentPassword456!   |

  @short_password_error
  Scenario Outline: User Registration with Short Password
    Given the user is on the Registration Page
    When I enter "<email>" in the email field
    And I enter "<password>" in the password field
    And I enter "<confirmPassword>" in the confirm password field
    And I click the Register button
    Then the user should see the error message "Password must be at least 8 characters"

    Examples:
      | email                     | password | confirmPassword |
      | test_user@example.com     | short    | short           |

  @feature_user_registration
  @invalid-password
  Scenario Outline: User Registration Process with Invalid Password
    Given the user navigates to the registration URL
    When the user enters "<email>" in the email field
    And the user enters "<password>" in the password field
    And the user enters "<confirmPassword>" in the confirm password field
    And the user clicks the Register button
    Then the user should see the error message "Password must contain at least one special character"

    Examples:
      | email                    | password              | confirmPassword        |
      | test_user@example.com    | NoSpecialChar123      | NoSpecialChar123       |

@invalid-password
Scenario Outline: User Registration Process with Invalid Password
  Given the user is on the Registration Page
  When I enter "<email>" in the email field
  And I enter "<password>" in the password field
  And I enter "<confirmPassword>" in the confirm password field
  And I click the Register button
  Then the error message text equals "Password must contain at least one number"

  Examples:
    | email                       | password           | confirmPassword      |
    | test_user@example.com      | NoNumbersHere!     | NoNumbersHere!       |

@max-length-email
Scenario Outline: User Registration Process with Maximum Length Email
  Given the user is on the Registration Page
  When I enter "<email>" in the email field
  And I enter "<password>" in the password field
  And I enter "<confirmPassword>" in the confirm password field
  And I click the Register button
  Then the current URL should contain "/confirmation"
  And the email field should contain the maximum length email
  And the password field should not be empty
  And the confirm password field should match the password
  And the Register button should be clicked and no errors occurred
  And the confirmation message should be displayed

  Examples:
    | email                                                             | password            | confirmPassword      |
    | aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa@example.com | SecurePass123!     | SecurePass123!       |

  @valid-registration
  Scenario Outline: User Registration Process
    Given the user is on the Registration Page
    When I enter "<email>" in the email field
    And I enter "<password>" in the password field
    And I enter "<confirmPassword>" in the confirm password field
    And I click the Register button
    Then the user should be directed to the Confirmation Page
    And the email field should contain "<email>"
    And the password field should not be empty
    And the confirm password field should match the password
    And the confirmation message should be displayed

    Examples:
      | email                   | password  | confirmPassword |
      | test_user@example.com   | P@ssw0rd  | P@ssw0rd       |

  @feature_user_registration
  @valid-registration
  Scenario Outline: User Registration Process
    When the user navigates to "<registration_url>"
    And I enter email "<email>"
    And I enter password "<password>"
    And I enter password "<confirmPassword>"
    And the user clicks the Register button
    Then the current URL should contain "/confirmation"
    And the email field should contain "<email>"
    And the password field should not be empty
    And the confirm password field should match password
    And the confirmation message should be displayed

    Examples:
      | registration_url                  | email                        | password          | confirmPassword   |
      | https://app.example.com/register | test_user+tag@example.com | SecurePass123!   | SecurePass123!    |

  @valid-registration
  Scenario Outline: User Registration Process
    When I navigate to registration URL: "https://app.example.com/register"
    And I enter email "<email>" in email field
    And I enter password "<password>" in password field
    And I enter password "<confirmPassword>" in confirm password field
    And I click Register button
    Then the confirmation message should be displayed

    Examples:
      | email                          | password         | confirmPassword   |
      | test123_user@example.com      | SecurePass123!  | SecurePass123!    |

  @valid-registration
  Scenario Outline: User Registration Process
    Given the user is on the Registration Page
    When I enter "<email>" in the email field
    And I enter "<password>" in the password field
    And I enter "<confirmPassword>" in the confirm password field
    And I click the Register button
    Then the confirmation message should be displayed

    Examples:
      | email                   | password            | confirmPassword       |
      | Test_User@example.com   | SecurePass123!      | SecurePass123!        |

  @valid-registration
  Scenario Outline: User Registration Process
    Given the user is on the Registration Page
    When the user navigates to "<registration_url>"
    And the user enters "<email>" in the email field
    And the user enters "<password>" in the password field
    And the user enters "<confirm_password>" in the confirm password field
    And the user clicks the Register button
    Then the current URL should contain "/confirmation"
    And the email field should contain "<email>"
    And the password field should not be empty
    And the confirm password field should match the password
    And the Register button is clicked and no errors occur
    And the confirmation message is displayed

    Examples:
      | registration_url               | email                      | password          | confirm_password   |
      | https://app.example.com/register | test.user@example.com    | SecurePass123!    | SecurePass123!     |

@valid-registration
Scenario Outline: User Registration Process
  Given the user is on the Registration Page
  When the user enters "<email>" in the email field
  And the user enters "<password>" in the password field
  And the user enters "<confirmPassword>" in the confirm password field
  And the user clicks the Register button
  Then the user should be directed to the confirmation page
  And the email field should contain "<email>"
  And the password field should not be empty
  And the confirm password field should match the password
  And the confirmation message should be displayed

  Examples:
    | email                      | password           | confirmPassword      |
    | test-user@example.com      | SecurePass123!     | SecurePass123!       |

@valid-registration
Scenario Outline: User Registration Process
  When the user navigates to the registration URL "https://app.example.com/register"
  And the user enters email "<email>" in the email field
  And the user enters password "<password>" in the password field
  And the user enters password "<confirmPassword>" in the confirm password field
  And the user clicks the Register button
  Then the user should be redirected to a confirmation URL
  And the email field should contain "<email>"
  And the password field should not be empty
  And the confirm password field should match the password
  And a confirmation message should be displayed

  Examples:
    | email                     | password           | confirmPassword      |
    | test_user@example.com    | SecurePass123!     | SecurePass123!       |
