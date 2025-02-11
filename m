Return-Path: <linux-kselftest+bounces-26355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82810A30AA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 12:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51AA6161A96
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 11:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615F91FBC85;
	Tue, 11 Feb 2025 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mq+ccVGL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2609A1F942D;
	Tue, 11 Feb 2025 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739274348; cv=none; b=F3Pe+cPGV4zKgIHLKIa4E9nVgRabMjGXqyMTP2Bg6jJLwncTt+DPbNPbCVdqndiKt5s9mNRhCcTNtCkGd5cYOFPLP43E4lAGXAG4YYu1f9REYj5j3yFWJanbfiiMrW2/ou9/KwtMfyvqVs7LLPsj8+4nDqb6a+vEewqPtKFWrJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739274348; c=relaxed/simple;
	bh=T3Vp7vUqx1OtGg3x7nh+pW+A11uxUE/U8Iv+xWaDeJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVxgfT3/InshbnhZSMtGAvwLZ+WeGjIhFXZXPfOJa6ixCZuRy/DWEKhorUF2Ad7fYUDqX2WkN7YDIZYQsXnWLJP3hFMG6VvGmVeuoyxKtD8YHuOwmqHXnQEpF330htKDfy9SH0lCavQ877yewMmiIg8qwi7ag1CYIbSjrnbcopY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mq+ccVGL; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5450475df04so3316951e87.0;
        Tue, 11 Feb 2025 03:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739274344; x=1739879144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLeIAK0yrRErJ2yCVLvDjXnsrf5KEMDWRHqk8rKgwo0=;
        b=mq+ccVGL0R36TQt6sQsQIEMLpFBGByXemhd3ed+tppiWW+sh2iI0I572Fp24RAVB2R
         NCSIk2ITgK/xRj/5wViXQI7p0ELvVgkdPgBjeTXgdZmT+xYzFCk5Qm6gi0IuFzAKHsDq
         CZ1kIB1tmvCkVKV4pFI8ldzhoNF63rK3LQRrLJFhlZdafgWy77eV4+ArLaY+QXLRpk9M
         ypBy976PBKKY//Br/7i+74L1gQfBIOyLYVdHXvCBEY5pt6kMOU8q5nP3awQhPOb5sWIc
         +zL8pt/Xk0nKF9u2ZvKY/h4AgFoBDpiLnWGIHJhkUsgaw45o7WATYU8iyhS72VUCfX08
         Bbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739274344; x=1739879144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLeIAK0yrRErJ2yCVLvDjXnsrf5KEMDWRHqk8rKgwo0=;
        b=Mhu3brbyKIR/ND0SNXw3bDBhjGVKu4EgxtPiYBCxWoJiJF8Y38q0zNKnPfxsCeCA7g
         GvQJVChlkZLfHWIayxLl/LJaV0NR3XCYgAJ0Fix6cDk0We3KubqSt4GB7nsrGIiqJSnN
         jKAssacjSRc4VEJpbvgLukiBG0Q7MXDww+1e3OAvc0h2EYO+1vfzuseI+ky28Ez0NPRa
         XP4Od5lLLtUnyRQ7LPzCdJbd3rOuqmQJGB819xhRZGkvi3e5nQHhvFqU9+ARTXciKHAQ
         +6Gox57XJRdKWt+z4EcDPFRfy4EUsexr/5VITuoFXo8pEkOOm7xKeyGgS8Awc1PksT06
         CriA==
X-Forwarded-Encrypted: i=1; AJvYcCUIIjV83HFYh5G0blVuiEXU8u6efeWo7ySdl/cXpvlXN6FN/z/bGmgZWUslBAW0mVGaoWkYGtjciXcc96s=@vger.kernel.org, AJvYcCVePAsFvJqGLghXy/KxPmioyQwm91r585c5CpBOlr3HxJYjJS6juST+53DfLLdN/31qRaW/BvQzOa9Tho4pERJV@vger.kernel.org
X-Gm-Message-State: AOJu0YwPD0bqyDdrTeYcEQopxoKoNrN3xyKIXQph4Re8SVYeXEil44Ax
	YJRNYmkGSEjpP+r9VYe7zKE/1RTBo5/8KNCEegO15P7lGJUOmLMDiLJ41OFj3h+xdWZ4QxM4U8O
	UB3cltuXKildXNMeIs/dxbrmNuQM=
X-Gm-Gg: ASbGncv3TQj6hpDFKxz++GpRZv4w+cAeOCgzRG50E6g1kf/AoKkWl5I5uTRvCwehIqf
	ayVzhNq1tt+4L+Jk/FlKB/rPjCaOwDWpt736Ums0YqZ3PmLhV5PdRevmeDCDZ3i3tt1b/dn7WYD
	po9qgDOPe27olOjueos0vsoqWwq8+6
