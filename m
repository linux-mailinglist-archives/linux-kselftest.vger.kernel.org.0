Return-Path: <linux-kselftest+bounces-16910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 709C9967B99
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 20:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB15C1F217FD
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 18:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7CD433CE;
	Sun,  1 Sep 2024 18:00:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6D227713;
	Sun,  1 Sep 2024 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725213635; cv=none; b=sIrHRgaPkjphcgLbHieYpf5ZvgcuP0p4RjwjoGimRzeEjtWtiXgIY/MUJEvtCBhTZJ6NgPSbz294CA9OqTZG2A4N5YFCi4QTqq5Kv9a0/jHaYjEGsne9pSdVdM/5meyy0Am8Shv4t7b2kiel+2rF4r+PhrrjIE5ozGPaQcfblWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725213635; c=relaxed/simple;
	bh=nBna60fx3H7dMyCjFkCA8bnAJztpc/dqb3uNNM0mjXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cvmO+heNqEkZY7ohyGYmMYLKKN0/pzHgHzeoVzfgNR8TImz39gNO/Sz0NsQCS1qRdV28MsX1QEC6Csbs8J4YzkP6hSd2muuJFaSez7NlPHtsAgw2ZDOYC2x4SjHrscwhpFcPMHJQN3fvTz6DNEXUw8LcLHvp4XI5I7sag9XoeRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WxfnC1XTHz9sSN;
	Sun,  1 Sep 2024 20:00:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QsBUIDsre01c; Sun,  1 Sep 2024 20:00:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WxfnC0dYnz9sSK;
	Sun,  1 Sep 2024 20:00:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 072698B767;
	Sun,  1 Sep 2024 20:00:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id rv0CCj-cNxuj; Sun,  1 Sep 2024 20:00:30 +0200 (CEST)
Received: from [192.168.234.154] (unknown [192.168.234.154])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 978038B763;
	Sun,  1 Sep 2024 20:00:30 +0200 (CEST)
Message-ID: <667622ae-dde5-410f-a9f8-4801788af278@csgroup.eu>
Date: Sun, 1 Sep 2024 20:00:30 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: vDSO: Do not rely on $ARCH for
 vdso_test_getrandom && vdso_test_chacha
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Xi Ruoyao <xry111@xry111.site>, broonie@kernel.org
References: <ddf594c81787dba708fc392cb03027470dee64fb.1725124064.git.christophe.leroy@csgroup.eu>
 <ZtRqp-uZe5C07qOF@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <ZtRqp-uZe5C07qOF@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jason,

Le 01/09/2024 à 15:22, Jason A. Donenfeld a écrit :
> Hi Christophe,
> 
> Hmm, I'm not so sure I like this very much. I think it's important for
> these tests to fail when an arch tries to hook up the function to the
> vDSO, but it's still not exported for some reason. This also regresses
> the ARCH=x86_64 vs ARCH=x86 thing, which SRCARCH fixes.
> 
> What about, instead, something like below, replacing the other commit?

I need to look at it in more details and perfom a test, but after first 
look I can't figure out how it would work.

When I build selftests,

to build 32 bits selftests I do:

	make ARCH=powerpc CROSS_COMPILE=ppc-linux-

to build a 64 bits BE selftests I do:

	make ARCH=powerpc CROSS_COMPILE=powerpc64-linux-

to build a 64 bits LE selftests I do:

	make ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-


I addition, in case someone does the build on a native platform directly,

On 32 bits, uname -m returns 'ppc'
On 64 bits, uname -m returns 'ppc64'
On 64 bits little endian, uname -m returns 'ppc64le'

How would this fit in the logic where IIUC you just remove '_64' from 
'x86_64' to get 'x86'

Christophe

> 
> Jason
> 
>  From ccc53425c98f4f5c2a1edaf775089efb56bd106e Mon Sep 17 00:00:00 2001
> From: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Date: Sun, 1 Sep 2024 15:05:01 +0200
> Subject: [PATCH] selftests: vDSO: fix cross build for getrandom and chacha
>   tests
> 
> Unlike the check for the standalone x86 test, the check for building the
> vDSO getrandom and chacaha tests looks at the architecture for the host
> rather than the architecture for the target when deciding if they should
> be built. Since the chacha test includes some assembler code this means
> that cross building with x86 as either the target or host is broken.
> 
> There's also some additional complications, where ARCH can legitimately
> be either x86_64 or x86, but the source code we need to compile lives in
> a directory path containing arch/x86. The standard SRCARCH variable
> handles that. And actually, all these variables and proper substitutions
> are already described in tools/scripts/Makefile.arch, so just include
> that to handle it.
> 
> Similarly, ARCH=x86 can actually describe ARCH=x86_64,
> just with CONFIG_64BIT, so we can't rely on ARCH for selecting
> non-32-bit tests. For that, check against $(ARCH)$(CONFIG_X86_32). This
> won't help for people manually running this inside the vDSO selftest
> directory (which isn't really supported anyway and has problems on
> various archs), but it should work for builds of the kselftests, where
> the CONFIG_* variables are defined. On x86_64 machines,
> $(ARCH)$(CONFIG_X86_32) will evaluate to x86. On arm64 machines, it will
> evaluate to arm64. On 32-bit x86 machines, it will evaluate to x86y,
> which won't match the filter list.
> 
> Reported-by: Mark Brown <broonie@kernel.org>
> Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>   tools/testing/selftests/vDSO/Makefile | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
> index e21e78aae24d..01a5805062b3 100644
> --- a/tools/testing/selftests/vDSO/Makefile
> +++ b/tools/testing/selftests/vDSO/Makefile
> @@ -1,6 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
> -uname_M := $(shell uname -m 2>/dev/null || echo not)
> -ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
> +include ../../../scripts/Makefile.arch
> 
>   TEST_GEN_PROGS := vdso_test_gettimeofday
>   TEST_GEN_PROGS += vdso_test_getcpu
> @@ -10,7 +9,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
>   TEST_GEN_PROGS += vdso_standalone_test_x86
>   endif
>   TEST_GEN_PROGS += vdso_test_correctness
> -ifeq ($(uname_M),x86_64)
> +ifeq ($(ARCH)$(CONFIG_X86_32),$(filter $(ARCH)$(CONFIG_X86_32),x86))
>   TEST_GEN_PROGS += vdso_test_getrandom
>   TEST_GEN_PROGS += vdso_test_chacha
>   endif
> @@ -38,8 +37,8 @@ $(OUTPUT)/vdso_test_getrandom: CFLAGS += -isystem $(top_srcdir)/tools/include \
>                                            $(KHDR_INCLUDES) \
>                                            -isystem $(top_srcdir)/include/uapi
> 
> -$(OUTPUT)/vdso_test_chacha: $(top_srcdir)/tools/arch/$(ARCH)/vdso/vgetrandom-chacha.S
> +$(OUTPUT)/vdso_test_chacha: $(top_srcdir)/tools/arch/$(SRCARCH)/vdso/vgetrandom-chacha.S
>   $(OUTPUT)/vdso_test_chacha: CFLAGS += -idirafter $(top_srcdir)/tools/include \
> -                                      -idirafter $(top_srcdir)/arch/$(ARCH)/include \
> +                                      -idirafter $(top_srcdir)/arch/$(SRCARCH)/include \
>                                         -idirafter $(top_srcdir)/include \
>                                         -D__ASSEMBLY__ -Wa,--noexecstack
> --
> 2.46.0
> 
> 

