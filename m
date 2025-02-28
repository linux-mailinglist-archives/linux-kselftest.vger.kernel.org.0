Return-Path: <linux-kselftest+bounces-27892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B09DA4995A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 13:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D053BD8A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 12:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA14C25F798;
	Fri, 28 Feb 2025 12:31:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1990C1C3BE3;
	Fri, 28 Feb 2025 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745885; cv=none; b=bKfjb/o57RwaDdtoHVgGWpFT6yG2oiQS1zvZYMYqeOL8Zzcok/9t5yxgweZl959yJ2maIUu1nzXMzMYnz3YuRk1gRCkiGbbk6RYJ+E6E3z5gNTPQzI+sYyEE+B4fkIWcuiQW318Q8VE1JBJ4DTUsOOMNE8Csm+LAy/yj47irTfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745885; c=relaxed/simple;
	bh=XMrFG06SF03GzZzh452twEP2WnLlvQfwLHAAPtu2OyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2wNSScI40PuiV0kj7km1CZThc3ZS8fePF+c5e4XLrsr4D8QV+Mj+J8evPsH8ybce9yYrI1T/RNmTX2slPpIrPsvxI4KhX6h2CPAsMIy2W0sngzwkoP9BnEJRIS+TYkHTd5Y4DYD7tKq0nI8d5YyObeBxn1ZUi+TnmIOGBta8/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F14D61688;
	Fri, 28 Feb 2025 04:31:38 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55F913F6A8;
	Fri, 28 Feb 2025 04:31:21 -0800 (PST)
Message-ID: <1dbfc2fa-2b40-497f-8588-d04d0d88c5f2@arm.com>
Date: Fri, 28 Feb 2025 12:31:19 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/16] selftests: vDSO: vdso_standalone_test_x86:
 Switch to nolibc
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Willy Tarreau <w@1wt.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev
References: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
 <20250226-parse_vdso-nolibc-v2-16-28e14e031ed8@linutronix.de>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20250226-parse_vdso-nolibc-v2-16-28e14e031ed8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/02/2025 11:44, Thomas Weißschuh wrote:
