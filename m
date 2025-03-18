Return-Path: <linux-kselftest+bounces-29360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1DBA67754
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 16:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547A33AFF38
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 15:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689AF20E021;
	Tue, 18 Mar 2025 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lvp1rCis"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1FD28FD;
	Tue, 18 Mar 2025 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310698; cv=none; b=XppWbDG6RtM7cNRt6wvfLLDtSpAYI8hDiopLX/NKgoIu4N/+fYxdxIABsYF6bvkAM3ZJf9mawlctF/5LjY42o6tuKJeQMuh5UO7zzPHBHARY+wbx8URsm6Eo4f36n4JD/sFc0xHIaxa9YI7nSvrcPKcQtSRIfdykc+2NAiA6yPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310698; c=relaxed/simple;
	bh=KUkSvOZPi88r/XTZ0pYSCa0BreGnfE2/PMqS/RwsBWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8PD9CaHepXilCWaPD6lgkNmA83/5QAsNXO7U+5H9ussI7exQeDjSmwZpnuhdrfa3HRzwpObGNk47qFKJHBJZm2s/28Naiatbx2pzjKmRBQett2wAJ/iyRTOtWUpZ9vUs+kMtf1Eod3w5V4hl5PS5Exnacf3hcJ0/LTg/uUSWcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lvp1rCis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECCFC4CEDD;
	Tue, 18 Mar 2025 15:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742310697;
	bh=KUkSvOZPi88r/XTZ0pYSCa0BreGnfE2/PMqS/RwsBWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lvp1rCisGL3+VJsnjPSY68vrXDu8MEkC6MMXlw1DMYNJu1mIhbfj8RuL/t1z60f1O
	 hSm0Uu0o4+0uaaQnd6WpUsgIJBVYjaCvSF22FvU/Lh7QsJ6FPx3xSnPZ3msaA1npOb
	 U7QctlvQ4UpP37AX0E6ThxOVPDk1K146O/Csi4HXcgeOt0doflAOdW9zRoTF+VEX8K
	 F5ajEZQdHbzEFJAoD9wubjsYz4zpUlwWh/7To9SFLVD5MBHZQWq9oGu8UibbJZJlgY
	 IW/CHCFi1DPIradVuyje345SvEHPw2GcKaKG8V9WQV1dEbY/YVRG2RFkBvw8PU48Sb
	 uOTIkGjWO+deQ==
Date: Tue, 18 Mar 2025 15:11:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, Aishwarya.TCV@arm.com,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] rseq/selftests: ensure the rseq abi TLS is actually 1024
 bytes
Message-ID: <85de6b23-5c15-4651-8604-75ce6473ff08@sirena.org.uk>
References: <20250311192222.323453-1-mjeanson@efficios.com>
 <78518446-083c-4db1-8c96-61fd49eddd8e@sirena.org.uk>
 <f61ded41-b1b8-4d0b-aff0-df7e0f5bab0d@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PL2XKkQY/yXWwUMt"
Content-Disposition: inline
In-Reply-To: <f61ded41-b1b8-4d0b-aff0-df7e0f5bab0d@efficios.com>
X-Cookie: Swim at your own risk.


--PL2XKkQY/yXWwUMt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 10:50:58AM -0400, Michael Jeanson wrote:
> On 2025-03-18 10:01, Mark Brown wrote:
> > On Tue, Mar 11, 2025 at 03:21:45PM -0400, Michael Jeanson wrote:
> >=20
> > > Adding the aligned(1024) attribute to the definition of __rseq_abi did
> > > not increase its size to 1024, for this attribute to impact the size =
of
> > > __rseq_abi it would need to be added to the declaration of 'struct
> > > rseq_abi'. We only want to increase the size of the TLS allocation to
> > > ensure registration will succeed with future extended ABI. Use a union
> > > with a dummy member to ensure we allocate 1024 bytes.

> > This is in today's -next and breaks the build of the KVM selftests:

=2E..

> > since unlike the rseq tests the KVM rseq test includes the UAPI header
> > for rseq which the padded union conflicts with.

> Oh, I missed that, we need a more unique name for the union.

> I'm unfamiliar with the workflow of linux-next, should I send a V2 of the
> current patch, or a new one that applies on top?

It depends on the tree that the patch was applied to - -next merges the
current stat of the maintainer trees daily rather than applying anything
itself.  In this case that's -tip, I think incremental is good for them
but ICBW?

--PL2XKkQY/yXWwUMt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfZjSMACgkQJNaLcl1U
h9DPmgf+OZwGLMY89YPeWmlq5p/J3WEOBChjcahyQIpHAbOt8KQgRPF+DQmTn9H/
N+iRyJg0GCUgBAb8R1QSLHNjK/dYCuNYHKSuVzj+PERiTmif2dqqS0I6qLVzR0nl
qdAHS+aYWQ3HqKJTO6EQJqSLhWJduch73Uyc+D2APdcFJ4iawMwchUEA6tCMhTFa
oHcQZ98BtPDfdx2Vo++3OG4ERD6fCO3aYMEw5K60vT1C8b1imwCWdprsqVBW3a6g
J4Cr42LuXFqdqSByLgNNQpJmMQUGBpp59i1bwz2yM0Y7cTik3K7RjV8Dgm2mprUB
xG/CwgJ0Q1Sgzyle7HLnwsD/p3/UjA==
=i+sG
-----END PGP SIGNATURE-----

--PL2XKkQY/yXWwUMt--

