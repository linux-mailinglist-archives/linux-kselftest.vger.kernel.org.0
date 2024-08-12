Return-Path: <linux-kselftest+bounces-15132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 064CB94E3F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 02:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52481F212A4
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 00:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A51136A;
	Mon, 12 Aug 2024 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="F6Uj8DQ6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A6D3FD4
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Aug 2024 00:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723422085; cv=none; b=nUv6pQlN6xvKuuL6jjiIfSP/Kw6gBCZ13zZNmrsFbTcP3uk9L1SuICnRdaVYJRYQzgKvrZk2sgatWaUdJv0zSx1CfX4bxQKi1BkE/dhIEEPuXlKlJpqJ385cCPhxCthb2ismeJYBgi7th/ggM2inrcAh4tvaT5DasSqoYSOo9ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723422085; c=relaxed/simple;
	bh=mBlLatA3StdegDP7iS8wIHPEwexFOQnA/qXdV1y2ydw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TgXQRwl/wZJiPGwv9WSswQUkB8iAhwWR/nqmte+Z++Pxyp5zCrB54QQKBBxEMr3rk7MH2Lsm87nrza/ck+tJivi/3vn3bE3ckuhPv728y/9c3rD5CtpGOZ7ZyqY7vSv3Qr8m1Qu8rmDMF8Vf+vB3BsEXY7Wsk4mAux3jEWqJRO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=F6Uj8DQ6; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1723422080;
	bh=rj+A1Eq8T+83bsU/83gJ88QOdkQtzM0CeShwXFFsH0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=F6Uj8DQ6XLvSPVkyZ9ass8HVvOQJGCTVOKJ0SCkJnk+8Sy2YJtwM+QKkcwivBLtru
	 65eBXL70cNeZeykdcUcjzRql9/YweQTSLwG3NPADzOI0IFoVy3x0b8TubtjEE6JICl
	 3B9WWJk7YKH24xtMhLG4YnmEOG3BURpteXw7emGQOzn5d91NYWMjxOU72BKajw/maA
	 8ca8YnnWX2UwUBHZxyOZb0eA897Bzo1D3sdIrX0G2oUdRIgRZYuT5W9tYEHyWowh9r
	 uljao9VXexlO9Bam23cg4pfPtgmVd37PknJMArDkTUnGSnZOgR1Xjpb/dRGuaQYMbr
	 R7m+o16tbiIlw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WhwDJ4phDz4wbR;
	Mon, 12 Aug 2024 10:21:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, npiggin@gmail.com, shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftest/powerpc/benchmark: remove requirement libc-dev
In-Reply-To: <f4ae0d9e-5d1f-4b5e-92b9-aabb513e3097@csgroup.eu>
References: <20240805083008.1300853-1-maddy@linux.ibm.com>
 <f4ae0d9e-5d1f-4b5e-92b9-aabb513e3097@csgroup.eu>
Date: Mon, 12 Aug 2024 10:21:19 +1000
Message-ID: <87seva8ubk.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 05/08/2024 =C3=A0 10:30, Madhavan Srinivasan a =C3=A9crit=C2=A0:
>> Currently exec-target.c file is linked as static and this
>> post a requirement to install libc dev package to build.
>> Without it, build-breaks when compiling selftest/powerpc/benchmark.
>>=20
>>    CC       exec_target
>> /usr/bin/ld: cannot find -lc: No such file or directory
>> collect2: error: ld returned 1 exit status
>>=20
>> exec_target.c is using "syscall" library function which
>> could be replaced with a inline assembly and the same is
>> proposed as a fix here.
>>=20
>> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
>> ---
>>   tools/testing/selftests/powerpc/benchmarks/Makefile    |  2 +-
>>   .../testing/selftests/powerpc/benchmarks/exec_target.c | 10 ++++++++--
>>   2 files changed, 9 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/tools/testing/selftests/powerpc/benchmarks/exec_target.c b/=
tools/testing/selftests/powerpc/benchmarks/exec_target.c
>> index c14b0fc1edde..20027a23b594 100644
>> --- a/tools/testing/selftests/powerpc/benchmarks/exec_target.c
>> +++ b/tools/testing/selftests/powerpc/benchmarks/exec_target.c
>> @@ -7,10 +7,16 @@
>>    */
>>=20=20=20
>>   #define _GNU_SOURCE
>> -#include <unistd.h>
>>   #include <sys/syscall.h>
>>=20=20=20
>>   void _start(void)
>>   {
>> -	syscall(SYS_exit, 0);
>> +	asm volatile (
>> +		"li %%r0, %[sys_exit];"
>> +		"li %%r3, 0;"
>> +		"sc;"
>> +		:
>> +		: [sys_exit] "i" (SYS_exit)
>> +		: "r0", "r3"
>> +	);
>
> That looks ok because SYS_exit() is not supposed to return, but in the=20
> general case you should take a lot more precautions regarding which=20
> registers get clobbered when using sc.

That's my fault for just blurting out that diff on slack without
thinking about it too hard.

We should probably just add the proper clobbers, in case anyone copies
it in future. Which should be:

	asm volatile (
		"li %%r0, %[sys_exit];"
		"li %%r3, 0;"
		"sc;"
		:
		: [sys_exit] "i" (SYS_exit)
		: "r0", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
		  "r11", "r12", "r13", "cr0", "ctr", "xer", "memory"
	);

cheers

