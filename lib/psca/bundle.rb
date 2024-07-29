module PSCA
  class Bundle < Inferno::TestGroup
    title 'Bundle (PS-CA) Tests'
    description 'Verify support for the server capabilities required by the Bundle (PS-CA) profile.'
    id :psca_bundle

    test do
      title 'Server returns correct Bundle resource from the Bundle read interaction'
      description %(
        This test will verify that Bundle resources can be read from the server.
      )
      # link 'https://simplifier.net/guide/ps-ca/Home/FHIR-Artifacts/BundlePS-CA?version=1.1.0-DFT'

      input :bundle_id
      makes_request :bundle

      run do
        fhir_read(:bundle, bundle_id, name: :bundle)

        assert_response_status(200)
        assert_resource_type(:bundle)
        assert resource.id == bundle_id,
               "Requested resource with id #{bundle_id}, received resource with id #{resource.id}"
      end
    end

    test do
      title 'Server returns Bundle resource that matches the Bundle (PS-CA) profile'
      description %(
        This test will validate that the Bundle resource returned from the server matches the Bundle (PS-CA) profile.
      )
      # link 'https://simplifier.net/guide/ps-ca/Home/FHIR-Artifacts/BundlePS-CA?version=1.1.0-DFT'
      uses_request :bundle

      run do
        assert_valid_resource(profile_url: 'http://fhir.infoway-inforoute.ca/io/psca/StructureDefinition/bundle-ca-ps')
      end
    end
  end
end
