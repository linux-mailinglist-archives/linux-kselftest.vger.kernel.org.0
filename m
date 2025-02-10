Return-Path: <linux-kselftest+bounces-26174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC50A2F001
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 15:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8DB166940
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 14:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04278237717;
	Mon, 10 Feb 2025 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu4kvVRs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D6D1F8BCD;
	Mon, 10 Feb 2025 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739198242; cv=none; b=uL/YZMu72VMQXt91DYeYH1/9rzX3M2hmPfsFC9LM8yUOHElSvnUxUOILcry1KSudZ5kDS9VLgKYrUp25gCv9NWmKQyB72fFjUWRZZiYPMJizl2UQJtll2ZUtUAZHuwX9rv+tPSrCzRNoo0Kx2kEY074cjSssNrxyA7tb+qWEGa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739198242; c=relaxed/simple;
	bh=WABggrDl+6XcDPR7LJQJRVd34bIgd1ja9UBul5F7oO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdB/Xi1gYb5xhpTG1i0ZHx+Q1/Casnd4bmVFz597p/S2n+siLQGwFiTo0L2bTeMZW+io7C7E1JcPl5TPawskDwFd212CGGg/3ah89LaQZWzfXfdOjg6AQYePoNr60jb1oI/T/mR44qZD2BDl0gnF2qow9Jg1cIosU6LyC/et554=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cu4kvVRs; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30737db1ab1so40170041fa.1;
        Mon, 10 Feb 2025 06:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739198238; x=1739803038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s80mFWRzJg0+ihTVB33GqIgTKxFbiYbst0uhq40Ik08=;
        b=Cu4kvVRs+VjA7Txjmr+wAv9lIAuVVxfx+lGTX6kcpaMpFyi5DC8IW8YzIrVRLzb1PP
         pDA4jKchIv4uNydbzx6KHfrt/h+mPlabYAWCUJXqpKXBYNpIJWFHPGqUKMAWb4PK3q/5
         +6dx2nXvnawSNl3+UkE+RemfxUO2hK4c/u3tOwAZHc3SlXiyA3e8NL/ziAyWsstx1CYp
         g4V/T8cGptK4ygZFDW4SsYEGIpBwojMokgNzZt2Hj3tSvbCJzovSmNLl/pdUMZ57d/Ny
         3+y13CXZcbzdkNj5c4b9uRU9l2dRAJWRQ2O9FkZs1ucpKlDj+xzcAxnUAIVgVyIsu91p
         XYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739198238; x=1739803038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s80mFWRzJg0+ihTVB33GqIgTKxFbiYbst0uhq40Ik08=;
        b=e3a7anSa34mRrqsf9l/FjZr3SuEM17PbtrfjG+Yi4Bkulzlbxz4mvGOo4HT5Ps8bkW
         r+PqAnFoZ87EsqfS9a0ezhwjQ+gQuVQ6OxOf5FE7k+j2sZcYjXzCoZYx1U31Vv/Y/4m1
         FCuOnkdcqS7TDrbf5SJMzQEAk1yZg2foAHylFmOJy7wNbZbHSo92BbFPpYIdeCGb7azK
         N6D4EqkR//iqGAqMNah0KKw3DsVaOIwvj0yaOv8d0J9HmLwWs9F5GSzN9lfCB5l1ob1F
         fB4w3L1YzsW9DeeUhjF0KJEhlJ7QCbT88qbU/TtzNozzofr+DZceq8kzihGehOgzzSQx
         Syow==
X-Forwarded-Encrypted: i=1; AJvYcCVnY9imOJViKNQq6PajyZk8wGjGtzfTkX1IlAnug7WHjW58wfUJ+m2W76owmO5VBAXkG4eNhpxvufS+i68=@vger.kernel.org, AJvYcCVy6kyrD2jsuV5nG8o0sEIur658TWX96Pm0DUeZPNsQgeoSs+5rwS0hj+w7nvZ9Fv/Q9qTqad7WfFMWOwswCKxL@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ4qLlB2ZZpH0o0Qw+IIT8ofVHnQ5GVSjUnvTVkulj9mPjXeqk
	WPOFCy/EvqN10FdxLtbDEf2Dwe4ltG0CylMclj6893CXl8A8Q5xwmCN/ONS05SMPHqZMA3xwb9Q
	CsZMibpP+x2XhQCRHCyN3633uD2M=
