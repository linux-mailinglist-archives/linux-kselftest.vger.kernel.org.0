Return-Path: <linux-kselftest+bounces-28420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA7AA55313
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 18:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBBE3A982D
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 17:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C888925C6EE;
	Thu,  6 Mar 2025 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkXKfeLZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F37D255E54;
	Thu,  6 Mar 2025 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741282167; cv=none; b=RPNRja2vWeJb3n5exLcSOY8A+ilfIUpyaRX09DeT3Sj2v++X77J+70HcbUOnoc6zVy1ESp8ZPjWs+Ybs2fN/+hmlU9WcMngVupTVJK1z2JCHfcp0az+b1/24fHQf1LGQjDlJcWxewlACYUJXmZFLcPQKi4xxgnjh9xsm1jaoeSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741282167; c=relaxed/simple;
	bh=2ZDI1BOKBehLrp6Gp9yWJh4BFdQxUqk4fAQd6AEYX7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2YJYoXv1fTWACGAgAumGZXxFakJSOV2pA1u+elvJz3cnSbtgLKXWfCshz5dDWeibPxeJ9KwJsHjeTjw/CrcYPDCVMiMrL3zM1jis3C1Twoh0lis7fErV0fD+DO6e8dGR/5+/9Zhw0HIFYFfEyU4dTFFejwVUEz1zeTG8ETDN8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkXKfeLZ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30ba92c846eso8973451fa.3;
        Thu, 06 Mar 2025 09:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741282164; x=1741886964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3GPRBnBVmbxhI0dCIq/9TZYTROumSbSHyzxyoeisCA=;
        b=TkXKfeLZhVHLhqIvGcCvfLhPAiiGecgF2kIY7DtMFPP2yid4VCLDAloUPvjQaH0e/m
         jR4rst351h4Gm8ufniLjaAaFPxpYEeH2Br8v8Bk7YjoTDnJAlHg0zewBp3VzV4mpKTob
         d4aHsfF74iXl1CNfg0GvxxpdqNZ7BAJdpi+c06w6dnA7wEl5RxZ5gVU73s1UVDICG11M
         tkk6g/lrDMajXSwE8NImDP01HAuQHRbVQ1d9pSxOeECS1KFJ/xkn/3iiLMLInDIHoKio
         yMDnZ3GmKxD8miBXy5VZ2jtZMN74W5CD34Y67/ZL4ZWq2On8x72l/wbjUyxRYfJt008V
         xA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741282164; x=1741886964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3GPRBnBVmbxhI0dCIq/9TZYTROumSbSHyzxyoeisCA=;
        b=DhR6okRmtjdR4BXi2Pjnq17YsGA/CMy6tVhzDHIb9Hgy5PvVnL6Kw21ft9psZwDFtO
         iraGMpg5OJehMqiU0fHfUjUxmMoOaSHKlgiRfqaxwyy3nrwaSyKg4tL8HtOMdkPnoQZw
         4lGdlk5zSTUUMxskwFFpSCQLIzUYdQn3E2h0q/McO2w57U1a1p8o1WTV9+TLG3ZaYhyL
         vCKKIk5Eih88M99qU7SzRhmtUYL8foz7hawKJFPHgKf4der/Rd4MaE6QQEdi1UDw6/yO
         wsw82HsXdIqAv8UpHiYWB5qSlYcvVAWeM0ZhqHqpqtcieB0gW2cBcz8IYCQYU8j1y2zD
         o0vA==
X-Forwarded-Encrypted: i=1; AJvYcCUM2BpXv3G7xzykajlHhHij7wMfncpYWEk4jHI6M8hC2qrVmq9tyBWaWj4z2k+Ctrt3Mx3fP0fm5KLIF373@vger.kernel.org, AJvYcCV46PmO8KVZZ0MPEjhfqv/nS5R9X2HEsY4BR27wqjpe6HR0videhj+zaHA23C6XDNo8FT8VYzPXYG+Vuj3z0vQO@vger.kernel.org, AJvYcCWLSRKiQDwS8ips6V12I2O1ij0o5Ce/E/bqqvn3ADT+iGlc1izZm2MMgEG+7ts6whzvbQsiJ2LjGOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+8yWSuAB3uP6cBuj1e+K7iIG2qoQWh1MkVixVHpnSZAEq/K1h
	MABHTarwIp5QSs7O+8PkOrmj1nlWAawjqG9+XKA4ia66LuVeMPD0yTChlEmoYXxmty9vGJw6HNy
	sAggvGuigUlQ/AozpMDeHDcttwrg=
X-Gm-Gg: ASbGncucZtY48J/p9djmDRvGa3O2zw3RYF5wqpV/D0mBE7VNULXbRb7lpF4d/WORkXK
	drVgurDauD4uCDV/DnRLa5t4as5mDcNqPwRA4K5axF9DjiKIZfLW+TJWRtfAvmz9DiGEZl9uwOm
	5GdseemNiKgdY8zMKUCOUwdBPn6F6d7TgoxdnGtNW5Hg==
