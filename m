Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FA141F963
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Oct 2021 04:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhJBCcX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Oct 2021 22:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbhJBCcW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Oct 2021 22:32:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61303C061775
        for <linux-kselftest@vger.kernel.org>; Fri,  1 Oct 2021 19:30:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o20so250087wro.3
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Oct 2021 19:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UMh51B3b6FYmnb33I2GV5L8AvSN4pCytU6644sWrlfk=;
        b=b9aUfOdAGzeBOtL59sbNQYcBBj8Udk3c4xNexPYPvyy8Aosh2spdF2LuYQ+GNzRAyo
         00Hl6SQ5l+zSXyaIq6KvtRiFJqPuhqY+VLM+w0Ut1L823QaG/xlB8qLZpmSD1JK6c5G9
         OrOoWXBPGNJT9lvzFCorPOroOIGmjre6tIzkXkbq4rbP85cRzh8dfXvS8GzvZBLSq4So
         YuPQsP5+aqVcXfG0dC87dPnqh5NQdyk6MFlZrw3huSdy9tUB4yiylRTAC87I9ioHmpwD
         SExNwupv+zwhwosAv4ATwlq55GXFMrbHL3gXj2cNctrrU/ML4nF9PxA/2IIOdoXNd2xd
         0M0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UMh51B3b6FYmnb33I2GV5L8AvSN4pCytU6644sWrlfk=;
        b=3QDeiwUrdb7ypGvFX9qYIZg1SSNuvct17UleECQxRHe2BdYgApUCmMi0LgLsse7Fg+
         9URzOA8EtdPzAT0/jXf4caCrRahHBPNpCmivyriCtAi/NxEMRxysroqnDQOIe0f1AGN8
         Qdss4Q5U4Fi/dGn8KYTzBwmcqfGI+vvZ856mf9LfwaPg7X9KichirzW5PslkIpG5628d
         5W8maUGGL110DrhzhDPLNGizea+4nIByzHRswM2EKpTuJl3tu/0jMrVIwnt3/9SXhxdz
         YBKyh/bXGEErTcLg4MznR+NRy4Aw1nnYWp7kMQnzzvlyRfeDURE1mBOdikXGNag/ChYB
         fcMw==
X-Gm-Message-State: AOAM530vL62AM7zSibmbiaVMdq6shwacXrZ3bozqhg3JjyCFKRbIv9c+
        Kx123YWkciTeBd2VRxsgO51vZ+HY2ck9zJxrkVwHGA==
X-Google-Smtp-Source: ABdhPJxikstrm9jmSMZmpWNGPb3ALM8GchQtWXgLkLwW7XltIlyBMGnOIq+/eSt2Xn9gdsO1M7LH+BxuUWesco7foTU=
X-Received: by 2002:a5d:4882:: with SMTP id g2mr1110886wrq.399.1633141834469;
 Fri, 01 Oct 2021 19:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211002013635.2076371-1-dlatypov@google.com>
In-Reply-To: <20211002013635.2076371-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 2 Oct 2021 10:30:23 +0800
Message-ID: <CABVgOS=kaU=6uK-oBV_JjDD=S8TPmaPKbqjOtRPQ2wBXyw1s6g@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix too small allocation when using suite-only kunit.filter_glob
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 2, 2021 at 9:36 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> When a user filters by a suite and not a test, e.g.
> $ ./tools/testing/kunit/kunit.py run 'suite_name'
>
> it hits this code
>   const int len = strlen(filter_glob);
>   ...
>   parsed->suite_glob = kmalloc(len, GFP_KERNEL);
> which fails to allocate space for the terminating NULL.
>
> Somehow, it seems like we can't easily reproduce this under UML, so the
> existing `parse_filter_test()` didn't catch this.
>
> Fix this by allocating `len + 1` and switch to kzalloc() just to be a
> bit more defensive. We're only going to run this code once per kernel
> boot, and it should never be very long.
>
> Also update the unit tests to be a bit more cautious.
> This bug showed up as a NULL pointer dereference here:
> >  KUNIT_EXPECT_STREQ(test, (const char *)filtered.start[0][0]->name, "suite0");
> `filtered.start[0][0]` was NULL, and `name` is at offset 0 in the struct,
> so `...->name` was also NULL.
>
> Fixes: 3b29021ddd10 ("kunit: tool: allow filtering test cases via glob")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Nice catch. I guess this is why we're all going to be switching to
rust one day. :-)

The fix looks good, and I ran it under KASAN just to be sure, and it passed.

Reviewed-by: David Gow <davidgow@google.com>

-- David

>  lib/kunit/executor.c      | 2 +-
>  lib/kunit/executor_test.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index bab3ab940acc..1d7fecd33261 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -33,7 +33,7 @@ static void kunit_parse_filter_glob(struct kunit_test_filter *parsed,
>         const char *period = strchr(filter_glob, '.');
>
>         if (!period) {
> -               parsed->suite_glob = kmalloc(len, GFP_KERNEL);
> +               parsed->suite_glob = kzalloc(len + 1, GFP_KERNEL);
>                 parsed->test_glob = NULL;
>                 strcpy(parsed->suite_glob, filter_glob);
>                 return;
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index e6323f398dfa..7d2b8dc668b1 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -149,6 +149,7 @@ static void filter_suites_test(struct kunit *test)
>
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start[0]);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start[0][0]);
>         KUNIT_EXPECT_STREQ(test, (const char *)filtered.start[0][0]->name, "suite0");
>  }
>
>
> base-commit: 3b29021ddd10cfb6b2565c623595bd3b02036f33
> --
> 2.33.0.800.g4c38ced690-goog
>
