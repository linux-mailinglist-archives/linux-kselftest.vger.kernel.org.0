Return-Path: <linux-kselftest+bounces-19526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C964999E21
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 09:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E891F2133E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 07:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC5E209F55;
	Fri, 11 Oct 2024 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="klwZNfcG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DA4209F4D
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632488; cv=none; b=fmu3t94Rtsuq5WFFAufYokHiX6j7II5vR6PFGWzea8r3RvK5Wq8FthbtcksoC0VGfkD/otDQ6S7goniTEhtqOceYnyfmWe8oDn+8McLwVT3EfTSp5aU1vNEMNb9DzcRZtN4ssCVem9mrsBMbSrGKL8qEPzoGc8QkI95hKC3rV1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632488; c=relaxed/simple;
	bh=Vr31J4NKtWh1sS877Cy6GUmzOYXOy5bEi2pcapzvXx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxdCuMUbAIYjnFwZ6m/Pn98BCGYkTa0H0ErwShDGfGPwISrX4xE+odal1XmdyFlLW8cvqWg0ggjuE95CpC0y0ZyRrGuaFPLWOVptT57CpfQz2sxwL8lGzsY9oBGZcRjUNjBv/FFGubDa0V1VszkAHtPvVOzwpU6gOjJn+KavqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=klwZNfcG; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbf0e6414aso2026236d6.1
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 00:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728632485; x=1729237285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8BaKFo4iA4daeUxYlEPFAYS0JdW8kJ64k+jNq5DS7Zs=;
        b=klwZNfcGz1RtVpyVTTvCs/L647heT6ElDGoAucbX94hVS5bMtR62TtHpHojddOuTjS
         TO0oDZ+Gppl6jfvGoIaYsCSMTvGYTi+5qkKU1e/QwxAUoWsPbUIx3FOXXH+0HtzjxNVi
         RzNq23WS6TjHBqKQ7rj/T00SepTWxQWK+a93dhsk/blAOrqZMGlmXF2DdM/bot70CmPW
         mcWiPuhcaDcNFQV7OJM2C1/DvBh/vNfE3zMfMkjTdPZBe7qa1XpqwSvmBne/a/Rk1W6m
         sSzFDANM7qvEt1Fw2CpbArzRDjCEIuJ4yhN/hpQHxOj32STFQKScxsE6NYpYZRHswSU0
         DTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728632485; x=1729237285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BaKFo4iA4daeUxYlEPFAYS0JdW8kJ64k+jNq5DS7Zs=;
        b=LV6Wk78VcMTUFmIyY3bDqFuewycqPPnZbfJEx3Jf9D9jVAKd861Sn6smpS01Qpjyvw
         OoeJ4Cp9sPv2WpJSUXMf0ieD7VlsJqfB4EiJNZfCqMOl+iBJ3BsG7C8n1D3uamrVmSr7
         1nV+QeOYvYXNJbEuKDbmJXQGksC0Q1F0rptXwmQwRssT8v3lUJ2fspclPTaiCS2v7260
         jWX+01rDUTET4IotIl4Y/fDbZlzJ49JR024Z7Jw2WNCkRGejHut0kezWxhpbuvZ5YYV9
         yfpY3VXFZwrG1jPKvSyqB+4BMPPEL9vsOiMdIOptqYUmWgxsMkorkMdkWIEqpYMS25RD
         YWnA==
X-Forwarded-Encrypted: i=1; AJvYcCViOR+2EcaPKoZZrFzFbTcoWPcZ98Edvc9KaYaktAIBfmF8KB9nDyLdYAZGweG6jjg11XNRsMpZaJYib+7EWvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya7PdsLQ+ZFGcNWCRWHkyOkqjTLBRPOkOLAI2Q4yDlyu4IDSlP
	TdHLPCcdTV3zY7EsQjOkPLUTXY3YWRK1+C6efs2EKiJnXyQ52kqYzhMyL/4z4M2HLDZu621PrMb
	A4UU/zxdfOUnEsulU/vX+NX8bxaUdZccsirV0
