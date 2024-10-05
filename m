Return-Path: <linux-kselftest+bounces-19090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F8E9915E8
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 12:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2E4285379
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 10:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE7614AD20;
	Sat,  5 Oct 2024 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNFVVpra"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F36136337;
	Sat,  5 Oct 2024 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728123140; cv=none; b=UaxTSwtuGyczH9FvUS7sJkAYMtVet1IalXc8O1SypNo2F1R9u6n3hOWGgQWc7/X3OUuQquk8g0cmG1F2vZDUPok38+kehlZ4KxHZu9PbaLHufOSxM/sl+6vnQhmpdh86V7mxTvGqBWpAh8X6w0Q+zAE6ZaIroBCqUYpfX0JAdlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728123140; c=relaxed/simple;
	bh=O1Rd6Ec99XvXAU8/BcCM4skzhvN8U4dOrh4h5JVeG3I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kUmAXqx9yTD80H/B80wS9/FLPRP/PUZqAUF2b8l/613G9o2M2LrOBAFFrzecvcIZJSy3fJCu7pRDvSFwV+uH2o3Ly2r9O0YJjG+YudHWDU9L1BSKm/Azi82CeRwAkRLfgJwqB7q2pPKDPawa3rOVCRYQSS1VRNeEnmR1OMZx6+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNFVVpra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86557C4CEC2;
	Sat,  5 Oct 2024 10:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728123140;
	bh=O1Rd6Ec99XvXAU8/BcCM4skzhvN8U4dOrh4h5JVeG3I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oNFVVpraNrMc5M7fLuildm62mtrhiI/SJhaKh7K2z9yMypxvtaM9bPnI5idBtYbr2
	 IpISqn342a4z5CfpXlIommAnMBUfmdoGWzJScz99rUBGDb7D6O7GJJmbK1h95pzGjj
	 KJYN6+iaLOM+DKwbQzMEptki97xwFczbsCqkf/tIae4a7CFmrmNY4kLBBhtpxfgyxA
	 4NFxA2I5C6WImLT7rhrApFESkE4M9zmoUAsS4JynTpmMVCGO54bTGN4vK40pru4pS+
	 GFtC7e8X7PjWgGM1jJsdgjfWyD1u7IpxFNtESKP/ScqaXCjxjEkOjem2ASoHnJ7yWM
	 DNvufOrQK4bfQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, =?utf-8?B?QmrDtnJu?=
 =?utf-8?B?IFTDtnBlbA==?=
 <bjorn@rivosinc.com>, linux-kernel@vger.kernel.org, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, Nathan
 Chancellor <nathan@kernel.org>, Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH] selftests: Do not skip BPF selftests by default
In-Reply-To: <bb579569-1451-414f-aac4-12757024d9a5@sirena.org.uk>
References: <20241004095348.797020-1-bjorn@kernel.org>
 <96023ef4-fa0b-4fc2-a6a7-ac32bc777c44@sirena.org.uk>
 <875xq82dqe.fsf@all.your.base.are.belong.to.us>
 <bb579569-1451-414f-aac4-12757024d9a5@sirena.org.uk>
Date: Sat, 05 Oct 2024 12:12:15 +0200
Message-ID: <87bjzyeu4g.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mark Brown <broonie@kernel.org> writes:

> On Fri, Oct 04, 2024 at 03:34:49PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> Mark Brown <broonie@kernel.org> writes:
>> > On Fri, Oct 04, 2024 at 11:53:47AM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>
>> >> This effectively is a revert of commit 7a6eb7c34a78 ("selftests: Skip
>> >> BPF seftests by default"). At the time when this was added, BPF had
>> >> "build time dependencies on cutting edge versions". Since then a
>> >> number of BPF capable tests has been included in net, hid, sched_ext.
>
>> > The issue was always requiring a bleeding edge version of clang, not
>> > sure if that's been relaxed yet, IIRC sometimes it required git
>> > versions.  I have clang 20 installed here so that's not an issue for me
>> > but given that that's not released yet it wouldn't be reasonable to
>> > expect CI systems to install it.
>
>> Yeah, but I'd say that is not the case anymore. LLVM 18 and 19 works.
>
> Hrm, that's definitely a lot better then though still a little cutting
> edge - the 24.10 Ubuntu release has clang 17, never mind any of the
> stables or LTSs (Debian is very popular for build containers).  Not
> quite at the "you can just install your distro package" level yet though
> it's definitely substantial progress.  Is this requirement documented
> somewhere someone could reasonably be expected to discover it?

I agree it would help having the minimal version stated somewhere. I'm
not aware of it.

> It's a bit unfortunate having to pull clang into GCC build containers,
> and needing a newer version than the minimum clang for the kernel itself
> too :/

I guess this boils down to the expecatation on the build environment. I
pull in Rust, various LLVM, and GCC versions into the build container.

Is the expectation the kernel and userland tooling must be the same?

>> > We also get a bunch of:
>
>> > die__process_unit: DW_TAG_label (0xa) @ <0x58eb7> not handled!
>> > die__process_unit: tag not supported 0xa (label)!
>
>> > if we do turn enable CONFIG_DEBUG_INFO_BTF for arm64.
>
>> This is pahole version related.
>
> Which version is needed?  I've got 1.24 (from Debian) here...

I bumped to 1.25!

>> > The whole thing is also broken for cross compilation with clang since
>> > everything is assuming that CROSS_COMPILE will be set for cross builds
>> > but that's not the case for LLVM=3D1 builds - net gives:
>
>> A lot can be said about kselftest, and cross-building. It's a bit of a
>> mess. Maybe we should move to meson or something for kselftest (that
>> requires less work for lazy developers like me). ;-)
>
> AFAICT it pretty much works fine?  It's certainly widely used.

