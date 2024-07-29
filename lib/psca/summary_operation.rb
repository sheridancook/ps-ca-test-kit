module PSCA
  class SummaryOperation < Inferno::TestGroup
    title 'Summary Operation Tests'
    description %(
        Verify support for the $summary operation as as described in the [IPS
        Guidance](http://hl7.org/fhir/uv/ips/STU1.1/ipsGeneration.html).
    )
    id :psca_summary_operation
    run_as_group

    test do
      title 'Server declares support for $summary operation in CapabilityStatement'
      description %(
        The Server declares support for Patient/[id]/$summary operation in its server CapabilityStatement
      )

      run do
        fhir_get_capability_statement
        assert_response_status(200)

        operations = resource.rest&.flat_map do |rest|
          rest.resource
            &.select { |r| r.type == 'Patient' && r.respond_to?(:operation) }
            &.flat_map(&:operation)
        end&.compact

        operation_defined = operations.any? do |operation|
          operation.definition == 'http://hl7.org/fhir/uv/ips/OperationDefinition/summary' ||
            ['summary', 'patient-summary'].include?(operation.name.downcase)
        end

        assert operation_defined, 'Server CapabilityStatement did not declare support for $summary operation in Patient resource.'
      end
    end

    test do
      title 'Server returns Bundle resource for Patient/[id]/$summary GET operation'
      description %(
        Server returns a valid PS-CA Bundle resource as successful result of
        $summary operation.

        This test currently only issues a GET request for the summary due to a
        limitation in Inferno in issuing POST requests that omit a Content-Type
        header when the body is empty. Inferno currently adds a `Content-Type:
        application/x-www-form-urlencoded` header when issuing a POST with no
        body, which causes issues in known reference implementations.

        A future update to this test suite should include a required POST
        request as well as an optional GET request for this content.
      )

      input :patient_id
      makes_request :summary_operation

      run do
        fhir_operation("Patient/#{patient_id}/$summary", name: :summary_operation, operation_method: :get)
        assert_response_status(200)
        assert_resource_type(:bundle)
        assert_valid_resource(profile_url: 'http://fhir.infoway-inforoute.ca/io/psca/StructureDefinition/bundle-ca-ps')
      end
    end

    test do
      title 'Server returns Bundle resource containing valid PS-CA Composition entry'
      description %(
        Server return valid PS-CA Composition resource in the Bundle as first entry
      )
      # link 'https://simplifier.net/guide/ps-ca/Home/FHIR-Artifacts/CompositionPS-CA?version=1.1.0-DFT'
      uses_request :summary_operation

      run do
        skip_if !resource.is_a?(FHIR::Bundle), 'No Bundle returned from document operation'

        assert resource.entry.length.positive?, 'Bundle has no entries'

        first_resource = resource.entry.first.resource

        assert first_resource.is_a?(FHIR::Composition), 'The first entry in the Bundle is not a Composition'
        assert_valid_resource(resource: first_resource, profile_url: 'http://fhir.infoway-inforoute.ca/io/psca/StructureDefinition/composition-ca-ps')
      end
    end

    test do
      title 'Server returns Bundle resource containing valid PS-CA MedicationStatement entry'
      description %(
        Server return valid PS-CA MedicationStatement resource in the Bundle as first entry
      )
      # link 'https://simplifier.net/guide/ps-ca/Home/FHIR-Artifacts/MedicationStatementPS-CA?version=1.1.0-DFT'
      uses_request :summary_operation

      run do
        skip_if !resource.is_a?(FHIR::Bundle), 'No Bundle returned from document operation'

        resources_present = resource.entry.any? { |r| r.resource.is_a?(FHIR::MedicationStatement) }

        assert resources_present, 'Bundle does not contain any MedicationStatement resources'

        assert_valid_bundle_entries(
          resource_types: {
            medication_statement: 'http://fhir.infoway-inforoute.ca/io/psca/StructureDefinition/medicationstatement-ca-ps'
          }
        )
      end
    end

    test do
      title 'Server returns Bundle resource containing valid PS-CA AllergyIntolerance entry'
      description %(
        Server return valid PS-CA AllergyIntolerance resource in the Bundle as first entry
      )
      # link 'https://simplifier.net/guide/ps-ca/Home/FHIR-Artifacts/AllergyIntolerancePS-CA?version=1.1.0-DFT'
      uses_request :summary_operation

      run do
        skip_if !resource.is_a?(FHIR::Bundle), 'No Bundle returned from document operation'

        resources_present = resource.entry.any? { |r| r.resource.is_a?(FHIR::AllergyIntolerance) }

        assert resources_present, 'Bundle does not contain any AllergyIntolerance resources'

        assert_valid_bundle_entries(
          resource_types: {
            allergy_intolerance: 'http://fhir.infoway-inforoute.ca/io/psca/StructureDefinition/allergyintolerance-ca-ps'
          }
        )
      end
    end

    test do
      title 'Server returns Bundle resource containing valid PS-CA Condition entry'
      description %(
        Server return valid PS-CA Condition resource in the Bundle as first entry
      )
      # link 'https://simplifier.net/guide/ps-ca/Home/FHIR-Artifacts/ConditionPS-CA?version=1.1.0-DFT'
      uses_request :summary_operation

      run do
        skip_if !resource.is_a?(FHIR::Bundle), 'No Bundle returned from document operation'

        resources_present = resource.entry.any? { |r| r.resource.is_a?(FHIR::Condition) }

        assert resources_present, 'Bundle does not contain any Condition resources'

        assert_valid_bundle_entries(
          resource_types: {
            condition: 'http://fhir.infoway-inforoute.ca/io/psca/StructureDefinition/condition-ca-ps'
          }
        )
      end
    end
  end
end
