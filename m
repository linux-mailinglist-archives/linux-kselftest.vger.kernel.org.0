Return-Path: <linux-kselftest+bounces-26054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A98E8A2D00C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 22:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C2716A208
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 21:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB261B4159;
	Fri,  7 Feb 2025 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xl2Calze"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4D41B3953
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 21:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738965242; cv=none; b=QkjMrSdV4ObNzcpUCJeHVJWMLXGynUQv3LQ7fTYRxfFtxDfOlJVP0UPOvS6CtvgxH5y1Lo5kASyewGkXzIpJMdIuycFV71PmZlQTFWpyi7uoau0FTSeMuoIVd0XYjJLpXJu2eBpe4doeazb5++577ttgLHtnTrOIv59bUKN+aOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738965242; c=relaxed/simple;
	bh=VeekEwj96xA0Hs59vDAXliI/sgxxJjxZsx/I7/fJZY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwywNUW0SNhqILJ+dqhwQ0yKCxvsTR7y99NArUqNSO3cGi/q2cFLnIHEbm6TFNNya1j1rWXMH+Y3LXJeT9/886iUZuMMEbAV76LE6FCp49VuqrdwhE/lWedpV08ZzyUHWZRWg3sliqF+dpW25GlkeYjomKhpWDfg447SsIEsIFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xl2Calze; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fa286ea7e8so1683861a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Feb 2025 13:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738965240; x=1739570040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8JPOvwUlSYA4FPC7cGEtXUo7l2ZSnPxDKa2YpPUTMU=;
        b=Xl2CalzeL6/f6n7YLnqbMGsLIL8pJaD+jlhO90+rJBDN8t4pE/i9WiOp+LOTm2JDyv
         i7i6RoTvUjMBHcxJ4k8SbdRrxw6sAqiOa+TL84gQ38v3MEVe7PmMiRtnOYqLAtvLcZjh
         YwCUmQ0/CFqjre/X1IJDWKs/DJqxsc9HNvfMfhxZ4ih+tzv+QyQ+udEy8kkANExAQt8L
         6ZpkyJLb8adrtROtZe5GtKPi1154eN7sFAIUXvk7OyINxkDT6aHRN8pMHdQDCsky9PPX
         yALcoJv8JmLFfot9AYH/SyWiXnBndKXgEglhOnkqMmhOeaLKjNaqRWlT1AtaSkx0F7C5
         B/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738965240; x=1739570040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8JPOvwUlSYA4FPC7cGEtXUo7l2ZSnPxDKa2YpPUTMU=;
        b=N+rw7SIdJ0ecu5t7FnWghWWYQ0gLb+7v7Ut7tPh2nwZ7w5LrPFGsx4cFrFcduz6GQ/
         NrfJBI85pfV2Cr2hIFTwWMq5TuoMRhLzgRhlACR6iEYOFCD2PwgtZUpstWwp/UddWG79
         8yCyfZWGJGFMpP0VW+v9SxLWb8r2vi2yHSk8nh+QKKEX4tcgSgTmn4kYXzqiMtGGelvX
         oN5dp7965jlToZCvttAZzshSKtI8y69YaFl4iLGrMwrha8q4/1VtyJPM8KHE9GoEy+43
         rJUSft6saNJBDmYptaCIZHIdP2mu6jFe6Hy3dVdq65f2sY039JFfGRLxYlTSIePCfBy8
         l7kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT0ZeQ0u0cc7YwTkbWz+XrzqMGfOSUVaNSJNo9Bei2vvrg+KWoYdhlvvhhge5/vxZBDu3ehtleXEw4GAgm+Hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB196YIilkfJMl8MMGU9sUzKk9A2WYQ/nt7P+W6MZexyurpuzd
	85Zz3oZolV1MeulVW2BD2EbCEKCHryLKgyI2mGpwVZGZE4ZYoRScrT2NyaAU9X33wt59n09/U6T
	Q1Hp49s7SO9DXlP0CJ4mPo6UfBzVNvsZUTyQJ
