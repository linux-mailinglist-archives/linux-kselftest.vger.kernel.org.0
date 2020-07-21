Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173712288E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jul 2020 21:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbgGUTIN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jul 2020 15:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730199AbgGUTGq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jul 2020 15:06:46 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9884C0619DE
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jul 2020 12:06:45 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l63so12359019pge.12
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jul 2020 12:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xl+gcvbDXd+PfVKLLD+1C1XM5QV+nhoL7JR5M/5kIIw=;
        b=gG1XFwUzVGKnd9WToMSC6L9L3IGTQ2wskP5zZ6bBwaanIpcpjC1GTOeAoRfRCUKHLd
         M1QJFNd1TTAChK9jBiH3oetqIg4srx0NUdbyizMl7shh1YAxIs2rnPaWm8z8uErvaBog
         sYaP7rQOCsMzb6+VXzC2BZ7sqHcQEyxQxPC3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xl+gcvbDXd+PfVKLLD+1C1XM5QV+nhoL7JR5M/5kIIw=;
        b=dYwmUUSW1LZ4O+grytSy7dB96KQokSQoSu7D2EVT6RBJNeGMBTGpfvTX7dA1DNzIov
         jMt2nWuQI/tsIR0nYfbTr5F5uEYxe9g/St10NiPsO8Mfo8GPSIGH6qGLKJqvkE7P1HZR
         Owybv0LHOXP5Nspwqez81BlUG2mQgneTF8d1y6WSOAsW2wER+QrF3sXgxDs/60XdUrWb
         pBO760BgYLsNGsFEIyHADsak/bCMnwoIfTz8wLjIy5ouVHzZtoE1bLr19Uh9hzPWPevU
         1CE3GkC3hgblzFm2N6HNWZoCTVoLqF8VCxhQz8t9/xvJNqRVseb1KX26Go5UmJGNQUwh
         0yew==
X-Gm-Message-State: AOAM531WF/j71kh7YJ3nRs8XqpMtWmoKNN8DwE2chuuFHt0/j07G+DDA
        aaagFfK1uhVIce7O3dP3CAIIyQ==
X-Google-Smtp-Source: ABdhPJzdfjK4EdVt5krNNTVtPzDsIEu++0oOObpGAk6TLAH/OkgIn/qunDavfBeMmNmdR9OMWfKCUA==
X-Received: by 2002:a63:7c42:: with SMTP id l2mr24525349pgn.35.1595358405368;
        Tue, 21 Jul 2020 12:06:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y198sm21516181pfg.116.2020.07.21.12.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 12:06:44 -0700 (PDT)
Date:   Tue, 21 Jul 2020 12:06:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        davidgow@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] lib: kunit: Provides a userspace memory context when
 tests are compiled as module
Message-ID: <202007211203.6CFE2F19BE@keescook>
References: <20200721174036.71072-1-vitor@massaru.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721174036.71072-1-vitor@massaru.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 21, 2020 at 02:40:36PM -0300, Vitor Massaru Iha wrote:
> KUnit test cases run on kthreads, and kthreads don't have an
> adddress space (current->mm is NULL), but processes have mm.
> 
> The purpose of this patch is to allow to borrow mm to KUnit kthread
> after userspace is brought up, because we know that there are processes
> running, at least the process that loaded the module to borrow mm.
> 
> This allows, for example, tests such as user_copy_kunit, which uses
> vm_mmap, which needs current->mm.

Ah! In the case of kunit starting before there IS a userspace...
interesting.

> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> ---
> v2:
>     * splitted patch in 3:
>         - Allows to install and load modules in root filesystem;
>         - Provides an userspace memory context when tests are compiled
>           as module;
>         - Convert test_user_copy to KUnit test;
>     * added documentation;
>     * added more explanation;
>     * added a missed test pointer;
>     * released mm with mmput();
> v3:
>     * rebased with last kunit branch
>     * Please apply this commit from kunit-fixes:
>         3f37d14b8a3152441f36b6bc74000996679f0998
> 
>  Documentation/dev-tools/kunit/usage.rst | 14 ++++++++++++++
>  include/kunit/test.h                    | 12 ++++++++++++
>  lib/kunit/try-catch.c                   | 15 ++++++++++++++-
>  3 files changed, 40 insertions(+), 1 deletion(-)
> ---
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 3c3fe8b5fecc..9f909157be34 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -448,6 +448,20 @@ We can now use it to test ``struct eeprom_buffer``:
> 
>  .. _kunit-on-non-uml:
> 
> +User-space context
> +------------------
> +
> +I case you need a user-space context, for now this is only possible through

typo: In case ...

> +tests compiled as a module. And it will be necessary to use a root filesystem
> +and uml_utilities.
> +
> +Example:
> +
> +.. code-block:: bash
> +
> +   ./tools/testing/kunit/kunit.py run --timeout=60 --uml_rootfs_dir=.uml_rootfs
> +
> +
>  KUnit on non-UML architectures
>  ==============================
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 59f3144f009a..ae3337139c65 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -222,6 +222,18 @@ struct kunit {
>  	 * protect it with some type of lock.
>  	 */
>  	struct list_head resources; /* Protected by lock. */
> +	/*
> +	 * KUnit test cases run on kthreads, and kthreads don't have an
> +	 * adddress space (current->mm is NULL), but processes have mm.
> +	 *
> +	 * The purpose of this mm_struct is to allow to borrow mm to KUnit kthread
> +	 * after userspace is brought up, because we know that there are processes
> +	 * running, at least the process that loaded the module to borrow mm.
> +	 *
> +	 * This allows, for example, tests such as user_copy_kunit, which uses
> +	 * vm_mmap, which needs current->mm.
> +	 */
> +	struct mm_struct *mm;

I have a general concern that this will need more careful solving in the
future as there are likely to be many tests that need a userspace
context to operate sanely. But that's just a note; this solves the
specific case now.

>  };
> 
>  void kunit_init_test(struct kunit *test, const char *name, char *log);
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index 0dd434e40487..d03e2093985b 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -11,7 +11,8 @@
>  #include <linux/completion.h>
>  #include <linux/kernel.h>
>  #include <linux/kthread.h>
> -
> +#include <linux/sched/mm.h>
> +#include <linux/sched/task.h>
>  #include "try-catch-impl.h"
> 
>  void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)
> @@ -24,8 +25,17 @@ EXPORT_SYMBOL_GPL(kunit_try_catch_throw);
>  static int kunit_generic_run_threadfn_adapter(void *data)
>  {
>  	struct kunit_try_catch *try_catch = data;
> +	struct kunit *test = try_catch->test;
> +
> +	if (test != NULL && test->mm != NULL)
> +		kthread_use_mm(test->mm);
> 
>  	try_catch->try(try_catch->context);
> +	if (test != NULL && test->mm != NULL) {
> +		kthread_unuse_mm(test->mm);
> +		mmput(test->mm);
> +		test->mm = NULL;

This mmput() seems unbalanced... see below.

> +	}
> 
>  	complete_and_exit(try_catch->try_completion, 0);
>  }
> @@ -65,6 +75,9 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
>  	try_catch->context = context;
>  	try_catch->try_completion = &try_completion;
>  	try_catch->try_result = 0;
> +
> +	test->mm = get_task_mm(current);
> +
>  	task_struct = kthread_run(kunit_generic_run_threadfn_adapter,
>  				  try_catch,
>  				  "kunit_try_catch_thread");

Isn't there something that destroys a "struct kunit"? I would expect
that to perform the mmput(). Why is it up in the threadfn?

> 
> base-commit: d43c7fb05765152d4d4a39a8ef957c4ea14d8847
> --
> 2.26.2
> 

-- 
Kees Cook
