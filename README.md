# Inferno PS-CA Test Kit

The Inferno Pan-Canadian Patient Summary Test Kit provides an
executable set of tests for the [Pan-Canadian Patient Summary (PS-CA)
Implementation Guide](https://simplifier.net/guide/ps-ca?version=current).  This test kit
is designed and maintained by the Infoway to support the development of the
PS-CA IG.

This test kit includes a web interface to run a configured local [HL7® FHIR®
validator](https://confluence.hl7.org/display/FHIR/Using+the+FHIR+Validator)
service to validate instances of FHIR resources to the PS-CA profiles, as well as
a preliminary test suite.

## Instructions

It is highly recommended that you use [Docker](https://www.docker.com/) to run
these tests.  This test kit requires at least 10 GB of memory are available to Docker.

- Clone this repo.
- Run `setup.sh` in this repo.
- Run `run.sh` in this repo.
- Navigate to `http://localhost`. The IPS Test suite will be available.

See the [Inferno Framework
Documentation](https://inferno-framework.github.io/docs/getting-started-users.html)
for more information on running Inferno.

## License

Licensed under the Apache License, Version 2.0 (the "License"); you may not use
this file except in compliance with the License. You may obtain a copy of the
License at
```
http://www.apache.org/licenses/LICENSE-2.0
```
Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either express or implied. See the License for the
specific language governing permissions and limitations under the License.

## Trademark Notice

HL7, FHIR and the FHIR [FLAME DESIGN] are the registered trademarks of Health
Level Seven International and their use does not constitute endorsement by HL7.
