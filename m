Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2FE7AAA57
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Sep 2023 09:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjIVHeq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 03:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjIVHem (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 03:34:42 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795ADF7
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Sep 2023 00:34:35 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53074ee0c2aso8444a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Sep 2023 00:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695368074; x=1695972874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K5zfdaunYQTmV6YNygu+cahM/gn1GwaaC8BvjKIZIUE=;
        b=W+6UYy6mKxmu9s41nTzdvz1NsyV/N1jqKiIsUtJUjBLDNghhaQQAsLQYtstQ+uJKAn
         19hchToa5i6r2cI8NrhoZhh6rPE8zHDosBtn7aDYODXJRwt4/I+ozpiunDMzESBnqMWC
         5XMP2wMbi8+oi1eflIc1up8+twGfOmYRyijxOplhoDXYVwYK5+dfdmdtUitxPGXJy3o5
         FvsV/xsRDj8i9TWslEbBUYEVVOPaT33UKFWWBjEG2QWnoRALqwhJgIXwxzY/nVjEl6vJ
         QYOTF136TG2DRCq8yCWSbDQWZ+QOq9YG+HCBUSIbgy5jdcaEnbflM0K7rQJao75khu/I
         Q+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695368074; x=1695972874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5zfdaunYQTmV6YNygu+cahM/gn1GwaaC8BvjKIZIUE=;
        b=ijliTgFxxacbKym5zUG4ZnhN/FH1/eosCcwCbvdypK16U0qOiDnrYRhg24fgWBKwwn
         BsNnsdPZZbP0MXsBlRHXoX7E3BH7HM7A7ix9tjKTFML7W0gAhafEerRY1ZXwtTYHMV0z
         aUC8E9lgLktga4i4D6OPGkH0srTwThEWMqEcZ7oeHXPRqEBtuplcg0UXXky8/93OUKQJ
         aCz8pxRRUML94inSanfBBm6oO7iP02zZQM2uvEdd6xr59jQVp0GSlW/EKiygvAFqpja8
         OkOg8P79mVaAX9fmJHtwAH5//rbYtqk++48jCuz/+JlxHJl5vlC/jhK6VET+rXFRbowY
         /5/A==
X-Gm-Message-State: AOJu0YzZFwla3V7YIBTAWlUmf7bwLWLVQvMfKyfkRJu00bPLh0ZahjGD
        27Gx6t7uXYA69fePQb0DeqbCtJmbys4NcBOZvJy6PA==
X-Google-Smtp-Source: AGHT+IEPLuo6LrBmKTy++ho0VHpctxc6V8ieemPAES8C644JmizFcjEU7ZFq5FdTexY1xMC4IOIK9BbSoQFW/52zNEo=
X-Received: by 2002:a50:d083:0:b0:52f:5f65:873c with SMTP id
 v3-20020a50d083000000b0052f5f65873cmr28334edd.3.1695368073862; Fri, 22 Sep
 2023 00:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230921014008.3887257-1-ruanjinjie@huawei.com> <20230921014008.3887257-5-ruanjinjie@huawei.com>
In-Reply-To: <20230921014008.3887257-5-ruanjinjie@huawei.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 22 Sep 2023 15:34:22 +0800
Message-ID: <CABVgOSkfctCd0KUQaRJDzOjp5wjOxFz+W-LZ11cC39=dDpQ8=A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] kunit: test: Fix the possible memory leak in executor_test
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     brendan.higgins@linux.dev, skhan@linuxfoundation.org,
        dlatypov@google.com, rmoar@google.com,
        janusz.krzysztofik@linux.intel.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d42c490605eda323"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000d42c490605eda323
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Sept 2023 at 09:41, 'Jinjie Ruan' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> When CONFIG_KUNIT_ALL_TESTS=y, making CONFIG_DEBUG_KMEMLEAK=y and
> CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y, the below memory leak is detected.
>
> If kunit_filter_suites() succeeds, not only copy but also filtered_suite
> and filtered_suite->test_cases should be freed.
>
> So use kunit_free_suite_set() to free the filtered_suite,
> filtered_suite->test_cases and copy as kunit_module_exit() and
> kunit_run_all_tests() do it. And the func kfree_at_end() is not used so
> remove it. After applying this patch, the following memory leak is never
> detected.
>
> unreferenced object 0xffff8881001de400 (size 1024):
>   comm "kunit_try_catch", pid 1396, jiffies 4294720452 (age 932.801s)
>   hex dump (first 32 bytes):
>     73 75 69 74 65 32 00 00 00 00 00 00 00 00 00 00  suite2..........
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff817db753>] __kmalloc_node_track_caller+0x53/0x150
>     [<ffffffff817bd242>] kmemdup+0x22/0x50
>     [<ffffffff829e961d>] kunit_filter_suites+0x44d/0xcc0
>     [<ffffffff829eb69f>] filter_suites_test+0x12f/0x360
>     [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
>     [<ffffffff81236fc6>] kthread+0x2b6/0x380
>     [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
>     [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
> unreferenced object 0xffff8881052cd388 (size 192):
>   comm "kunit_try_catch", pid 1396, jiffies 4294720452 (age 932.801s)
>   hex dump (first 32 bytes):
>     a0 85 9e 82 ff ff ff ff 80 cd 7c 84 ff ff ff ff  ..........|.....
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff817dbad2>] __kmalloc+0x52/0x150
>     [<ffffffff829e9651>] kunit_filter_suites+0x481/0xcc0
>     [<ffffffff829eb69f>] filter_suites_test+0x12f/0x360
>     [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
>     [<ffffffff81236fc6>] kthread+0x2b6/0x380
>     [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
>     [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
>
> unreferenced object 0xffff888100da8400 (size 1024):
>   comm "kunit_try_catch", pid 1398, jiffies 4294720454 (age 781.945s)
>   hex dump (first 32 bytes):
>     73 75 69 74 65 32 00 00 00 00 00 00 00 00 00 00  suite2..........
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff817db753>] __kmalloc_node_track_caller+0x53/0x150
>     [<ffffffff817bd242>] kmemdup+0x22/0x50
>     [<ffffffff829e961d>] kunit_filter_suites+0x44d/0xcc0
>     [<ffffffff829eb13f>] filter_suites_test_glob_test+0x12f/0x560
>     [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
>     [<ffffffff81236fc6>] kthread+0x2b6/0x380
>     [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
>     [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
> unreferenced object 0xffff888105117878 (size 96):
>   comm "kunit_try_catch", pid 1398, jiffies 4294720454 (age 781.945s)
>   hex dump (first 32 bytes):
>     a0 85 9e 82 ff ff ff ff a0 ac 7c 84 ff ff ff ff  ..........|.....
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff817dbad2>] __kmalloc+0x52/0x150
>     [<ffffffff829e9651>] kunit_filter_suites+0x481/0xcc0
>     [<ffffffff829eb13f>] filter_suites_test_glob_test+0x12f/0x560
>     [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
>     [<ffffffff81236fc6>] kthread+0x2b6/0x380
>     [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
>     [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
> unreferenced object 0xffff888102c31c00 (size 1024):
>   comm "kunit_try_catch", pid 1404, jiffies 4294720460 (age 781.948s)
>   hex dump (first 32 bytes):
>     6e 6f 72 6d 61 6c 5f 73 75 69 74 65 00 00 00 00  normal_suite....
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff817db753>] __kmalloc_node_track_caller+0x53/0x150
>     [<ffffffff817bd242>] kmemdup+0x22/0x50
>     [<ffffffff829ecf17>] kunit_filter_attr_tests+0xf7/0x860
>     [<ffffffff829e99ff>] kunit_filter_suites+0x82f/0xcc0
>     [<ffffffff829ea975>] filter_attr_test+0x195/0x5f0
>     [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
>     [<ffffffff81236fc6>] kthread+0x2b6/0x380
>     [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
>     [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
> unreferenced object 0xffff8881052cd250 (size 192):
>   comm "kunit_try_catch", pid 1404, jiffies 4294720460 (age 781.948s)
>   hex dump (first 32 bytes):
>     a0 85 9e 82 ff ff ff ff 00 a9 7c 84 ff ff ff ff  ..........|.....
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff817dbad2>] __kmalloc+0x52/0x150
>     [<ffffffff829ecfc1>] kunit_filter_attr_tests+0x1a1/0x860
>     [<ffffffff829e99ff>] kunit_filter_suites+0x82f/0xcc0
>     [<ffffffff829ea975>] filter_attr_test+0x195/0x5f0
>     [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
>     [<ffffffff81236fc6>] kthread+0x2b6/0x380
>     [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
>     [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
> unreferenced object 0xffff888104f4e400 (size 1024):
>   comm "kunit_try_catch", pid 1408, jiffies 4294720464 (age 781.944s)
>   hex dump (first 32 bytes):
>     73 75 69 74 65 00 00 00 00 00 00 00 00 00 00 00  suite...........
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff817db753>] __kmalloc_node_track_caller+0x53/0x150
>     [<ffffffff817bd242>] kmemdup+0x22/0x50
>     [<ffffffff829ecf17>] kunit_filter_attr_tests+0xf7/0x860
>     [<ffffffff829e99ff>] kunit_filter_suites+0x82f/0xcc0
>     [<ffffffff829e9fc3>] filter_attr_skip_test+0x133/0x6e0
>     [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
>     [<ffffffff81236fc6>] kthread+0x2b6/0x380
>     [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
>     [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
> unreferenced object 0xffff8881052cc620 (size 192):
>   comm "kunit_try_catch", pid 1408, jiffies 4294720464 (age 781.944s)
>   hex dump (first 32 bytes):
>     a0 85 9e 82 ff ff ff ff c0 a8 7c 84 ff ff ff ff  ..........|.....
>     00 00 00 00 00 00 00 00 02 00 00 00 02 00 00 00  ................
>   backtrace:
>     [<ffffffff817dbad2>] __kmalloc+0x52/0x150
>     [<ffffffff829ecfc1>] kunit_filter_attr_tests+0x1a1/0x860
>     [<ffffffff829e99ff>] kunit_filter_suites+0x82f/0xcc0
>     [<ffffffff829e9fc3>] filter_attr_skip_test+0x133/0x6e0
>     [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
>     [<ffffffff81236fc6>] kthread+0x2b6/0x380
>     [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
>     [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
>
> Fixes: e5857d396f35 ("kunit: flatten kunit_suite*** to kunit_suite** in .kunit_test_suites")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309142251.uJ8saAZv-lkp@intel.com/
> ---
> v2:
> - Add the memory leak backtrace.
> - Remove the unused func kfree_at_end() kernel test robot noticed.

We have some plans to reintroduce a similar function later as a
general kunit feature, but it's fine removing it here.

> - Update the commit message.
> ---

This mostly looks good, but as Rae pointed out, the cleanup won't get
called if some of the assertions fail.

Using something more like kfree_at_end(), such as
kunit_add_action(test, (kunit_action_t *)kunit_free_suite_set, got)
would resolve all of these issues.

(You may need to write a wrapper around kunit_free_suite_set to make
it work as an action if you go down that path.)

Cheers,
-- David

>  lib/kunit/executor_test.c | 40 ++++++++++++++++++---------------------
>  1 file changed, 18 insertions(+), 22 deletions(-)
>
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index b4f6f96b2844..88d26c9cdce8 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -9,7 +9,6 @@
>  #include <kunit/test.h>
>  #include <kunit/attributes.h>
>
> -static void kfree_at_end(struct kunit *test, const void *to_free);
>  static struct kunit_suite *alloc_fake_suite(struct kunit *test,
>                                             const char *suite_name,
>                                             struct kunit_case *test_cases);
> @@ -56,7 +55,6 @@ static void filter_suites_test(struct kunit *test)
>         got = kunit_filter_suites(&suite_set, "suite2", NULL, NULL, &err);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>         KUNIT_ASSERT_EQ(test, err, 0);
> -       kfree_at_end(test, got.start);
>
>         /* Validate we just have suite2 */
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
> @@ -64,6 +62,9 @@ static void filter_suites_test(struct kunit *test)
>
>         /* Contains one element (end is 1 past end) */
>         KUNIT_ASSERT_EQ(test, got.end - got.start, 1);
> +
> +       if (!err)
> +               kunit_free_suite_set(got);
>  }
>
>  static void filter_suites_test_glob_test(struct kunit *test)
> @@ -82,7 +83,6 @@ static void filter_suites_test_glob_test(struct kunit *test)
>         got = kunit_filter_suites(&suite_set, "suite2.test2", NULL, NULL, &err);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>         KUNIT_ASSERT_EQ(test, err, 0);
> -       kfree_at_end(test, got.start);
>
>         /* Validate we just have suite2 */
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
> @@ -93,6 +93,9 @@ static void filter_suites_test_glob_test(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
>         KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->test_cases[0].name, "test2");
>         KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].name);
> +
> +       if (!err)

Because of the KUNIT_ASSERT_EQ(test, err, 0) call above, we know err
is nonzero here, so this conditional shouldn't be required. But it
also wouldn't be if you used a deferred action to clean up.


> +               kunit_free_suite_set(got);
>  }
>
>  static void filter_suites_to_empty_test(struct kunit *test)
> @@ -109,10 +112,12 @@ static void filter_suites_to_empty_test(struct kunit *test)
>
>         got = kunit_filter_suites(&suite_set, "not_found", NULL, NULL, &err);
>         KUNIT_ASSERT_EQ(test, err, 0);
> -       kfree_at_end(test, got.start); /* just in case */
>
>         KUNIT_EXPECT_PTR_EQ_MSG(test, got.start, got.end,
>                                 "should be empty to indicate no match");
> +
> +       if (!err)
> +               kunit_free_suite_set(got);
>  }
>
>  static void parse_filter_attr_test(struct kunit *test)
> @@ -172,7 +177,6 @@ static void filter_attr_test(struct kunit *test)
>         got = kunit_filter_suites(&suite_set, NULL, filter, NULL, &err);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>         KUNIT_ASSERT_EQ(test, err, 0);
> -       kfree_at_end(test, got.start);
>
>         /* Validate we just have normal_suite */
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
> @@ -183,6 +187,9 @@ static void filter_attr_test(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
>         KUNIT_EXPECT_STREQ(test, got.start[0]->test_cases[0].name, "normal");
>         KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].name);
> +
> +       if (!err)
> +               kunit_free_suite_set(got);
>  }
>
>  static void filter_attr_empty_test(struct kunit *test)
> @@ -200,10 +207,12 @@ static void filter_attr_empty_test(struct kunit *test)
>
>         got = kunit_filter_suites(&suite_set, NULL, filter, NULL, &err);
>         KUNIT_ASSERT_EQ(test, err, 0);
> -       kfree_at_end(test, got.start); /* just in case */
>
>         KUNIT_EXPECT_PTR_EQ_MSG(test, got.start, got.end,
>                                 "should be empty to indicate no match");
> +
> +       if (!err)
> +               kunit_free_suite_set(got);
>  }
>
>  static void filter_attr_skip_test(struct kunit *test)
> @@ -222,7 +231,6 @@ static void filter_attr_skip_test(struct kunit *test)
>         got = kunit_filter_suites(&suite_set, NULL, filter, "skip", &err);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>         KUNIT_ASSERT_EQ(test, err, 0);
> -       kfree_at_end(test, got.start);
>
>         /* Validate we have both the slow and normal test */
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
> @@ -233,6 +241,9 @@ static void filter_attr_skip_test(struct kunit *test)
>         /* Now ensure slow is skipped and normal is not */
>         KUNIT_EXPECT_EQ(test, got.start[0]->test_cases[0].status, KUNIT_SKIPPED);
>         KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].status);
> +
> +       if (!err)
> +               kunit_free_suite_set(got);
>  }
>
>  static struct kunit_case executor_test_cases[] = {
> @@ -255,21 +266,6 @@ static struct kunit_suite executor_test_suite = {
>  kunit_test_suites(&executor_test_suite);
>
>  /* Test helpers */
> -
> -/* Use the resource API to register a call to kfree(to_free).
> - * Since we never actually use the resource, it's safe to use on const data.
> - */
> -static void kfree_at_end(struct kunit *test, const void *to_free)
> -{
> -       /* kfree() handles NULL already, but avoid allocating a no-op cleanup. */
> -       if (IS_ERR_OR_NULL(to_free))
> -               return;
> -
> -       kunit_add_action(test,
> -                       (kunit_action_t *)kfree,
> -                       (void *)to_free);
> -}
> -
>  static struct kunit_suite *alloc_fake_suite(struct kunit *test,
>                                             const char *suite_name,
>                                             struct kunit_case *test_cases)
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230921014008.3887257-5-ruanjinjie%40huawei.com.

--000000000000d42c490605eda323
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
ddIn9n5Jt6Z1o79zxraLMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBtHFwIgQZjer5K
H+4Q+wns10k7qN+4wN2Uf+JsyOYjukaMEgdLErfA1wwtQ9uHkoYQZcWBuVVkQFa5hI+sqI2m1Weq
riMCFSiU38s1tADdMX12IMfJRN60Nznhrw+nPyDRZqRhUTW24TwnHorkDnFPW8PHo7fAw4FrpI0n
impZAng7ccvvK09K3ZuhwTIxJMsPXCZYsrXWORTw5sczRAP6XvKbPBJnsJoSTe5dFBPBHOQJOGhU
qWfEfWnWMJPF3LxSGLpLFQXO3RwQqmxv08avwXfVPouh1xuB3FX7rpDabT8YDhu9JgIZkLEKko7L
yQt6zWwng7k8YF/jGbiAta6VMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB5
HR6Az4E3QKs4e0EZCCpGM2s/x/5SnzPA1pUrU8rX+TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA5MjIwNzM0MzRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAAHgKlvO3L1CMcn10N77F
6hGroBZZcPASGpESDjbZ1tehqbCxc/o8K0DY7/tUuAhPTQJJb0lnIMhFSoQiCziNjhm4NcLoepD9
mFu2PYoIKCgQBzJJN3YqGVLvevyZMMlpAYXnsDIGMApGBT9+FN5HzaT7+3K9j/3WdvlXXsVw9DnA
TrtUPjYD7XpaElIuPZiPXRPrcBC2q5iW0wR0sjYc3gOvFD2AuS0Gdx2qI/Z96bMwLCh2dXrRcnsH
6vduPtGiM2Wkp+zWAzQlRtoG3J7wzotqASyxz1yzJ1U9AjPqg2LlzTWQu2LgqRf5doLuitAGsxeu
i2dm5n3Wdq0z6b7BNQ==
--000000000000d42c490605eda323--
