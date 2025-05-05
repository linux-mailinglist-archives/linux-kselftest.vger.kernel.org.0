Return-Path: <linux-kselftest+bounces-32336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE11AA915C
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 12:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C2A1700C7
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 10:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03431F9F7C;
	Mon,  5 May 2025 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNxoGU+R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782441F2BAB;
	Mon,  5 May 2025 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746442236; cv=none; b=q3lPR6io/3QftJlwx7jV2SxjSVIz9Zh9ejSDLYWeeVOsuewdbubjUo1YFfOXLInPvCbi6G/GeVObmdljSr5S/DSGXrr0TMOTnk1DsQgPrMK0nS+AFUNl3FLMS+KQdlUO/GTo43ajjR+4I9t05XW9IzmbOKmYThLJHdcWIC6+hF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746442236; c=relaxed/simple;
	bh=UFNblr5wKg+Ece6PV/X+dgW5H5sguoEuUnrsMpQzl84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYrXQQo5wsMhAyzAibcm69k+0+68UHf+VbSJNQ3afmgjwannaWznfiEq7/gawBH7gqlN3pCO0iNeoaL/2nVJVs+30j1HEpNaFiSXyQxAiJOSdVQEtyQRAwyl1TMpYrzElSELNchQndL8eKzKxHi3UU8vFCBnlZdsIDhoUIU4TVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNxoGU+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFF0C4CEE4;
	Mon,  5 May 2025 10:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746442236;
	bh=UFNblr5wKg+Ece6PV/X+dgW5H5sguoEuUnrsMpQzl84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PNxoGU+RdkjCob6oxkTObdkcfZS1OoE/7wP8qPoIRWgyqKRc6IQ7fBH5CIijs/sPK
	 WeLCVg5mUeMqygqP+WgtnnpRRF34FRaJnSqUFHIwWwmtJWiZuEUmpzSL5G4/JupXIV
	 YCg/6kNg+AZhiet1i+qNLSbM+hHE8RRdu3j1rx4j7aFD3iWubBy67URtLS6zqZ/lr5
	 oe1dBvKEKNfunBRXbfIFBNVpL3OHFQAWwHHRIfmaJmPaqYwkT0WReaRA+C5aMqPrgB
	 rh1w8+NslhQ2VQAvi2MqWPrjLe2oy3ejBXTMxebBIvwQIxtkkO3VHQK+S9Dh9Q3mGe
	 j0s5Fe/G9DORg==
Date: Mon, 5 May 2025 19:50:31 +0900
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
	Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v3 12/32] selftests: harness: Stop using
 setjmp()/longjmp()
Message-ID: <aBiX9zbR7ehAxQjS@finisterre.sirena.org.uk>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
 <20250411-nolibc-kselftest-harness-v3-12-4d9c0295893f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5qcRjHQpVcMlMOPH"
Content-Disposition: inline
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-12-4d9c0295893f@linutronix.de>
X-Cookie: I thought YOU silenced the guard!


--5qcRjHQpVcMlMOPH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 11:00:36AM +0200, Thomas Wei=C3=9Fschuh wrote:
> Usage of longjmp() was added to ensure that teardown is always run in
> commit 63e6b2a42342 ("selftests/harness: Run TEARDOWN for ASSERT failures=
")
> However instead of calling longjmp() to the teardown handler it is easier=
 to
> just call the teardown handler directly from __bail().
> Any potential duplicate teardown invocations are harmless as the actual
> handler will only ever be executed once since
> commit fff37bd32c76 ("selftests/harness: Fix fixture teardown").

I didn't fully verify (I'm on holiday right now) but it looks like this,
which is in -next as 8a37733a874f:

> @@ -757,7 +749,7 @@
>   */
>  #define OPTIONAL_HANDLER(_assert) \
>  	for (; _metadata->trigger; _metadata->trigger =3D \
> -			__bail(_assert, _metadata))
> +			__bail(_assert, _metadata, self, variant))
> =20
>  #define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeo=
f__(var))1))
> =20

breaks the build of several selftests when building for arm64:

In file included from seccomp_bpf.c:56:
seccomp_bpf.c: In function =E2=80=98kill_thread_or_group=E2=80=99:
=2E./kselftest_harness.h:755:52: error: =E2=80=98self=E2=80=99 undeclared (=
first use in this function)
  755 |                         __bail(_assert, _metadata, self, variant))
      |                                                    ^~~~
=2E./kselftest_harness.h:803:14: note: in expansion of macro =E2=80=98OPTIO=
NAL_HANDLER=E2=80=99
  803 | } while (0); OPTIONAL_HANDLER(_assert)
      |              ^~~~~~~~~~~~~~~~
=2E./kselftest_harness.h:516:9: note: in expansion of macro =E2=80=98__EXPE=
CT=E2=80=99
  516 |         __EXPECT(expected, #expected, seen, #seen, =3D=3D, 1)
      |         ^~~~~~~~
seccomp_bpf.c:844:9: note: in expansion of macro =E2=80=98ASSERT_EQ=E2=80=99
  844 |         ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
      |         ^~~~~~~~~

Full build log at:

    https://builds.sirena.org.uk/407f60a151df3c44397e5afc0111eb9b026c38d3/a=
rm64/defconfig/build.log

--5qcRjHQpVcMlMOPH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgYl/EACgkQJNaLcl1U
h9BBRgf+IViHaDpaJxLoE3q7DmujnsBqCpT+BG4txIQfmu78it0stCSX2sxU/oVN
hMb4q1JGg8U8cqHExGAXp2yoPi1p0tSLxlpXSZuoIbLAiIx+ff3+Uf9Ne3lNJ+CB
LtKIEqZqjA6uRJ9j9PftIg14BI8RgEq4aM8WfXPWNLVkVzUvPIdGiiRuS8Pwif10
n/c5lk77jbz7WkSvuBhfYfxO0qnq68QxDih3zK6t0qvmHUDi7dr8IQIcE6uG/Xum
v4V1kTbgfHmWL6RMCruVvt0dr62yjP1Cu5LX7WbdBGHHILNB3NFwlTG55wn2b7cJ
YF3p1UVV4vO3PuRKTzqYPMX3oCNA4w==
=X2kM
-----END PGP SIGNATURE-----

--5qcRjHQpVcMlMOPH--

