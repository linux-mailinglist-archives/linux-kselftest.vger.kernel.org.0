Return-Path: <linux-kselftest+bounces-41735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DF2B80BC0
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 17:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F163ABF04
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 15:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE69341368;
	Wed, 17 Sep 2025 15:50:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A40C341365;
	Wed, 17 Sep 2025 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124237; cv=none; b=FlUph24pCRM4SAO1RWaCcwxNZfuRfvt8HokxGOIcTONnqS5sy1iNUlqsZ5VbAxEmOvpfwovYiRwX7vLh5rmXEVWOzceQyG+jBWkMUt9J7qS6RF8zhjfF3jxsCnrmE0sOPQJ06oJL1ytzWOtzX8bJfZfBhr83wEBLpx9BkyGqWrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124237; c=relaxed/simple;
	bh=gMlGy7IwJmgxQ01YDgC0fqwZq8TOm4obHsD+x0lnXD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFkEjYL/KwIke02NRt3hnE8H8/lie35JcW/q5XUNazuuagPVIVB8IvudnJLGhsqImw4UMujD1bYlCc1ODKbBmMI5yVdRmm5jEUdnMsLxvpeDSjmMIM3zBFs4LMj5he9kn9SzUKT2gRsDEzaoeZnD9fpZrh3xPlXFzs6S18KYgs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cRjGc51W3z9sxb;
	Wed, 17 Sep 2025 17:23:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id semPCKf2cGPh; Wed, 17 Sep 2025 17:23:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cRjGc3ltzz9sxZ;
	Wed, 17 Sep 2025 17:23:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 699538B76C;
	Wed, 17 Sep 2025 17:23:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id sLjYwSuYZXNq; Wed, 17 Sep 2025 17:23:52 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 38E3E8B767;
	Wed, 17 Sep 2025 17:23:40 +0200 (CEST)
Message-ID: <c4a281c7-e225-418f-95c3-8fa91073a6b4@csgroup.eu>
Date: Wed, 17 Sep 2025 17:23:40 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/36] powerpc/vdso: Explicitly include asm/cputable.h
 and asm/feature-fixups.h
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Nick Alcock <nick.alcock@oracle.com>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Shuah Khan <shuah@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Russell King
 <linux@armlinux.org.uk>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Shannon Nelson <sln@onemain.com>,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org
References: <20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de>
 <20250917-vdso-sparc64-generic-2-v3-7-3679b1bc8ee8@linutronix.de>
 <41d100c5-4706-400e-a61a-46b068f1bc74@csgroup.eu>
 <20250917171207-1fad0416-7543-481c-a998-5881fab1714e@linutronix.de>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250917171207-1fad0416-7543-481c-a998-5881fab1714e@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/09/2025 à 17:21, Thomas Weißschuh a écrit :
> On Wed, Sep 17, 2025 at 04:41:49PM +0200, Christophe Leroy wrote:
>>
>>
>> Le 17/09/2025 à 16:00, Thomas Weißschuh a écrit :
>>> The usage of ASM_FTR_IFCLR(CPU_TR_ARCH_31) requires asm/cputable.h and
>>> asm/feature-fixups.h. Currently these headers are included transitively,
>>> but that transitive inclusion is about to go away.
>>
>> Hum ...
>>
>> That was unexpectedly added by commit 9c7bfc2dc21e ("powerpc/64s: Make
>> POWER10 and later use pause_short in cpu_relax loops")
>>
>> In theory, vdso/ headers shouldn't include any headers outside of vdso/
> 
> I am aware. But this is the dependency as it exists today and I don't really
> want to make this series larger than it already is. This is by far not the
> only such layering violation in the vDSO headers. I have some patches prepared...
> 
>>> Explicitly include the headers.
>>>
>>> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>>> ---
>>>    arch/powerpc/include/asm/vdso/processor.h | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/arch/powerpc/include/asm/vdso/processor.h b/arch/powerpc/include/asm/vdso/processor.h
>>> index 80d13207c5688d73954822aede2bbe2d0e05c054..42b64903bdf47cc5bd571fc3b5caed45e6358cb9 100644
>>> --- a/arch/powerpc/include/asm/vdso/processor.h
>>> +++ b/arch/powerpc/include/asm/vdso/processor.h
>>> @@ -4,6 +4,9 @@
>>>    #ifndef __ASSEMBLY__
>>
>> __ASSEMBLY__ is replaced by __ASSEMBLER__ in powerpc-next in commit
>> 74db6cc331b0 ("powerpc: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi
>> headers")
> 
> Ack. I'll have to rebase this series after -rc1 in any case. Right now I am
> hoping to collect some Acks.
> 
>>> +#include <asm/cputable.h>
>>> +#include <asm/feature-fixups.h>
>>> +
>>>    /* Macros for adjusting thread priority (hardware multi-threading) */
>>>    #ifdef CONFIG_PPC64
>>>    #define HMT_very_low()		asm volatile("or 31, 31, 31	# very low priority")
>>>
>>


Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>



