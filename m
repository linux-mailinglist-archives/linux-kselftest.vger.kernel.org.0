Return-Path: <linux-kselftest+bounces-26807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA79CA38D4F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 21:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90AA1188ACAE
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 20:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD3423770B;
	Mon, 17 Feb 2025 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEFeESLo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B89222688A;
	Mon, 17 Feb 2025 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739824219; cv=none; b=Ur+5AHym5GtldLyWAc1FfVSS9PVAgC98rXtY/DGyhXfBUCJl6NG8NZyMt4HqR6iryEcbK0y2LoLwjy1kAiKMA1RMuQ+21PfNPHOPAvIP7YMnK6oHZg3ZHyuE2l56egI/dDyEv8b+c0d5hzSCKXoRGdOiamDVEo1yJ3o4s+pjw9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739824219; c=relaxed/simple;
	bh=hHj+ni7guICMMlq3AFNLkjqP1O7vxi1AkfDWBy8K0yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkszWvb7po/tiD6Cygd3SQH0uv1GnhRs+J4qmtl8CCk2K3nCzB2fJv7OE2TrmYekifzorZ+DF/3NPFBwZ2uIhydfHLdJm42DZOKczTU3IfFPaYdzI1yakoonb9ykpHhXG9CIsa1YYysuU0NIwb0GdlO64W/3WLGA8eALyWlvw7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEFeESLo; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3076262bfc6so50380691fa.3;
        Mon, 17 Feb 2025 12:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739824213; x=1740429013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfL3l8Z4aDmW/4LgzTXn4n1T2hToaIgptI3PZvLfVJc=;
        b=jEFeESLoRbCFya7nvizJvEEMqrUgRgXlSa4OIqGI8QcirW5Z0Ni9lIzxIF3p6/j1V7
         Gni1IlGYlg9QAmAaSbbatw31wNkn0Q5lWfSYOfqZEgDUXL7eDqkDtRvvdjD27c1Bt+WT
         is9ufusdSX12EhnDPZlOheEPYQmVp/SK1mNGqsMkE0COGqwxcM/VhIBnUJs+uEBl7kww
         wZVAcqTfQ5b2SyfckH+6r5h+B0JcbBcpKYXa1iJfanxy0JEus+n24DCAzKQItq2Nq7UF
         SpGTWxmDeskQ20N/8NoDXF3bMAFS4kwd2+6sISairTRYIWqnCfRqxIMnos/QNM9K6idx
         nccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739824213; x=1740429013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfL3l8Z4aDmW/4LgzTXn4n1T2hToaIgptI3PZvLfVJc=;
        b=DHv5XxFd9SmN7q6oUV4RmhduR+ovGafKQqfIvmc6RwfrPYk3JmmxwwDQ2sPrCqsjzb
         qXeuIrbz3dkaJOrWslJuB1/d1bvDv8DtQltRYcljhpC7GsXZOz5J59TLahbH8saeolkX
         31HafQJbaPwXTqeFZJQnXiLXze/U2ceXxAzgXFmEYRoiHiQN64jj/gv00GdOJ4/NDc7R
         wgP7IgiLP8U2TFaE/o77iFXLNlA2bdyEAPR1EI9EZ8U9zhB9dR88R+RD/JWvf6CssT2n
         vdR0D8Uw9bAy++LlkzSSWNSaFhU4AoDU22R6xkIfnHdUs4QGOxl4OCow2S9GSMEjW0RJ
         E+rA==
X-Forwarded-Encrypted: i=1; AJvYcCXSb7r5yIxON867VPogYttpY84cWgKDywt6tAiwiHZUwLcThpYChDcqyj1eTXMltR38smFV/QrYGVNybIH51eI=@vger.kernel.org, AJvYcCXm7eL+tATGY7aw/RZJT1zzBurzKu/8v7WyTaXXzxWAYGd4T529wU/hRDobATwzgaA18lz+eMf2nhjrMM/OTqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuLC6rWaXJYlsYJFEXFbSL47Cf4pm9NKhFdWWLbKaz+GjAtHUi
	Ls2iR4jc7xePfKTfbGC//Ah7ZqfgfsQf760/NuDXG7RJX0PhpGAQc4i1xOHlJ/knjlwmg4OMTmL
	e7c9bvQBYQycggXoo9B8+1yJ2x8k=
X-Gm-Gg: ASbGnctzNDDE+M5LTwOlcAIRtYS5XhkJ2DbDD1wzMuMEXiIQgz4UYWXD+21K4zh0bfT
	DImFnIDj5dvuN4O2qNl+uFKy0WjDQ/DJ/uFjsDft003dVFzXHWyVecxyrBhVWLihZo7gCJ9U=
