Return-Path: <linux-kselftest+bounces-26159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82564A2ED17
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 14:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F1C97A2F93
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 13:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C896222569;
	Mon, 10 Feb 2025 13:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="d5w3e8H1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA941C3C00
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739192465; cv=none; b=KsAzcLyVF0aWuo6ag6HVoCIJ43kHlgFOSUDVQVAo/AJaQTb7jqPuaYFF7eHaHGPxdyNefjMT1jDfgRjDn2X1G/E5nCV9LmwKSPI6HvW2fph7ZtUwcHV3F1o829ebHFidGYWAmO+kvsgfaIf13iAp+twf7W7ZpzKYIZPyORK3TqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739192465; c=relaxed/simple;
	bh=S25E6BDj8TREV05Kv+UpERQAgNuSuZzsZx17eB9iICs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EQbXQ7K1vxbCoYBxYIqDfVy/pIZ59zNT40Uo9WFTGKz8HIv0na7+3GgwsikBogsee2Hi3o4NYwrpxhXvsisHKfBD71W3GJhL1+TixRxj9dExQkTrPBQsj3COuAfZX0H/9qehABoRLZM4uN9HyT4IfluVseXETUjwG1gj5+Xzml0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=d5w3e8H1; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3072f8dc069so45740581fa.3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 05:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1739192461; x=1739797261; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VK71TzxGVkRX9qG7tdueNdkbW6Dq9pUcgTDdLuMd3C0=;
        b=d5w3e8H1J2BP7hQ+CFTXMnSb3KcC9F4N8/oSa6sE8uiUV3GHwltZgOz/GKIy5hAzIA
         VfXWd0veBjGm6xObUVGUvPOEgT7lhc8Lj5f3Cxz1JUTVO3f+bNjYSaHzLL/nzFx0INau
         a6MouZ7at9d5cRiS/OFQEJn83VM+DwJNIOoME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739192461; x=1739797261;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VK71TzxGVkRX9qG7tdueNdkbW6Dq9pUcgTDdLuMd3C0=;
        b=GJ9ecoE2j3BWbUg5PMT5kef+ul9MGkhXuOQuQESYrOYb7MWNMrpTfgzHm/626+5wY/
         K5FnsfwpXLOmIig0lG6XyvmAsLmikb/PcG4W5NVexcOMCtyBfZqsk5wZXqYFApjHqC4c
         aJJ5cP+PScbaFDcHaOwW02a5fCzV7x9iRGZSh6YHlhkGbjIorOO73XKkF8xvCqjnI3Cm
         9ecbBJs5C/hPP397h6J0gYBxmObrh/vGAg82eGqW8fuhxBnBX/iTeOBCzwrJgoUS0nKo
         fvOPqBDCNheh/Gaudc2VM293/qW0nsEE165KM2V8zZTsw5jm+C48+6LYOWb2z2yvUYvO
         9GqA==
X-Forwarded-Encrypted: i=1; AJvYcCWF9RNHS/Rgk4MVyXt7+nml/Rlm2hm9WmmZ1XEZpToGiFb8T9y3QABT6EpcTmPd5peRtbIbVwztcU+EJytHroQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTvWdEHAm8xGXnp9Fg+tvTyQkzAS1vfE+aj2wVMZL5fJ0VuaKk
	KJgFV8+dXqLL5eDjbpRAAR6DD78mc+osQhuRAiZzdbQc+B953EyLGyjr5DoDBwE=
X-Gm-Gg: ASbGncvK56oPBqaUiPc3RgvpUIStK3R8ZTy9Z/RqjQzylFZmUhVrKN3L4XTNixOh34T
	YTBVmNHt4tWSir+hw0BOiL1iybr4LV6ouc05Jii1EqWDe3poen3OSGLuaTB/6CMZ7k64DmMbgIJ
	CLzWD19CP6vSma2pX2tMpdHn9t9CEgOWuTJ2fPrL18hPsJ2zedas+w62u3XNlOFNYv9NroRCoyj
	jlU4tx1scdu4Y6xsaIErjYF7dJQXIFJhqBfXyeiqZfx9MDD9K0VdFXNkzNgxDqGpOQNsynp97Pp
	MboCIrtMfDY72utG
