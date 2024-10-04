Return-Path: <linux-kselftest+bounces-19039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1939906AB
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 16:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894F7286021
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 14:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E5A21C19E;
	Fri,  4 Oct 2024 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpsXWQsz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9221948D;
	Fri,  4 Oct 2024 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728053195; cv=none; b=C5Uu1qDo3Y5asuu6iWPbmxY1mWWmsFWIAkzjvz3s3o1tOV5M3M5WKESHWI01hIyMXo+ivJleOJIIeNzuQzbO4SkYtcoa6L5xs3gFhKIHN8sOWiA7ihjTQIN4C6CeRI8sqKCiV/8wT+tSwpcLRvbiJZ5e9cR/j3cKqWP3GTkt8B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728053195; c=relaxed/simple;
	bh=Kd7bxxn+E6+a5OxHMhzYutlTNc12wg0ar2p6Ca02iDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHsjI9QfREfBPl05zeYYvX3ZPOfWZGuiWZMvMMgZSk+r0RH0nsWw8Kn7BIZ5I36wl06K2wOfvS3bjBZRqBVa9vlYnvNHqKVKEs/uXWn4M43rXNTN04xUgz0VJUpzwLLoAyGUTJNBRRQMjNOenic5HF7Tdh1u26ROoZI29L9PCQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpsXWQsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0A9C4CEC6;
	Fri,  4 Oct 2024 14:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728053194;
	bh=Kd7bxxn+E6+a5OxHMhzYutlTNc12wg0ar2p6Ca02iDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WpsXWQszg2DgwFS81tb6nwql6Z7+RJKDFdGq5iSG0LZvks0AMmjGhIipT87H5y2PQ
	 29MEcDCzUescRkh24KdNQ7v1mSTn8G84WuqvAv0Q55WuZnLLvNrZ5LXkFxVqsrlkDB
	 3Er7ESa2ZQIFsELewu6MJ/JdHAJtxxgEqjTgqwae+pu85j8MA0+TmgWZ4iads46ngr
	 TpmTmlCEB4bUmWaVr0LBr8dazkZu3+fiJYa56SbKVLmvKAKNZeXIDRUK3YkvYRgzUX
	 6Zd1Z2suPYENnSGqUQi1kJF+4l6hktwp59ojPc5ZaGaPq6KOw8P+GrIvSUWmk02d3Q
	 WROU18UmBWmtw==
Date: Fri, 4 Oct 2024 15:46:28 +0100
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
Message-ID: <bb579569-1451-414f-aac4-12757024d9a5@sirena.org.uk>
References: <20241004095348.797020-1-bjorn@kernel.org>
 <96023ef4-fa0b-4fc2-a6a7-ac32bc777c44@sirena.org.uk>
 <875xq82dqe.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JKPBhgJ4YDwDsxOc"
Content-Disposition: inline
In-Reply-To: <875xq82dqe.fsf@all.your.base.are.belong.to.us>
X-Cookie: A bachelor is an unaltared male.


--JKPBhgJ4YDwDsxOc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2024 at 03:34:49PM +0200, Bj=F6rn T=F6pel wrote:
> Mark Brown <broonie@kernel.org> writes:
> > On Fri, Oct 04, 2024 at 11:53:47AM +0200, Bj=F6rn T=F6pel wrote:

