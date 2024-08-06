Return-Path: <linux-kselftest+bounces-14831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A55BA9489F7
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 09:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513D02867A4
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 07:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34401BC067;
	Tue,  6 Aug 2024 07:20:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1707816B386
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Aug 2024 07:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722928805; cv=none; b=OxEaQU25FgrM4c+WZ2DM5Ri3Qhyn/o+WARg9mzdrMG++REKy7MNyd/utKvnIW5k2NLSZBN7vMaMvkOcDvjaAH5ktHycdgFgxSd4mVcfuNmCi1RDYXq8uKhuHo3aYMdiGI1xD/WDjKB74oFEURtxw/1eckSO5/tGHTZ3L1ee40Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722928805; c=relaxed/simple;
	bh=wVVjp6LHYgO9kRWzJcBV145UyRD4l9vUvYpO5/lvJo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nBz6BFF/qAIDl0hyfh9RLsNe9E2Q1icMQrOF6z/RHiCp61yggOGqBnKt6K+aorTPCSfaDk+gSnSZKyHDQPLuQcBMVG0UQshPdBxPf+qwUJ+XzKx6ea94wqMjtXvNaHWxA28SxaMunz92JCJ0H61Q1KOXDYDgYGenYVj0Wtp5364=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WdPDw3G4Jz9sRy;
	Tue,  6 Aug 2024 08:54:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9C1_uF5rH1in; Tue,  6 Aug 2024 08:54:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WdPDw1q2qz9sRs;
	Tue,  6 Aug 2024 08:54:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1743F8B76C;
	Tue,  6 Aug 2024 08:54:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 9ed2RUntKXGp; Tue,  6 Aug 2024 08:54:40 +0200 (CEST)
Received: from [192.168.234.84] (unknown [192.168.234.84])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B17788B763;
	Tue,  6 Aug 2024 08:54:39 +0200 (CEST)
Message-ID: <f4ae0d9e-5d1f-4b5e-92b9-aabb513e3097@csgroup.eu>
Date: Tue, 6 Aug 2024 08:54:39 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest/powerpc/benchmark: remove requirement libc-dev
To: Madhavan Srinivasan <maddy@linux.ibm.com>, mpe@ellerman.id.au,
 npiggin@gmail.com, shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
References: <20240805083008.1300853-1-maddy@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240805083008.1300853-1-maddy@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 05/08/2024 à 10:30, Madhavan Srinivasan a écrit :
> Currently exec-target.c file is linked as static and this
> post a requirement to install libc dev package to build.
> Without it, build-breaks when compiling selftest/powerpc/benchmark.
> 
>    CC       exec_target
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
>   tools/testing/selftests/powerpc/benchmarks/Makefile    |  2 +-
>   .../testing/selftests/powerpc/benchmarks/exec_target.c | 10 ++++++++--
>   2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/powerpc/benchmarks/Makefile b/tools/testing/selftests/powerpc/benchmarks/Makefile
> index 1321922038d0..ca4483c238b9 100644
> --- a/tools/testing/selftests/powerpc/benchmarks/Makefile
> +++ b/tools/testing/selftests/powerpc/benchmarks/Makefile
> @@ -18,4 +18,4 @@ $(OUTPUT)/context_switch: LDLIBS += -lpthread
>   
>   $(OUTPUT)/fork: LDLIBS += -lpthread
>   
> -$(OUTPUT)/exec_target: CFLAGS += -static -nostartfiles
> +$(OUTPUT)/exec_target: CFLAGS += -nostartfiles
> diff --git a/tools/testing/selftests/powerpc/benchmarks/exec_target.c b/tools/testing/selftests/powerpc/benchmarks/exec_target.c
> index c14b0fc1edde..20027a23b594 100644
> --- a/tools/testing/selftests/powerpc/benchmarks/exec_target.c
> +++ b/tools/testing/selftests/powerpc/benchmarks/exec_target.c
> @@ -7,10 +7,16 @@
>    */
>   
>   #define _GNU_SOURCE
> -#include <unistd.h>
>   #include <sys/syscall.h>
>   
>   void _start(void)
>   {
> -	syscall(SYS_exit, 0);
> +	asm volatile (
> +		"li %%r0, %[sys_exit];"
> +		"li %%r3, 0;"
> +		"sc;"
> +		:
> +		: [sys_exit] "i" (SYS_exit)
> +		: "r0", "r3"
> +	);

That looks ok because SYS_exit() is not supposed to return, but in the 
general case you should take a lot more precautions regarding which 
registers get clobbered when using sc.

Maybe it is worth a comment.

Christophe

>   }

