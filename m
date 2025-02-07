Return-Path: <linux-kselftest+bounces-26029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AB6A2CC44
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 20:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374A01637B1
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4F01A0712;
	Fri,  7 Feb 2025 19:05:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008231990AB;
	Fri,  7 Feb 2025 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738955102; cv=none; b=BMZ/sWoKSUVNOAlMJUnq94y2yy026IttBuTcvwBhqCr7+Z6XzDpA2CxcONOkY8deN1pchCx0dxjLeL2P/Ng2VmbOly8WCUpluZbZgVXI72LiXJLrmnhaQF8RRPgdyF8p3nbXuMMsovQgqqrv48EvhMyutRu/rWMiVCcRL3juxGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738955102; c=relaxed/simple;
	bh=nfak6YBpKoIkwV6c51SeGEIGw40oBBnFp4Wpk3NEI4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxw0BUmV6kqG25er+t+n8dVQ57dLT0fNIbLiybxugAD2feEt1BkAiNeiagcvYPi8H/HXiz8aQVIrPlpX68Hu227xyMIBVEKtiDrpT4869C8sxi4/Hf2TrSv7Cb9ls/2kys2GJwqsSRHcg2OjfnKvkjj2/xTesq2l9u9fwBElw4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF2DC4CED1;
	Fri,  7 Feb 2025 19:04:59 +0000 (UTC)
Date: Fri, 7 Feb 2025 19:04:57 +0000
From: Mark Brown <broonie@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Fix uninitialized variable warning in
 FPMR test
Message-ID: <ba0dddf4-e4e4-482b-95f3-52eb4e31a643@sirena.org.uk>
References: <20250207-arm_fix_selftest-v1-1-0d6eeb04299e@debian.org>
 <89da135a-8c14-478f-9830-0b03ecd0b14d@sirena.org.uk>
 <20250207-small-marmot-of-opposition-e7afd3@leitao>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FDm01rLVQI5sIA6w"
Content-Disposition: inline
In-Reply-To: <20250207-small-marmot-of-opposition-e7afd3@leitao>
X-Cookie: MMM-MM!!  So THIS is BIO-NEBULATION!


--FDm01rLVQI5sIA6w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2025 at 10:45:39AM -0800, Breno Leitao wrote:
> On Fri, Feb 07, 2025 at 05:26:06PM +0000, Mark Brown wrote:
> > On Fri, Feb 07, 2025 at 03:06:42AM -0800, Breno Leitao wrote:
> > > Fix compiler warning about potentially uninitialized orig_fpmr variab=
le:

> > > 	testcases/fpmr_siginfo.c: In function =E2=80=98fpmr_present=E2=80=99:
> > > 	testcases/fpmr_siginfo.c:68:25: warning: =E2=80=98orig_fpmr=E2=80=99=
 may be used uninitialized in this function [-Wmaybe-uninitialized]

> > This seems like something that should be reported to the compiler
> > people, we only print the FPMR value if have_fpmr and there's an
> > assignment to orig_fpmr in that case.  Which compiler is this?

> Good point. I am using:
> 	# gcc --version
> 	gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-2)

> Clang, on the other hand, isn't upset about it.

Right, and I'm not seeing it here either.  I'm not opposed to applying
the patch if enough people are using toolchains that have the issue, but
these sorts of sledgehammer assignments aren't ideal since they mask
issues.

--FDm01rLVQI5sIA6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmemWVgACgkQJNaLcl1U
h9D+tAf/Xm9j1E6SpVemvF2m33NlUWK3E1tEJsTSJrt4XEkozF5hb4Qf+COjmmg8
wKWFw6higqVPG1lUlScw5fbRQ+jzUgAI4PS6zmBDKNmutTF3NZxByVEvVKKMqDca
VtDTu1fgWcCJbo7GTBX63tG6SYrCVf2DwaG8208uq0J+kVXZ3pR8K8JaLuE4JBUD
tf8q6Aa/Plptr/QRRjD9Fx73ARjz26m2J4Lgu/goQuFC/dYJsxh8mZe0/+if2gZm
AlEOUGPZC69sv7ROAow4GyZiglXh2jrLg52MbtM8ZaJ69izZd64MgAOFiru3DGw1
Puhv/NRAb5vIqBU/TQ6/cFd9WGc/Kw==
=uGMp
-----END PGP SIGNATURE-----

--FDm01rLVQI5sIA6w--

