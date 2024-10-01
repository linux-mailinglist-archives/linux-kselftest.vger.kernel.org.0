Return-Path: <linux-kselftest+bounces-18803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 973D098C4A5
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 19:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458811F25789
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 17:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429C11CC8A6;
	Tue,  1 Oct 2024 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vl4xZL6Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A7C1CC15B;
	Tue,  1 Oct 2024 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727804003; cv=none; b=mJv1xuKo51WByTuDT4RI8wQ3e0VQgiJ+hs5fDABeT1F5aTC6hf5dq86wjELF8Yrm4oy3nupWW+g3b7wSPOqA1k+nxkV1qBbV32jNLhDHbNrOqSlb1O08iMtgcGyRrK3yqHYxtvLEkBfXPsPRG8mFWeZl28HiQBXs3aVM4wfXNqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727804003; c=relaxed/simple;
	bh=prDur8m2vd+I3bZCB3BSpi/S83VkG6ayAgQVvfgOpWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9xt6hNb5vL9cY/nN+TJ9E6dv64lO7TTU3vdA/nFOCgksEg96Ea0H57HE9kw4veri9pOYQhoByan7oqCNsEEN21MpupyOWtAgGGjEfTeKp8s6tLEmzM/YvxskjgrC5i88rkB1/wywLNfKmPkL4LuaaOmqZPBH2LFcD6oxgAR6+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vl4xZL6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C96C4CEC6;
	Tue,  1 Oct 2024 17:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727804002;
	bh=prDur8m2vd+I3bZCB3BSpi/S83VkG6ayAgQVvfgOpWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vl4xZL6YY2Dae9PlED3ufSGitTd1p2Z0N5zYmFWfHiwR/lXhaP0C903fl0oURIT3K
	 tDj5vOligYpmrbdAYDDqKj2nUm8Cf0Pz7E8cDhGvjhDnTyh4s6sFO/p5GrfFNPXUv/
	 u6KUS8MVirPOvcimQUBMMvgDTMTXMOy3cpVjFiITZp52b5FZJpc51pLmyv7apALkr0
	 IVxsw1MXfpa1U86lqAGko43eBb+CJNNgMQkdMOyP24R9uopQOEXsvVf0II0wrStoJr
	 25ktGQgkFpfufClnjsX2BT2THDD/1+ic3SJsZzS+NJyTnAYibCe/Uecdr4uM+yegis
	 IqKQ6dOENudmQ==
Date: Tue, 1 Oct 2024 18:33:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Florian Weimer <fweimer@redhat.com>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"kees@kernel.org" <kees@kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"jannh@google.com" <jannh@google.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"bsegall@google.com" <bsegall@google.com>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Message-ID: <6bf15851-03fe-40cd-b95c-f7e2ca40ac54@sirena.org.uk>
References: <cc2e7d86-c890-4cb1-8cad-1cfaa9f53dc8@sirena.org.uk>
 <82be9ec6e43a018add8d9bbc6ba67feee676f32e.camel@intel.com>
 <5643761f-cc38-4e41-9ddd-f0a1934f8724@sirena.org.uk>
 <9f022aa4cd3e2dc82d0c963e9d2bf5c7ddd5b92a.camel@intel.com>
 <77bc051d-b2c9-4e3a-b956-be8879048e20@sirena.org.uk>
 <5464b915b52bf3b91ec70201736479a5347838af.camel@intel.com>
 <158190d9-a4a6-4647-84e8-f4ae036d984b@sirena.org.uk>
 <20240927-springen-fortpflanzen-34a303373088@brauner>
 <727524e9109022632250ab0485f5ecc1c1900092.camel@intel.com>
 <20241001-atheismus-stetig-4f6f3001715c@brauner>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BRHYL8Lzq6CYUNzt"
Content-Disposition: inline
In-Reply-To: <20241001-atheismus-stetig-4f6f3001715c@brauner>
X-Cookie: Even a hawk is an eagle among crows.


--BRHYL8Lzq6CYUNzt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2024 at 05:12:38PM +0200, Christian Brauner wrote:
> On Fri, Sep 27, 2024 at 03:21:59PM GMT, Edgecombe, Rick P wrote:

> > Did you catch that a token can be at a different offsets location on th=
e stack
> > depending on args passed to map_shadow_stack? So userspace will need so=
mething
> > like the code above, but that adjusts the 'shadow_stack_size' such that=
 the
> > kernel looks for the token in the right place. It will be even weirder =
if
> > someone uses clone3 to switch to a stack that has already been used, an=
d pivoted
> > off of, such that a token was left in the middle of the stack. In that =
case
> > userspace would have to come up with args disconnected from the actual =
size of
> > the shadow stack such that the kernel would be cajoled into looking for=
 the
> > token in the right place.
> >=20
> > A shadow stack size is more symmetric on the surface, but I'm not sure =
it will
> > be easier for userspace to handle. So I think we should just have a poi=
nter to
> > the token. But it will be a usable implementation either way.

My suspicion would be that if we're doing the pivot to a previously used
shadow stack we'd also be pivoting the regular stack along with it which
would face similar issues with having an unusual method for specifying
the stack top so I don't know how much we're really winning.  Like we
both keep saying either of the interfaces works though, it's just a
taste question with both having downsides.

> Maybe it's best to let glibc folks decide what is better/more ergonomic f=
or them.

The relevant people are on the thread I think. =20

I've rebased onto v6.12-rc1, assuming I don't notice anything horrible
in testing I'll post that with the ABI unchanged for now.

--BRHYL8Lzq6CYUNzt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmb8MlkACgkQJNaLcl1U
h9AoNQf+Jkavle4N/yks/qB+Ufu+4UFkdBffqruCufymGzobEFRaeKJvJJAKtfka
wz/fgNd8tiTpVq0SlpdFyG9UumI6HQBCcgQBBnO32/rOct21Lt5WQnEMDTj+PXB+
8n8HkvNnzGKFPsfPZ7iavCVRiBFQpQYQKOWLWWG76ZQcAhvVz/OZyXLOV7NoGCwx
mmQu+825ZeRg07YrPqF/8DhAeBSYYxLgEUly9H1R7hhj90lTKyup7nUJCmGPgxR6
FgewpWMk1Lmhf4jS70PMXEEapT/ergA8BvqrhuTRftD6cj26G5kg1vIcAZ0ohqar
4HHk4ioCgvzeAywd9/wEltOUrJVDsg==
=4Sah
-----END PGP SIGNATURE-----

--BRHYL8Lzq6CYUNzt--

