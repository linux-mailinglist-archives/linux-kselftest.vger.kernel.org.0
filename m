Return-Path: <linux-kselftest+bounces-8997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8E68B4B9E
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Apr 2024 14:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8121F21667
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Apr 2024 12:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA996A33F;
	Sun, 28 Apr 2024 12:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="cS2VqRA7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07575F861;
	Sun, 28 Apr 2024 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714306108; cv=none; b=M9woXV87XQ/Vq5VVPp9U4Zjspb6R50PL5XcPggu4CCppufYbPGrEWhkm4Rxrw7d8KMZyKpqsQJhoFakigK8UQs/WkEq90SQaUAmVFwUQDQCXJ1VluTB4ArRTUQo8VkGevRZpJpxV2t1J0eLTaDOvL/6oLHWtN8ZYwDH+cHLrYAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714306108; c=relaxed/simple;
	bh=WXJUO9YQdJC+BeaW5G3UQILBU5XwVnOjmj/cjDBeAXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyoEMJ3dQscEUR9jX1GFfVHsXzDhFPStLd461vrEWP3liJ5k9qe2sASHDtz4pMJVc9cK/4h/fNz/axncd4btHk24rty2z8RBFS8lu585OGiL1wi49TDFA46zj7etHEoRBjbe0SEeQWR8NWSSQbE2CKclVSwGfLiL804y1nyQ0co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=cS2VqRA7; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valentinobst.de;
	s=s1-ionos; t=1714306087; x=1714910887; i=kernel@valentinobst.de;
	bh=PZmG1kqRjQ0u8igBJqTBBrvnDExhwzDX/sauu1mYL9o=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:cc:content-transfer-encoding:content-type:
	 date:from:message-id:mime-version:reply-to:subject:to;
	b=cS2VqRA7uKha57FgSt/mCC0kBCDINO9kHGarNXA9hsUngXQ6bzq8TGtWrcbln6zP
	 HSxlgfK4u05NDq+5RYa5da0a98fmH3T3vsFAZKi4uqWDiGGUrVUV5a5mjrgOBII3h
	 lxPf0k3fJ8cylH8JmMI6jnHNX3GyuLCC++SI/gpKZ3vy5U1Exh+K+v4QwZWuYgFG2
	 mJtbYXOcvPcdpbMfE0fOw7ncvB8w9XsQIq65T737iltGCU2bw8pP+HeMr26ZThYOe
	 2PWfBfnuzF+TNCWwX6B3ekqQANhxUEgfG8TtsAmgOT/1hJ6GmhenTzxY86k2XDE9U
	 CIM2BXKajmdRS04ZRg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from archbook.speedport.ip ([80.133.135.193]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mum2d-1srmhY1vvP-00rlku; Sun, 28 Apr 2024 14:08:07 +0200
From: Valentin Obst <kernel@valentinobst.de>
To: jhubbard@nvidia.com
Cc: anders.roxell@linaro.org,
	bpoirier@nvidia.com,
	broonie@kernel.org,
	guillaume.tucker@collabora.com,
	kernel@valentinobst.de,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mpdesouza@suse.com,
	nathan@kernel.org,
	sashal@kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH] selftests: default to host arch for LLVM builds
