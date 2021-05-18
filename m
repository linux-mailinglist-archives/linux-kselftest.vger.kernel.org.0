Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C6A3881AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 May 2021 22:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242705AbhERUxd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 May 2021 16:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240272AbhERUxd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 May 2021 16:53:33 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0224C061760
        for <linux-kselftest@vger.kernel.org>; Tue, 18 May 2021 13:52:14 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n8so572829plf.7
        for <linux-kselftest@vger.kernel.org>; Tue, 18 May 2021 13:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+DAs03ze2iLGrXZLZIzptTE6KU69sGQUDBhtzB60KZ0=;
        b=Ox12y593I4po/OU/lRETPsTURBwzeR0Nakfr6c8729zOzLvZ2V14d3c1hT/i45ZMGG
         9CRMMFimZ+r3eSQz/HyJd8JNWSEUja5Zys9xVWxwLbH8AoK8rbuKufNfTYlxg9TWCHch
         XOUDWHuTZ9g3LrHYcv3aoNKWB2jenfg64Nf+NnoSx9jKfDqXmy27HqdllPpcx/Ev4ddu
         Hupqe38y/pW91nUeepKlRGxrd/bpGqyTxVYAnUxvL5eRb6/b0RYfkz77xhCO7kFNGX7F
         3G9t9CsPCpUWbtsOfXrShZlU5KOMfYYQmIETsHD/xgO4L8vPEB1dsPsZ1ntavdRGwkEz
         2RrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DAs03ze2iLGrXZLZIzptTE6KU69sGQUDBhtzB60KZ0=;
        b=Swv9uN2h0mPjf+HKMKRGSvlMSpKZ4jlZsZdZZMqlMmOgA5EKnOPasrVGZvdv3+sKsh
         YC0vhYMvvQKv59QZgnRwbva/073+i9kaQxI8Nr/7h+H7OVjT7bvy61O3IpAfzt733jVb
         T5APWb0TM81ByYwvQfqSy5hiNVbc1qhj0b6CePWHPBq+TP+I0IehL3SGdlehBY7CdOGS
         wLxTvMMLMc2ss2teUhxcH+yXE0SBxJacaWLK/nz6kAuDM7jslOUol83dMc7dfbXiPJWn
         3eLZeDzC8fXc82TlTRHlHaRsWxLx9D40npPxyqdq1W+NOA268I3HNZpWcmeaH+cC3B7K
         kIFw==
X-Gm-Message-State: AOAM530ouGuArQyVzLPpYo2vQbUtuXBtaT5CJU41B7p0D7SLYy1T7+5i
        hV/sgpivkIOCu9aRarCMguPAPiIPI6vFmqkuCFkqxg==
X-Google-Smtp-Source: ABdhPJyioAE2SKxSLS9PrFpn0//p7URyT0dqGpYfjdEHgPiiaOk8lHLnhTxauAV0nG5h5jit7AW1Hub73wT5H6lwgp8=
X-Received: by 2002:a17:90b:3796:: with SMTP id mz22mr7061634pjb.80.1621371133969;
 Tue, 18 May 2021 13:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210507213110.155492-1-brendanhiggins@google.com>
 <20210507213110.155492-2-brendanhiggins@google.com> <CABVgOS=3ToE-w8PT_p_xqxqs4AR_a4u4LwFAFE-TrMtEEySG=A@mail.gmail.com>
