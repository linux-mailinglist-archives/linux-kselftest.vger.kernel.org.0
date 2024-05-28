Return-Path: <linux-kselftest+bounces-10796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B368D25FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 22:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8B41F25269
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 20:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688C0178CEE;
	Tue, 28 May 2024 20:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bthHckIe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C67375809;
	Tue, 28 May 2024 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716928518; cv=none; b=iRza74zfZ1+gJ5UOZG+opODXA/QRo1DfNajjKArjcBYjZ8xg1Daxm3ruax2W4x5rjgGU47w75XW8r43X+SBpaLZKxALdNuyK0uVxoVK+TjomY4Q5OxUPqDhMmCkFXjRgbPMQDKdL2rxBVLwHSS0eF+NloFQ0l5cNsurle/WQEYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716928518; c=relaxed/simple;
	bh=EIMQ4tqK+JUU2Shu+ELX594M9kOVv7GUsWW4DjYy5ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkp2/dfw+pOM5v116s9qNKtHxuZLpAJC5IdTYPfBy0B0Uj5/SpuU9FGkEsRPCZskFgcFqadmLIvEw1RhvXU4TLv3iRBWHKTAyV7428eoOb4B12ppnWhzAoQEeDRizgNJAiwVWAbfTebUv98uNUCEwdobpBcYmuFNCmJtKdIIn5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bthHckIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BDEC3277B;
	Tue, 28 May 2024 20:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716928517;
	bh=EIMQ4tqK+JUU2Shu+ELX594M9kOVv7GUsWW4DjYy5ZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bthHckIefXTrydQ+Od1NMHOUDAjgTr85lC4GSo1iKOeL+R3ZEOH5boePap3u1VuLJ
	 j4HWCfTkQmzMCBk2B7MPh2hO14ToRjVk+cevDNN47JMCIflNhu2cppwm/uwYPvwm30
	 zAbr33Hsx+ciQhC3yI0x1Xz8frw78AzARotnpVB3jEOePD6eX5eJn6e3Zl42LeZIun
	 auTgRXrdAydoEU0hxpTbj01UzQVkvH2qD+78ZjvfZBOHTx6T0Wpb3Opt8JDKZchXA1
	 SSyT03N2k4A0L5PJYx/t8slls5bATvdOF38EwHamK/Yqze1eFeQYHp19PhFfu5DGXy
	 86KRA3yTgRA0w==
Date: Tue, 28 May 2024 13:35:15 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	sunliming <sunliming@kylinos.cn>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2] selftests/user_events: silence a clang warning:
 address of packed member
Message-ID: <20240528203515.GC2680415@thelio-3990X>
References: <20240527214704.300444-1-jhubbard@nvidia.com>
 <20240528202833.GB2680415@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528202833.GB2680415@thelio-3990X>

On Tue, May 28, 2024 at 01:28:33PM -0700, Nathan Chancellor wrote:
> Hi John,
> 
> On Mon, May 27, 2024 at 02:47:04PM -0700, John Hubbard wrote:
> > When building with clang, via:
> > 
> >     make LLVM=1 -C tools/testing/selftest
> > 
> > ...clang warns about "taking address of packed member 'write_index' ".
> > This is not particularly helpful, because the test code really wants to
> > write to exactly this location, and if it ends up being unaligned, then
> > the test won't work (and may segfault, depending on the CPU type).
> > 
> > If that ever comes up, it will be obvious and can be fixed. But all it's
> > doing now is prevent a clean clang build, so disable the warning.
> > 
> > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> > ---
> > 
> > Changes since the first version:
> > 
> > 1) Rebased onto Linux 6.10-rc1
> > 
> > 
> > thanks,
> > John Hubbard
> > 
> > 
> >  tools/testing/selftests/user_events/Makefile | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/user_events/Makefile b/tools/testing/selftests/user_events/Makefile
> > index 10fcd0066203..617e94344711 100644
> > --- a/tools/testing/selftests/user_events/Makefile
> > +++ b/tools/testing/selftests/user_events/Makefile
> > @@ -1,5 +1,10 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
> > +
> > +ifneq ($(LLVM),)
> 
> Perhaps it would be better if this were
> 
>   ifeq ($(CC),clang)
> 
> as that would catch both CC=clang and LLVM=1 users? I haven't tested
> this though.

Hmmm, now that I am actually looking at tools/testing/selftests/lib.mk,
it seems like CC is only set to clang when $(LLVM) is set, so keeping it
the way it is now is probably best. Sorry about that, I am not too
familiar with the tools build system.

> Additionally, I think it would be good to mention that
> -Wno-address-of-packed-member is GCC's default, whereas Clang enables
> -Waddress-of-packed-member by default.
> 
> > +    CFLAGS += -Wno-address-of-packed-member
> > +endif
> > +
> >  LDLIBS += -lrt -lpthread -lm
> >  
> >  TEST_GEN_PROGS = ftrace_test dyn_test perf_test abi_test
> > 
> > base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
> > -- 
> > 2.45.1
> > 
> > 
> 

