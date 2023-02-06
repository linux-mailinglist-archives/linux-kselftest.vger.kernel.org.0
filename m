Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF57B68BBF0
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 12:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjBFLpu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 06:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjBFLpt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 06:45:49 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2178222035;
        Mon,  6 Feb 2023 03:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675683948; x=1707219948;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uR/HXzJZOonPBiXJlX7ofHHUBlPEq8VyuqMXpzZ/uKY=;
  b=RTdFolDPaq9B9W4dW+/R0kgeIRbR5ItRmJwMTOM8qc7lrjwXyPEgthem
   VVU2ssspD5HoyXGPVKjtkhl9W7sjotVIdtd50uShEp2Fvn4K3DYnBi7fr
   BKWHTpF4Z6P3nJD6ZCbd+6jiRHzT+lw5w9itREaLkxStduIvknN4Q8t/C
   avkS8fgU5Uxh0o+jKJnvQ+Xd2psecywXuTmrCQTRW6Df3MjwCWNTeNTKv
   /Nta7g1swcN/UGSs39qTBBu+FR2zamP+viSOTLThIdvZryA4O97YK1yUx
   qdjJ7wfFk4eKEtn1kOvzmfqeqnaIcqBz3P9mpL3NKqIsVeaC6gKS+9nPs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="356544493"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="356544493"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 03:45:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="643999780"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="643999780"
Received: from mjothix-mobl2.ger.corp.intel.com ([10.252.35.36])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 03:45:43 -0800
Date:   Mon, 6 Feb 2023 13:45:40 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
In-Reply-To: <20230131054655.396270-5-tan.shaopeng@jp.fujitsu.com>
Message-ID: <a9ab65a6-f750-7fd9-99ba-1cbd15427d2c@linux.intel.com>
References: <20230131054655.396270-1-tan.shaopeng@jp.fujitsu.com> <20230131054655.396270-5-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 31 Jan 2023, Shaopeng Tan wrote:

> After creating a child process with fork() in CAT test, if an error
> occurs or a signal such as SIGINT is received, the parent process will
> be terminated immediately, and therefor the child process will not
> be killed and also resctrlfs is not unmounted.
> 
> There is a signal handler registered in CMT/MBM/MBA tests, which kills
> child process, unmount resctrlfs, cleanups result files, etc., if a
> signal such as SIGINT is received.
>
> Commonize the signal handler registered for CMT/MBM/MBA tests and reuse
> it in CAT too.
> 
> To reuse the signal handler, make the child process in CAT wait to be
> killed by parent process in any case (an error occurred or a signal was
> received), and when killing child process use global bm_pid instead of
> local bm_pid.
> 
> Also, since the MBA/MBA/CMT/CAT are run in order, unregister the signal
> handler at the end of each test so that the signal handler cannot be
> inherited by other tests.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/cat_test.c    | 28 ++++----
>  tools/testing/selftests/resctrl/fill_buf.c    | 14 ----
>  tools/testing/selftests/resctrl/resctrl.h     |  2 +
>  tools/testing/selftests/resctrl/resctrl_val.c | 70 +++++++++++++------
>  4 files changed, 68 insertions(+), 46 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 6a8306b0a109..3524fa88e3a4 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -103,7 +103,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  	unsigned long l_mask, l_mask_1;
>  	int ret, pipefd[2], sibling_cpu_no;
>  	char pipe_message;
> -	pid_t bm_pid;
>  
>  	cache_size = 0;
>  
> @@ -181,28 +180,31 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  		strcpy(param.filename, RESULT_FILE_NAME1);
>  		param.num_of_runs = 0;
>  		param.cpu_no = sibling_cpu_no;
> +	} else {
> +		ret = signal_handler_register();
> +		if (ret) {
> +			kill(bm_pid, SIGKILL);
> +			goto out;
> +		}
>  	}
>  
>  	remove(param.filename);
>  

>  	ret = cat_val(&param);
> -	if (ret)
> -		return ret;
> -
> -	ret = check_results(&param);
> -	if (ret)
> -		return ret;
> +	if (ret == 0)
> +		ret = check_results(&param);

It would be take this program flow fix out of the signal handler change
into a separate change.

-- 
 i.
