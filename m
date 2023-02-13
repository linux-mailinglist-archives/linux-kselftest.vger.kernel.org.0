Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE87694233
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 11:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjBMKBc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 05:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjBMKBb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 05:01:31 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73244E3A7;
        Mon, 13 Feb 2023 02:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676282475; x=1707818475;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jM3ojbWxTDRR+9k9Uu+pTHtjkV94n0a+GM1BYfY+HOM=;
  b=UvThC3geREFmVlZlKIJqh5kMBv2vuPaeSCBnYAB65DI3d3EgOJFmF1xK
   itjWXync4omHSe5dH+iDxEK7inbGwRa7HNDMFss91AKcXM+2ymvbO6TZ1
   MJHSCvb0JVoM9wLBnyWsCKH8fGD1M13mrFoQvdcElxQV/hU4CPjfgXj+2
   PDmWZX5IYA/0orUJLfHNa4ZraQSxarkFxHbV+gt94/lBhJ+sj5MZl/Jz1
   4Z53ZsJyg06FWEDZGlatndbuiWoiSwvKO4oxaimo7betFeHPOsgh98ieS
   ES6rZghLRD91pu90ez1ih/J6+7BkftDbkauFjeV+AuTq78sMCHKWt4K59
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="395468062"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="395468062"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 02:01:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="997638071"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="997638071"
Received: from hdevries-mobl.ger.corp.intel.com ([10.249.36.140])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 02:00:54 -0800
Date:   Mon, 13 Feb 2023 12:00:52 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v7 4/6] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
In-Reply-To: <20230213062428.1721572-5-tan.shaopeng@jp.fujitsu.com>
Message-ID: <616c7fab-65ad-17b7-f360-94b7e22f892@linux.intel.com>
References: <20230213062428.1721572-1-tan.shaopeng@jp.fujitsu.com> <20230213062428.1721572-5-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 13 Feb 2023, Shaopeng Tan wrote:

> After creating a child process with fork() in CAT test, if an error
> occurs when parent process runs cat_val() or check_results(), the child

I'd replace the rest of the paragraph with this:

"returns early. The parent will wait pipe message from child which will 
never be sent by the child and the parent cannot proceeed to unmount 
resctrlfs."

> process will not be killed and also resctrlfs is not unmounted. Also if
> an error occurs when child process runs cat_val() or check_results(),
> the child process is returned, but the parent process will wait pipe
> message from child.
>
> Synchronize the exits between the parent and child. An error occurs
> whether in parents process or child process, the parents process
> always kills child process and runs umount_resctrlfs(), and the
> child process always waits to be killed by the parent process.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/cat_test.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 6a8306b0a109..477b62dac546 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -186,23 +186,20 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
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
>  
>  	if (bm_pid == 0) {
>  		/* Tell parent that child is ready */
>  		close(pipefd[0]);
>  		pipe_message = 1;
>  		if (write(pipefd[1], &pipe_message, sizeof(pipe_message)) <
> -		    sizeof(pipe_message)) {
> -			close(pipefd[1]);
> +		    sizeof(pipe_message))
> +			/*
> +			 * Just print the error message.
> +			 * Let while(1) run and wait for itself to be killed.
> +			 */
>  			perror("# failed signaling parent process");
> -			return errno;
> -		}
>  
>  		close(pipefd[1]);
>  		while (1)
> @@ -226,5 +223,5 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  	if (bm_pid)
>  		umount_resctrlfs();
>  
> -	return 0;
> +	return ret;
>  }
> 

The code change looks good.

-- 
 i.


