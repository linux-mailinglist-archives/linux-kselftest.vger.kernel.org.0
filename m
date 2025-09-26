Return-Path: <linux-kselftest+bounces-42491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10030BA48D4
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 18:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652E21C05387
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 16:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30212367C5;
	Fri, 26 Sep 2025 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GS6E0EXm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89931823DD;
	Fri, 26 Sep 2025 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902957; cv=none; b=lcOm7S65p9VJLcc/CAl/7dxbVNx/6tKOoahSjM86UzxS/Z/3/4dlFVQ2KeTcc0C7VnH22T9t6ZUK+cnXyKiuxhh2ztWdi4sLVnitEesn4Ou/kW4yq3H2/D7AE5Ua7ppTAOBumvmQqz/s3XkvMar+e5P0sq86wimYirYChcdzJn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902957; c=relaxed/simple;
	bh=vIjK8L0zmx3vzH4+wepEoghbzlgv5uJqUNT8+cEOMRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sl5eIGKP3pxZPf/lhNgoBKN1IDCRfDtED69UjS7ftwC7GZNpz2SeaBxMI7LjUhM9/7vFA2TBa58YCNi02Fs5dcyZYMq6adr/u3+o3YzwqWvmL6pdwuEoXj/QEl1NCH3hRbIzC5hswtukFzsg+BPwLWLj++o2DKQTxn2W1wqqCAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GS6E0EXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD350C4CEF4;
	Fri, 26 Sep 2025 16:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758902957;
	bh=vIjK8L0zmx3vzH4+wepEoghbzlgv5uJqUNT8+cEOMRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GS6E0EXmr6Vld7SgTsA6FsDXzrFcXM4Yi1Aq10B9ivoONfTJAD+oQn55Ab6o7OTdk
	 4MF14UppV3queoLGGMs0YlliihhIJFCM7yLwRQAvUivnBPazOLDz3XhXsDw0EoyBu8
	 LfjN2t0HyCSMSO8I7uXdEjyPIDGLu/8IVAEReVyi+McMCXO2lJ64JmkhcvaMr0aHxe
	 0kKRLwgcqk6k6prx621TO8IsOjicUaSx6WvhusVX66hrawa8z2UTBZoXGlArt6mKEH
	 d98+Gg5z1RTlFQPwQu6YNyYUKrj6gNRM+1pJr33Qd/oVE2ARxEvXfUxEUODVPiTS17
	 Dxj7TrI8u8MhA==
Date: Fri, 26 Sep 2025 17:09:08 +0100
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>,
	"nsz@port70.net" <nsz@port70.net>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"dalias@libc.org" <dalias@libc.org>,
	"jeffxu@google.com" <jeffxu@google.com>,
	"will@kernel.org" <will@kernel.org>,
	"yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"codonell@redhat.com" <codonell@redhat.com>,
	"libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RFC 0/3] arm64/gcs: Allow reuse of user managed shadow
 stacks
Message-ID: <5397025d-7528-4b9c-b38d-b843ab004f47@sirena.org.uk>
References: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
 <760447dc3e5805bf5668e80a94bf32356e2eb2d3.camel@intel.com>
 <8aab0f36-52ad-4fd6-98c3-bcdba45dbe16@sirena.org.uk>
 <ac0ceb09ffaeb1f0925b61ed1b82ee6475df2368.camel@intel.com>
 <604190c7-5931-4e74-a1c9-467e52d3001b@sirena.org.uk>
 <eab692794cbc82080b708c581efd5973b6004be0.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ptvvVk1i1ZxvsU15"
Content-Disposition: inline
In-Reply-To: <eab692794cbc82080b708c581efd5973b6004be0.camel@intel.com>
X-Cookie: Your canceled check is your receipt.


--ptvvVk1i1ZxvsU15
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 26, 2025 at 03:46:26PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2025-09-26 at 01:44 +0100, Mark Brown wrote:

> > I agree it seems clearly better from a security point of view to have
> > writable shadow stacks than none at all, I don't think there's much
> > argument there other than the concerns about the memory consumption
> > and performance tradeoffs.

> IIRC the WRSS equivalent works the same for ARM where you need to use a
> special instruction, right? So we are not talking about full writable

Yes, it's GCSSTR for arm64.

> shadow stacks that could get attacked from any overflow, rather,
> limited spots that have the WRSS (or similar) instruction. In the
> presence of forward edge CFI, we might be able to worry less about
> attackers being able to actually reach it? Still not quite as locked
> down as having it disabled, but maybe not such a huge gap compared to
> the mmap/munmap() stuff that is the alternative we are weighing.

Agreed, as I said it's a definite win still - just not quite as strong.

--ptvvVk1i1ZxvsU15
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjWuqQACgkQJNaLcl1U
h9C0tQf/bJT4tz0mWt/tJVu1pg6AwGbm5/vbqNjvsiVUkegN4TV1NVKgmCA9mnG8
YhPNEYEZ0H8rdL3+zsXN7nFrlzwdh8L/+Kds+ktFeh+86DSA9tAb9v8paIU8Z2Mo
rqW11WJ5+znEADjTcS/dr3Dos9jru2S9z9VOdtNvX7/aaXn5XZEsjPto3ecwL+tl
vFkliUWV/ZgRYV5r5FUBiVldrfHZoUpbe1sL/qPxan+hNnXCteaOhqP4hmO71BHt
18HbfNDN+tswNVbbWCzdi1sUo2/2YJ+ueL0A/rKqL+ns8v9YWThVOJgkSh22Yy6i
Qq1dnnSRhfstXWIi/s4XBmlh6QEwCA==
=sqXy
-----END PGP SIGNATURE-----

--ptvvVk1i1ZxvsU15--

