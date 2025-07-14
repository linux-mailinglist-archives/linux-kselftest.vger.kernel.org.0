Return-Path: <linux-kselftest+bounces-37254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E18A2B0405C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 15:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C808618838F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 13:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D991524A066;
	Mon, 14 Jul 2025 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzRZpbkK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09201F91C7;
	Mon, 14 Jul 2025 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500407; cv=none; b=sMa/GL+rUL1pXReWkoQuOxMQ+MqlxZHT3c1hYbmc8SYspRaLR9KP8mYvd+RbE0wQipF/sknMuUp0dZqXqUrXXkt5u2VSTR6csX2OAjv9r8939qXr4F050jw91vD4RvhJhExAGyR1CGarMyNGOLgqBYIv4Tm9Z2EPawarOdHhoOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500407; c=relaxed/simple;
	bh=dea+tmBeWqB+yG7LfH3kFCnhPvkRqdYPOZzN+qCQA0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBiSuopKv4yIga2kIit6SpbHl1pwgrA2vcsO/D8sI7XR9k1TMuGWGQknTxwcGnAMv2JxG+4e2U5iDaXGIfxi6Hn2mL4UK5qVtvrSHnOxFCOsYqquYT/cG1lvoJEWxdCB6nqL2CtHbVDCnTXy8lm9k6aH18LttwASKbXqboYgJuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzRZpbkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC95C4CEF0;
	Mon, 14 Jul 2025 13:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752500406;
	bh=dea+tmBeWqB+yG7LfH3kFCnhPvkRqdYPOZzN+qCQA0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZzRZpbkKdoqDZrBghSEyLjO9qVHKNo6Wd/vTIR8iVb2lN7OpSGdF6MEb3TLCP5e2j
	 qrROrJTszTtnTK1zEFwadxRxsKC0sHs1STpX2X+7+5v/6eFyMsGlxM0k+UZFkwMYvj
	 b+HURDsF8P56gmOTGVMx+2oSelH9yFH6RV8p6l+ztH7iGdi1jTeA7L4KPLAmdHubvQ
	 fdduTknny41l+OXITL0S9xIxtWzxE1zrNEk/YTEsvqiVpqycFnad7s4wKj443opYRL
	 Fy+eTneiV1RXey/ZaNnLc983NULzhz2KfsdRyCPCS30frne2vq73Ow/F9yuPC0bJs4
	 Di9FGjsmOgqlw==
Date: Mon, 14 Jul 2025 14:39:59 +0100
From: Mark Brown <broonie@kernel.org>
To: wang lian <lianux.mm@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>, SeongJae Park <sj@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Liam Howlett <Liam.Howlett@oracle.com>,
	Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	gkwang <gkwang@linx-info.com>, p1ucky0923 <p1ucky0923@gmail.com>,
	ryncsn <ryncsn@gmail.com>,
	"zijing . zhang" <zijing.zhang@proton.me>,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] selftests/mm: refactor common code and improve test
 skipping in guard_region
Message-ID: <a3457ab8-8bb7-4a43-913e-2eb73149ff20@sirena.org.uk>
References: <20250714130009.14581-1-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mG9YY/Tnfrcf5Rq7"
Content-Disposition: inline
In-Reply-To: <20250714130009.14581-1-lianux.mm@gmail.com>
X-Cookie: Non-sequiturs make me eat lampshades.


--mG9YY/Tnfrcf5Rq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 09:00:09PM +0800, wang lian wrote:

> Move the generic `FORCE_READ` macro from `guard-regions.c` to the shared
> `vm_util.h` header to promote code reuse.
>=20
> In `guard-regions.c`, replace `ksft_exit_skip()` with the `SKIP()` macro
> to ensure only the current test is skipped on permission failure, instead
> of terminating the entire test binary.

These two changes look fine but they're not really related so should be
separate patches.  Looking briefly at guard-regions.c I see a bunch more
use of ksft_exit_ functions that ought to be fixed as well, but your fix
is good.

--mG9YY/Tnfrcf5Rq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmh1CK8ACgkQJNaLcl1U
h9Bffgf/e6P7d065l3tVXplIfDmfI6m7r7Q+rxjsoMJt/PqR/EClhsrfnTC5ZSv/
XpnWdUv4e8cz/8J65Xi7aHZVgU4TcaFzC3y9sTTBpzpk/54SaTwZERILkA/Em795
f7OuLDasvYV+IRubq8StUNtzE6qgeDjckqstXsZzidvgAKuWT1DZCFlg+c+diNsI
nieqQaAi4PXwYtvHfFzsyn8Kg9p35KswyN509wXmtWzcDyRwhKh9PcqDGKuIxho3
k6pLEmdGVvfN+AZa528BXRMds0ia8ayI+/Rx043G+UbA8mUXBcWYsTv73sTCp051
alrl49LiqM1Kw1WO6QDNiKjr8Yckbg==
=lgx0
-----END PGP SIGNATURE-----

--mG9YY/Tnfrcf5Rq7--

