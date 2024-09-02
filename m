Return-Path: <linux-kselftest+bounces-16981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C409689D2
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 16:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BCE1F23772
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 14:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3276419E985;
	Mon,  2 Sep 2024 14:24:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03C013C9C4;
	Mon,  2 Sep 2024 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287043; cv=none; b=cJyB7zAq3V4CiWFdritO1aU+sfsCsXaLQjUHNqR6p2gc7rKqX3huXFFt1gfPcHoeUVfktr2EMih6+viNvMJnCIIcGmlkyGbe7SLOGJIeBOwhwCkY1jYvYVf1LfKACE6XRWRcZjkQVU+KCKO2JZIEozvtSszbCYsALEQM/kLGqwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287043; c=relaxed/simple;
	bh=iLrvGpSH1QX5oZJq0n8hkED4WsYiacPD/XFaibuaEpU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=T0suhrxUkByv7fiWd7EVC8ry4XiCMKzNCIKdxGLDD0ta+l5PNrRm1StPKBGps/xDc+gBbb/k7zo4lmFo99yXREklc2+81aPfswwCPzOa3/22mtMovkjbj1XoSj1dIgAdKETlB+wgaP5i8wSwxcLZ5M4nEFwcVJDWfRHzX4SPGk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wy9wv6KxMz9sSN;
	Mon,  2 Sep 2024 16:23:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kCIfLdUv6a_x; Mon,  2 Sep 2024 16:23:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wy9wv57Crz9sRy;
	Mon,  2 Sep 2024 16:23:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9EAA88B770;
	Mon,  2 Sep 2024 16:23:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 9J2Nm99gaq24; Mon,  2 Sep 2024 16:23:59 +0200 (CEST)
Received: from [192.168.234.167] (unknown [192.168.234.167])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 41B2B8B76E;
	Mon,  2 Sep 2024 16:23:59 +0200 (CEST)
Message-ID: <2367d530-9a63-4acc-aa92-cc443477ca2c@csgroup.eu>
Date: Mon, 2 Sep 2024 16:23:59 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: vDSO: Do not rely on $ARCH for
 vdso_test_getrandom && vdso_test_chacha
From: Christophe Leroy <christophe.leroy@csgroup.eu>
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
 <cae4fb76-224e-4858-a44a-1ebb71c25821@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <cae4fb76-224e-4858-a44a-1ebb71c25821@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 02/09/2024 à 16:18, Christophe Leroy a écrit :
> 
> 
> Le 02/09/2024 à 15:57, Jason A. Donenfeld a écrit :
>> On Mon, Sep 02, 2024 at 03:23:47PM +0200, Christophe Leroy wrote:
>>>
>>>
>>> Le 02/09/2024 à 14:37, Mark Brown a écrit :
>>>> On Mon, Sep 02, 2024 at 02:22:38PM +0200, Christophe Leroy wrote:
>>>>
>>>>> When vdso_test_getcpu doesn't find the vDSO entry point, it prints 
>>>>> an error
>>>>> text and returns KSFT_SKIP
>>>>
>>>>> I thought it would be more correct to have the same behaviour on
>>>>> vdso_test_getrandom instead of trying to build it only when the 
>>>>> underlying
>>>>> kernel supports it.
>>>>
>>>> The problem is that the test incorporates assembler code so it simply
>>>> won't build for architectures without explicit porting, the issue isn't
>>>> if the target kernel supports it but rather that the test won't compile
>>>> in the first place.
>>>
>>> Yes indeed and that was the purpose of my patch, have a macro in
>>> vdso_config.h to tell where the assembler code is:
>>>
>>> diff --git a/tools/testing/selftests/vDSO/vdso_config.h
>>> b/tools/testing/selftests/vDSO/vdso_config.h
>>> index 740ce8c98d2e..693920471160 100644
>>> --- a/tools/testing/selftests/vDSO/vdso_config.h
>>> +++ b/tools/testing/selftests/vDSO/vdso_config.h
>>> @@ -47,6 +47,7 @@
>>>    #elif defined(__x86_64__)
>>>    #define VDSO_VERSION        0
>>>    #define VDSO_NAMES        1
>>> +#define VDSO_GETRANDOM
>>> "../../../../arch/x86/entry/vdso/vgetrandom-chacha.S"
>>>    #elif defined(__riscv__) || defined(__riscv)
>>>    #define VDSO_VERSION        5
>>>    #define VDSO_NAMES        1
>>>
>>>
>>> And then:
>>>
>>> diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha-asm.S
>>> b/tools/testing/selftests/vDSO/vdso_test_chacha-asm.S
>>> new file mode 100644
>>> index 000000000000..8e704165f6f2
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/vDSO/vdso_test_chacha-asm.S
>>> @@ -0,0 +1,7 @@
>>> +#include "vdso_config.h"
>>> +
>>> +#ifdef VDSO_GETRANDOM
>>> +
>>> +#include VDSO_GETRANDOM
>>> +
>>> +#endif
>>>
>>> I thought it was a lot easier to handle if through necessary #ifdefs in
>>> vdso_config.h that implementing an additional logic in Makefiles.
>>
>> Yet it still tripped up the test robot, right?
> 
> Yes I need to look at that.
> 
>>
>> In general I'm not crazy about this approach.
> 
> I have the feeling I get things done easier with that approach. But if 
> you feel better playing up with the makefile, I incline.

Also I thing that one day or another someone will want to implement it a 
more performant way on power10 which is one of the latest powerpc CPU, 
something similar to arch/powerpc/crypto/chacha-p10le-8x.S

When that happens, we will need a way to tell vdso_test_chacha to build 
another vgetrandom-chacha.S and I feel that doing it in the Makefile 
will become really tricky.

