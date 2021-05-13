Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650BE37FEFD
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 22:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhEMU06 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 May 2021 16:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhEMU05 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 May 2021 16:26:57 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97111C061574
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 13:25:47 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id j30so2196464ila.5
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 13:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qZzch66iB51NNi0ZqHmY6/CosY2oTBkrOtTo2o2UtmA=;
        b=naxDTl1YplWg7mI73yjQ3Ur7yiJ5GL757T/EsxDwhtdI+SyN9H4l7W3KkLd7kPfOxy
         0KbG/M3WzgLAA4OoaZeRu2EdFFkq8V5/Ck5w0BLWqgUAeQwOrLiFjMhOfPcd4AdUNIx+
         HBlSIdNm8oNheRC7ZQjpKZdzsKXPDk+r2773xHiiFo8T6nYqwbQ7X538lVGAxMTfDLwb
         igMft+NYQgfWsaAbrhCKuJcN/ap3dR+kBxwX3GaJ4SEMzrC1Nq0XvDFeLngysrdpkVjf
         2HE0DPouNwMh0x0Kp2QgxyecUebD5BCQyoDHLEAY18b4cBF04DLkfkaZ59thO2O2j3NA
         xeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qZzch66iB51NNi0ZqHmY6/CosY2oTBkrOtTo2o2UtmA=;
        b=oDqDKJKcHiSLRB6JatJswtZiW22AyVZ38IzlkHr8EHGQRtVkwtSHxeIohCl6nLJ4bf
         svsuHOSoBfxxaPwPzwb+gmvWLndLmq6629YH6aZDOQg1QE99C/aanhkYzdATMelWMdsd
         Bg27RPUwfgZllO72irvNZTLzN+CdZjs9tnzj573te31h/jljBivjfRkEAmJ/UvBdrlPS
         Xg/rTLi+MT8M8glrajqrdaQB+IXgMLrh1zQqwRDDqGSDA0N6ci7zZTGxIVm1YxQPdXf3
         a0FQE/pXdspbAfcmqubuHOSEP6vWSqn2HasTQ1sYbvtaXlCuPphcPxpSFpsHi5EOkoRN
         TRmA==
X-Gm-Message-State: AOAM531ETwhusN4ANOG/05oESbFcu1aqZqR9imzsanRcYgZv69SR+diB
        REf0VeDri8CBen7uBvm39HSqKdrm3dn8bq8VHuu/BA==
X-Google-Smtp-Source: ABdhPJwWqSM8cwDGiiK8bkKgEHqHEaoiQfDyuAyLyaYDjoNMuPIL6qx6+4tDBOeLPCU0I9RMgQvpSiD80Cz/hWcr4ZA=
X-Received: by 2002:a05:6e02:b2c:: with SMTP id e12mr20879228ilu.136.1620937546870;
 Thu, 13 May 2021 13:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210513200350.854429-1-davidgow@google.com>
In-Reply-To: <20210513200350.854429-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 13 May 2021 13:25:35 -0700
Message-ID: <CAGS_qxoOM_STeiDQSdrYu6_5upOMMeBcg8NXjZuKCJ=rc=7Vag@mail.gmail.com>
Subject: Re: [PATCH] kunit: Add gnu_printf specifiers
To:     David Gow <davidgow@google.com>
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

On Thu, May 13, 2021 at 1:03 PM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Some KUnit functions use variable arguments to implement a printf-like
> format string. Use the __printf() attribute to let the compiler warn if
> invalid format strings are passed in.
>
> If the kernel is build with W=3D1, it complained about the lack of these
> specifiers, e.g.:
> ../lib/kunit/test.c:72:2: warning: function =E2=80=98kunit_log_append=E2=
=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format attribu=
te [-Wsuggest-attribute=3Dformat]
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

As noted below, these additions don't really do anything.
Unfortunately, they just make compiler warnings noisier in the case of
kunit_log_append().

But if this silences a W=3D1 warning, then we should probably add them in.
I guess it also serves as documentation that we're using the same
standard format specifiers and not something custom, which is nice.

> ---
>  include/kunit/test.h      | 2 +-
>  lib/kunit/string-stream.h | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 49601c4b98b8..af2e386b867c 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -610,7 +610,7 @@ static inline void *kunit_kzalloc(struct kunit *test,=
 size_t size, gfp_t gfp)
>
>  void kunit_cleanup(struct kunit *test);
>
> -void kunit_log_append(char *log, const char *fmt, ...);
> +void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);

Before this patch:
../lib/kunit/kunit-example-test.c: In function =E2=80=98example_simple_test=
=E2=80=99:
../include/linux/kern_levels.h:5:18: warning: format =E2=80=98%s=E2=80=99 e=
xpects
argument of type =E2=80=98char *=E2=80=99, but argument 3 has type =E2=80=
=98int=E2=80=99 [-Wformat=3D]
    5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
      |                  ^~~~~~
