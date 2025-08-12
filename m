Return-Path: <linux-kselftest+bounces-38760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBECB21E2D
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 08:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4CB67A1F89
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 06:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155722C21CE;
	Tue, 12 Aug 2025 06:20:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0935F15383A;
	Tue, 12 Aug 2025 06:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754979638; cv=none; b=FygcVDG3d8SDz3nxwQFApn0px2hCOEc0xgpnfD/Ex/NQ6H2e3rubtGNQTujFECP3rMs2Bq28MwD3BZKVTSunrRXlcvdxl1BT/BLwPS4Ge5fz0LawQ7Cl+YKRjGiRQdUTZ6hzpXWm8hPLzbKM+K1iEPQ31mDkk/Swmp1dM+gBwn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754979638; c=relaxed/simple;
	bh=Y7VqHf4C+JSQxOFwIP6hzbmo5lu9mZzg++Z+7+9xQJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOdj6knzg2b9C9uHB5eGWNS2GhonIWqNlp+kzHocmAjpTqbfBgudCdVoQZyzBD/TYTezklt9rwmrJC5t4KsKzoEba7jPO7AruOXkQurogmgjQkFjKxddULzpBgqjvOy3K9FqhRFviV62Fvfg1ReZFkXyGpJnKAK+JQyVdr6Tc+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c1LbP1ZCQz9sSH;
	Tue, 12 Aug 2025 08:05:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3WR0gSTJzGY1; Tue, 12 Aug 2025 08:05:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c1LbP0Kj8z9sSC;
	Tue, 12 Aug 2025 08:05:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DE8C38B764;
	Tue, 12 Aug 2025 08:05:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id VXWlAoGWUx8D; Tue, 12 Aug 2025 08:05:52 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C6768B763;
	Tue, 12 Aug 2025 08:05:52 +0200 (CEST)
Message-ID: <d72bb0f7-8dc3-42ca-84d9-c74b4db02445@csgroup.eu>
Date: Tue, 12 Aug 2025 08:05:51 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] selftests: vDSO: fix -Wunitialized in powerpc
 VDSO_CALL() wrapper
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan
 <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>, llvm@lists.linux.dev,
 kernel test robot <lkp@intel.com>
References: <20250812-vdso-tests-fixes-v2-0-90f499dd35f8@linutronix.de>
 <20250812-vdso-tests-fixes-v2-1-90f499dd35f8@linutronix.de>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250812-vdso-tests-fixes-v2-1-90f499dd35f8@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 12/08/2025 à 07:39, Thomas Weißschuh a écrit :
> The _rval register variable is meant to be an output operand of the asm
> statement but is instead used as input operand.
> clang 20.1 notices this and triggers -Wuninitialized warnings:
> 
> tools/testing/selftests/timers/auxclock.c:154:10: error: variable '_rval' is uninitialized when used here [-Werror,-Wuninitialized]
>    154 |                 return VDSO_CALL(self->vdso_clock_gettime64, 2, clockid, ts);
>        |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> tools/testing/selftests/timers/../vDSO/vdso_call.h:59:10: note: expanded from macro 'VDSO_CALL'
>     59 |                 : "r" (_rval)                                           \
>        |                        ^~~~~
> tools/testing/selftests/timers/auxclock.c:154:10: note: variable '_rval' is declared here
> tools/testing/selftests/timers/../vDSO/vdso_call.h:47:2: note: expanded from macro 'VDSO_CALL'
>     47 |         register long _rval asm ("r3");                                 \
>        |         ^
> 
> It seems the list of input and output operands have been switched around.
> However as the argument registers are not always initialized they can not
> be marked as pure inputs as that would trigger -Wuninitialized warnings.
> Adding _rval as another input and output operand does also not work as it
> would collide with the existing _r3 variable.
> 
> Instead reuse _r3 for both the argument and the return value.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Foe-kbuild-all%2F202506180223.BOOk5jDK-lkp%40intel.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C611dd96dfdad4dcd55d708ddd9629305%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638905739611064850%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=QcOje8P4T0%2BsqgkSaP%2BkT3fS875kqCZhxChDmvWVY%2Fg%3D&reserved=0
> Fixes: 6eda706a535c ("selftests: vDSO: fix the way vDSO functions are called for powerpc")
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   tools/testing/selftests/vDSO/vdso_call.h | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_call.h b/tools/testing/selftests/vDSO/vdso_call.h
> index bb237d771051bd4103367fc60b54b505b7586965..e7205584cbdca5e10c13c1e9425d2023b02cda7f 100644
> --- a/tools/testing/selftests/vDSO/vdso_call.h
> +++ b/tools/testing/selftests/vDSO/vdso_call.h
> @@ -44,7 +44,6 @@
>   	register long _r6 asm ("r6");					\
>   	register long _r7 asm ("r7");					\
>   	register long _r8 asm ("r8");					\
> -	register long _rval asm ("r3");					\
>   									\
>   	LOADARGS_##nr(fn, args);					\
>   									\
> @@ -54,13 +53,13 @@
>   		"	bns+	1f\n"					\
>   		"	neg	3, 3\n"					\
>   		"1:"							\
> -		: "+r" (_r0), "=r" (_r3), "+r" (_r4), "+r" (_r5),	\
> +		: "+r" (_r0), "+r" (_r3), "+r" (_r4), "+r" (_r5),	\
>   		  "+r" (_r6), "+r" (_r7), "+r" (_r8)			\
> -		: "r" (_rval)						\
> +		:							\
>   		: "r9", "r10", "r11", "r12", "cr0", "cr1", "cr5",	\
>   		  "cr6", "cr7", "xer", "lr", "ctr", "memory"		\
>   	);								\
> -	_rval;								\
> +	_r3;								\
>   })
>   
>   #else
> 


