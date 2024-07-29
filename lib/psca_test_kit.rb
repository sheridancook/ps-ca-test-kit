Dir.glob(File.join(__dir__, 'ips', '*.rb')).each { |path| require_relative path.delete_prefix("#{__dir__}/") }
require_relative 'psca/version'

module PSCA
  class Suite < Inferno::TestSuite
    title 'Pan-Canadian Patient Summary (PS-CA) v1.1.0 DFT'
    short_title 'PS-CA v1.1.0 DFT'
    description %(
      This test suite evaluates the ability of a system to provide patient
      summary data expressed using HL7® FHIR® in accordance with the
      [Pan-Canadian Patient Summary (PS-CA
      IG) v1.1.0 DFT](https://simplifier.net/guide/ps-ca?version=1.1.0-DFT).  

      Because PS-CA bundles can be generated and transmitted in many different
      ways beyond a traditional FHIR RESTful server, this test suite allows you
      to optionally evaluate a single bundle that is not being provided by a server in the
      'PS-CA Resource Validation Tests'.

      For systems that support a standard API for generating and communicating
      these bundles in accordance with the guidance provided in the IG, use the
      'PS-CA Operation Tests'.

      For systems that also provide a FHIR API access to the components resources
      of the PS bundle, use the 'PS-CA Read Tests'.

      This suite provides two presets:
      * HL7.org IPS Server: Hosted reference IPS Server.  This is suitable for running
        the 'Operation' and 'Read' tests.  Resource IDs may not remain valid as this is an
        open server.
      * IPS Example Summary Bundle: Populates the 'IPS Resource Validation Test' with an
        example provided in the IG. 
    )

    id 'psca'
    version PSCA::VERSION

    VALIDATION_MESSAGE_FILTERS = [
      /\A\S+: \S+: URL value '.*' does not resolve/
    ].freeze

    fhir_resource_validator do
      igs 'ca.infoway.io.psca 1.1.0'

      exclude_message do |message|
        VALIDATION_MESSAGE_FILTERS.any? { |filter| filter.match? message.message }
      end
    end

    links [
      {
        label: 'Report Issue',
        url: 'https://informs.infoway-inforoute.ca/projects/PS/issues/'
      },
      {
        label: 'Open Source',
        url: 'https://github.com/AccessDigitalHealth/inferno-framework/psca-test-kit/'
      },
      {
        label: 'Pan-Canadian Patient Summary (PS-CA IG) v1.1.0 DFT',
        url: 'https://simplifier.net/guide/ps-ca?version=1.1.0-DFT'
      }
    ]
    
    # Comment this out to remove
    #group from: :psca_resource_validation

    group do
      title 'PS-CA Server Operations for Generating PS-CA Bundles Tests'
      short_title 'PS-CA Operation Tests'
      description %(
        This group evaluates the ability of systems to provide a standard FHIR
        API for generating and communicating a PS-CA Bundle as described in the
        [IPS Data Generation and Inclusion Guidance](http://hl7.org/fhir/uv/ips/STU1.1/ipsGeneration.html).

        Please note that the DocRef tests are currently of limited scope.
      )


      input :url, title: 'PS-CA FHIR Server Base URL'

      fhir_client do
        url :url
      end

      group from: :psca_summary_operation
      group from: :psca_docref_operation
    end

    group do
      title 'PS-CA Server Read and Validate Profiles Tests'
      short_title 'PS-CA Read Tests'
      optional

      input :url, title: 'PS-CA FHIR Server Base URL'

      fhir_client do
        url :url
      end

      group from: :psca_allergy_intolerance
      group from: :psca_bundle     
      group from: :psca_condition
      group from: :psca_composition     
      group from: :psca_medication_statement
      group  do
        title 'Observation Profiles'

        group from: :psca_observation_alcohol_use
      end
      group do
        title 'Observation Result Profiles'

        group from: :psca_observation_results
      end
      group from: :psca_patient
    end
  end
end