X-Google-Smtp-Source: AGHT+IHDT/eIP+Pbzm+Om/uBXkiRIL9h7c3KOxhsZUZ1+q9+BD3/W8/4GrYct/epDfZRG/JhiryJBtZsNSLPx6iD7bw=
X-Received: by 2002:a05:6214:5b08:b0:6cb:e947:2d12 with SMTP id
 6a1803df08f44-6cbeffff575mr19699606d6.25.1728632484422; Fri, 11 Oct 2024
 00:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720181025.work.002-kees@kernel.org>
In-Reply-To: <20240720181025.work.002-kees@kernel.org>
From: David Gow <davidgow@google.com>
Date: Fri, 11 Oct 2024 15:41:12 +0800
Message-ID: <CABVgOSnXJcQ_E1DJK+==H7DZ0X7OnkaPsbaX=Oh=CZ4jjCVhkg@mail.gmail.com>
Subject: Re: [PATCH] lib: Move KUnit tests into tests/ subdirectory
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Andy Shevchenko <andy@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, linux-hardening@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-trace-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Shuah Khan <skhan@linuxfoundation.org>, Daniel Latypov <dlatypov@google.com>, 
	Guenter Roeck <linux@roeck-us.net>, David Howells <dhowells@redhat.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Nathan Chancellor <nathan@kernel.org>, 
	Fangrui Song <maskray@google.com>, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000037a56006242e9d87"

--00000000000037a56006242e9d87
Content-Type: text/plain; charset="UTF-8"

On Sun, 21 Jul 2024 at 02:10, Kees Cook <kees@kernel.org> wrote:
>
> Following from the recent KUnit file naming discussion[1], move all
> KUnit tests in lib/ into lib/tests/.
>
> Link: https://lore.kernel.org/lkml/20240720165441.it.320-kees@kernel.org/ [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> I can carry this in the hardening tree. To disrupt people as little as
> possible, I'm hoping to send this either at the end of -rc1 or early
> in -rc2.
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: David Gow <davidgow@google.com>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> Cc: linux-hardening@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: linux-trace-kernel@vger.kernel.org
> ---

I've just rebased this and sent it out as part of a series of renames to Andrew:
https://lore.kernel.org/linux-kselftest/20241011072509.3068328-5-davidgow@google.com/T/#u

Hopefully this will be a workable way of getting all of the different
renames (and other things entangled with renames) in, but let me know
if it causes problems / if I broke it.

Cheers,
-- David



