Return-Path: <linux-kselftest+bounces-37068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 134CCB0156E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 10:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180231C46B3A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 08:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04561F8690;
	Fri, 11 Jul 2025 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwJOwzS/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A495A1E9B08;
	Fri, 11 Jul 2025 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752221171; cv=none; b=PIJYXr0PmVp6+bNChEBiWYCx5zX4JLJ9y6dopSLpeUxVqIvuA0xYQvoQMUJVJjVkrJh519qPc00tp8UhqN3nKkH1r8F2daetvQGoBNWn5xozV51bZUgUTPnAjh/F67uOmc9VNeLNRDGTEHMb/bF9M9Rl3MCidCeb82ZZWxu9Q8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752221171; c=relaxed/simple;
	bh=4oK+FupIPs9DGyTuogCpD0d3ZzgXAznS+zlOc49bvSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZXi+0d9/gHib0+iA/SOrnO38UJzW2Pr2dJL7J1JkGRBy6qIjrKXBIjUTIu5NcNuLYTo5GUBfbWUPefWt/zbTZGGvSPNACjWeX44AKTmb4c41LU3k16lEhCShrRlH7GqAVb3jSJf1M3jR+rnoHOkTzmYp/gbUcdiLo7v2ahxn6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwJOwzS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBA8C4CEF6;
	Fri, 11 Jul 2025 08:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752221169;
	bh=4oK+FupIPs9DGyTuogCpD0d3ZzgXAznS+zlOc49bvSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwJOwzS/hTagv8jwRy+p+h4wgxBi2XtcQ8I/MOyvUpbA443xKZelGC2Z13JtbZeam
	 aoaTcBGix9sN1yvpjqB1nns29S0qORUwQBPsJ+5qoHq/pjtj+mTVnuIaXWsLQp4OQu
	 VAzC4vQS3aEDaDpV8M8oSBI5LZ17QNl7FBMSSwCNg2a2fW1GneBhsV4q4no63cyo/o
	 SbKW8allNCYoWLGyUWykcSlDU5sBjLFwo6JkaAE3p54v3O5HWGiyGQv2tYfhkRjZTJ
	 dW0dBo1wbeifttRMSezXhpFalxcb63vUX26/je2jumYE5+vtfQ45crWo1Ky1v+ivX5
	 fBn1sEtjZ8ULg==
Date: Fri, 11 Jul 2025 09:05:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: wang lian <lianux.mm@gmail.com>, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, david@redhat.com, sj@kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, shuah@kernel.org,
	Liam.Howlett@oracle.com, brauner@kernel.org, gkwang@linx-info.com,
	jannh@google.com, p1ucky0923@gmail.com, ryncsn@gmail.com,
	vbabka@suse.cz, zijing.zhang@proton.me
Subject: Re: [PATCH v4] selftests/mm: add process_madvise() tests
Message-ID: <aHDFzeSJlh8caDQX@finisterre.sirena.org.uk>
References: <20250710112249.58722-1-lianux.mm@gmail.com>
 <aG_DPLhtZ5qDuWHY@finisterre.sirena.org.uk>
 <1C943CB7-D63C-41F9-B676-90261E26F049@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j8ge6CSSxSA88wDS"
Content-Disposition: inline
In-Reply-To: <1C943CB7-D63C-41F9-B676-90261E26F049@nvidia.com>
X-Cookie: Do not cut switchbacks.


--j8ge6CSSxSA88wDS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 12:21:36PM -0400, Zi Yan wrote:
> On 10 Jul 2025, at 9:42, Mark Brown wrote:
> > On Thu, Jul 10, 2025 at 07:22:49PM +0800, wang lian wrote:

> >> +#include <linux/pidfd.h>
> >> +#include <linux/uio.h>

> > Does this work without 'make headers_install' for the systems that were
> > affectd by missing headers?  Lorenzo mentioned that we shouldn't depend
> > on that for the mm tests (I'm not enthusiastic about that approach
> > myself, but if it's what mm needs).

> No. =E2=80=9Cmake headers_install=E2=80=9D is still needed. I tried to ge=
t it compiled
> without it but failed. It seems that a lot of files will need to be
> copied to tools/include from =E2=80=9Cmake headers=E2=80=9D.

If you're doing that it should again be a separate patch.  Another
option if it's just a few defines or something is to copy just them into
your program.

--j8ge6CSSxSA88wDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhwxcgACgkQJNaLcl1U
h9Badgf/a2B2bRbAFSTo23HeH3jIpwegv7pKIGbjDJbeb7H4zgaxdGDBImEAsTff
EPKjfpx1/FbAwxBxfWTOjjWcOLjFJpKJKMkQIzeWggBHyLMgIx5PObYFkctOsbQE
dmL+WzAgaXepsyPRnIbFGu58pBm/8MaviS6MgPkmTbaB7x6O/Et7vIj5FfaxWHcG
kwyQoC7CceI48/WhFGkje+PIPlkWLJ587ywb6LH3Vc/6Nb0ztKBGmtfd/ZAVGdhW
sGNwg+DoMo5W1Zcp6ddwJJCBPFx6/yJU3eRz2ko7OOz3UyYnHa073J/AIsg2QaGn
wVCaOOnwBs9W49VhW4v2bSuN7trVmw==
=ZwVv
-----END PGP SIGNATURE-----

--j8ge6CSSxSA88wDS--