X-Google-Smtp-Source: AGHT+IH9sFZjIbF2hYddFB9pjj9cde2EFIwaWIiUqulEgH9EY3el1EGkLz6wONU3+Zru+3ajUKBAguq/FWtTMyhUkKs=
X-Received: by 2002:a05:6512:3b2b:b0:545:5f0:9536 with SMTP id
 2adb3069b0e04-54505f09661mr3793110e87.50.1739274343842; Tue, 11 Feb 2025
 03:45:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-scanf-kunit-convert-v6-0-4d583d07f92d@gmail.com>
 <20250210-scanf-kunit-convert-v6-1-4d583d07f92d@gmail.com> <Z6s2eqh0jkYHntUL@pathway.suse.cz>
In-Reply-To: <Z6s2eqh0jkYHntUL@pathway.suse.cz>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Feb 2025 06:45:07 -0500
X-Gm-Features: AWEUYZlGPfUAOlpqNmwSRLp7J7Yo_ttfhA07BXvloBntEtzB1syfdskMus6S3KA
Message-ID: <CAJ-ks9n5=FYiFdmzWCkkACzX6oEVs=Z261_ZAKVq3tkqgJoSCQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] scanf: convert self-test to KUnit
To: Petr Mladek <pmladek@suse.com>
Cc: David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 6:37=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Mon 2025-02-10 13:13:48, Tamir Duberstein wrote:
> > Convert the scanf() self-test to a KUnit test.
> >
> > In the interest of keeping the patch reasonably-sized this doesn't
> > refactor the tests into proper parameterized tests - it's all one big
> > test case.
> >
> > Acked-by: Petr Mladek <pmladek@suse.com>
>
> Please, remove this. The patchset has changed a lot and it is not
> longer true.

Will do.

>
> > --- a/lib/test_scanf.c
> > +++ b/lib/scanf_kunit.c
> > @@ -15,67 +13,49 @@
> [...]
> >  #define _check_numbers_template(arg_fmt, expect, str, fmt, n_args, ap)=
               \
> >  do {                                                                  =
       \
> > -     pr_debug("\"%s\", \"%s\" ->\n", str, fmt);                       =
       \
> > +     kunit_printk(KERN_DEBUG, test, "\"%s\", \"%s\" ->", str, fmt);  \
>
> The switch from pr_debug() to kunit_printk() causes printing huge
> amount of messages even when the test passes.

I'm not able to reproduce this. pr_debug expands to printk(KERN_DEBUG,
...) which is also what kunit_printk(KERN_DEBUG, ...) expands to. Can
you help me understand how you're testing?

