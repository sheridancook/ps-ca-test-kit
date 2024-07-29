module PSCA
  class Patient < Inferno::TestGroup
    title 'Patient (PS-CA) Tests'
    description 'Verify support for the server capabilities required by the Patient (PS-CA) profile.'
    id :psca_patient

    test do
      title 'Server returns correct Patient resource from the Patient read interaction'
      description %(
        This test will verify that Patient resources can be read from the server.
      )
      # link 'https://simplifier.net/guide/ps-ca/Home/FHIR-Artifacts/PatientPS-CA?version=1.1.0-DFT'

      input :patient_id
      makes_request :patient

      run do
        fhir_read(:patient, patient_id, name: :patient)

        assert_response_status(200)
        assert_resource_type(:patient)
        assert resource.id == patient_id,
               "Requested resource with id #{patient_id}, received resource with id #{resource.id}"
      end
    end

    test do
      title 'Server returns Patient resource that matches the Patient (PS-CA) profile'
      description %(
        This test will validate that the Patient resource returned from the server matches the Patient (PS-CA) profile.
      )
      # link 'https://simplifier.net/guide/ps-ca/Home/FHIR-Artifacts/PatientPS-CA?version=1.1.0-DFT'
      uses_request :patient

      run do
        assert_valid_resource(profile_url: 'http://fhir.infoway-inforoute.ca/io/psca/StructureDefinition/patient-ca-ps')
      end
    end
  end
end
