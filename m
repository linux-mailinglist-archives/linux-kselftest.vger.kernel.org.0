Return-Path: <linux-kselftest+bounces-35964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB049AEB58B
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 12:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00A93A5C14
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 10:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69F029992E;
	Fri, 27 Jun 2025 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fj360n+b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D087224893;
	Fri, 27 Jun 2025 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021738; cv=none; b=r0AUviF/TONEWY5B6+1WXCytH0lbLqihVxhdOhs55LdflaT/1DKkOrAlSE3rtDK3cutpC0KKDn4+NCu5frfMBi+3jwLD/tLxXhyLdHKro922sik4Tm9gQrUBxc4a26GKC7AxF2rU3V/aHP/uHEqVT5MZx3SOodltR32wfi6nAjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021738; c=relaxed/simple;
	bh=w8uGM8V3BeOaxaupPf60FQSG2Cnb6F/+ZSO18HXNtkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJeTC5dS56OCuCxu5/Cvcdg6gEmmv6eWoui5xuby8C/DJx57um7ptW96FQbbUYmARMV++KGOKSLKrf1pdxqo9C0g6cS9i5SSi3g1SXSsdqV63eNL7/Eq+ibmPfKglU/mbF5EWjW0v2VSelvp9VU/Jo9gqaFlJqOKPAZuDIUGgpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fj360n+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB677C4CEE3;
	Fri, 27 Jun 2025 10:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751021738;
	bh=w8uGM8V3BeOaxaupPf60FQSG2Cnb6F/+ZSO18HXNtkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fj360n+blrE4iYL1vzNpEIzzok3rcXkLm2AN1scyQgysvlldpZEhZHz9kA9cud+rM
	 AYJulATI+pF8PxE1Xce9WqZiS6v2SnyOrJ60B25q3bSU0iBQg5jfDiVQnRm1QdXZmM
	 X7ibljFytuz/nrxp9j9HodGkOSUks8ovvY1kKYQ7jwBwugNuuzec9nGQkvgqeShwfz
	 qQ0NcGnoeycpOX6wjlauz/8FFfxHk42dRhSua98b8+t4idIktSr9Wge6Twg8NQ0jjX
	 ZpFOxChEOHm29VEUyu0GsfpupQtBL70UERgF8DxIyDCGPDWRPjeDdIt9F46tHoHqsD
	 xxprjRGnLyAog==
Date: Fri, 27 Jun 2025 11:55:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/arm64: Prevent build warnings from
 -Wmaybe-uninitialized
Message-ID: <aF54phWq1IGlaphz@finisterre.sirena.org.uk>
References: <20250625020138.3777454-1-anshuman.khandual@arm.com>
 <dd3dee5a-b030-4658-8cef-c777928368d4@sirena.org.uk>
 <af5cbd48-6312-481d-8e91-7739612493c1@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0uBnPjIGKotRgbPj"
Content-Disposition: inline
In-Reply-To: <af5cbd48-6312-481d-8e91-7739612493c1@arm.com>
X-Cookie: Do not cut switchbacks.


--0uBnPjIGKotRgbPj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 04:15:09PM +0530, Anshuman Khandual wrote:
> On 25/06/25 3:54 PM, Mark Brown wrote:

> >> -	int status;
> >> +	int status =3D 0;

> > This will shut the warnings up, but it's a bit of a heavy hammer that
> > means that the warning can never trigger warnings for that variable
> > being unused.  Is it possible to fix this by updating the control flow
> > such that the compiler can tell that the initialisation follows the use?

> The problem might not exist in reality. In the test function test_fork()
> in the file tools/testing/selftests/arm64/gcs/basic-gcs.c there does not
> seem to be a path where WIFEXITED(status) might get called when 'status'
> has not been initialized as there is a preceding waitpid() which would
> ensure 'status' gets set. Similar scenarios are present in fork_test_c()
> and write_fork_read() as well.=20

Yes, it's a fairly common false positive pattern (in this case it'll be
that the compiler can't understand the constraints with pulling things
out of the exit status).

> But the compiler still throws these build warnings. Seems to be false
> positives and this fix just works around that.

Right, the problem is that it works around it with a big hammer that
just shuts the warning up completely meaning that if we do cause issues
in the future then the compiler won't be able to tell us about them.  It
would be better to suppess it by changing the control flow such that the
compiler can follow it.

--0uBnPjIGKotRgbPj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmheeKAACgkQJNaLcl1U
h9BoAAf/cLJ4iO8ZRetLgVRyylvU3LbHGcwMSRactvuK8r9ThRrcNDQIDZWvFoVe
+QensBvEaIO8IrQCbE0FpKQrE199O7hwkT3Lv56V2uMNlXCm8B+Usm+iPLdn8nRO
8GgVuezQqAJxkjfUA1LBcmblqVikDLtnIGT863TEqd4Wexnliei+Xd/jL5WJJis6
s1qr7wo83A2RIuMPNPzdEJMiwhkSNRQbenLCXeXiNt754TyQBTnw8BhGf4Uyy6E0
0sNtuHLmxtxiFqSXJQPDotg04tyrJinM6GlHDjHmRlyDopBKRSaQTZwQHclas/oK
0klJ3MGVJSlx89Bj/Wyfucqhm6ZEsQ==
=/LTI
-----END PGP SIGNATURE-----

--0uBnPjIGKotRgbPj--