X-Gm-Gg: ASbGncvOr0+JQHyesFqga0M1BZS3tNErWBD+Aoe1/RMR7NiCZPlkzvChSj5+tPEjuVR
	wfPR0iwbZlpZArdA+hq5Ozg1/6k3UuxxSor7HOUPmNu81lRUpF7F8X9FGmTEx//qAPBzxQWQ+tK
	yJMT2GVIFVWCRB/4B5tUO69wV1Rg==
X-Google-Smtp-Source: AGHT+IEQ3N7LGa37pQ7nMqVFq50zy1Va8WdT7BIlXYAY8WGCw739VQbeOv3w5zOeAAO8ewJxD5xMGSWUwK6f9W60e2w=
X-Received: by 2002:a17:90a:ec85:b0:2f1:3355:4a8f with SMTP id
 98e67ed59e1d1-2fa23f423d9mr6772607a91.4.1738965239665; Fri, 07 Feb 2025
 13:53:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250202192412.340848-1-sergio.collado@gmail.com>
In-Reply-To: <20250202192412.340848-1-sergio.collado@gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Fri, 7 Feb 2025 16:53:47 -0500
X-Gm-Features: AWEUYZl7gVorsscNmDMsy6aoUiWPtEvqMb3L6OXPtWQGexYQPwOu3GivqRAJtAc
Message-ID: <CA+GJov6+TPSm6ns8+MrSytWF5qsS1cm=KFJrUivPtzc5QvgARQ@mail.gmail.com>
Subject: Re: [PATCH v8] Kunit to check the longest symbol length
To: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Cc: David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, David Rheinsberg <david@readahead.eu>, 
	rust-for-linux@vger.kernel.org, x86@kernel.org, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 2, 2025 at 2:24=E2=80=AFPM Sergio Gonz=C3=A1lez Collado
<sergio.collado@gmail.com> wrote:
>
> The longest length of a symbol (KSYM_NAME_LEN) was increased to 512
> in the reference [1]. This patch adds kunit test suite to check the longe=
st
> symbol length. These tests verify that the longest symbol length defined
> is supported.
>
> This test can also help other efforts for longer symbol length,
> like [2].
>
> The test suite defines one symbol with the longest possible length.
>
> The first test verify that functions with names of the created
> symbol, can be called or not.
>
> The second test, verify that the symbols are created (or
> not) in the kernel symbol table.
>
> [1] https://lore.kernel.org/lkml/20220802015052.10452-6-ojeda@kernel.org/
> [2] https://lore.kernel.org/lkml/20240605032120.3179157-1-song@kernel.org=
/
>
> Tested-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Rae Moar <rmoar@google.com>
> Signed-off-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/504

Hello!

Thanks for fixing the typo and this new version! This patch still does
not apply cleanly in the Makefile for me. Have you rebased it on the
kselftest/kunit branch? I also have a few more questions that I just
noticed.

Thanks!
-Rae

