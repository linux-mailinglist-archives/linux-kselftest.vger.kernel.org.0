Return-Path: <linux-kselftest+bounces-27020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26B4A3CD19
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 00:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936E83B741A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 23:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3130B25EF98;
	Wed, 19 Feb 2025 23:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H8vElUH1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B73825E44C
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 23:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006625; cv=none; b=GMmzu9d1r1GAhmf6vnEV5EZt4cRrqq0y6bN+FWE2dQQ5SQbQ0YseEqNmGHv4q4kZaUAWQjQAn57k4LsNRA9gPUWjzJeWTD2+u0O/ycn5dNUNkkuQQ5gbl57J2/8PWG0qZ2JLRqiERRHx1CE1K9nlpYtOuInvPJUNoFoOnnmN3jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006625; c=relaxed/simple;
	bh=2v3fbJENcPCOsiSlqCuhDArUF6IFIdzSWeYv9YS73YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGdmafJu7oeySvINcokTEIvqj6glq/OVEQ+LMa5X1s/a+dzAvcul2HhMMRXkHGhqfqUpxtPSBErEOoVYwRNVYm2HEXzNEtCa0rIMJWrRQvaDDDKdS7Z5YtNvZ2hZSkShWDvjaj0AuvsSowru7S83bfTeJJETJJt7Ub5pAS0xGGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H8vElUH1; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e44fda56e3so3702286d6.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 15:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740006621; x=1740611421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxDOtVT8g3qbzXn2w5KHZMQo+N1woVaWlFhDh/fHi0s=;
        b=H8vElUH1IBWNhrIgen/wZyeCYTF34vdouzpK0ALmRI6Kl+m1hKkTEuL5avS04SSs74
         cN6qzd1DkBT2Ip1nq3itrAGtn7P1jkc3uD6ypr6GDfMcnxxI1kCi1VUnWc8rVkhcAt5z
         cIF8V0UzNgSzVlzbYlRJgebvdtFDQ1e2Jj1/zbJ2QMN4ABUkckf3nMVv6jANLoMXWkd8
         WcaomXV2B2wZOUE4MkXOPMHSbB7wW/OKl998IT2f47J7fKp8Ef3LW4RXckhUZLurgBuu
         YWQ7HrDxs7LhsCtgWwYJD7+ZTV0nsiZ36V6Ook3Fxr76CNlFG/a/NeSKFbZNvfkAdStd
         Ev9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740006621; x=1740611421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxDOtVT8g3qbzXn2w5KHZMQo+N1woVaWlFhDh/fHi0s=;
        b=xIdt/n9ZYjMQWOuDDehIO4ZWBoNEIqnxqJWgAMjjmQocwGt1f6c9creIk7YZDyDslJ
         zKrYXTrhB1k8I9STDy0K7N7j/xPG7cybRaXNAP7G7Q+rxhY8DUw1ebRnbvgjYZj1hQ+Z
         8dRPqBWiiLtm0CnQnHMdgl6iIHlAINzaXiAnPhOp0k7tqFPmd9vvkDaqVj3uTRN4MBXy
         08yJUE3IziY+iyH5RfrBa0ntpOsCrLJy8BkgOLgWNpemUd7yzfHGBZMcln9Hb/A/eNlp
         L0HrxzoKlScltIJxrH/5fP26thy5av3ybFNDL8dRI34dlngULld9GmGmvxef70/i7VXv
         ENjg==
X-Forwarded-Encrypted: i=1; AJvYcCV6RbQ2UihzSTDzHtQhp0dcx5p/NQLKaaUtRx7zYcbo+9zjUxhtQfOxW8lUzC7ES1CwGfsWLEnT9csXSmFmH8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa4IKOPDfUsq9cPTIBIUEcexQ5+J5okfFJA29PktwMKGSb+RnQ
	dK4Pc+Qwtqt51XPp3HiWixHjWJeG1UjD7ALl4aXW3fTQafs1PfsS0fr+LHeWXcCqyLqnFrxgEs6
	kFcUvrN3dnBIMD5H/6ravZ11aCOC2fhHg6gKX
X-Gm-Gg: ASbGncvTQfDQbLuJg8vMzdk7syfx/pnZDOGJ/tO1TY+6NT3A83gDQ9AnofBQEfu+CvC
	bSGG7UrtZozS3h89GrgJvkq6c1VIARQJWV7gLFTfyc54BKu3ciilDEZQ0bOlK9NsucvryTmQMHg
	HoNsVDoNB5C5qczrq82Ilg4hTvqfLAoc4=
