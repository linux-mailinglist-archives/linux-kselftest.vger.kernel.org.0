Return-Path: <linux-kselftest+bounces-25570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73FFA25B50
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 14:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1923D3A4198
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 13:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76F7205AB3;
	Mon,  3 Feb 2025 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YPpXSpjZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zpOBiFzq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C69205AB8;
	Mon,  3 Feb 2025 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738590622; cv=none; b=XGR4B6LLzYjGKYABLIdlr8P2WPSY0g2rHG1/tT56xFJTXXIIa9LIrFl0X3CeJ1Qto8ES5J+32JQa7YRi/hj38t7TAPZe6rpFNANNTaxm9mEcxZGSyUz24usBh4pv38JhxadkokjwVhzyn19ds+UeB8s2maccvf3LCNd9mTfricE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738590622; c=relaxed/simple;
	bh=Nsul2RHko3wUFZHRd+DzcKbvxURzXAXeCgS95BA2UqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pm5VMupXEbP9rkFUg5e/Flj41wEQ18nLvVMYKWPV2ZfLtKarjCcSzJT0c3ORGt0UWNtBjKQwOvS/tlQfgJkIahv74O5IL2zToI2vlrBxB6STkmVz8snMhz7qybVK1mKawIooGTEzkTKzWKKh/dx9yhv/8oeUvc28PKyMAwbvi4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YPpXSpjZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zpOBiFzq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 3 Feb 2025 14:50:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738590618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQrfcOY2FHWEyibchfnDOta6mFsV+KBdbtmBdSk0oiU=;
	b=YPpXSpjZ0wzBy4i8ZEGZe/u1qrkNxIslNFF/UDtZTHdW0VLlZT5yRwiaAXsn/twnpPhfSp
	ZGnL5wODQkps5Jjcja0NMEDmdPrr8M2E6S1bkQ/i/YbxQ0AkIdTIUK2jnucFNUUg1eArsU
	Bk8j13Vusd2XQHjUG6DaahEBrQ/RdklJuQlVfb1Jz8jlSg6N8kzk7ovAHBfrZSm871ejTs
	z7+PnSuYLQNsKdEcyJXSinH2tZ/lylpVUkI0M8kZVPZZe57W9UlPml9zY4pW5l5N/1l199
	iWeimxH0IFa0nl6Ds3kBhPShEcYqFdpHUmqpzEuCrJ+pwUjuNFTX4FiJ3hiX2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738590618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQrfcOY2FHWEyibchfnDOta6mFsV+KBdbtmBdSk0oiU=;
	b=zpOBiFzqOW/f8piH0OJQXhdrOuRqtzwchGmFzVAfGVF4jCmrbXF//XpS3g+xALDkpSvFsV
	HS3pxrQy5AuuvFBA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH 00/16] selftests: vDSO: parse_vdso: Make compatible with
 nolibc
Message-ID: <20250203143640-70c59c53-af45-40cb-9a52-6395b3fdd263@linutronix.de>
References: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
 <cd1147a8-25ba-47d2-a59a-0a686469a808@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd1147a8-25ba-47d2-a59a-0a686469a808@csgroup.eu>

On Mon, Feb 03, 2025 at 12:23:29PM +0100, Christophe Leroy wrote:
> Le 03/02/2025 ‡ 10:05, Thomas Weiﬂschuh a Ècrit†:
> > For testing the functionality of the vDSO, it is necessary to build
> > userspace programs for multiple different architectures.
> > It is additional work to acquire matching userspace cross-compilers with
> > full C libraries and then building root images out of those.
> > The kernel tree already contains nolibc, a small, header-only C library.
> > By using it, it is possible to build userspace programs without any
> > additional dependencies.
> > For example the kernel.org crosstools or multi-target clang can be used
> > to build test programs for a multitude of architectures.
> > While nolibc is very limited, it is enough for many selftests.
> > With some minor adjustments it is possible to make parse_vdso.c
> > compatible with nolibc.
> > As an example, vdso_standalone_test_x86 is now built from the same C
> > code as the regular vdso_test_gettimeofday, while still being completely
> > standalone.
> > 
> > This should probably go through the kselftest tree.
> 
> Not sure what are the expectations with this series.

In general it should also work for PPC,
thanks for testing it.

> I gave it a try with vdso_test_gettimeofday and get the following:
> 
> $ powerpc64-linux-gcc -nostdlib -nostdinc -ffreestanding
> -fno-asynchronous-unwind-tables -fno-stack-protector -include /home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include/nolibc/nolibc.h -I/home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include/nolibc/
> -isystem
> /home/chleroy/linux-powerpc/tools/testing/selftests/../../../usr/include
> -std=gnu99 -O2 -D_GNU_SOURCE= -isystem /home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include/uapi
> vdso_test_gettimeofday.c parse_vdso.c  -o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_gettimeofday
> 
> make: Entering directory
> '/home/chleroy/linux-powerpc/tools/testing/selftests/vDSO'
> powerpc64-linux-gcc -nostdlib -nostdinc -ffreestanding
> -fno-asynchronous-unwind-tables -fno-stack-protector -include /home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include/nolibc/nolibc.h -I/home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include/nolibc/
> -isystem
> /home/chleroy/linux-powerpc/tools/testing/selftests/../../../usr/include
> -std=gnu99 -O2 -D_GNU_SOURCE= -isystem /home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include/uapi
> vdso_test_gettimeofday.c parse_vdso.c  -o /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_gettimeofday

