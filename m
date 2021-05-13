Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F0E37FF73
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 22:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhEMUtl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 May 2021 16:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhEMUtj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 May 2021 16:49:39 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BDCC06174A
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 13:48:29 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u133so3774071wmg.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 13:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dGB51QrtZPdSxwxWBoGg4WEVZZlkiB0hLTHFQQSVKgw=;
        b=KQWMq1IP3OP2LY2wCYR9fJWa7W2Qy4qETloqS25tPcBiaqyvBBvNJebqlMWRJ21mAd
         mOJ6dnl85TULZhCwrIxtrph11kQ0dB1+UoNwqZhYwEo1xxpSB3apZUlS/DrhXjJ9jYCw
         VigbGH9yTCH+kmCKd/CMaYkquhzqXHiZC/r2BbM2f5jN8zDNiOyN4ncHqME4Zvb6pvMC
         NNclnZCrbnL9U3iDV7AM81S0vOquzgy4v01wkGyc2MKm2osJ45Lgd6tA9LBJH4ToOxOh
         h7jjyEWxW1Ewc8HBEeoeHReunSrl/XT6DLQPiifOIQKUkVUnQZWgwU2Tvb3PEHa2pbRS
         Lcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dGB51QrtZPdSxwxWBoGg4WEVZZlkiB0hLTHFQQSVKgw=;
        b=WJJVaKanOv99b9e+uusKpXto1/mAUHF3dhtKiSNBVvjCquBs0IbXvHcYBqlDAip7qn
         tb1ZaejjbDQfV7LOmqHd5B8YjuCI4v/C0rPuIKrxXrP6FXUEtXBigR8V3qMDgV3zbNNY
         2nDFEm+IGAyfmszULk+qjNx2rqODIf7GXaUJqVSy+z7kcZXQPSY9cdLlv+G0Jcs0KErY
         fAjCg2UHkdwSYeBjBeMaxTg1E/t9zsbSkuqY2sd6qcVpwY7R231o1prvw4/aoEFvHYBx
         cdUGPX4s8bkBP9uSl1wgkxBIQXe6q1zrewJnCNAJknOSGW28k6++TwZ7P5++WmJneUF9
         IINw==
X-Gm-Message-State: AOAM531pLiveVBSzEcpD6/mvgEfXHQ9ayrYQSXoY9Z1BGoak19lC+Mgk
        UzyUowPm+oLO3h7RrCJbRD8AiYrcT7FwMyKHR4E8xQ==
X-Google-Smtp-Source: ABdhPJzhMmofqv5D6fbTvQQIsmKkUQpAal/lQr9yE9lxDr8GDIVFmRxBmI2vC6RCs5aNycBLcNTATF4eRiPKPMaSUv0=
X-Received: by 2002:a1c:cc17:: with SMTP id h23mr26925463wmb.129.1620938907795;
 Thu, 13 May 2021 13:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210513200350.854429-1-davidgow@google.com> <CAGS_qxoOM_STeiDQSdrYu6_5upOMMeBcg8NXjZuKCJ=rc=7Vag@mail.gmail.com>
In-Reply-To: <CAGS_qxoOM_STeiDQSdrYu6_5upOMMeBcg8NXjZuKCJ=rc=7Vag@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 14 May 2021 04:48:16 +0800
Message-ID: <CABVgOSmi01-DpECo0AYSGJWMbPTEHzhA4pRG-vSimfMsF_xpFw@mail.gmail.com>
Subject: Re: [PATCH] kunit: Add gnu_printf specifiers
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 14, 2021 at 4:25 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Thu, May 13, 2021 at 1:03 PM 'David Gow' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > Some KUnit functions use variable arguments to implement a printf-like
> > format string. Use the __printf() attribute to let the compiler warn if
> > invalid format strings are passed in.
> >
> > If the kernel is build with W=3D1, it complained about the lack of thes=
e
> > specifiers, e.g.:
> > ../lib/kunit/test.c:72:2: warning: function =E2=80=98kunit_log_append=
=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format attr=
ibute [-Wsuggest-attribute=3Dformat]
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
>
> As noted below, these additions don't really do anything.
> Unfortunately, they just make compiler warnings noisier in the case of
> kunit_log_append().
>
> But if this silences a W=3D1 warning, then we should probably add them in=
.
> I guess it also serves as documentation that we're using the same
> standard format specifiers and not something custom, which is nice.
>

