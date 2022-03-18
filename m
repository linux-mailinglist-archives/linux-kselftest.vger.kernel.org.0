Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F114DE45D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Mar 2022 23:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240288AbiCRW6g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Mar 2022 18:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbiCRW6f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Mar 2022 18:58:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4442E6D62;
        Fri, 18 Mar 2022 15:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647644234; x=1679180234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MIl7JsaOHxijGAIUuba/9eAjETHYaUeo9cez80W7ilw=;
  b=n/pds6vt7OoTQAWKRahj6BLY+dkrq8jPhy9DzCDgAE3JFr3vWgRxLTSZ
   fQ9Ys4uGS639ygi4YKHnkQYk5ihFzZCgR0kj7XAs6PVc1qlTcV+WjHK13
   7aFBJuo8tyx0XS4Ajd8ajIIK2bBM3weAwco7GrAg2dFNLhrU0ciipT9bb
   SJsn4kmavuewdLRZ+Bnf4ViqZFvZfc37s3xldMLXPmQbLIjR0js9tCHSz
   l7VjWjwUYC1x8arnSBOpcfag9oLEkqd6E4usZWao9pIWh/BokMGHvOuZR
   /qBfcyy7SfAJepXKKIfsunpctUe83eY3h6EY/UzO/HQc+BjyI4MA1v0o1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="257436901"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="257436901"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 15:57:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="715688135"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 15:57:14 -0700
Date:   Fri, 18 Mar 2022 15:57:13 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 5/6] selftests/resctrl: Update README about using
 kselftest framework to build/run resctrl_tests
Message-ID: <YjUOSQC0TAwaarJ9@otcwcpicx3.sc.intel.com>
References: <20220318075807.2921063-1-tan.shaopeng@jp.fujitsu.com>
 <20220318075807.2921063-6-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318075807.2921063-6-tan.shaopeng@jp.fujitsu.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 18, 2022 at 04:58:06PM +0900, Shaopeng Tan wrote:
> resctrl_tests can be built or run using kselftests framework.
> Add description on how to do so in README.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/README | 39 +++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/README b/tools/testing/selftests/resctrl/README
> index 3d2bbd4fa3aa..58d0cb4e6a16 100644
> --- a/tools/testing/selftests/resctrl/README
> +++ b/tools/testing/selftests/resctrl/README
> @@ -12,24 +12,49 @@ Allocation test on Intel RDT hardware. More tests will be added in the future.
>  And the test suit can be extended to cover AMD QoS and ARM MPAM hardware
>  as well.
>  
> +resctrl_tests can be run with or without kselftest framework.
> +
> +WITH KSELFTEST FRAMEWORK
> +=======================
> +
>  BUILD
>  -----
>  
> -Run "make" to build executable file "resctrl_tests".
> +Build executable file "resctrl_tests" from top level directory of the kernel source:
> + $ make -C tools/testing/selftests TARGETS=resctrl
>  
>  RUN
>  ---
>  
> -To use resctrl_tests, root or sudoer privileges are required. This is because
> -the test needs to mount resctrl file system and change contents in the file
> -system.
> +Run resctrl_tests as sudo or root since the test needs to mount resctrl file
> +system and change contents in the file system.
> +Using kselftest framework will run all supported tests within resctrl_tests:
> +
> + $ sudo make -C tools/testing/selftests TARGETS=resctrl run_tests
> +
> +More details about kselftest framework can be found in
> +Documentation/dev-tools/kselftest.rst.
> +
> +WITHOUT KSELFTEST FRAMEWORK
> +===========================
> +
> +BUILD
> +-----
> +
> +Build executable file "resctrl_tests" from this directory(tools/testing/selftests/resctrl/):
> +  $ make
> +
> +RUN
> +---
>  
> +Run resctrl_tests as sudo or root since the test needs to mount resctrl file
> +system and change contents in the file system.
>  Executing the test without any parameter will run all supported tests:
>  
> -	sudo ./resctrl_tests
> + $ sudo ./resctrl_tests
>  
>  OVERVIEW OF EXECUTION
> ----------------------
> +=====================
>  
>  A test case has four stages:
>  
> @@ -41,7 +66,7 @@ A test case has four stages:
>    - teardown: umount resctrl and clear temporary files.
>  
>  ARGUMENTS
> ----------
> +=========
>  
>  Parameter '-h' shows usage information.
>  
> -- 
> 2.27.0
> 
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