X-Google-Smtp-Source: AGHT+IH5uVvDd6Cne/l61fuK43Afgo8nMjKgAKcSCvSB7ABbW1STcOPSwV3Ijv52x6kYgcCYXd7P3U02Lj3cFUIgGtY=
X-Received: by 2002:a2e:9396:0:b0:308:f75f:440 with SMTP id
 38308e7fff4ca-30927a576f4mr27324861fa.9.1739824212783; Mon, 17 Feb 2025
 12:30:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250202192412.340848-1-sergio.collado@gmail.com> <CA+GJov6+TPSm6ns8+MrSytWF5qsS1cm=KFJrUivPtzc5QvgARQ@mail.gmail.com>
In-Reply-To: <CA+GJov6+TPSm6ns8+MrSytWF5qsS1cm=KFJrUivPtzc5QvgARQ@mail.gmail.com>
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Mon, 17 Feb 2025 21:29:36 +0100
X-Gm-Features: AWEUYZlyoey_bsA_oN7b9t8TUCXWsdT9GsuwCy0WB-9notVkrie5IDJdh-Xue4Y
Message-ID: <CAA76j93VLJc=ocGYHqN-LSd717ip3kQFzk9EN789+Sq382g72g@mail.gmail.com>
Subject: Re: [PATCH v8] Kunit to check the longest symbol length
To: Rae Moar <rmoar@google.com>
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

Hello,

On Fri, 7 Feb 2025 at 22:54, Rae Moar <rmoar@google.com> wrote:
>
> On Sun, Feb 2, 2025 at 2:24=E2=80=AFPM Sergio Gonz=C3=A1lez Collado
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
> > The test suite defines one symbol with the longest possible length.
> >
> > The first test verify that functions with names of the created
> > symbol, can be called or not.
> >
> > The second test, verify that the symbols are created (or
> > not) in the kernel symbol table.
> >
> > [1] https://lore.kernel.org/lkml/20220802015052.10452-6-ojeda@kernel.or=
g/
> > [2] https://lore.kernel.org/lkml/20240605032120.3179157-1-song@kernel.o=
rg/
> >
> > Tested-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> > Reviewed-by: Rae Moar <rmoar@google.com>
> > Signed-off-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>
> > Link: https://github.com/Rust-for-Linux/linux/issues/504
>
> Hello!
>
> Thanks for fixing the typo and this new version! This patch still does
> not apply cleanly in the Makefile for me. Have you rebased it on the
> kselftest/kunit branch? I also have a few more questions that I just
> noticed.
>
> Thanks!
> -Rae
>
> > ---
> > V7 -> V8: typo fixed & rebased
> > ---
> > V6 -> V7: rebased
> > ---
> > V5 -> V6: remove tests with symbols of length KSYM_NAME_LEN+1
> > ---
> > V4 -> V5: fixed typo, added improved description
> > ---
> > V3 -> V4: add x86 mantainers, add new reference.
> > ---
> > V2 -> V3: updated base and added MODULE_DESCRIPTION() and MODULE_AUTHOR=
()
> > ---
> > V1 -> V2: corrected CI tests. Added fix proposed at [3]
> >
> > [3] https://lore.kernel.org/lkml/Y9ES4UKl%2F+DtvAVS@gmail.com/T/#m3ef0e=
12bb834d01ed1ebdcae12ef5f2add342077
> >
> > The test execution should result in something like:
> > ```
> > [20:04:35] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D longest-symbol=
 (4 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [20:04:35] [PASSED] test_longest_symbol
> > [20:04:35] [PASSED] test_longest_symbol_kallsyms
> > [20:04:35] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED]=
 longest-symbol =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [20:04:35] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [20:04:35] Testing complete. Ran 4 tests: passed: 4
> > ```
> > ---
> >  arch/x86/tools/insn_decoder_test.c |  3 +-
> >  lib/Kconfig.debug                  |  9 ++++
> >  lib/Makefile                       |  2 +
> >  lib/longest_symbol_kunit.c         | 84 ++++++++++++++++++++++++++++++
> >  4 files changed, 97 insertions(+), 1 deletion(-)
> >  create mode 100644 lib/longest_symbol_kunit.c
> >
> > diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_d=
ecoder_test.c
> > index 472540aeabc2..6c2986d2ad11 100644
> > --- a/arch/x86/tools/insn_decoder_test.c
> > +++ b/arch/x86/tools/insn_decoder_test.c
> > @@ -10,6 +10,7 @@
> >  #include <assert.h>
> >  #include <unistd.h>
> >  #include <stdarg.h>
> > +#include <linux/kallsyms.h>
> >
> >  #define unlikely(cond) (cond)
> >
> > @@ -106,7 +107,7 @@ static void parse_args(int argc, char **argv)
> >         }
> >  }
> >
> > -#define BUFSIZE 256
> > +#define BUFSIZE (256 + KSYM_NAME_LEN)
>
> I'm not too familiar with this test. I believe this would potentially
> make a symbol with a length that exceeds the KSYM_NAME_LEN. What is
> the intention for this line?
That will define how much space to write a symbol. I'm also not
familiar with that test, but I know had to be fixed:
https://lore.kernel.org/lkml/Y9ES4UKl%2F+DtvAVS@gmail.com/T/#m3ef0e12bb834d=
01ed1ebdcae12ef5f2add342077

