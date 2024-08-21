Return-Path: <linux-kselftest+bounces-15803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5323B9591B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 02:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03ED21F22EDD
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 00:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DC64A1D;
	Wed, 21 Aug 2024 00:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kovJu63f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E92C23B1;
	Wed, 21 Aug 2024 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724199578; cv=none; b=bNLFthWNCyQlHcGQPzlN3gEOuLKRMfmjOPh8Ndo1M5ap0YxbDgkMD5+VS/CXF5VdqWb1rVmEj7MC3ibai8Tg7SOFsftICsFITFt6kHj3A/o59REuVuZA/1QwgHs4Cst07+sgselk84k9vVBcnQQXGKTPaqrOlbBOOUerVbIZnp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724199578; c=relaxed/simple;
	bh=EaV2S6nUuW/zJjsBcgYHEPa7d91KBdIgmj9DZyEQnEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qy6KPhh8z8k9WqaotKn55AgilQJOg+Ln8ix9Jk2kmkcSmF22zv3DNKMlkGmWUEAl0fvOTUmwamBj0WeKAxW3OsX0EMrsWtry41+af2n5p+GjNRZEbB2LaRgOFUR6+X7jeshS3YvoJVEo0swgthlv9mgDBrENT+aSaD4AOGwFlj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kovJu63f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DB7C4AF09;
	Wed, 21 Aug 2024 00:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724199577;
	bh=EaV2S6nUuW/zJjsBcgYHEPa7d91KBdIgmj9DZyEQnEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kovJu63ft656FoEemfTqL0KMXmthipNqSW18ftLQwZpJf4EhWalfm1JrICDhWDczq
	 EaX7b2QDbNh7Q/1+p4Eh5JS7TiDWhkCMJFgg74ycwXsE4H2cBi0qTAXgosBwjQBMaD
	 Dg+f4y4cTJxpEBQoOrvYvG35IlRB0LfaRIDDM5IjfH25onjnvM9n744bVEwvrn6uOs
	 X+4KXni217paQskZRlXN8/6xr7zbAihXq62Km1GaBSjmi2Ap9N6UgsLXCMJeZvrFN5
	 wwx6jSOBK6GeDtZZFHJ7lIrMv89IFRg7PIxmvs062lI9yuCcm1TP/weGRHI/0AGvJG
	 /0rB94s0dpQaA==
Date: Wed, 21 Aug 2024 01:19:28 +0100
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"jannh@google.com" <jannh@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"kees@kernel.org" <kees@kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"bsegall@google.com" <bsegall@google.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Message-ID: <5643761f-cc38-4e41-9ddd-f0a1934f8724@sirena.org.uk>
References: <20240819-clone3-shadow-stack-v9-0-962d74f99464@kernel.org>
 <20240819-clone3-shadow-stack-v9-4-962d74f99464@kernel.org>
 <dc8328dbaa01ca7443eeb75024752c673904e3a4.camel@intel.com>
 <cc2e7d86-c890-4cb1-8cad-1cfaa9f53dc8@sirena.org.uk>
 <82be9ec6e43a018add8d9bbc6ba67feee676f32e.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bFuUKleevhkkntrQ"
Content-Disposition: inline
In-Reply-To: <82be9ec6e43a018add8d9bbc6ba67feee676f32e.camel@intel.com>
X-Cookie: You are false data.


--bFuUKleevhkkntrQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 11:57:23PM +0000, Edgecombe, Rick P wrote:
> On Wed, 2024-08-21 at 00:34 +0100, Mark Brown wrote:

> > I was doing things this way for symmetry with how we specify the normal
> > stack.=A0 That's a bit different since the kernel will actually use the
> > size for the normal stack but it felt nicer to keep things looking
> > consistent, it saves users wondering why they work differently.=A0 It's
> > also a bit of a help with portability given that arm64 expects to have a
> > top of stack marker above the token by default while x86 doesn't support
> > that.

> Hmm, so then on arm the kernel would look for the token down a frame. Hmm=
=2E I
> think it makes it even stranger ABI wise.

I think it's going to be strange one way or another, either you specify
a size that we don't currently really use or you have two things both
called stacks which are described differently.  I suppose we could call
a single parameter shadow_stack_pointer?  Though I do note that as you
indicated we've been going for some time and this is the first time it
came up...

> SHADOW_STACK_SET_MARKER can be optional (not on arm, but could be in the
> future). Then the shadow_stack_size to token offset behavior would depend=
 on
> some historical originally supported combination of map_shadow_stack args.

I called it _SET_TOKEN, it's optional on arm64 - we check both potential
locations for the token in clone3().

> BTW, just to try to reduce potential future revisions, what do you think =
about
> the 8 byte alignment need? Did I miss the check somewhere?

I've added a check that both the base address and size are sizeof(void *)
aligned.

--bFuUKleevhkkntrQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbFMpAACgkQJNaLcl1U
h9DU6Qf9F2Dl/fvuQRd2JyJIsu59y4LuFvI86LkK8ckXfpBuzwkrKacoBRJBNILx
JoXi6GbagUmsuIWVGo1mR00Y7PKxfBDTlXAA/dqO1KrZaoxlthcKDdAlVayOO/O3
LuUhVrfJ5li8eEXUVAp4Ozbg33uCOYgHD2TtXvwjOwgf1pDvqAiz7wm4GEuiZMIp
f7k7zEEJU6NvW7pEH5r+g5QGB1eoRs/9KNujV/A8M9HjPzCw+B6BpJqassJJDWtU
9SDkcTZ2BzpsWGzCnlxnNTOBV2uYmy8qcgmL71f83GhxRlSCqI8QdPyPf4nBu3/r
9EF8yCn0lS/HBIvkqzpGG1DK1v8P2g==
=rkA4
-----END PGP SIGNATURE-----

--bFuUKleevhkkntrQ--

