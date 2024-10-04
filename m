Return-Path: <linux-kselftest+bounces-19020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFD7990482
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 15:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1BB21F21E59
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 13:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A2F20FAA3;
	Fri,  4 Oct 2024 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/X84KLr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0678929422;
	Fri,  4 Oct 2024 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048892; cv=none; b=BOSe4SaTvzZ5klhGLig3bKE8epbvn7TlZkV/qHIjantAj8wYlM2IRWRBHn4MfViiI3QuTsRa+IQfxqaYKQTa4JUT+kFzJh6CWLk6lLHSISeFl1u8n9tCYsyRBXArqYp7RJ7JQXIMsE7d8YolWZyiNeJeT/7C+LkpeplHOrkgmc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048892; c=relaxed/simple;
	bh=tQo+D+ZsOwHzRRUp3hj0H1PJAeVCaMRjiE8Fwe63jjE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kQuJapZHMzTnyC2w2OQcsQcKgTVbB7HcmSa4W8QqbcegZlnqdbE995oNeTveHOrc1JgRR/7RU+R8GBiJZXlBM0TEfu/yNxOoJBsvrRnzAKeOsOelkyvYAJUwtcf1il/8o+xmqQwhKYYkNFSuY79FCMCYLXU4nOHPRm32xXliQTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/X84KLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756CBC567D6;
	Fri,  4 Oct 2024 13:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728048891;
	bh=tQo+D+ZsOwHzRRUp3hj0H1PJAeVCaMRjiE8Fwe63jjE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=X/X84KLr2oi7bZZCfDXd3SaFeQG2ilD4hwgdfp/gh9nF5zwhLX1wxusZ+a9dyiUyx
	 bD8ZiwKb6u0AAO0tQN+td6PYo3DPdw4Gu2tIgeXYSV/0/fu7uLDP3raP3W+Nlct6q2
	 z9H5VbXsu8+ei8Oy2LQY7IqBsK6gv7thzaLh+1Q/bvv++XJH1sA8bsTI7Rt4aAMcV8
	 kB1/M5YqNkZVgPybQ5NuJk3pWc/s9jhVIWfAgTI/bEPYvSwRJevw084WCnBN4VQMaS
	 kaSz+qzP4Wv1W6aMgaPEam8hyYRClJeQaCwBFDgqGxeLYDamUchI2YzrPeOPLOmplP
	 KLS/rJgIQ6YVg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, =?utf-8?B?QmrDtnJu?=
 =?utf-8?B?IFTDtnBlbA==?=
 <bjorn@rivosinc.com>, linux-kernel@vger.kernel.org, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, Nathan
 Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] selftests: Do not skip BPF selftests by default
In-Reply-To: <96023ef4-fa0b-4fc2-a6a7-ac32bc777c44@sirena.org.uk>
References: <20241004095348.797020-1-bjorn@kernel.org>
 <96023ef4-fa0b-4fc2-a6a7-ac32bc777c44@sirena.org.uk>
Date: Fri, 04 Oct 2024 15:34:49 +0200
Message-ID: <875xq82dqe.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mark!

Mark Brown <broonie@kernel.org> writes:

> On Fri, Oct 04, 2024 at 11:53:47AM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>=20
>> This effectively is a revert of commit 7a6eb7c34a78 ("selftests: Skip
>> BPF seftests by default"). At the time when this was added, BPF had
>> "build time dependencies on cutting edge versions". Since then a
>> number of BPF capable tests has been included in net, hid, sched_ext.
>>=20
>> There is no reason not to include BPF by default in the build.
>
> The issue was always requiring a bleeding edge version of clang, not
> sure if that's been relaxed yet, IIRC sometimes it required git
> versions.  I have clang 20 installed here so that's not an issue for me
> but given that that's not released yet it wouldn't be reasonable to
> expect CI systems to install it.

Yeah, but I'd say that is not the case anymore. LLVM 18 and 19 works.

> There's a few other substantial issues with all of these suites now I
> look, none of them build on arm64 since arm64 defconfig has
> DEBUG_INFO_REDUCED=3Dy which isn't compatible with CONFIG_DEBUG_INFO_BTF
> so that gets turned off and the build splats trying to read the BTF out
> of the kernel binary (which is a new build dep for the selftests
> too...).=20=20
>
>    https://storage.kernelci.org/next/master/next-20241004/arm64/defconfig=
%2Bkselftest/gcc-12/config/
>
> We also get a bunch of:
>
> die__process_unit: DW_TAG_label (0xa) @ <0x58eb7> not handled!
> die__process_unit: tag not supported 0xa (label)!
>
> if we do turn enable CONFIG_DEBUG_INFO_BTF for arm64.=20=20

This is pahole version related.

> The whole thing is also broken for cross compilation with clang since
> everything is assuming that CROSS_COMPILE will be set for cross builds
> but that's not the case for LLVM=3D1 builds - net gives:
>
>   BPF_PROG nat6to4.bpf.o
>   BPF_PROG sample_map_ret0.bpf.o
> /usr/lib/gcc-cross/aarch64-linux-gnu/12/../../../../aarch64-linux-gnu/bin=
/ld: /home/broonie/git/linux/tools/testing/selftests/net/libynl.a(ynl.o): R=
elocations in generic ELF (EM: 62)
> /usr/lib/gcc-cross/aarch64-linux-gnu/12/../../../../aarch64-linux-gnu/bin=
/ld: /home/broonie/git/linux/tools/testing/selftests/net/libynl.a(ynl.o): R=
elocations in generic ELF (EM: 62)
> /usr/lib/gcc-cross/aarch64-linux-gnu/12/../../../../aarch64-linux-gnu/bin=
/ld: /home/broonie/git/linux/tools/testing/selftests/net/libynl.a(ynl.o): R=
elocations in generic ELF (EM: 62)
> /usr/lib/gcc-cross/aarch64-linux-gnu/12/../../../../aarch64-linux-gnu/bin=
/ld: /home/broonie/git/linux/tools/testing/selftests/net/libynl.a: error ad=
ding symbols: file in wrong format
>   BPF_PROG sample_ret0.bpf.o
> collect2: error: ld returned 1 exit status
>
> with similar errors in libbpf for HID:
>
> /usr/bin/aarch64-linux-gnu-ld: /home/broonie/git/linux/tools/testing/self=
tests/hid/tools/build/libbpf/libbpf.a(libbpf-in.o): Relocations in generic =
ELF (EM: 62)
> /usr/bin/aarch64-linux-gnu-ld: /home/broonie/git/linux/tools/testing/self=
tests/hid/tools/build/libbpf/libbpf.a(libbpf-in.o): Relocations in generic =
ELF (EM: 62)
>
> KernelCI is seeing failures earlier with HID:
>
>    https://storage.kernelci.org/next/master/next-20241004/arm64/defconfig=
%2Bkselftest/gcc-12/logs/kselftest.log
>
> and an unrelated missing dependency on libssl for net that needs to be
> fixed.

A lot can be said about kselftest, and cross-building. It's a bit of a
mess. Maybe we should move to meson or something for kselftest (that
requires less work for lazy developers like me). ;-)

I'm simply arguing that the *default* should be: BPF (and
hid/net/sched_ext) turned on. Default on would surface these kind of
problems, rather than hiding them. (And let the CI exclude tests it
cannot handle).


Cheers!
Bj=C3=B6rn

