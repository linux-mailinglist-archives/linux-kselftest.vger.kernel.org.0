Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9418268DA2D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 15:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjBGOJX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 09:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjBGOJW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 09:09:22 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A7B61B8;
        Tue,  7 Feb 2023 06:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675778961; x=1707314961;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=D+s+xJYNtyKUrNWPCUskYm55IKEKSH1iYwC7Lk3zkZk=;
  b=SgSDFNDWoG71siBVVMLa39T0HSfCrAny+rX295IAN/33D+6RgPQ+4IgF
   6yuqzHEslTj45oqS7/zus1EGs62HuqbLaB13zMc9qZg/aG4eX2lT8ymHZ
   0ax9LCdHBg4pCsqRtjhX9cosbHdV1JnAaFVke4zNc/IcTxs2UEyTSViLZ
   DT8sFX8/rZG6wgt/rMrF0YuNUIOgklAne5KVvq9zfa1Dd98hazUcYYdIJ
   Nw4+K9vXZMmjZuSoDqYBn8xPmTC4go/NmyA/ZwRY37O3G7dT9A/b1IHbk
   JYEIRNksrfB5EY8xPrpD/aUJGhoMNSSVe/Lh1B+AZ3xcmBHvqKgu6Aclo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="329531025"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="329531025"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 06:05:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="660240909"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="660240909"
Received: from msharawy-mobl.ger.corp.intel.com ([10.249.37.46])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 06:05:10 -0800
Date:   Tue, 7 Feb 2023 16:05:04 +0200 (EET)
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
Message-ID: <83e1de31-b448-1a51-ba39-faec794694f@linux.intel.com>
References: <20230131054655.396270-1-tan.shaopeng@jp.fujitsu.com> <20230131054655.396270-5-tan.shaopeng@jp.fujitsu.com>
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

If the write error is ignored here, won't it just lead to parent hanging 
forever waiting for the child to send the message through the pipe which 
will never come?


-- 
 i.

