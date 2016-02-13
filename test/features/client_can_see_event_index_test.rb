require_relative '../test_helper'
require_relative '../test_payloads'

class ClientCanSeeEventIndexTest < FeatureTest
  include TestHelpers
  include TestPayloads

  def test_event_index
    page.driver.browser.post('/sources?identifier=jumpstartlab&rootUrl=http://jumpstartlab.com')

    PayloadRequest.create(payload_one)
    PayloadRequest.create(payload_two)
    PayloadRequest.create(payload_three)

    visit '/jumpstartlab/events'
    assert page.has_content? "socialLogin"
    assert page.has_content? "anotherEvent"
    assert page.has_content? "yetAnother"
  end
end
