module PSCA
  class ObservationResults < Inferno::TestGroup
    title 'Observation Results (PS-CA) Tests'
    description 'Verify support for the server capabilities required by the Observation Results (PS-CA) profile.'
    id :psca_observation_results

    input :observation_results_id

    test do
      title 'Server returns correct Observation resource from the Observation read interaction'
      description %(
        This test will verify that Observation resources can be read from the server.
      )
      # link 'https://simplifier.net/ps-ca-r1/observationresultspsca'
      makes_request :observation

      run do
        fhir_read(:observation, observation_results_id, name: :observation)

        assert_response_status(200)
        assert_resource_type(:observation)
        assert resource.id == observation_results_id,
               "Requested resource with id #{observation_results_id}, received resource with id #{resource.id}"
      end
    end

    test do
      title 'Server returns Observation resource that matches the Observation Results (PS-CA) profile'
      description %(
        This test will validate that the Observation resource returned from the server matches the Observation Results (PS-CA) profile.
      )
      # link 'https://simplifier.net/ps-ca-r1/observationresultspsca'
      uses_request :observation

      run do
        assert_valid_resource(profile_url: 'http://fhir.infoway-inforoute.ca/io/psca/StructureDefinition/observation-results-ca-ps')
      end
    end
  end
end
