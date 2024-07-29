module PSCA
  class AllergyIntolerance < Inferno::TestGroup
    title 'Allergy Intolerance (PS-CA) Tests'
    description 'Verify support for the server capabilities required by the Allergy Intolerance (PS-CA) profile.'
    id :psca_allergy_intolerance

    test do
      title 'Server returns correct AllergyIntolerance resource from the AllergyIntolerance read interaction'
      description %(
        This test will verify that AllergyIntolerance resources can be read from the server.
      )
      # link 'https://simplifier.net/guide/ps-ca/Home/FHIR-Artifacts/AllergyIntolerancePS-CA?version=1.1.0-DFT'

      input :allergy_intolerance_id
      makes_request :allergy_intolerance

      run do
        fhir_read(:allergy_intolerance, allergy_intolerance_id, name: :allergy_intolerance)

        assert_response_status(200)
        assert_resource_type(:allergy_intolerance)
        assert resource.id == allergy_intolerance_id,
               "Requested resource with id #{allergy_intolerance_id}, received resource with id #{resource.id}"
      end
    end

    test do
      title 'Server returns AllergyIntolerance resource that matches the Allergy Intolerance (PS-CA) profile'
      description %(
        This test will validate that the AllergyIntolerance resource returned from the server matches the Allergy Intolerance (PS-CA) profile.
      )
      # link 'https://simplifier.net/guide/ps-ca/Home/FHIR-Artifacts/AllergyIntolerancePS-CA?version=1.1.0-DFT'
      uses_request :allergy_intolerance

      run do
        assert_valid_resource(profile_url: 'http://fhir.infoway-inforoute.ca/io/psca/StructureDefinition/allergyintolerance-ca-ps')
      end
    end
  end
end
