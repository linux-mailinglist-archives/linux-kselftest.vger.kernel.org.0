Return-Path: <linux-kselftest+bounces-22434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004F09D5A1C
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 08:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4731F23760
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 07:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFB6176AA1;
	Fri, 22 Nov 2024 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtoM/7GW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5971632E5;
	Fri, 22 Nov 2024 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261122; cv=none; b=oUPWoogrcV4Y6QcbBzY36XQwlob8IhlnMJ65iBpN6pGuSF7MZ2F3AAl4x1U7crTpDS/Wr2cx2anEbBetMTTiP0uj6ZYEuYnPe/zHbAXQghrpVmfc4MXjxWyONe4dtaudW+nbRG1daQQt7sZUVAm94cBHBt284njtZCORb7mQcI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261122; c=relaxed/simple;
	bh=ZWlW9aSFCfbZUzdU1sdafCr7ATCoUXWbUOFp3ZzaKBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKPst27aq8RCXBgFxIJ8KsaAlHAUBNSrXvnw/CDsm8oDJcY7Ho1gc/yc6nHMt1zjDLD/AoOIlLjneYPydJX00ByCUmP5c22D5hmaFpFa4nI4JNIFfdZ6Ax13skUrGdZo6YFhkcYAYmfhnmV2FU26qlfTfw5sPYw8adrrI/prsRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtoM/7GW; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ff550d37a6so21526321fa.0;
        Thu, 21 Nov 2024 23:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732261119; x=1732865919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7r3p/5Ql6yojNUi6PG4Q3ZK6FhlGHHmC5gH4VSwnLQA=;
        b=VtoM/7GWO+ovT6tbWMlsWk9RHL2YygQ6S07xiTIPKJQprjp9Hlu7YpWIg0Cd0ycHT/
         LFMTQWgamWUoIY7ZgcAiIVuDzjTYHk2Scp+qhku5vAFEF8WBJombLiRu8YopdQ9WT2pO
         lVfxLn3wCMolfu/UqjVNoOdQh15m/IjvRaO+Aiv/RUExLkPkMvQoQdsVQS/+qZcnnm05
         rdKM6Ga2iSh6FdFT578JSWpt9NDRSo/7Yvl9uShZEVA91jMZoYN+c82OWSvdYR4jkDJ4
         2B9clCOwHKl4k1FQfBHS9NNfCAHIChuxHNB2iuE64fP39ESUbXhjD+WPW3ZUXdnYOTob
         WVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732261119; x=1732865919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7r3p/5Ql6yojNUi6PG4Q3ZK6FhlGHHmC5gH4VSwnLQA=;
        b=rELgaacV8JHI4+mPQAHYyUnGN8+r3Acg4QB4au0UueTnRd+qg6HVV1Tt/HHm0BP/K+
         ScL5qkLEi80gwBPLfGu2Y7S8hMMEDpQxVhYnf3XvVOpLIGSsP0b7/K1i5jomzdwxIiZr
         RrnUni9DAmDITWoVnydq2yC0yyS8xPKuPTYSqBiV/cA39VeKvN/FCAOdM4g5MYg21J+7
         sA99YvO/bKprjdi2A2EFK5IDbU8VZL39XtKCliwEC3CKsJ/geVxjW2kLkPBwQjyxPp9z
         T2rf/RUPzmpLrERx3U5LSW2+t2dqeZNdQa57so8yqqE3v4KW9qYxI0BKPWcL//Wh6/1W
         KWRw==
X-Forwarded-Encrypted: i=1; AJvYcCWmSuAVMLLoAIx2VFZgYuNHblOGuIG6LoK5yeRh6be4rKgGfsQgxykm1hFr5Jzk5cmYYSpgRj6pgG5bqkVqve8=@vger.kernel.org, AJvYcCXA/vzgUG0MeCmv3g6fBSveoYUWZFBBcztDzCsK8UL3u1L90G7MRjSbi3cTqO6urp/uy/f0FdHymwnz9zNLK7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6+I7kBUj/5N8plqF+JBk1Rxo90nh5t36z4zLfxx0n/kw+oeTw
	cmF3lAK3kvCMVBaxvtMiYtyamxTGx1K3/vc1jwKvbmrBG8SoTGvwi9LE82sXsHolryohrf6IOAr
	dfFCfAclBIkNdfbS0ijVHi0uB3DA=
