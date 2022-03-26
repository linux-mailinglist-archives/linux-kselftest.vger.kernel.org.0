Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74614E7EED
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Mar 2022 05:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiCZE3g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 26 Mar 2022 00:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiCZE3f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 26 Mar 2022 00:29:35 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353CD3AA60
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 21:27:59 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so10046839wmj.0
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 21:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wXjQomr6Ua4s3PfVrkfMx69oLfa65TadzK4GjLZb12k=;
        b=Uoan5FLW5aJ/AKTslmBZagRi1tYDmzDv3sYMU5/xS7rsUTI7XhkwrLKETpfoO2H14w
         ou3v9kWudprahOUJ9UyJzbJROUgCsdwSyG7EHIYJlPycrLpREbwIZAd4jZ8MrtaXwupF
         zw7MxWk+AZmV6vXxZBQWNITt5rdYU7IRVm1IRyMpch2DGWG0D14sYASm+lp+l8rFjHWP
         Qmpbi2IvIK5/wu8yO94ERx90iwnexfL+lN7poY6I8tL8QcWHwxLZ9aUeVwk54XI33Oxm
         ItsI5z5qoYe/t5zLXR+8qqD/RBzMxDR6hR9Ri2sgEpmWrvaa+PACFDgDVeeLBg3+mnm8
         YsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wXjQomr6Ua4s3PfVrkfMx69oLfa65TadzK4GjLZb12k=;
        b=OtvWLrtl6fX3A0KY9hdYhyo1q0al4DzZ/WSZ+66gI/N+NlgargLy+exvZakkD49Ji9
         7/oKhrL1F2itZ9MuSP73rvUcVp0VeL+bEQivOFMul2fQs2kW5wHh6qJ/8vJlGcXf5j3x
         20AJEOlAfQ4nrpQZD8LmKUw8e8zCodUCLL5AkiK6UuCXTxJK92HmA1g2031b3+sBMd2o
         nj/Boht7E7Lf0XDG6SMz4Tw5O6P/Nrx6sfuid0YU67APfJUVVp9lJ3mHJ2nwkrFXGg4G
         1DfLoG/jThCSgl6QPdZ3HgmCeawjxGiewIMUP8jcmLlCYvRmiQjwygQprH1SbkWxT7L+
         sVWQ==
X-Gm-Message-State: AOAM5326DEbXWXC9eDiv9gl2Fwv9MaKmqaVFuxoOvafXCOFbKFxAiUav
        gi6up8qcHrgiUJ/SwxrDDnpwfJ7DYpmnh4Lh36MQBQ==
X-Google-Smtp-Source: ABdhPJwARGDiTO39yg6O9KNmUsWTzj/6mLa4Hh2JdflHE8NFPWrdc9eBxiXEOHA3S+RoWuPvYJueYFcpWb+kqg1g/tg=
X-Received: by 2002:a05:600c:4f48:b0:38c:a460:cb6 with SMTP id
 m8-20020a05600c4f4800b0038ca4600cb6mr13577299wmq.96.1648268877617; Fri, 25
 Mar 2022 21:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220326002013.483394-1-dlatypov@google.com> <20220326002013.483394-2-dlatypov@google.com>
In-Reply-To: <20220326002013.483394-2-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 26 Mar 2022 12:27:46 +0800
Message-ID: <CABVgOSm+o=t=8hgR=T676rHJjWp0p-VXeoZt28G0kVqURqCGMg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kunit: split resource API impl from test.c into
 new resource.c
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Mar 26, 2022 at 8:20 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> We've split out the declarations from include/kunit/test.h into
> resource.h.
> This patch splits out the definitions as well for consistency.
>
> A side effect of this is git blame won't properly track history by
> default, users need to run
> $ git blame -L ,1 -C13 lib/kunit/resource.c
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Looks good and works fine here. I'm going to try to rebase most of the
other resource system stuff I'm working on on top of these (which will
likely end up moving a bunch of code _again_, but is probably the
least terrible of all the available options).

