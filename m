Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0244DE43A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Mar 2022 23:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbiCRWtH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Mar 2022 18:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbiCRWtG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Mar 2022 18:49:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1189D2CE06;
        Fri, 18 Mar 2022 15:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647643667; x=1679179667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FkHuNgc659yN21L5/D1sn0B4u/W0uIWKS75COKQLGJo=;
  b=RRZIrE89wr/xrZpfPrxXoRFugaV2DihNKoLxDCvPZKuB6OSiX2XKvrQl
   /MH7BjZSAXntPi2quO1aW1bbtRpC7ZMdtdewY8Hgf1cuXo0k2azomPnxJ
   Hi8+WBpQZrwcyVpzOp3+3FX12z8iXOh3UFLtBTDiotO4nx+8G3AL9dEJ1
   0i8eIw7zjtciJulTvQJ9uHMepEemYkHKhJYAXHUOiF1b4pR+rDAL3khet
   1ml2fpV80VAdoP975xcvuNr5LB8LMUQMaU+m20PlhlODw6XAt3V0opGyf
   ncFxROp+QJ11ufgFW+2lyHvVeEyy5sfr6IzTb7OqVWkyjpwwneQpDL6nP
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="256967138"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="256967138"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 15:47:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="542076895"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 15:47:46 -0700
Date:   Fri, 18 Mar 2022 15:47:42 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v6 1/6] selftests/resctrl: Kill child process before
 parent process terminates if SIGTERM is received
Message-ID: <YjUMDvPd8hMNkUbG@otcwcpicx3.sc.intel.com>
References: <20220318075807.2921063-1-tan.shaopeng@jp.fujitsu.com>
 <20220318075807.2921063-2-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318075807.2921063-2-tan.shaopeng@jp.fujitsu.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 18, 2022 at 04:58:02PM +0900, Shaopeng Tan wrote:
> In kselftest framework, a sub test is run using the timeout utility
                                   s/is run/runs/
> and it will send SIGTERM to the test upon timeout.
> 
> In resctrl_tests, a child process is created by fork() to
> run benchmark but SIGTERM is not set in sigaction().
> If SIGTERM signal is received, the parent process will be killed,
> but the child process still exists.
> 
> kill child process before parent process terminates

s/kill/Kill the/        add "the" before "parent"

> if SIGTERM signal is received.
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/resctrl_val.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 95224345c78e..b32b96356ec7 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -678,6 +678,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
>  	sigemptyset(&sigact.sa_mask);
>  	sigact.sa_flags = SA_SIGINFO;
>  	if (sigaction(SIGINT, &sigact, NULL) ||
> +	    sigaction(SIGTERM, &sigact, NULL) ||
>  	    sigaction(SIGHUP, &sigact, NULL)) {
>  		perror("# sigaction");
>  		ret = errno;
> -- 
> 2.27.0

Please fix the typos.

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