X-Gm-Gg: ASbGncuYMhdnGHUpT/IWpWPdh5n0GjlP+98fok4hHRtbGZgDLS/bZ17wF/kAp0wgvhb
	CcXo0j6djwuocHpNTLhEPexda8ynLBc8=
X-Google-Smtp-Source: AGHT+IHOU4Kp1ealVEt/B9S1i9AFfGiiXaqu+E7VcxGqmVLcSEZQE9kKvcWRA/JghnwWZ88Dz8VNLpr9yTA9m9YGflo=
X-Received: by 2002:a05:651c:889:b0:2fb:4b40:1e18 with SMTP id
 38308e7fff4ca-2ffa716d35amr7504991fa.13.1732261118352; Thu, 21 Nov 2024
 23:38:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117195923.222145-1-sergio.collado@gmail.com> <CA+GJov6Ks6tLCeZLs2_8yPEgGgNs1FfPM=xTNbmmQND=U+z8rA@mail.gmail.com>
In-Reply-To: <CA+GJov6Ks6tLCeZLs2_8yPEgGgNs1FfPM=xTNbmmQND=U+z8rA@mail.gmail.com>
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Fri, 22 Nov 2024 08:38:00 +0100
Message-ID: <CAA76j91gK2J6jO-qys=NbahC5v3Omuzed-gXBkeK00ObnR26Pw@mail.gmail.com>
Subject: Re: [PATCH v5] Kunit to check the longest symbol length
To: Rae Moar <rmoar@google.com>
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

Very interesting that behaviour. I will inspect what is happening there.
Thanks for pointing that out.

