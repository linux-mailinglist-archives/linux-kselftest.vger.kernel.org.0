Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63327F3E27
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2019 03:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfKHCnY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 21:43:24 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46661 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfKHCnY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 21:43:24 -0500
Received: by mail-pf1-f195.google.com with SMTP id 193so3661411pfc.13
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Nov 2019 18:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L7ghc5DftJ1dJAFGG7geKIMSB0XHdAtyHWb1fKQe0ss=;
        b=Fv95OKfAjhccA38qGlkswPxYWtCbR279VGUGFr3KsVCn/eHl34M0jb1TfygFNNbKIU
         T/2VlJUyJroKPpb5Ej3+4kBCXen6m2VMg1MLOCY7UsqryzvgghQJtbundVmCHiTwgpgh
         VAQBdzwux0qEv+PPvtJMAwzXVOdZtTL+k4C8PKwczU89em4WnzfIP8ZIFneVHYmeL+D+
         ukumFNfa2FdVQT5y7CAPZNxYerq+Afvl3uHth9Zdf7pqWBrDzPT9UcWfeqhUqRx/PPTo
         gYkK2dPXgOQXh6YwUDpBIwuXkbynry9MYsY+IPXEV3gHjaQ3t6C0GgaUL1AfgY0fJQAP
         Rinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L7ghc5DftJ1dJAFGG7geKIMSB0XHdAtyHWb1fKQe0ss=;
        b=tNR3eCKF1QOaSm4bx1Mq/9XfHf+JEy+cedE91RX4427Kncl3Wn38Z5F6R5OsZpvyry
         40PokdJV5N7yoST2fIXHiQsBVFsJfqX7d7Bhn6tVlSc0LvAduDSa4K/pYDkfNaxl7WUU
         gRCXY5yp1aqkU++MGaA0IGAKZH24Wx7nfHdZJLIeQqwvqGaleB01ZWt8YJkcNxsPfXwI
         O86PvoZTB9XDGwCOX6qofw4NX0MP1dVHV+9jRQxRE0jUC+hkCHmcs+84Ig4WPlD5m6Uh
         mnjAf0EY7a1bff+Z/NRVoQ159v2SCnsGwXlvSzF3ZoImaso8fRzSBWrlG6nTmtOtzieB
         pZsQ==
X-Gm-Message-State: APjAAAWbhijHcie7Zzee9YYSHTtXS/jnM8UsjFxMma1Nb3jFEyFGImTH
        /dkPqwlt1Rx8/mSDFlhOtmo0ZuLuRkNQzYvcYuW4ewd/Yls=
X-Google-Smtp-Source: APXvYqwmr0Xk5qSCk6LJsKaE68DfwybqJtqkMDQUaniWJCkpnNU/JnviODiDeYpoCijj9Q+rcus/ybCUi0qX1DpuoRs=
X-Received: by 2002:a63:234c:: with SMTP id u12mr8550073pgm.384.1573181002849;
 Thu, 07 Nov 2019 18:43:22 -0800 (PST)
MIME-Version: 1.0
References: <1571335639-21675-1-git-send-email-alan.maguire@oracle.com> <1571335639-21675-6-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1571335639-21675-6-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 7 Nov 2019 18:43:11 -0800
Message-ID: <CAFd5g46s4eY4qEB5UZPeOKNdZXm4+sA9N=4g8gDYAhyhMahZKw@mail.gmail.com>
Subject: Re: [PATCH v3 linux-kselftest-test 5/6] kunit: allow kunit to be
 loaded as a module
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 17, 2019 at 11:09 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> Making kunit itself buildable as a module allows for "always-on"
> kunit configuration; specifying CONFIG_KUNIT=m means the module
> is built but only used when loaded.  Kunit test modules will load
> kunit.ko as an implicit dependency, so simply running
> "modprobe my-kunit-tests" will load the tests along with the kunit
> module and run them.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> ---
>  lib/kunit/Kconfig     | 2 +-
>  lib/kunit/Makefile    | 4 +++-
>  lib/kunit/test.c      | 2 ++
>  lib/kunit/try-catch.c | 3 +++
>  4 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 9ebd5e6..065aa16 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -3,7 +3,7 @@
>  #
>
>  menuconfig KUNIT
> -       bool "KUnit - Enable support for unit tests"
> +       tristate "KUnit - Enable support for unit tests"
>         help
>           Enables support for kernel unit tests (KUnit), a lightweight unit
>           testing and mocking framework for the Linux kernel. These tests are
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 769d940..8e2635a 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -1,4 +1,6 @@
> -obj-$(CONFIG_KUNIT) +=                 test.o \
> +obj-$(CONFIG_KUNIT) +=                 kunit.o
> +
> +kunit-objs +=                          test.o \
>                                         string-stream.o \
>                                         assert.o \
>                                         try-catch.o
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index e8b2443..c0ace36 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -523,3 +523,5 @@ void *kunit_find_symbol(const char *sym)
>         return ERR_PTR(-ENOENT);
>  }
>  EXPORT_SYMBOL(kunit_find_symbol);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index 1c1e9af..72fc8ed 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -31,6 +31,8 @@ static int kunit_generic_run_threadfn_adapter(void *data)
>         complete_and_exit(try_catch->try_completion, 0);
>  }
>
> +KUNIT_VAR_SYMBOL(sysctl_hung_task_timeout_secs, unsigned long);

Can you just export sysctl_hung_task_timeout_secs?

I don't mean to make you redo all this work for one symbol twice, but
I thought we agreed on just exposing this symbol, but in a namespace.
It seemed like a good use case for that namespaced exporting thing
that Luis was talking about. As I understood it, you would have to
export it in the module that defines it, and then use the new
MODULE_IMPORT_NS() macro here.

> +
>  static unsigned long kunit_test_timeout(void)
>  {
>         unsigned long timeout_msecs;
> @@ -52,6 +54,7 @@ static unsigned long kunit_test_timeout(void)
>          * For more background on this topic, see:
>          * https://mike-bland.com/2011/11/01/small-medium-large.html
>          */
> +       KUNIT_INIT_VAR_SYMBOL(NULL, sysctl_hung_task_timeout_secs);
>         if (sysctl_hung_task_timeout_secs) {
>                 /*
>                  * If sysctl_hung_task is active, just set the timeout to some
> --
> 1.8.3.1
>
