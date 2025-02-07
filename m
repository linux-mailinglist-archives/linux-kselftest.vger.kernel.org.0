Return-Path: <linux-kselftest+bounces-26013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F7DA2CA1E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 18:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC5B3A77B9
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 17:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0871922E1;
	Fri,  7 Feb 2025 17:26:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F74F23C8DE;
	Fri,  7 Feb 2025 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949171; cv=none; b=GOnsL67d2DwMhf+BDxl0XZp09TgqGU4eldyM2oTeKIlBL6FRipa8IlOkri8q8f6SFSsstSYFoLHRB2wM7EMg+Ej+pZ2Dyn7oeuzo61VmaaL95X3zzON037jsQ4mdKnlrU6b+od9g5IPi+6eEq5Iel4gRP/K1yNsjOJljS1tKzXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949171; c=relaxed/simple;
	bh=G8iebWs9iXWEisbS8QoULbBM7HA813xGjWjC55f/gDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oq3AIjd+gXvwte4qAQkSBp36EsYXiox4AB1+hxsVUyhb1xyv/mdJItLEl2bE1OIDTEN9/q3gWJyzP7DQ6e0F+mYgBjEHzKxp08T9WUtK4BAk3q71BLDnuGSV6hKy/2kPAPiFqWCUL8h2azZRnrBVj4wNS/ZjUk0CJowZTQ9Z1sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22999C4CED1;
	Fri,  7 Feb 2025 17:26:08 +0000 (UTC)
Date: Fri, 7 Feb 2025 17:26:06 +0000
From: Mark Brown <broonie@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Fix uninitialized variable warning in
 FPMR test
Message-ID: <89da135a-8c14-478f-9830-0b03ecd0b14d@sirena.org.uk>
References: <20250207-arm_fix_selftest-v1-1-0d6eeb04299e@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hHw0qavQsd22qTLy"
Content-Disposition: inline
In-Reply-To: <20250207-arm_fix_selftest-v1-1-0d6eeb04299e@debian.org>
X-Cookie: MMM-MM!!  So THIS is BIO-NEBULATION!


--hHw0qavQsd22qTLy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2025 at 03:06:42AM -0800, Breno Leitao wrote:
> Fix compiler warning about potentially uninitialized orig_fpmr variable:
>=20
> 	testcases/fpmr_siginfo.c: In function =E2=80=98fpmr_present=E2=80=99:
> 	testcases/fpmr_siginfo.c:68:25: warning: =E2=80=98orig_fpmr=E2=80=99 may=
 be used uninitialized in this function [-Wmaybe-uninitialized]
> 	                         fprintf(stderr, "FPMR in frame is %llx, was %ll=
x\n",
> 	                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
> 	                                 fpmr_ctx->fpmr, orig_fpmr);
> 	                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~

This seems like something that should be reported to the compiler
people, we only print the FPMR value if have_fpmr and there's an
assignment to orig_fpmr in that case.  Which compiler is this?

--hHw0qavQsd22qTLy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmemQi0ACgkQJNaLcl1U
h9AttAf/XRt7qoqT2772eKxoPwS3Sq6TxfiGGChnMGjdkvM2j6Oxm8hEirSFUG8t
ueb91q79QHguSHJVjM+MOgwiHjexs85Itp5UG5lMGNoxKgVCPfZADc/NlsvTbXEP
94bxiYfE+PA6RqVU7NN21YCLXCB3AOe54bY/klJbscm3wWV5Q/lBwRCpXfMkG90P
qEp7UNTQChDTZmpJvjeFUdIp8jD4uWu+WgOvdfkhU+L2lPnERaMJ8GiOiIrPymrN
VRpQHu3PPsczwbUJ+qNidgIPhiCvpX7CAMnzixVC9XU0iUc2iHm7hvC2P8mmbjpb
wtyCIXytbPAH5vXZMvPE+Wm/jIGFvA==
=5EkO
-----END PGP SIGNATURE-----

--hHw0qavQsd22qTLy--