> >> This effectively is a revert of commit 7a6eb7c34a78 ("selftests: Skip
> >> BPF seftests by default"). At the time when this was added, BPF had
> >> "build time dependencies on cutting edge versions". Since then a
> >> number of BPF capable tests has been included in net, hid, sched_ext.

> > The issue was always requiring a bleeding edge version of clang, not
> > sure if that's been relaxed yet, IIRC sometimes it required git
> > versions.  I have clang 20 installed here so that's not an issue for me
> > but given that that's not released yet it wouldn't be reasonable to
> > expect CI systems to install it.

> Yeah, but I'd say that is not the case anymore. LLVM 18 and 19 works.

Hrm, that's definitely a lot better then though still a little cutting
edge - the 24.10 Ubuntu release has clang 17, never mind any of the
stables or LTSs (Debian is very popular for build containers).  Not
quite at the "you can just install your distro package" level yet though
it's definitely substantial progress.  Is this requirement documented
somewhere someone could reasonably be expected to discover it?

It's a bit unfortunate having to pull clang into GCC build containers,
and needing a newer version than the minimum clang for the kernel itself
too :/

> > We also get a bunch of:

> > die__process_unit: DW_TAG_label (0xa) @ <0x58eb7> not handled!
> > die__process_unit: tag not supported 0xa (label)!

> > if we do turn enable CONFIG_DEBUG_INFO_BTF for arm64.

> This is pahole version related.

Which version is needed?  I've got 1.24 (from Debian) here...

> > The whole thing is also broken for cross compilation with clang since
> > everything is assuming that CROSS_COMPILE will be set for cross builds
> > but that's not the case for LLVM=3D1 builds - net gives:

> A lot can be said about kselftest, and cross-building. It's a bit of a
> mess. Maybe we should move to meson or something for kselftest (that
> requires less work for lazy developers like me). ;-)

AFAICT it pretty much works fine?  It's certainly widely used.

> I'm simply arguing that the *default* should be: BPF (and
> hid/net/sched_ext) turned on. Default on would surface these kind of
> problems, rather than hiding them. (And let the CI exclude tests it
> cannot handle).

The original motivation behind that patch was that there were a bunch of
CI systems all trying to run as many of the selftests as they can,
running into BPF and getting frustrated at the amount of time it was
consuming (or not managing to get it working at all).  Everyone was
assuming they were missing something or somehow doing the wrong thing to
satisfy the dependencies and it was burning a bunch of time and
discouraging people from using the selftests at all since it doesn't
create a good impression if stuff just doesn't build.  People did often
end up skipping BPF, but only after banging their heads against it for a
while, and then went and compared notes with other CI systems and found
everyone else had the same problem.

I think we before defaulting BPF stuff on we should at the very least
fix the builds for commonly covered architectures, it looks like as well
as arm64 we're also seeing BTF not generated on 32 bit arm:

   https://storage.kernelci.org/next/master/next-20241004/arm/multi_v7_defc=
onfig%2Bkselftest/gcc-12/config/kernel.config

but everything else I spot checked looks fine.  It'd be much better to
skip gracefully if the kernel doesn't have BPF too.

We should probably also have explicit clang presence and feature/version
checks in the builds since clang is now fairly widely available in
distros but many of them have older versions than are needed so I
imagine a common failure pattern might be that people see clang is
needed, install their distro clang package and then run into errors from
clang.  That'd mean people would get a graceful skip with a clear
description of what's needed rather than build errors.

This is all a particular issue for the net tests where the addition of BPF
is a regression, not only can't you run the BPF based tests without
getting BPF working we've now lost the entire net testsuite if BPF isn't
working since it breaks the build.  TBH I didn't notice this getting
broken because I forgot that I was expecting to see net tests on
kernelci.org and the build break means they just disappear entirely from
the runtime results.  That really does need a graceful skip.

--JKPBhgJ4YDwDsxOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmb//8MACgkQJNaLcl1U
h9CPLgf9Gocwxq6rC7AlTu5wU9GWsdECfrkKXxMJ0bL6pv/GfRt8eNHZTyq3rrwF
nXkOMzqWEXrSsI0xdhfd7UYd5M41o6IZiSi/Q3AZUci2hnWE6fOOri6cUUUX1Im8
hv2eQpQAfVCrurr2gJbsq7Owr/y6jA+nQ8ZNDBd8o6KI6UBQWDRH2jNVS1ABOLpf
fQUeSPPr4IqJogK9pu6K+U/bHwxmVqsbIIzXza7sFw1inmGr3jfUEW12Qx/hPdiM
p/9uOe7eQO+DB9kDHkRhpLdwm9nMvoBjs/3/y3r7Eps42VXSDN+UobJHyXpgisQ6
cQTScmCy8K56kOzgE6GP+Sk+KCf/jw==
=koLM
-----END PGP SIGNATURE-----

--JKPBhgJ4YDwDsxOc--

