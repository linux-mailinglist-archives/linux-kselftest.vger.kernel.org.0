Return-Path: <linux-kselftest+bounces-16979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BF29689B8
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 16:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18B54B230CD
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 14:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579B519E98A;
	Mon,  2 Sep 2024 14:18:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8646613C9C7;
	Mon,  2 Sep 2024 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286715; cv=none; b=p7H+EeqQX3tUjm+rZG5S7UdYyo5GR7nuUis+YMFCafTcx/4U3Cy4laLQ15xlf3h2+HaOLir+/IWBFQrY6AoFw60DAoCMPYvnIG76t1bNog7VaI57AsP4NE0wt6IFImmlRpHNjovcfl79/MOtlzpdLZrSu4t+DaE1rPqqlGrncsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286715; c=relaxed/simple;
	bh=+VuG2M1xa3MWBHUbHXGPrWXef37LtbrfQ9WXZ8TCtCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBTLj2iW+bTnxzQowEUXEVundrgheLVBam6FHhgKywr2uZN9yaFHFyj++RQ0SzSI0+8AjhAEfBze2J/inOWBYpxc4E5smz+pGccKNv0001HOU/fEV+6bg069MBGD5Kapuknaus7P2X5rX8MaIHEsrV8TtC0yhE3mnBKGx1eovWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wy9pb6jQMz9sST;
	Mon,  2 Sep 2024 16:18:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dYB5tVBeTlu0; Mon,  2 Sep 2024 16:18:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wy9pb5jKRz9sSS;
	Mon,  2 Sep 2024 16:18:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B4D598B76C;
	Mon,  2 Sep 2024 16:18:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id r6wBvH7GjfCs; Mon,  2 Sep 2024 16:18:31 +0200 (CEST)
Received: from [192.168.234.167] (unknown [192.168.234.167])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5B5558B763;
	Mon,  2 Sep 2024 16:18:31 +0200 (CEST)
Message-ID: <cae4fb76-224e-4858-a44a-1ebb71c25821@csgroup.eu>
Date: Mon, 2 Sep 2024 16:18:31 +0200
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
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Xi Ruoyao <xry111@xry111.site>
References: <ddf594c81787dba708fc392cb03027470dee64fb.1725124064.git.christophe.leroy@csgroup.eu>
 <ZtRqp-uZe5C07qOF@zx2c4.com>
 <fe8ea6a6-71d7-4cfc-b20b-fa0a7f39a4be@csgroup.eu>
 <ec7bfeb4-30aa-4874-98b7-7877a12cb98f@sirena.org.uk>
 <ffc5600d-362f-4400-8f8b-a1ea77ca51bf@csgroup.eu>
 <ZtXEUZC_jRBSAG9k@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <ZtXEUZC_jRBSAG9k@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 02/09/2024 à 15:57, Jason A. Donenfeld a écrit :
> On Mon, Sep 02, 2024 at 03:23:47PM +0200, Christophe Leroy wrote:
>>
>>
>> Le 02/09/2024 à 14:37, Mark Brown a écrit :
>>> On Mon, Sep 02, 2024 at 02:22:38PM +0200, Christophe Leroy wrote:
>>>
>>>> When vdso_test_getcpu doesn't find the vDSO entry point, it prints an error
>>>> text and returns KSFT_SKIP
>>>
>>>> I thought it would be more correct to have the same behaviour on
>>>> vdso_test_getrandom instead of trying to build it only when the underlying
>>>> kernel supports it.
>>>
>>> The problem is that the test incorporates assembler code so it simply
>>> won't build for architectures without explicit porting, the issue isn't
>>> if the target kernel supports it but rather that the test won't compile
>>> in the first place.
>>
>> Yes indeed and that was the purpose of my patch, have a macro in
>> vdso_config.h to tell where the assembler code is:
>>
>> diff --git a/tools/testing/selftests/vDSO/vdso_config.h
>> b/tools/testing/selftests/vDSO/vdso_config.h
>> index 740ce8c98d2e..693920471160 100644
>> --- a/tools/testing/selftests/vDSO/vdso_config.h
>> +++ b/tools/testing/selftests/vDSO/vdso_config.h
>> @@ -47,6 +47,7 @@
>>    #elif defined(__x86_64__)
>>    #define VDSO_VERSION		0
>>    #define VDSO_NAMES		1
>> +#define VDSO_GETRANDOM	
>> "../../../../arch/x86/entry/vdso/vgetrandom-chacha.S"
>>    #elif defined(__riscv__) || defined(__riscv)
>>    #define VDSO_VERSION		5
>>    #define VDSO_NAMES		1
>>
>>
>> And then:
>>
>> diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha-asm.S
>> b/tools/testing/selftests/vDSO/vdso_test_chacha-asm.S
>> new file mode 100644
>> index 000000000000..8e704165f6f2
>> --- /dev/null
>> +++ b/tools/testing/selftests/vDSO/vdso_test_chacha-asm.S
>> @@ -0,0 +1,7 @@
>> +#include "vdso_config.h"
>> +
>> +#ifdef VDSO_GETRANDOM
>> +
>> +#include VDSO_GETRANDOM
>> +
>> +#endif
>>
>> I thought it was a lot easier to handle if through necessary #ifdefs in
>> vdso_config.h that implementing an additional logic in Makefiles.
> 
> Yet it still tripped up the test robot, right?

Yes I need to look at that.

> 
> In general I'm not crazy about this approach.

I have the feeling I get things done easier with that approach. But if 
you feel better playing up with the makefile, I incline.

