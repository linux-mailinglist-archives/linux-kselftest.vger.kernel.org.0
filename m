Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFF615A307
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2020 09:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgBLIOi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Feb 2020 03:14:38 -0500
Received: from mout-p-202.mailbox.org ([80.241.56.172]:30266 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbgBLIOi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Feb 2020 03:14:38 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 48HXVg31rGzQlDK;
        Wed, 12 Feb 2020 09:14:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id d6fAeFS6_2E4; Wed, 12 Feb 2020 09:14:29 +0100 (CET)
Date:   Wed, 12 Feb 2020 19:14:14 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     shuah <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: Linux 5.6-rc1 kselftest build failures
Message-ID: <20200212081414.7bwkndf6qxg2p35a@yavin>
References: <ff16537e-febc-1b98-0cf8-1aa23e0c29b0@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xhe55iz3x7b3lfsi"
Content-Disposition: inline
In-Reply-To: <ff16537e-febc-1b98-0cf8-1aa23e0c29b0@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--xhe55iz3x7b3lfsi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-11, shuah <shuah@kernel.org> wrote:
> openat2:
>=20
> tools/testing/selftests/openat2'
> gcc -Wall -O2 -g -fsanitize=3Daddress -fsanitize=3Dundefined openat2_test=
=2Ec
> helpers.c  -o tools/testing/selftests/openat2/openat2_test
> In file included from /usr/include/fcntl.h:301,
>                  from helpers.c:9:
> In function =E2=80=98openat=E2=80=99,
>     inlined from =E2=80=98touchat=E2=80=99 at helpers.c:49:11:
> /usr/include/x86_64-linux-gnu/bits/fcntl2.h:126:4: error: call to
> =E2=80=98__openat_missing_mode=E2=80=99 declared with attribute error: op=
enat with O_CREAT
> or O_TMPFILE in third argument needs 4 arguments
>   126 |    __openat_missing_mode ();
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~

Yeah, that's a brain-o -- it looks like you have a newer glibc than
me which gives you a warning when you don't set the mode. The fix should
be just the following:

--8<-----------------------------------------------------------------------
Subject: [PATCH] selftests: openat2: fix build error on newer glibc

It appears that newer glibcs check that openat(O_CREAT) was provided a
fourth argument (rather than passing garbage), resulting in the
following build error:

  In file included from /usr/include/fcntl.h:301,
                   from helpers.c:9:
  In function =E2=80=98openat=E2=80=99,
      inlined from =E2=80=98touchat=E2=80=99 at helpers.c:49:11:
  /usr/include/x86_64-linux-gnu/bits/fcntl2.h:126:4: error: call to
  =E2=80=98__openat_missing_mode=E2=80=99 declared with attribute error: op=
enat with O_CREAT
  or O_TMPFILE in third argument needs 4 arguments
    126 |    __openat_missing_mode ();
        |    ^~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 tools/testing/selftests/openat2/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/openat2/helpers.c b/tools/testing/self=
tests/openat2/helpers.c
index e9a6557ab16f..5074681ffdc9 100644
--- a/tools/testing/selftests/openat2/helpers.c
+++ b/tools/testing/selftests/openat2/helpers.c
@@ -46,7 +46,7 @@ int sys_renameat2(int olddirfd, const char *oldpath,
=20
 int touchat(int dfd, const char *path)
 {
-	int fd =3D openat(dfd, path, O_CREAT);
+	int fd =3D openat(dfd, path, O_CREAT, 0700);
 	if (fd >=3D 0)
 		close(fd);
 	return fd;
--=20
2.25.0


--xhe55iz3x7b3lfsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXkOzzwAKCRCdlLljIbnQ
EraKAQC/qMKYRdSDHKJDWUIVTk4FHJi8YDwEcnu4LjqgbyslhwD/TgRqDCBjUmG4
DYIqXhuIMKKZchvwgGkdIRL6Kdua2wk=
=XJmq
-----END PGP SIGNATURE-----

--xhe55iz3x7b3lfsi--