Yeah: I did this to get rid of the W=3D1 warnings. I don't know if
there's a way of doing this which would be less verbose: I do think
that the format checking is worthwhile in general, even if we're
hitting a few nasty cases where things are nested in macros.


> > ---
> >  include/kunit/test.h      | 2 +-
> >  lib/kunit/string-stream.h | 6 +++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 49601c4b98b8..af2e386b867c 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -610,7 +610,7 @@ static inline void *kunit_kzalloc(struct kunit *tes=
t, size_t size, gfp_t gfp)
> >
> >  void kunit_cleanup(struct kunit *test);
> >
> > -void kunit_log_append(char *log, const char *fmt, ...);
> > +void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
>
> Before this patch:
> ../lib/kunit/kunit-example-test.c: In function =E2=80=98example_simple_te=
st=E2=80=99:
> ../include/linux/kern_levels.h:5:18: warning: format =E2=80=98%s=E2=80=99=
 expects
> argument of type =E2=80=98char *=E2=80=99, but argument 3 has type =E2=80=
=98int=E2=80=99 [-Wformat=3D]
>     5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
>       |                  ^~~~~~
> ../include/kunit/test.h:622:10: note: in definition of macro =E2=80=98kun=
it_log=E2=80=99
>   622 |   printk(lvl fmt, ##__VA_ARGS__);    \
>       |          ^~~
> ../include/kunit/test.h:641:2: note: in expansion of macro =E2=80=98kunit=
_printk=E2=80=99
>   641 |  kunit_printk(KERN_INFO, test, fmt, ##__VA_ARGS__)
>       |  ^~~~~~~~~~~~
> ../include/linux/kern_levels.h:14:19: note: in expansion of macro =E2=80=
=98KERN_SOH=E2=80=99
>    14 | #define KERN_INFO KERN_SOH "6" /* informational */
>       |                   ^~~~~~~~
> ../include/kunit/test.h:641:15: note: in expansion of macro =E2=80=98KERN=
_INFO=E2=80=99
>   641 |  kunit_printk(KERN_INFO, test, fmt, ##__VA_ARGS__)
>       |               ^~~~~~~~~
> ../lib/kunit/kunit-example-test.c:23:2: note: in expansion of macro =E2=
=80=98kunit_info=E2=80=99
>    23 |  kunit_info(test, "invalid: %s", 42);
>
> After this patch, it gets noisier:
> In file included from ../lib/kunit/kunit-example-test.c:9:
> ../lib/kunit/kunit-example-test.c: In function =E2=80=98example_simple_te=
st=E2=80=99:
> ../include/linux/kern_levels.h:5:18: warning: format =E2=80=98%s=E2=80=99=
 expects
> argument of type =E2=80=98char *=E2=80=99, but argument 3 has type =E2=80=
=98int=E2=80=99 [-Wformat=3D]
>     5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
>       |                  ^~~~~~
> ../include/kunit/test.h:622:10: note: in definition of macro =E2=80=98kun=
it_log=E2=80=99
>   622 |   printk(lvl fmt, ##__VA_ARGS__);    \
>       |          ^~~
> ../include/kunit/test.h:641:2: note: in expansion of macro =E2=80=98kunit=
_printk=E2=80=99
>   641 |  kunit_printk(KERN_INFO, test, fmt, ##__VA_ARGS__)
>       |  ^~~~~~~~~~~~
> ../include/linux/kern_levels.h:14:19: note: in expansion of macro =E2=80=
=98KERN_SOH=E2=80=99
>    14 | #define KERN_INFO KERN_SOH "6" /* informational */
>       |                   ^~~~~~~~
> ../include/kunit/test.h:641:15: note: in expansion of macro =E2=80=98KERN=
_INFO=E2=80=99
>   641 |  kunit_printk(KERN_INFO, test, fmt, ##__VA_ARGS__)
>       |               ^~~~~~~~~
> ../lib/kunit/kunit-example-test.c:23:2: note: in expansion of macro =E2=
=80=98kunit_info=E2=80=99
>    23 |  kunit_info(test, "invalid: %s", 42);
>       |  ^~~~~~~~~~
> ../include/kunit/test.h:105:31: warning: format =E2=80=98%s=E2=80=99 expe=
cts argument
> of type =E2=80=98char *=E2=80=99, but argument 4 has type =E2=80=98int=E2=
=80=99 [-Wformat=3D]
>   105 | #define KUNIT_SUBTEST_INDENT  "    "
>       |                               ^~~~~~
> ../include/kunit/test.h:623:42: note: in definition of macro =E2=80=98kun=
it_log=E2=80=99
>   623 |   kunit_log_append((test_or_suite)->log, fmt "\n", \
>       |                                          ^~~
> ../include/kunit/test.h:628:23: note: in expansion of macro
> =E2=80=98KUNIT_SUBTEST_INDENT=E2=80=99
>   628 |  kunit_log(lvl, test, KUNIT_SUBTEST_INDENT "# %s: " fmt,  \
>       |                       ^~~~~~~~~~~~~~~~~~~~
> ../include/kunit/test.h:641:2: note: in expansion of macro =E2=80=98kunit=
_printk=E2=80=99
>   641 |  kunit_printk(KERN_INFO, test, fmt, ##__VA_ARGS__)
>       |  ^~~~~~~~~~~~
> ../lib/kunit/kunit-example-test.c:23:2: note: in expansion of macro =E2=
=80=98kunit_info=E2=80=99
>    23 |  kunit_info(test, "invalid: %s", 42);
>       |  ^~~~~~~~~~
>
>

Yeah: that is pretty ugly. TBH, it was pretty ugly beforehand, and
this does make it worse. I guess that's the price we pay for having so
many nested macros, as well.
Personally, I suspect this is still worth it to get rid of the
compiler warnings, but only just.

> >
> >  /*
> >   * printk and log to per-test or per-suite log buffer.  Logging only d=
one
> > diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
> > index fe98a00b75a9..5e94b623454f 100644
> > --- a/lib/kunit/string-stream.h
> > +++ b/lib/kunit/string-stream.h
> > @@ -35,9 +35,9 @@ struct string_stream *alloc_string_stream(struct kuni=
t *test, gfp_t gfp);
> >  int __printf(2, 3) string_stream_add(struct string_stream *stream,
> >                                      const char *fmt, ...);
> >
> > -int string_stream_vadd(struct string_stream *stream,
> > -                      const char *fmt,
> > -                      va_list args);
> > +int __printf(2, 0) string_stream_vadd(struct string_stream *stream,
> > +                                     const char *fmt,
> > +                                     va_list args);
>
> This is never called with a literal `fmt` string.
> It's currently only ever called through the _add variant, which does
> have __printf(2,3).
>
> So this can't catch any mistakes currently.
> And I think it's hard to imagine we'd ever pass in a literal format
> string w/ a va_list.
>

Yeah: I was tempted to leave this one out, but it was triggering
warnings with the "you should use __printf()" heuristic. In fact, it
had two warnings.
The __printf() specifier documentation does specifically call out
cases where a va_list is passed in as a case to use '0' for the
positional argument, but only the format string is checked for
validity: there's no typechecking.

> >
> >  char *string_stream_get_string(struct string_stream *stream);
> >
> > --
> > 2.31.1.751.gd2f1c929bd-goog
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "KUnit Development" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kunit-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/ms=
gid/kunit-dev/20210513200350.854429-1-davidgow%40google.com.
