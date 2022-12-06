Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E27644D66
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Dec 2022 21:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiLFUmc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Dec 2022 15:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLFUmb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Dec 2022 15:42:31 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF6E140CE;
        Tue,  6 Dec 2022 12:42:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NRXR03Jhqz4wgr;
        Wed,  7 Dec 2022 07:42:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670359342;
        bh=K7JYE1hToUGcBVpA/960K6aiEXk1vlQjnRMxpck3fCE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kPpSrWfffCgqvDXNp3pKfDZtQoHONEyECU3SBSQ+a4YOOLLejkgsRZDEjlxiZ0VbQ
         j8PnqK27EHAUa0MEkFEIHtUnG/bppLqG98tBz7wHyIrzJy24N1EkdOca9UBgbEPvbg
         TRKpQi8jJmUsTjNurze97VCxT/9NMe4jV+ot5tVcoTAQw1nJ4K/jy1JyXfpsFh6ypf
         u/fJGaNbUBAm/bnoilQpOTy9E4MFdzN1tEXMsX0AfPDSj6asFVplIWIHRiVbzmv/K+
         v2Q0kBJrmZWVrqDq56JiN04d/pvCCdW/871yA1QWXsUhepwuMXE3KLLU8sb5SjMxm5
         Ll+S367sS+nBw==
Date:   Wed, 7 Dec 2022 07:42:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Ricardo Koller <ricarkol@google.com>,
        Marc Zyngier <maz@kernel.org>,
        David Matlack <dmatlack@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] KVM: selftests: Fix build for memstress.[ch] rename
Message-ID: <20221207074108.42477c2d@canb.auug.org.au>
In-Reply-To: <20221206175916.250104-1-broonie@kernel.org>
References: <20221206175916.250104-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gIjGuZa49emUOUcGuk+mOYK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--Sig_/gIjGuZa49emUOUcGuk+mOYK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Tue,  6 Dec 2022 17:59:16 +0000 Mark Brown <broonie@kernel.org> wrote:
>
> Today's -next fails to build the KVM selftests on at least arm64 due to
> commit
>=20
>  9fda6753c9dd ("KVM: selftests: Rename perf_test_util.[ch] to memstress.[=
ch]")
>=20
> interacting poorly with commit
>=20
>  a93871d0ea9f ("KVM: selftests: Add a userfaultfd library")
>=20
> which adds a new user of perf_test_util.h.  Do the rename in the new
> user.
>=20
> Fixes: 9fda6753c9dd ("KVM: selftests: Rename perf_test_util.[ch] to memst=
ress.[ch]")
> Fixes: a93871d0ea9f ("KVM: selftests: Add a userfaultfd library")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: Ricardo Koller <ricarkol@google.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: David Matlack <dmatlack@google.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  tools/testing/selftests/kvm/lib/userfaultfd_util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/kvm/lib/userfaultfd_util.c b/tools/t=
esting/selftests/kvm/lib/userfaultfd_util.c
> index 3b44846fc277..92cef20902f1 100644
> --- a/tools/testing/selftests/kvm/lib/userfaultfd_util.c
> +++ b/tools/testing/selftests/kvm/lib/userfaultfd_util.c
> @@ -20,7 +20,7 @@
> =20
>  #include "kvm_util.h"
>  #include "test_util.h"
> -#include "perf_test_util.h"
> +#include "memstress.h"
>  #include "userfaultfd_util.h"
> =20
>  #ifdef __NR_userfaultfd
> --=20
> 2.30.2
>=20

Thanks for that.  I have added that as a merge fix patch to the kvm-arm
merge.  I assume this will be fixed up when that tree is merged into
the kvm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/gIjGuZa49emUOUcGuk+mOYK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOPqSgACgkQAVBC80lX
0GzQ2Qf+Ny661ZIduH2JTV2yIm/GiRstahlnwDTe8zVfqaYRmfV2AxCFi5ZkJPD5
QbaVfYBZBU/+fbIkVHr342CUQQvGW53EYHvbSUAp0InwYN22psIIUjrQCPw2izi/
GX9xRaShazh0d2jpZC6T1mzZZgwF18XfFAAdXEac+Vs+fB5TMIAcdjHEW38ibkQP
p8WQmXysyMEO1WntkiZvmzTmB34DGtU/YDgHVLw2RC7c9alQ3kQH93UTOkkmWtVg
jvnNg6QgKANQ6I9AiPubRuPlxFm5nKrAqhRW9nHYvk1AAkUOk3jhFVr6UPCxWj1a
VU6rsqmgMuSrrKoKmeOOeXO9ZkuMLg==
=qAFU
-----END PGP SIGNATURE-----

--Sig_/gIjGuZa49emUOUcGuk+mOYK--
