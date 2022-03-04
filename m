Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC65C4CDF26
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 22:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiCDUqP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 15:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiCDUqO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 15:46:14 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987401066C0;
        Fri,  4 Mar 2022 12:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646426726; x=1677962726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JjYlYk4Ix0CQ30yUz6UM7pdS0qqc7/2Jw+OpJFbJ7DE=;
  b=GUfcX8bWjOIoTi/JG1vZ9vTGNtWT1Wmf+7GNAoGbvk+MeVcqf1Tp1uZE
   lCV56c0GKbinBobqaVaf5YJeMEXEiCOC/o4IPka9ADgyp4TweR1G5zq/0
   ZYVdBs0zyrD2Iw/o90XUzOBcQcGGnqQX/r7of6OUnusNKU/BlXmx9vlyY
   TAW0Vqw/K+Htgi8siHU3ysDF2iumKsn1G+8YrivyKFL7HOIWUS4bAPKMQ
   JB6k5AKuB4XHdJxQI7rl7eRYNgRCTAqlYO21eeSKhjaWLnR34TmQxGXUJ
   E0/5amhXLa/RByXh/N+Pd1FPzPLty1l5UJZf0AbnFFfl7x4JuHufPPKku
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="252888021"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="252888021"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 12:45:26 -0800
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="810871952"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 12:45:26 -0800
Date:   Fri, 4 Mar 2022 12:45:25 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v4 2/6] selftests/resctrl: Change the default limited
 time to 120 seconds
Message-ID: <YiJ6ZUgiQNAYn+ZR@otcwcpicx3.sc.intel.com>
References: <20220304103834.486892-1-tan.shaopeng@jp.fujitsu.com>
 <20220304103834.486892-3-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304103834.486892-3-tan.shaopeng@jp.fujitsu.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Shaopeng,

On Fri, Mar 04, 2022 at 07:38:30PM +0900, Shaopeng Tan wrote:
> When testing on a Intel(R) Xeon(R) Gold 6254 CPU @ 3.10GHz the resctrl
> selftests fail due to timeout after exceeding the default time limit of
> 45 seconds. On this system the test takes about 68 seconds.
> Since the failing test by default accesses a fixed size of memory, the
> execution time should not vary significantly between different environment.
> A new default of 120 seconds should be sufficient yet easy to customize
> with the introduction of the "settings" file for reference.
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/settings | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 tools/testing/selftests/resctrl/settings
> 
> diff --git a/tools/testing/selftests/resctrl/settings b/tools/testing/selftests/resctrl/settings
> new file mode 100644
> index 000000000000..6091b45d226b
> --- /dev/null
> +++ b/tools/testing/selftests/resctrl/settings
> @@ -0,0 +1 @@

Maybe add some comments here?

+# If running time is longer than 120 seconds when new tests are added in 
+# the future, increase timeout here.

> +timeout=120
> -- 
> 2.27.0
> 
Thanks.

-Fenghua
