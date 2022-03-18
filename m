Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF934DE451
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Mar 2022 23:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbiCRWxQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Mar 2022 18:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbiCRWxP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Mar 2022 18:53:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1371E3076EF;
        Fri, 18 Mar 2022 15:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647643916; x=1679179916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S4pQrEN8HpDPhir9k2llngd8DTnUCApgq4uXGL8O+Qo=;
  b=QQuRMRwc9qkNSE4Tegd8T+/p2jW/HYusLBCHckddwYEAA47z/TctDdY5
   MmLZRyfChm4GD84Je2mXjLQfeFOW1y52KZUYcXt7HV4LuNGxnYuLcS/dz
   /DaFA2J5L5CBQnlCpCyuYsnt9ArsBKpt2uFN7MiOSLoh6sjWd0QEfY/r5
   NIpaxgmNCpoTpIaFHKeob1+SkLQrHkVp6vqwmRJlPtBgfFxApR5+Ns8q3
   fsLVlDmnRSsT5yyb2dCvv90BCIwV6jQI46HsN5MMew/JZ8O30aRJBSA22
   a+BbPZHKz294yEGgzoIA1rXcaAd2A2RUTTotJfzzB7DLLEd7UTifiWAQb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="257191875"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="257191875"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 15:51:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="647669930"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 15:51:55 -0700
Date:   Fri, 18 Mar 2022 15:51:54 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v6 3/6] selftests/resctrl: Fix resctrl_tests' return code
 to work with selftest framework
Message-ID: <YjUNCn6CguwhN6Kd@otcwcpicx3.sc.intel.com>
References: <20220318075807.2921063-1-tan.shaopeng@jp.fujitsu.com>
 <20220318075807.2921063-4-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318075807.2921063-4-tan.shaopeng@jp.fujitsu.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 18, 2022 at 04:58:04PM +0900, Shaopeng Tan wrote:
> In kselftest framework, if a sub test can not run by some reasons,
                                                   s/by/for/
> the test result should be marked as SKIP rather than FAIL.
> Return KSFT_SKIP(4) instead of KSFT_FAIL(1) if resctrl_tests is not run
							       s/is/does/
> as root or it is run on a test environment which does not support resctrl.
               s/is run/runs/
> 
>  - ksft_exit_fail_msg(): returns KSFT_FAIL(1)
>  - ksft_exit_skip(): returns KSFT_SKIP(4)
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/resctrl_tests.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 973f09a66e1e..ed7e1a995b01 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -205,7 +205,7 @@ int main(int argc, char **argv)
>  	 * 2. We execute perf commands
>  	 */
>  	if (geteuid() != 0)
> -		return ksft_exit_fail_msg("Not running as root, abort testing.\n");
> +		return ksft_exit_skip("Not running as root. Skipping...\n");
>  
>  	/* Detect AMD vendor */
>  	detect_amd();
> @@ -235,7 +235,7 @@ int main(int argc, char **argv)
>  	sprintf(bm_type, "fill_buf");
>  
>  	if (!check_resctrlfs_support())
> -		return ksft_exit_fail_msg("resctrl FS does not exist\n");
> +		return ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL config options.\n");
>  
>  	filter_dmesg();
>  
> -- 
> 2.27.0
> 

Please fix the typos.

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
