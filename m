Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC5F222856
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jul 2020 18:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgGPQgC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jul 2020 12:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbgGPQgC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jul 2020 12:36:02 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B56C08C5C0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jul 2020 09:36:01 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id p7so2989475qvl.4
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jul 2020 09:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=TLyzrMoUQJBrFIS7h6/Ao3hqwvcAjDtd5BjTOluL9gg=;
        b=GrgSKDhxqKx4Ttoo/eEntuPwJVU7FTTnuxxRBHCdAjExk8jst+SL8WG4eAnNH+xe55
         zd+2bXboDcoeeDCO4XWH8BAjiML8Zjwt9mMp3k1x/2lkEmsAc1N9grJFKb/4MYa5GeCV
         JG7Dn0t2rCXzeN4phClA3yDyZuUDDFxKEvSj9vVRHsXzGxKFU7Lp7YfxDcQQISgt1ImM
         ee5DgE8JsaMj1Pd//bpOa2k4JCGW+03m2y3rvMs0Hv94t42sXb3NLlXtlZ8ywnQ24aBa
         GilOZX8Ep5MV70Mm5D2bFUFfvzTAZ/pZQdp9+wcPz2nbMqdhephslTLUXthYNHdj1ZXt
         ps6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=TLyzrMoUQJBrFIS7h6/Ao3hqwvcAjDtd5BjTOluL9gg=;
        b=dAtriXwwpGTCdHqtVG+aZt8JK5x+e2auNwbjQKjgYd0Q/DrN1uyVrns5TjPdHgtL9U
         9O680eEd531FvG860Yijnjt/+5KCW4TyoyKHyxxMYWkQEWka6gykDYHM78t2MIPV3C4n
         OcGvhJYKWojplZAdHdIjo3hE6ixW9O21CQF1Lo52jhdr4OE9Id7UPrmiyqDG//mjSJ+q
         SWLKokpH0iVuuiAa+LccYDMNPfE2FuwsxvmoS7TTU3SRS+OrQAQxOgCmx5VUZuwXWWOn
         D+vXsGEV2AqpJoQVQVNn4EBb3ufcGLjwdAE7NTrxLb6TjqI+cPK/QUy7MJaitwnJ7AXU
         nY7g==
X-Gm-Message-State: AOAM530ascOnvQQgUfcNuJaby+pZq8mNND3K3Qohq5gI/UvjqRLhoQYD
        rs8zvm5hMU9vjc5jkhT/VmXeEA==
X-Google-Smtp-Source: ABdhPJzDAQdsuQfj+FrH2AKPIAzSqhhNwiffQw3ilVWX5dglvzazNFagj3w1wfSFixQ3ZB7ypXcGPw==
X-Received: by 2002:a0c:f683:: with SMTP id p3mr5009130qvn.39.1594917361013;
        Thu, 16 Jul 2020 09:36:01 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id g1sm7742608qkl.86.2020.07.16.09.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 09:36:00 -0700 (PDT)
Message-ID: <ccf310f7b7f5368be09868f7f782096a45b779f1.camel@massaru.org>
Subject: Re: [RFC 2/3] lib: Allows to borrow mm in userspace on KUnit
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Thu, 16 Jul 2020 13:35:57 -0300
In-Reply-To: <CAFd5g47HPGjX4AYuBCjH8DqSUMNO+yqjudWH+ZNovStM+aXExA@mail.gmail.com>
References: <20200715031120.1002016-1-vitor@massaru.org>
         <20200715031120.1002016-3-vitor@massaru.org>
         <CAFd5g47HPGjX4AYuBCjH8DqSUMNO+yqjudWH+ZNovStM+aXExA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2020-07-15 at 17:37 -0700, Brendan Higgins wrote:
> On Tue, Jul 14, 2020 at 8:11 PM Vitor Massaru Iha <vitor@massaru.org>
> wrote:
> 
> Probably want to add more of a description here as what you are doing
> is not entirely trivial to someone not familiar with mm contexts.
> 
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > ---
> >  include/kunit/test.h  |  1 +
> >  lib/kunit/try-catch.c | 15 ++++++++++++++-
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 59f3144f009a..49c38bdcb93e 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -222,6 +222,7 @@ struct kunit {
> >          * protect it with some type of lock.
> >          */
> >         struct list_head resources; /* Protected by lock. */
> > +       struct mm_struct *mm;
> 
> Part of me thinks we should put a better name here, part of me thinks
> it is fine because it matches the convention.
> 
> Either way, this DEFINITELY deserves a comment explaining what it is,
> why it exists, and how it should/shouldn't be used.
> 
> >  };
> > 
> >  void kunit_init_test(struct kunit *test, const char *name, char
> > *log);
> > diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> > index 0dd434e40487..f677c2f2a51a 100644
> > --- a/lib/kunit/try-catch.c
> > +++ b/lib/kunit/try-catch.c
> > @@ -11,7 +11,8 @@
> >  #include <linux/completion.h>
> >  #include <linux/kernel.h>
> >  #include <linux/kthread.h>
> > -
> > +#include <linux/sched/mm.h>
> > +#include <linux/sched/task.h>
> >  #include "try-catch-impl.h"
> > 
> >  void __noreturn kunit_try_catch_throw(struct kunit_try_catch
> > *try_catch)
> > @@ -24,8 +25,17 @@ EXPORT_SYMBOL_GPL(kunit_try_catch_throw);
> >  static int kunit_generic_run_threadfn_adapter(void *data)
> >  {
> >         struct kunit_try_catch *try_catch = data;
> > +       struct kunit *test = try_catch->test;
> > +
> > +       if (test->mm != NULL)
> > +               kthread_use_mm(try_catch->test->mm);
> > 
> >         try_catch->try(try_catch->context);
> > +       if (try_catch->test->mm) {
> 
> Here and below: You already have a pointer to test. You should use
> it.

Ops, thanks!
> 
> > +               if (test->mm != NULL)
> > +                       kthread_unuse_mm(try_catch->test->mm);
> > +               try_catch->test->mm = NULL;
> > +       }
> > 
> >         complete_and_exit(try_catch->try_completion, 0);
> >  }
> > @@ -65,6 +75,9 @@ void kunit_try_catch_run(struct kunit_try_catch
> > *try_catch, void *context)
> >         try_catch->context = context;
> >         try_catch->try_completion = &try_completion;
> >         try_catch->try_result = 0;
> > +
> > +       test->mm = get_task_mm(current);
> > +
> >         task_struct =
> > kthread_run(kunit_generic_run_threadfn_adapter,
> >                                   try_catch,
> >                                   "kunit_try_catch_thread");
> > --
> > 2.26.2
> > 

