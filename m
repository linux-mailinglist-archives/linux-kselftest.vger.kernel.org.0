Return-Path: <linux-kselftest+bounces-16417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996B59610C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54BFE2820C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 15:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3766A1C57A9;
	Tue, 27 Aug 2024 15:12:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA741BC9E3;
	Tue, 27 Aug 2024 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771545; cv=none; b=aLe0An4oAh9joHquYAHOMf39SAfSfkAqGkdeGAUvgqO33cdT9C4nMhj94O8nK07LOwILpWGxfXWUDa4ZQW5Ayrqhp+6QPEUSeE9DdGaQOcasiAHDYZaiKdwIe6AaL7nz9KMThVjW4NcGKnYg7H7jOglzni1dDlnEhXOLhfPz0YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771545; c=relaxed/simple;
	bh=YS1WS6AMQC0AIGR4KIux8obLAvmAK9y0e/V4joi0yis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7oVidnlWHOWyuJsREzQRSfjCg6rb7NuRhhJIvfPA/kA83k7nLVI8HgRLOoFFwgabMqxVQRkpongzqsoWVCtK5sY+z+PZLhCGCavBsZNvsfIowyoIl1YNTBpduuwgt+wfrF/gSxpVubRo3db9/Io6hXSazCrnKK8HuKeFrVR+cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WtWHT4Q90z9sPd;
	Tue, 27 Aug 2024 17:12:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sLT0wIHpPuNS; Tue, 27 Aug 2024 17:12:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WtWHT3WwTz9rvV;
	Tue, 27 Aug 2024 17:12:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 692058B78B;
	Tue, 27 Aug 2024 17:12:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id J_l_rLP-Y5G0; Tue, 27 Aug 2024 17:12:21 +0200 (CEST)
Received: from [192.168.233.149] (unknown [192.168.233.149])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CF8898B77C;
	Tue, 27 Aug 2024 17:12:20 +0200 (CEST)
Message-ID: <538e9c85-8050-427d-a513-3194bae67115@csgroup.eu>
Date: Tue, 27 Aug 2024 17:12:20 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] selftests/vDSO: Use KHDR_INCLUDES to locate UAPI
 headers for vdso_test_getrandom
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
 Jinyang He <hejinyang@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 Arnd Bergmann <arnd@arndb.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20240827132018.88854-1-xry111@xry111.site>
 <20240827132018.88854-4-xry111@xry111.site> <Zs3blfx1inX_FQLR@zx2c4.com>
 <019268d4-c177-49e7-aab3-b8fa431905ca@cs-soprasteria.com>
 <Zs3fhiSlXg2aCGa8@zx2c4.com>
 <e9a2257f1447ce11e1f22e9a3c64d4b18aa428e1.camel@xry111.site>
 <0730ca3a-e158-44ea-bb9e-1a7716b45360@csgroup.eu>
 <Zs3qEMQOv5MAipox@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Zs3qEMQOv5MAipox@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/08/2024 à 17:00, Jason A. Donenfeld a écrit :
> On Tue, Aug 27, 2024 at 04:50:59PM +0200, Christophe Leroy wrote:
>>
>>
>> Le 27/08/2024 à 16:41, Xi Ruoyao a écrit :
>>> On Tue, 2024-08-27 at 16:15 +0200, Jason A. Donenfeld wrote:
>>>
>>> /* snip */
>>>
>>>> gcc -std=gnu99 -D_GNU_SOURCE= -isystem /home/zx2c4/Projects/random-linux/tools/testing/selftests/../../../tools/include -isystem /home/zx2c4/Projects/random-linux/tools/testing/selftests/../../../usr/include    vdso_test_getrandom.c parse_vdso.c  -o /home/zx2c4/Projects/random-linux/tools/testing/selftests/vDSO/vdso_test_getrandom
>>>> vdso_test_getrandom.c:43:41: error: field ‘params’ has incomplete type
>>>>      43 |         struct vgetrandom_opaque_params params;
>>>>         |                                         ^~~~~~
>>>>
>>>> $ ls /home/zx2c4/Projects/random-linux/tools/testing/selftests/../../../usr/include
>>>> headers_check.pl  Makefile
>>>>
>>>> Since I don't build in there, this directory is empty.
>>>
>>> In the toplevel Makefile:
>>>
>>> kselftest-%: headers FORCE
>>>       $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
>>>
>>> So running "make kselftest-all" to build the self tests should have
>>> already caused make to build the "headers" target, which puts the
>>> headers into usr/include.
>>>
>>> I don't think it's supported to build self tests w/o invoking the
>>> toplevel Makefile: many other self tests use KHDR_INCLUDES as well, so
>>> generally building with something like "make -C tools/testing/selftests"
>>> just won't work.
>>>
>>
>> My usr/include/ is also empty (only Makefile and headers_check.pl) and
>> building directly in tools/testing/selftests/vDSO works for me.
>>
>> The command is:
>>
>> ppc-linux-gcc -std=gnu99 -D_GNU_SOURCE= -isystem
>> /home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include
>> -isystem
>> /home/chleroy/linux-powerpc/tools/testing/selftests/../../../include/uapi
>>      vdso_test_getrandom.c parse_vdso.c  -o
>> /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_getrandom
>>
>> I believe I get the needed headers through : -isystem
>> /home/chleroy/linux-powerpc/tools/testing/selftests/../../../include/uapi
> 
> The effect of this patch is to replace include/uapi with usr/include, so
> it will break for you too.
> 
> What I'm wondering is why yours and mine work like that, while Ruoyao's
> breaks. He makes a good argument as to why this patch is the "right
> way", even if it breaks our workflow...

Ah yes he is probably right.

Then I'll have to first do:

make CROSS_COMPILE=powerpc64-linux- ARCH=powerpc headers

Then everything should be fine.

Christophe

> 
>>
>> Christophe
>>
>> PS: By the way, did you see the -DBULID_VDSO for the chacha test ? Don't
>> know the impact though ....
> 
> Yes and https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20240827145454.3317093-1-Jason%40zx2c4.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C627846cc0a0e429e45c508dcc6a90690%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638603676502990226%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=H7PPFv8QGHsb9xh3J%2FzyeFrpvDu2uSKqx4ZwrPNwC2s%3D&reserved=0

