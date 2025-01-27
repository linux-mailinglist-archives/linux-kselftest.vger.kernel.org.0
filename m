Return-Path: <linux-kselftest+bounces-25249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D51A1DDB2
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 22:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5312A3A47A0
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 21:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3C219340D;
	Mon, 27 Jan 2025 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ClREr+li"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136C9191F6D
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2025 21:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738011856; cv=none; b=kScivM0Z7vZLfp/wU5a/z+AQXWRS+B2Mmz/e1YqWCtauHGGE0bVYrbZ8nC8IVcHJjfPKoU6R3nyj9/NDjB2zbnK7Aksly9lycsTP3wgEyMXwrT9iOKPWPbnyDEf3DNdPZBDG6XP1+VS/b7Wa698a1quxIOm/StV1QRSmljKt5tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738011856; c=relaxed/simple;
	bh=H8ovIADPahKqgnV5YG3t9GMBtpkHPdMi9fqxZwfnBJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ryZyQaUrQkkrUrreHRTY8JkIJEvEZHecKwqE319FPTIODwLmfps2aYAzmuDBp6ASjY7O+TthAG4umVTUVkD2/a7y+Rrwno2uoz2UeYAslEhW8k2z5Ig7AQTSMC/b//ZQEC8zLH6n21OmYeTqFMsdmP/qFkWHqIRgx72kdqZCBKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ClREr+li; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so6552120a91.3
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2025 13:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738011854; x=1738616654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoOTWso6vnNQEol50KDl9uyVE5wdPyErjCcG9xU2LF4=;
        b=ClREr+liDBR8x1HDC7z2kNaznKzU9u4pKVylNNk0rP4PV8O01SaSx5VOuiFdWR/utq
         0Q8tNdGs43jpuKnMJvGPl9TUBSGV3kWV6dI1zgJzAdq4BV6aI+fJBylbq69o1flihHd2
         Sju9+pHw+zT3OGhdUvzOKrF+pYGOlFY1OikCvKOOzLVJ7En4Z8tttK/lfiMh8YJzSYf7
         TxnuiQ7CSPUS6qEjMEqBiZJXabLhc0wgSM6KhVF0/9j/mo1lwfIT/uOjYGSwVclwoDyc
         68RfH7eirphgEJ0HYpNfauR1zBS/pxmxa3AHif2bMPAwYDrS+Aiulh/1cseumv9zSx5B
         s0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738011854; x=1738616654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoOTWso6vnNQEol50KDl9uyVE5wdPyErjCcG9xU2LF4=;
        b=nfsKhAh23yg/FPnGryEtbrM+T5gsq79JZG2wEfyPSc8HRd88ejVJsqs4sEhAOeIB4H
         K/zzUfciSwarC3qYbtnaWLtBNkuJyLXe6kevIHAxAd3C1BguQwY3NqECx7pHXP5f2q09
         xA4utD1Kw0mBxrHPDIl7smTJLsk3OdOliEla2CY1Xp93S42fdeowjd+DUWpHbnFwnsLO
         2USO+2sELvYeFrw0Xz/F+RF9MGNiA133gt84e88cSAeAtd5gr0s2eA8QWpmmEo/4mCE8
         FVm71sQ04sWVlUPbalO2UFeuTM/3Z3BU+3X87KZbz36KhBPiAG6mdudMp1aZgJ7ZXiBh
         apeA==
X-Forwarded-Encrypted: i=1; AJvYcCV4KRLxozvWQFICyl7vIPHtaXziCgBAm8fpbNOeFa/SuoXpDfg9dsGHhBIxLdLAVvd2kf4tNTpprwdGA7kqHUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvif+mMfSRxd+LSy8ldS+I2hEaxSluc55FXIEuachHRu/zuZJm
	E+HHroGPJ4qkf+jgZuSTnKrZJ7xHSaIhMg21I6I7ZZYHB/Eql163WVLzbEX5Do0C3uceoLDJ3Ee
	lTwT/CSRz1eUrt3S65a35FW3l4qhsmIZ/6LjQ0crbIdKZqB/9lA==
X-Gm-Gg: ASbGncu4jLTbJc4//yqrAumzM/sH1yhtOxWwq+5Jqo4dXL5Hv3eSFMbvAaivBO9X6Fa
	ypF3aPRYctuSv+Jf7sr/IbTUPxEt4aYKwC6cka9BH6RohAGNU3b409r8+7Simpmk=
X-Google-Smtp-Source: AGHT+IGVFaDi1w4/uXw6mL2aohymTRupuUKtmzFeR4AJY1Mx1Jc4FNIVtJe8Dq04yro6ezW1gGtBKQecl6FmVe4mvFs=
X-Received: by 2002:a17:90a:c883:b0:2ee:b2be:f390 with SMTP id
 98e67ed59e1d1-2f782d37d55mr60563476a91.28.1738011854064; Mon, 27 Jan 2025
 13:04:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250126223627.732451-1-sergio.collado@gmail.com>
In-Reply-To: <20250126223627.732451-1-sergio.collado@gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Mon, 27 Jan 2025 16:04:00 -0500
X-Gm-Features: AWEUYZlB-AVGnm8s5uG4dd5xgHmfQAhUlYMLgMHhMo3OQ7iExowHpgRWq1AF44c
Message-ID: <CA+GJov7u+VwaVLLVwHWvRkqDrVgSPLEtkG-AjHDvXnSgdnRDWw@mail.gmail.com>
Subject: Re: [PATCH v6] Kunit to check the longest symbol length
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

On Sun, Jan 26, 2025 at 5:36=E2=80=AFPM Sergio Gonz=C3=A1lez Collado
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
> Signed-off-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/504

Hi Sergio!

Thanks for sending another version of this test. This now looks good
to me! The test passes both built-in to the kernel and loaded as a
module.

Happy to take this patch though the kselftest/kunit branch. However
this patch does not cleanly apply to that branch right now. There are
just a few lines in lib/Makefile that differ. It would be an easy fix
of rebasing the patch and sending out a new version. Or would you
prefer sending it through another branch? Let me know.

But other than the need to rebase, this patch looks good to me:

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

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
> index 472540aeabc2..3bde35ea4188 100644
> --- a/arch/x86/tools/insn_decoder_test.c
> +++ b/arch/x86/tools/insn_decoder_test.c
> @@ -10,6 +10,7 @@
>  #include <assert.h>
>  #include <unistd.h>
>  #include <stdarg.h>
> +#include <linux/kallsysms.h>
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
> index 5f1874622175..4c3a61862281 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2828,6 +2828,15 @@ config FORTIFY_KUNIT_TEST
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
> index 000000000000..38ae117647e4
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
> +               KUNIT_FAIL(test, "test_longest_symbol kallsysms: kprobe n=
ot registered\n");
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
> --
> 2.39.2
>

