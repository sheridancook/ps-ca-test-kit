module PSCA
  class Composition < Inferno::TestGroup
    title 'Composition (IPS) Tests'
    description 'Verify support for the server capabilities required by the Composition (PS-CA) profile.'
    id :psca_composition

    test do
      title 'Server returns correct Composition resource from the Composition read interaction'
      description %(
        This test will verify that Composition resources can be read from the server.
      )
      # link 'https://simplifier.net/guide/ps-ca/Home/FHIR-Artifacts/CompositionPS-CA?version=1.1.0-DFT'

      input :composition_id
      makes_request :composition

      run do
        fhir_read(:composition, composition_id, name: :composition)

        assert_response_status(200)
        assert_resource_type(:composition)
        assert resource.id == composition_id,
               "Requested resource with id #{composition_id}, received resource with id #{resource.id}"
      end
    end

    test do
      title 'Server returns Composition resource that matches the Composition (PS-CA) profile'
      description %(
        This test will validate that the Composition resource returned from the server matches the Composition (PS-CA) profile.
      )
      # link 'https://simplifier.net/guide/ps-ca/Home/FHIR-Artifacts/CompositionPS-CA?version=1.1.0-DFT'
      uses_request :composition

      run do
        assert_valid_resource(profile_url: 'http://fhir.infoway-inforoute.ca/io/psca/StructureDefinition/composition-ca-ps')
      end
    end

  end
end