X-Google-Smtp-Source: AGHT+IEw/mpr7Oz2wdmnj9Oda8U1Bn34wzWNruZoEp5Td7KL4zsegVlhKsPNH7lpeKFCF81jQzEpT14QjvWmwK9bxNc=
X-Received: by 2002:ad4:5aac:0:b0:6e4:5971:135d with SMTP id
 6a1803df08f44-6e6a26396a4mr17987456d6.18.1740006620727; Wed, 19 Feb 2025
 15:10:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250202192412.340848-1-sergio.collado@gmail.com>
 <CA+GJov6+TPSm6ns8+MrSytWF5qsS1cm=KFJrUivPtzc5QvgARQ@mail.gmail.com> <CAA76j93VLJc=ocGYHqN-LSd717ip3kQFzk9EN789+Sq382g72g@mail.gmail.com>
In-Reply-To: <CAA76j93VLJc=ocGYHqN-LSd717ip3kQFzk9EN789+Sq382g72g@mail.gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Wed, 19 Feb 2025 18:10:08 -0500
X-Gm-Features: AWEUYZmA9y1IK7t8yZ1EpnrJjF_VBJnhxF8CEsJZWnAav7LBMLY2NYNsOtING80
Message-ID: <CA+GJov6oxnFp-XYtQVxdWbGAWpCkNjmUZZi=iRPj-eWUZWOvKA@mail.gmail.com>
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

