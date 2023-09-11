Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53C679B243
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 01:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242099AbjIKVTj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbjIKKHq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 06:07:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594E7101;
        Mon, 11 Sep 2023 03:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694426862; x=1725962862;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=oh0Zy/V3VyMAu5In2Ipg/gMQQV8/i4gpEGPeqw7tFXI=;
  b=PUtX8EWJ7889ia3CxNJ0vCuyNykqr+UM54a895lj/V7+5QR8JB3kqUNE
   2azyUzKXm4uqRMhEXb6ZjtbzJIi77CIdn98lFAQnMzISUYsdcvK1pKqmt
   ou8656UWlev5Vd44GL8qc9M5Uwqqva0Pi5xo5lQo2CZjO6qffSVGpWFQ4
   yFAQIsHRcj+kw8JRPutNML4ERBCvGnFqZiow9lQjeQ1HihUFAgT4peW+9
   Z5J0uqEv225BehkgqxA10dpnCzKfLs132UlZfW6+s6HSyJT8wUYh7VE+0
   3IGxrn22OWP1OHCoP/3THv8UplvysQWss+Wev8JheJbfbKrr9iN1EfKbu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="357484290"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="357484290"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:07:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="719938160"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="719938160"
Received: from kschuele-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.63.119])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:07:37 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        =?utf-8?Q?Ma=C3=ADra?= Canal <mairacanal@riseup.net>,
        dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH 1/2] kunit: Warn if tests are slow
In-Reply-To: <20230911-kms-slow-tests-v1-1-d3800a69a1a1@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230911-kms-slow-tests-v1-0-d3800a69a1a1@kernel.org>
 <20230911-kms-slow-tests-v1-1-d3800a69a1a1@kernel.org>
Date:   Mon, 11 Sep 2023 13:07:35 +0300
Message-ID: <87leddf2fs.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 11 Sep 2023, Maxime Ripard <mripard@kernel.org> wrote:
> Kunit recently gained support to setup attributes, the first one being
> the speed of a given test, then allowing to filter out slow tests.
>
> A slow test is defined in the documentation as taking more than one
> second. There's an another speed attribute called "super slow" but whose
> definition is less clear.
>
> Add support to the test runner to check the test execution time, and
> report tests that should be marked as slow but aren't.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  lib/kunit/test.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 49698a168437..a3b924501f3d 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -379,6 +379,9 @@ static void kunit_run_case_internal(struct kunit *test,
>  				    struct kunit_suite *suite,
>  				    struct kunit_case *test_case)
>  {
> +	struct timespec64 start, end;
> +	struct timespec64 duration;
> +
>  	if (suite->init) {
>  		int ret;
>  
> @@ -390,7 +393,20 @@ static void kunit_run_case_internal(struct kunit *test,
>  		}
>  	}
>  
> +	ktime_get_ts64(&start);
> +
>  	test_case->run_case(test);
> +
> +	ktime_get_ts64(&end);
> +
> +	duration = timespec64_sub(end, start);
> +
> +	if (duration.tv_sec >= 1 &&
> +	    (test_case->attr.speed == KUNIT_SPEED_UNSET ||
> +	     test_case->attr.speed >= KUNIT_SPEED_NORMAL))
> +		kunit_warn(test,
> +			   "Test should be marked slow (runtime: %lld.%09lds)",
> +			   duration.tv_sec, duration.tv_nsec);

Two thoughts:

Should there be some tolerance here? Otherwise we're flagging this on
the slowest machines, and we'll be defining tests slow based on
that. Like, warn if it takes more than 2 seconds.

What if someone makes a test faster, but forgets to update the
attribute? Should we also flag slow tests that are in fact fast?


BR,
Jani.


>  }
>  
>  static void kunit_case_internal_cleanup(struct kunit *test)

-- 
Jani Nikula, Intel Open Source Graphics Center
