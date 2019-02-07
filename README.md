# About

This is a simple wrapper container for [the official Vault Docker image](https://hub.docker.com/_/vault).  This wrapper will GET a single URL (based on wget),
 and is intended to be used in conjunction with [the Authy/KMS unseal workflow](https://www.linkedin.com/pulse/simplifying-vault-push-based-unsealing-issac-goldstand/).

## How to use

`docker run -e VAULT_UNSEAL_URL=https://somedomain.com/start ...normal vault docker commands...`

When a value is supplied for the VAULT_UNSEAL_URL environment variable, a call to wget will be made to that value immediately before starting Vault.  This is intended to be the caller script used to trigger the Authy confirmation [case on the sample code in this Gist](https://gist.github.com/issacg/ea661c6652d00191d1d6f08fc9b38b60)

## Rationale
 The advantages of the Authy/KMS workflow to the [built-in KMS unseal](https://www.vaultproject.io/docs/configuration/seal/awskms.html) introduced in free Vault 1.0 are:

 1. There is some confirmation to signal to an operator that there has been an attempt to unseal.  This allows an operator to quickly detect a red flag when there are more unseal requests than would be expected.  I see this as a compramise between convenience of auto-unseal and the oversight given by manual unseal
 2. The built-in KMS unseal requires AWS permissions to the Vault instance.  While this is easily solved where a machine-based role is available (for example inside EC2), the Authy/KMS workflow works just as well, and just as secure, even when the Vault instance is hosted outside of the AWS cloud

The wget call is made before starting vault, rather than after (which would make more sense) to [KISS](https://en.wikipedia.org/wiki/KISS_principle).  It's just easier, and the Unseal operation will only happen after the Authy request is approved, which (presumably) will take mre time to process than the Vault startup itself.  If you disagree, patches are welcome :)

 ## License
 Copyright 2019 Issac Goldstand

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.