>
> >
> >  int main(int argc, char **argv)
> >  {
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 1af972a92d06..62d43aa9e8f0 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2838,6 +2838,15 @@ config FORTIFY_KUNIT_TEST
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
> > index d5cfc7afbbb8..e8fec9defec2 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -393,6 +393,8 @@ obj-$(CONFIG_FORTIFY_KUNIT_TEST) +=3D fortify_kunit=
.o
> >  obj-$(CONFIG_CRC_KUNIT_TEST) +=3D crc_kunit.o
> >  obj-$(CONFIG_SIPHASH_KUNIT_TEST) +=3D siphash_kunit.o
> >  obj-$(CONFIG_USERCOPY_KUNIT_TEST) +=3D usercopy_kunit.o
> > +obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) +=3D longest_symbol_kunit.o
> > +CFLAGS_longest_symbol_kunit.o +=3D $(call cc-disable-warning, missing-=
prototypes)
> >
> >  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) +=3D devmem_is_allowed.o
>
> These are the lines that are causing the patch to not apply cleanly.
> The change list that applies cleanly for me is:
>
>  obj-$(CONFIG_FORTIFY_KUNIT_TEST) +=3D fortify_kunit.o
>  obj-$(CONFIG_SIPHASH_KUNIT_TEST) +=3D siphash_kunit.o
>  obj-$(CONFIG_USERCOPY_KUNIT_TEST) +=3D usercopy_kunit.o
>  obj-$(CONFIG_CRC16_KUNIT_TEST) +=3D crc16_kunit.o
> +obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) +=3D longest_symbol_kunit.o
> +CFLAGS_longest_symbol_kunit.o +=3D $(call cc-disable-warning, missing-pr=
ototypes)
>
>  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) +=3D devmem_is_allowed.o
>
I will create a new rebased version of the patch.

> >
> > diff --git a/lib/longest_symbol_kunit.c b/lib/longest_symbol_kunit.c
> > new file mode 100644
> > index 000000000000..2a2dd1151097
> > --- /dev/null
> > +++ b/lib/longest_symbol_kunit.c
> > @@ -0,0 +1,84 @@
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
>
> I don't believe you use this macro. Could probably be deleted.
>
This macro should work out of the box by means of the pr_*() macros:
https://docs.kernel.org/core-api/printk-basics.html#c.pr_fmt

>
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
>
> I don't think you use this anymore with the new changes. Can probably
> be deleted.
>
Indeed, I totally overlooked that.

>
> > +
> > +/*Generate a symbol whose name length is 511 */
> > +#define LONGEST_SYM_NAME  DDDDDI(g1h2i3j4k5l6m7n)
> > +
> > +#define RETURN_LONGEST_SYM 0xAAAAA
> > +
> > +noinline int LONGEST_SYM_NAME(void);
> > +noinline int LONGEST_SYM_NAME(void)
> > +{
> > +       return RETURN_LONGEST_SYM;
> > +}
> > +
> > +_Static_assert(sizeof(__stringify(LONGEST_SYM_NAME)) =3D=3D KSYM_NAME_=
LEN,
> > +"Incorrect symbol length found. Expected KSYM_NAME_LEN: "
> > +__stringify(KSYM_NAME) ", but found: "
> > +__stringify(sizeof(LONGEST_SYM_NAME)));
>
> Should this error return __stringify(KSYM_NAME_LEN) instead of
> __stringify(KSYM_NAME) to give the maximum length?
>
It is done on purpose to show what the actual symbol is. Under some
conditions the names can incorporate
prefix symbols, for example:
https://lore.kernel.org/lkml/20221028194453.526899822@infradead.org/,
if this happens it will be easier to spot what is going on.

>
> Also, I get an error because the length of LONGEST_SYM_NAME is 512.
> The error is produced by this code:
> https://elixir.bootlin.com/linux/v6.13.1/source/scripts/kallsyms.c#L152
> and alerts if the symbol length is >=3D to KSYM_NAME_LEN. That is fine
> as long as that is the intention of this test to produce a warning. Or
> should this warning change to be "> KSYM_NAME_LEN" if usage of symbols
> that are the maximum length is allowed?
>
Indeed that is expected, as the limit is reached. I think it may not
be really needed to update the condition to "> KSYM_NAME_LEN".


Thanks a lot for your remarks.
Cheers!