> [ 5780.664377] KTAP version 1
> [ 5780.664891] 1..1
> [ 5780.665376]     KTAP version 1
> [ 5780.665765]     # Subtest: scanf
> [ 5780.666104]     # module: scanf_kunit
> [ 5780.666112]     1..10
> [ 5780.667354]     # numbers_simple: "0", "%llu" ->
> [ 5780.667371]     # numbers_simple:    0
> [ 5780.667923]     # numbers_simple: "0", "%llu" ->
> [ 5780.668321]     # numbers_simple:    0
> [ 5780.668803]     # numbers_simple: "1", "%llu" ->
> [ 5780.669175]     # numbers_simple:    1
> [ 5780.669624]     # numbers_simple: "18446744073709551615", "%llu" ->
>
> [... skipping 7500+ lines ...]
>
> [ 5783.157777]     # test_simple_strtol: simple_strtol("0x7ffffffffffffff=
f", 0) -> 0x7fffffffffffffff
> [ 5783.158229]     # test_simple_strtol: simple_strtol("0x800000000000000=
1", 0) -> 0x8000000000000001
> [ 5783.158683]     # test_simple_strtol: simple_strtol("0x800000000000000=
0", 0) -> 0x8000000000000000
> [ 5783.159131]     # test_simple_strtol: simple_strtol("0x800000000000000=
0", 0) -> 0x8000000000000000
> [ 5783.159586]     # test_simple_strtol: simple_strtol("0x800000000000000=
1", 0) -> 0x8000000000000001
> [ 5783.160048]     # test_simple_strtol: simple_strtol("0x7ffffffffffffff=
f", 0) -> 0x7fffffffffffffff
> [ 5783.160506]     # test_simple_strtol: simple_strtol("0xfffffffffffffff=
e", 0) -> 0xfffffffffffffffe
> [ 5783.160957]     # test_simple_strtol: simple_strtol("0x2", 0) -> 0x2
> [ 5783.161467]     # test_simple_strtol: simple_strtol("0xfffffffffffffff=
f", 0) -> 0xffffffffffffffff
> [ 5783.161806]     # test_simple_strtol: simple_strtol("0x1", 0) -> 0x1
> [ 5783.162564]     ok 10 test_simple_strtol
> [ 5783.163145] # scanf: pass:10 fail:0 skip:0 total:10
> [ 5783.163537] # Totals: pass:22 fail:0 skip:0 total:22
> [ 5783.164052] ok 1 scanf
>
>
> Yes, it would help with debugging. But we should print these details
> only when the test fails!
>
> Partial solution might be to use pr_debug(). The messages will be
> disabled by default and can be enabled via /sys/kernel/debug/dynamic_debu=
g/control
>
> Here is some POC:
>
> From 7ea79fd67c4a7d8dff9d9fa986bb8dc037087c47 Mon Sep 17 00:00:00 2001
> From: Petr Mladek <pmladek@suse.com>
> Date: Tue, 11 Feb 2025 12:24:40 +0100
> Subject: [POC] kunit/scanf_knunit: Add kunit_debug() to allow using the
>  dynamic debug facility
>
> Do not fill the kernel logbuffer with debug messages by default.
> Allow to enable them via /sys/kernel/debug/dynamic_debug/control
>
> The question is whether we want to print them into the kunit log.
>
> FIXME: This use just a POC. The right solution should reduce
>        cut&paste.
> ---
>  include/kunit/test.h | 30 ++++++++++++++++++++++++++++++
>  lib/scanf_kunit.c    |  6 +++---
>  2 files changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 58dbab60f853..23fa3d6b3735 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -637,6 +637,36 @@ void __printf(2, 3) kunit_log_append(struct string_s=
tream *log, const char *fmt,
>  #define kunit_err(test, fmt, ...) \
>         kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
>
> +/*
> + * pr_debug and log to per-test or per-suite log buffer.  Logging only d=
one
> + * if CONFIG_KUNIT_DEBUGFS is 'y'; if it is 'n', no log is allocated/use=
d.
> + *
> + * The special variant is needed to allow using the printk dynamic debug
> + * infrastructure, see CONFIG_DYNAMIC_DEBUG.
> + */
> +#define kunit_log_debug(test_or_suite, fmt, ...)                       \
> +       do {                                                            \
> +               pr_debug(fmt, ##__VA_ARGS__);                           \
> +               kunit_log_append((test_or_suite)->log,  fmt,            \
> +                                ##__VA_ARGS__);                        \
> +       } while (0)
> +
> +#define kunit_printk_debug(test, fmt, ...)                             \
> +       kunit_log_debug(test, KUNIT_SUBTEST_INDENT "# %s: " fmt,        \
> +                 (test)->name, ##__VA_ARGS__)
> +
> +/**
> + * kunit_debug() - Prints an DEBUG level message associated with @test.
> + *
> + * @test: The test context object.
> + * @fmt:  A printk() style format string.
> + *
> + * Prints an error level message.
> + */
> +#define kunit_debug(test, fmt, ...) \
> +       kunit_printk_debug(test, fmt, ##__VA_ARGS__)
> +
> +
>  /*
>   * Must be called at the beginning of each KUNIT_*_ASSERTION().
>   * Cf. KUNIT_CURRENT_LOC.
> diff --git a/lib/scanf_kunit.c b/lib/scanf_kunit.c
> index 7e2e7d891e41..e45f3c4f0437 100644
> --- a/lib/scanf_kunit.c
> +++ b/lib/scanf_kunit.c
> @@ -42,10 +42,10 @@ _test(struct kunit *test, check_fn fn, const void *ch=
eck_data, const char *strin
>
>  #define _check_numbers_template(arg_fmt, expect, str, fmt, n_args, ap)  =
       \
>  do {                                                                    =
       \
> -       kunit_printk(KERN_DEBUG, test, "\"%s\", \"%s\" ->", str, fmt);  \
> +       kunit_debug(test, "\"%s\", \"%s\" ->", str, fmt);       \
>         for (; n_args > 0; n_args--, expect++) {                         =
       \
>                 typeof(*expect) got =3D *va_arg(ap, typeof(expect));     =
         \
> -               kunit_printk(KERN_DEBUG, test, "\t" arg_fmt, got);       =
       \
> +               kunit_debug(test, "\t" arg_fmt, got);           \
>                 KUNIT_EXPECT_EQ_MSG(test, got, *expect,                  =
       \
>                                     "vsscanf(\"%s\", \"%s\", ...)", str, =
fmt);  \
>         }                                                                =
       \
> @@ -677,7 +677,7 @@ do {                                                 =
                               \
>                                                                          =
       \
>         len =3D snprintf(test_buffer, BUF_SIZE, gen_fmt, expect);        =
         \
>         got =3D (fn)(test_buffer, &endp, base);                          =
         \
> -       kunit_printk(KERN_DEBUG, test, #fn "(\"%s\", %d) -> " gen_fmt, te=
st_buffer, base, got); \
> +       kunit_debug(test, #fn "(\"%s\", %d) -> " gen_fmt, test_buffer, ba=
se, got); \
>         if (got !=3D (expect)) {                                         =
         \
>                 KUNIT_FAIL(test, #fn "(\"%s\", %d): got " gen_fmt " expec=
ted " gen_fmt, \
>                            test_buffer, base, got, expect);              =
       \
> --
> 2.48.1
>
>
> But when thinking more about it. I think that even pr_debug() is not
> the right solution.
>
> IMHO, we really want to print these details only when the test fails.
>
> Best Regards,
> Petr

If you use one of the kunit userspace helpers, you will only see the
output when the test fails. Having said that, in my local testing I
don't see the KERN_DEBUG prints locally. I had to run with
ignore_loglevel to see them at all.

