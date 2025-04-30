Return-Path: <linux-kselftest+bounces-32005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F52AA3FCD
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 02:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFDD13B7891
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D43A41;
	Wed, 30 Apr 2025 00:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW+eklPw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8183D1854;
	Wed, 30 Apr 2025 00:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745974116; cv=none; b=YyfXGRj9prn42ZVYyZA9pLcTHxqJbAXFsq7+We66zAHkk2xk8Cbo2PLfAOnOVliCbywuOC2YrPWfksFPqBSZldP86UOJlPoPGEdKz2FPImb02ahZDifaobgqtXiuaAUiC7gNukAnd43WESh7bI6BCsFbPlsFY9CF/0WJd456Er4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745974116; c=relaxed/simple;
	bh=VVFZTctHxV0J4BThDv/Rh1bu5X7V1E/RSG49b70KuFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3DtYWFeQKH4xNDwAOO0sRec0Bq/ashWMXNPZZOvz+hTmmxecTnAq/sB5+1onviG+PPCyf/WWXmazEX0TEotC34ev1U7JkVC9AAn6+iVMj/Ltj2KCByws719T5YZPLhOyqA4PA50TT8fuEFG0tvx1wM03/N4OP3EcE6SV5ubc9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW+eklPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD11C4CEE3;
	Wed, 30 Apr 2025 00:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745974115;
	bh=VVFZTctHxV0J4BThDv/Rh1bu5X7V1E/RSG49b70KuFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NW+eklPwrSa6qc0ANGDyz5ecCRQIwS8PesnSG7ZB0CPRIM67IQ+chPQENuKAi8zd0
	 Zm0R4pyyTFAJ92d2wvYK8KPthnCFMB4BchhmNBtnzWe8xgtVMFWUGiyoWKvSGNE2Fw
	 ENRTIbvu37efEZw9Qc9JXc3kQFVt9iN7UUm1kJrvcFFzdq6cNsGSE7nkA+c7mr4XpO
	 1Lzs6pVxugKDBfktLfW4aEWSQIThcWbYpdZvOE+/EEUrwFtNI6r3Tq0J9zcYco04Ao
	 uuPddb65DCIMCvzEIGz8vbggqDjU6uZxMsTS6t7v1flq7FdDn5fM4GFDvj9xs+TbRA
	 /7/jj5o1gfZ/A==
Date: Wed, 30 Apr 2025 09:48:31 +0900
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH] KVM: selftests: add test for SVE host corruption
Message-ID: <aBFzXw-ASk1bXQvx@finisterre.sirena.org.uk>
References: <20250417-kvm-selftest-sve-signal-v1-1-6330c2f3da0c@kernel.org>
 <aBDv39FD7eDYoplg@J2N7QTR9R3.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C+U9jvApfUFUi2KB"
Content-Disposition: inline
In-Reply-To: <aBDv39FD7eDYoplg@J2N7QTR9R3.cambridge.arm.com>
X-Cookie: Well begun is half done.


--C+U9jvApfUFUi2KB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 29, 2025 at 04:27:27PM +0100, Mark Rutland wrote:
> On Thu, Apr 17, 2025 at 12:32:49AM +0100, Mark Brown wrote:

> > Signed-off-by: Mark Brown <broonie@kernel.org>

> Looks like my Signed-off-by got dropped by accident; it should be above
> yours here.

> Aside from that, and the initial feature test, this looks pretty much
> identical to my original WIP.

Sorry, for a while I had a version of the program that was a lot more
modified (I was trying to make it work with a wider range of supervised
programs) so it didn't feel right to carry your SoB forward, but those
didn't actually go all the way to working enough to enable any of the
additional programs I was looking at so I ended up unwinding them and
didn't also unwind that change.

> I'm not sure if it's worth keeping all the printf() calls, which were
> only there to help me check the UDF trap was being handled correctly.

I've found them handy when using it.

--C+U9jvApfUFUi2KB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgRc10ACgkQJNaLcl1U
h9AtJAf+MbIe0znLqzLeaZE59FpZ7imkJVYN6BNayn6dR6KSH0ba5TR2bJ6BOB+F
420HSoFS7860BB8M5gF1SYpt0BfhiwjXrCFEBjh/CI4n7XhIJKgWodPjFsSN4hIA
scNzDwbQ8TSF6N2BV/Wqa1y6SX2qE6HcSEsS3kiIn8dcPFXWKwxMAypCXPJpVF6p
SfQKTaqgkOkQBHW4TrPMbA20jdgLgGnYfGtB77/1VgTWfqaULkOc16bYSPVTYvu7
DXXhpzMrMwzCLSPIS9t9c3IZDSQKyeyk5SM2O17y5moR2ymnTSBRtR9aA1IQh+AJ
D/dD4tw21AQDTCp5d5zWoqSLzmIeyg==
=V8X6
-----END PGP SIGNATURE-----

--C+U9jvApfUFUi2KB--

