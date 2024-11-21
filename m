Return-Path: <linux-kselftest+bounces-22427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CE69D54FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 22:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC460B23084
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 21:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125801D79A6;
	Thu, 21 Nov 2024 21:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oaj9FRSc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000AE1CB50D
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732225558; cv=none; b=aQYd64dNforp9oPszvJXMhGO6IzGinwg8yebnM1QJmSbm3xSBWK0vqcmgainFgBB9XJ910aucWBfcmaUy2/tT4jUky1eEe2skdwPdQP1F5Ryqsu3VnUGvKOHRD5r0PLjmqz7O+BDiXz0Fa0fx+X2PX30GxbaX4B5ZVS6rGbvhrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732225558; c=relaxed/simple;
	bh=JENSaX7lT8JwqZ8seiloLZvg9LwcSqfEWqLr5zZP490=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cP7d4ccUsAPVPA61LLWKM8pMSnes3nuTuMD0b5kzKdEdunjRXqQDXeQhT6KyZ7AW31e54vPA0mmPjJYKAPckhMc/GfAT8o8D9AmCDzb6vQEx3zPXCVtsEMMI8AJWWGvU7J988engUyuXaLIx0gnwWJX2FAIpojbSr+5xZr92kZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oaj9FRSc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-724d57a9f7cso926639b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 13:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732225555; x=1732830355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4a8oWPSly7lypmnYWn7HyCF8FEhlYXGucolUoN3Di8=;
        b=Oaj9FRScefgPlf+2AykXqs/k9sE5uxLWTA/KbZPuKomUlmFKenaRJVTa+zK3DB8dU6
         BK7yUHBAfE4iRC5Xe87Ub/XI1K5CImGktYthCL0oKoJAauGdqZrF7sfJnU3sUIVU0b85
         s9imXpn0Kppoo77+qqmViJHCOEoi0sYq7sk0euJ8l/Oi7Kh9n0WoAtMwgq0dNI1IBAQJ
         2yXEwlQrWoVSULj/HsZVNdvcNz9kTDZn3fk9LLD9SH7L7gD7gGSfLX6sfaSFETujJ4ou
         yh44tSgQkKm/CTSXxdmH4uLCYAov/R4WA+24hlKmmGcURFovhpAvLXJy1EbU6EZbGvpp
         zBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732225555; x=1732830355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4a8oWPSly7lypmnYWn7HyCF8FEhlYXGucolUoN3Di8=;
        b=d0zmaYZiyVdZQ5h7FDnJwkd+CPvR1TPvdBVKc1L1haBG0EyqsWL8q/d/3mQPyMpRMH
         m2hyTfzSP2GG8WrenvZaz4aKbQruDejrZ6ERsMPJEkZKCmhtOqCEt/FB3SIHhMAEIi/h
         Pn6mzvWjQ5cAMqHiAd/cjxYtr0tSbDACUW/zGpDBGLMkaCG+usTQ9ljbBsAa9lSJMHl2
         b6WcUngSXDe+c52nhFhXnKAaz5+/fldFUcsTSu36E1vrnEFJlll6g4TtssZ7WB25GopE
         M2JCgrfHvLod0MHQnHPJkRvU+B7TdlkHRPMO8mxSN3eJcjqkEvn457zWaYrpQDiPn1Tv
         Zy6A==
X-Forwarded-Encrypted: i=1; AJvYcCXYZdu9bAcUuOo2e+8DNkivtD3GN1vo5SbFL9Bz3ADqLRSTd7k1j05Ne3wsVZzp38+u8jU61TV+8r5ikH3dZks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaFuw4AOFEmesiWEIAl1kE/LNYWxDy1H6LPRK11IUvwebhHOwY
	nPwmZFAPw4EaLoURbvyeuJXDPumUDPjE7ziuuyqJXQTXTiwjgWng434d383YDmocBreSETYUfld
	H6aD3KV4cr5eU3SveqCLm01LMj7NViLU2lEkD