Date: Sun, 28 Apr 2024 14:08:06 +0200
Message-ID: <20240428120806.19275-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <6d398f1d-6882-40fb-8ced-7fe6bee2aee7@nvidia.com>
References: <6d398f1d-6882-40fb-8ced-7fe6bee2aee7@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:hBsuJ9S4dgHa96hLHUY5sMNgbvBAexdizMdlgNtB+IKdMogcBfU
 WXl/WN+W7dxB8bo/T96sLzF8nxrOKg2JXtuOMoHwKvwvQFDLPa4/g/1valeFomAjc3bSJ/A
 CBQ6d14ocW8SJzCmJJQbrW11h7JweoqcSh1vghWTSR570eZgqQipaQ6zD1LkoaXbXydrj0B
 qsjRESE+XAQbpMNNW3b6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mp1aKaqNETI=;hoB6pPKDa5bHwMIkBwX75lmwT+R
 L0iNcZQ/AsJ3oCku+ZIlaKw2w/2132NoIT0UU/nQ2RjlLvk4ABzFlV5f4T6HOVbWrpJObS5oL
 6PYXxxhfj5aSu6RSSjk6ZkT6sZQzUnQ6Igh906jXx9g50svr7QtwB4YPqYowJX1lAB5nggBWb
 SYfwuu/ijxv8c3Z/oRZeiFIqBHvxWYiI1fZWfnmK2d8OeSplhBcByo+oupFVC6Aydh+OBP9C/
 rf82UqYqR4/LtWG64MI/NCFs+dlb1F0IKUXpoK8FjJS5Z3S2XmsttzLonhp0ahzfGI/f1GMo4
 FnniUZ76UC0tR83xhUWvawZLwK+OzXDTvy5fF3cQ5U+tPnOuAqaavVKQvYoKmKNzECLzsM4p8
 3CYeO6boBVQ06VXcyE1LBWtYXXYQD8b6PVcYRXyIGblckOxOOGFpO6WnL4rpZbwSf8mTqQmtT
 UZQvSeNybZxSBUhHJ9Cyb3cinn9UZZbqzKgt+bTBZveOOYOKea/cu1dCtUnYm15XxhnjkOdaC
 sEAVgEUXOCJL+kaFh1VoFoBsHqnHx440cMS7JR5Q9j6QztXztsW8tPOpifKZEIHYqJKf0uUwS
 mICX/UZHghZwNuagaI6KVUcO2G3DE36i1kKouS97i7pOvSifx6Ka6k4I/VZG/26ebzTn/ljXR
 EFPmgoQap3CjrJ74M5gdkSugJfHXF+nHBg1V6n2st6G7Dm1/4dB5aWX4Bg5HtV041XX60VUiB
 mWdzImDtQgRBcQG7o6rmUiEJaTMvtch9ft2wKK9PuEp8lz2+XXgcWs=

> > Align the behavior for gcc and clang builds by interpreting unset
> > `ARCH` and `CROSS_COMPILE` variables in `LLVM` builds as a sign that the
> > user wants to build for the host architecture.
> >
> > This patch preserves the properties that setting the `ARCH` variable to an
> > unknown value will trigger an error that complains about insufficient
> > information, and that a set `CROSS_COMPILE` variable will override the
> > target triple that is determined based on presence/absence of `ARCH`.
> >
> > When compiling with clang, i.e., `LLVM` is set, an unset `ARCH` variable in
> > combination with an unset `CROSS_COMPILE` variable, i.e., compiling for
> > the host architecture, leads to compilation failures since `lib.mk` can
> > not determine the clang target triple. In this case, the following error
> > message is displayed for each subsystem that does not set `ARCH` in its
> > own Makefile before including `lib.mk` (lines wrapped at 75 chrs):
> >
> >    make[1]: Entering directory '/mnt/build/linux/tools/testing/selftests/
> >     sysctl'
> >    ../lib.mk:33: *** Specify CROSS_COMPILE or add '--target=' option to
> >     lib.mk.  Stop.
> >    make[1]: Leaving directory '/mnt/build/linux/tools/testing/selftests/
> >     sysctl'
>
> Thanks for fixing this.
>
> And yes, the selftests "normal" (non-cross-compile) build is *broken*
> right now, for clang. I didn't realize from the patch title that this is
> actually a significant fix. Maybe we should change the subject line (patch
> title) to something like:
>
>     [PATCH] selftests: fix the clang build: default to host arch for LLVM builds

Yes, I agree that the title should contain the word 'fix' somewhere. For
me its okay if maintainers reword the title when applying the patch,
alternatively I can send a v2. (Is it still a v2 if I change the title, or
rather a new patch?).

Any thoughts on whether this also needs a 'Cc stable'? Its not quite
clear to me if this fix meets the requirements. As above, no objections if
maintainers should decide to add it.

>
> ?
>
> Just a thought. The "Fixes:" tag covers it already, I realize.
>
> Anyway, this looks correct, and fixes that aspect of the build for me, so
> either way, please feel free to add:
>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Thanks!

	- Best Valentin
