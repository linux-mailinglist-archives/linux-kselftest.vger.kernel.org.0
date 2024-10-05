Return-Path: <linux-kselftest+bounces-19107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC7D9916AA
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 14:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61CA1F22B5A
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 12:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABFE14B94B;
	Sat,  5 Oct 2024 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YknrkGmm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDAF82D91;
	Sat,  5 Oct 2024 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728130215; cv=none; b=ACo5GkEzHIQZGqcg1gvSSIqJ9rw+7xrNnFMa9lutmyobadR7W+2V8dTYRkyyKHQZJMd8zWPtOSYnRrw8K4u94bnZznlJP/zX2/G31+/j1n0GQpe5liToOY5IYlsUUGk646gY6MgofufHXX2QF86DDtW9ORw+ByIx6qFqGQYtnQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728130215; c=relaxed/simple;
	bh=k7JwcDVnbEixpxAlYkqVh+O0lGDuWqZnz+mr8iDxfkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iypFimDJ3krHSEr77oDAq6R2/gMpM4wmpbPkEul3v8A2NsTRW/VPBruZ6NWeYkuly5wIprPjzvDcE7eG4ArL7klHTf6rCwJhtkuu0nzE1VH1lsIyaMHsz3jb3qd0d4SaE6Q9GbUuVs61LNyy9BV4tUHojNIoiZqWhYMCXRVjYL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YknrkGmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A321EC4CEC2;
	Sat,  5 Oct 2024 12:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728130215;
	bh=k7JwcDVnbEixpxAlYkqVh+O0lGDuWqZnz+mr8iDxfkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YknrkGmmpkbdrE3Lt6C/pKy7y9GK9dW2SZx+XuOkXtOU2RSEwUReh4JeuVvin+kpu
	 zCTdqVftuoSn9YGyk6LdJ05wRRsCSm0NnmT3Es5OoIyhbBopVfUx+0jenIlcHcuVEK
	 QUxyG4W6x+X4VMgVa8LMpYuVtaYfvCGxzSoaqa7/t8TNXlPvI2xBp/7DQaIG4X6Ob1
	 t/Ew915xduGG3bH8C4Vdi4ArD/q+QYXkiZg7S2f0MvNEGBV1cUTLPsS/YqGf8Tpu/k
	 ZQkIVtZntbxeGMXopJI3XsSq8bZ0c/CNHYpPkYAjlf8K026mToruhxc30aF6nf3ztc
	 RfTYI0F9nT8XA==
Date: Sat, 5 Oct 2024 13:10:12 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH] selftests: Do not skip BPF selftests by default
Message-ID: <ZwEspBT04w20oPsj@finisterre.sirena.org.uk>
References: <20241004095348.797020-1-bjorn@kernel.org>
 <96023ef4-fa0b-4fc2-a6a7-ac32bc777c44@sirena.org.uk>
 <875xq82dqe.fsf@all.your.base.are.belong.to.us>
 <bb579569-1451-414f-aac4-12757024d9a5@sirena.org.uk>
 <87bjzyeu4g.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QO42guiMCIxRerEh"
Content-Disposition: inline
In-Reply-To: <87bjzyeu4g.fsf@all.your.base.are.belong.to.us>
X-Cookie: Editing is a rewording activity.


--QO42guiMCIxRerEh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 05, 2024 at 12:12:15PM +0200, Bj=F6rn T=F6pel wrote:
> Mark Brown <broonie@kernel.org> writes:
> > On Fri, Oct 04, 2024 at 03:34:49PM +0200, Bj=F6rn T=F6pel wrote:
> >> Mark Brown <broonie@kernel.org> writes:

> > It's a bit unfortunate having to pull clang into GCC build containers,
> > and needing a newer version than the minimum clang for the kernel itself
> > too :/

> I guess this boils down to the expecatation on the build environment. I
> pull in Rust, various LLVM, and GCC versions into the build container.

> Is the expectation the kernel and userland tooling must be the same?

I'd say it's a likely expectation, or at least a case people are going
to want to try.  A bunch of the people doing builds have per toolchain
containers, as well as keeping the container size under control it makes
it easy to be sure that your build actually used the toolchain you
thought it used if there simply isn't any other toolchain in there.  You
have testing that is focused on making sure that all the puportedly
supported toolchain versions actually work.

> >> > The whole thing is also broken for cross compilation with clang since
> >> > everything is assuming that CROSS_COMPILE will be set for cross buil=
ds
> >> > but that's not the case for LLVM=3D1 builds - net gives:

> >> A lot can be said about kselftest, and cross-building. It's a bit of a
> >> mess. Maybe we should move to meson or something for kselftest (that
> >> requires less work for lazy developers like me). ;-)

> > AFAICT it pretty much works fine?  It's certainly widely used.

> Ugh, I guess we have very different views here. For me kselftest
> cross-building is breaking all the time. The tests are a mix of using
> the kselftest framework, and "having tests stored somewhere". Targets
> have different semantics (e.g. missing things from "install"),
> developers (I definitely include me self here!) seem to have a hard time
> figuring out what should be included in the test Makefiles (copy and
> paste, etc.).

I'm pretty much exclusively cross building kselftest, even for the cases
I end up doing native builds the build is set up like a cross build
because a lot of my stuff is running in a Kubernetes cluster which will
spin up whatever machines it can get cheapest at a given moment.