On Mon, Feb 17, 2025 at 3:30=E2=80=AFPM Sergio Gonz=C3=A1lez Collado
<sergio.collado@gmail.com> wrote:
>
> Hello,
>
> On Fri, 7 Feb 2025 at 22:54, Rae Moar <rmoar@google.com> wrote:
> >
> > On Sun, Feb 2, 2025 at 2:24=E2=80=AFPM Sergio Gonz=C3=A1lez Collado
> > <sergio.collado@gmail.com> wrote:
> > >
> > > The longest length of a symbol (KSYM_NAME_LEN) was increased to 512
> > > in the reference [1]. This patch adds kunit test suite to check the l=
ongest
> > > symbol length. These tests verify that the longest symbol length defi=
ned
> > > is supported.
> > >
> > > This test can also help other efforts for longer symbol length,
> > > like [2].
> > >
> > > The test suite defines one symbol with the longest possible length.
> > >
> > > The first test verify that functions with names of the created
> > > symbol, can be called or not.
> > >
> > > The second test, verify that the symbols are created (or
> > > not) in the kernel symbol table.
> > >
> > > [1] https://lore.kernel.org/lkml/20220802015052.10452-6-ojeda@kernel.=
org/
> > > [2] https://lore.kernel.org/lkml/20240605032120.3179157-1-song@kernel=
.org/
> > >
> > > Tested-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > > Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> > > Reviewed-by: Rae Moar <rmoar@google.com>
> > > Signed-off-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com=
>
> > > Link: https://github.com/Rust-for-Linux/linux/issues/504
> >
> > Hello!
> >
> > Thanks for fixing the typo and this new version! This patch still does
> > not apply cleanly in the Makefile for me. Have you rebased it on the
> > kselftest/kunit branch? I also have a few more questions that I just
> > noticed.
> >
> > Thanks!
> > -Rae
> >
> > > ---
> > > V7 -> V8: typo fixed & rebased
> > > ---
> > > V6 -> V7: rebased
> > > ---
> > > V5 -> V6: remove tests with symbols of length KSYM_NAME_LEN+1
> > > ---
> > > V4 -> V5: fixed typo, added improved description
> > > ---
> > > V3 -> V4: add x86 mantainers, add new reference.
> > > ---
> > > V2 -> V3: updated base and added MODULE_DESCRIPTION() and MODULE_AUTH=
OR()
> > > ---
> > > V1 -> V2: corrected CI tests. Added fix proposed at [3]
> > >
> > > [3] https://lore.kernel.org/lkml/Y9ES4UKl%2F+DtvAVS@gmail.com/T/#m3ef=
0e12bb834d01ed1ebdcae12ef5f2add342077
> > >
> > > The test execution should result in something like:
> > > ```
> > > [20:04:35] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D longest-symb=
ol (4 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > [20:04:35] [PASSED] test_longest_symbol
> > > [20:04:35] [PASSED] test_longest_symbol_kallsyms
> > > [20:04:35] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSE=
D] longest-symbol =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > [20:04:35] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > [20:04:35] Testing complete. Ran 4 tests: passed: 4
> > > ```
> > > ---
> > >  arch/x86/tools/insn_decoder_test.c |  3 +-
> > >  lib/Kconfig.debug                  |  9 ++++
> > >  lib/Makefile                       |  2 +
> > >  lib/longest_symbol_kunit.c         | 84 ++++++++++++++++++++++++++++=
++
> > >  4 files changed, 97 insertions(+), 1 deletion(-)
> > >  create mode 100644 lib/longest_symbol_kunit.c
> > >
> > > diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn=
_decoder_test.c
> > > index 472540aeabc2..6c2986d2ad11 100644
> > > --- a/arch/x86/tools/insn_decoder_test.c
> > > +++ b/arch/x86/tools/insn_decoder_test.c
> > > @@ -10,6 +10,7 @@
> > >  #include <assert.h>
> > >  #include <unistd.h>
> > >  #include <stdarg.h>
> > > +#include <linux/kallsyms.h>
> > >
> > >  #define unlikely(cond) (cond)
> > >
> > > @@ -106,7 +107,7 @@ static void parse_args(int argc, char **argv)
> > >         }
> > >  }
> > >
> > > -#define BUFSIZE 256
> > > +#define BUFSIZE (256 + KSYM_NAME_LEN)
> >
> > I'm not too familiar with this test. I believe this would potentially
> > make a symbol with a length that exceeds the KSYM_NAME_LEN. What is
> > the intention for this line?
> That will define how much space to write a symbol. I'm also not
> familiar with that test, but I know had to be fixed:
> https://lore.kernel.org/lkml/Y9ES4UKl%2F+DtvAVS@gmail.com/T/#m3ef0e12bb83=
4d01ed1ebdcae12ef5f2add342077
>
> >
> > >
> > >  int main(int argc, char **argv)
> > >  {
> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index 1af972a92d06..62d43aa9e8f0 100644
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -2838,6 +2838,15 @@ config FORTIFY_KUNIT_TEST
> > >           by the str*() and mem*() family of functions. For testing r=
untime
> > >           traps of FORTIFY_SOURCE, see LKDTM's "FORTIFY_*" tests.
> > >
> > > +config LONGEST_SYM_KUNIT_TEST
> > > +       tristate "Test the longest symbol possible" if !KUNIT_ALL_TES=
TS
> > > +       depends on KUNIT && KPROBES
> > > +       default KUNIT_ALL_TESTS
> > > +       help
> > > +         Tests the longest symbol possible
> > > +
> > > +         If unsure, say N.
> > > +
> > >  config HW_BREAKPOINT_KUNIT_TEST
> > >         bool "Test hw_breakpoint constraints accounting" if !KUNIT_AL=
L_TESTS
> > >         depends on HAVE_HW_BREAKPOINT
> > > diff --git a/lib/Makefile b/lib/Makefile
> > > index d5cfc7afbbb8..e8fec9defec2 100644
> > > --- a/lib/Makefile
> > > +++ b/lib/Makefile
> > > @@ -393,6 +393,8 @@ obj-$(CONFIG_FORTIFY_KUNIT_TEST) +=3D fortify_kun=
it.o
> > >  obj-$(CONFIG_CRC_KUNIT_TEST) +=3D crc_kunit.o
> > >  obj-$(CONFIG_SIPHASH_KUNIT_TEST) +=3D siphash_kunit.o
> > >  obj-$(CONFIG_USERCOPY_KUNIT_TEST) +=3D usercopy_kunit.o
> > > +obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) +=3D longest_symbol_kunit.o
> > > +CFLAGS_longest_symbol_kunit.o +=3D $(call cc-disable-warning, missin=
g-prototypes)
> > >
> > >  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) +=3D devmem_is_allowed.o
> >
> > These are the lines that are causing the patch to not apply cleanly.
> > The change list that applies cleanly for me is:
> >
> >  obj-$(CONFIG_FORTIFY_KUNIT_TEST) +=3D fortify_kunit.o
> >  obj-$(CONFIG_SIPHASH_KUNIT_TEST) +=3D siphash_kunit.o
> >  obj-$(CONFIG_USERCOPY_KUNIT_TEST) +=3D usercopy_kunit.o
> >  obj-$(CONFIG_CRC16_KUNIT_TEST) +=3D crc16_kunit.o
> > +obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) +=3D longest_symbol_kunit.o
> > +CFLAGS_longest_symbol_kunit.o +=3D $(call cc-disable-warning, missing-=
prototypes)
> >
> >  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) +=3D devmem_is_allowed.o
> >
> I will create a new rebased version of the patch.
>
> > >
> > > diff --git a/lib/longest_symbol_kunit.c b/lib/longest_symbol_kunit.c
> > > new file mode 100644
> > > index 000000000000..2a2dd1151097
> > > --- /dev/null
> > > +++ b/lib/longest_symbol_kunit.c
> > > @@ -0,0 +1,84 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Test the longest symbol length. Execute with:
> > > + *  ./tools/testing/kunit/kunit.py run longest-symbol
> > > + *  --arch=3Dx86_64 --kconfig_add CONFIG_KPROBES=3Dy --kconfig_add C=
ONFIG_MODULES=3Dy
> > > + *  --kconfig_add CONFIG_RETPOLINE=3Dn --kconfig_add CONFIG_CFI_CLAN=
G=3Dn
> > > + *  --kconfig_add CONFIG_MITIGATION_RETPOLINE=3Dn
> > > + */
> > > +
> > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >
> > I don't believe you use this macro. Could probably be deleted.
> >
> This macro should work out of the box by means of the pr_*() macros:
> https://docs.kernel.org/core-api/printk-basics.html#c.pr_fmt

