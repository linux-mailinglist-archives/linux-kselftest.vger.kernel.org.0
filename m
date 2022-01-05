Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B5B4859C4
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 21:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243855AbiAEUHm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 15:07:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40390 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243847AbiAEUHk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 15:07:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C527B81D5C;
        Wed,  5 Jan 2022 20:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80935C36AE0;
        Wed,  5 Jan 2022 20:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641413258;
        bh=li3QLwxVn9lTYMyu8AVDi89PvVj8yPmgWVVq8l2imWA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DlFSqTNrf4gavWiRw6K9Bj6HH2uPFH4c1DsD9UFYT7gLt8PWAfqZXX264JX6XyMBl
         0Bno5kLWg62V26nhWJm5Khi2rSNFzGx9cAfiEwjCj4hX7dv1CATRgYelTDhbrGX/TI
         IYt0/a5InOFxnwVkYMOzcB/QiW4svWYWslCzN0wXHfmHkWLW4JUndULgcUgEVvzKQP
         c3+qeFJhLjEmY9hUmWiX+UIQZjKyWbcRllxGOA9McrKYtoxbE7IqpYyVAsXKcE+8Hz
         oV31hVbrJDddCx9nxgHmSBBUoQeHcNfwCnfdDKWsDN8IAdjZH0eHFMej5gAsjOkRAE
         Gm4Td5L4dYTPA==
Message-ID: <02122eeb569342b1083e8058afe04733a99617e2.camel@kernel.org>
Subject: Re: [PATCH 2/2] selftests: tpm: add async space test with
 noneexisting handle
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tadeusz Struk <tstruk@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-integrity@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Jan 2022 22:07:32 +0200
In-Reply-To: <20211229050655.2030-2-tstruk@gmail.com>
References: <20211229050655.2030-1-tstruk@gmail.com>
         <20211229050655.2030-2-tstruk@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2021-12-28 at 21:06 -0800, Tadeusz Struk wrote:
> Add a test for tpm2 spaces in async mode that checks if
                 ~~~~
I would rather speak about adding a test case for /dev/tpmrm0.

> the code handles invalid handles correctly.
>=20
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: <linux-integrity@vger.kernel.org>
> Cc: <linux-kselftest@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> Signed-off-by: Tadeusz Struk <tstruk@gmail.com>
> ---
> =C2=A0tools/testing/selftests/tpm2/tpm2_tests.py | 16 ++++++++++++++++
> =C2=A01 file changed, 16 insertions(+)
>=20
> diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py
> b/tools/testing/selftests/tpm2/tpm2_tests.py
> index 9d764306887b..b373b0936e40 100644
> --- a/tools/testing/selftests/tpm2/tpm2_tests.py
> +++ b/tools/testing/selftests/tpm2/tpm2_tests.py
> @@ -302,3 +302,19 @@ class AsyncTest(unittest.TestCase):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log.debug("Calling get_c=
ap in a NON_BLOCKING mode")
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 async_client.get_cap(tpm=
2.TPM2_CAP_HANDLES,
> tpm2.HR_LOADED_SESSION)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 async_client.close()
> +
> +=C2=A0=C2=A0=C2=A0 def test_flush_invlid_context(self):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log =3D logging.getLogger(__n=
ame__)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log.debug(sys._getframe().f_c=
ode.co_name)
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 async_client =3D tpm2.Client(=
tpm2.Client.FLAG_SPACE |
> tpm2.Client.FLAG_NONBLOCK)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log.debug("Calling flush_cont=
ext passing in an invalid
> handle ")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 handle =3D 0x80123456
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D 0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 async=
_client.flush_context(handle)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except OSError as e:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =
=3D e.errno
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(rc, 22)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 async_client.close()

BR,
Jarkko
