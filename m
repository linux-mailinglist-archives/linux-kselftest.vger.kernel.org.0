Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30998262587
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Sep 2020 05:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgIIDAu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Sep 2020 23:00:50 -0400
Received: from ozlabs.org ([203.11.71.1]:50703 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbgIIDAu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Sep 2020 23:00:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BmRbg2x0Gz9sTX;
        Wed,  9 Sep 2020 13:00:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1599620447;
        bh=3sMO884hg7pPLK7RKjxOZTh+vUD/yFzH8k0FjgNvOok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uaWxMc0OMTr1wT+EG8NLJgY72MEJ32VhO4TLbXpDfqMIzmrLbH29lQ6JnUTONVx0x
         BZlAZPt3+huulhPQhxvbnk8TkpY0LY4iqvZWxyELQKL0So61IFOeCvg+ZRMU6kTamW
         wyU5VNazyX/xdSYYSD3mu/vviL0pqGy7w2xGTqoV3l4xSKQmJ/uwFldU7Jv4daUC8k
         xCRer2a8AftNyH7pXTpHw2XxTXH+/puJjJr+ePzazfA58pklYRFFOYDLJKt6zPrrg8
         yRB6X4wiKEvniWJe0GgevNTULo4Z0PkwziAnufQqwhAMez3MM24jamB8jC6FFon0g0
         wKmyr1gXzfbuQ==
Date:   Wed, 9 Sep 2020 13:00:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Qian Cai <cai@lca.pw>
Cc:     skhan@linuxfoundation.org, brendanhiggins@google.com,
        urielguajardo@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-next@vger.kernel.org
Subject: Re: [PATCH 2/2] kunit: ubsan integration
Message-ID: <20200909130046.118fe505@canb.auug.org.au>
In-Reply-To: <20200903123824.GA4225@lca.pw>
References: <20200806174326.3577537-1-urielguajardojr@gmail.com>
        <20200806174326.3577537-2-urielguajardojr@gmail.com>
        <20200902125223.GA5676@lca.pw>
        <20200903123824.GA4225@lca.pw>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zfuNZ91fUths2EWrVnzCG=u";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--Sig_/zfuNZ91fUths2EWrVnzCG=u
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Qian,

On Thu, 3 Sep 2020 08:38:25 -0400 Qian Cai <cai@lca.pw> wrote:
>
> On Wed, Sep 02, 2020 at 08:52:24AM -0400, Qian Cai wrote:
> > On Thu, Aug 06, 2020 at 05:43:26PM +0000, Uriel Guajardo wrote: =20
> > > Integrates UBSAN into the KUnit testing framework. It fails KUnit tes=
ts
> > > whenever it reports undefined behavior.
> > >=20
> > > Signed-off-by: Uriel Guajardo <urielguajardo@google.com> =20
> >=20
> > It looks like this patch had been merged into linux-next but the "[PATC=
H 1/2]
> > kunit: support failure from dynamic analysis tools" did not. Hence, it =
caused a
> > compiling failure.
> >=20
> > lib/ubsan.c: In function =E2=80=98ubsan_prologue=E2=80=99:
> > lib/ubsan.c:141:2: error: implicit declaration of function =E2=80=98kun=
it_fail_current_test=E2=80=99; did you mean =E2=80=98kunit_init_test=E2=80=
=99? [-Werror=3Dimplicit-function-declaration]
> >   kunit_fail_current_test();
> >   ^~~~~~~~~~~~~~~~~~~~~~~
> >   kunit_init_test
> > cc1: some warnings being treated as errors =20
>=20
> Stephen, Shuah, can you revert this commit or pick up its dependency as w=
ell?

Sorry, for the slow response ... this should be gone today.

--=20
Cheers,
Stephen Rothwell

--Sig_/zfuNZ91fUths2EWrVnzCG=u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl9YRV4ACgkQAVBC80lX
0Gw8EQf/c1VzFm3ro9TFRsYuojPzJHb6J39cJzCwYjxVJ9yH1Qcf0d1rUbpt6w1W
8+EupMS6gQrVVzdawHGApftrxHuV8ELNRDVNsRo07V9E/cjbdHSaB7gXvnoCrjzR
msDborabO43BmnOVFs2Ji54y7Fl1Uy6EiTl9hDYXCEC3clXZaFL2FOU4myWaFLd0
kZJD4/pEcbe56T5Javo/fQFZCKYxC3jHGOeE1QQZ7yilSRsYFBLbvH5eTaOSDFOm
TIeuV0erCW3wrqKvhjz6ZWJHlilxSiBCnIPWuEu8dq+rcrXzGzvFDkWJs0REJU70
P90MDo8f4SV1Zgav4daSHApS5PnpLQ==
=qlg+
-----END PGP SIGNATURE-----

--Sig_/zfuNZ91fUths2EWrVnzCG=u--
