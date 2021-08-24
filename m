Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157AC3F5D05
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Aug 2021 13:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbhHXLWd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Aug 2021 07:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbhHXLWc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Aug 2021 07:22:32 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F41C061757;
        Tue, 24 Aug 2021 04:21:48 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Gv6Bc47nGzQjym;
        Tue, 24 Aug 2021 13:21:44 +0200 (CEST)
Received: from spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116])
        by smtp102.mailbox.org (Postfix) with ESMTP id 3FD93270;
        Tue, 24 Aug 2021 13:21:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp102.mailbox.org ([80.241.60.233])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id I8hs8NQsf1jJ; Tue, 24 Aug 2021 13:21:38 +0200 (CEST)
Received: from senku (unknown [118.208.104.190])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp102.mailbox.org (Postfix) with ESMTPSA id 2D16326D;
        Tue, 24 Aug 2021 13:21:34 +0200 (CEST)
Date:   Tue, 24 Aug 2021 21:21:29 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>, shuah@kernel.org,
        Christian Brauner <christian@brauner.io>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: openat2: Fix testing failure for O_LARGEFILE
 flag
Message-ID: <20210824112129.2t6lzqyf2dxllw4a@senku>
References: <1627475340-128057-1-git-send-email-baolin.wang@linux.alibaba.com>
 <01184d9e-477d-cbe4-c936-62b92e915911@linux.alibaba.com>
 <9411d418-567b-78f0-0e4d-30f08371c55a@linux.alibaba.com>
 <a9dc1616-61b9-c010-950c-521693c74247@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ufybcjmqvvbiby3e"
Content-Disposition: inline
In-Reply-To: <a9dc1616-61b9-c010-950c-521693c74247@linuxfoundation.org>
X-Rspamd-Queue-Id: 3FD93270
X-Rspamd-UID: 850424
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--ufybcjmqvvbiby3e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-08-23, Shuah Khan <skhan@linuxfoundation.org> wrote:
> Hi Baolin,
>=20
> On 8/22/21 8:40 PM, Baolin Wang wrote:
> > Hi Shuah,
> >=20
> > On 2021/7/28 20:32, Baolin Wang wrote:
> > > Hi,
> > >=20
> > > > When running the openat2 test suite on ARM64 platform, we got below=
 failure,
> > > > since the definition of the O_LARGEFILE is different on ARM64. So w=
e can
> > > > set the correct O_LARGEFILE definition on ARM64 to fix this issue.
> > >=20
> > > Sorry, I forgot to copy the failure log:
> > >=20
>=20
> Please cc everybody get_maintainers.pl suggests. You are missing
> key reviewers for this change.
>=20
> Adding Christian Brauner and Aleksa Sarai to the thread.
>=20
> > > # openat2 unexpectedly returned # 3['/lkp/benchmarks/kernel_selftests=
/tools/testing/selftests/openat2'] with 208000 (!=3D 208000)
>=20
> Not sure I understand this. 208000 (!=3D 208000) look sthe same to me.
>=20
> > > not ok 102 openat2 with incompatible flags (O_PATH | O_LARGEFILE) fai=
ls with -22 (Invalid argument)
> > >=20
> > > >=20
> > > > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >=20
> > Could you apply this patch if no objection from your side? Thanks.
> >=20
>=20
> Ideally this define should come from an include file.

The issue is that O_LARGEFILE is set to 0 by glibc because glibc appears
to hide the nuts and bolts of largefile support from userspace. I
couldn't find a nice way of doing a architecture-dependent includes of
include/uapi from kselftests, so I just went with this instead -- but I
agree that a proper include would be better if someone can figure out
how to do it.

> Christian, Aleksa,
>=20
> Can you review this patch and let me know if this approach looks right.

Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

It'd be nice to fix this for the other architectures I mention in the
comment (mips, parisc, powerpc, sparc) -- which are the ones that I
could find that had a custom O_LARGEFILE definition.

> > > > ---
> > > > =A0 tools/testing/selftests/openat2/openat2_test.c | 4 ++++
> > > > =A0 1 file changed, 4 insertions(+)
> > > >=20
> > > > diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools=
/testing/selftests/openat2/openat2_test.c
> > > > index d7ec1e7..1bddbe9 100644
> > > > --- a/tools/testing/selftests/openat2/openat2_test.c
> > > > +++ b/tools/testing/selftests/openat2/openat2_test.c
> > > > @@ -22,7 +22,11 @@
> > > > =A0=A0 * XXX: This is wrong on {mips, parisc, powerpc, sparc}.
> > > > =A0=A0 */
> > > > =A0 #undef=A0=A0=A0 O_LARGEFILE
> > > > +#ifdef __aarch64__
> > > > +#define=A0=A0=A0 O_LARGEFILE 0x20000
> > > > +#else
> > > > =A0 #define=A0=A0=A0 O_LARGEFILE 0x8000
> > > > +#endif
> > > > =A0 struct open_how_ext {
> > > > =A0=A0=A0=A0=A0 struct open_how inner;
> > > >=20
> >=20
>=20
> thanks,
> -- Shuah

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ufybcjmqvvbiby3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCYSTWNwAKCRCdlLljIbnQ
Ep/uAQDWL4pxkriA19TI8MlqihWk/zMgI75lNQtI5MUCR5WZvgD/YUOzLOSyZrU9
z0gdvEDAdRLwmJEEzs/wtDV/eb0YbQo=
=ijy5
-----END PGP SIGNATURE-----

--ufybcjmqvvbiby3e--
