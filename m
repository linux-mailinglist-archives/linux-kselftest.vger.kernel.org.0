Return-Path: <linux-kselftest+bounces-16914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF5C967BD1
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 20:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78C1280B40
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 18:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E71045BEF;
	Sun,  1 Sep 2024 18:43:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C7917BA6;
	Sun,  1 Sep 2024 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725216195; cv=none; b=oIFjknGmvngqSfD5VOKMrghBjPHPp0avkoqdko0GnGvbs0J3mvMWUhnIVLZvu7ln9cvZhRSINWPgPSo43vcNOs/Ayj1odk06CDs9YSOIFkgSFp5aCOlDtV1+J/YP8eZoVTf/DK7smjdJ2fCrF7RToEzvSEGW4jCTSM0AQW0+vHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725216195; c=relaxed/simple;
	bh=UVSOd/WYdmt9syjO5zHmRNT8dh7mNVs3oIjfiXs0is0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqxao9csaxiAmiETRlocf4T8QBiO1SVezN4H7a7wwAuKgP4rP3B4rKhZikLWCzOd8Qz8SMARULRYnSK/o1/miMhUT5BiRZvixjYfrhJaTXTHjxYAgc1sFZOi9FpDcPrN88aPvbqgzDR6oatG1rqm7xzL+knFz7PMHEcvNg0Gt9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WxgkR2wZlz9sSN;
	Sun,  1 Sep 2024 20:43:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f-QtdpVYL6Kf; Sun,  1 Sep 2024 20:43:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WxgkR1q5hz9sSK;
	Sun,  1 Sep 2024 20:43:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 243378B767;
	Sun,  1 Sep 2024 20:43:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id hFIeW2c4y8Oo; Sun,  1 Sep 2024 20:43:11 +0200 (CEST)
Received: from [192.168.234.154] (unknown [192.168.234.154])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C33B98B763;
	Sun,  1 Sep 2024 20:43:10 +0200 (CEST)
Message-ID: <efca582d-20e9-4871-bcd8-5abcdb0c22f3@csgroup.eu>
Date: Sun, 1 Sep 2024 20:43:10 +0200
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
 <667622ae-dde5-410f-a9f8-4801788af278@csgroup.eu>
 <ZtSsTkTUCGyxaN_d@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <ZtSsTkTUCGyxaN_d@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 01/09/2024 à 20:02, Jason A. Donenfeld a écrit :
> On Sun, Sep 01, 2024 at 08:00:30PM +0200, Christophe Leroy wrote:
>> Hi Jason,
>>
>> Le 01/09/2024 à 15:22, Jason A. Donenfeld a écrit :
>>> Hi Christophe,
>>>
>>> Hmm, I'm not so sure I like this very much. I think it's important for
>>> these tests to fail when an arch tries to hook up the function to the
>>> vDSO, but it's still not exported for some reason. This also regresses
>>> the ARCH=x86_64 vs ARCH=x86 thing, which SRCARCH fixes.
>>>
>>> What about, instead, something like below, replacing the other commit?
>>
>> I need to look at it in more details and perfom a test, but after first
>> look I can't figure out how it would work.
>>
>> When I build selftests,
>>
>> to build 32 bits selftests I do:
>>
>> 	make ARCH=powerpc CROSS_COMPILE=ppc-linux-
>>
>> to build a 64 bits BE selftests I do:
>>
>> 	make ARCH=powerpc CROSS_COMPILE=powerpc64-linux-
>>
>> to build a 64 bits LE selftests I do:
>>
>> 	make ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-
>>
>>
>> I addition, in case someone does the build on a native platform directly,
>>
>> On 32 bits, uname -m returns 'ppc'
>> On 64 bits, uname -m returns 'ppc64'
>> On 64 bits little endian, uname -m returns 'ppc64le'
>>
>> How would this fit in the logic where IIUC you just remove '_64' from
>> 'x86_64' to get 'x86'
> 
> Huh? That's not what tools/scripts/Makefile.arch does.

Hum ... yes sorry I looked at it too quickly and mixed things up with 
the other patch.

Nevertheless, if I understand well what tools/scripts/Makefile.arch does 
on an x86_64 for instance:

uname -m returns x86_64
HOSTARCH = x86 (sed -e s/x86_64/x86)
ARCH = x86
SRCARCH = x86

If you build with make ARCH=x86_64,
SRCARCH = x86

So I still can't see how you can use that to know if it is a x86_64 or not.

I don't see either what could be the result for powerpc.

By the way, in your patch I don't think you can use CONFIG_X86_32, 
CONFIG symbols are not known when building selftests.

Christophe