X-Google-Smtp-Source: AGHT+IE+6ti0DA/zJ9/ga8L5P6j0t+vrknzNNNRUKvkPhUp3k/QIkKG4YhcWlFi8r0n1dYpC5L5cSQ==
X-Received: by 2002:ac2:5eca:0:b0:545:40f:575c with SMTP id 2adb3069b0e04-545040f58bcmr2462046e87.0.1739192460953;
        Mon, 10 Feb 2025 05:01:00 -0800 (PST)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-54506b8771csm628323e87.190.2025.02.10.05.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:01:00 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Arpitha Raghunandan <98.arpi@gmail.com>,  David Gow
 <davidgow@google.com>,  Petr Mladek <pmladek@suse.com>,  Steven Rostedt
 <rostedt@goodmis.org>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Sergey Senozhatsky
 <senozhatsky@chromium.org>,  Andrew Morton <akpm@linux-foundation.org>,
  Shuah Khan <shuah@kernel.org>,  Brendan Higgins
 <brendan.higgins@linux.dev>,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  Geert Uytterhoeven
 <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/2] printf: convert self-test to KUnit
In-Reply-To: <20250207-printf-kunit-convert-v2-1-057b23860823@gmail.com>
	(Tamir Duberstein's message of "Fri, 07 Feb 2025 06:30:44 -0500")
References: <20250207-printf-kunit-convert-v2-0-057b23860823@gmail.com>
	<20250207-printf-kunit-convert-v2-1-057b23860823@gmail.com>
Date: Mon, 10 Feb 2025 14:00:59 +0100
Message-ID: <87tt92q7hw.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 07 2025, Tamir Duberstein <tamird@gmail.com> wrote:

> Convert the printf() self-test to a KUnit test.
>
> In the interest of keeping the patch reasonably-sized this doesn't
> refactor the tests into proper parameterized tests - it's all one big
> test case.
>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  Documentation/core-api/printk-formats.rst |   2 +-
>  MAINTAINERS                               |   2 +-
>  arch/m68k/configs/amiga_defconfig         |   1 -
>  arch/m68k/configs/apollo_defconfig        |   1 -
>  arch/m68k/configs/atari_defconfig         |   1 -
>  arch/m68k/configs/bvme6000_defconfig      |   1 -
>  arch/m68k/configs/hp300_defconfig         |   1 -
>  arch/m68k/configs/mac_defconfig           |   1 -
>  arch/m68k/configs/multi_defconfig         |   1 -
>  arch/m68k/configs/mvme147_defconfig       |   1 -
>  arch/m68k/configs/mvme16x_defconfig       |   1 -
>  arch/m68k/configs/q40_defconfig           |   1 -
>  arch/m68k/configs/sun3_defconfig          |   1 -
>  arch/m68k/configs/sun3x_defconfig         |   1 -
>  arch/powerpc/configs/ppc64_defconfig      |   1 -
>  lib/Kconfig.debug                         |  20 +++-
>  lib/Makefile                              |   2 +-
>  lib/{test_printf.c => printf_kunit.c}     | 164 +++++++++++++++---------------
>  tools/testing/selftests/lib/config        |   1 -
>  tools/testing/selftests/lib/printf.sh     |   4 -
>  20 files changed, 104 insertions(+), 104 deletions(-)
>
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> index ecccc0473da9..0d9461bd6964 100644
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -661,7 +661,7 @@ Do *not* use it from C.
>  Thanks
>  ======
>  
> -If you add other %p extensions, please extend <lib/test_printf.c> with
> +If you add other %p extensions, please extend <lib/printf_kunit.c> with
>  one or more test cases, if at all feasible.
>  
>  Thank you for your cooperation and attention.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 896a307fa065..57e366d356bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25368,7 +25368,7 @@ R:	Sergey Senozhatsky <senozhatsky@chromium.org>
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
>  F:	Documentation/core-api/printk-formats.rst
> -F:	lib/test_printf.c
> +F:	lib/printf_kunit.c
>  F:	lib/test_scanf.c
>  F:	lib/vsprintf.c
>  
> diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
> index dbf2ea561c85..e8c5e08fb6ec 100644
> --- a/arch/m68k/configs/amiga_defconfig
> +++ b/arch/m68k/configs/amiga_defconfig
> @@ -622,7 +622,6 @@ CONFIG_ATOMIC64_SELFTEST=m
>  CONFIG_ASYNC_RAID6_TEST=m
>  CONFIG_TEST_HEXDUMP=m
>  CONFIG_TEST_KSTRTOX=m
> -CONFIG_TEST_PRINTF=m
>  CONFIG_TEST_SCANF=m
>  CONFIG_TEST_BITMAP=m
>  CONFIG_TEST_UUID=m

If/when you do re-roll a v3, can you split the defconfig changes off to
a separate patch? It's a little annoying to scroll through all those
mechanical one-liner diffs to get to the actual changes.

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1af972a92d06..4834cac1eb8f 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2427,6 +2427,23 @@ config ASYNC_RAID6_TEST
>  config TEST_HEXDUMP
>  	tristate "Test functions located in the hexdump module at runtime"
>  
> +config PRINTF_KUNIT_TEST
> +	tristate "KUnit test printf() family of functions at runtime" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Enable this option to test the printf functions at boot.
> +

Well, not necessarily at boot unless built-in? 

> +	  KUnit tests run during boot and output the results to the debug log
> +	  in TAP format (http://testanything.org/). Only useful for kernel devs
> +	  running the KUnit test harness, and not intended for inclusion into a
> +	  production build.
> +
> +	  For more information on KUnit and unit tests in general please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> +

I see that this is copy-pasted from other kunit config items, but not
all of them have all this boilerplate, and I don't think it's useful
(and, the mentions of "at boot" and "during boot" are actively
misleading). Other kunit config items are shorter and more to the point,
e.g.

          Enable this to turn on 'list_sort()' function test. This test is
          executed only once during system boot (so affects only boot time),
          or at module load time.

          If unsure, say N.

>  
>  obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
> diff --git a/lib/test_printf.c b/lib/printf_kunit.c
> similarity index 89%
> rename from lib/test_printf.c
> rename to lib/printf_kunit.c
> index 59dbe4f9a4cb..fe6f4df92dd5 100644
> --- a/lib/test_printf.c
> +++ b/lib/printf_kunit.c
> @@ -5,7 +5,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> -#include <linux/init.h>
> +#include <kunit/test.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/printk.h>
> @@ -25,8 +25,6 @@
>  
>  #include <linux/property.h>
>  
> -#include "../tools/testing/selftests/kselftest_module.h"
> -
>  #define BUF_SIZE 256
>  #define PAD_SIZE 16
>  #define FILL_CHAR '$'
> @@ -37,72 +35,71 @@
>  	block \
>  	__diag_pop();
>  
> -KSTM_MODULE_GLOBALS();
> +static char *test_buffer;
> +static char *alloced_buffer;
> +
> +static struct kunit *kunittest;
>  
> -static char *test_buffer __initdata;
> -static char *alloced_buffer __initdata;
> +#define tc_fail(fmt, ...) \
> +	KUNIT_FAIL(kunittest, fmt, ##__VA_ARGS__)
>  
> -static int __printf(4, 0) __init
> +static void __printf(4, 0)
>  do_test(int bufsize, const char *expect, int elen,
>  	const char *fmt, va_list ap)
>  {
>  	va_list aq;
>  	int ret, written;
>  
> -	total_tests++;
> -
>  	memset(alloced_buffer, FILL_CHAR, BUF_SIZE + 2*PAD_SIZE);
>  	va_copy(aq, ap);
>  	ret = vsnprintf(test_buffer, bufsize, fmt, aq);
>  	va_end(aq);
>  
>  	if (ret != elen) {
> -		pr_warn("vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d\n",
> +		tc_fail("vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d\n",
>  			bufsize, fmt, ret, elen);
> -		return 1;
> +		return;
>  	}
>  
>  	if (memchr_inv(alloced_buffer, FILL_CHAR, PAD_SIZE)) {
> -		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote before buffer\n", bufsize, fmt);
> -		return 1;
> +		tc_fail("vsnprintf(buf, %d, \"%s\", ...) wrote before buffer\n", bufsize, fmt);
> +		return;
>  	}
>  
>  	if (!bufsize) {
>  		if (memchr_inv(test_buffer, FILL_CHAR, BUF_SIZE + PAD_SIZE)) {
> -			pr_warn("vsnprintf(buf, 0, \"%s\", ...) wrote to buffer\n",
> +			tc_fail("vsnprintf(buf, 0, \"%s\", ...) wrote to buffer\n",
>  				fmt);
> -			return 1;
>  		}
> -		return 0;
> +		return;
>  	}
>  
>  	written = min(bufsize-1, elen);
>  	if (test_buffer[written]) {
> -		pr_warn("vsnprintf(buf, %d, \"%s\", ...) did not nul-terminate buffer\n",
> +		tc_fail("vsnprintf(buf, %d, \"%s\", ...) did not nul-terminate buffer\n",
>  			bufsize, fmt);
> -		return 1;
> +		return;
>  	}
>  
>  	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, bufsize - (written + 1))) {
> -		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
> +		tc_fail("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
>  			bufsize, fmt);
> -		return 1;
> +		return;
>  	}
>  
>  	if (memchr_inv(test_buffer + bufsize, FILL_CHAR, BUF_SIZE + PAD_SIZE - bufsize)) {
> -		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond buffer\n", bufsize, fmt);
> -		return 1;
> +		tc_fail("vsnprintf(buf, %d, \"%s\", ...) wrote beyond buffer\n", bufsize, fmt);
> +		return;
>  	}
>  
>  	if (memcmp(test_buffer, expect, written)) {
> -		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'\n",
> +		tc_fail("vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'\n",
>  			bufsize, fmt, test_buffer, written, expect);
> -		return 1;
> +		return;
>  	}
> -	return 0;
>  }
>  
> -static void __printf(3, 4) __init
> +static void __printf(3, 4)
>  __test(const char *expect, int elen, const char *fmt, ...)
>  {
>  	va_list ap;
> @@ -110,9 +107,8 @@ __test(const char *expect, int elen, const char *fmt, ...)
>  	char *p;
>  
>  	if (elen >= BUF_SIZE) {
> -		pr_err("error in test suite: expected output length %d too long. Format was '%s'.\n",
> -		       elen, fmt);
> -		failed_tests++;
> +		tc_fail("error in test suite: expected output length %d too long. Format was '%s'.\n",
> +			elen, fmt);
>  		return;
>  	}
>  
> @@ -124,19 +120,17 @@ __test(const char *expect, int elen, const char *fmt, ...)
>  	 * enough and 0), and then we also test that kvasprintf would
>  	 * be able to print it as expected.
>  	 */
> -	failed_tests += do_test(BUF_SIZE, expect, elen, fmt, ap);
> +	do_test(BUF_SIZE, expect, elen, fmt, ap);
>  	rand = get_random_u32_inclusive(1, elen + 1);
>  	/* Since elen < BUF_SIZE, we have 1 <= rand <= BUF_SIZE. */
> -	failed_tests += do_test(rand, expect, elen, fmt, ap);
> -	failed_tests += do_test(0, expect, elen, fmt, ap);
> +	do_test(rand, expect, elen, fmt, ap);
> +	do_test(0, expect, elen, fmt, ap);
>  
>  	p = kvasprintf(GFP_KERNEL, fmt, ap);
>  	if (p) {
> -		total_tests++;
>  		if (memcmp(p, expect, elen+1)) {
> -			pr_warn("kvasprintf(..., \"%s\", ...) returned '%s', expected '%s'\n",
> +			tc_fail("kvasprintf(..., \"%s\", ...) returned '%s', expected '%s'\n",
>  				fmt, p, expect);
> -			failed_tests++;
>  		}
>  		kfree(p);
>  	}

So reading through this, is there really any reason to drop those
existing total_tests and failed_tests tallies? Since you do need to keep
the control flow the same, leaving the return types and "return
1"/"return 0" and their uses in updating failed_tests would also reduce
the patch size quite significantly.

So they no longer come from some KSTM_MODULE_GLOBALS(), and thus need to
be explicitly declared in this module, but that's exactly how it was
originally until someone decided to lift that from the the printf suite
to kstm.

Yes, they'd need to be explicitly initialized to 0 during kunit_init
since they are no longer use-once __initdata variable, and some
kunit_exit logic would need to "manually" report them.

Rasmus