>  MAINTAINERS                            | 18 ++++++-------
>  lib/Makefile                           | 35 +-----------------------
>  lib/tests/Makefile                     | 37 ++++++++++++++++++++++++++
>  lib/{ => tests}/bitfield_kunit.c       |  0
>  lib/{ => tests}/checksum_kunit.c       |  0
>  lib/{ => tests}/cmdline_kunit.c        |  0
>  lib/{ => tests}/cpumask_kunit.c        |  0
>  lib/{ => tests}/fortify_kunit.c        |  0
>  lib/{ => tests}/hashtable_test.c       |  0
>  lib/{ => tests}/is_signed_type_kunit.c |  0
>  lib/{ => tests}/kunit_iov_iter.c       |  0
>  lib/{ => tests}/list-test.c            |  0
>  lib/{ => tests}/memcpy_kunit.c         |  0
>  lib/{ => tests}/overflow_kunit.c       |  0
>  lib/{ => tests}/siphash_kunit.c        |  0
>  lib/{ => tests}/slub_kunit.c           |  0
>  lib/{ => tests}/stackinit_kunit.c      |  0
>  lib/{ => tests}/string_helpers_kunit.c |  0
>  lib/{ => tests}/string_kunit.c         |  0
>  lib/{ => tests}/test_bits.c            |  0
>  lib/{ => tests}/test_fprobe.c          |  0
>  lib/{ => tests}/test_hash.c            |  0
>  lib/{ => tests}/test_kprobes.c         |  0
>  lib/{ => tests}/test_linear_ranges.c   |  0
>  lib/{ => tests}/test_list_sort.c       |  0
>  lib/{ => tests}/test_sort.c            |  0
>  26 files changed, 47 insertions(+), 43 deletions(-)
>  create mode 100644 lib/tests/Makefile
>  rename lib/{ => tests}/bitfield_kunit.c (100%)
>  rename lib/{ => tests}/checksum_kunit.c (100%)
>  rename lib/{ => tests}/cmdline_kunit.c (100%)
>  rename lib/{ => tests}/cpumask_kunit.c (100%)
>  rename lib/{ => tests}/fortify_kunit.c (100%)
>  rename lib/{ => tests}/hashtable_test.c (100%)
>  rename lib/{ => tests}/is_signed_type_kunit.c (100%)
>  rename lib/{ => tests}/kunit_iov_iter.c (100%)
>  rename lib/{ => tests}/list-test.c (100%)
>  rename lib/{ => tests}/memcpy_kunit.c (100%)
>  rename lib/{ => tests}/overflow_kunit.c (100%)
>  rename lib/{ => tests}/siphash_kunit.c (100%)
>  rename lib/{ => tests}/slub_kunit.c (100%)
>  rename lib/{ => tests}/stackinit_kunit.c (100%)
>  rename lib/{ => tests}/string_helpers_kunit.c (100%)
>  rename lib/{ => tests}/string_kunit.c (100%)
>  rename lib/{ => tests}/test_bits.c (100%)
>  rename lib/{ => tests}/test_fprobe.c (100%)
>  rename lib/{ => tests}/test_hash.c (100%)
>  rename lib/{ => tests}/test_kprobes.c (100%)
>  rename lib/{ => tests}/test_linear_ranges.c (100%)
>  rename lib/{ => tests}/test_list_sort.c (100%)
>  rename lib/{ => tests}/test_sort.c (100%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8754ac2c259d..3f4b9d007cbb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3737,10 +3737,10 @@ F:      include/vdso/bits.h
>  F:     lib/bitmap-str.c
>  F:     lib/bitmap.c
>  F:     lib/cpumask.c
> -F:     lib/cpumask_kunit.c
>  F:     lib/find_bit.c
>  F:     lib/find_bit_benchmark.c
>  F:     lib/test_bitmap.c
> +F:     lib/tests/cpumask_kunit.c
>  F:     tools/include/linux/bitfield.h
>  F:     tools/include/linux/bitmap.h
>  F:     tools/include/linux/bits.h
> @@ -8618,9 +8618,9 @@ L:        linux-hardening@vger.kernel.org
>  S:     Supported
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
>  F:     include/linux/fortify-string.h
> -F:     lib/fortify_kunit.c
> -F:     lib/memcpy_kunit.c
>  F:     lib/test_fortify/*
> +F:     lib/tests/fortify_kunit.c
> +F:     lib/tests/memcpy_kunit.c
>  F:     scripts/test_fortify.sh
>  K:     \b__NO_FORTIFY\b
>
> @@ -9246,9 +9246,9 @@ F:        include/linux/string.h
>  F:     include/linux/string_choices.h
>  F:     include/linux/string_helpers.h
>  F:     lib/string.c
> -F:     lib/string_kunit.c
>  F:     lib/string_helpers.c
> -F:     lib/string_helpers_kunit.c
> +F:     lib/tests/string_helpers_kunit.c
> +F:     lib/tests/string_kunit.c
>  F:     scripts/coccinelle/api/string_choices.cocci
>
>  GENERIC UIO DRIVER FOR PCI DEVICES
> @@ -12347,7 +12347,7 @@ F:      Documentation/trace/kprobes.rst
>  F:     include/asm-generic/kprobes.h
>  F:     include/linux/kprobes.h
>  F:     kernel/kprobes.c
> -F:     lib/test_kprobes.c
> +F:     lib/tests/test_kprobes.c
>  F:     samples/kprobes
>
>  KS0108 LCD CONTROLLER DRIVER
> @@ -12697,7 +12697,7 @@ M:      Mark Brown <broonie@kernel.org>
>  R:     Matti Vaittinen <mazziesaccount@gmail.com>
>  F:     include/linux/linear_range.h
>  F:     lib/linear_ranges.c
> -F:     lib/test_linear_ranges.c
> +F:     lib/tests/test_linear_ranges.c
>
>  LINUX FOR POWER MACINTOSH
>  L:     linuxppc-dev@lists.ozlabs.org
> @@ -12824,7 +12824,7 @@ M:      David Gow <davidgow@google.com>
>  L:     linux-kselftest@vger.kernel.org
>  L:     kunit-dev@googlegroups.com
>  S:     Maintained
> -F:     lib/list-test.c
> +F:     lib/tests/list-test.c
>
>  LITEX PLATFORM
>  M:     Karol Gugala <kgugala@antmicro.com>
> @@ -20498,7 +20498,7 @@ M:      Jason A. Donenfeld <Jason@zx2c4.com>
>  S:     Maintained
>  F:     include/linux/siphash.h
>  F:     lib/siphash.c
> -F:     lib/siphash_kunit.c
> +F:     lib/tests/siphash_kunit.c
>
>  SIS 190 ETHERNET DRIVER
>  M:     Francois Romieu <romieu@fr.zoreil.com>
> diff --git a/lib/Makefile b/lib/Makefile
> index 3b1769045651..f00fe120ee9e 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -49,9 +49,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
>          percpu-refcount.o rhashtable.o base64.o \
>          once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
>          generic-radix-tree.o bitmap-str.o
> -obj-$(CONFIG_STRING_KUNIT_TEST) += string_kunit.o
>  obj-y += string_helpers.o
> -obj-$(CONFIG_STRING_HELPERS_KUNIT_TEST) += string_helpers_kunit.o
>  obj-y += hexdump.o
>  obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
>  obj-y += kstrtox.o
> @@ -62,22 +60,17 @@ obj-$(CONFIG_TEST_DHRY) += test_dhry.o
>  obj-$(CONFIG_TEST_FIRMWARE) += test_firmware.o
>  obj-$(CONFIG_TEST_BITOPS) += test_bitops.o
>  CFLAGS_test_bitops.o += -Werror
> -obj-$(CONFIG_CPUMASK_KUNIT_TEST) += cpumask_kunit.o
>  obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
> -obj-$(CONFIG_TEST_IOV_ITER) += kunit_iov_iter.o
> -obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
>  obj-$(CONFIG_TEST_IDA) += test_ida.o
>  obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
>  CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
>  CFLAGS_test_ubsan.o += $(call cc-disable-warning, unused-but-set-variable)
>  UBSAN_SANITIZE_test_ubsan.o := y
>  obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
> -obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
>  obj-$(CONFIG_TEST_MIN_HEAP) += test_min_heap.o
>  obj-$(CONFIG_TEST_LKM) += test_module.o
>  obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
>  obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
> -obj-$(CONFIG_TEST_SORT) += test_sort.o
>  obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
>  obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
>  obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
> @@ -104,10 +97,7 @@ obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
>  obj-$(CONFIG_TEST_LOCKUP) += test_lockup.o
>  obj-$(CONFIG_TEST_HMM) += test_hmm.o
>  obj-$(CONFIG_TEST_FREE_PAGES) += test_free_pages.o
> -obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
>  obj-$(CONFIG_TEST_REF_TRACKER) += test_ref_tracker.o
> -CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
> -obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
>  obj-$(CONFIG_TEST_OBJPOOL) += test_objpool.o
>
>  obj-$(CONFIG_TEST_FPU) += test_fpu.o
> @@ -129,7 +119,7 @@ endif
>  obj-$(CONFIG_DEBUG_INFO_REDUCED) += debug_info.o
>  CFLAGS_debug_info.o += $(call cc-option, -femit-struct-debug-detailed=any)
>
> -obj-y += math/ crypto/
> +obj-y += math/ crypto/ tests/
>
>  obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
>  obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
> @@ -366,29 +356,6 @@ obj-$(CONFIG_OBJAGG) += objagg.o
>  # pldmfw library
>  obj-$(CONFIG_PLDMFW) += pldmfw/
>
> -# KUnit tests
> -CFLAGS_bitfield_kunit.o := $(DISABLE_STRUCTLEAK_PLUGIN)
> -obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
> -obj-$(CONFIG_CHECKSUM_KUNIT) += checksum_kunit.o
> -obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
> -obj-$(CONFIG_HASHTABLE_KUNIT_TEST) += hashtable_test.o
> -obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
> -obj-$(CONFIG_BITS_TEST) += test_bits.o
> -obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
> -obj-$(CONFIG_SLUB_KUNIT_TEST) += slub_kunit.o
> -obj-$(CONFIG_MEMCPY_KUNIT_TEST) += memcpy_kunit.o
> -obj-$(CONFIG_IS_SIGNED_TYPE_KUNIT_TEST) += is_signed_type_kunit.o
> -CFLAGS_overflow_kunit.o = $(call cc-disable-warning, tautological-constant-out-of-range-compare)
> -obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
> -CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
> -obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
> -CFLAGS_fortify_kunit.o += $(call cc-disable-warning, unsequenced)
> -CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-overread)
> -CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-truncation)
> -CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
> -obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
> -obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
> -
>  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
>
>  obj-$(CONFIG_FIRMWARE_TABLE) += fw_table.o
> diff --git a/lib/tests/Makefile b/lib/tests/Makefile
> new file mode 100644
> index 000000000000..c6a14cc8663e
> --- /dev/null
> +++ b/lib/tests/Makefile
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for tests of kernel library functions.
> +
> +# KUnit tests
> +CFLAGS_bitfield_kunit.o := $(DISABLE_STRUCTLEAK_PLUGIN)
> +obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
> +obj-$(CONFIG_BITS_TEST) += test_bits.o
> +obj-$(CONFIG_CHECKSUM_KUNIT) += checksum_kunit.o
> +obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
> +obj-$(CONFIG_CPUMASK_KUNIT_TEST) += cpumask_kunit.o
> +CFLAGS_fortify_kunit.o += $(call cc-disable-warning, unsequenced)
> +CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-overread)
> +CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-truncation)
> +CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
> +obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
> +CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
> +obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
> +obj-$(CONFIG_HASHTABLE_KUNIT_TEST) += hashtable_test.o
> +obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
> +obj-$(CONFIG_TEST_IOV_ITER) += kunit_iov_iter.o
> +obj-$(CONFIG_IS_SIGNED_TYPE_KUNIT_TEST) += is_signed_type_kunit.o
> +obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
> +obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
> +obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
> +obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
> +obj-$(CONFIG_MEMCPY_KUNIT_TEST) += memcpy_kunit.o
> +CFLAGS_overflow_kunit.o = $(call cc-disable-warning, tautological-constant-out-of-range-compare)
> +obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
> +obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
> +obj-$(CONFIG_SLUB_KUNIT_TEST) += slub_kunit.o
> +obj-$(CONFIG_TEST_SORT) += test_sort.o
> +CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
> +obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
> +obj-$(CONFIG_STRING_KUNIT_TEST) += string_kunit.o
> +obj-$(CONFIG_STRING_HELPERS_KUNIT_TEST) += string_helpers_kunit.o
> +
> diff --git a/lib/bitfield_kunit.c b/lib/tests/bitfield_kunit.c
> similarity index 100%
> rename from lib/bitfield_kunit.c
> rename to lib/tests/bitfield_kunit.c
> diff --git a/lib/checksum_kunit.c b/lib/tests/checksum_kunit.c
> similarity index 100%
> rename from lib/checksum_kunit.c
> rename to lib/tests/checksum_kunit.c
> diff --git a/lib/cmdline_kunit.c b/lib/tests/cmdline_kunit.c
> similarity index 100%
> rename from lib/cmdline_kunit.c
> rename to lib/tests/cmdline_kunit.c
> diff --git a/lib/cpumask_kunit.c b/lib/tests/cpumask_kunit.c
> similarity index 100%
> rename from lib/cpumask_kunit.c
> rename to lib/tests/cpumask_kunit.c
> diff --git a/lib/fortify_kunit.c b/lib/tests/fortify_kunit.c
> similarity index 100%
> rename from lib/fortify_kunit.c
> rename to lib/tests/fortify_kunit.c
> diff --git a/lib/hashtable_test.c b/lib/tests/hashtable_test.c
> similarity index 100%
> rename from lib/hashtable_test.c
> rename to lib/tests/hashtable_test.c
> diff --git a/lib/is_signed_type_kunit.c b/lib/tests/is_signed_type_kunit.c
> similarity index 100%
> rename from lib/is_signed_type_kunit.c
> rename to lib/tests/is_signed_type_kunit.c
> diff --git a/lib/kunit_iov_iter.c b/lib/tests/kunit_iov_iter.c
> similarity index 100%
> rename from lib/kunit_iov_iter.c
> rename to lib/tests/kunit_iov_iter.c
> diff --git a/lib/list-test.c b/lib/tests/list-test.c
> similarity index 100%
> rename from lib/list-test.c
> rename to lib/tests/list-test.c
> diff --git a/lib/memcpy_kunit.c b/lib/tests/memcpy_kunit.c
> similarity index 100%
> rename from lib/memcpy_kunit.c
> rename to lib/tests/memcpy_kunit.c
> diff --git a/lib/overflow_kunit.c b/lib/tests/overflow_kunit.c
> similarity index 100%
> rename from lib/overflow_kunit.c
> rename to lib/tests/overflow_kunit.c
> diff --git a/lib/siphash_kunit.c b/lib/tests/siphash_kunit.c
> similarity index 100%
> rename from lib/siphash_kunit.c
> rename to lib/tests/siphash_kunit.c
> diff --git a/lib/slub_kunit.c b/lib/tests/slub_kunit.c
> similarity index 100%
> rename from lib/slub_kunit.c
> rename to lib/tests/slub_kunit.c
> diff --git a/lib/stackinit_kunit.c b/lib/tests/stackinit_kunit.c
> similarity index 100%
> rename from lib/stackinit_kunit.c
> rename to lib/tests/stackinit_kunit.c
> diff --git a/lib/string_helpers_kunit.c b/lib/tests/string_helpers_kunit.c
> similarity index 100%
> rename from lib/string_helpers_kunit.c
> rename to lib/tests/string_helpers_kunit.c
> diff --git a/lib/string_kunit.c b/lib/tests/string_kunit.c
> similarity index 100%
> rename from lib/string_kunit.c
> rename to lib/tests/string_kunit.c
> diff --git a/lib/test_bits.c b/lib/tests/test_bits.c
> similarity index 100%
> rename from lib/test_bits.c
> rename to lib/tests/test_bits.c
> diff --git a/lib/test_fprobe.c b/lib/tests/test_fprobe.c
> similarity index 100%
> rename from lib/test_fprobe.c
> rename to lib/tests/test_fprobe.c
> diff --git a/lib/test_hash.c b/lib/tests/test_hash.c
> similarity index 100%
> rename from lib/test_hash.c
> rename to lib/tests/test_hash.c
> diff --git a/lib/test_kprobes.c b/lib/tests/test_kprobes.c
> similarity index 100%
> rename from lib/test_kprobes.c
> rename to lib/tests/test_kprobes.c
> diff --git a/lib/test_linear_ranges.c b/lib/tests/test_linear_ranges.c
> similarity index 100%
> rename from lib/test_linear_ranges.c
> rename to lib/tests/test_linear_ranges.c
> diff --git a/lib/test_list_sort.c b/lib/tests/test_list_sort.c
> similarity index 100%
> rename from lib/test_list_sort.c
> rename to lib/tests/test_list_sort.c
> diff --git a/lib/test_sort.c b/lib/tests/test_sort.c
> similarity index 100%
> rename from lib/test_sort.c
> rename to lib/tests/test_sort.c
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20240720181025.work.002-kees%40kernel.org.

--00000000000037a56006242e9d87
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUqgYJKoZIhvcNAQcCoIIUmzCCFJcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
erg7AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFKFQnbTpSq0q
cOYnlrbegXJIIvA6MFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBR
nRJBmUP+IpudtmSQ/R55Sv0qv8TO9zHTlIdsIf2Gc/zeCi0SamUQkFWb01d7Q+20kcpxNzwV6M7y
hDRk5uuVFvtVxOrmbhflCo0uBpD9vz/symtfJYZLNyvSDi1PIVrwGNpyRrD0W6VQJxzzsBTwsO+S
XWN3+x70+QDf7+zovW7KF0/y8QYD6PIN7Y9LRUXct0HKhatkHmO3w6MSJatnqSvsjffIwpNecUMo
h10c6Etz17b7tbGdxdxLw8njN+UnfoFp3v4irrafB6jkArRfsR5TscZUUKej0ihl7mXEKUBmClkP
ndcbXHFxS6WTkpjvl7Jjja8DdWJSJmdEWUnFjnQnDrqLqvYjeVMS/8IBF57eyT6yEPrMzA+Zd+f5
hnM7HuBSGvVHv+c/rlHVp0S364DBGXj11obl7nKgL9D59QwC5/kNJ1whoKwsATUSepanzALdOTn3
BavXUVE38e4c90il44T1bphqtLfmHZ1T5ZwxjtjzNMKy0Mb9j/jcFxfibCISYbnk661FBe38bhYj
0DhqINx2fw0bwhpfFGADOZDe5DVhI7AIW/kEMHuIgAJ/HPgyn1+tldOPWiFLQbTNNBnfGv9sDPz0
hWV2vSAXq35i+JS06BCkbGfE5ci6zFy4pt8fmqMGKFH/t3ELCTYo116lqUTDcVC8DAWN8E55aDGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAZ6Vqszmp/3gGFW0sCFu
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQg4cHpYsTHIsuR90Br85sWehCxHiFg
6iopPQAwb8rbB20wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MDExMDc0MTI1WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAEpo4IUUZCdZiQSwmGOn+Uf0qQ+oW/yuZHbul9LnrS+DU1Tx
6/yVeuH8BXxkGFawr2AP0HwGETjTMJvg3FbvTDf1eMf/U+NGd+HuXADwRtVCUyyl43Gkr87gM6dc
GbmHaBevW4n3/b/iPdGRcbrnEEuc8sTYYXWsCzlbkc08aLMrliId2ne+jprD5DXtfaKqbkplQkKH
lmQPSuVV4763tpKuWd7JrmocnsP1s0r2yfzgKzEXDVuS0YdiI7/yRtLiT++y68q/dRe3zZVwvYWo
mdQ8D0AVQj4xuADn5tN4TjF2JA/2ZQqxvJbGBfUj00ib4EwTEyticLpQ+EhpwtjROC8=
--00000000000037a56006242e9d87--