X-Gm-Gg: ASbGncstBSWtqs+bVgPg3HUpXSQ9rjnmWHxyhzynjcJoTV2RY6Bl6qqynSO9rcs+yEv
	peNKSqNI3L3Hv0wc6N9FhG7ZAYf6xw1DK
X-Google-Smtp-Source: AGHT+IFj3ewzHS7CHSwnlpSbvZE0LyO+Qo7rO/sZNb0D2NaUQuJLy6NLIzQ400cfoImivcwpiS5/Vd/gS8PpEgCzqsE=
X-Received: by 2002:a05:6a00:13a8:b0:71e:1b6d:5a94 with SMTP id
 d2e1a72fcca58-724df3c81f9mr800143b3a.5.1732225554847; Thu, 21 Nov 2024
 13:45:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117195923.222145-1-sergio.collado@gmail.com>
In-Reply-To: <20241117195923.222145-1-sergio.collado@gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Thu, 21 Nov 2024 16:45:42 -0500
Message-ID: <CA+GJov6Ks6tLCeZLs2_8yPEgGgNs1FfPM=xTNbmmQND=U+z8rA@mail.gmail.com>
Subject: Re: [PATCH v5] Kunit to check the longest symbol length
To: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Dave Hansen <dave.hansen@linuax.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, David Rheinsberg <david@readahead.eu>, 
	rust-for-linux@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org, 
	ricardo.marliere@suse.com, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 17, 2024 at 2:59=E2=80=AFPM Sergio Gonz=C3=A1lez Collado
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
> The test suite defines two symbols, one with the longest length defined,
> and other one whit the longest length defined +1. In the test suite
> there are four tests, three positive and one negative.
>
> The first and third tests, verify that functions with names of the create=
d
> symbols, can be called or not.
>
> The second and fourth tests, verify that the symbols are created (or
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

Hello!

This patch is passing tests when it is built-in but it is failing when
I run it as a module.

Here is the result when run as a module with "modprobe longest_symbol_kunit=
":

[   30.446570] KTAP version 1
[   30.446826] 1..1
[   30.453560]     KTAP version 1
[   30.453785]     # Subtest: longest-symbol
[   30.454376]     # module: longest_symbol_kunit
[   30.457622]     1..4
[   30.463765]     ok 1 test_longest_symbol
[   30.471805]     # test_longest_symbol_kallsyms: test_longest_symbol
kallsyms: kprobe registered
[   30.478995]     ok 2 test_longest_symbol_kallsyms
[   30.479735]     ok 3 test_longest_symbol_plus1
[   30.596269]     # test_longest_symbol_plus1_kallsyms:
test_longest_symbol_plus1 kallsyms: kprobe registered
[   30.602564]     # test_longest_symbol_plus1_kallsyms: EXPECTATION
FAILED at lib/longest_symbol_kunit.c:106
[   30.602564]     Expected longest_sym_plus1 =3D=3D ((void *)0), but
[   30.602564]         longest_sym_plus1 =3D=3D ffffffffc01313e0
[   30.602564]         ((void *)0) =3D=3D 0000000000000000
[   30.603924]     not ok 4 test_longest_symbol_plus1_kallsyms
[   30.606305] # longest-symbol: pass:3 fail:1 skip:0 total:4
[   30.606669] # Totals: pass:3 fail:1 skip:0 total:4
[   30.608618] not ok 1 longest-symbol

Seems the symbol name is found when run as modules?

Thanks!
-Rae

> ---
> V1 -> V2: corrected CI tests. Added fix proposed at [3]
>
> [3] https://lore.kernel.org/lkml/Y9ES4UKl%2F+DtvAVS@gmail.com/T/#m3ef0e12=
bb834d01ed1ebdcae12ef5f2add342077
> ---
> V2 -> V3: updated base and added MODULE_DESCRIPTION() and MODULE_AUTHOR()
> ---
> V3 -> V4: add x86 mantainers, add new reference.
> ---
> V4 -> V5: fixed typo, added improved description
>
> The test execution shoud result in something like:
>
> ```
> [20:04:35] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D longest-symbol (=
4 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [20:04:35] [PASSED] test_longest_symbol
> [20:04:35] [PASSED] test_longest_symbol_kallsyms
> [20:04:35] [PASSED] test_longest_symbol_plus1
> [20:04:35] [PASSED] test_longest_symbol_plus1_kallsyms
> [20:04:35] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] l=
ongest-symbol =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [20:04:35] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [20:04:35] Testing complete. Ran 4 tests: passed: 4
> ```
>
> But also there are two warnings like:
>
> ```
> Symbol snnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7n=
nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnnng1h2i3j4k=
5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3=
j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nn=
g1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6=
m7ng1h2i3j4k5l6m7nnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4=
k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7ne too=
 long for kallsyms (512 >=3D 512).
> Please increase KSYM_NAME_LEN both in kernel and kallsyms.c
> ```
>
> Because the tests try to generate simbols of the same length as
> KSYM_NAME_LEN. This is the expected outcome, as defined:
> https://lore.kernel.org/all/20131023130753.GO29695@two.firstfloor.org/
>
> ---
>  arch/x86/tools/insn_decoder_test.c |   3 +-
>  lib/Kconfig.debug                  |   9 +++
>  lib/Makefile                       |   2 +
>  lib/longest_symbol_kunit.c         | 125 +++++++++++++++++++++++++++++
>  4 files changed, 138 insertions(+), 1 deletion(-)
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
> index 7312ae7c3cc5..1f3059176637 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2820,6 +2820,15 @@ config FORTIFY_KUNIT_TEST
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
> index 773adf88af41..fc878e716825 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -389,6 +389,8 @@ CFLAGS_fortify_kunit.o +=3D $(DISABLE_STRUCTLEAK_PLUG=
IN)
>  obj-$(CONFIG_FORTIFY_KUNIT_TEST) +=3D fortify_kunit.o
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
> index 000000000000..ebd26eedbf7b
> --- /dev/null
> +++ b/lib/longest_symbol_kunit.c
> @@ -0,0 +1,125 @@
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
> +/*Generate a symbol whose name length is 512 */
> +#define LONGEST_SYM_NAME_PLUS1 PLUS1(LONGEST_SYM_NAME)
> +
> +#define RETURN_LONGEST_SYM 0xAAAAA
> +#define RETURN_LONGEST_SYM_PLUS1 0x55555
> +
> +noinline int LONGEST_SYM_NAME(void);
> +noinline int LONGEST_SYM_NAME(void)
> +{
> +       return RETURN_LONGEST_SYM;
> +}
> +
> +noinline int LONGEST_SYM_NAME_PLUS1(void);
> +noinline int LONGEST_SYM_NAME_PLUS1(void)
> +{
> +       return RETURN_LONGEST_SYM_PLUS1;
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
> +static void test_longest_symbol_plus1(struct kunit *test)
> +{
> +       KUNIT_EXPECT_EQ(test, RETURN_LONGEST_SYM_PLUS1, LONGEST_SYM_NAME_=
PLUS1());
> +};
> +
> +static void test_longest_symbol_plus1_kallsyms(struct kunit *test)
> +{
> +       unsigned long (*kallsyms_lookup_name)(const char *name);
> +       static int (*longest_sym_plus1)(void);
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
> +       kunit_warn(test, "test_longest_symbol_plus1 kallsyms: kprobe regi=
stered\n");
> +       kallsyms_lookup_name =3D (unsigned long (*)(const char *name))kp.=
addr;
> +       unregister_kprobe(&kp);
> +
> +       longest_sym_plus1 =3D
> +               (void *) kallsyms_lookup_name(__stringify(LONGEST_SYM_NAM=
E_PLUS1));
> +       KUNIT_EXPECT_NULL(test, longest_sym_plus1);
> +};
> +
> +static struct kunit_case longest_symbol_test_cases[] =3D {
> +       KUNIT_CASE(test_longest_symbol),
> +       KUNIT_CASE(test_longest_symbol_kallsyms),
> +       KUNIT_CASE(test_longest_symbol_plus1),
> +       KUNIT_CASE(test_longest_symbol_plus1_kallsyms),
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
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/kunit-dev=
/20241117195923.222145-1-sergio.collado%40gmail.com.