> ---
> V7 -> V8: typo fixed & rebased
> ---
> V6 -> V7: rebased
> ---
> V5 -> V6: remove tests with symbols of length KSYM_NAME_LEN+1
> ---
> V4 -> V5: fixed typo, added improved description
> ---
> V3 -> V4: add x86 mantainers, add new reference.
> ---
> V2 -> V3: updated base and added MODULE_DESCRIPTION() and MODULE_AUTHOR()
> ---
> V1 -> V2: corrected CI tests. Added fix proposed at [3]
>
> [3] https://lore.kernel.org/lkml/Y9ES4UKl%2F+DtvAVS@gmail.com/T/#m3ef0e12=
bb834d01ed1ebdcae12ef5f2add342077
>
> The test execution should result in something like:
> ```
> [20:04:35] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D longest-symbol (=
4 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [20:04:35] [PASSED] test_longest_symbol
> [20:04:35] [PASSED] test_longest_symbol_kallsyms
> [20:04:35] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] l=
ongest-symbol =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [20:04:35] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [20:04:35] Testing complete. Ran 4 tests: passed: 4
> ```
> ---
>  arch/x86/tools/insn_decoder_test.c |  3 +-
>  lib/Kconfig.debug                  |  9 ++++
>  lib/Makefile                       |  2 +
>  lib/longest_symbol_kunit.c         | 84 ++++++++++++++++++++++++++++++
>  4 files changed, 97 insertions(+), 1 deletion(-)
>  create mode 100644 lib/longest_symbol_kunit.c
>
> diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_dec=
oder_test.c
> index 472540aeabc2..6c2986d2ad11 100644
> --- a/arch/x86/tools/insn_decoder_test.c
> +++ b/arch/x86/tools/insn_decoder_test.c
> @@ -10,6 +10,7 @@
>  #include <assert.h>
>  #include <unistd.h>
>  #include <stdarg.h>
> +#include <linux/kallsyms.h>
>
>  #define unlikely(cond) (cond)
>
> @@ -106,7 +107,7 @@ static void parse_args(int argc, char **argv)
>         }
>  }
>
> -#define BUFSIZE 256
> +#define BUFSIZE (256 + KSYM_NAME_LEN)

I'm not too familiar with this test. I believe this would potentially
make a symbol with a length that exceeds the KSYM_NAME_LEN. What is
the intention for this line?

>
>  int main(int argc, char **argv)
>  {
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1af972a92d06..62d43aa9e8f0 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2838,6 +2838,15 @@ config FORTIFY_KUNIT_TEST
>           by the str*() and mem*() family of functions. For testing runti=
me
>           traps of FORTIFY_SOURCE, see LKDTM's "FORTIFY_*" tests.
>
> +config LONGEST_SYM_KUNIT_TEST
> +       tristate "Test the longest symbol possible" if !KUNIT_ALL_TESTS
> +       depends on KUNIT && KPROBES
> +       default KUNIT_ALL_TESTS
> +       help
> +         Tests the longest symbol possible
> +
> +         If unsure, say N.
> +
>  config HW_BREAKPOINT_KUNIT_TEST
>         bool "Test hw_breakpoint constraints accounting" if !KUNIT_ALL_TE=
STS
>         depends on HAVE_HW_BREAKPOINT
> diff --git a/lib/Makefile b/lib/Makefile
> index d5cfc7afbbb8..e8fec9defec2 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -393,6 +393,8 @@ obj-$(CONFIG_FORTIFY_KUNIT_TEST) +=3D fortify_kunit.o
>  obj-$(CONFIG_CRC_KUNIT_TEST) +=3D crc_kunit.o
>  obj-$(CONFIG_SIPHASH_KUNIT_TEST) +=3D siphash_kunit.o
>  obj-$(CONFIG_USERCOPY_KUNIT_TEST) +=3D usercopy_kunit.o
> +obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) +=3D longest_symbol_kunit.o
> +CFLAGS_longest_symbol_kunit.o +=3D $(call cc-disable-warning, missing-pr=
ototypes)
>
>  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) +=3D devmem_is_allowed.o

These are the lines that are causing the patch to not apply cleanly.
The change list that applies cleanly for me is:

 obj-$(CONFIG_FORTIFY_KUNIT_TEST) +=3D fortify_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) +=3D siphash_kunit.o
 obj-$(CONFIG_USERCOPY_KUNIT_TEST) +=3D usercopy_kunit.o
 obj-$(CONFIG_CRC16_KUNIT_TEST) +=3D crc16_kunit.o
+obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) +=3D longest_symbol_kunit.o
+CFLAGS_longest_symbol_kunit.o +=3D $(call cc-disable-warning, missing-prot=
otypes)

 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) +=3D devmem_is_allowed.o

