Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85354B22CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 11:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348790AbiBKKIa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Feb 2022 05:08:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiBKKI3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Feb 2022 05:08:29 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DC62D3
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 02:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644574109; x=1676110109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z2gk1OpljxDmJHIclc6+jtjq1esiae1ePRP93bRgHfI=;
  b=K3bZFxTgdt6zaOkFoG1i6egGPSpLnkLSPuxmaKiDgL1ISFSYBnIdVXst
   c8dov7HRRP+4QfHeHWZ9mMXRQxjPB9vilWQ0EstGLd7cf6PcXPDacHJL8
   Q4zFSOD7dADhyaUy5dMwKeo20k5G93utxh1Dp4m7MWKTW5K3TkCZNvU0l
   dPy89UMUKp1QFelBkvKe3Kv6SlyIhWQjPi7zW/+m4qwv5H7uSEgXGLhqX
   XuJDuvWVgBsGKwmeH78fmnEIEeczLpfoHPEoXuqm7fz1QPs8I9lLbUFU3
   kkIdh40PD8JCqy0rIiuq5vIU0Lz+lQRHAsEFiTzEOjgkFLIzUMzL8AhRb
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="248536477"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="248536477"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 02:08:28 -0800
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="483271617"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 02:08:25 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 11 Feb 2022 12:08:23 +0200
Date:   Fri, 11 Feb 2022 12:08:23 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>
Subject: Re: [PATCH v5 3/6] thunderbolt: test: use NULL macros
Message-ID: <YgY1lzA20zyFcVi3@lahna>
References: <20220211094133.265066-1-ribalda@chromium.org>
 <20220211094133.265066-3-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211094133.265066-3-ribalda@chromium.org>
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

Hi,

On Fri, Feb 11, 2022 at 10:41:30AM +0100, Ricardo Ribalda wrote:
> Replace the NULL checks with the more specific and idiomatic NULL macros.
> 
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---

...

> @@ -2496,50 +2496,50 @@ static void tb_test_property_parse(struct kunit *test)
>  	struct tb_property *p;
>  
>  	dir = tb_property_parse_dir(root_directory, ARRAY_SIZE(root_directory));
> -	KUNIT_ASSERT_TRUE(test, dir != NULL);
> +	KUNIT_ASSERT_NOT_NULL(test, dir);
>  
>  	p = tb_property_find(dir, "foo", TB_PROPERTY_TYPE_TEXT);
> -	KUNIT_ASSERT_TRUE(test, !p);
> +	KUNIT_ASSERT_NOT_NULL(test, p);

This should be KUNIT_ASSERT_NULL(test, p) as we specifically want to
check that the property does not exist (!p is same as p == NULL).

>  	p = tb_property_find(dir, "vendorid", TB_PROPERTY_TYPE_TEXT);
> -	KUNIT_ASSERT_TRUE(test, p != NULL);
> +	KUNIT_ASSERT_NOT_NULL(test, p);
>  	KUNIT_EXPECT_STREQ(test, p->value.text, "Apple Inc.");
>  
>  	p = tb_property_find(dir, "vendorid", TB_PROPERTY_TYPE_VALUE);
> -	KUNIT_ASSERT_TRUE(test, p != NULL);
> +	KUNIT_ASSERT_NOT_NULL(test, p);
>  	KUNIT_EXPECT_EQ(test, p->value.immediate, 0xa27);
>  
>  	p = tb_property_find(dir, "deviceid", TB_PROPERTY_TYPE_TEXT);
> -	KUNIT_ASSERT_TRUE(test, p != NULL);
> +	KUNIT_ASSERT_NOT_NULL(test, p);
>  	KUNIT_EXPECT_STREQ(test, p->value.text, "Macintosh");
>  
>  	p = tb_property_find(dir, "deviceid", TB_PROPERTY_TYPE_VALUE);
> -	KUNIT_ASSERT_TRUE(test, p != NULL);
> +	KUNIT_ASSERT_NOT_NULL(test, p);
>  	KUNIT_EXPECT_EQ(test, p->value.immediate, 0xa);
>  
>  	p = tb_property_find(dir, "missing", TB_PROPERTY_TYPE_DIRECTORY);
> -	KUNIT_ASSERT_TRUE(test, !p);
> +	KUNIT_ASSERT_NOT_NULL(test, p);

Ditto here.

With those fixed (please also run the tests if possible to see that they
still pass) you can add,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!