X-Gm-Gg: ASbGnct17gkq+Jq8WsklVZycRAjsEjBk7g0P19qM1/odE5IvLqTdkO+D8+8z2Yx7gSz
	mi8eaO1ay9TS4H0s0z01OGqIF0Yy5IY9d535LcWaYNJLmGUoZF3tp0ndnM9Qy7et61G0MrTVYYf
	ntl6ktZHT3VDZZ
X-Google-Smtp-Source: AGHT+IGH0XnJppescO6Iu/iZvdvCVrvlDbYFvv6BiC8GRaZZyrQgs4UKn0i1WrvjUfKk9WI/UkRgp2380s680qQ0ohU=
X-Received: by 2002:a05:651c:514:b0:2fb:5035:a03 with SMTP id
 38308e7fff4ca-307e57ce236mr52075261fa.14.1739198237389; Mon, 10 Feb 2025
 06:37:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-printf-kunit-convert-v2-0-057b23860823@gmail.com>
 <20250207-printf-kunit-convert-v2-1-057b23860823@gmail.com> <87tt92q7hw.fsf@prevas.dk>
In-Reply-To: <87tt92q7hw.fsf@prevas.dk>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 10 Feb 2025 09:36:41 -0500
X-Gm-Features: AWEUYZmADyNTxOepjox0OkGwD6ORA1jVrCOeXh_ZlJYyc2QDKyzof_riUKDIB8w
Message-ID: <CAJ-ks9=SEBCZiuq2YE3Uj5wJ4Pv+78W-VBTeV7CSzLYJZqsR8Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] printf: convert self-test to KUnit
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Arpitha Raghunandan <98.arpi@gmail.com>, David Gow <davidgow@google.com>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 8:01=E2=80=AFAM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On Fri, Feb 07 2025, Tamir Duberstein <tamird@gmail.com> wrote:
>
> [...]
>
> If/when you do re-roll a v3, can you split the defconfig changes off to
> a separate patch? It's a little annoying to scroll through all those
> mechanical one-liner diffs to get to the actual changes.

Yep. I'll split them into one for m68k and another for powerpc. Geert,
I'll move your Acked-by to the m68k patch.

> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 1af972a92d06..4834cac1eb8f 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2427,6 +2427,23 @@ config ASYNC_RAID6_TEST
> >  config TEST_HEXDUMP
> >       tristate "Test functions located in the hexdump module at runtime=
"
> >
> > +config PRINTF_KUNIT_TEST
> > +     tristate "KUnit test printf() family of functions at runtime" if =
!KUNIT_ALL_TESTS
> > +     depends on KUNIT
> > +     default KUNIT_ALL_TESTS
> > +     help
> > +       Enable this option to test the printf functions at boot.
> > +
>
> Well, not necessarily at boot unless built-in?
>
> > +       KUnit tests run during boot and output the results to the debug=
 log
