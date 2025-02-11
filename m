Return-Path: <linux-kselftest+bounces-26393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90329A310D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 17:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF8B188CA09
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F24253F3B;
	Tue, 11 Feb 2025 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1m2MHhL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1380D253B5B;
	Tue, 11 Feb 2025 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290163; cv=none; b=LMEXttQ3/otHTQ6XOtHWgvRk6gXC3Fn1YvSnAs4i0e/R/P0sEXKA5sxaQ5IENroOq/CNwAq9zRSFIdgvJKozOl95gj1dSOWR2m/dokjB6/V70wiLDWH17HbQ3OIBIyNnP2W9Hmj5pB4yJZNzU+jWExUp7o3Q4OXgos1uWdOLixw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290163; c=relaxed/simple;
	bh=uVTzjIRuB9GzXG4XoIgIaoGzN7vXHDZUswRWlY2NEy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jX7Bee137n6097FOTpAc0rAsBB/VX8cN3ngSQ/JI4rRL68ydG1Tm3ipZBO1zICjCeEjlce24Z25p4ByCikcq6RomnN3ejoccsFlJNH7bWlnqV6Bebr8OCinLJ8e+Lfuq4KQgGX+7ikE8tRSaQq9Wg9bJkudaLDZaqohr20tI7qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1m2MHhL; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-308f53aef4fso15672481fa.0;
        Tue, 11 Feb 2025 08:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739290158; x=1739894958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wggzSEy/aJABx2YwMPxa320+4QSUVeDKPBn2O/Cn2QA=;
        b=P1m2MHhLK+KA5b1snqa6S97SHBdJ+b9iFRLTxFOCe2kzehm/GBhio8lu0Tk7UmLA3g
         4H584xWqZbYG3lZTE9g0xKhG4QJLELdqjL+rUMBDgzx1Y44Pdp7Ao6z9tdk0MNVwQX8h
         GZOmwjol4zUxUsWBWz9pvUhfFtJ9yICTOL6pqj5jgquByaV6c6qCDH9IblKLbZoWXZK5
         xdlN9HY9thtBKNEkUlqysUIK+Xj/VaNnAOaNNsa6d67KasD6pjIcoyhMi2Ok0SrloYJr
         rv9HSehUQAEEPQMDC6CeXkm7LI12ILoyBmXzFXq5UfGQgeb9zfCDEMl5KKWZX36reJ7L
         ZS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739290158; x=1739894958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wggzSEy/aJABx2YwMPxa320+4QSUVeDKPBn2O/Cn2QA=;
        b=tzXfZh1scm+jm9b8WVbCOQqJBB47DoCGCFlx61ijnQ9c+2qH9hL1w+Z9rFOcHyNDZC
         VWCX2bGSzIp2RRjIjkltFTKSkDpxTjM1OZ8JvlfaCOMyFb4yqOaMFYFGm6UHJxEbuSIb
         yOwVm0klfhyLVtescuOEtsCsiphISSENFE/lx67Q9IlksCq9weXoVKr8bn464cRO1OzJ
         a5eNp676TMjiZcu0+KjjyOQj/jat6stPkAMGIn+h4YHEPf+CKJDujKU1Js8IPeOlBZ24
         Gu0/OG8kCllZ/GOp+3vOS2OKEpe1DYoIGeveuHOhOVv8rzCBaJfTj134rn5vtJ98tV2t
         iL9w==
X-Forwarded-Encrypted: i=1; AJvYcCXGUd/uxdTtegQXMWldDkWMg9zJm9gdEoUCXC5xA6s79qqDaSmebsE3iD0+7I4zuV/DUIh5vYejcUIOQps=@vger.kernel.org, AJvYcCXa0XKlbrYVI8SGj/e0QlxYqh+bJ/ZOfD2jt8DpGlJrQM6yFSld6I8eJLGOsMhO6+IU6/WlTEV/LNWxuHpw5RTd@vger.kernel.org
X-Gm-Message-State: AOJu0YzOUgXAtxqkjn9FhCj7tTftZZDJWRadLJ9Iv08kOSMvbf5DN6Vm
	QHTHLBDVk7gRYrVZrWQ1lTnoc8WeE/0z8M7FNokk7FmZ7r7TveqEJHxy7aFdwfQta7HdobUzpkB
	hjrxd8rqnoWIbAsZJUIZ6y1uSQNQ=
