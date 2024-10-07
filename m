Return-Path: <linux-kselftest+bounces-19179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EE8993789
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 21:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1F01C2320A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 19:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC221DE3DA;
	Mon,  7 Oct 2024 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EwY9sHJV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2541DE3D6
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Oct 2024 19:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728330106; cv=none; b=oc9UJrxqi7iAaY7BKcYIkp86bsWp0trbKv5JvyAszzTjeBNEDsbyNkzQ+r5fjvJ9urhZdiSohjpTFbQEJX5k6Y+FsMR/5M61ur/LY/udbDDmV2pj/fVobR1d9Oo6zX57QFT6MXyalsCTaXduaPC9RlF24uMNHxPIyKTwAjeHQrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728330106; c=relaxed/simple;
	bh=zf/VeBuEZrnh4exdUEQ5oRJ18LCtlUUMIB6Xf3ntymU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OpIyEI0/cJJV+V57Q5E7UwM+ZCWEm+TwytuKJiKRJcQdWvc80nQa1a9ElTAeR+nm4zofI5maoZXxQe91cSXlHKWPXC9v7rP11vSl1I35QzvGYSyIee9/y1Go5T38z1ZBWybojocOnr3GxtBMiJ3i7Yo/CGkTR68sVQBIorf149E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EwY9sHJV; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a34802247eso27901845ab.0
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Oct 2024 12:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728330103; x=1728934903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xxu9Zk90QqGZGGEGFcTSRjhWKEo03ZZ3G7RMXPv9kqo=;
        b=EwY9sHJVfentkqsWPWqgIOUtzJrNPfQuFpzTvhi8c7gHijJCZ3xyzag0PdXdz0180T
         K7ej7BKDYFnHq7XXn5qMDj9m+GsfgDdrivcfQP9JxzOG9918+VOUWBPsQKIxDZ5c8gDO
         jfk0vQMZDFMmo5iPaIdXJHFsfZaj2KwU9XDj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728330103; x=1728934903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxu9Zk90QqGZGGEGFcTSRjhWKEo03ZZ3G7RMXPv9kqo=;
        b=u0cRqbZUA9NHO1Uk5czitgsWOBosgt6rZIDZEGP17XAUz873mZrQ7HYqdZnSTR3cLA
         0RYJD31HDvmppB15toX2n/kLk9pF+mKG8fAjLleZg5fTsNizObDwiYhGTiG1XDonY+DQ
         dYNxGbDVSCMHNcJJnamtXLyC6mtCLxqNuIzW9U4Pg8ZpORFAoazM29tEBIjh+Jy5Mly5
         OFCGOxSFYKdwaO75dJjJG8Bj0MszdqzSCgrtOadsG5dYtXuIKXMmCHz7kHvT3k4BMnhj
         q2lNUhOyv2iT69AC41zm8dgB+2b9LUDP+wWk46M0Y6oGMjrGXad8p7f1THvSwe4RWaWV
         6PUg==
X-Forwarded-Encrypted: i=1; AJvYcCU6taBiSr5cEO4bCKNUy0are8/qWu5CHA6qvcYVKcdnUdhlbNehAIvbDuLDhaSCrl3lc0wrhLJg+14ZrVAER5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjsS08Xu+UNFZ8lyLn/wzjBwgbpWY+bZHRS8dmB0jgHdBj16Sf
	GgRgudzNdlo9N8JehRI+iNspFTVzPwTwAmEbQOMrNLIROrqUcbm1LT3BbKbIpQ4=
X-Google-Smtp-Source: AGHT+IHdrptOjJye8JY+jScwD3H9vRhHGbz1Dn5EaeaqFcYvVuBpiDEA7xXZzMSKq2MifrRIfTM9cQ==
X-Received: by 2002:a92:c56e:0:b0:3a2:463f:fd9f with SMTP id e9e14a558f8ab-3a375a9cfe6mr118750545ab.11.1728330102692;
        Mon, 07 Oct 2024 12:41:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db91334e11sm225826173.74.2024.10.07.12.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 12:41:42 -0700 (PDT)
Message-ID: <fedcb6e0-7e21-4644-8ed9-e22658b48bca@linuxfoundation.org>
Date: Mon, 7 Oct 2024 13:41:40 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Kunit to check the longest symbol length
To: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, David Rheinsberg <david@readahead.eu>,
 rust-for-linux@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, ricardo.marliere@suse.com,
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240924172351.23225-1-sergio.collado@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240924172351.23225-1-sergio.collado@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/24/24 11:23, Sergio González Collado wrote:
> The longest length of a symbol (KSYM_NAME_LEN) was increased to 512
> in the reference [1]. This patch adds a kunit test to check the longest
> symbol length.
> 
> This test can also help other efforts for longer symbol lenght,
Spelling - length