In-Reply-To: <CABVgOS=3ToE-w8PT_p_xqxqs4AR_a4u4LwFAFE-TrMtEEySG=A@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 18 May 2021 13:52:02 -0700
Message-ID: <CAFd5g44kr=qps7y4uCrLJASRHZv1ubCBqHFsspsCgcZt1-yoUw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] kunit: Add 'kunit_shutdown' option
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 15, 2021 at 12:58 AM David Gow <davidgow@google.com> wrote:
>
> On Sat, May 8, 2021 at 5:31 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > From: David Gow <davidgow@google.com>
> >
> > Add a new kernel command-line option, 'kunit_shutdown', which allows the
> > user to specify that the kernel poweroff, halt, or reboot after
> > completing all KUnit tests; this is very handy for running KUnit tests
> > on UML or a VM so that the UML/VM process exits cleanly immediately
> > after running all tests without needing a special initramfs.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > Tested-By: Daniel Latypov <dlatypov@google.com>
> > ---
>
> Obviously I'm okay with this change, but I did find a minor whitespace
> nitpick below.
>
> >  lib/kunit/executor.c                | 20 ++++++++++++++++++++
> >  tools/testing/kunit/kunit_kernel.py |  2 +-
> >  tools/testing/kunit/kunit_parser.py |  2 +-
> >  3 files changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > index 15832ed446685..7db619624437c 100644
> > --- a/lib/kunit/executor.c
> > +++ b/lib/kunit/executor.c
> > @@ -1,5 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >
> > +#include <linux/reboot.h>
> >  #include <kunit/test.h>
> >  #include <linux/glob.h>
> >  #include <linux/moduleparam.h>
> > @@ -18,6 +19,9 @@ module_param(filter_glob, charp, 0);
> >  MODULE_PARM_DESC(filter_glob,
> >                 "Filter which KUnit test suites run at boot-time, e.g. list*");
> >
> > +static char *kunit_shutdown;
> > +core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
> > +
> >  static struct kunit_suite * const *
> >  kunit_filter_subsuite(struct kunit_suite * const * const subsuite)
> >  {
> > @@ -82,6 +86,20 @@ static struct suite_set kunit_filter_suites(void)
> >         return filtered;
> >  }
> >
> > +static void kunit_handle_shutdown(void)
> > +{
> > +       if (!kunit_shutdown)
> > +               return;
> > +
> > +       if (!strcmp(kunit_shutdown, "poweroff"))
> > +               kernel_power_off();
> > +       else if (!strcmp(kunit_shutdown, "halt"))
> > +               kernel_halt();
> > +       else if (!strcmp(kunit_shutdown, "reboot"))
> > +               kernel_restart(NULL);
> > +
> > +}
> > +
> >  static void kunit_print_tap_header(struct suite_set *suite_set)
> >  {
> >         struct kunit_suite * const * const *suites, * const *subsuite;
> > @@ -112,6 +130,8 @@ int kunit_run_all_tests(void)
> >                 kfree(suite_set.start);
> >         }
> >
> > +       kunit_handle_shutdown();
> > +
> >         return 0;
> >  }
> >
> > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> > index 89a7d4024e878..e22ade9d91ad5 100644
> > --- a/tools/testing/kunit/kunit_kernel.py
> > +++ b/tools/testing/kunit/kunit_kernel.py
> > @@ -208,7 +208,7 @@ class LinuxSourceTree(object):
> >         def run_kernel(self, args=None, build_dir='', filter_glob='', timeout=None) -> Iterator[str]:
> >                 if not args:
> >                         args = []
> > -               args.extend(['mem=1G', 'console=tty'])
> > +               args.extend(['mem=1G', 'console=tty','kunit_shutdown=halt'])
> Nit: space here between 'console=tty', and 'kunit_shutdown=halt'.

Whoops, I probably introduced it after addressing a rebase conflict.

Thanks, will fix.

> >                 if filter_glob:
> >                         args.append('kunit.filter_glob='+filter_glob)
> >                 self._ops.linux_bin(args, timeout, build_dir)
> > diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> > index e8bcc139702e2..8d8d4d70b39dd 100644
> > --- a/tools/testing/kunit/kunit_parser.py
> > +++ b/tools/testing/kunit/kunit_parser.py
> > @@ -49,7 +49,7 @@ class TestStatus(Enum):
> >
> >  kunit_start_re = re.compile(r'TAP version [0-9]+$')
> >  kunit_end_re = re.compile('(List of all partitions:|'
> > -                         'Kernel panic - not syncing: VFS:)')
> > +                         'Kernel panic - not syncing: VFS:|reboot: System halted)')
> >
> >  def isolate_kunit_output(kernel_output) -> Iterator[str]:
> >         started = False
> > --
> > 2.31.1.607.g51e8a6a459-goog
> >
