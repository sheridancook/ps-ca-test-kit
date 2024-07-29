module PSCA
  class Condition < Inferno::TestGroup
    title 'Condition (PS-CA) Tests'
    description 'Verify support for the server capabilities required by the Condition (PS-CA) profile.'
    id :psca_condition

    test do
      title 'Server returns correct Condition resource from the Condition read interaction'
      description %(
        This test will verify that Condition resources can be read from the server.
      )
      # link 'https://simplifier.net/guide/ps-ca/Home/FHIR-Artifacts/ConditionPS-CA?version=1.1.0-DFT'

      input :condition_id
      makes_request :condition

      run do
        fhir_read(:condition, condition_id, name: :condition)

        assert_response_status(200)
        assert_resource_type(:condition)
        assert resource.id == condition_id,
               "Requested resource with id #{condition_id}, received resource with id #{resource.id}"
      end
    end

    test do
      title 'Server returns Condition resource that matches the Condition (PS-CA) profile'
      description %(
        This test will validate that the Condition resource returned from the server matches the Condition (PS-CA) profile.
      )
      # link 'https://simplifier.net/guide/ps-ca/Home/FHIR-Artifacts/ConditionPS-CA?version=1.1.0-DFT'
      uses_request :condition

      run do
        assert_valid_resource(profile_url: 'http://fhir.infoway-inforoute.ca/io/psca/StructureDefinition/condition-ca-ps')
      end
    end
  end
end