> A lot of tests are not included in the top-level kselftest Makefile
> (maybe there's a rationale for that? I haven't found one).

As far as I'm aware the ones that aren't included are ones that are (or
were, perhaps there's some cases that need revisiting) unreasonably hard
to get going or where the test programs just don't look at all like
selftests so break the framework when you try to run them.  I
occasionally go through and try to enable more selftests in both my CI
and KernelCI, I know there's some that are missing from the top level
Makefile that I didn't hook in because they were too broken but there's
a bunch of others where I've sent patches because it just looks like an
oversight.  There's other people doing similar stuff, Muhammad Usama
Anjum from Collabora has been doing a bunch of stuff recently for
example.

> I love kbuild for the *kernel*, but IMO it really feels bolted on for
> kselftest (and much of tools/).

> Tests don't get the same love as the kernel proper, and developers don't
> want to spend a lot of time figuring out how kselftests works -- and
> that shows in kselftest.

That's a big part of the pushback on things like the build issues with
the BPF tests and the way those issues manifest, part of the goal is to
get the selftests to the point where they mostly work without too much
effort.  Things like requiring a library are not too much of an issue,
you just search for what provides foo.h on your distro or whatever, and
similarly if it's a common tool that distros tend to carry.  Similarly
adding the tools/testing/selftests/suite/config fragments to a defconfig
should be what's needed to get the kernel configured appropriately to do
the tests.

It would be nice to do something better with the libraries, IIRC some of
the suites do already for cases where the libray is only used by a
subset of the tests, but other than that we do mostly seem to be at a
point where you can reasonably just expect things to work.

> > I think we before defaulting BPF stuff on we should at the very least
> > fix the builds for commonly covered architectures, it looks like as well
> > as arm64 we're also seeing BTF not generated on 32 bit arm:

> >    https://storage.kernelci.org/next/master/next-20241004/arm/multi_v7_=
defconfig%2Bkselftest/gcc-12/config/kernel.config

> > but everything else I spot checked looks fine.  It'd be much better to
> > skip gracefully if the kernel doesn't have BPF too.

> > We should probably also have explicit clang presence and feature/version
> > checks in the builds since clang is now fairly widely available in
> > distros but many of them have older versions than are needed so I
> > imagine a common failure pattern might be that people see clang is
> > needed, install their distro clang package and then run into errors from
> > clang.  That'd mean people would get a graceful skip with a clear
> > description of what's needed rather than build errors.

> This is not only true for BPF/Clang. There are a number of kselftests
> that make assumptions about architecture, and tools. I do agree that a
> proper feature detection (what bpftool/perf is using, or move to that
> new shiny build system ;-P) for kselftest would be great!

Do you have specific pointers to problem suites?  The general idea is
that if there's architecture dependencies the tests should be skipped
when not applicable (eg, the arm64, riscv and x86 suites do this) and at
the minute for straightforward library dependencies we just expect
people to sort them out (it's mildly annoying whenever someone starts
using a new library but it tends not to be too much of a barrier).

I'm not sure the problem here is really the language TBH.

> > This is all a particular issue for the net tests where the addition of =
BPF
> > is a regression, not only can't you run the BPF based tests without
> > getting BPF working we've now lost the entire net testsuite if BPF isn't
> > working since it breaks the build.  TBH I didn't notice this getting
> > broken because I forgot that I was expecting to see net tests on
> > kernelci.org and the build break means they just disappear entirely from
> > the runtime results.  That really does need a graceful skip.

> ...and adding net/hid/sched_ext to the default skip as well? What the
> tests that only work on some platforms. I'm intentionally provoking
> here. I don't like hiding tests, because it is bit "tricky" to setup the
> tooling. BPF is very much in the core of the kernel, and leaving those
> tests out seems odd.

I think the ideal thing would be to have these suites included in the
build and skipping gracefully with comprehensible error messages if
their dependencies aren't met.  Now that they are expected to work with
released versions of clang it's a lot more tractable for people to
resolve the dependency than it was in the past.  We also need to ensure
that they work for at least major architectures, even with their
dependencies installed and config fragments turned on no upstream
configuration can currently build any BPF tests on either arm or arm64
which clearly isn't at all OK.

Like I said above I think for net the current situation is a serious
regression and should be fixed so that only the BPF related net tests
are skipped when BPF isn't working.

--QO42guiMCIxRerEh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcBLKMACgkQJNaLcl1U
h9AVCAf3fWUJK+i2QAf52M8fkqBs7g2oXpWNh/cdCAkb685PWkZkyfHsQfKSL5N8
txpYz+EcJKXJneyYQVOpOt9PTHg+NNaccAC/JvS/V3+UmaZF7/mgwVgj7mLAtM/c
tzvlOWbiGOC2OTlRusB01scwGoRbj6R4ApIND3DTou2UA68sy+l6kZoSEP8Lm6KB
yUfjm9SXve66XMtapCkR1lU9G+FLPMFlwlEIqiJ6F0WbGfnO7r50yNf4J6HYZfm3
x3jwDKqU7BEeA0kUxb519MQaS4fI/AJaA5AUlYwTf3izzu6vXYeKI0o9nFeHTlnM
iM16o7fQGi2+4HiZ9Ew8PSgK1pCX
=nhT9
-----END PGP SIGNATURE-----

--QO42guiMCIxRerEh--

