Return-Path: <linux-kselftest+bounces-25567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B147BA2587E
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 12:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605911882143
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 11:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188C5203712;
	Mon,  3 Feb 2025 11:50:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2141D2036F9;
	Mon,  3 Feb 2025 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738583406; cv=none; b=jtACXghC5twFZ334d8uQWKF0ZjAkLK2AnLgtZt2vNOT9k+PR/1TKBIRDQigDcUJ86f8sGhyf3gnudmAe1Xr5iZn/2ABZ6H4QKMimCDBfvn1nv7IqAsgC2P1O1vfDMGuitRBlkVWG5Q3sJscRtaxSBcKGk+LQwYm1d0kab+zjQpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738583406; c=relaxed/simple;
	bh=DnGNmo0EcgYF2mLPxgt5xh017OiYO+5rLFa3mHfZ4pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fWvrB3beniBw4qmE0YHgb0gOYWBgrDDjl7km2ClmyFf881i2Yj3kRg3F/FpfrZiUUZcXhx/iVw5GuSdcVBqgZ8BXOImtP4NPWcvhKF7OVqeRkvbxYSlooj5C4TWiF5+nuQbFld38QCWcpKW/XIx0hGYIROllQkxJsSkTmlC5yxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Ymkdb4BDxz9sPd;
	Mon,  3 Feb 2025 12:23:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uGBPqI4AfzYv; Mon,  3 Feb 2025 12:23:31 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Ymkdb2t6tz9rvV;
	Mon,  3 Feb 2025 12:23:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 556158B764;
	Mon,  3 Feb 2025 12:23:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id vMCArOcsO-hF; Mon,  3 Feb 2025 12:23:31 +0100 (CET)
Received: from [192.168.202.221] (unknown [192.168.202.221])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2B7A28B763;
	Mon,  3 Feb 2025 12:23:30 +0100 (CET)
Message-ID: <cd1147a8-25ba-47d2-a59a-0a686469a808@csgroup.eu>
Date: Mon, 3 Feb 2025 12:23:29 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] selftests: vDSO: parse_vdso: Make compatible with
 nolibc
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
References: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/02/2025 à 10:05, Thomas Weißschuh a écrit :
> For testing the functionality of the vDSO, it is necessary to build
> userspace programs for multiple different architectures.
> It is additional work to acquire matching userspace cross-compilers with
> full C libraries and then building root images out of those.
> The kernel tree already contains nolibc, a small, header-only C library.
> By using it, it is possible to build userspace programs without any
> additional dependencies.
> For example the kernel.org crosstools or multi-target clang can be used
> to build test programs for a multitude of architectures.
> While nolibc is very limited, it is enough for many selftests.
> With some minor adjustments it is possible to make parse_vdso.c
> compatible with nolibc.
> As an example, vdso_standalone_test_x86 is now built from the same C
> code as the regular vdso_test_gettimeofday, while still being completely
> standalone.
> 
> This should probably go through the kselftest tree.

Not sure what are the expectations with this series.

I gave it a try with vdso_test_gettimeofday and get the following:

$ powerpc64-linux-gcc -nostdlib -nostdinc -ffreestanding 
-fno-asynchronous-unwind-tables -fno-stack-protector -include 
/home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include/nolibc/nolibc.h 
-I/home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include/nolibc/ 
-isystem 
/home/chleroy/linux-powerpc/tools/testing/selftests/../../../usr/include 
-std=gnu99 -O2 -D_GNU_SOURCE= -isystem 
/home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include/uapi 
    vdso_test_gettimeofday.c parse_vdso.c  -o 
/home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_gettimeofday

make: Entering directory 
'/home/chleroy/linux-powerpc/tools/testing/selftests/vDSO'
powerpc64-linux-gcc -nostdlib -nostdinc -ffreestanding 
-fno-asynchronous-unwind-tables -fno-stack-protector -include 
/home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include/nolibc/nolibc.h 
-I/home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include/nolibc/ 
-isystem 
/home/chleroy/linux-powerpc/tools/testing/selftests/../../../usr/include 
-std=gnu99 -O2 -D_GNU_SOURCE= -isystem 
/home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include/uapi 
    vdso_test_gettimeofday.c parse_vdso.c  -o 
