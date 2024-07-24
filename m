Return-Path: <linux-kselftest+bounces-14138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A899393ACC4
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 08:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF501C21F1C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 06:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84D9535A3;
	Wed, 24 Jul 2024 06:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kiWVX5O+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783905025E
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 06:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721803412; cv=none; b=gnJBYpG7EOenjv1C7r7HPAGKz+P3/5XVmXblMnAOT0CBbTJXGzzlwVJb7jgdwVmN5CPokBlGrM48A6C4GTO+nC5YUvcEfo4bL7pcqm9BqaDx2nyXI5sCmlecI02cTB6oCIge0UjvsgUM1Evh79BFc6n/IvjZ2TPm5fOc4/4uMhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721803412; c=relaxed/simple;
	bh=hiUH1hfpLphjSNuGCI0Wk/gmou3gCSgKpxPe24e3fVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALEygLULaHEhHcrN9mIV5GNhL7RcA+ZK6POAQGXeMM1kXku4XS9awScfs1P1kHHY3qoaXwEezw36SBkc47L2kJgUxoGOBcahSRaJjEiMFo2oaTx0rZVFmrp+SNCjWmX0AeCb2qPaGI6QvIb/KGQpjG6WWa8NNXrSLczJNtFmAVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kiWVX5O+; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44f9d7cb5c5so221461cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 23:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721803408; x=1722408208; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eM2Uv69CVxSRmXweiZ1bxwYvlHWLxcclXgw88cViSWE=;
        b=kiWVX5O+8WJ4xkT/qT3vDb81Fo/l3Z2Ch0yMiQ5FMI2v7VvdsJfm3rnnV5KHTQuK0y
         Z9SXB+k9MwXhPV+qUEfS00Jq98YJ12i5LCkM1tAFs3FFhEdLgHMSiV1IM11iYAXFHpki
         09Ap0YDWtpsijy0kxMh7L/U1IOEcU/BGBnKxo3JgyzLeFHclSSa/KXRLrfIgdm64aYCx
         FfFyAJDMiqRqWyheI/hLOl2kpSAiMgA3EqsSQV9WRo3xHGPf1kJtT/Fs5Ak1lcK4AIjq
         3IUsfz7tmhIVXMq6ysr1VE570i/9u2pqsXDHLqyKd45+KSZ65HFcc1sepVKXcmKeSynv
         KKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721803408; x=1722408208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eM2Uv69CVxSRmXweiZ1bxwYvlHWLxcclXgw88cViSWE=;
        b=dEpjdfc8w4XSoikmKwOQ/6uIpkpBNF6aIvw2zuNqYJ4S9oZl0FXBcwgDJ9Zjvv2S9V
         GpyQ30Qk3auPl/+EfMqfeJjFIO1Y7pEQ5gVeruCCFEaFOynOEDYUn6lovC2ppkZ5waZg
         DsNb7hLN1eKh038KCBJ+0FOiU/lQv7SEqb7gaU0FNa8w2y2I6GRkNcqtbkRhxbNpOGVK
         GqhH1114Qb1cV724UU+xH5lRGycoGssq5Jm82h+zsNSHJD4h0KwsgmCj91h6WfLfyohF
         5JTEGM5nKQ1sSCrCuQ3HQw3xVVlBnViSISA7KPtGH92CiI5P9+GI+AZoY9bg4bFDaAW7
         5NLg==
X-Forwarded-Encrypted: i=1; AJvYcCXu9Jcq7lJdTOKVEy7XjsIdwPRGpfm3X/pX4mpDP5XpaCCiMxs+LBxbDqH6jugOfGsBADeYXapScfIwzu7dE45icyhHwPFW9MHVDwEpMYzy
X-Gm-Message-State: AOJu0YySGgkLNv+wwJLGNP/TSLTGW4YP+W2Ud04dmDRSc9tH3q0msQJF
	j39BkGG6HbPW88cxl90d5ltqu/o/jzse5+QYhN75RCyIeuXfHxsfkKHEZMqg39wjGkNHj8vH0bP
	msEf0GYYFFvTALHCgHAbD+RAy7WkbW+ITHHh7
X-Google-Smtp-Source: AGHT+IERQ/irJOv4MisrPi/QNY/+lOsfFjAeCoSgr2fRJQcAUd+Ok9bslxQIkITkUCodIKyt78t2gDeufpwWCvE5j+w=
X-Received: by 2002:a05:622a:13ca:b0:447:d78d:773b with SMTP id
 d75a77b69052e-44fd4a76c47mr2665461cf.6.1721803408146; Tue, 23 Jul 2024
 23:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720181025.work.002-kees@kernel.org>
In-Reply-To: <20240720181025.work.002-kees@kernel.org>
From: David Gow <davidgow@google.com>
Date: Wed, 24 Jul 2024 14:43:15 +0800
Message-ID: <CABVgOSnz1nvVQBmcZrTsUp3RStBYwk5_VN5-heOSHq3aYMsXTQ@mail.gmail.com>
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
	boundary="0000000000008c67a0061df898c8"

--0000000000008c67a0061df898c8
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

Thanks.

I'm happy if you want to rename list-test.c -> list_kunit.c, too.

Cheers
-- David

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

--0000000000008c67a0061df898c8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
JEfDtvHU6wy3MSBE3/TrMFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AGwXYwvLVjByVooZ+uKzQVW2nnClCIizd0jfARuMRTPNAWI2uOBSKoR0T6XWsGsVvX1vBF0FA+a9
DQOd8GYqzEaKOiHDIjq/o455YXkiKhPpxDSIM+7st/OZnlkRbgAyq4rAhAjbZlceKp+1vj0wIvCa
4evQZvJNnJvTb4Vcnqf4Xg2Pl57hSUAgejWvIGAxfiAKG8Zk09I9DNd84hucIS2UIgoRGGWw3eIg
GQs0EfiilyTgsH8iMOPqUJ1h4oX9z1FpaiJzfxcvcGG46SCieSFP0USs9aMl7GeERue37kBf14Pd
kOYIfx09Pcv/N6lHV6kXlzG0xeUuV3RxtLtszQgxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAFsPHWl8lqMEwx3lAnpufYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIMGZ2yAL0VfU2724txV50/Rg6ZEojpi61SLfRYrctg0pMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcyNDA2NDMyOFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAKQx+a
D75DG8lMeTmcMHcl85snOx5wEkkrB188+qm10rhrAEhq26YiZDktW2D97Xq/SsuMT7J/UnqRk1R0
E8r++nljCOqDh8WTW9eRVFeUnWU7ddfgOUcNPRkHjDRXWas5z9mDs1SFS6Y5x4CFTJnzqf18817G
k/jfHB7kzU8DN89Km9cOOcAmAo/2HnhKO3m0jBvM3aXTQULZawdAlQSWt/TOVHMxffFV7sysuNgx
4JQa4YWLnjNBnJ7N0nug4xaGeybclOKOGW/NvvUS/fm0SnPgfPFmPgsiymQOKWwVYZD+64Eti5zR
xGpSyElHi8jwoQY/ubcGcqncdouqpBlK
--0000000000008c67a0061df898c8--