On Thu, 21 Nov 2024 at 22:45, Rae Moar <rmoar@google.com> wrote:
>
> On Sun, Nov 17, 2024 at 2:59=E2=80=AFPM Sergio Gonz=C3=A1lez Collado
> <sergio.collado@gmail.com> wrote:
> >
> > The longest length of a symbol (KSYM_NAME_LEN) was increased to 512
> > in the reference [1]. This patch adds kunit test suite to check the lon=
gest
> > symbol length. These tests verify that the longest symbol length define=
d
> > is supported.
> >
> > This test can also help other efforts for longer symbol length,
> > like [2].
> >
> > The test suite defines two symbols, one with the longest length defined=
,
> > and other one whit the longest length defined +1. In the test suite
> > there are four tests, three positive and one negative.
> >
> > The first and third tests, verify that functions with names of the crea=
ted
> > symbols, can be called or not.
> >
> > The second and fourth tests, verify that the symbols are created (or
> > not) in the kernel symbol table.
> >
> > [1] https://lore.kernel.org/lkml/20220802015052.10452-6-ojeda@kernel.or=
g/
> > [2] https://lore.kernel.org/lkml/20240605032120.3179157-1-song@kernel.o=
rg/
> >
> > Tested-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> > Signed-off-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>
> > Link: https://github.com/Rust-for-Linux/linux/issues/504
>
> Hello!
>
> This patch is passing tests when it is built-in but it is failing when
> I run it as a module.
>
> Here is the result when run as a module with "modprobe longest_symbol_kun=
it":
>
> [   30.446570] KTAP version 1
> [   30.446826] 1..1
> [   30.453560]     KTAP version 1
> [   30.453785]     # Subtest: longest-symbol
> [   30.454376]     # module: longest_symbol_kunit
> [   30.457622]     1..4
> [   30.463765]     ok 1 test_longest_symbol
> [   30.471805]     # test_longest_symbol_kallsyms: test_longest_symbol
> kallsyms: kprobe registered
> [   30.478995]     ok 2 test_longest_symbol_kallsyms
> [   30.479735]     ok 3 test_longest_symbol_plus1
> [   30.596269]     # test_longest_symbol_plus1_kallsyms:
> test_longest_symbol_plus1 kallsyms: kprobe registered
> [   30.602564]     # test_longest_symbol_plus1_kallsyms: EXPECTATION
> FAILED at lib/longest_symbol_kunit.c:106
> [   30.602564]     Expected longest_sym_plus1 =3D=3D ((void *)0), but
> [   30.602564]         longest_sym_plus1 =3D=3D ffffffffc01313e0
> [   30.602564]         ((void *)0) =3D=3D 0000000000000000
> [   30.603924]     not ok 4 test_longest_symbol_plus1_kallsyms
> [   30.606305] # longest-symbol: pass:3 fail:1 skip:0 total:4
> [   30.606669] # Totals: pass:3 fail:1 skip:0 total:4
> [   30.608618] not ok 1 longest-symbol
>
> Seems the symbol name is found when run as modules?
>
> Thanks!
> -Rae
>
> > ---
> > V1 -> V2: corrected CI tests. Added fix proposed at [3]
> >
> > [3] https://lore.kernel.org/lkml/Y9ES4UKl%2F+DtvAVS@gmail.com/T/#m3ef0e=
12bb834d01ed1ebdcae12ef5f2add342077
> > ---
> > V2 -> V3: updated base and added MODULE_DESCRIPTION() and MODULE_AUTHOR=
()
> > ---
> > V3 -> V4: add x86 mantainers, add new reference.
> > ---
> > V4 -> V5: fixed typo, added improved description
> >
> > The test execution shoud result in something like:
> >
> > ```
> > [20:04:35] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D longest-symbol=
 (4 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [20:04:35] [PASSED] test_longest_symbol
> > [20:04:35] [PASSED] test_longest_symbol_kallsyms
> > [20:04:35] [PASSED] test_longest_symbol_plus1
> > [20:04:35] [PASSED] test_longest_symbol_plus1_kallsyms
> > [20:04:35] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED]=
 longest-symbol =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [20:04:35] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [20:04:35] Testing complete. Ran 4 tests: passed: 4
> > ```
> >
> > But also there are two warnings like:
> >
> > ```
> > Symbol snnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m=
7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnnng1h2i3j=
4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2=
i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7=
nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5=
l6m7ng1h2i3j4k5l6m7nnnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3=
j4k5l6m7nnng1h2i3j4k5l6m7ng1h2i3j4k5l6m7nng1h2i3j4k5l6m7ng1h2i3j4k5l6m7ne t=
oo long for kallsyms (512 >=3D 512).
> > Please increase KSYM_NAME_LEN both in kernel and kallsyms.c
> > ```
> >
> > Because the tests try to generate simbols of the same length as
> > KSYM_NAME_LEN. This is the expected outcome, as defined:
> > https://lore.kernel.org/all/20131023130753.GO29695@two.firstfloor.org/
> >
> > ---
> >  arch/x86/tools/insn_decoder_test.c |   3 +-
> >  lib/Kconfig.debug                  |   9 +++
> >  lib/Makefile                       |   2 +
> >  lib/longest_symbol_kunit.c         | 125 +++++++++++++++++++++++++++++
> >  4 files changed, 138 insertions(+), 1 deletion(-)
> >  create mode 100644 lib/longest_symbol_kunit.c
> >
> > diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_d=
ecoder_test.c
> > index 472540aeabc2..3bde35ea4188 100644
> > --- a/arch/x86/tools/insn_decoder_test.c
> > +++ b/arch/x86/tools/insn_decoder_test.c
> > @@ -10,6 +10,7 @@
> >  #include <assert.h>
> >  #include <unistd.h>
> >  #include <stdarg.h>
> > +#include <linux/kallsysms.h>
> >
> >  #define unlikely(cond) (cond)
> >
> > @@ -106,7 +107,7 @@ static void parse_args(int argc, char **argv)
> >         }
> >  }
> >
> > -#define BUFSIZE 256
> > +#define BUFSIZE (256 + KSYM_NAME_LEN)
> >
> >  int main(int argc, char **argv)
> >  {
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 7312ae7c3cc5..1f3059176637 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2820,6 +2820,15 @@ config FORTIFY_KUNIT_TEST
> >           by the str*() and mem*() family of functions. For testing run=
time
> >           traps of FORTIFY_SOURCE, see LKDTM's "FORTIFY_*" tests.
> >
> > +config LONGEST_SYM_KUNIT_TEST
> > +       tristate "Test the longest symbol possible" if !KUNIT_ALL_TESTS
> > +       depends on KUNIT && KPROBES
> > +       default KUNIT_ALL_TESTS
> > +       help
> > +         Tests the longest symbol possible
> > +
> > +         If unsure, say N.
> > +
> >  config HW_BREAKPOINT_KUNIT_TEST
> >         bool "Test hw_breakpoint constraints accounting" if !KUNIT_ALL_=
TESTS
> >         depends on HAVE_HW_BREAKPOINT
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 773adf88af41..fc878e716825 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -389,6 +389,8 @@ CFLAGS_fortify_kunit.o +=3D $(DISABLE_STRUCTLEAK_PL=
UGIN)
> >  obj-$(CONFIG_FORTIFY_KUNIT_TEST) +=3D fortify_kunit.o
> >  obj-$(CONFIG_SIPHASH_KUNIT_TEST) +=3D siphash_kunit.o
> >  obj-$(CONFIG_USERCOPY_KUNIT_TEST) +=3D usercopy_kunit.o
> > +obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) +=3D longest_symbol_kunit.o
> > +CFLAGS_longest_symbol_kunit.o +=3D $(call cc-disable-warning, missing-=
prototypes)
> >
> >  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) +=3D devmem_is_allowed.o
> >
> > diff --git a/lib/longest_symbol_kunit.c b/lib/longest_symbol_kunit.c
> > new file mode 100644
> > index 000000000000..ebd26eedbf7b
> > --- /dev/null
> > +++ b/lib/longest_symbol_kunit.c
> > @@ -0,0 +1,125 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Test the longest symbol length. Execute with:
> > + *  ./tools/testing/kunit/kunit.py run longest-symbol
> > + *  --arch=3Dx86_64 --kconfig_add CONFIG_KPROBES=3Dy --kconfig_add CON=
FIG_MODULES=3Dy
> > + *  --kconfig_add CONFIG_RETPOLINE=3Dn --kconfig_add CONFIG_CFI_CLANG=
=3Dn
> > + *  --kconfig_add CONFIG_MITIGATION_RETPOLINE=3Dn
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <kunit/test.h>
> > +#include <linux/stringify.h>
> > +#include <linux/kprobes.h>
> > +#include <linux/kallsyms.h>
> > +
> > +#define DI(name) s##name##name
> > +#define DDI(name) DI(n##name##name)
> > +#define DDDI(name) DDI(n##name##name)
> > +#define DDDDI(name) DDDI(n##name##name)
> > +#define DDDDDI(name) DDDDI(n##name##name)
> > +
> > +#define PLUS1(name) __PASTE(name, e)
> > +
> > +/*Generate a symbol whose name length is 511 */
> > +#define LONGEST_SYM_NAME  DDDDDI(g1h2i3j4k5l6m7n)
> > +
> > +/*Generate a symbol whose name length is 512 */
> > +#define LONGEST_SYM_NAME_PLUS1 PLUS1(LONGEST_SYM_NAME)
> > +
> > +#define RETURN_LONGEST_SYM 0xAAAAA
> > +#define RETURN_LONGEST_SYM_PLUS1 0x55555
> > +
> > +noinline int LONGEST_SYM_NAME(void);
> > +noinline int LONGEST_SYM_NAME(void)
> > +{
> > +       return RETURN_LONGEST_SYM;
> > +}
> > +
> > +noinline int LONGEST_SYM_NAME_PLUS1(void);
> > +noinline int LONGEST_SYM_NAME_PLUS1(void)
> > +{
> > +       return RETURN_LONGEST_SYM_PLUS1;
> > +}
> > +
> > +_Static_assert(sizeof(__stringify(LONGEST_SYM_NAME)) =3D=3D KSYM_NAME_=
LEN,
> > +"Incorrect symbol length found. Expected KSYM_NAME_LEN: "
> > +__stringify(KSYM_NAME) ", but found: "
> > +__stringify(sizeof(LONGEST_SYM_NAME)));
> > +
> > +static void test_longest_symbol(struct kunit *test)
> > +{
> > +       KUNIT_EXPECT_EQ(test, RETURN_LONGEST_SYM, LONGEST_SYM_NAME());
> > +};
> > +
> > +static void test_longest_symbol_kallsyms(struct kunit *test)
> > +{
> > +       unsigned long (*kallsyms_lookup_name)(const char *name);
> > +       static int (*longest_sym)(void);
> > +
> > +       struct kprobe kp =3D {
> > +               .symbol_name =3D "kallsyms_lookup_name",
> > +       };
> > +
> > +       if (register_kprobe(&kp) < 0) {
> > +               pr_info("%s: kprobe not registered\n", __func__);
> > +               KUNIT_FAIL(test, "test_longest_symbol kallsysms: kprobe=
 not registered\n");
> > +               return;
> > +       }
> > +
> > +       kunit_warn(test, "test_longest_symbol kallsyms: kprobe register=
ed\n");
> > +       kallsyms_lookup_name =3D (unsigned long (*)(const char *name))k=
p.addr;
> > +       unregister_kprobe(&kp);
> > +
> > +       longest_sym =3D
> > +               (void *) kallsyms_lookup_name(__stringify(LONGEST_SYM_N=
AME));
> > +       KUNIT_EXPECT_EQ(test, RETURN_LONGEST_SYM, longest_sym());
> > +};
> > +
> > +static void test_longest_symbol_plus1(struct kunit *test)
> > +{
> > +       KUNIT_EXPECT_EQ(test, RETURN_LONGEST_SYM_PLUS1, LONGEST_SYM_NAM=
E_PLUS1());
> > +};
> > +
> > +static void test_longest_symbol_plus1_kallsyms(struct kunit *test)
> > +{
> > +       unsigned long (*kallsyms_lookup_name)(const char *name);
> > +       static int (*longest_sym_plus1)(void);
> > +
> > +       struct kprobe kp =3D {
> > +               .symbol_name =3D "kallsyms_lookup_name",
> > +       };
> > +
> > +       if (register_kprobe(&kp) < 0) {
> > +               pr_info("%s: kprobe not registered\n", __func__);
> > +               KUNIT_FAIL(test, "test_longest_symbol kallsysms: kprobe=
 not registered\n");
> > +               return;
> > +       }
> > +
> > +       kunit_warn(test, "test_longest_symbol_plus1 kallsyms: kprobe re=
gistered\n");
> > +       kallsyms_lookup_name =3D (unsigned long (*)(const char *name))k=
p.addr;
> > +       unregister_kprobe(&kp);
> > +
> > +       longest_sym_plus1 =3D
> > +               (void *) kallsyms_lookup_name(__stringify(LONGEST_SYM_N=
AME_PLUS1));
> > +       KUNIT_EXPECT_NULL(test, longest_sym_plus1);
> > +};
> > +
> > +static struct kunit_case longest_symbol_test_cases[] =3D {
> > +       KUNIT_CASE(test_longest_symbol),
> > +       KUNIT_CASE(test_longest_symbol_kallsyms),
> > +       KUNIT_CASE(test_longest_symbol_plus1),
> > +       KUNIT_CASE(test_longest_symbol_plus1_kallsyms),
> > +       {}
> > +};
> > +
> > +static struct kunit_suite longest_symbol_test_suite =3D {
> > +       .name =3D "longest-symbol",
> > +       .test_cases =3D longest_symbol_test_cases,
> > +};
> > +kunit_test_suite(longest_symbol_test_suite);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("Test the longest symbol length");
> > +MODULE_AUTHOR("Sergio Gonz=C3=A1lez Collado");
> > --
> > 2.39.2
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "KUnit Development" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kunit-dev+unsubscribe@googlegroups.com.
> > To view this discussion visit https://groups.google.com/d/msgid/kunit-d=
ev/20241117195923.222145-1-sergio.collado%40gmail.com.