/home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_gettimeofday
parse_vdso.c:38:34: error: unknown type name 'Elf64_Versym'
    38 | #define ELF_BITS_XFORM2(bits, x) Elf##bits##_##x
       |                                  ^~~
parse_vdso.c:39:33: note: in expansion of macro 'ELF_BITS_XFORM2'
    39 | #define ELF_BITS_XFORM(bits, x) ELF_BITS_XFORM2(bits, x)
       |                                 ^~~~~~~~~~~~~~~
parse_vdso.c:40:16: note: in expansion of macro 'ELF_BITS_XFORM'
    40 | #define ELF(x) ELF_BITS_XFORM(ELF_BITS, x)
       |                ^~~~~~~~~~~~~~
parse_vdso.c:63:9: note: in expansion of macro 'ELF'
    63 |         ELF(Versym) *versym;
       |         ^~~
parse_vdso.c:38:34: error: unknown type name 'Elf64_Verdef'
    38 | #define ELF_BITS_XFORM2(bits, x) Elf##bits##_##x
       |                                  ^~~
parse_vdso.c:39:33: note: in expansion of macro 'ELF_BITS_XFORM2'
    39 | #define ELF_BITS_XFORM(bits, x) ELF_BITS_XFORM2(bits, x)
       |                                 ^~~~~~~~~~~~~~~
parse_vdso.c:40:16: note: in expansion of macro 'ELF_BITS_XFORM'
    40 | #define ELF(x) ELF_BITS_XFORM(ELF_BITS, x)
       |                ^~~~~~~~~~~~~~
parse_vdso.c:64:9: note: in expansion of macro 'ELF'
    64 |         ELF(Verdef) *verdef;
       |         ^~~
parse_vdso.c: In function 'vdso_init_from_sysinfo_ehdr':
parse_vdso.c:38:34: error: 'Elf64_Versym' undeclared (first use in this 
function); did you mean 'Elf64_Sym'?
    38 | #define ELF_BITS_XFORM2(bits, x) Elf##bits##_##x
       |                                  ^~~
parse_vdso.c:39:33: note: in expansion of macro 'ELF_BITS_XFORM2'
    39 | #define ELF_BITS_XFORM(bits, x) ELF_BITS_XFORM2(bits, x)
       |                                 ^~~~~~~~~~~~~~~
parse_vdso.c:40:16: note: in expansion of macro 'ELF_BITS_XFORM'
    40 | #define ELF(x) ELF_BITS_XFORM(ELF_BITS, x)
       |                ^~~~~~~~~~~~~~
parse_vdso.c:150:45: note: in expansion of macro 'ELF'
   150 |                         vdso_info.versym = (ELF(Versym) *)
       |                                             ^~~
parse_vdso.c:38:34: note: each undeclared identifier is reported only 
once for each function it appears in
    38 | #define ELF_BITS_XFORM2(bits, x) Elf##bits##_##x
       |                                  ^~~
parse_vdso.c:39:33: note: in expansion of macro 'ELF_BITS_XFORM2'
    39 | #define ELF_BITS_XFORM(bits, x) ELF_BITS_XFORM2(bits, x)
       |                                 ^~~~~~~~~~~~~~~
parse_vdso.c:40:16: note: in expansion of macro 'ELF_BITS_XFORM'
    40 | #define ELF(x) ELF_BITS_XFORM(ELF_BITS, x)
       |                ^~~~~~~~~~~~~~
parse_vdso.c:150:45: note: in expansion of macro 'ELF'
   150 |                         vdso_info.versym = (ELF(Versym) *)
       |                                             ^~~
parse_vdso.c:150:58: error: expected expression before ')' token
   150 |                         vdso_info.versym = (ELF(Versym) *)
       |                                                          ^
parse_vdso.c:38:34: error: 'Elf64_Verdef' undeclared (first use in this 
function); did you mean 'Elf64_Word'?
    38 | #define ELF_BITS_XFORM2(bits, x) Elf##bits##_##x
       |                                  ^~~
parse_vdso.c:39:33: note: in expansion of macro 'ELF_BITS_XFORM2'
    39 | #define ELF_BITS_XFORM(bits, x) ELF_BITS_XFORM2(bits, x)
       |                                 ^~~~~~~~~~~~~~~
parse_vdso.c:40:16: note: in expansion of macro 'ELF_BITS_XFORM'
    40 | #define ELF(x) ELF_BITS_XFORM(ELF_BITS, x)
       |                ^~~~~~~~~~~~~~
