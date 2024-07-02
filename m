Return-Path: <linux-kselftest+bounces-13034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB0691EEE7
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 08:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5783E1F22481
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 06:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A3060BBE;
	Tue,  2 Jul 2024 06:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="Dkuo6Nga"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AC06A342;
	Tue,  2 Jul 2024 06:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719901493; cv=none; b=JkQMM0MMkvaNi/RyPAH6F0npmH3kKG005Sb/8N0XdeM46LA4L9Ad8PcsDiZ5Xc1vRM8G/Ecd/2RZhJyU/vzAg2C51DPr92pRQ4Xrmm8FTKPeYghdKuow5cO2TAJ+aWHszmfKC03nd3TiUYYXptzlJqiwNxZ8YwAOzq8I7cqJ2lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719901493; c=relaxed/simple;
	bh=eQBjqlSGyO59Jc0Nff0IJog1OEaBmGyhGkjRGxye8bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cixnmNQecXF0MnJLJoImfiJD9HLa2ysDkKaYtC0RRgjC6mUSETYBNjrApzZOegI9JmYCIfYMXA1IdT0pSUq0fcuQDE+/V8uOcdxrMM4qhpg1X3M1WYtvSEAQGKPVQUYYQwntTnCeVtS56Ajr7MkY/9KMDKVsGSyfsweewiLjF9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=Dkuo6Nga; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WCtDS4nSkz9smv;
	Tue,  2 Jul 2024 08:24:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1719901480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8uqtxEOVEGEDNB8zOCRNpkE7rC/LoU/VZhdBt7aB2E=;
	b=Dkuo6NgacKiGuHwkPbRoWTd6TT778a+CuyBlGJHcOF21J10q01ROXqemLTjg3ROdMW1lO2
	XlpVhbD6h7Qf5e2LNGj2IcGdpUgBKiC8QvAWDPVj1cNsCtaZRYHVevDzkelzTJaNi3IJgb
	3R87CORDjd/C/OWuP9kQSZ4Sp45q5XvsQdIN+vgDhT02LyEQEfRgqS35K9D5r4bd4RWtmv
	2D2aof3gWIasLLg9LywnldOTI2aVt4Z1qijqLPiSGIugOgXkyXc8+w79T8spCxoQmijOAu
	qEMjos7MCBU+Nl1hK62eLDMyABoixcrlG5fTexcY3jT1Ciym9oMUqVrliN8qHg==
Date: Mon, 1 Jul 2024 23:24:25 -0700
From: Aleksa Sarai <cyphar@cyphar.com>
To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, akpm@linux-foundation.org, david@readahead.eu, 
	dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com, jeffxu@google.com, 
	jorgelo@chromium.org, keescook@chromium.org, skhan@linuxfoundation.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v4] memfd: `MFD_NOEXEC_SEAL` should not imply
 `MFD_ALLOW_SEALING`
Message-ID: <20240702.061524-ancient.sardines.voting.pucker-nTYAKsgH2OOw@cyphar.com>
References: <20240630184912.37335-1-pobrn@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ahusy5h4jnsdkkjx"
Content-Disposition: inline
In-Reply-To: <20240630184912.37335-1-pobrn@protonmail.com>


--ahusy5h4jnsdkkjx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-06-30, Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com> wrote:
> `MFD_NOEXEC_SEAL` should remove the executable bits and set `F_SEAL_EXEC`
> to prevent further modifications to the executable bits as per the comment
> in the uapi header file:
>=20
>   not executable and sealed to prevent changing to executable
>=20
> However, commit 105ff5339f498a ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EX=
EC")
> that introduced this feature made it so that `MFD_NOEXEC_SEAL` unsets
> `F_SEAL_SEAL`, essentially acting as a superset of `MFD_ALLOW_SEALING`.
>=20
> Nothing implies that it should be so, and indeed up until the second vers=
ion
> of the of the patchset[0] that introduced `MFD_EXEC` and `MFD_NOEXEC_SEAL=
`,
> `F_SEAL_SEAL` was not removed, however, it was changed in the third revis=
ion
> of the patchset[1] without a clear explanation.
>=20
> This behaviour is surprising for application developers, there is no
> documentation that would reveal that `MFD_NOEXEC_SEAL` has the additional
> effect of `MFD_ALLOW_SEALING`. Additionally, combined with `vm.memfd_noex=
ec=3D2`
> it has the effect of making all memfds initially sealable.
>=20
> So do not remove `F_SEAL_SEAL` when `MFD_NOEXEC_SEAL` is requested,
> thereby returning to the pre-Linux 6.3 behaviour of only allowing
> sealing when `MFD_ALLOW_SEALING` is specified.