Can you explain what kind of tests does it run and how it is useful?
Include test output in the change log.

> like [2].
> 
> [1] https://lore.kernel.org/lkml/20220802015052.10452-6-ojeda@kernel.org/
> [2] https://lore.kernel.org/lkml/20240605032120.3179157-1-song@kernel.org/
> 
> Tested-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
> ---
> V1 -> V2: corrected CI tests. Added fix proposed at [3]
> 
> [3] https://lore.kernel.org/lkml/Y9ES4UKl%2F+DtvAVS@gmail.com/T/#m3ef0e12bb834d01ed1ebdcae12ef5f2add342077
> ---
> V2 -> V3: updated base and added MODULE_DESCRIPTION() and MODULE_AUTHOR()
> ---
> V3 -> V4: add x86 mantainers, add new reference.
> ---
>   arch/x86/tools/insn_decoder_test.c |   3 +-
>   lib/Kconfig.debug                  |   9 +++
>   lib/Makefile                       |   2 +
>   lib/longest_symbol_kunit.c         | 124 +++++++++++++++++++++++++++++
>   4 files changed, 137 insertions(+), 1 deletion(-)
>   create mode 100644 lib/longest_symbol_kunit.c
> 
> diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder_test.c
> index 472540aeabc2..3bde35ea4188 100644
> --- a/arch/x86/tools/insn_decoder_test.c
> +++ b/arch/x86/tools/insn_decoder_test.c
> @@ -10,6 +10,7 @@
>   #include <assert.h>
>   #include <unistd.h>
>   #include <stdarg.h>
> +#include <linux/kallsysms.h>
>   
>   #define unlikely(cond) (cond)
>   
> @@ -106,7 +107,7 @@ static void parse_args(int argc, char **argv)
>   	}
>   }
>   
> -#define BUFSIZE 256
> +#define BUFSIZE (256 + KSYM_NAME_LEN)
>   
>   int main(int argc, char **argv)
>   {
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index bc8faa4509e1..09015e7e07f3 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2805,6 +2805,15 @@ config FORTIFY_KUNIT_TEST
>   	  by the str*() and mem*() family of functions. For testing runtime
>   	  traps of FORTIFY_SOURCE, see LKDTM's "FORTIFY_*" tests.
>   
> +config LONGEST_SYM_KUNIT_TEST
> +	tristate "Test the longest symbol possible" if !KUNIT_ALL_TESTS
> +	depends on KUNIT && KPROBES
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Tests the longest symbol possible

Can you add more detail why one would want to enable this test?

> +
> +	  If unsure, say N.
> +
>   config HW_BREAKPOINT_KUNIT_TEST
>   	bool "Test hw_breakpoint constraints accounting" if !KUNIT_ALL_TESTS
>   	depends on HAVE_HW_BREAKPOINT
> diff --git a/lib/Makefile b/lib/Makefile
> index 773adf88af41..fc878e716825 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -389,6 +389,8 @@ CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
>   obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
>   obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
>   obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
> +obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) += longest_symbol_kunit.o
> +CFLAGS_longest_symbol_kunit.o += $(call cc-disable-warning, missing-prototypes)
>   
>   obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
>   
> diff --git a/lib/longest_symbol_kunit.c b/lib/longest_symbol_kunit.c
> new file mode 100644
> index 000000000000..557ad6eae56c
> --- /dev/null
> +++ b/lib/longest_symbol_kunit.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test the longest symbol length. Execute with:
> + *  ./tools/testing/kunit/kunit.py run longest-symbol
> + *  --arch=x86_64 --kconfig_add CONFIG_KPROBES=y --kconfig_add CONFIG_MODULES=y
> + *  --kconfig_add CONFIG_RETPOLINE=n
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <kunit/test.h>
> +#include <linux/stringify.h>
> +#include <linux/kprobes.h>
> +#include <linux/kallsyms.h>
> +
> +#define DI(name) s##name##name
> +#define DDI(name) DI(n##name##name)
> +#define DDDI(name) DDI(n##name##name)
> +#define DDDDI(name) DDDI(n##name##name)
> +#define DDDDDI(name) DDDDI(n##name##name)
> +
> +#define PLUS1(name) __PASTE(name, e)
> +
> +/*Generate a symbol whose name length is 511 */
> +#define LONGEST_SYM_NAME  DDDDDI(g1h2i3j4k5l6m7n)
> +
> +/*Generate a symbol whose name length is 512 */
> +#define LONGEST_SYM_NAME_PLUS1 PLUS1(LONGEST_SYM_NAME)
> +
> +#define RETURN_LONGEST_SYM 0xAAAAA
> +#define RETURN_LONGEST_SYM_PLUS1 0x55555
> +
> +noinline int LONGEST_SYM_NAME(void);
> +noinline int LONGEST_SYM_NAME(void)
> +{
> +	return RETURN_LONGEST_SYM;
> +}
> +
> +noinline int LONGEST_SYM_NAME_PLUS1(void);
> +noinline int LONGEST_SYM_NAME_PLUS1(void)
> +{
> +	return RETURN_LONGEST_SYM_PLUS1;
> +}
> +
> +_Static_assert(sizeof(__stringify(LONGEST_SYM_NAME)) == KSYM_NAME_LEN,
> +"Incorrect symbol length found. Expected KSYM_NAME_LEN: "
> +__stringify(KSYM_NAME) ", but found: "
> +__stringify(sizeof(LONGEST_SYM_NAME)));
> +
> +static void test_longest_symbol(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test, RETURN_LONGEST_SYM, LONGEST_SYM_NAME());
> +};
> +
> +static void test_longest_symbol_kallsyms(struct kunit *test)
> +{
> +	unsigned long (*kallsyms_lookup_name)(const char *name);
> +	static int (*longest_sym)(void);
> +
> +	struct kprobe kp = {
> +		.symbol_name = "kallsyms_lookup_name",
> +	};
> +
> +	if (register_kprobe(&kp) < 0) {
> +		pr_info("%s: kprobe not registered\n", __func__);
> +		KUNIT_FAIL(test, "test_longest_symbol kallsysms: kprobe not registered\n");
> +		return;
> +	}
> +
> +	kunit_warn(test, "test_longest_symbol kallsyms: kprobe registered\n");
> +	kallsyms_lookup_name = (unsigned long (*)(const char *name))kp.addr;
> +	unregister_kprobe(&kp);
> +
> +	longest_sym =
> +		(void *) kallsyms_lookup_name(__stringify(LONGEST_SYM_NAME));
> +	KUNIT_EXPECT_EQ(test, RETURN_LONGEST_SYM, longest_sym());
> +};
> +
> +static void test_longest_symbol_plus1(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test, RETURN_LONGEST_SYM_PLUS1, LONGEST_SYM_NAME_PLUS1());
> +};
> +
> +static void test_longest_symbol_plus1_kallsyms(struct kunit *test)
> +{
> +	unsigned long (*kallsyms_lookup_name)(const char *name);
> +	static int (*longest_sym_plus1)(void);
> +
> +	struct kprobe kp = {
> +		.symbol_name = "kallsyms_lookup_name",
> +	};
> +
> +	if (register_kprobe(&kp) < 0) {
> +		pr_info("%s: kprobe not registered\n", __func__);
> +		KUNIT_FAIL(test, "test_longest_symbol kallsysms: kprobe not registered\n");
> +		return;
> +	}
> +
> +	kunit_warn(test, "test_longest_symbol_plus1 kallsyms: kprobe registered\n");
> +	kallsyms_lookup_name = (unsigned long (*)(const char *name))kp.addr;
> +	unregister_kprobe(&kp);
> +
> +	longest_sym_plus1 =
> +		(void *) kallsyms_lookup_name(__stringify(LONGEST_SYM_NAME_PLUS1));
> +	KUNIT_EXPECT_NULL(test, longest_sym_plus1);
> +};
> +
> +static struct kunit_case longest_symbol_test_cases[] = {
> +	KUNIT_CASE(test_longest_symbol),
> +	KUNIT_CASE(test_longest_symbol_kallsyms),
> +	KUNIT_CASE(test_longest_symbol_plus1),
> +	KUNIT_CASE(test_longest_symbol_plus1_kallsyms),
> +	{}
> +};
> +
> +static struct kunit_suite longest_symbol_test_suite = {
> +	.name = "longest-symbol",
> +	.test_cases = longest_symbol_test_cases,
> +};
> +kunit_test_suite(longest_symbol_test_suite);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Test the longest symbol length");
> +MODULE_AUTHOR("Sergio González Collado");
> 
> base-commit: abf2050f51fdca0fd146388f83cddd95a57a008d

thanks,
-- Shuah