parse_vdso.c:155:45: note: in expansion of macro 'ELF'
   155 |                         vdso_info.verdef = (ELF(Verdef) *)
       |                                             ^~~
parse_vdso.c:155:58: error: expected expression before ')' token
   155 |                         vdso_info.verdef = (ELF(Verdef) *)
       |                                                          ^
parse_vdso.c: At top level:
parse_vdso.c:38:34: error: unknown type name 'Elf64_Versym'; did you 
mean 'Elf64_Sym'?
    38 | #define ELF_BITS_XFORM2(bits, x) Elf##bits##_##x
       |                                  ^~~
parse_vdso.c:39:33: note: in expansion of macro 'ELF_BITS_XFORM2'
    39 | #define ELF_BITS_XFORM(bits, x) ELF_BITS_XFORM2(bits, x)
       |                                 ^~~~~~~~~~~~~~~
parse_vdso.c:40:16: note: in expansion of macro 'ELF_BITS_XFORM'
    40 | #define ELF(x) ELF_BITS_XFORM(ELF_BITS, x)
       |                ^~~~~~~~~~~~~~
parse_vdso.c:177:32: note: in expansion of macro 'ELF'
   177 | static bool vdso_match_version(ELF(Versym) ver,
       |                                ^~~
parse_vdso.c: In function 'vdso_sym':
parse_vdso.c:224:25: error: 'STN_UNDEF' undeclared (first use in this 
function); did you mean 'SHN_UNDEF'?
   224 |         for (; chain != STN_UNDEF; chain = 
vdso_info.chain[chain]) {
       |                         ^~~~~~~~~
       |                         SHN_UNDEF
parse_vdso.c:240:25: warning: implicit declaration of function 
'vdso_match_version' [-Wimplicit-function-declaration]
   240 |                     && !vdso_match_version(vdso_info.versym[chain],
       |                         ^~~~~~~~~~~~~~~~~~
make: *** [../lib.mk:222: 
/home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_gettimeofday] 
Error 1
make: Leaving directory 
'/home/chleroy/linux-powerpc/tools/testing/selftests/vDSO'

Christophe

> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
> Thomas Weißschuh (16):
>        MAINTAINERS: Add vDSO selftests
>        elf, uapi: Add definition for STN_UNDEF
>        elf, uapi: Add definition for DT_GNU_HASH
>        elf, uapi: Add definitions for VER_FLG_BASE and VER_FLG_WEAK
>        elf, uapi: Add type ElfXX_Versym
>        elf, uapi: Add types ElfXX_Verdef and ElfXX_Veraux
>        tools/include: Add uapi/linux/elf.h
>        selftests: Add headers target
>        selftests: vDSO: vdso_standalone_test_x86: Use vdso_init_form_sysinfo_ehdr
>        selftests: vDSO: parse_vdso: Drop vdso_init_from_auxv()
>        selftests: vDSO: parse_vdso: Use UAPI headers instead of libc headers
>        selftests: vDSO: parse_vdso: Test __SIZEOF_LONG__ instead of ULONG_MAX
>        selftests: vDSO: parse_vdso: Make compatible with nolibc
>        selftests: vDSO: vdso_test_gettimeofday: Clean up includes
>        selftests: vDSO: vdso_test_gettimeofday: Make compatible with nolibc
>        selftests: vDSO: vdso_standalone_test_x86: Switch to nolibc
> 
>   MAINTAINERS                                        |   1 +
>   include/uapi/linux/elf.h                           |  38 ++
>   tools/include/uapi/linux/elf.h                     | 524 +++++++++++++++++++++
>   tools/testing/selftests/lib.mk                     |   5 +-
>   tools/testing/selftests/vDSO/Makefile              |  11 +-
>   tools/testing/selftests/vDSO/parse_vdso.c          |  21 +-
>   tools/testing/selftests/vDSO/parse_vdso.h          |   1 -
>   .../selftests/vDSO/vdso_standalone_test_x86.c      | 143 +-----
>   .../selftests/vDSO/vdso_test_gettimeofday.c        |   4 +-
>   9 files changed, 584 insertions(+), 164 deletions(-)
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20241017-parse_vdso-nolibc-e069baa7ff48
> 
> Best regards,