This log is confusing. It contains traces of "make" output but no "make"
invocation. I'm also not sure if there were two different compilations
or only one. Can you give the full commandline?
For your testing it should be enough to enable
"vdso_test_standalone_x86" in the Makefile for PPC.

> parse_vdso.c:38:34: error: unknown type name 'Elf64_Versym'
>    38 | #define ELF_BITS_XFORM2(bits, x) Elf##bits##_##x
>       |                                  ^~~
> parse_vdso.c:39:33: note: in expansion of macro 'ELF_BITS_XFORM2'
>    39 | #define ELF_BITS_XFORM(bits, x) ELF_BITS_XFORM2(bits, x)
>       |                                 ^~~~~~~~~~~~~~~
> parse_vdso.c:40:16: note: in expansion of macro 'ELF_BITS_XFORM'
>    40 | #define ELF(x) ELF_BITS_XFORM(ELF_BITS, x)
>       |                ^~~~~~~~~~~~~~
> parse_vdso.c:63:9: note: in expansion of macro 'ELF'
>    63 |         ELF(Versym) *versym;
>       |         ^~~
> parse_vdso.c:38:34: error: unknown type name 'Elf64_Verdef'
>    38 | #define ELF_BITS_XFORM2(bits, x) Elf##bits##_##x
>       |                                  ^~~
> parse_vdso.c:39:33: note: in expansion of macro 'ELF_BITS_XFORM2'
>    39 | #define ELF_BITS_XFORM(bits, x) ELF_BITS_XFORM2(bits, x)
>       |                                 ^~~~~~~~~~~~~~~
> parse_vdso.c:40:16: note: in expansion of macro 'ELF_BITS_XFORM'
>    40 | #define ELF(x) ELF_BITS_XFORM(ELF_BITS, x)
>       |                ^~~~~~~~~~~~~~
> parse_vdso.c:64:9: note: in expansion of macro 'ELF'
>    64 |         ELF(Verdef) *verdef;
>       |         ^~~
> parse_vdso.c: In function 'vdso_init_from_sysinfo_ehdr':
> parse_vdso.c:38:34: error: 'Elf64_Versym' undeclared (first use in this
> function); did you mean 'Elf64_Sym'?
>    38 | #define ELF_BITS_XFORM2(bits, x) Elf##bits##_##x
>       |                                  ^~~
> parse_vdso.c:39:33: note: in expansion of macro 'ELF_BITS_XFORM2'
>    39 | #define ELF_BITS_XFORM(bits, x) ELF_BITS_XFORM2(bits, x)
>       |                                 ^~~~~~~~~~~~~~~
> parse_vdso.c:40:16: note: in expansion of macro 'ELF_BITS_XFORM'
>    40 | #define ELF(x) ELF_BITS_XFORM(ELF_BITS, x)
>       |                ^~~~~~~~~~~~~~
> parse_vdso.c:150:45: note: in expansion of macro 'ELF'
>   150 |                         vdso_info.versym = (ELF(Versym) *)
>       |                                             ^~~
> parse_vdso.c:38:34: note: each undeclared identifier is reported only once
> for each function it appears in
>    38 | #define ELF_BITS_XFORM2(bits, x) Elf##bits##_##x
>       |                                  ^~~
> parse_vdso.c:39:33: note: in expansion of macro 'ELF_BITS_XFORM2'
>    39 | #define ELF_BITS_XFORM(bits, x) ELF_BITS_XFORM2(bits, x)
>       |                                 ^~~~~~~~~~~~~~~
> parse_vdso.c:40:16: note: in expansion of macro 'ELF_BITS_XFORM'
>    40 | #define ELF(x) ELF_BITS_XFORM(ELF_BITS, x)
>       |                ^~~~~~~~~~~~~~
> parse_vdso.c:150:45: note: in expansion of macro 'ELF'
>   150 |                         vdso_info.versym = (ELF(Versym) *)
>       |                                             ^~~
> parse_vdso.c:150:58: error: expected expression before ')' token
>   150 |                         vdso_info.versym = (ELF(Versym) *)
>       |                                                          ^
> parse_vdso.c:38:34: error: 'Elf64_Verdef' undeclared (first use in this
> function); did you mean 'Elf64_Word'?
>    38 | #define ELF_BITS_XFORM2(bits, x) Elf##bits##_##x
>       |                                  ^~~
> parse_vdso.c:39:33: note: in expansion of macro 'ELF_BITS_XFORM2'
>    39 | #define ELF_BITS_XFORM(bits, x) ELF_BITS_XFORM2(bits, x)
>       |                                 ^~~~~~~~~~~~~~~
> parse_vdso.c:40:16: note: in expansion of macro 'ELF_BITS_XFORM'
>    40 | #define ELF(x) ELF_BITS_XFORM(ELF_BITS, x)
>       |                ^~~~~~~~~~~~~~
> parse_vdso.c:155:45: note: in expansion of macro 'ELF'
>   155 |                         vdso_info.verdef = (ELF(Verdef) *)
>       |                                             ^~~
> parse_vdso.c:155:58: error: expected expression before ')' token
>   155 |                         vdso_info.verdef = (ELF(Verdef) *)
>       |                                                          ^
> parse_vdso.c: At top level:
> parse_vdso.c:38:34: error: unknown type name 'Elf64_Versym'; did you mean
> 'Elf64_Sym'?
>    38 | #define ELF_BITS_XFORM2(bits, x) Elf##bits##_##x
>       |                                  ^~~
> parse_vdso.c:39:33: note: in expansion of macro 'ELF_BITS_XFORM2'
>    39 | #define ELF_BITS_XFORM(bits, x) ELF_BITS_XFORM2(bits, x)
>       |                                 ^~~~~~~~~~~~~~~
> parse_vdso.c:40:16: note: in expansion of macro 'ELF_BITS_XFORM'
>    40 | #define ELF(x) ELF_BITS_XFORM(ELF_BITS, x)
>       |                ^~~~~~~~~~~~~~
> parse_vdso.c:177:32: note: in expansion of macro 'ELF'
>   177 | static bool vdso_match_version(ELF(Versym) ver,
>       |                                ^~~
> parse_vdso.c: In function 'vdso_sym':
> parse_vdso.c:224:25: error: 'STN_UNDEF' undeclared (first use in this
> function); did you mean 'SHN_UNDEF'?
>   224 |         for (; chain != STN_UNDEF; chain = vdso_info.chain[chain]) {
>       |                         ^~~~~~~~~
>       |                         SHN_UNDEF
> parse_vdso.c:240:25: warning: implicit declaration of function
> 'vdso_match_version' [-Wimplicit-function-declaration]
>   240 |                     && !vdso_match_version(vdso_info.versym[chain],
>       |                         ^~~~~~~~~~~~~~~~~~
> make: *** [../lib.mk:222: /home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_gettimeofday]
> Error 1
> make: Leaving directory
> '/home/chleroy/linux-powerpc/tools/testing/selftests/vDSO'
> 
> Christophe
> 
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> > Thomas Weiﬂschuh (16):
> >        MAINTAINERS: Add vDSO selftests
> >        elf, uapi: Add definition for STN_UNDEF
> >        elf, uapi: Add definition for DT_GNU_HASH
> >        elf, uapi: Add definitions for VER_FLG_BASE and VER_FLG_WEAK
> >        elf, uapi: Add type ElfXX_Versym
> >        elf, uapi: Add types ElfXX_Verdef and ElfXX_Veraux
> >        tools/include: Add uapi/linux/elf.h
> >        selftests: Add headers target
> >        selftests: vDSO: vdso_standalone_test_x86: Use vdso_init_form_sysinfo_ehdr
> >        selftests: vDSO: parse_vdso: Drop vdso_init_from_auxv()
> >        selftests: vDSO: parse_vdso: Use UAPI headers instead of libc headers
> >        selftests: vDSO: parse_vdso: Test __SIZEOF_LONG__ instead of ULONG_MAX
> >        selftests: vDSO: parse_vdso: Make compatible with nolibc
> >        selftests: vDSO: vdso_test_gettimeofday: Clean up includes
> >        selftests: vDSO: vdso_test_gettimeofday: Make compatible with nolibc
> >        selftests: vDSO: vdso_standalone_test_x86: Switch to nolibc
> > 
> >   MAINTAINERS                                        |   1 +
> >   include/uapi/linux/elf.h                           |  38 ++
> >   tools/include/uapi/linux/elf.h                     | 524 +++++++++++++++++++++
> >   tools/testing/selftests/lib.mk                     |   5 +-
> >   tools/testing/selftests/vDSO/Makefile              |  11 +-
> >   tools/testing/selftests/vDSO/parse_vdso.c          |  21 +-
> >   tools/testing/selftests/vDSO/parse_vdso.h          |   1 -
> >   .../selftests/vDSO/vdso_standalone_test_x86.c      | 143 +-----
> >   .../selftests/vDSO/vdso_test_gettimeofday.c        |   4 +-
> >   9 files changed, 584 insertions(+), 164 deletions(-)
> > ---
> > base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> > change-id: 20241017-parse_vdso-nolibc-e069baa7ff48
> > 
> > Best regards,
> 

