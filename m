Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3A215BA0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2020 08:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgBMH2R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Feb 2020 02:28:17 -0500
Received: from mout-p-101.mailbox.org ([80.241.56.151]:40788 "EHLO
        mout-p-101.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbgBMH2R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Feb 2020 02:28:17 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 48J7Ql1frkzKmT5;
        Thu, 13 Feb 2020 08:28:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id rJTc2o0rhn-7; Thu, 13 Feb 2020 08:28:11 +0100 (CET)
Date:   Thu, 13 Feb 2020 18:27:58 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     shuah <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: Linux 5.6-rc1 kselftest build failures
Message-ID: <20200213072758.e2bngq2z6yypvsim@yavin>
References: <ff16537e-febc-1b98-0cf8-1aa23e0c29b0@kernel.org>
 <20200212081414.7bwkndf6qxg2p35a@yavin>
 <5311f218-9bb0-4792-c469-019c7c2db7ee@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qh5d5kw7pebtctms"
Content-Disposition: inline
In-Reply-To: <5311f218-9bb0-4792-c469-019c7c2db7ee@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--qh5d5kw7pebtctms
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-12, shuah <shuah@kernel.org> wrote:
> On 2/12/20 1:14 AM, Aleksa Sarai wrote:
> > On 2020-02-11, shuah <shuah@kernel.org> wrote:
> > > openat2:
> > >=20
> > > tools/testing/selftests/openat2'
> > > gcc -Wall -O2 -g -fsanitize=3Daddress -fsanitize=3Dundefined openat2_=
test.c
> > > helpers.c  -o tools/testing/selftests/openat2/openat2_test
> > > In file included from /usr/include/fcntl.h:301,
> > >                   from helpers.c:9:
> > > In function =E2=80=98openat=E2=80=99,
> > >      inlined from =E2=80=98touchat=E2=80=99 at helpers.c:49:11:
> > > /usr/include/x86_64-linux-gnu/bits/fcntl2.h:126:4: error: call to
> > > =E2=80=98__openat_missing_mode=E2=80=99 declared with attribute error=
: openat with O_CREAT
> > > or O_TMPFILE in third argument needs 4 arguments
> > >    126 |    __openat_missing_mode ();
> > >        |    ^~~~~~~~~~~~~~~~~~~~~~~~
> >=20
> > Yeah, that's a brain-o -- it looks like you have a newer glibc than
> > me which gives you a warning when you don't set the mode. The fix should
> > be just the following:
> >=20
>=20
> Nice. Do you mind sending a proper patch, I can pull in.

Done[1].

[1]: https://lore.kernel.org/linux-kselftest/20200213072656.15611-1-cyphar@=
cyphar.com/

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--qh5d5kw7pebtctms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXkT6ewAKCRCdlLljIbnQ
EnCtAQCzI05OXMgl0JIuGJ5egu8Kczl6d3+PRHVJNjo+G6ctzAD8DeeaDhBBGG4S
DRST3Y5gOLhDnlxv5gvFKh6UVQqbxg4=
=toGw
-----END PGP SIGNATURE-----

--qh5d5kw7pebtctms--
