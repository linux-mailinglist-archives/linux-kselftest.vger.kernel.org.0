Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C316D4AA908
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Feb 2022 14:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241026AbiBENJr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Feb 2022 08:09:47 -0500
Received: from mga11.intel.com ([192.55.52.93]:32078 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233802AbiBENJr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Feb 2022 08:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644066587; x=1675602587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HoZfpuHf/UIox5btfBw3eoPBS718sWW7EpkqflQ8Yk0=;
  b=Ush67bIR2Sf5dPB//gbdKajyQQh171BKJ0QhcjpvHvI8ssPpEi/8BtXY
   1q3lMFDYwiYEO8RonYflU4Ndv5S2GTdFk4+DpAwfbW/cXd55VwauUBMEI
   ydDLGKKyAxq0QZgtZElAsc8nwTkf2i9q70sakUYqbUFazGE/vlogYzxUi
   /Rtc7NLolZDwLG5NVjXvdhu/Flkg3ECq5p0MBltHcHJ4meqaFuK5zCiWv
   H9Lh4D3WEquhX5CvDPEl2VM6+YGKkE/qE3GvWOM3IhqNYL8bMbm3tPN/2
   J+dfNj1OuDu/np8j1F0swWUup7MkcViMYn/uJWoobw/PxRK8FePYQ3/+Z
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="246099065"
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="246099065"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 05:09:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="600481400"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 05:09:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nGKlu-001GnP-Vw;
        Sat, 05 Feb 2022 15:06:34 +0200
Date:   Sat, 5 Feb 2022 15:06:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH 2/3] list: test: Add a test for list_is_head()
Message-ID: <Yf52WjnmA17wQ5p7@smile.fi.intel.com>
References: <20220205061539.273330-1-davidgow@google.com>
 <20220205061539.273330-2-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205061539.273330-2-davidgow@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Feb 05, 2022 at 02:15:37PM +0800, David Gow wrote:
> list_is_head() was added recently[1], and didn't have a KUnit test. The
> implementation is trivial, so it's not a particularly exciting test, but
> it'd be nice to get back to full coverage of the list functions.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/list.h?id=0425473037db40d9e322631f2d4dc6ef51f97e88

...

> +static void list_test_list_is_head(struct kunit *test)
> +{
> +	struct list_head a, b;
> +
> +	KUNIT_EXPECT_TRUE(test, list_is_head(&a, &a));

OK.

> +	KUNIT_EXPECT_FALSE(test, list_is_head(&a, &b));

Perhaps OK, but the main case here is to test an (arbitrary) member of the existing list.

> +}

-- 
With Best Regards,
Andy Shevchenko


