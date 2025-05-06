Return-Path: <linux-kselftest+bounces-32486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08124AABB22
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 09:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46BE74A105E
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 07:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA56821FF55;
	Tue,  6 May 2025 05:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+iAB74T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8763A21FF3A;
	Tue,  6 May 2025 05:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746511195; cv=none; b=IE7jHWzaBykI4Iz/RTND/q4sIpLDgh0QAXsxASOsVwH+rWsF3eVMJKl86TJEsR6UEWEUzSNLsIbMlWLirgVz5gsOmbvw0OS10y5Ya7n19rF9KiiO7/RzdTCjAbWAtOP1bFKkOJSAx/9R2JEm05dCp+tkKTn7FzJEFX0w3b6uHm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746511195; c=relaxed/simple;
	bh=Kb1lUAeoRtIUJnAhsc3vraaNuVuobSjLberQPqjWHbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCAGiWS/qHv5cR5KYjKIZ2tRw6rdElm+Rsnvl1y7w6jXrn5fVd9sz2lMHsxxB/PMs4eGd/tI+dtbhe8K/wGlOLzYp98W8asrHebKf7M21yJqfNud2sr2OaSCeyaBH8vSlldODGdPs1j8WwKdKPeMuwi/PsVifOnSabOnMmpja0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+iAB74T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4CAC4CEE4;
	Tue,  6 May 2025 05:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746511195;
	bh=Kb1lUAeoRtIUJnAhsc3vraaNuVuobSjLberQPqjWHbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+iAB74T78uLHaN/ZWrLl3mkMArBPj9sY2AZ9ipmmampIfxDskrxaVDstkNrEbuNU
	 avP0K4N7eRvWfwvDFnDVVW5iehQKUza7/XluC/TP/NvGRCm07wHo7HA6Awk3DgNN+w
	 HpTg47GRibcPjIGLq1CEBXCOsmRJ3eqUUGop4f/fLwTXTn3HvDClzefqLb3LXTnid8
	 bgn5KvnoKx2PTOmgN7403EymtTBURYxw+W/4AKu1IkjTz8mM4YCH5pTmYQoCk+bXkm
	 c+tqVUGpLp6fyHP1Sn8/Ax+Q7TYiCDowzLHVkJb9EC5F8Ik7kNOVmQPRGL09EHku0E
	 ZGs+JYYZ8FcHw==
Date: Tue, 6 May 2025 14:59:49 +0900
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
	Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 14/14] HACK: selftests/nolibc: demonstrate usage of
 the kselftest harness
Message-ID: <aBmlVZ70RhyB3KNQ@finisterre.sirena.org.uk>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
 <20250505-nolibc-kselftest-harness-v4-14-ee4dd5257135@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5PVValDLORU6SycC"
Content-Disposition: inline
In-Reply-To: <20250505-nolibc-kselftest-harness-v4-14-ee4dd5257135@linutronix.de>
X-Cookie: Well begun is half done.


--5PVValDLORU6SycC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2025 at 05:15:32PM +0200, Thomas Wei=DFschuh wrote:

> Show how to use the kselftest harness together with nolibc.
> This just runs the existing harness selftest by crudely replacing the
> regular nolibc-test.c with the harness-selftest.c to get that wired up ea=
sily.
> To use it:
> 	$ cd tools/testing/selftests/nolibc/
> 	$ ./run-tests -m user
>=20
> In the future nolibc-test can use the harness for itself.

FWIW there's also several arm64 tests which are written using nolibc
which could usefully be converted to this, they're using nolibc because
they test interfaces intended to be used by libc and so want to avoid
conflicting uses.

--5PVValDLORU6SycC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgZpVIACgkQJNaLcl1U
h9DrpAf/UmMsQFSFH6KSf/ihkHiVXwn80Wb/1PIyryqGvYmFbUsm2PhRZjPEVOqV
lrn/maI9O9kL6q5i3iA72f2YOleC6oILKwMaCMMTxeVH5x+S2E0A+P7gwjyXlan2
lKxVxpr+ddnKARBiH+xuXcKEtL3dtSJO/vgvrl9X/CuvAa2HOMKYt2VzwKOUsE2+
9vbxHrVDsAVP5QZLYjuxJHe8x1UByabickyNNdsRO+//F3jus0t1ixa868KUew9/
t0LxERfxJfmdDSsexvfj7Tbr4uQYiPheEY05uNPfh2+grjFIRXi8p8MWEHQObu5s
U/Fj/0xNChSCnibLIHRKs8h3npW1Ig==
=u/Qq
-----END PGP SIGNATURE-----

--5PVValDLORU6SycC--