One nitpick (newline at end of file) below, otherwise this is good.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/Makefile   |   1 +
>  lib/kunit/resource.c | 126 +++++++++++++++++++++++++++++++++++++++++++
>  lib/kunit/test.c     | 116 +--------------------------------------
>  3 files changed, 128 insertions(+), 115 deletions(-)
>  create mode 100644 lib/kunit/resource.c
>
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index c49f4ffb6273..29aff6562b42 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -1,6 +1,7 @@
>  obj-$(CONFIG_KUNIT) +=                 kunit.o
>
>  kunit-objs +=                          test.o \
> +                                       resource.o \
>                                         string-stream.o \
>                                         assert.o \
>                                         try-catch.o \
> diff --git a/lib/kunit/resource.c b/lib/kunit/resource.c
> new file mode 100644
> index 000000000000..b8bced246217
> --- /dev/null
> +++ b/lib/kunit/resource.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit resource API for test managed resources (allocations, etc.).
> + *
> + * Copyright (C) 2022, Google LLC.
> + * Author: Daniel Latypov <dlatypov@google.com>
> + */
> +
> +#include <kunit/resource.h>
> +#include <kunit/test.h>
> +#include <linux/kref.h>
> +
> +/*
> + * Used for static resources and when a kunit_resource * has been created by
> + * kunit_alloc_resource().  When an init function is supplied, @data is passed
> + * into the init function; otherwise, we simply set the resource data field to
> + * the data value passed in.
> + */
> +int kunit_add_resource(struct kunit *test,
> +                      kunit_resource_init_t init,
> +                      kunit_resource_free_t free,
> +                      struct kunit_resource *res,
> +                      void *data)
> +{
> +       int ret = 0;
> +       unsigned long flags;
> +
> +       res->free = free;
> +       kref_init(&res->refcount);
> +
> +       if (init) {
> +               ret = init(res, data);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               res->data = data;
> +       }
> +
> +       spin_lock_irqsave(&test->lock, flags);
> +       list_add_tail(&res->node, &test->resources);
> +       /* refcount for list is established by kref_init() */
> +       spin_unlock_irqrestore(&test->lock, flags);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(kunit_add_resource);
> +
> +int kunit_add_named_resource(struct kunit *test,
> +                            kunit_resource_init_t init,
> +                            kunit_resource_free_t free,
> +                            struct kunit_resource *res,
> +                            const char *name,
> +                            void *data)
> +{
> +       struct kunit_resource *existing;
> +
> +       if (!name)
> +               return -EINVAL;
> +
> +       existing = kunit_find_named_resource(test, name);
> +       if (existing) {
> +               kunit_put_resource(existing);
> +               return -EEXIST;
> +       }
> +
> +       res->name = name;
> +
> +       return kunit_add_resource(test, init, free, res, data);
> +}
> +EXPORT_SYMBOL_GPL(kunit_add_named_resource);
> +
> +struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
> +                                                   kunit_resource_init_t init,
> +                                                   kunit_resource_free_t free,
> +                                                   gfp_t internal_gfp,
> +                                                   void *data)
> +{
> +       struct kunit_resource *res;
> +       int ret;
> +
> +       res = kzalloc(sizeof(*res), internal_gfp);
> +       if (!res)
> +               return NULL;
> +
> +       ret = kunit_add_resource(test, init, free, res, data);
> +       if (!ret) {
> +               /*
> +                * bump refcount for get; kunit_resource_put() should be called
> +                * when done.
> +                */
> +               kunit_get_resource(res);
> +               return res;
> +       }
> +       return NULL;
> +}
> +EXPORT_SYMBOL_GPL(kunit_alloc_and_get_resource);
> +
> +void kunit_remove_resource(struct kunit *test, struct kunit_resource *res)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&test->lock, flags);
> +       list_del(&res->node);
> +       spin_unlock_irqrestore(&test->lock, flags);
> +       kunit_put_resource(res);
> +}
> +EXPORT_SYMBOL_GPL(kunit_remove_resource);
> +
> +int kunit_destroy_resource(struct kunit *test, kunit_resource_match_t match,
> +                          void *match_data)
> +{
> +       struct kunit_resource *res = kunit_find_resource(test, match,
> +                                                        match_data);
> +
> +       if (!res)
> +               return -ENOENT;
> +
> +       kunit_remove_resource(test, res);
> +
> +       /* We have a reference also via _find(); drop it. */
> +       kunit_put_resource(res);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(kunit_destroy_resource);
> +

.git/rebase-apply/patch:151: new blank line at EOF.

+

> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 3bca3bf5c15b..0f66c13d126e 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -6,10 +6,10 @@
>   * Author: Brendan Higgins <brendanhiggins@google.com>
>   */
>
> +#include <kunit/resource.h>
>  #include <kunit/test.h>
>  #include <kunit/test-bug.h>
>  #include <linux/kernel.h>
> -#include <linux/kref.h>
>  #include <linux/moduleparam.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched.h>
> @@ -592,120 +592,6 @@ void __kunit_test_suites_exit(struct kunit_suite **suites)
>  }
>  EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
>
> -/*
> - * Used for static resources and when a kunit_resource * has been created by
> - * kunit_alloc_resource().  When an init function is supplied, @data is passed
> - * into the init function; otherwise, we simply set the resource data field to
> - * the data value passed in.
> - */
> -int kunit_add_resource(struct kunit *test,
> -                      kunit_resource_init_t init,
> -                      kunit_resource_free_t free,
> -                      struct kunit_resource *res,
> -                      void *data)
> -{
> -       int ret = 0;
> -       unsigned long flags;
> -
> -       res->free = free;
> -       kref_init(&res->refcount);
> -
> -       if (init) {
> -               ret = init(res, data);
> -               if (ret)
> -                       return ret;
> -       } else {
> -               res->data = data;
> -       }
> -
> -       spin_lock_irqsave(&test->lock, flags);
> -       list_add_tail(&res->node, &test->resources);
> -       /* refcount for list is established by kref_init() */
> -       spin_unlock_irqrestore(&test->lock, flags);
> -
> -       return ret;
> -}
> -EXPORT_SYMBOL_GPL(kunit_add_resource);
> -
> -int kunit_add_named_resource(struct kunit *test,
> -                            kunit_resource_init_t init,
> -                            kunit_resource_free_t free,
> -                            struct kunit_resource *res,
> -                            const char *name,
> -                            void *data)
> -{
> -       struct kunit_resource *existing;
> -
> -       if (!name)
> -               return -EINVAL;
> -
> -       existing = kunit_find_named_resource(test, name);
> -       if (existing) {
> -               kunit_put_resource(existing);
> -               return -EEXIST;
> -       }
> -
> -       res->name = name;
> -
> -       return kunit_add_resource(test, init, free, res, data);
> -}
> -EXPORT_SYMBOL_GPL(kunit_add_named_resource);
> -
> -struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
> -                                                   kunit_resource_init_t init,
> -                                                   kunit_resource_free_t free,
> -                                                   gfp_t internal_gfp,
> -                                                   void *data)
> -{
> -       struct kunit_resource *res;
> -       int ret;
> -
> -       res = kzalloc(sizeof(*res), internal_gfp);
> -       if (!res)
> -               return NULL;
> -
> -       ret = kunit_add_resource(test, init, free, res, data);
> -       if (!ret) {
> -               /*
> -                * bump refcount for get; kunit_resource_put() should be called
> -                * when done.
> -                */
> -               kunit_get_resource(res);
> -               return res;
> -       }
> -       return NULL;
> -}
> -EXPORT_SYMBOL_GPL(kunit_alloc_and_get_resource);
> -
> -void kunit_remove_resource(struct kunit *test, struct kunit_resource *res)
> -{
> -       unsigned long flags;
> -
> -       spin_lock_irqsave(&test->lock, flags);
> -       list_del(&res->node);
> -       spin_unlock_irqrestore(&test->lock, flags);
> -       kunit_put_resource(res);
> -}
> -EXPORT_SYMBOL_GPL(kunit_remove_resource);
> -
> -int kunit_destroy_resource(struct kunit *test, kunit_resource_match_t match,
> -                          void *match_data)
> -{
> -       struct kunit_resource *res = kunit_find_resource(test, match,
> -                                                        match_data);
> -
> -       if (!res)
> -               return -ENOENT;
> -
> -       kunit_remove_resource(test, res);
> -
> -       /* We have a reference also via _find(); drop it. */
> -       kunit_put_resource(res);
> -
> -       return 0;
> -}
> -EXPORT_SYMBOL_GPL(kunit_destroy_resource);
> -
>  struct kunit_kmalloc_array_params {
>         size_t n;
>         size_t size;
> --
> 2.35.1.1021.g381101b075-goog
>
