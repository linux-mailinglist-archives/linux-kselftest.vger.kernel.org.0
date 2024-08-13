Return-Path: <linux-kselftest+bounces-15199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FBD94FEF5
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 09:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A9C1F23A0E
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 07:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662216BFC0;
	Tue, 13 Aug 2024 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="g3u6x2Gm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85F458ABF
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 07:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723534907; cv=none; b=H02nI7w4J6g8g9OPVTr9qS3qvsR5FxW5sOMMgFV/S6lpmButUjHXb7AXXhhXbVUaTYgQ4mfdxtNLVd0huWk+UlNtnrbPLjnvmewmvyQil253WMbTXhSUWWcDmVbNXXWm+x5siw+Js6GMsdd+x2olmGG/htrOshrfbiOEx8n0vY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723534907; c=relaxed/simple;
	bh=fm9Kpt57b40yadm64AoXBXQzx/9uDgSr9tOs6LUFcus=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JZBFFuFeo5KwUni+F7u8TJQjkZ55N588WAPVsMr44aSqaaxvgMHi2jQEGTMH4YTWKEG5OFgGXOe78g4OWftKqdTYEZpEqr8miuvt9853n6wgExDYveNO5w04eMboqZ9QMAA2jxr3mgqe10HFqM0fT1c1NHYGLD1dDuSC5xKR1BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=g3u6x2Gm; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1723534901;
	bh=HADWfDzMp04GGptzdq/izw7iCG7iWe0aK2JW4OGIX/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=g3u6x2GmJgmwseBPqEFiJU6QSAsQ1JEOnc0i547A/EudElq6JUJ6CBZSD/Wkp4BPY
	 nPlqArhJFiTwgvbg21halm4oxxLHDAH40TTwEDhaUDrRDWCOBttwcj/ykT/eUM3hVj
	 7uF2DjEb7A0NlSusrSuMA+fAg3OwRyea8VCfbDAMwILgZs1E56S+YU5W7eg/pfS5kd
	 H6/80Gg7AUMj6mQlqA5A+Z+J4ftytXK1iu8Lt4JxKiZ7kQ55A0zcKy1G+zeAzjVwH1
	 /nF+lnMhsGctaJOn1oK1lg8enNq7oz21oRZnuMKQbeIRLS8GToemBu1r+3VUVlVxXI
	 E2gJIiTp58f+g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wjjxx5kbMz4x1s;
	Tue, 13 Aug 2024 17:41:41 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, Madhavan
 Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH v2] selftest/powerpc/benchmark: remove requirement libc-dev
In-Reply-To: <20240812094152.418586-1-maddy@linux.ibm.com>
References: <20240812094152.418586-1-maddy@linux.ibm.com>
Date: Tue, 13 Aug 2024 17:41:41 +1000
Message-ID: <87wmkk27ka.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Madhavan Srinivasan <maddy@linux.ibm.com> writes:
> Currently exec-target.c file is linked as static and this
> post a requirement to install libc dev package to build.

I think specifically the problem is that the test requires a static
libc, which is packaged separately in some distros from the regular libc
headers, am I right?

On Fedora the package is glibc-static, as opposed to glibc-devel, which
the tests still require.

So this patch removes the requirement to have glibc-static installed.
Any idea what the package is called on Debian/Ubuntu?

cheers

> Without it, build-break when compiling selftest/powerpc/benchmark.
>
>   CC       exec_target
> /usr/bin/ld: cannot find -lc: No such file or directory
> collect2: error: ld returned 1 exit status
>
> exec_target.c is using "syscall" library function which
> could be replaced with a inline assembly and the same is
> proposed as a fix here.
>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> ---
> Chnagelog v1:
> - Add comment for clobber register and proper list of
>   clobber registers as suggested by Michael Ellerman and
>   Christophe Leroy
>
>  .../selftests/powerpc/benchmarks/Makefile        |  2 +-
>  .../selftests/powerpc/benchmarks/exec_target.c   | 16 ++++++++++++++--
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/powerpc/benchmarks/Makefile b/tools/testing/selftests/powerpc/benchmarks/Makefile
> index 1321922038d0..ca4483c238b9 100644
> --- a/tools/testing/selftests/powerpc/benchmarks/Makefile
> +++ b/tools/testing/selftests/powerpc/benchmarks/Makefile
> @@ -18,4 +18,4 @@ $(OUTPUT)/context_switch: LDLIBS += -lpthread
>  
>  $(OUTPUT)/fork: LDLIBS += -lpthread
>  
> -$(OUTPUT)/exec_target: CFLAGS += -static -nostartfiles
> +$(OUTPUT)/exec_target: CFLAGS += -nostartfiles
> diff --git a/tools/testing/selftests/powerpc/benchmarks/exec_target.c b/tools/testing/selftests/powerpc/benchmarks/exec_target.c
> index c14b0fc1edde..a6408d3f26cd 100644
> --- a/tools/testing/selftests/powerpc/benchmarks/exec_target.c
> +++ b/tools/testing/selftests/powerpc/benchmarks/exec_target.c
> @@ -7,10 +7,22 @@
>   */
>  
>  #define _GNU_SOURCE
> -#include <unistd.h>
>  #include <sys/syscall.h>
>  
>  void _start(void)
>  {
> -	syscall(SYS_exit, 0);
> +	asm volatile (
> +		"li %%r0, %[sys_exit];"
> +		"li %%r3, 0;"
> +		"sc;"
> +		:
> +		: [sys_exit] "i" (SYS_exit)
> +		/*
> +		 * "sc" will clobber r0, r3-r13, cr0, ctr, xer and memory.
> +		 * Even though sys_exit never returns, handle clobber
> +		 * registers.
> +		 */
> +		: "r0", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
> +		  "r11", "r12", "r13", "cr0", "ctr", "xer", "memory"
> +	);
>  }
> -- 
> 2.45.2

