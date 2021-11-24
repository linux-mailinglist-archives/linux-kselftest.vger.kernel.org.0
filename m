Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4F645D167
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Nov 2021 00:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbhKXX5z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 18:57:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:48946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236890AbhKXX5z (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 18:57:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A0E761039;
        Wed, 24 Nov 2021 23:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637798085;
        bh=ZZiBkfeRF6d5nKEh6At4F30WYpDHpX8KwYXyNUcaaqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=klYJBVoHGlHtDRlNehYQp9FUaUeyBiL6JsecJz1zwPl/1BJOMdwER0j/esqgHuZc/
         N2e6Hb/Vg56ZiTPmz+bSKWSICeUJCqhO2oHhUyjkZ9Fr7/XH576HULx+BW3qdBI6HN
         RDk0l3ZUdFUifBrOjSFJyEAoplAHVqHMO3cAv70hJtvEKdrX97oAPdxw4yfsoISiKx
         DcYIkIYFqDzgZnj8mLlqEX1dzIb6xv9xJcEh45xTkUsVxY8ARUQ7TD6uQTSHX5YoWS
         kwDWBdbXLoqTfcGPD7DL7LuMyMDmqa9rU0T+cXMTWhZux+DjdF7zFBAZSRBNmyAKhe
         oYxtrtYeCXkmQ==
Date:   Thu, 25 Nov 2021 01:54:42 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH v2 1/3] selftests: tpm2: Probe for available PCR bank
Message-ID: <YZ7QwlZ77b4A/ZbR@iki.fi>
References: <20211124141314.1356338-1-stefanb@linux.ibm.com>
 <20211124141314.1356338-2-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124141314.1356338-2-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 24, 2021 at 09:13:12AM -0500, Stefan Berger wrote:
> Probe for an available PCR bank to accommodate devices that do not have a
> SHA-1 PCR bank or whose SHA-1 bank is deactivated. Use the bank that can
> be used in the TPM2 commands. Assert on the probing function to not
> return None.

What is *the bank* that can be used?

In addition, I don't understand the last sentence.

/Jarkko


> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  tools/testing/selftests/tpm2/tpm2_tests.py | 35 +++++++++++++++++-----
>  1 file changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
> index 9d764306887b..6b88ff0e47b9 100644
> --- a/tools/testing/selftests/tpm2/tpm2_tests.py
> +++ b/tools/testing/selftests/tpm2/tpm2_tests.py
> @@ -27,7 +27,23 @@ class SmokeTest(unittest.TestCase):
>          result = self.client.unseal(self.root_key, blob, auth, None)
>          self.assertEqual(data, result)
>  
> +    def determine_bank_alg(self):
> +        # Probe for available PCR bank
> +        for bank_alg in [tpm2.TPM2_ALG_SHA1, tpm2.TPM2_ALG_SHA256]:
> +            try:
> +                handle = self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
> +                self.client.policy_pcr(handle, [17], bank_alg=bank_alg)
> +                return bank_alg
> +            except tpm2.UnknownPCRBankError:
> +                pass
> +            finally:
> +                self.client.flush_context(handle)
> +        return None
> +
>      def test_seal_with_policy(self):
> +        bank_alg = self.determine_bank_alg()
> +        self.assertIsNotNone(bank_alg)
> +
>          handle = self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
>  
>          data = ('X' * 64).encode()
> @@ -35,7 +51,7 @@ class SmokeTest(unittest.TestCase):
>          pcrs = [16]
>  
>          try:
> -            self.client.policy_pcr(handle, pcrs)
> +            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
>              self.client.policy_password(handle)
>  
>              policy_dig = self.client.get_policy_digest(handle)
> @@ -47,7 +63,7 @@ class SmokeTest(unittest.TestCase):
>          handle = self.client.start_auth_session(tpm2.TPM2_SE_POLICY)
>  
>          try:
> -            self.client.policy_pcr(handle, pcrs)
> +            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
>              self.client.policy_password(handle)
>  
>              result = self.client.unseal(self.root_key, blob, auth, handle)
> @@ -72,6 +88,9 @@ class SmokeTest(unittest.TestCase):
>          self.assertEqual(rc, tpm2.TPM2_RC_AUTH_FAIL)
>  
>      def test_unseal_with_wrong_policy(self):
> +        bank_alg = self.determine_bank_alg()
> +        self.assertIsNotNone(bank_alg)
> +
>          handle = self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
>  
>          data = ('X' * 64).encode()
> @@ -79,7 +98,7 @@ class SmokeTest(unittest.TestCase):
>          pcrs = [16]
>  
>          try:
> -            self.client.policy_pcr(handle, pcrs)
> +            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
>              self.client.policy_password(handle)
>  
>              policy_dig = self.client.get_policy_digest(handle)
> @@ -91,13 +110,13 @@ class SmokeTest(unittest.TestCase):
>          # Extend first a PCR that is not part of the policy and try to unseal.
>          # This should succeed.
>  
> -        ds = tpm2.get_digest_size(tpm2.TPM2_ALG_SHA1)
> -        self.client.extend_pcr(1, ('X' * ds).encode())
> +        ds = tpm2.get_digest_size(bank_alg)
> +        self.client.extend_pcr(1, ('X' * ds).encode(), bank_alg=bank_alg)
>  
>          handle = self.client.start_auth_session(tpm2.TPM2_SE_POLICY)
>  
>          try:
> -            self.client.policy_pcr(handle, pcrs)
> +            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
>              self.client.policy_password(handle)
>  
>              result = self.client.unseal(self.root_key, blob, auth, handle)
> @@ -109,14 +128,14 @@ class SmokeTest(unittest.TestCase):
>  
>          # Then, extend a PCR that is part of the policy and try to unseal.
>          # This should fail.
> -        self.client.extend_pcr(16, ('X' * ds).encode())
> +        self.client.extend_pcr(16, ('X' * ds).encode(), bank_alg=bank_alg)
>  
>          handle = self.client.start_auth_session(tpm2.TPM2_SE_POLICY)
>  
>          rc = 0
>  
>          try:
> -            self.client.policy_pcr(handle, pcrs)
> +            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
>              self.client.policy_password(handle)
>  
>              result = self.client.unseal(self.root_key, blob, auth, handle)
> -- 
> 2.31.1
> 
