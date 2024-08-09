Return-Path: <linux-kselftest+bounces-15052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2832C94C96E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 06:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48871F22689
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 04:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BD1166310;
	Fri,  9 Aug 2024 04:54:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F6424B34
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Aug 2024 04:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723179268; cv=none; b=GgaRhpEqULPYnKBCTw50bVqlh/cFYv7L00omhSn517F0ZXAhgEbUPNToeaKPfSzj12yXW98dDR7WFlH3NaYgW9wQLH7D/UhRY95N3rnVJCIJPEACN5qUiZ84chw/rDgdjIJwlsrAY2zYIAiBtE362Sux6xWyUTf6+Tgyn7NZ9fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723179268; c=relaxed/simple;
	bh=OSv8SP//Jz++N8qm75X4cenikA1V+D53xYBwOaV0e78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvF22+5o2EaAJ43ZYhcJEcL7FS4S7UQ/no//eR7XxedF4epRVxDIPt1Upe52UTuZLWnKqD8mocUSBUKlsEQar7sKFOCz/1Jqb/DWjNmkI5IkDJZLyeKbIXJwR9EWPRwxyf9Nh4zNDIbDFwi/y9G2hi79EZBl9SyszP4IL71P2Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WgBQf4JN9z9sPd;
	Fri,  9 Aug 2024 06:54:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id miJVm8R5-rkm; Fri,  9 Aug 2024 06:54:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WgBQf3MB7z9rvV;
	Fri,  9 Aug 2024 06:54:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6103E8B76C;
	Fri,  9 Aug 2024 06:54:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id pI3wWWHAvrH0; Fri,  9 Aug 2024 06:54:18 +0200 (CEST)
Received: from [192.168.234.192] (unknown [192.168.234.192])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E93F78B763;
	Fri,  9 Aug 2024 06:54:17 +0200 (CEST)
Message-ID: <493e1a40-6847-4be8-8978-ed71e7b8bf8c@csgroup.eu>
Date: Fri, 9 Aug 2024 06:54:17 +0200
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
 <f4ae0d9e-5d1f-4b5e-92b9-aabb513e3097@csgroup.eu>
 <6e26fec3-0c27-45da-bd3b-69d3b7e0e493@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <6e26fec3-0c27-45da-bd3b-69d3b7e0e493@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/08/2024 à 06:25, Madhavan Srinivasan a écrit :
> 
> On 8/6/24 12:24 PM, Christophe Leroy wrote:
>>
>>
>> Le 05/08/2024 à 10:30, Madhavan Srinivasan a écrit :
>>> Currently exec-target.c file is linked as static and this
>>> post a requirement to install libc dev package to build.
>>> Without it, build-breaks when compiling selftest/powerpc/benchmark.
>>>
>>>    CC       exec_target
>>> /usr/bin/ld: cannot find -lc: No such file or directory
>>> collect2: error: ld returned 1 exit status
>>>
>>> exec_target.c is using "syscall" library function which
>>> could be replaced with a inline assembly and the same is
>>> proposed as a fix here.
>>>
>>> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>>> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
>>> ---
>>>   tools/testing/selftests/powerpc/benchmarks/Makefile    |  2 +-
>>>   .../testing/selftests/powerpc/benchmarks/exec_target.c | 10 ++++++++--
>>>   2 files changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/powerpc/benchmarks/Makefile 
>>> b/tools/testing/selftests/powerpc/benchmarks/Makefile
>>> index 1321922038d0..ca4483c238b9 100644
>>> --- a/tools/testing/selftests/powerpc/benchmarks/Makefile
>>> +++ b/tools/testing/selftests/powerpc/benchmarks/Makefile
>>> @@ -18,4 +18,4 @@ $(OUTPUT)/context_switch: LDLIBS += -lpthread
>>>     $(OUTPUT)/fork: LDLIBS += -lpthread
>>>   -$(OUTPUT)/exec_target: CFLAGS += -static -nostartfiles
>>> +$(OUTPUT)/exec_target: CFLAGS += -nostartfiles
>>> diff --git a/tools/testing/selftests/powerpc/benchmarks/exec_target.c 
>>> b/tools/testing/selftests/powerpc/benchmarks/exec_target.c
>>> index c14b0fc1edde..20027a23b594 100644
>>> --- a/tools/testing/selftests/powerpc/benchmarks/exec_target.c
>>> +++ b/tools/testing/selftests/powerpc/benchmarks/exec_target.c
>>> @@ -7,10 +7,16 @@
>>>    */
>>>     #define _GNU_SOURCE
>>> -#include <unistd.h>
>>>   #include <sys/syscall.h>
>>>     void _start(void)
>>>   {
>>> -    syscall(SYS_exit, 0);
>>> +    asm volatile (
>>> +        "li %%r0, %[sys_exit];"
>>> +        "li %%r3, 0;"
>>> +        "sc;"
>>> +        :
>>> +        : [sys_exit] "i" (SYS_exit)
>>> +        : "r0", "r3"
>>> +    );
>>
>> That looks ok because SYS_exit() is not supposed to return, but in the 
>> general case you should take a lot more precautions regarding which 
>> registers get clobbered when using sc.
>>
>> Maybe it is worth a comment.
> 
> 
> ok sure and something like this will help?
> 
> 
> +        : "r0", "r3" //clobber registers, r0 - syscall number, r3 - 
> exit value
> 

Not really.

sc will clobber r0 and r3-r12, also SO bit in CR.

Here the reason why you have no problem with that is that SYS_exit never 
returns. At the end, even your "r0" and "r3" clobber are unnecessary 
because of that.

Christophe