>
> diff --git a/lib/longest_symbol_kunit.c b/lib/longest_symbol_kunit.c
> new file mode 100644
> index 000000000000..2a2dd1151097
> --- /dev/null
> +++ b/lib/longest_symbol_kunit.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test the longest symbol length. Execute with:
> + *  ./tools/testing/kunit/kunit.py run longest-symbol
> + *  --arch=3Dx86_64 --kconfig_add CONFIG_KPROBES=3Dy --kconfig_add CONFI=
G_MODULES=3Dy
> + *  --kconfig_add CONFIG_RETPOLINE=3Dn --kconfig_add CONFIG_CFI_CLANG=3D=
n
> + *  --kconfig_add CONFIG_MITIGATION_RETPOLINE=3Dn
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

I don't believe you use this macro. Could probably be deleted.

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

I don't think you use this anymore with the new changes. Can probably
be deleted.

> +
> +/*Generate a symbol whose name length is 511 */
> +#define LONGEST_SYM_NAME  DDDDDI(g1h2i3j4k5l6m7n)
> +
> +#define RETURN_LONGEST_SYM 0xAAAAA
> +
> +noinline int LONGEST_SYM_NAME(void);
> +noinline int LONGEST_SYM_NAME(void)
> +{
> +       return RETURN_LONGEST_SYM;
> +}
> +
> +_Static_assert(sizeof(__stringify(LONGEST_SYM_NAME)) =3D=3D KSYM_NAME_LE=
N,
> +"Incorrect symbol length found. Expected KSYM_NAME_LEN: "
> +__stringify(KSYM_NAME) ", but found: "
> +__stringify(sizeof(LONGEST_SYM_NAME)));

Should this error return __stringify(KSYM_NAME_LEN) instead of
__stringify(KSYM_NAME) to give the maximum length?

Also, I get an error because the length of LONGEST_SYM_NAME is 512.
The error is produced by this code:
https://elixir.bootlin.com/linux/v6.13.1/source/scripts/kallsyms.c#L152
and alerts if the symbol length is >=3D to KSYM_NAME_LEN. That is fine
as long as that is the intention of this test to produce a warning. Or
should this warning change to be "> KSYM_NAME_LEN" if usage of symbols
that are the maximum length is allowed?

> +
> +static void test_longest_symbol(struct kunit *test)
> +{
> +       KUNIT_EXPECT_EQ(test, RETURN_LONGEST_SYM, LONGEST_SYM_NAME());
> +};
> +
> +static void test_longest_symbol_kallsyms(struct kunit *test)
> +{
> +       unsigned long (*kallsyms_lookup_name)(const char *name);
> +       static int (*longest_sym)(void);
> +
> +       struct kprobe kp =3D {
> +               .symbol_name =3D "kallsyms_lookup_name",
> +       };
> +
> +       if (register_kprobe(&kp) < 0) {
> +               pr_info("%s: kprobe not registered\n", __func__);
> +               KUNIT_FAIL(test, "test_longest_symbol kallsyms: kprobe no=
t registered\n");
> +               return;
> +       }
> +
> +       kunit_warn(test, "test_longest_symbol kallsyms: kprobe registered=
\n");
> +       kallsyms_lookup_name =3D (unsigned long (*)(const char *name))kp.=
addr;
> +       unregister_kprobe(&kp);
> +
> +       longest_sym =3D
> +               (void *) kallsyms_lookup_name(__stringify(LONGEST_SYM_NAM=
E));
> +       KUNIT_EXPECT_EQ(test, RETURN_LONGEST_SYM, longest_sym());
> +};
> +
> +static struct kunit_case longest_symbol_test_cases[] =3D {
> +       KUNIT_CASE(test_longest_symbol),
> +       KUNIT_CASE(test_longest_symbol_kallsyms),
> +       {}
> +};
> +
> +static struct kunit_suite longest_symbol_test_suite =3D {
> +       .name =3D "longest-symbol",
> +       .test_cases =3D longest_symbol_test_cases,
> +};
> +kunit_test_suite(longest_symbol_test_suite);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Test the longest symbol length");
> +MODULE_AUTHOR("Sergio Gonz=C3=A1lez Collado");
>
> base-commit: a86bf2283d2c9769205407e2b54777c03d012939
> --
> 2.39.2
>

