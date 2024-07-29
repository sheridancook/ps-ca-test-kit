module PSCA
  class MedicationStatement < Inferno::TestGroup
    title 'Medication Statement (PS-CA) Tests'
    description 'Verify support for the server capabilities required by the Medication Statement (PS-CA) profile.'
    id :psca_medication_statement

    input :medication_statement_id

    test do
      title 'Server returns correct MedicationStatement resource from the MedicationStatement read interaction'
      description %(
        This test will verify that MedicationStatement resources can be read from the server.
      )
      # link 'https://simplifier.net/guide/ps-ca/Home/FHIR-Artifacts/MedicationStatementPS-CA?version=1.1.0-DFT'
      makes_request :medication_statement

      run do
        fhir_read(:medication_statement, medication_statement_id, name: :medication_statement)

        assert_response_status(200)
        assert_resource_type(:medication_statement)
        assert resource.id == medication_statement_id,
               "Requested resource with id #{medication_statement_id}, received resource with id #{resource.id}"
      end
    end

    test do
      title 'Server returns MedicationStatement resource that matches the Medication Statement (PS-CA) profile'
      description %(
        This test will validate that the MedicationStatement resource returned from the server matches the Medication Statement (PS-CA) profile.
      )
      # link 'https://simplifier.net/guide/ps-ca/Home/FHIR-Artifacts/MedicationStatementPS-CA?version=1.1.0-DFT'
      uses_request :medication_statement

      run do
        assert_valid_resource(profile_url: 'http://fhir.infoway-inforoute.ca/io/psca/StructureDefinition/medicationstatement-ca-ps')
      end
    end
  end
end
