Return-Path: <linux-kselftest+bounces-28360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5802A53E4B
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 00:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E44A43A87CD
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 23:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103511EE03B;
	Wed,  5 Mar 2025 23:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dtlnrTdb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EDB1A5BB2
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216687; cv=none; b=m7vAh77Rs03NZa5tMj9ZIdpDAQnGTL8L2o+VdsImmIHRil6zvFqXVaeNlQX9mV607mFkgkYciEHOmQwcDh/DlLGu4MWD2HiGWUz1p+oh3FnlVCS1dtmngpQJ3F9q+134Bsp4N9h3Oowt+mx9CkDw+in06bjiu0Dp7oMaBeZwAzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216687; c=relaxed/simple;
	bh=RjrOEY5xBWbb9vIZTQoHjd0JCvfKWp1YPIBIRXBCIyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/Y+jkf7tSIn7jBAQPFvxlo4p6WnTbYE1jAikhncJCxBni8q3W0TSXYbF4NlrU8CXh9/SSorCAjMBVJkqAH1kvvQJe3sOCjWXBc8BfsY5zLevgsdh9heNNZpjwTal0onYjp6F7SzrJ9bpHrZ0/8N8ij5bw1aS3ykYZtnSX4hzlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dtlnrTdb; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e895f3365aso794336d6.0
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Mar 2025 15:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741216684; x=1741821484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGW8NA+qaOK/6mvNEBoQiCzB2M+/FGL5kz9mP/r6zrk=;
        b=dtlnrTdbZUGA1r33noXoM1lOKN7r1LXU07jOET6LMt0rreciLuG983WLg9HUZl9ReO
         au9WyPRYrc+fbEEPQirpIkd0Q67jmeR/jpkf/0nchwyucxDrMHohV9AcGqAuq0sFWvWx
         zTwnTIMukjKFQDILUF/W+j1H4UG6rIyJbuTR6Hb8sjEckeSs/4EvTC2Rw2DnvkWhJNG9
         AslgaQZp+21v1tr56gRXH/2ZANcrrFwapfp9N5TnYd/B44QgP4JGcvEZnQ5G6z7BZfvY
         XYRXim+kOyXm0bn23XpwM/J+AZ+H3iZ4XKvmNHl9TLRko1V7nIrThbfxu46P97+NFQeV
         QOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741216684; x=1741821484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGW8NA+qaOK/6mvNEBoQiCzB2M+/FGL5kz9mP/r6zrk=;
        b=TK3UwtyhkzNkHmHW8nDKZwgA4t7rWWRCfHU0xQVaj0bhDNY2DBsj/UUM95JapT1VvH
         9B6ffe/juZpiauWjDj1OTQ6WoVUL2xAH3ExHix1OW/OD82lE6h7lRoHyQ/7rMl2fjXFd
         c11RQpxpVzkkja2nbBtKPEQw3Ax93WOFAjWgEJJiVEBG4PeorETL7/t1xD4tL71iFuKO
         bvx4dS7GIqPdUvK3loKmptn0XTiF1Ceb/UXIxmgAhT1H1+W9YIstd/LzqjSqjlzuHR4z
         Th7gJhDtfue6EE4Gi9XhqdhLPosdrAVCeNb/DKl1ymDpoa0T8fAcIN38IOgiFHa2uvji
         lMjw==
X-Forwarded-Encrypted: i=1; AJvYcCV90YUeITOBFDWNsDr42E1cF5W+0tFx4uYA+PnFq5SUZroMoP4gtFn8uu8oZvkNs/x1QvFwXWUtxz04HwwjeYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1refZuw4wYgKu1lVSwTmvsRAOvqSpYZclWHFHgha5806t0zoU
	nQc/yuM8NxmDeVvoXnk3XwB6JfS2KEY7i1Q6iNftlOQn30Q1fFYeW2DJm0xxaHo9OIkOWpbuTl1
	MDPQa5qH1+fhX4qOOFZOvOhQbOdkphm/g0lty
X-Gm-Gg: ASbGncvAZUtBkd4mzX+QZ/kxiXAcYyFXOUyXYLzC4V/8B/qgJRSUAToADAcBJvZ6EJk
	4vvRTP3EuoIYznSZ72KD22bvgh+4ToM39jMC9/+TJXoxRJGOgKeNyufnRqv0GBruC6iU3AwqZbe
	QFsIR0MMbUDzWWrrW2jsu67hicFU2tw/AqHiZbSss1hRip29u5LBFhAZ9jK+HT
X-Google-Smtp-Source: AGHT+IHHySWEtVSXkSbDQpUQIThvZ1hpg7GnLI3hT91ZYcvIqyHEqJLgOkDfCVdyHJwcshahAuA0hzH1Q1gaU1DbZII=
X-Received: by 2002:a05:6214:258b:b0:6e4:4331:aae0 with SMTP id
 6a1803df08f44-6e8e6cffdb6mr64730556d6.1.1741216683832; Wed, 05 Mar 2025
 15:18:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302221518.76874-1-sergio.collado@gmail.com>
In-Reply-To: <20250302221518.76874-1-sergio.collado@gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Wed, 5 Mar 2025 18:17:52 -0500
X-Gm-Features: AQ5f1Jopmd_6Jpyt6OPDyNi0XtCysbyV65mh0GDzFLW3gDMrF-hBQmtmZu7FtS4
Message-ID: <CA+GJov65LdxqZTk_Dm252BJOBSAY2dEmdRAxtTgRei4UDxV0hA@mail.gmail.com>
Subject: Re: [PATCH v9] Kunit to check the longest symbol length
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

On Sun, Mar 2, 2025 at 5:15=E2=80=AFPM Sergio Gonz=C3=A1lez Collado
<sergio.collado@gmail.com> wrote:
>
> The longest length of a symbol (KSYM_NAME_LEN) was increased to 512
> in the reference [1]. This patch adds kunit test suite to check the longe=
st
> symbol length. These tests verify that the longest symbol length defined
> is supported.
>

Hello!

Thanks for all the updates! This is now applying cleanly for me and it
looks good to me.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

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
> ---
> V8 -> V9: removed unused macro & corrected error message
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
>  lib/longest_symbol_kunit.c         | 82 ++++++++++++++++++++++++++++++
>  4 files changed, 95 insertions(+), 1 deletion(-)
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
>
> diff --git a/lib/longest_symbol_kunit.c b/lib/longest_symbol_kunit.c
> new file mode 100644
> index 000000000000..e3c28ff1807f
> --- /dev/null
> +++ b/lib/longest_symbol_kunit.c
> @@ -0,0 +1,82 @@
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
> +__stringify(KSYM_NAME_LEN) ", but found: "
> +__stringify(sizeof(LONGEST_SYM_NAME)));
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
> +               pr_info("%s: kprobe not registered", __func__);
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
> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
> --
> 2.39.2
>

