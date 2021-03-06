require_relative '../test_helper'
require_relative '../test_payloads'

class ClientGetsErrorWithNoUrlTest < FeatureTest
  include TestHelpers
  include TestPayloads

  def test_
    page.driver.browser.post('/sources?identifier=testlab&rootUrl=http://jumpstartlab.com')
    create_15_payloads

    visit '/sources/testlab/urls/nottest'

    assert page.has_content? "Url (http://jumpstartlab.com/nottest) has not been requested."
  end
end