> > +       in TAP format (http://testanything.org/). Only useful for kerne=
l devs
> > +       running the KUnit test harness, and not intended for inclusion =
into a
> > +       production build.
> > +
> > +       For more information on KUnit and unit tests in general please =
refer
> > +       to the KUnit documentation in Documentation/dev-tools/kunit/.
> > +
> > +       If unsure, say N.
> > +
>
> I see that this is copy-pasted from other kunit config items, but not
> all of them have all this boilerplate, and I don't think it's useful
> (and, the mentions of "at boot" and "during boot" are actively
> misleading). Other kunit config items are shorter and more to the point,
> e.g.
>
>           Enable this to turn on 'list_sort()' function test. This test i=
s
>           executed only once during system boot (so affects only boot tim=
e),
>           or at module load time.
>
>           If unsure, say N.
>

Very good point. Truthfully this boilerplate is a result of
checkpatch.pl nagging about this paragraph being a certain length.
I'll drop it and just write "Enable this option to test the printf
functions at runtime.".

> >
> >  obj-$(CONFIG_TEST_BITMAP) +=3D test_bitmap.o
> > diff --git a/lib/test_printf.c b/lib/printf_kunit.c
> > similarity index 89%
> > rename from lib/test_printf.c
> > rename to lib/printf_kunit.c
> > index 59dbe4f9a4cb..fe6f4df92dd5 100644
> > --- a/lib/test_printf.c
> > +++ b/lib/printf_kunit.c
> > @@ -5,7 +5,7 @@
> >
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >
> > -#include <linux/init.h>
> > +#include <kunit/test.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/printk.h>
> > @@ -25,8 +25,6 @@
> >
> >  #include <linux/property.h>
> >
> > -#include "../tools/testing/selftests/kselftest_module.h"
> > -
> >  #define BUF_SIZE 256
> >  #define PAD_SIZE 16
> >  #define FILL_CHAR '$'
> > @@ -37,72 +35,71 @@
> >       block \
> >       __diag_pop();
> >
> > -KSTM_MODULE_GLOBALS();
> > +static char *test_buffer;
> > +static char *alloced_buffer;
> > +
> > +static struct kunit *kunittest;
> >
> > -static char *test_buffer __initdata;
> > -static char *alloced_buffer __initdata;
> > +#define tc_fail(fmt, ...) \
> > +     KUNIT_FAIL(kunittest, fmt, ##__VA_ARGS__)
> >
> > -static int __printf(4, 0) __init
> > +static void __printf(4, 0)
> >  do_test(int bufsize, const char *expect, int elen,
> >       const char *fmt, va_list ap)
> >  {
> >       va_list aq;
> >       int ret, written;
> >
> > -     total_tests++;
> > -
> >       memset(alloced_buffer, FILL_CHAR, BUF_SIZE + 2*PAD_SIZE);
> >       va_copy(aq, ap);
> >       ret =3D vsnprintf(test_buffer, bufsize, fmt, aq);
> >       va_end(aq);
> >
> >       if (ret !=3D elen) {
> > -             pr_warn("vsnprintf(buf, %d, \"%s\", ...) returned %d, exp=
ected %d\n",
> > +             tc_fail("vsnprintf(buf, %d, \"%s\", ...) returned %d, exp=
ected %d\n",
> >                       bufsize, fmt, ret, elen);
> > -             return 1;
> > +             return;
> >       }
> >
> >       if (memchr_inv(alloced_buffer, FILL_CHAR, PAD_SIZE)) {
> > -             pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote before buf=
fer\n", bufsize, fmt);
> > -             return 1;
> > +             tc_fail("vsnprintf(buf, %d, \"%s\", ...) wrote before buf=
fer\n", bufsize, fmt);
> > +             return;
> >       }
> >
> >       if (!bufsize) {
> >               if (memchr_inv(test_buffer, FILL_CHAR, BUF_SIZE + PAD_SIZ=
E)) {
> > -                     pr_warn("vsnprintf(buf, 0, \"%s\", ...) wrote to =
buffer\n",
> > +                     tc_fail("vsnprintf(buf, 0, \"%s\", ...) wrote to =
buffer\n",
> >                               fmt);
> > -                     return 1;
> >               }
> > -             return 0;
> > +             return;
> >       }
> >
> >       written =3D min(bufsize-1, elen);
> >       if (test_buffer[written]) {
> > -             pr_warn("vsnprintf(buf, %d, \"%s\", ...) did not nul-term=
inate buffer\n",
> > +             tc_fail("vsnprintf(buf, %d, \"%s\", ...) did not nul-term=
inate buffer\n",
> >                       bufsize, fmt);
> > -             return 1;
> > +             return;
> >       }
> >
> >       if (memchr_inv(test_buffer + written + 1, FILL_CHAR, bufsize - (w=
ritten + 1))) {
> > -             pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the=
 nul-terminator\n",
> > +             tc_fail("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the=
 nul-terminator\n",
> >                       bufsize, fmt);
> > -             return 1;
> > +             return;
> >       }
> >
> >       if (memchr_inv(test_buffer + bufsize, FILL_CHAR, BUF_SIZE + PAD_S=
IZE - bufsize)) {
> > -             pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond buf=
fer\n", bufsize, fmt);
> > -             return 1;
> > +             tc_fail("vsnprintf(buf, %d, \"%s\", ...) wrote beyond buf=
fer\n", bufsize, fmt);
> > +             return;
> >       }
> >
> >       if (memcmp(test_buffer, expect, written)) {
> > -             pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expe=
cted '%.*s'\n",
> > +             tc_fail("vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expe=
cted '%.*s'\n",
> >                       bufsize, fmt, test_buffer, written, expect);
> > -             return 1;
> > +             return;
> >       }
> > -     return 0;
> >  }
> >
> > -static void __printf(3, 4) __init
> > +static void __printf(3, 4)
> >  __test(const char *expect, int elen, const char *fmt, ...)
> >  {
> >       va_list ap;
> > @@ -110,9 +107,8 @@ __test(const char *expect, int elen, const char *fm=
t, ...)
> >       char *p;
> >
> >       if (elen >=3D BUF_SIZE) {
> > -             pr_err("error in test suite: expected output length %d to=
o long. Format was '%s'.\n",
> > -                    elen, fmt);
> > -             failed_tests++;
> > +             tc_fail("error in test suite: expected output length %d t=
oo long. Format was '%s'.\n",
> > +                     elen, fmt);
> >               return;
> >       }
> >
> > @@ -124,19 +120,17 @@ __test(const char *expect, int elen, const char *=
fmt, ...)
> >        * enough and 0), and then we also test that kvasprintf would
> >        * be able to print it as expected.
> >        */
> > -     failed_tests +=3D do_test(BUF_SIZE, expect, elen, fmt, ap);
> > +     do_test(BUF_SIZE, expect, elen, fmt, ap);
> >       rand =3D get_random_u32_inclusive(1, elen + 1);
> >       /* Since elen < BUF_SIZE, we have 1 <=3D rand <=3D BUF_SIZE. */
> > -     failed_tests +=3D do_test(rand, expect, elen, fmt, ap);
> > -     failed_tests +=3D do_test(0, expect, elen, fmt, ap);
> > +     do_test(rand, expect, elen, fmt, ap);
> > +     do_test(0, expect, elen, fmt, ap);
> >
> >       p =3D kvasprintf(GFP_KERNEL, fmt, ap);
> >       if (p) {
> > -             total_tests++;
> >               if (memcmp(p, expect, elen+1)) {
> > -                     pr_warn("kvasprintf(..., \"%s\", ...) returned '%=
s', expected '%s'\n",
> > +                     tc_fail("kvasprintf(..., \"%s\", ...) returned '%=
s', expected '%s'\n",
> >                               fmt, p, expect);
> > -                     failed_tests++;
> >               }
> >               kfree(p);
> >       }
>
> So reading through this, is there really any reason to drop those
> existing total_tests and failed_tests tallies? Since you do need to keep
> the control flow the same, leaving the return types and "return
> 1"/"return 0" and their uses in updating failed_tests would also reduce
> the patch size quite significantly.
>
> So they no longer come from some KSTM_MODULE_GLOBALS(), and thus need to
> be explicitly declared in this module, but that's exactly how it was
> originally until someone decided to lift that from the the printf suite
> to kstm.
>
> Yes, they'd need to be explicitly initialized to 0 during kunit_init
> since they are no longer use-once __initdata variable, and some
> kunit_exit logic would need to "manually" report them.

If I understand your concern correctly, you only really care about
`total_tests`, right? I think it's slightly unidiomatic to count tests
outside the framework this way but it's not a hill I'll die on.

Just to elaborate on why I think this unidiomatic: the KUnit test
runner script that produces human-readable output doesn't emit logs
unless something fails. In the success case, you'd get (before the
next patch that breaks this into many tests):

[09:34:15] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D pri=
ntf (1 subtest)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[09:34:15] [PASSED] printf_test
[09:34:15] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
[PASSED] printf
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[09:34:15] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[09:34:15] Testing complete. Ran 1 tests: passed: 1

but the raw output does contain the tally:

KTAP version 1
1..1
    KTAP version 1
    # Subtest: printf
    # module: printf_kunit
    1..1
    ok 1 printf_test
    # printf: ran 448 tests
ok 1 printf

So assuming you're OK with this compromise, I'll go ahead and spin v3.

Thanks for the review!

