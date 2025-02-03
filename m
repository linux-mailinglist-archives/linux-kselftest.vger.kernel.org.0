Return-Path: <linux-kselftest+bounces-25572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3B9A25F3B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 16:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7691884AF5
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 15:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D683420A5CF;
	Mon,  3 Feb 2025 15:50:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A09920A5C3;
	Mon,  3 Feb 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738597810; cv=none; b=azNZtpkc3Xb/WKJ7QF9TLMCwIMkZXaWZ0SQ3qcbkzqxEGdUSts9i8q36HYLRn0Uobjsxkh6CMCcMJ0AvxIg5KjgJLQkP7E66xL5skaduYO66HuwO93uUVWV4RMHYsluoDdvEwwS73hAPwq07jKcXdMAblcWyQcmrh77HQosMiHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738597810; c=relaxed/simple;
	bh=JTdeXaWqQUg5XXeh7UfMKu8pBBGAsuiPlLDWkM5u90Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1yCfvvYEERWwxBgCqnCEOkT9WQcQ77rqv5O5+oqXbJDHBORnevg+ptAz9oBuUauLWhsMBdAm59VzH/3tTgR0/XJDWIjsDi3sjIXMUcd3t2NJ1l9PpLhSMZrlHTXCp3pmURd5onyE+/K7lhBVxJOdJiRpP9kyKVvg8LfdFDqlt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YmrPS5s5Zz9sS8;
	Mon,  3 Feb 2025 16:43:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WsSVNvLwdVO2; Mon,  3 Feb 2025 16:43:24 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YmrPS4WCsz9sRy;
	Mon,  3 Feb 2025 16:43:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 87FEF8B764;
	Mon,  3 Feb 2025 16:43:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id bjVNeM0DjxQi; Mon,  3 Feb 2025 16:43:24 +0100 (CET)
Received: from [192.168.202.221] (unknown [192.168.202.221])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1321C8B763;
	Mon,  3 Feb 2025 16:43:22 +0100 (CET)
Message-ID: <937c99b3-3837-4510-be65-4eca3b280ce2@csgroup.eu>
Date: Mon, 3 Feb 2025 16:43:22 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] selftests: vDSO: parse_vdso: Make compatible with
 nolibc
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev
References: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
 <cd1147a8-25ba-47d2-a59a-0a686469a808@csgroup.eu>
 <20250203143640-70c59c53-af45-40cb-9a52-6395b3fdd263@linutronix.de>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250203143640-70c59c53-af45-40cb-9a52-6395b3fdd263@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/02/2025 à 14:50, Thomas Weißschuh a écrit :
> On Mon, Feb 03, 2025 at 12:23:29PM +0100, Christophe Leroy wrote:
>> Le 03/02/2025 à 10:05, Thomas Weißschuh a écrit :
>>> For testing the functionality of the vDSO, it is necessary to build
>>> userspace programs for multiple different architectures.
>>> It is additional work to acquire matching userspace cross-compilers with
>>> full C libraries and then building root images out of those.
>>> The kernel tree already contains nolibc, a small, header-only C library.
>>> By using it, it is possible to build userspace programs without any
>>> additional dependencies.
>>> For example the kernel.org crosstools or multi-target clang can be used
>>> to build test programs for a multitude of architectures.
>>> While nolibc is very limited, it is enough for many selftests.
>>> With some minor adjustments it is possible to make parse_vdso.c
>>> compatible with nolibc.
>>> As an example, vdso_standalone_test_x86 is now built from the same C
>>> code as the regular vdso_test_gettimeofday, while still being completely
>>> standalone.
>>>
>>> This should probably go through the kselftest tree.
>>
>> Not sure what are the expectations with this series.
> 
> In general it should also work for PPC,
> thanks for testing it.
> 
>> I gave it a try with vdso_test_gettimeofday and get the following:
>>
>> $ powerpc64-linux-gcc -nostdlib -nostdinc -ffreestanding
>> -fno-asynchronous-unwind-tables -fno-stack-protector -include /home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include/nolibc/nolibc.h -I/home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include/nolibc/
>> -isystem
>> /home/chleroy/linux-powerpc/tools/testing/selftests/../../../usr/include
>> -std=gnu99 -O2 -D_GNU_SOURCE= -isystem /home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include/uapi
>> vdso_test_gettimeofday.c parse_vdso.c  -o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_gettimeofday
>>
>> make: Entering directory
>> '/home/chleroy/linux-powerpc/tools/testing/selftests/vDSO'
>> powerpc64-linux-gcc -nostdlib -nostdinc -ffreestanding
>> -fno-asynchronous-unwind-tables -fno-stack-protector -include /home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include/nolibc/nolibc.h -I/home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include/nolibc/
>> -isystem
>> /home/chleroy/linux-powerpc/tools/testing/selftests/../../../usr/include
>> -std=gnu99 -O2 -D_GNU_SOURCE= -isystem /home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include/uapi
>> vdso_test_gettimeofday.c parse_vdso.c  -o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_gettimeofday
> 
> This log is confusing. It contains traces of "make" output but no "make"
> invocation. I'm also not sure if there were two different compilations
> or only one. Can you give the full commandline?
> For your testing it should be enough to enable
> "vdso_test_standalone_x86" in the Makefile for PPC.

Well, yes I copied/pasted too much.

I made some hacky modifications to the Makefile but I forgot the '| 
header' pattern. With it added it works as expected.

Do you have any plan to get it work with nolibc for all test programs in 
selftests/vDSO, not only the standalone x86 test ?

Christophe

