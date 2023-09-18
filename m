Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B967A47B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 13:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjIRLA0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 07:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237673AbjIRLAS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 07:00:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A518F;
        Mon, 18 Sep 2023 04:00:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A57C433C7;
        Mon, 18 Sep 2023 11:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695034811;
        bh=mUP6+EOkqcXwwHbp/HXe6HO9SgJ+ru7fakc6rUq1+Cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JRcMHnFI1H4CVwaI8yhCmtOPdp+FzuUGK1NYH1ESGOZO88hXQArQ9JBPK0zrjBcM/
         SVKzKoQsepWlY0yExn8n7Ktxh8iH6SMKq8HwLfEgZKThDRR58TZfmcmJBX3wCz+QRI
         1yTCoU05IGB50cuGOB3BbwoozrxtM6BByqKgN9V9ibyaLCTvwOf8e7SMuHj1toAI2Z
         F80Ak+P2/ZW89YQkuFbzt2KiHl5+SIf6CFdZcBUJdxdFRESd4C2pevyskRCW8nXDSq
         97X1VirI6/6iAIoTX7GTjXfu0vGeDgvaiXdpfrgzk007VZTiIpwgcST8HgVxgjQAa7
         PHdi2af/UUV+g==
From:   SeongJae Park <sj@kernel.org>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org,
        brendan.higgins@linux.dev, feng.tang@intel.com,
        damon@lists.linux.dev, linux-mm@kvack.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon/core-test: Fix memory leak in damon_new_region()
Date:   Mon, 18 Sep 2023 11:00:09 +0000
Message-Id: <20230918110009.78365-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230918074759.3895339-2-ruanjinjie@huawei.com>
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

On Mon, 18 Sep 2023 15:47:58 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> When CONFIG_DAMON_KUNIT_TEST=y and making CONFIG_DEBUG_KMEMLEAK=y
> and CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y, the below memory leak is detected.
> 
> The damon_region which is allocated by kmem_cache_alloc() in
> damon_new_region() in damon_test_regions() and
> damon_test_update_monitoring_result() are not freed. So use
> damon_free_region() to free it.

Nit.  This patch is not directly adding use of damon_free_region() but replaces
damon_del_region() call with damon_destroy_region(), so that it calls both
damon_del_region() and damon_free_region().

I think this part might better to be re-written?

> After applying this patch, the following
> memory leak is never detected.
> 
>     unreferenced object 0xffff2b49c3edc000 (size 56):
>       comm "kunit_try_catch", pid 338, jiffies 4294895280 (age 557.084s)
>       hex dump (first 32 bytes):
>         01 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00  ................
>         00 00 00 00 00 00 00 00 00 00 00 00 49 2b ff ff  ............I+..
>       backtrace:
>         [<0000000088e71769>] slab_post_alloc_hook+0xb8/0x368
>         [<00000000b528f67c>] kmem_cache_alloc+0x168/0x284
>         [<000000008603f022>] damon_new_region+0x28/0x54
>         [<00000000a3b8c64e>] damon_test_regions+0x38/0x270
>         [<00000000559c4801>] kunit_try_run_case+0x50/0xac
>         [<000000003932ed49>] kunit_generic_run_threadfn_adapter+0x20/0x2c
>         [<000000003c3e9211>] kthread+0x124/0x130
>         [<0000000028f85bdd>] ret_from_fork+0x10/0x20
>     unreferenced object 0xffff2b49c5b20000 (size 56):
>       comm "kunit_try_catch", pid 354, jiffies 4294895304 (age 556.988s)
>       hex dump (first 32 bytes):
>         03 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00  ................
>         00 00 00 00 00 00 00 00 96 00 00 00 49 2b ff ff  ............I+..
>       backtrace:
>         [<0000000088e71769>] slab_post_alloc_hook+0xb8/0x368
>         [<00000000b528f67c>] kmem_cache_alloc+0x168/0x284
>         [<000000008603f022>] damon_new_region+0x28/0x54
>         [<00000000ca019f80>] damon_test_update_monitoring_result+0x18/0x34
>         [<00000000559c4801>] kunit_try_run_case+0x50/0xac
>         [<000000003932ed49>] kunit_generic_run_threadfn_adapter+0x20/0x2c
>         [<000000003c3e9211>] kthread+0x124/0x130
>         [<0000000028f85bdd>] ret_from_fork+0x10/0x20
> 
> Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
> Fixes: f4c978b6594b ("mm/damon/core-test: add a test for damon_update_monitoring_results()")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Other than the above trivial nit,

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
> v2:
> - Replace the damon_del_region() with damon_destroy_region() rather than
>   calling damon_free_region().
> - Update the commit message.

And thank you for making the changes.


Thanks,
SJ

> ---
>  mm/damon/core-test.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
> index 79f1f12e0dd5..3959be35b901 100644
> --- a/mm/damon/core-test.h
> +++ b/mm/damon/core-test.h
> @@ -30,7 +30,7 @@ static void damon_test_regions(struct kunit *test)
>  	damon_add_region(r, t);
>  	KUNIT_EXPECT_EQ(test, 1u, damon_nr_regions(t));
>  
> -	damon_del_region(r, t);
> +	damon_destroy_region(r, t);
>  	KUNIT_EXPECT_EQ(test, 0u, damon_nr_regions(t));
>  
>  	damon_free_target(t);
> @@ -321,6 +321,8 @@ static void damon_test_update_monitoring_result(struct kunit *test)
>  	damon_update_monitoring_result(r, &old_attrs, &new_attrs);
>  	KUNIT_EXPECT_EQ(test, r->nr_accesses, 150);
>  	KUNIT_EXPECT_EQ(test, r->age, 20);
> +
> +	damon_free_region(r);
>  }
>  
>  static void damon_test_set_attrs(struct kunit *test)
> -- 
> 2.34.1
> 
> 