X-Gm-Gg: ASbGnctL1ED0Q6ZuWcxd6L9ktYXUgcwGw3w3K8zs97sCn0U0AXCQt1fllgdKLrCn6ZZ
	U394DkUt28Ecvunsdad3xIXZaNepXBVSnvhXDoQQkNgy/c8dHQ1zh4E5jTPOH3hwQBnXhaZ9mU4
	tQm6Z+5cqDdNC9
X-Google-Smtp-Source: AGHT+IHFVQLBAyPQTyyGR//j4uHAGjTQ5GxjwodV0fAUgmgKdj2iAj9aD1VIq/iVdt/2jb0A0EOk5OdrUMFGBHDzO3Y=
X-Received: by 2002:a05:651c:4ca:b0:302:3e14:34c8 with SMTP id
 38308e7fff4ca-3090367d768mr484011fa.22.1739290157836; Tue, 11 Feb 2025
 08:09:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-scanf-kunit-convert-v6-0-4d583d07f92d@gmail.com>
 <20250210-scanf-kunit-convert-v6-1-4d583d07f92d@gmail.com>
 <Z6s2eqh0jkYHntUL@pathway.suse.cz> <CAJ-ks9n5=FYiFdmzWCkkACzX6oEVs=Z261_ZAKVq3tkqgJoSCQ@mail.gmail.com>
 <Z6t1midEnp5q1Uja@pathway.suse.cz>
In-Reply-To: <Z6t1midEnp5q1Uja@pathway.suse.cz>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Feb 2025 11:08:41 -0500
X-Gm-Features: AWEUYZlP_2LcAvmdFxSHIsCa9qgpWAAhuNMrrrfcnF-G8nwCR-qUJGTiah2VvrE
Message-ID: <CAJ-ks9=Tu4onRXhcSguD8ku1g6ROROhY36iozbOfN7Z1+Smghw@mail.gmail.com>
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

On Tue, Feb 11, 2025 at 11:06=E2=80=AFAM Petr Mladek <pmladek@suse.com> wro=
te:
>
> On Tue 2025-02-11 06:45:07, Tamir Duberstein wrote:
> > On Tue, Feb 11, 2025 at 6:37=E2=80=AFAM Petr Mladek <pmladek@suse.com> =
wrote:
> > >
> > > On Mon 2025-02-10 13:13:48, Tamir Duberstein wrote:
> > > > Convert the scanf() self-test to a KUnit test.
> > > >
> > > > In the interest of keeping the patch reasonably-sized this doesn't
> > > > refactor the tests into proper parameterized tests - it's all one b=
ig
> > > > test case.
> > > >
> > > > Acked-by: Petr Mladek <pmladek@suse.com>
> > >
> > > Please, remove this. The patchset has changed a lot and it is not
> > > longer true.
> >
> > Will do.
> >
> > >
> > > > --- a/lib/test_scanf.c
> > > > +++ b/lib/scanf_kunit.c
> > > > @@ -15,67 +13,49 @@
> > > [...]
> > > >  #define _check_numbers_template(arg_fmt, expect, str, fmt, n_args,=
 ap)               \