Hi! Thanks for your responses.

This seems good to me. Thanks for the explanation.

>
> >
> > > +
> > > +#include <kunit/test.h>
> > > +#include <linux/stringify.h>
> > > +#include <linux/kprobes.h>
> > > +#include <linux/kallsyms.h>
> > > +
> > > +#define DI(name) s##name##name
> > > +#define DDI(name) DI(n##name##name)
> > > +#define DDDI(name) DDI(n##name##name)
> > > +#define DDDDI(name) DDDI(n##name##name)
> > > +#define DDDDDI(name) DDDDI(n##name##name)
> > > +
> > > +#define PLUS1(name) __PASTE(name, e)
> >
> > I don't think you use this anymore with the new changes. Can probably
> > be deleted.
> >
> Indeed, I totally overlooked that.
>
> >
> > > +
> > > +/*Generate a symbol whose name length is 511 */
> > > +#define LONGEST_SYM_NAME  DDDDDI(g1h2i3j4k5l6m7n)
> > > +
> > > +#define RETURN_LONGEST_SYM 0xAAAAA
> > > +
> > > +noinline int LONGEST_SYM_NAME(void);
> > > +noinline int LONGEST_SYM_NAME(void)
> > > +{
> > > +       return RETURN_LONGEST_SYM;
> > > +}
> > > +
> > > +_Static_assert(sizeof(__stringify(LONGEST_SYM_NAME)) =3D=3D KSYM_NAM=
E_LEN,
> > > +"Incorrect symbol length found. Expected KSYM_NAME_LEN: "
> > > +__stringify(KSYM_NAME) ", but found: "
> > > +__stringify(sizeof(LONGEST_SYM_NAME)));
> >
> > Should this error return __stringify(KSYM_NAME_LEN) instead of
> > __stringify(KSYM_NAME) to give the maximum length?
> >
> It is done on purpose to show what the actual symbol is. Under some
> conditions the names can incorporate
> prefix symbols, for example:
> https://lore.kernel.org/lkml/20221028194453.526899822@infradead.org/,
> if this happens it will be easier to spot what is going on.

Right now this outputs: "Incorrect symbol len. Expected KSYM_NAME_LEN:
KSYM_NAME, but found: sizeof(snn...6m7n)"
This seems incorrect because KSYM_NAME has no value. Instead I would
expect:  "Incorrect symbol len. Expected KSYM_NAME_LEN: 512, but
found: sizeof(snn...6m7n)".

>
> >
> > Also, I get an error because the length of LONGEST_SYM_NAME is 512.
> > The error is produced by this code:
> > https://elixir.bootlin.com/linux/v6.13.1/source/scripts/kallsyms.c#L152
> > and alerts if the symbol length is >=3D to KSYM_NAME_LEN. That is fine
> > as long as that is the intention of this test to produce a warning. Or
> > should this warning change to be "> KSYM_NAME_LEN" if usage of symbols
> > that are the maximum length is allowed?
> >
> Indeed that is expected, as the limit is reached. I think it may not
> be really needed to update the condition to "> KSYM_NAME_LEN".
>

That seems good to me.

Thanks!
-Rae

>
> Thanks a lot for your remarks.
> Cheers!

