Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CE94AF32F
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Feb 2022 14:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbiBINov (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 08:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiBINou (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 08:44:50 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680EFC061355;
        Wed,  9 Feb 2022 05:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644414294; x=1675950294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X0mPTQZc8MsI6QCkVWroL5iQzYDp8qCkuD8NST7YBWY=;
  b=nMGdwhR8C+uEwHBrkVymWHZFn4BfTCQ5eJJUASuq7PCTfbOF98nSaxtZ
   mzYOzUVA58hH1Vyex1B96/m+DZfXozNSYDvG/yL3+zPJ56Oc3+9QJuNqJ
   DbIjikh7GL2BIp5izHKAB3JAFzP+G+8YwdJmf5kg1ABRDawlZIzPuTcuQ
   fkKrY0XHMsrQGfujvilOkx3847bEBULO7BkrzOZNOZ42cmXbkyxItgNA7
   gkyUu0adR+zAGFrNCnYa5V4okJtIaiaA8CEs8O5eMTP7MNnuVfCQOnjTW
   VgkUa/j3mtLb76kDDGfnkVbkONMgZaJIEXQlBfVPoIbpmKIAA3lOsJSlE
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="249153588"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="249153588"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 05:44:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="525990164"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 05:44:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nHnGD-002czi-Ei;
        Wed, 09 Feb 2022 15:43:53 +0200
Date:   Wed, 9 Feb 2022 15:43:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH v3 1/3] list: test: Add test for list_del_init_careful()
Message-ID: <YgPFGUyK4ood7WvU@smile.fi.intel.com>
References: <20220209052813.854014-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209052813.854014-1-davidgow@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 09, 2022 at 01:28:11PM +0800, David Gow wrote:
> The list_del_init_careful() function was added[1] after the list KUnit
> test. Add a very basic test to cover it.
> 
> Note that this test only covers the single-threaded behaviour (which
> matches list_del_init()), as is already the case with the test for
> list_empty_careful().
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c6fe44d96fc1536af5b11cd859686453d1b7bfd1


Now the negative tests make more sense, thanks!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
to the entire series.

> Signed-off-by: David Gow <davidgow@google.com>
> ---
> 
> Changes since v2:
> https://lore.kernel.org/linux-kselftest/20220208040122.695258-1-davidgow@google.com/
> - Fix the test calling list_del_init() instead of
>   list_del_init_careful()
> - Improve the comment noting we only test single-threaded behaviour.
> 
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20220205061539.273330-1-davidgow@google.com/
> - Patch 1/3 unchanged
> ---
>  lib/list-test.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/lib/list-test.c b/lib/list-test.c
> index ee09505df16f..f82a3c7788b8 100644
> --- a/lib/list-test.c
> +++ b/lib/list-test.c
> @@ -161,6 +161,25 @@ static void list_test_list_del_init(struct kunit *test)
>  	KUNIT_EXPECT_TRUE(test, list_empty_careful(&a));
>  }
>  
> +static void list_test_list_del_init_careful(struct kunit *test)
> +{
> +	/* NOTE: This test only checks the behaviour of this function in
> +	 * isolation. It does not verify memory model guarantees. */
> +	struct list_head a, b;
> +	LIST_HEAD(list);
> +
> +	list_add_tail(&a, &list);
> +	list_add_tail(&b, &list);
> +
> +	/* before: [list] -> a -> b */
> +	list_del_init_careful(&a);
> +	/* after: [list] -> b, a initialised */
> +
> +	KUNIT_EXPECT_PTR_EQ(test, list.next, &b);
> +	KUNIT_EXPECT_PTR_EQ(test, b.prev, &list);
> +	KUNIT_EXPECT_TRUE(test, list_empty_careful(&a));
> +}
> +
>  static void list_test_list_move(struct kunit *test)
>  {
>  	struct list_head a, b;
> @@ -707,6 +726,7 @@ static struct kunit_case list_test_cases[] = {
>  	KUNIT_CASE(list_test_list_replace_init),
>  	KUNIT_CASE(list_test_list_swap),
>  	KUNIT_CASE(list_test_list_del_init),
> +	KUNIT_CASE(list_test_list_del_init_careful),
>  	KUNIT_CASE(list_test_list_move),
>  	KUNIT_CASE(list_test_list_move_tail),
>  	KUNIT_CASE(list_test_list_bulk_move_tail),
> -- 
> 2.35.0.263.gb82422642f-goog
> 

-- 
With Best Regards,
Andy Shevchenko


