Return-Path: <linux-kselftest+bounces-15800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2043A95913D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 01:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A021F22954
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 23:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B701C8236;
	Tue, 20 Aug 2024 23:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/aaS2cZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0509A14D2A3;
	Tue, 20 Aug 2024 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724196889; cv=none; b=BjB7ZTHFyy+W5pgyNkT/JQstXm1+OsaEMdOrLjezvWBfIvrLRbGJwDrw/yWOQxza3MXpj0o1fvUQyNHp0AyZeZDBC0r/Qdn5JOVzH5b3BYSyj3RTLfZB4rwFK+vRHOHKVQg4yGlBrxEDkeyRrT1bf0i2MKFA4fXA19SPd7yiSv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724196889; c=relaxed/simple;
	bh=PcNdyNdFFi34n7JOK7s+4Yo4lP/cjn0tlDF4eIIRgkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvVT50K1rKK+6L7RnnybNNXmmywksvwd0hn9OTxVEoX60HkTnaO0VYnFl1/snORHlPsH5ocxzXtDhZoVrpPcA6Q6oOqQs25xS67ykkYg2mKSVA1cLpwGoYwYQr4v7KGmCv8GqYm8CRm5joxkA7VXgKZWMEmA4whdYqstsNQW5j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/aaS2cZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDAFC4AF09;
	Tue, 20 Aug 2024 23:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724196888;
	bh=PcNdyNdFFi34n7JOK7s+4Yo4lP/cjn0tlDF4eIIRgkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D/aaS2cZKCAd730aL3vyN8a5SOmmHiA3Z/NGOd0WY89GaQQbpZQD5O7y+J1m3lgXO
	 et2giW3ZzhT137qsaZrIbXyD7dsuYteHZQ0TMW/AMzWhfxvXAb5AMm/V+h+G2IWyRm
	 5GmmyvN4+JOzk+sPSf34ZkeXF9X+pzG0ez4D06OdyCFoX80Xe6arWORKDM4qDsSe2F
	 iQsV0/Fb7iKlRiXptBFa0r4mhFy8R71X2XfMDgPQg3jnsPuH9ZNLUXcmWFcCIluUpu
	 J27QBP/jQ424qRGC8zvdrTxtW23q+ClBgVVmAViVE6Gs32HMvRLK6ueXwqEvV4aZAU
	 E209QzqoFpspQ==
Date: Wed, 21 Aug 2024 00:34:39 +0100
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"bsegall@google.com" <bsegall@google.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"jannh@google.com" <jannh@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"kees@kernel.org" <kees@kernel.org>
Subject: Re: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Message-ID: <cc2e7d86-c890-4cb1-8cad-1cfaa9f53dc8@sirena.org.uk>
References: <20240819-clone3-shadow-stack-v9-0-962d74f99464@kernel.org>
 <20240819-clone3-shadow-stack-v9-4-962d74f99464@kernel.org>
 <dc8328dbaa01ca7443eeb75024752c673904e3a4.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DPkc7CrQVQ11KFQF"
Content-Disposition: inline
In-Reply-To: <dc8328dbaa01ca7443eeb75024752c673904e3a4.camel@intel.com>
X-Cookie: You are false data.


--DPkc7CrQVQ11KFQF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 09:36:46PM +0000, Edgecombe, Rick P wrote:
> On Mon, 2024-08-19 at 20:24 +0100, Mark Brown wrote:

> > +=A0=A0=A0=A0=A0=A0=A0/* This should really be an atomic cmpxchg.=A0 It=
 is not. */
> > +=A0=A0=A0=A0=A0=A0=A0copy_from_user_page(vma, page, addr, &val, maddr =
+ offset,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 sizeof(val));

> Were so close to the real cmpxchg at this point. I took a shot at it with=
 the
> diff at the end. I'm not sure if it might need some of the instrumentation
> calls.

Great - I hadn't been sure if there was any fun with access from kernel
mode on x86.  I can't get that patch to apply cleanly FWIW:

patching file arch/x86/kernel/shstk.c
Hunk #1 FAILED at 204.
patch: **** malformed patch at line 24: offset),

I think I got everything integrated correctly, I should have a version
with that folded in out tomorrow.

> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (val !=3D expected)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return false;

> Return false for an int will be 0 (i.e. success). I think it might be cov=
ering
> up a bug. The gup happens to args->shadow_stack + args->shadow_stack_size=
 - 1
> (the size inclusive). But the copy happens at the size exclusive.

Ah, yeah, thanks for noticing - that's cut'n'paste from the arm64 code
where the token check is in a separate function.

> > +=A0=A0=A0=A0=A0=A0=A0if (!(vma->vm_flags & VM_SHADOW_STACK)) {

> Can we check VM_WRITE here too? At least on x86, shadow stacks can be
> mprotect()ed as read-only. The reason for this before I think fell out of=
 the
> implementation details, but all the same it would be nice be consistent. =
Then it
> should behave identically to a real shadow stack access.

Seems reasonable.

> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (kargs->shadow_stack_s=
ize < SHADOW_STACK_SIZE_MIN)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0r=
eturn false;

> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (kargs->shadow_stack_s=
ize > rlimit(RLIMIT_STACK))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0r=
eturn false;

> At the risk of asking a stupid question or one that I should have asked a=
 long
> time ago...
>=20
> Why do we need both shadow_stack and shadow_stack_size? We are basically =
asking
> it to consume a token at a pointer and have userspace manage the shadow s=
tack
> itself. So why does the kernel care what size it is? Couldn't we just have
> 'shadow_stack' have that mean consume a token here.

I was doing things this way for symmetry with how we specify the normal
stack.  That's a bit different since the kernel will actually use the
size for the normal stack but it felt nicer to keep things looking
consistent, it saves users wondering why they work differently.  It's
also a bit of a help with portability given that arm64 expects to have a
top of stack marker above the token by default while x86 doesn't support
that.

--DPkc7CrQVQ11KFQF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbFKA8ACgkQJNaLcl1U
h9DPpAf9F6wdWXEyFxD6xmJTNedWyU2aW6YSOs533kCg8s87GG0+dM+09tyahTtp
ctEiO3vjSOYKTpPUhfDULeudsrkR3odg3Er5u6bX6fGOpZTmnGjVLnbIIxpmqyL7
2BUCIZzU7e+WLIViis+ZpR/ikf4HFEBWZc8OTo4QQDuwuyb7Wlx4X4t3L+I4kV96
e/ihKKcRSyszo+nAyuOsqkA1VLmdDGTQN/vmgHGgxI7AnHE2HPx/fTe2rv/F40D8
L/aB4bB5G8FhfqPYP4mD7U+1KonWYNFaq2R6rTRU9kVHvY8wddL6LnumTPh/9I0Y
xQG0GPU76l0pPjuz0MtbHu+4z3oYIQ==
=lfMN
-----END PGP SIGNATURE-----

--DPkc7CrQVQ11KFQF--

