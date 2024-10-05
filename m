Return-Path: <linux-kselftest+bounces-19114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2991D991756
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 16:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F008F28234E
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 14:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1504915350B;
	Sat,  5 Oct 2024 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fg1xKSC4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D897B14F9FD;
	Sat,  5 Oct 2024 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728138403; cv=none; b=s8P8ciChjPoJ5FcpXZJUGXXy8PNgb/NwMuDq9HkQMJqdjHwq54f29+qQV7e+u7d8A08z9r+wFqcKdo69rYl66xw52bCxNXSNRj6/uNfGciLDnpHd4mYg1i+zc/S9kTCMc9lBCQfUKHSXtuE+SFz+NujOAwKbvfJVsnV+863ircw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728138403; c=relaxed/simple;
	bh=Ui4f67bI5qg3mi7Kvi866nZtpXF6pIbWLLz9Q6eVGHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kvf7q2f+tQNwJWNqKoOVKsQTT22B+dRXAjMYoWg4GMx9T5K1FwFiiJexT4Ch+w/rYGjJwNUE6AOs4vsgez62IjK3KW8sIgfu2qYQcw3ZPvg0xTUn5bxrk1oK+jub8GTYoriLHBXaJd6jWLdN0mSQ+IPe3+aAwhjBuXFK4FNh+Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fg1xKSC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4611C4CEC2;
	Sat,  5 Oct 2024 14:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728138402;
	bh=Ui4f67bI5qg3mi7Kvi866nZtpXF6pIbWLLz9Q6eVGHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fg1xKSC4NhQ2aMtpoW4HUSL5Vl676upIYulOZ4Fef+MgwhRcnKSuTAVZof5tRXaeu
	 Q1tRRcqw8kz/1RRX6iguuHP7EAr5b+V8uKvCbfTELTHEoSwbv3xIUd7KBX+3m88B4M
	 iP8JUr/BcQ/zUWo8EgoyBTR37/9pxu3ALsoy/OGKRDWvnJxcSx9jja30QqG2/yrELj
	 5GPLmDNUqsz0LXuX6gebtF0rkOkOWdBLpI1QAFMCjtE9fQ5bqovIzHn1m+N0J4nt2X
	 rGtymCRknCVu5PXVp9JVhf8S/D+1Wxzqx8AfXgxB3BJuy2atPS/uqx4c3Dorsskiwx
	 MZNHK7rfCoaEQ==
Date: Sat, 5 Oct 2024 15:26:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 3/5] KVM: arm64: Manage GCS access and registers for
 guests
Message-ID: <ZwFMnhXGV_Nj31tE@finisterre.sirena.org.uk>
References: <20241005-arm64-gcs-v14-0-59060cd6092b@kernel.org>
 <20241005-arm64-gcs-v14-3-59060cd6092b@kernel.org>
 <87iku6vl4z.wl-maz@kernel.org>
 <ZwE6V9cqf7jD1rTc@finisterre.sirena.org.uk>
 <87frpavgam.wl-maz@kernel.org>
 <ZwFDmaeIgPKfmJnj@finisterre.sirena.org.uk>
 <87ed4uveam.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0QqCvw04ekMR8TQf"
Content-Disposition: inline
In-Reply-To: <87ed4uveam.wl-maz@kernel.org>
X-Cookie: Editing is a rewording activity.


--0QqCvw04ekMR8TQf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 05, 2024 at 03:02:09PM +0100, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > Ah, I see.  I'd been under the impression that the generic machinery was
> > supposed to handle this already using the descriptions in
> > emulate-nested.c and we only needed handlers for more specific actions.

> From that very file:

> /*
>  * Map encoding to trap bits for exception reported with EC=0x18.
>  [...]
>  */

> Everything else needs special handling.

I see.  I had noticed that comment on that table but I didn't register
that the comment wound up applying to the whole file rather than being
about a specific part of the handling.  I'm a bit confused about how
things like the SVE traps I mentioned work here...

--0QqCvw04ekMR8TQf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcBTJ0ACgkQJNaLcl1U
h9Azkwf9Gwwz8q60Dh76qqd4muskEMs0WrsOk2sjTbP0N9yru800k7prO0c64TB/
Z7UDAB61rUrfEkkEcm9ayiykXFNs/H0woh0TNP1M2HbEB15kA8qb9NKHn7FTFcdV
epJQws8/O3LLS4pJhucvGAVBW6GOJFlS2PeMrdDMP/FOQZd8llvFR3GmNvymZvj8
Wxm3++GdLgRcjQOMQBYrd6JhhGocA2Jgqx1y1UCqLwCPKM5Fb9GxxE4jTvI2y4n7
Lz0iAMzBbT79mz8gnmKySCYs05njCTU0tvjmhyi8sRud+g8PtxPnV8zXQNNolZoq
cB4ulzZIgiR74MYruWwPS+Iioc1FdQ==
=FMDR
-----END PGP SIGNATURE-----

--0QqCvw04ekMR8TQf--

