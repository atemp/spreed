Feature: set-description
  Background:
    Given user "owner" exists
    Given user "moderator" exists
    Given user "invited user" exists
    Given user "not invited but joined user" exists
    Given user "not joined user" exists

  Scenario: owner can not set description in one-to-one room
    Given user "owner" creates room "one-to-one room"
      | roomType | 1 |
      | invite   | moderator |
    When user "owner" sets description for room "one-to-one room" to "the description" with 400
    And user "moderator" sets description for room "one-to-one room" to "the description" with 400
    Then user "owner" is participant of room "one-to-one room" (v3)
      | description |
      |             |
    And user "moderator" is participant of room "one-to-one room" (v3)
      | description |
      |             |



  Scenario: owner can set description in group room
    Given user "owner" creates room "group room"
      | roomType | 2 |
      | roomName | room |
    And user "owner" adds "moderator" to room "group room" with 200
    And user "owner" promotes "moderator" in room "group room" with 200
    And user "owner" adds "invited user" to room "group room" with 200
    When user "owner" sets description for room "group room" to "the description" with 200
    Then user "owner" is participant of room "group room" (v3)
      | description     |
      | the description |
    And user "moderator" is participant of room "group room" (v3)
      | description     |
      | the description |
    And user "invited user" is participant of room "group room" (v3)
      | description     |
      | the description |

  Scenario: moderator can set description in group room
    Given user "owner" creates room "group room"
      | roomType | 2 |
      | roomName | room |
    And user "owner" adds "moderator" to room "group room" with 200
    And user "owner" promotes "moderator" in room "group room" with 200
    And user "owner" adds "invited user" to room "group room" with 200
    When user "moderator" sets description for room "group room" to "the description" with 200
    Then user "owner" is participant of room "group room" (v3)
      | description     |
      | the description |
    And user "moderator" is participant of room "group room" (v3)
      | description     |
      | the description |
    And user "invited user" is participant of room "group room" (v3)
      | description     |
      | the description |

  Scenario: others can not set description in group room
    Given user "owner" creates room "group room"
      | roomType | 2 |
      | roomName | room |
    And user "owner" adds "moderator" to room "group room" with 200
    And user "owner" promotes "moderator" in room "group room" with 200
    And user "owner" adds "invited user" to room "group room" with 200
    And user "owner" sets description for room "group room" to "the description" with 200
    When user "invited user" sets description for room "group room" to "invited user description" with 403
    And user "not invited user" sets description for room "group room" to "not invited user description" with 404
    # Guest user names in tests must being with "guest"
    And user "guest not joined" sets description for room "group room" to "guest not joined description" with 404
    Then user "owner" is participant of room "group room" (v3)
      | description     |
      | the description |
    And user "moderator" is participant of room "group room" (v3)
      | description     |
      | the description |
    And user "invited user" is participant of room "group room" (v3)
      | description     |
      | the description |



  Scenario: owner can set description in public room
    Given user "owner" creates room "public room"
      | roomType | 3 |
      | roomName | room |
    And user "owner" adds "moderator" to room "public room" with 200
    And user "owner" promotes "moderator" in room "public room" with 200
    And user "owner" adds "invited user" to room "public room" with 200
    And user "not invited but joined user" joins room "public room" with 200
    And user "guest moderator" joins room "public room" with 200
    And user "owner" promotes "guest moderator" in room "public room" with 200
    And user "guest" joins room "public room" with 200
    When user "owner" sets description for room "public room" to "the description" with 200
    Then user "owner" is participant of room "public room" (v3)
      | description     |
      | the description |
    And user "moderator" is participant of room "public room" (v3)
      | description     |
      | the description |
    And user "invited user" is participant of room "public room" (v3)
      | description     |
      | the description |
    And user "not invited but joined user" is participant of room "public room" (v3)
      | description     |
      | the description |
    And user "guest moderator" is participant of room "public room" (v3)
      | description     |
      | the description |
    And user "guest" is participant of room "public room" (v3)
      | description     |
      | the description |

  Scenario: moderator can set description in public room
    Given user "owner" creates room "public room"
      | roomType | 3 |
      | roomName | room |
    And user "owner" adds "moderator" to room "public room" with 200
    And user "owner" promotes "moderator" in room "public room" with 200
    And user "owner" adds "invited user" to room "public room" with 200
    And user "not invited but joined user" joins room "public room" with 200
    And user "guest moderator" joins room "public room" with 200
    And user "owner" promotes "guest moderator" in room "public room" with 200
    And user "guest" joins room "public room" with 200
    When user "moderator" sets description for room "public room" to "the description" with 200
    Then user "owner" is participant of room "public room" (v3)
      | description     |
      | the description |
    And user "moderator" is participant of room "public room" (v3)
      | description     |
      | the description |
    And user "invited user" is participant of room "public room" (v3)
      | description     |
      | the description |
    And user "not invited but joined user" is participant of room "public room" (v3)
      | description     |
      | the description |
    And user "guest moderator" is participant of room "public room" (v3)
      | description     |
      | the description |
    And user "guest" is participant of room "public room" (v3)
      | description     |
      | the description |

  Scenario: guest moderator can set description in public room
    Given user "owner" creates room "public room"
      | roomType | 3 |
      | roomName | room |
    And user "owner" adds "moderator" to room "public room" with 200
    And user "owner" promotes "moderator" in room "public room" with 200
    And user "owner" adds "invited user" to room "public room" with 200
    And user "not invited but joined user" joins room "public room" with 200
    And user "guest moderator" joins room "public room" with 200
    And user "owner" promotes "guest moderator" in room "public room" with 200
    And user "guest" joins room "public room" with 200
    When user "guest moderator" sets description for room "public room" to "the description" with 200
    Then user "owner" is participant of room "public room" (v3)
      | description     |
      | the description |
    And user "moderator" is participant of room "public room" (v3)
      | description     |
      | the description |
    And user "invited user" is participant of room "public room" (v3)
      | description     |
      | the description |
    And user "not invited but joined user" is participant of room "public room" (v3)
      | description     |
      | the description |
    And user "guest moderator" is participant of room "public room" (v3)
      | description     |
      | the description |
    And user "guest" is participant of room "public room" (v3)
      | description     |
      | the description |

  Scenario: others can not set description in public room
    Given user "owner" creates room "public room"
      | roomType | 3 |
      | roomName | room |
    And user "owner" adds "moderator" to room "public room" with 200
    And user "owner" promotes "moderator" in room "public room" with 200
    And user "owner" adds "invited user" to room "public room" with 200
    And user "not invited but joined user" joins room "public room" with 200
    And user "guest moderator" joins room "public room" with 200
    And user "owner" promotes "guest moderator" in room "public room" with 200
    And user "guest" joins room "public room" with 200
    And user "owner" sets description for room "public room" to "the description" with 200
    When user "invited user" sets description for room "public room" to "invited user description" with 403
    And user "not invited but joined user" sets description for room "public room" to "not invited but joined description" with 403
    And user "not joined user" sets description for room "public room" to "not joined user description" with 404
    And user "guest" sets description for room "public room" to "guest description" with 403
    # Guest user names in tests must being with "guest"
    And user "guest not joined" sets description for room "public room" to "guest not joined description" with 404
    Then user "owner" is participant of room "public room" (v3)
      | description     |
      | the description |
    And user "moderator" is participant of room "public room" (v3)
      | description     |
      | the description |
    And user "invited user" is participant of room "public room" (v3)
      | description     |
      | the description |
    And user "not invited but joined user" is participant of room "public room" (v3)
      | description     |
      | the description |
    And user "guest moderator" is participant of room "public room" (v3)
      | description     |
      | the description |
    And user "guest" is participant of room "public room" (v3)
      | description     |
      | the description |



  Scenario: room list returns the hashed description if the description is set
    Given user "owner" creates room "public room"
      | roomType | 3 |
      | roomName | room |
    And user "owner" adds "moderator" to room "public room" with 200
    And user "owner" promotes "moderator" in room "public room" with 200
    And user "owner" adds "invited user" to room "public room" with 200
    And user "not invited but joined user" joins room "public room" with 200
    When user "owner" sets description for room "public room" to "the description" with 200
    Then user "owner" is participant of the following rooms (v3)
      | name | description     |
      | room | dc90bdf167b8d5598ac2ac3812aa71e34de10ce2 |
    And user "moderator" is participant of the following rooms (v3)
      | name | description     |
      | room | dc90bdf167b8d5598ac2ac3812aa71e34de10ce2 |
    And user "invited user" is participant of the following rooms (v3)
      | name | description     |
      | room | dc90bdf167b8d5598ac2ac3812aa71e34de10ce2 |
    And user "not invited but joined user" is participant of the following rooms (v3)
      | name | description     |
      | room | dc90bdf167b8d5598ac2ac3812aa71e34de10ce2 |

  Scenario: room list returns an empty value if the description is not set
    Given user "owner" creates room "public room"
      | roomType | 3 |
      | roomName | room |
    And user "owner" adds "moderator" to room "public room" with 200
    And user "owner" promotes "moderator" in room "public room" with 200
    And user "owner" adds "invited user" to room "public room" with 200
    And user "not invited but joined user" joins room "public room" with 200
    When user "owner" sets description for room "public room" to "" with 200
    Then user "owner" is participant of the following rooms (v3)
      | name | description |
      | room |             |
    And user "moderator" is participant of the following rooms (v3)
      | name | description |
      | room |             |
    And user "invited user" is participant of the following rooms (v3)
      | name | description |
      | room |             |
    And user "not invited but joined user" is participant of the following rooms (v3)
      | name | description |
      | room |             |