> vdso_standalone_test_x86 provides its own ASM syscall wrappers and
> _start() implementation. The in-tree nolibc library already provides
> this functionality for multiple architectures. By making use of nolibc,
> the standalone testcase can be built from the exact same codebase as the
> non-standalone version.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  tools/testing/selftests/vDSO/Makefile              |   8 +-
>  .../selftests/vDSO/vdso_standalone_test_x86.c      | 168 +--------------------
>  2 files changed, 7 insertions(+), 169 deletions(-)
> 
> diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
> index bc8ca186fb877dc11740c37f1e07e45e84c2ae92..12a0614b9fd4983deffe5d6a7cfa06ba8d92a516 100644
> --- a/tools/testing/selftests/vDSO/Makefile
> +++ b/tools/testing/selftests/vDSO/Makefile
> @@ -22,13 +22,17 @@ include ../lib.mk
>  
>  CFLAGS += $(TOOLS_INCLUDES)
>  
> +CFLAGS_NOLIBC := -nostdlib -nostdinc -ffreestanding -fno-asynchronous-unwind-tables \
> +		 -fno-stack-protector -include $(top_srcdir)/tools/include/nolibc/nolibc.h \
> +		 -I$(top_srcdir)/tools/include/nolibc/ $(KHDR_INCLUDES)
> +
>  $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
>  $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
>  $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c
>  $(OUTPUT)/vdso_test_clock_getres: vdso_test_clock_getres.c
>  
> -$(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
> -$(OUTPUT)/vdso_standalone_test_x86: CFLAGS +=-nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
> +$(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c | headers
> +$(OUTPUT)/vdso_standalone_test_x86: CFLAGS:=$(CFLAGS_NOLIBC) $(CFLAGS)
>  
>  $(OUTPUT)/vdso_test_correctness: vdso_test_correctness.c
>  $(OUTPUT)/vdso_test_correctness: LDFLAGS += -ldl
> diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
> deleted file mode 100644
> index 500608f89c66b5747e3d845ebc54e4c3a35b6ccd..0000000000000000000000000000000000000000
> --- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
> +++ /dev/null
> @@ -1,167 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * vdso_test.c: Sample code to test parse_vdso.c on x86
> - * Copyright (c) 2011-2014 Andy Lutomirski
> - *
> - * You can amuse yourself by compiling with:
> - * gcc -std=gnu99 -nostdlib
> - *     -Os -fno-asynchronous-unwind-tables -flto -lgcc_s
> - *      vdso_standalone_test_x86.c parse_vdso.c
> - * to generate a small binary.  On x86_64, you can omit -lgcc_s
> - * if you want the binary to be completely standalone.
> - */
> -
> -#include <sys/syscall.h>
> -#include <sys/time.h>
> -#include <unistd.h>
> -#include <stdint.h>
> -#include <linux/auxvec.h>
> -
> -#include "parse_vdso.h"
> -
> -/* We need some libc functions... */
> -int strcmp(const char *a, const char *b)
> -{
> -	/* This implementation is buggy: it never returns -1. */
> -	while (*a || *b) {
> -		if (*a != *b)
> -			return 1;
> -		if (*a == 0 || *b == 0)
> -			return 1;
> -		a++;
> -		b++;
> -	}
> -
> -	return 0;
> -}
> -
> -/*
> - * The clang build needs this, although gcc does not.
> - * Stolen from lib/string.c.
> - */
> -void *memcpy(void *dest, const void *src, size_t count)
> -{
> -	char *tmp = dest;
> -	const char *s = src;
> -
> -	while (count--)
> -		*tmp++ = *s++;
> -	return dest;
> -}
> -
> -/* ...and two syscalls.  This is x86-specific. */
> -static inline long x86_syscall3(long nr, long a0, long a1, long a2)
> -{
> -	long ret;
> -#ifdef __x86_64__
> -	asm volatile ("syscall" : "=a" (ret) : "a" (nr),
> -		      "D" (a0), "S" (a1), "d" (a2) :
> -		      "cc", "memory", "rcx",
> -		      "r8", "r9", "r10", "r11" );
> -#else
> -	asm volatile ("int $0x80" : "=a" (ret) : "a" (nr),
> -		      "b" (a0), "c" (a1), "d" (a2) :
> -		      "cc", "memory" );
> -#endif
> -	return ret;
> -}
> -
> -static inline long linux_write(int fd, const void *data, size_t len)
> -{
> -	return x86_syscall3(__NR_write, fd, (long)data, (long)len);
> -}
> -
> -static inline void linux_exit(int code)
> -{
> -	x86_syscall3(__NR_exit, code, 0, 0);
> -}
> -
> -void to_base10(char *lastdig, time_t n)
> -{
> -	while (n) {
> -		*lastdig = (n % 10) + '0';
> -		n /= 10;
> -		lastdig--;
> -	}
> -}
> -
> -unsigned long getauxval(const unsigned long *auxv, unsigned long type)
> -{
> -	unsigned long ret;
> -
> -	if (!auxv)
> -		return 0;
> -
> -	while (1) {
> -		if (!auxv[0] && !auxv[1]) {
> -			ret = 0;
> -			break;
> -		}
> -
> -		if (auxv[0] == type) {
> -			ret = auxv[1];
> -			break;
> -		}
> -
> -		auxv += 2;
> -	}
> -
> -	return ret;
> -}
> -
> -void c_main(void **stack)
> -{
> -	/* Parse the stack */
> -	long argc = (long)*stack;
> -	stack += argc + 2;
> -
> -	/* Now we're pointing at the environment.  Skip it. */
> -	while(*stack)
> -		stack++;
> -	stack++;
> -
> -	/* Now we're pointing at auxv.  Initialize the vDSO parser. */
> -	vdso_init_from_sysinfo_ehdr(getauxval((unsigned long *)stack, AT_SYSINFO_EHDR));
> -
> -	/* Find gettimeofday. */
> -	typedef long (*gtod_t)(struct timeval *tv, struct timezone *tz);
> -	gtod_t gtod = (gtod_t)vdso_sym("LINUX_2.6", "__vdso_gettimeofday");
> -
> -	if (!gtod)
> -		linux_exit(1);
> -
> -	struct timeval tv;
> -	long ret = gtod(&tv, 0);
> -
> -	if (ret == 0) {
> -		char buf[] = "The time is                     .000000\n";
> -		to_base10(buf + 31, tv.tv_sec);
> -		to_base10(buf + 38, tv.tv_usec);
> -		linux_write(1, buf, sizeof(buf) - 1);
> -	} else {
> -		linux_exit(ret);
> -	}
> -
> -	linux_exit(0);
> -}
> -
> -/*
> - * This is the real entry point.  It passes the initial stack into
> - * the C entry point.
> - */
> -asm (
> -	".text\n"
> -	".global _start\n"
> -	".type _start,@function\n"
> -	"_start:\n\t"
> -#ifdef __x86_64__
> -	"mov %rsp,%rdi\n\t"
> -	"and $-16,%rsp\n\t"
> -	"sub $8,%rsp\n\t"
> -	"jmp c_main"
> -#else
> -	"push %esp\n\t"
> -	"call c_main\n\t"
> -	"int $3"
> -#endif
> -	);
> diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
> new file mode 120000
> index 0000000000000000000000000000000000000000..4d3d96f1e440c965474681a6f35375a60b3921be
> --- /dev/null
> +++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
> @@ -0,0 +1 @@
> +vdso_test_gettimeofday.c
> \ No newline at end of file
> 

-- 
Regards,
Vincenzo


