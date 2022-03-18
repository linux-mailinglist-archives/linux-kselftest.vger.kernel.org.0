Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961034DE459
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Mar 2022 23:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241372AbiCRW5B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Mar 2022 18:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbiCRW5A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Mar 2022 18:57:00 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850922CB193;
        Fri, 18 Mar 2022 15:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647644140; x=1679180140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xpw1e+WCyhXngW08aawz7OWfMjoVe0z/2/nbVbuqEj4=;
  b=UMtL8GnauD3cSCh/24t+jLKg3lPuB1oR8UXrMBXzTN5P1sgtVuFKw3AZ
   2SCMOLECbE1KBGnLMpVCnghm8gbBNEOg0ccoMzHgZo8hJiTbRM8BoTxge
   eH7PQjr6MVsWfVlXccaVYVTWe+YzNX4br5uL8spjoeU3K/vX3hDMqsotc
   YfYSFF5VTQf2Ktn1/5bByQYSylRAfyw9gfy8Ny+irlejj+kpJi1XhUbPC
   Uopm5QW17MVYRv5gRMrFbTpliqX5KJFzZgVC0huCvlBwvp5+vZfV+T6vJ
   yS9jadgLjt+uA03mmF0WNmGsfgwal9h4AAEAWrIGFln2eZR4ygzRCv50O
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="317954231"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="317954231"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 15:55:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="599681950"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 15:55:39 -0700
Date:   Fri, 18 Mar 2022 15:55:34 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 4/6] selftests/resctrl: Make resctrl_tests run using
 kselftest framework
Message-ID: <YjUN5tnFtkMp17zt@otcwcpicx3.sc.intel.com>
References: <20220318075807.2921063-1-tan.shaopeng@jp.fujitsu.com>
 <20220318075807.2921063-5-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318075807.2921063-5-tan.shaopeng@jp.fujitsu.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 18, 2022 at 04:58:05PM +0900, Shaopeng Tan wrote:
> In kselftest framework, all tests can be build/run at a time,
					s/build/built/
> and a sub test also can be build/run individually. As follows:
			    s/build/built/
> $ make kselftest-all TARGETS=resctrl
> $ make -C tools/testing/selftests run_tests
> $ make -C tools/testing/selftests TARGETS=resctrl run_tests
> 
> However, resctrl_tests cannot be run using kselftest framework,
> users have to change directory to tools/testing/selftests/resctrl/,
> run "make" to build executable file "resctrl_tests",
> and run "sudo ./resctrl_tests" to execute the test.
> 
> To build/run resctrl_tests using kselftest framework.
> Modify tools/testing/selftests/Makefile
> and tools/testing/selftests/resctrl/Makefile.
> 
> Even after this change, users can still build/run resctrl_tests
> without using framework as before.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/Makefile         |  1 +
>  tools/testing/selftests/resctrl/Makefile | 17 ++++-------------
>  2 files changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index d08fe4cfe811..6138354b3760 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -52,6 +52,7 @@ TARGETS += proc
>  TARGETS += pstore
>  TARGETS += ptrace
>  TARGETS += openat2
> +TARGETS += resctrl
>  TARGETS += rlimits
>  TARGETS += rseq
>  TARGETS += rtc
> diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
> index 6bcee2ec91a9..bee5fa8f1ac9 100644
> --- a/tools/testing/selftests/resctrl/Makefile
> +++ b/tools/testing/selftests/resctrl/Makefile
> @@ -1,17 +1,8 @@
> -CC = $(CROSS_COMPILE)gcc
>  CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
> -SRCS=$(wildcard *.c)
> -OBJS=$(SRCS:.c=.o)
> +CFLAGS += $(KHDR_INCLUDES)
>  
> -all: resctrl_tests
> +TEST_GEN_PROGS := resctrl_tests
>  
> -$(OBJS): $(SRCS)
> -	$(CC) $(CFLAGS) -c $(SRCS)
> +include ../lib.mk
>  
> -resctrl_tests: $(OBJS)
> -	$(CC) $(CFLAGS) -o $@ $^
> -
> -.PHONY: clean
> -
> -clean:
> -	$(RM) $(OBJS) resctrl_tests
> +$(OUTPUT)/resctrl_tests: $(wildcard *.c)
> -- 
> 2.27.0
> 

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