X-Google-Smtp-Source: AGHT+IH/YlWmoRHr1Ii2Pc5mZeyT1wbsTGHyOyWkV+/j74OqiWKiPVXIMNv8fKZgc+JSddo0OQ9fxbaIyeYzSitv60o=
X-Received: by 2002:a2e:a595:0:b0:307:2b3e:a4a9 with SMTP id
 38308e7fff4ca-30bd7a70812mr37072751fa.20.1741282163283; Thu, 06 Mar 2025
 09:29:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-printf-kunit-convert-v5-0-5db840301730@gmail.com>
 <20250221-printf-kunit-convert-v5-2-5db840301730@gmail.com> <Z8nQ0vCNgz4lEJEj@pathway.suse.cz>
In-Reply-To: <Z8nQ0vCNgz4lEJEj@pathway.suse.cz>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 6 Mar 2025 12:28:47 -0500
X-Gm-Features: AQ5f1Jo7c5afgFz2OUPXMWBao9ERbtEDe2_OPEz4cK8LEr1rzbF43Frduj4rlVE
Message-ID: <CAJ-ks9k8GON_x3doHi6XCNrQLfiva6obrQ7A6Sn+qUgdXLUuhQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] printf: break kunit into test cases
To: Petr Mladek <pmladek@suse.com>
Cc: Arpitha Raghunandan <98.arpi@gmail.com>, David Gow <davidgow@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 11:44=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Fri 2025-02-21 15:34:31, Tamir Duberstein wrote:
> > Move all tests into `printf_test_cases`. This gives us nicer output in
> > the event of a failure.
> >
> > Combine `plain_format` and `plain_hash` into `hash_pointer` since
> > they're testing the same scenario.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  lib/tests/printf_kunit.c | 331 +++++++++++++++++----------------------=
--------
> >  1 file changed, 121 insertions(+), 210 deletions(-)
> >
> > diff --git a/lib/tests/printf_kunit.c b/lib/tests/printf_kunit.c
> > index 287bbfb61148..013df6f6dd49 100644
> > --- a/lib/tests/printf_kunit.c
> > +++ b/lib/tests/printf_kunit.c
> > @@ -38,13 +38,8 @@ static unsigned int total_tests;
> >  static char *test_buffer;
> >  static char *alloced_buffer;
> >
> > -static struct kunit *kunittest;
> > -
> > -#define tc_fail(fmt, ...) \
> > -     KUNIT_FAIL(kunittest, fmt, ##__VA_ARGS__)
> > -
> > -static void __printf(4, 0)
> > -do_test(int bufsize, const char *expect, int elen,
> > +static void __printf(5, 0)
> > +do_test(struct kunit *kunittest, int bufsize, const char *expect, int =
elen,
> >       const char *fmt, va_list ap)
> >  {
> >       va_list aq;
> > @@ -58,59 +53,64 @@ do_test(int bufsize, const char *expect, int elen,
> [...]
> >
> >       if (memcmp(test_buffer, expect, written)) {
> > -             tc_fail("vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expe=
cted '%.*s'",
> > -                     bufsize, fmt, test_buffer, written, expect);
> > +             KUNIT_FAIL(kunittest, "vsnprintf(buf, %d, \"%s\", ...) wr=
ote '%s', expected '%.*s'",
> > +                        bufsize, fmt, test_buffer, written, expect);
> >               return;
> >       }
> >  }
> >
> > -static void __printf(3, 4)
> > -__test(const char *expect, int elen, const char *fmt, ...)
> > +static void __printf(4, 0)
>
> This should be:
>
> static void __printf(4, 5)
>
> The 2nd parameter is zero when the variable list of parameters is
> passed using va_list.

Yeah, thanks for the catch. I fixed this locally after you observed
the same on the scanf-kunit series.

> > +__test(struct kunit *kunittest, const char *expect, int elen, const ch=
ar *fmt, ...)
> >  {
> >       va_list ap;
> >       int rand;
> >       char *p;
>
> > @@ -247,89 +225,44 @@ plain_format(void)
> >  #define ZEROS ""
> >  #define ONES ""
> >
> > -static int
> > -plain_format(void)
> > -{
> > -     /* Format is implicitly tested for 32 bit machines by plain_hash(=
) */
> > -     return 0;
> > -}
> > -
> >  #endif       /* BITS_PER_LONG =3D=3D 64 */
> >
> > -static int
> > -plain_hash_to_buffer(const void *p, char *buf, size_t len)
> > +static void
> > +plain_hash_to_buffer(struct kunit *kunittest, const void *p, char *buf=
, size_t len)
> >  {
> > -     int nchars;
> > -
> > -     nchars =3D snprintf(buf, len, "%p", p);
> > -
> > -     if (nchars !=3D PTR_WIDTH)
> > -             return -1;
> > +     KUNIT_ASSERT_EQ(kunittest, snprintf(buf, len, "%p", p), PTR_WIDTH=
);
> >
> >       if (strncmp(buf, PTR_VAL_NO_CRNG, PTR_WIDTH) =3D=3D 0) {
> >               kunit_warn(kunittest, "crng possibly not yet initialized.=
 plain 'p' buffer contains \"%s\"",
> >                       PTR_VAL_NO_CRNG);
> > -             return 0;
> >       }
> > -
> > -     return 0;
> >  }
> >
> > -static int
> > -plain_hash(void)
> > -{
> > -     char buf[PLAIN_BUF_SIZE];
> > -     int ret;
> > -
> > -     ret =3D plain_hash_to_buffer(PTR, buf, PLAIN_BUF_SIZE);
> > -     if (ret)
> > -             return ret;
> > -
> > -     if (strncmp(buf, PTR_STR, PTR_WIDTH) =3D=3D 0)
> > -             return -1;
> > -
> > -     return 0;
> > -}
> > -
> > -/*
> > - * We can't use test() to test %p because we don't know what output to=
 expect
> > - * after an address is hashed.
> > - */
> >  static void
> > -plain(void)
> > +hash_pointer(struct kunit *kunittest)
> >  {
> > -     int err;
> > +     if (no_hash_pointers)
> > +             kunit_skip(kunittest, "hash pointers disabled");
> >
> > -     if (no_hash_pointers) {
> > -             kunit_warn(kunittest, "skipping plain 'p' tests");
> > -             return;
> > -     }
> > +     char buf[PLAIN_BUF_SIZE];
> >
> > -     err =3D plain_hash();
> > -     if (err) {
> > -             tc_fail("plain 'p' does not appear to be hashed");
> > -             return;
> > -     }
> > +     plain_hash_to_buffer(kunittest, PTR, buf, PLAIN_BUF_SIZE);
> >
> > -     err =3D plain_format();
> > -     if (err) {
> > -             tc_fail("hashing plain 'p' has unexpected format");
> > -     }
> > +     /*
> > +      * We can't use test() to test %p because we don't know what outp=
ut to expect
> > +      * after an address is hashed.
> > +      */
>
> The code does not longer print a reasonable error message on failure.
> I would extend the comment to make it easier to understand the
> meaning. Also I would use the imperative style. Something like:
>
>         /*
>          * The hash of %p is unpredictable, therefore test() cannot be us=
ed.
>          * Instead, verify that the first 32 bits are zeros on a 64-bit s=
ystem,
>          * and confirm the non-hashed value is not printed.
>          */

I'll make this change. Note that this comment isn't changing here, it
only appears to be because its indentation changed.

> > +
> > +     KUNIT_EXPECT_MEMEQ(kunittest, buf, ZEROS, strlen(ZEROS));
> > +     KUNIT_EXPECT_MEMNEQ(kunittest, buf+strlen(ZEROS), PTR_STR, PTR_WI=
DTH);
>
> This looks wrong. It should be either:
>
>         KUNIT_EXPECT_MEMNEQ(kunittest, buf, PTR_STR, PTR_WIDTH);
>
> or
>
>         KUNIT_EXPECT_MEMNEQ(kunittest,
>                             buf + strlen(ZEROS),
>                             PTR_STR + strlen(ZEROS),
>                             PTR_WIDTH - strlen(ZEROS));
>
> I would use the 1st variant. It is easier and it works the same way
> as the original check.

Ah, I see. Done as you ask.

>
> Anyway, it is a great clean up of the pointer tests. I have wanted to do =
it
> since a long time but I never found time.

Thanks!

> >  }
> >
> >  static void
> > -test_hashed(const char *fmt, const void *p)
> > +test_hashed(struct kunit *kunittest, const char *fmt, const void *p)
> >  {
> >       char buf[PLAIN_BUF_SIZE];
> > -     int ret;
> >
> > -     /*
> > -      * No need to increase failed test counter since this is assumed
> > -      * to be called after plain().
> > -      */
> > -     ret =3D plain_hash_to_buffer(p, buf, PLAIN_BUF_SIZE);
> > -     if (ret)
> > -             return;
> > +     plain_hash_to_buffer(kunittest, p, buf, PLAIN_BUF_SIZE);
> >
> >       test(buf, fmt, p);
> >  }
> > @@ -739,11 +664,9 @@ flags(void)
> >                                                       (unsigned long) g=
fp);
> >       gfp |=3D __GFP_HIGH;
> >       test(cmp_buffer, "%pGg", &gfp);
> > -
> > -     kfree(cmp_buffer);
>
> I belive that the kfree() should stay. Otherwise, the test leaks memory
> in every run.

This memory is now allocated using `kunit_kmalloc`:

>  * kunit_kmalloc() - Like kmalloc() except the allocation is *test manage=
d*.
> [...]
>  * See kmalloc() and kunit_kmalloc_array() for more information.

`kunit_kmalloc_array`:

> * Just like `kmalloc_array(...)`, except the allocation is managed by the=
 test case
> * and is automatically cleaned up after the test case concludes. See kuni=
t_add_action()
> * for more information.

So this kfree is not necessary.

>
> >  }
> >
> > -static void fwnode_pointer(void)
> > +static void fwnode_pointer(struct kunit *kunittest)
> >  {
> >       const struct software_node first =3D { .name =3D "first" };
> >       const struct software_node second =3D { .name =3D "second", .pare=
nt =3D &first };
>
> Otherwise, it looks good to me.
>
> Best Regards,
> Petr