../include/kunit/test.h:622:10: note: in definition of macro =E2=80=98kunit=
_log=E2=80=99
  622 |   printk(lvl fmt, ##__VA_ARGS__);    \
      |          ^~~
../include/kunit/test.h:641:2: note: in expansion of macro =E2=80=98kunit_p=
rintk=E2=80=99
  641 |  kunit_printk(KERN_INFO, test, fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~
../include/linux/kern_levels.h:14:19: note: in expansion of macro =E2=80=98=
KERN_SOH=E2=80=99
   14 | #define KERN_INFO KERN_SOH "6" /* informational */
      |                   ^~~~~~~~
../include/kunit/test.h:641:15: note: in expansion of macro =E2=80=98KERN_I=
NFO=E2=80=99
  641 |  kunit_printk(KERN_INFO, test, fmt, ##__VA_ARGS__)
      |               ^~~~~~~~~
../lib/kunit/kunit-example-test.c:23:2: note: in expansion of macro =E2=80=
=98kunit_info=E2=80=99
   23 |  kunit_info(test, "invalid: %s", 42);

After this patch, it gets noisier:
In file included from ../lib/kunit/kunit-example-test.c:9:
../lib/kunit/kunit-example-test.c: In function =E2=80=98example_simple_test=
=E2=80=99:
../include/linux/kern_levels.h:5:18: warning: format =E2=80=98%s=E2=80=99 e=
xpects
argument of type =E2=80=98char *=E2=80=99, but argument 3 has type =E2=80=
=98int=E2=80=99 [-Wformat=3D]
    5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
      |                  ^~~~~~
../include/kunit/test.h:622:10: note: in definition of macro =E2=80=98kunit=
_log=E2=80=99
  622 |   printk(lvl fmt, ##__VA_ARGS__);    \
      |          ^~~
../include/kunit/test.h:641:2: note: in expansion of macro =E2=80=98kunit_p=
rintk=E2=80=99
  641 |  kunit_printk(KERN_INFO, test, fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~
../include/linux/kern_levels.h:14:19: note: in expansion of macro =E2=80=98=
KERN_SOH=E2=80=99
   14 | #define KERN_INFO KERN_SOH "6" /* informational */
      |                   ^~~~~~~~
../include/kunit/test.h:641:15: note: in expansion of macro =E2=80=98KERN_I=
NFO=E2=80=99
  641 |  kunit_printk(KERN_INFO, test, fmt, ##__VA_ARGS__)
      |               ^~~~~~~~~
../lib/kunit/kunit-example-test.c:23:2: note: in expansion of macro =E2=80=
=98kunit_info=E2=80=99
   23 |  kunit_info(test, "invalid: %s", 42);
      |  ^~~~~~~~~~
../include/kunit/test.h:105:31: warning: format =E2=80=98%s=E2=80=99 expect=
s argument
of type =E2=80=98char *=E2=80=99, but argument 4 has type =E2=80=98int=E2=
=80=99 [-Wformat=3D]
  105 | #define KUNIT_SUBTEST_INDENT  "    "
      |                               ^~~~~~
../include/kunit/test.h:623:42: note: in definition of macro =E2=80=98kunit=
_log=E2=80=99
  623 |   kunit_log_append((test_or_suite)->log, fmt "\n", \
      |                                          ^~~
../include/kunit/test.h:628:23: note: in expansion of macro
=E2=80=98KUNIT_SUBTEST_INDENT=E2=80=99
  628 |  kunit_log(lvl, test, KUNIT_SUBTEST_INDENT "# %s: " fmt,  \
      |                       ^~~~~~~~~~~~~~~~~~~~
../include/kunit/test.h:641:2: note: in expansion of macro =E2=80=98kunit_p=
rintk=E2=80=99
  641 |  kunit_printk(KERN_INFO, test, fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~
../lib/kunit/kunit-example-test.c:23:2: note: in expansion of macro =E2=80=
=98kunit_info=E2=80=99
   23 |  kunit_info(test, "invalid: %s", 42);
      |  ^~~~~~~~~~


>
>  /*
>   * printk and log to per-test or per-suite log buffer.  Logging only don=
e
> diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
> index fe98a00b75a9..5e94b623454f 100644
> --- a/lib/kunit/string-stream.h
> +++ b/lib/kunit/string-stream.h
> @@ -35,9 +35,9 @@ struct string_stream *alloc_string_stream(struct kunit =
*test, gfp_t gfp);
>  int __printf(2, 3) string_stream_add(struct string_stream *stream,
>                                      const char *fmt, ...);
>
> -int string_stream_vadd(struct string_stream *stream,
> -                      const char *fmt,
> -                      va_list args);
> +int __printf(2, 0) string_stream_vadd(struct string_stream *stream,
> +                                     const char *fmt,
> +                                     va_list args);

This is never called with a literal `fmt` string.
It's currently only ever called through the _add variant, which does
have __printf(2,3).

So this can't catch any mistakes currently.
And I think it's hard to imagine we'd ever pass in a literal format
string w/ a va_list.

>
>  char *string_stream_get_string(struct string_stream *stream);
>
> --
> 2.31.1.751.gd2f1c929bd-goog
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20210513200350.854429-1-davidgow%40google.com.
