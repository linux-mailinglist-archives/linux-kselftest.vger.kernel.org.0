Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8B94CDF03
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 22:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiCDUiS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 15:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiCDUiF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 15:38:05 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A065D31CD;
        Fri,  4 Mar 2022 12:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646426237; x=1677962237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4FG8XYoVVruS7FNpnH2bs+u63FbERV1MqJpDIHUQuKE=;
  b=lq/cfP6lxQ/kzsiqN40FaxT8Vkud8xI6o3eSveKHgYpyylEtQ+Lyua/B
   vj9ecV5TeFEsIe1XN4vq0rbhZP6Tz/w8y1XRIP9q0P/axD2WLU+nDr9Lt
   r4pwo8lqpwCgDo7qeS/vJtuZXg1rwFpqTrvWRTJGDD3i3XLMCLAU31dVY
   1N8U4DFkm58yo6rKlr9ssuA/ITH/8U1g2RCfAz/TtkPy9ceV8P1bU5fFb
   HNYMIIwtI9beotxRURm/JYzuCByjq/ROUc+DvgRtV8/gkNgEPBjI0b6iH
   Yoxc10N1nAASMgeoOvrLSbe8iCDQMDzQVgP/tFA74e1qwtPXtOB6giT74
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="252886706"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="252886706"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 12:37:16 -0800
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="509091847"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 12:37:16 -0800
Date:   Fri, 4 Mar 2022 12:37:09 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 5/6] selftests/resctrl: Update README about using
 kselftest framework to build/run resctrl_tests
Message-ID: <YiJ4YM49fFANO9C2@otcwcpicx3.sc.intel.com>
References: <20220304103834.486892-1-tan.shaopeng@jp.fujitsu.com>
 <20220304103834.486892-6-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304103834.486892-6-tan.shaopeng@jp.fujitsu.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 04, 2022 at 07:38:33PM +0900, Shaopeng Tan wrote:
> In this patch series, I make restrl_tests build/run using kselftest
> framework, but some users do not known how to build/run resctrl_tests
> using kseltest framework.

Please don't use "I" or "we" in commit messages. Also the grammar seems
not right here.

> 
> Add manual of how to make resctrl_tests build/run
> using kselftest framework into README.

Maybe change the commit message to this:

resctrl_tests can be built or run using kselftests framework. Add
description on how to do so in README.

> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/README | 31 +++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/resctrl/README b/tools/testing/selftests/resctrl/README
> index 3d2bbd4fa3aa..268cf3f95bd5 100644
> --- a/tools/testing/selftests/resctrl/README
> +++ b/tools/testing/selftests/resctrl/README
> @@ -12,9 +12,37 @@ Allocation test on Intel RDT hardware. More tests will be added in the future.
>  And the test suit can be extended to cover AMD QoS and ARM MPAM hardware
>  as well.
>  
> +resctrl_tests can be run with or without kselftest framework.
> +
> +USE KSELFTEST FRAMEWORK
> +-----------------------
> +
> +BUILD
> +-----

The "---" under titles are all same. This cannot tell readers clearly
topic hierarchies.

How about this?
+USE KSELFTEST FRAMEWORK
+-----------------------
+
+* BUILD
+

> +
> +Execute the following command in top level directory of the kernel source.
> +
> +Build resctrl:
> + $ make -C tools/testing/selftests TARGETS=resctrl
> +
> +RUN
> +---

How about this?
+* RUN
+
> +
> +Run resctrl:
> + $ make -C tools/testing/selftests TARGETS=resctrl run_tests

Run this as sudo or root.
+ $ sudo make -C tools/testing/selftests TARGETS=resctrl run_tests

> +
> +Using kselftest framework, the ./resctrl_tests will be run without any parameters.
> +
> +More details about kselftest framework as follow.
> +Documentation/dev-tools/kselftest.rst
> +
> +NOT USE KSELFTEST FRAMEWORK
> +---------------------------
> +
>  BUILD
>  -----
>  
> +Execute the following command in this directory(tools/testing/selftests/resctrl/).
>  Run "make" to build executable file "resctrl_tests".
>  
>  RUN
> @@ -24,7 +52,8 @@ To use resctrl_tests, root or sudoer privileges are required. This is because
>  the test needs to mount resctrl file system and change contents in the file
>  system.
>  
> -Executing the test without any parameter will run all supported tests:
> +Executing the test without any parameter will run all supported tests.
> +It takes about 68 seconds on a Intel(R) Xeon(R) Gold 6254 CPU @ 3.10GHz.

resctrl will add more tests in the future. Running time may be longer in
the future. I would suggest to remove the "It takes about 68 seconds..." line.

>  
>  	sudo ./resctrl_tests
>  
> -- 
> 2.27.0
> 

Thanks.

-Fenghua