This behaviour makes sense, I'm a little sad I didn't catch it when I
was fixing vm.memfd_noexec. There is a possibility for breakage, but we
should give it a shot, given how new the API is (and the API itself was
also broken until Linux 6.6 anyway)...

Feel free to take my

Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

Thanks.

> Now, this is technically a uapi break. However, the damage is expected
> to be minimal. To trigger user visible change, a program has to do the
> following steps:
>=20
>  - create memfd:
>    - with `MFD_NOEXEC_SEAL`,
>    - without `MFD_ALLOW_SEALING`;
>  - try to add seals / check the seals.
>=20
> But that seems unlikely to happen intentionally since this change
> essentially reverts the kernel's behaviour to that of Linux <6.3,
> so if a program worked correctly on those older kernels, it will
> likely work correctly after this change.
>=20
> I have used Debian Code Search and GitHub to try to find potential
> breakages, and I could only find a single one. dbus-broker's
> memfd_create() wrapper is aware of this implicit `MFD_ALLOW_SEALING`
> behaviour, and tries to work around it[2]. This workaround will
> break. Luckily, this only affects the test suite, it does not affect
> the normal operations of dbus-broker. There is a PR with a fix[3].
>=20
> I also carried out a smoke test by building a kernel with this change
> and booting an Arch Linux system into GNOME and Plasma sessions.
>=20
> There was also a previous attempt to address this peculiarity by
> introducing a new flag[4].
>=20
> [0]: https://lore.kernel.org/lkml/20220805222126.142525-3-jeffxu@google.c=
om/
> [1]: https://lore.kernel.org/lkml/20221202013404.163143-3-jeffxu@google.c=
om/
> [2]: https://github.com/bus1/dbus-broker/blob/9eb0b7e5826fc76cad7b025bc46=
f267d4a8784cb/src/util/misc.c#L114
> [3]: https://github.com/bus1/dbus-broker/pull/366
> [4]: https://lore.kernel.org/lkml/20230714114753.170814-1-david@readahead=
=2Eeu/
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
> ---
>=20
> * v3: https://lore.kernel.org/linux-mm/20240611231409.3899809-1-jeffxu@ch=
romium.org/
> * v2: https://lore.kernel.org/linux-mm/20240524033933.135049-1-jeffxu@goo=
gle.com/
> * v1: https://lore.kernel.org/linux-mm/20240513191544.94754-1-pobrn@proto=
nmail.com/
>=20
> This fourth version returns to removing the inconsistency as opposed to d=
ocumenting
> its existence, with the same code change as v1 but with a somewhat extend=
ed commit
> message. This is sent because I believe it is worth at least a try; it ca=
n be easily
> reverted if bigger application breakages are discovered than initially im=
agined.
>=20
> ---
>  mm/memfd.c                                 | 9 ++++-----
>  tools/testing/selftests/memfd/memfd_test.c | 2 +-
>  2 files changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 7d8d3ab3fa37..8b7f6afee21d 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -356,12 +356,11 @@ SYSCALL_DEFINE2(memfd_create,
> =20
>  		inode->i_mode &=3D ~0111;
>  		file_seals =3D memfd_file_seals_ptr(file);
> -		if (file_seals) {
> -			*file_seals &=3D ~F_SEAL_SEAL;
> +		if (file_seals)
>  			*file_seals |=3D F_SEAL_EXEC;
> -		}
> -	} else if (flags & MFD_ALLOW_SEALING) {
> -		/* MFD_EXEC and MFD_ALLOW_SEALING are set */
> +	}
> +
> +	if (flags & MFD_ALLOW_SEALING) {
>  		file_seals =3D memfd_file_seals_ptr(file);
>  		if (file_seals)
>  			*file_seals &=3D ~F_SEAL_SEAL;
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/s=
elftests/memfd/memfd_test.c
> index 95af2d78fd31..7b78329f65b6 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -1151,7 +1151,7 @@ static void test_noexec_seal(void)
>  			    mfd_def_size,
>  			    MFD_CLOEXEC | MFD_NOEXEC_SEAL);
>  	mfd_assert_mode(fd, 0666);
> -	mfd_assert_has_seals(fd, F_SEAL_EXEC);
> +	mfd_assert_has_seals(fd, F_SEAL_SEAL | F_SEAL_EXEC);
>  	mfd_fail_chmod(fd, 0777);
>  	close(fd);
>  }
> --=20
> 2.45.2
>=20
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ahusy5h4jnsdkkjx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZoOdGAAKCRAol/rSt+lE
b/bMAPsELjqhhIEvgoFUyco4SkEpHUv9AdswlGz0JSGqGog89QD/T9UJTeK56VZR
SLv/IwmCkNnuMde9Oc3GeTXAWkIVlAk=
=9zpA
-----END PGP SIGNATURE-----

--ahusy5h4jnsdkkjx--