> > > >  do {                                                              =
           \
> > > > -     pr_debug("\"%s\", \"%s\" ->\n", str, fmt);                   =
           \
> > > > +     kunit_printk(KERN_DEBUG, test, "\"%s\", \"%s\" ->", str, fmt)=
;  \
> > >
> > > The switch from pr_debug() to kunit_printk() causes printing huge
> > > amount of messages even when the test passes.
> >
> > I'm not able to reproduce this.
>
> It is because the loglevel filtering, see below.
>
> > pr_debug expands to printk(KERN_DEBUG,
> > ...) which is also what kunit_printk(KERN_DEBUG, ...) expands to. Can
> > you help me understand how you're testing?
>
> It is more complicated, see the following in include/linux/printk.h:
>
> <paste>
> /* If you are writing a driver, please use dev_dbg instead */
> #if defined(CONFIG_DYNAMIC_DEBUG) || \
>         (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODU=
LE))
> #include <linux/dynamic_debug.h>
>
> /**
>  * pr_debug - Print a debug-level message conditionally
>  * @fmt: format string
>  * @...: arguments for the format string
>  *
>  * This macro expands to dynamic_pr_debug() if CONFIG_DYNAMIC_DEBUG is
>  * set. Otherwise, if DEBUG is defined, it's equivalent to a printk with
>  * KERN_DEBUG loglevel. If DEBUG is not defined it does nothing.
>  *
>  * It uses pr_fmt() to generate the format string (dynamic_pr_debug() use=
s
>  * pr_fmt() internally).
>  */
> #define pr_debug(fmt, ...)                      \
>         dynamic_pr_debug(fmt, ##__VA_ARGS__)
> #elif defined(DEBUG)
> #define pr_debug(fmt, ...) \
>         printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
> #else
> #define pr_debug(fmt, ...) \
>         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
> #endif
> </paste>
>
>
> It would be nice to define it the other way around. But it would
> require reworking the macro trickery which might be tricky ;-)
>
>
> > > [ 5780.664377] KTAP version 1
> > > [ 5780.664891] 1..1
> > > [ 5780.665376]     KTAP version 1
> > > [ 5780.665765]     # Subtest: scanf
> > > [ 5780.666104]     # module: scanf_kunit
> > > [ 5780.666112]     1..10
> > > [ 5780.667354]     # numbers_simple: "0", "%llu" ->
> > > [ 5780.667371]     # numbers_simple:    0
> > > [ 5780.667923]     # numbers_simple: "0", "%llu" ->
> > > [ 5780.668321]     # numbers_simple:    0
> > > [ 5780.668803]     # numbers_simple: "1", "%llu" ->
> > > [ 5780.669175]     # numbers_simple:    1
> > > [ 5780.669624]     # numbers_simple: "18446744073709551615", "%llu" -=
>
> > >
> > > [... skipping 7500+ lines ...]
> > >
> > > [ 5783.157777]     # test_simple_strtol: simple_strtol("0x7ffffffffff=
fffff", 0) -> 0x7fffffffffffffff
> > > [ 5783.158229]     # test_simple_strtol: simple_strtol("0x80000000000=
00001", 0) -> 0x8000000000000001
> > > [ 5783.158683]     # test_simple_strtol: simple_strtol("0x80000000000=
00000", 0) -> 0x8000000000000000
> > > [ 5783.159131]     # test_simple_strtol: simple_strtol("0x80000000000=
00000", 0) -> 0x8000000000000000
> > > [ 5783.159586]     # test_simple_strtol: simple_strtol("0x80000000000=
00001", 0) -> 0x8000000000000001
> > > [ 5783.160048]     # test_simple_strtol: simple_strtol("0x7ffffffffff=
fffff", 0) -> 0x7fffffffffffffff
> > > [ 5783.160506]     # test_simple_strtol: simple_strtol("0xfffffffffff=
ffffe", 0) -> 0xfffffffffffffffe
> > > [ 5783.160957]     # test_simple_strtol: simple_strtol("0x2", 0) -> 0=
x2
> > > [ 5783.161467]     # test_simple_strtol: simple_strtol("0xfffffffffff=
fffff", 0) -> 0xffffffffffffffff
> > > [ 5783.161806]     # test_simple_strtol: simple_strtol("0x1", 0) -> 0=
x1
> > > [ 5783.162564]     ok 10 test_simple_strtol
> > > [ 5783.163145] # scanf: pass:10 fail:0 skip:0 total:10
> > > [ 5783.163537] # Totals: pass:22 fail:0 skip:0 total:22
> > > [ 5783.164052] ok 1 scanf
>
> I saw the above messages using "dmesg".
>
> They can also be seen in /sys/kernel/debug/kunit/scanf/results
> when CONFIG_KUNIT_DEBUGFS is enabled.
>
>
> > If you use one of the kunit userspace helpers, you will only see the
> > output when the test fails. Having said that, in my local testing I
> > don't see the KERN_DEBUG prints locally. I had to run with
> > ignore_loglevel to see them at all.
>
> Yeah, KERN_DEBUG are for the least important messages. Consoles usually
> do not print them to do not scare normal users and also historically
> because of slow serial consoles.
>
> Anyway, they are always stored into the internal log buffer. So that
> they can be seen by "dmesg" even when they were filtered on the
> console.
>
> BTW: The log buffer has a limited size. The oldest messages get lost
>      when are too many of them. Which is another reason to do not
>      print the debug messages by default.
>
>
> Best Regards,
> Petr
>
> PS: You are sending new revisions too fast. It is hard to follow.
>     I personally prefer to send one revision per week at maximum.
>     It gives people chance to find time for the review and provide
>     some feedback.

Thanks, I'll reduce the frequency. Apologies for the noise!

I think all this is addressed in v7.