>
>
> thanks,
> --
> John Hubbard
> NVIDIA
>
> >
> > In the same scenario a gcc build would default to the host architecture,
> > i.e., it would use plain `gcc`.
> >
> > Fixes: 795285ef2425 ("selftests: Fix clang cross compilation")
> > Reviewed-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Valentin Obst <kernel@valentinobst.de>
> > ---
> > I am not entirely sure whether this behavior is in fact known and intended
> > and whether the way to obtain the host target triple is sufficiently
> > general. The flag was introduced in llvm-8 with [1], it will be an error in
> > older clang versions.
> >
> > The target triple you get with `-print-target-triple` may not be the
> > same that you would get when explicitly setting ARCH to you host
> > architecture. For example on my x86_64 system it get
> > `x86_64-pc-linux-gnu` instead of `x86_64-linux-gnu`, similar deviations
> > were observed when testing other clang binaries on compiler-explorer,
> > e.g., [2].
> >
> > An alternative could be to simply do:
> >
> >        ARCH ?= $(shell uname -m)
> >
> > before using it to select the target. Possibly with some post processing,
> > but at that point we would likely be replicating `scripts/subarch.include`.
> > This is what some subsystem Makefiles do before including `lib.mk`. This
> > change might make it possible to remove the explicit setting of `ARCH` from
> > the few subsystem Makefiles that do it.
> >
> > [1]: https://reviews.llvm.org/D50755
> > [2]: https://godbolt.org/z/r7Gn9bvv1
> >
> > Changes in v1:
> > - Shortened commit message.
> > - Link to RFC: https://lore.kernel.org/r/20240303-selftests-libmk-llvm-rfc-v1-1-9ab53e365e31@valentinobst.de
> > ---
> >   tools/testing/selftests/lib.mk | 12 ++++++++++--
> >   1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> > index da2cade3bab0..8ae203d8ed7f 100644
> > --- a/tools/testing/selftests/lib.mk
> > +++ b/tools/testing/selftests/lib.mk
> > @@ -7,6 +7,8 @@ else ifneq ($(filter -%,$(LLVM)),)
> >   LLVM_SUFFIX := $(LLVM)
> >   endif
> >
> > +CLANG := $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
> > +
> >   CLANG_TARGET_FLAGS_arm          := arm-linux-gnueabi
> >   CLANG_TARGET_FLAGS_arm64        := aarch64-linux-gnu
> >   CLANG_TARGET_FLAGS_hexagon      := hexagon-linux-musl
> > @@ -18,7 +20,13 @@ CLANG_TARGET_FLAGS_riscv        := riscv64-linux-gnu
> >   CLANG_TARGET_FLAGS_s390         := s390x-linux-gnu
> >   CLANG_TARGET_FLAGS_x86          := x86_64-linux-gnu
> >   CLANG_TARGET_FLAGS_x86_64       := x86_64-linux-gnu
> > -CLANG_TARGET_FLAGS              := $(CLANG_TARGET_FLAGS_$(ARCH))
> > +
> > +# Default to host architecture if ARCH is not explicitly given.
> > +ifeq ($(ARCH),)
> > +CLANG_TARGET_FLAGS := $(shell $(CLANG) -print-target-triple)
> > +else
> > +CLANG_TARGET_FLAGS := $(CLANG_TARGET_FLAGS_$(ARCH))
> > +endif
> >
> >   ifeq ($(CROSS_COMPILE),)
> >   ifeq ($(CLANG_TARGET_FLAGS),)
> > @@ -30,7 +38,7 @@ else
> >   CLANG_FLAGS     += --target=$(notdir $(CROSS_COMPILE:%-=%))
> >   endif # CROSS_COMPILE
> >
> > -CC := $(LLVM_PREFIX)clang$(LLVM_SUFFIX) $(CLANG_FLAGS) -fintegrated-as
> > +CC := $(CLANG) $(CLANG_FLAGS) -fintegrated-as
> >   else
> >   CC := $(CROSS_COMPILE)gcc
> >   endif # LLVM
> >
> > ---
> > base-commit: 4cece764965020c22cff7665b18a012006359095
> > change-id: 20240303-selftests-libmk-llvm-rfc-5fe3cfa9f094
> >
> > Best regards,
> > --
> > Valentin Obst <kernel@valentinobst.de>

