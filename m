Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D227917DD
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 15:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbjIDNO7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 09:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344991AbjIDNO6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 09:14:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D890CDE;
        Mon,  4 Sep 2023 06:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693833292; x=1725369292;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RCc6n5WZdbhfvlnmNEYoE34yvS8N0R8/Swbn0o3B8m8=;
  b=T896vZdvU4k+yjZOO9OHYooLy33iPKMVx8K3Dl4m3cgAors8S7bMEyHd
   aPBx1SwpskbzL2mAEZvy2gBdMA5nhd6Qe6t7054s4UJuqN1nrsj1lf2PT
   bn2a5ZkIyABlgowLh9PhxL6ApBlkSj7Np4jOt47wB7Jc1g5zui4enm+s0
   KWanPZFyhHXAHTvHdryGEoEjtlAOB037XnQaKC+Btep4Y0pHnXhxEocPA
   2MuSE7+3g9ezf5Cs7jf7POWik07W/rj6jKlarYvkVzor84S+OY8KBmcEP
   ObwWvQwYy0icOWoHfM4MlOkFLeLGApy/ERr1sz4zm5Eno0pf2Uo0OVTcq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="442991981"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="442991981"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 06:14:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="884019184"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="884019184"
Received: from okozlyk-mobl.ger.corp.intel.com ([10.249.44.17])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 06:14:44 -0700
Date:   Mon, 4 Sep 2023 16:14:47 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 8/8] selftests/resctrl: Fix wrong format specifier
In-Reply-To: <a10dfa9cbfec05e8056744bc5e3ac0697a4fbd9b.1693829810.git.maciej.wieczor-retman@intel.com>
Message-ID: <eb997572-3e51-22dc-2c61-f89a363a798@linux.intel.com>
References: <cover.1693829810.git.maciej.wieczor-retman@intel.com> <a10dfa9cbfec05e8056744bc5e3ac0697a4fbd9b.1693829810.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-445482151-1693833291=:1759"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-445482151-1693833291=:1759
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 4 Sep 2023, Wieczor-Retman Maciej wrote:

> A long unsigned int variable is passed to the ksft_print_msg() and the
> format specifier used expects a variable of type int.
> 
> Change the format specifier to match the passed variable.
> 
> Signed-off-by: Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
> ---
> Changelog v2:
> - Added this patch to the series.
> 
>  tools/testing/selftests/resctrl/cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> index d3cbb829ff6a..a5d082cd2d53 100644
> --- a/tools/testing/selftests/resctrl/cache.c
> +++ b/tools/testing/selftests/resctrl/cache.c
> @@ -294,7 +294,7 @@ int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
>  	ret = platform && abs((int)diff_percent) > max_diff_percent &&
>  	      (cmt ? (abs(avg_diff) > max_diff) : true);
>  
> -	ksft_print_msg("%s Check cache miss rate within %d%%\n",
> +	ksft_print_msg("%s Check cache miss rate within %lu%%\n",
>  		       ret ? "Fail:" : "Pass:", max_diff_percent);
>  
>  	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-445482151-1693833291=:1759--
