Return-Path: <linux-kselftest+bounces-18161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F0D97D3A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 11:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A2C1F27645
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 09:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116677DA8C;
	Fri, 20 Sep 2024 09:33:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA5C13A265
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726824808; cv=none; b=G5A0zZtXTXU3w3JfSLYHlw3RgjBhPFqZ/mdXYMjO/Ml7ziL5vPfjlKY/834veMqRCD9bh5/NQUSV8EF9pE5iU2Kfm13JLXe0o8Uc3G800zb8KtHOIBXMtnHJBrvbNppLPdcIfaLPB5D9GZsaDH0WVr8j4UDiqEuKQO68rlXH4tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726824808; c=relaxed/simple;
	bh=6UDg+l1JcZseEPirBBIBXXm9e/Pn+erzR5gaK/0I2Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ay+yWKhl4tcfR7vlqpyChwtlYpsd6ANGvciXfmdRfQWyuW+R0SS7vhKkkpb3Do0T4ihyQJLxmfLIzhJwJBxh1KEukjpMFibzaSMlOMlp16QcqhGohqmKxGUqCVkCWTl58usd7RMHfJZDgixrSnfwhuV2SQg3R6PK3aLTVF+R/EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X96dF3S0wz9tQp;
	Fri, 20 Sep 2024 11:33:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NSYxwh3eUKj4; Fri, 20 Sep 2024 11:33:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X96dF2jGcz9tQn;
	Fri, 20 Sep 2024 11:33:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4A7A38B77E;
	Fri, 20 Sep 2024 11:33:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id l0_JRxjy2UhN; Fri, 20 Sep 2024 11:33:21 +0200 (CEST)
Received: from [192.168.232.48] (unknown [192.168.232.48])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D0D188B77D;
	Fri, 20 Sep 2024 11:33:20 +0200 (CEST)
Message-ID: <3e3507d8-f17c-4af8-83cb-682190f5bf67@csgroup.eu>
Date: Fri, 20 Sep 2024 11:33:20 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: vDSO: fix compile error for
 vdso_test_getrandom
To: Yu Liao <liaoyu15@huawei.com>, Shuah Khan <skhan@linuxfoundation.org>,
 shuah@kernel.org
Cc: liwei391@huawei.com, Jason@zx2c4.com, broonie@kernel.org,
 linux-kselftest@vger.kernel.org, Xie XiuQi <xiexiuqi@huawei.com>
References: <20240919111841.20226-1-liaoyu15@huawei.com>
 <20ef1a1d-db00-44a7-a550-0b293d6e0d0e@linuxfoundation.org>
 <0010d5c7-388e-d648-8320-83b9fd16e615@huawei.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <0010d5c7-388e-d648-8320-83b9fd16e615@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 20/09/2024 à 03:54, Yu Liao a écrit :
> [Vous ne recevez pas souvent de courriers de liaoyu15@huawei.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> On 2024/9/20 0:51, Shuah Khan wrote:
> 
>>> diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
>>> b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
>>> index 72a1d9b43a84..84f2bbb2d5e0 100644
>>> --- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
>>> +++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
>>> @@ -19,6 +19,7 @@
>>>    #include <sys/ptrace.h>
>>>    #include <sys/wait.h>
>>>    #include <sys/types.h>
>>> +#include <linux/sched.h>

This not correct. According to man page of clone(2), CLONE_ macros are 
in <sched.h>, you should include <sched.h> instead.

See https://man7.org/linux/man-pages/man2/clone.2.html

By the way on my environment (gcc 12.2 + glibc 2.38), <sched.h> gets 
already indirectly included by <phread.h>, and at the end the 
CLONE_NEWTIME is in glibc headers in usr/include/bits/sched.h

>>>    #include <linux/random.h>
>>>    #include <linux/compiler.h>
>>>    #include <linux/ptrace.h>
>>
>> Do you see this error after installing headers? Installing headers is
>> a dependency to be able to compile selftests.
>>
> 
> Yes, this error still exists after installing header files. Here are my steps
> to reproduce:
> 
> make headers_install
> make -C tools/testing/selftests TARGETS=vDSO
> 
> After applying the patch, the error no longer appears.
> 
> Best regards,
> Yu

