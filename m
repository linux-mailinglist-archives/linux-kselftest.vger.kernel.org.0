Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 854A0F3E43
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2019 04:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfKHDCr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 22:02:47 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:46754 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbfKHDCr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 22:02:47 -0500
Received: by mail-il1-f195.google.com with SMTP id q1so3118818ile.13
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Nov 2019 19:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gv3+n/c+38zvwy3Zq6JG6GHg2sYaACls7c2MhxQMBzE=;
        b=pRynUAiW1uPF2J9chfhPN9oeKkYWylAn1lkV4lomStqviluWeX7UtfKz1mOwyUaJt3
         lPgXD7ToZMcLXpR3Fkjf5GlcJE7l3+G9SkH0Ko5CDtEVOuVUls3UK3iRXPHLgPi04eFX
         aa5gVqh5GtzRDoTwfVj0l3K8QGUhjnAnhQCXpAdcPlvj5GFKtNH2jELUXfm3uYKEAyAc
         PiCoSj8fZl2qlUuq+9tlSEdqaR3kkSh++al0apUO3LzyvJ/6bPDJCDED1ZKNjd/3Ay7h
         ZKJnbei7TPPTHf1wGCSfBP8mjWvJ74y4oYT2SLLpebiIYTaUKWOlnkrGDY2DgX1R3TWy
         S2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gv3+n/c+38zvwy3Zq6JG6GHg2sYaACls7c2MhxQMBzE=;
        b=qJa+4YwwEjm+Al1Qp/Gf/KCw/cjoonaDwHcyoffDrJIGc3Du2q84JRudx8Up1UiTt8
         hX8hP0V73lTFQmb6MHRR82teHe6PTLDsyQ8is7+oBZoQt9VsfzRJj9sJBuiAq54lNHAK
         q6dYICurnAIJGyjyzxsyPn1ODadol3uFbU5jIRPwxDNByge54O6USOaxgGPkWWYqCbA0
         WUjIAJNnzHT4rcb6OZHzltyiJiZ6tr8eLi0BfXTAb1lfJrb8X6cNsVN9X+y3ShNdNCqN
         A3hJUJseG67ptBz/g0Rv5KjX+s3AgD1FOLXe8L8hnDcQAGmvtY10ze4rXoOILQJdCtcZ
         FtNQ==
X-Gm-Message-State: APjAAAUDCAHO7pbW4mXRPkWmxUyahMohtk6eTm60ewA6bIXvdHxRw8nS
        5QyPJ5hPMVP/vxsAyp/xJ7Iu/Q==
X-Google-Smtp-Source: APXvYqzFaMkN0XzBKKC42AzT60rki5eCoQbSHNn398fYmsVPBLpd07iwotlWqZpRpc4AWVzKPZH01Q==
X-Received: by 2002:a17:902:fe11:: with SMTP id g17mr7563765plj.329.1573182165525;
        Thu, 07 Nov 2019 19:02:45 -0800 (PST)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id m123sm4205287pfb.133.2019.11.07.19.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 19:02:44 -0800 (PST)
Date:   Thu, 7 Nov 2019 19:02:40 -0800
From:   Brendan Higgins <brendanhiggins@google.com>
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
Subject: Re: [PATCH v3 linux-kselftest-test 5/6] kunit: allow kunit to be
 loaded as a module
Message-ID: <20191108030240.GA241915@google.com>
References: <1571335639-21675-1-git-send-email-alan.maguire@oracle.com>
 <1571335639-21675-6-git-send-email-alan.maguire@oracle.com>
 <CAFd5g46s4eY4qEB5UZPeOKNdZXm4+sA9N=4g8gDYAhyhMahZKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFd5g46s4eY4qEB5UZPeOKNdZXm4+sA9N=4g8gDYAhyhMahZKw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 07, 2019 at 06:43:11PM -0800, Brendan Higgins wrote:
> On Thu, Oct 17, 2019 at 11:09 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > Making kunit itself buildable as a module allows for "always-on"
> > kunit configuration; specifying CONFIG_KUNIT=m means the module
> > is built but only used when loaded.  Kunit test modules will load
> > kunit.ko as an implicit dependency, so simply running
> > "modprobe my-kunit-tests" will load the tests along with the kunit
> > module and run them.
> >
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > ---
> >  lib/kunit/Kconfig     | 2 +-
> >  lib/kunit/Makefile    | 4 +++-
> >  lib/kunit/test.c      | 2 ++
> >  lib/kunit/try-catch.c | 3 +++
> >  4 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> > index 9ebd5e6..065aa16 100644
> > --- a/lib/kunit/Kconfig
> > +++ b/lib/kunit/Kconfig
> > @@ -3,7 +3,7 @@
> >  #
> >
> >  menuconfig KUNIT
> > -       bool "KUnit - Enable support for unit tests"
> > +       tristate "KUnit - Enable support for unit tests"
> >         help
> >           Enables support for kernel unit tests (KUnit), a lightweight unit
> >           testing and mocking framework for the Linux kernel. These tests are
> > diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> > index 769d940..8e2635a 100644
> > --- a/lib/kunit/Makefile
> > +++ b/lib/kunit/Makefile
> > @@ -1,4 +1,6 @@
> > -obj-$(CONFIG_KUNIT) +=                 test.o \
> > +obj-$(CONFIG_KUNIT) +=                 kunit.o
> > +
> > +kunit-objs +=                          test.o \
> >                                         string-stream.o \
> >                                         assert.o \
> >                                         try-catch.o
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index e8b2443..c0ace36 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -523,3 +523,5 @@ void *kunit_find_symbol(const char *sym)
> >         return ERR_PTR(-ENOENT);
> >  }
> >  EXPORT_SYMBOL(kunit_find_symbol);
> > +
> > +MODULE_LICENSE("GPL");
> > diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> > index 1c1e9af..72fc8ed 100644
> > --- a/lib/kunit/try-catch.c
> > +++ b/lib/kunit/try-catch.c
> > @@ -31,6 +31,8 @@ static int kunit_generic_run_threadfn_adapter(void *data)
> >         complete_and_exit(try_catch->try_completion, 0);
> >  }
> >
> > +KUNIT_VAR_SYMBOL(sysctl_hung_task_timeout_secs, unsigned long);
> 
> Can you just export sysctl_hung_task_timeout_secs?
> 
> I don't mean to make you redo all this work for one symbol twice, but
> I thought we agreed on just exposing this symbol, but in a namespace.
> It seemed like a good use case for that namespaced exporting thing
> that Luis was talking about. As I understood it, you would have to
> export it in the module that defines it, and then use the new
> MODULE_IMPORT_NS() macro here.

Also, I tried applying this and running this on kselftest/test and got
the following build error:

In file included from lib/kunit/try-catch.c:10:
lib/kunit/try-catch.c: In function ‘kunit_test_timeout’:
./include/kunit/test.h:132:19: error: lvalue required as unary ‘&’ operand
  kunit_##symbol = &(symbol)
                   ^
lib/kunit/try-catch.c:57:2: note: in expansion of macro ‘KUNIT_INIT_VAR_SYMBOL’
  KUNIT_INIT_VAR_SYMBOL(NULL, sysctl_hung_task_timeout_secs);
  ^~~~~~~~~~~~~~~~~~~~~

> > +
> >  static unsigned long kunit_test_timeout(void)
> >  {
> >         unsigned long timeout_msecs;
> > @@ -52,6 +54,7 @@ static unsigned long kunit_test_timeout(void)
> >          * For more background on this topic, see:
> >          * https://mike-bland.com/2011/11/01/small-medium-large.html
> >          */
> > +       KUNIT_INIT_VAR_SYMBOL(NULL, sysctl_hung_task_timeout_secs);
> >         if (sysctl_hung_task_timeout_secs) {
> >                 /*
> >                  * If sysctl_hung_task is active, just set the timeout to some
> > --
> > 1.8.3.1
> >