Ugh, I guess we have very different views here. For me kselftest
cross-building is breaking all the time. The tests are a mix of using
the kselftest framework, and "having tests stored somewhere". Targets
have different semantics (e.g. missing things from "install"),
developers (I definitely include me self here!) seem to have a hard time
figuring out what should be included in the test Makefiles (copy and
paste, etc.).

A lot of tests are not included in the top-level kselftest Makefile
(maybe there's a rationale for that? I haven't found one).

I love kbuild for the *kernel*, but IMO it really feels bolted on for
kselftest (and much of tools/).

Tests don't get the same love as the kernel proper, and developers don't
want to spend a lot of time figuring out how kselftests works -- and
that shows in kselftest.

>> I'm simply arguing that the *default* should be: BPF (and
>> hid/net/sched_ext) turned on. Default on would surface these kind of
>> problems, rather than hiding them. (And let the CI exclude tests it
>> cannot handle).
>
> The original motivation behind that patch was that there were a bunch of
> CI systems all trying to run as many of the selftests as they can,
> running into BPF and getting frustrated at the amount of time it was
> consuming (or not managing to get it working at all).  Everyone was
> assuming they were missing something or somehow doing the wrong thing to
> satisfy the dependencies and it was burning a bunch of time and
> discouraging people from using the selftests at all since it doesn't
> create a good impression if stuff just doesn't build.  People did often
> end up skipping BPF, but only after banging their heads against it for a
> while, and then went and compared notes with other CI systems and found
> everyone else had the same problem.
>
> I think we before defaulting BPF stuff on we should at the very least
> fix the builds for commonly covered architectures, it looks like as well
> as arm64 we're also seeing BTF not generated on 32 bit arm:
>
>    https://storage.kernelci.org/next/master/next-20241004/arm/multi_v7_de=
fconfig%2Bkselftest/gcc-12/config/kernel.config
>
> but everything else I spot checked looks fine.  It'd be much better to
> skip gracefully if the kernel doesn't have BPF too.
>
> We should probably also have explicit clang presence and feature/version
> checks in the builds since clang is now fairly widely available in
> distros but many of them have older versions than are needed so I
> imagine a common failure pattern might be that people see clang is
> needed, install their distro clang package and then run into errors from
> clang.  That'd mean people would get a graceful skip with a clear
> description of what's needed rather than build errors.

This is not only true for BPF/Clang. There are a number of kselftests
that make assumptions about architecture, and tools. I do agree that a
proper feature detection (what bpftool/perf is using, or move to that
new shiny build system ;-P) for kselftest would be great!

> This is all a particular issue for the net tests where the addition of BPF
> is a regression, not only can't you run the BPF based tests without
> getting BPF working we've now lost the entire net testsuite if BPF isn't
> working since it breaks the build.  TBH I didn't notice this getting
> broken because I forgot that I was expecting to see net tests on
> kernelci.org and the build break means they just disappear entirely from
> the runtime results.  That really does need a graceful skip.

...and adding net/hid/sched_ext to the default skip as well? What the
tests that only work on some platforms. I'm intentionally provoking
here. I don't like hiding tests, because it is bit "tricky" to setup the
tooling. BPF is very much in the core of the kernel, and leaving those
tests out seems odd.

Thanks for the discussion! I'll have a look into the feature detection.

Bj=C3=B6rn

