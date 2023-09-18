Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599787A47C4
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 13:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239235AbjIRLDn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 07:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjIRLDN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 07:03:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209378F;
        Mon, 18 Sep 2023 04:03:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0D7C433C7;
        Mon, 18 Sep 2023 11:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695034986;
        bh=xheY1ymXh/wvdjFd8+v/+GHt+em90YiVp8HQxiG3Nd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zi8DFmZm1oR8NWs7ka2iDKaLGQgBPU04YKEruMLQeiJ774r2K4wMKMxgQlFbp0FXY
         DVGTGCkK3T7WQjdQpTp3+N2ZL5QC5N9Gy8vU+peGy6qMXRCMihR+yHriLYH8u8USqs
         oH77NXEo9PjHiLOFfKckdkLwWnoU6NUZtvBWOp6isqjzwTFuUr0BLR8By8DyzBG09o
         wx1RIIFk9yHkzPt3uwX6qM3TdpaT/IaK7OToIC1uWLx/WJyBd5mkIx7ThNpYeCgc/C
         7MY5w7xw2c9gadANljIDPj9Ko/P54/tQ02XB23waPsc+5OO0aiTxgrN79iAEf4Sr0R
         5aVR5b1Ik8Hjg==
From:   SeongJae Park <sj@kernel.org>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org,
        brendan.higgins@linux.dev, feng.tang@intel.com,
        damon@lists.linux.dev, linux-mm@kvack.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/damon/core-test: Fix memory leak in damon_new_ctx()
Date:   Mon, 18 Sep 2023 11:03:04 +0000
Message-Id: <20230918110304.81807-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230918074759.3895339-3-ruanjinjie@huawei.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jinjie,

On Mon, 18 Sep 2023 15:47:59 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> When CONFIG_DAMON_KUNIT_TEST=y and making CONFIG_DEBUG_KMEMLEAK=y
> and CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y, the below memory leak is detected.
> 
> The damon_ctx which is allocated by kzalloc() in damon_new_ctx() in
> damon_test_ops_registration() and damon_test_set_attrs() are not freed.
> So use damon_destroy_ctx() to free it. After applying this patch, the
> following memory leak is never detected
> 
>     unreferenced object 0xffff2b49c6968800 (size 512):
>       comm "kunit_try_catch", pid 350, jiffies 4294895294 (age 557.028s)
>       hex dump (first 32 bytes):
>         88 13 00 00 00 00 00 00 a0 86 01 00 00 00 00 00  ................
>         00 87 93 03 00 00 00 00 0a 00 00 00 00 00 00 00  ................
>       backtrace:
>         [<0000000088e71769>] slab_post_alloc_hook+0xb8/0x368
>         [<0000000073acab3b>] __kmem_cache_alloc_node+0x174/0x290
>         [<00000000b5f89cef>] kmalloc_trace+0x40/0x164
>         [<00000000eb19e83f>] damon_new_ctx+0x28/0xb4
>         [<00000000daf6227b>] damon_test_ops_registration+0x34/0x328
>         [<00000000559c4801>] kunit_try_run_case+0x50/0xac
>         [<000000003932ed49>] kunit_generic_run_threadfn_adapter+0x20/0x2c
>         [<000000003c3e9211>] kthread+0x124/0x130
>         [<0000000028f85bdd>] ret_from_fork+0x10/0x20
>     unreferenced object 0xffff2b49c1a9cc00 (size 512):
>       comm "kunit_try_catch", pid 356, jiffies 4294895306 (age 557.000s)
>       hex dump (first 32 bytes):
>         88 13 00 00 00 00 00 00 a0 86 01 00 00 00 00 00  ................
>         00 00 00 00 00 00 00 00 0a 00 00 00 00 00 00 00  ................
>       backtrace:
>         [<0000000088e71769>] slab_post_alloc_hook+0xb8/0x368
>         [<0000000073acab3b>] __kmem_cache_alloc_node+0x174/0x290
>         [<00000000b5f89cef>] kmalloc_trace+0x40/0x164
>         [<00000000eb19e83f>] damon_new_ctx+0x28/0xb4
>         [<00000000058495c4>] damon_test_set_attrs+0x30/0x1a8
>         [<00000000559c4801>] kunit_try_run_case+0x50/0xac
>         [<000000003932ed49>] kunit_generic_run_threadfn_adapter+0x20/0x2c
>         [<000000003c3e9211>] kthread+0x124/0x130
>         [<0000000028f85bdd>] ret_from_fork+0x10/0x20
> 
> Fixes: d1836a3b2a9a ("mm/damon/core-test: initialise context before test in damon_test_set_attrs()")
> Fixes: 4f540f5ab4f2 ("mm/damon/core-test: add a kunit test case for ops registration")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Feng Tang <feng.tang@intel.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
> v2:
> - Add Reviewed-by.
> - Rebased on mm-unstable.
> - Update the commit message.
> ---
>  mm/damon/core-test.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
> index 3959be35b901..649adf91ebc5 100644
> --- a/mm/damon/core-test.h
> +++ b/mm/damon/core-test.h
> @@ -269,6 +269,8 @@ static void damon_test_ops_registration(struct kunit *test)
>  
>  	/* Check double-registration failure again */
>  	KUNIT_EXPECT_EQ(test, damon_register_ops(&ops), -EINVAL);
> +
> +	damon_destroy_ctx(c);
>  }
>  
>  static void damon_test_set_regions(struct kunit *test)
> @@ -346,6 +348,8 @@ static void damon_test_set_attrs(struct kunit *test)
>  	invalid_attrs = valid_attrs;
>  	invalid_attrs.aggr_interval = 4999;
>  	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL);
> +
> +	damon_destroy_ctx(c);
>  }
>  
>  static void damon_test_moving_sum(struct kunit *test)
> -- 
> 2.34.1
> 
> 
