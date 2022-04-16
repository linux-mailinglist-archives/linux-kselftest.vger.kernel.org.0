Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1D2503507
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Apr 2022 09:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiDPHz4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Apr 2022 03:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiDPHzz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Apr 2022 03:55:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2C110877E;
        Sat, 16 Apr 2022 00:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650095604; x=1681631604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xV/d1iJRhjqgFrWqpQ6qFBsR6GoGgFOYv3MLCdk9Kno=;
  b=mpgWMiO57rMiBl/urS2/YiUpbxeo0GGvGVJPRrNC5egTLMn7LEy6x7Qq
   IONHLF7vz5SXZo23UV5O5R/MmWe5KbsggRCk4hYmdRb58XoT3CvjTCNAB
   lhAI66x+NDsHLLM1cCWUJvAIDmaZF7gUDuyqJNxTPYUOQWgBkWpYH+sg6
   My4ZjXqeR2/h0KHWqU8pMaUFXP8euyPhBlhORG/5r5FPQfcfpikJ2OwTq
   uWnO3ivqonicm4UitwNWZdoUkWE+98zRGuGXuObA5iuNqV9SsHAyL4wmb
   Oat7+MMd5J7RK3ljj28590uA4kmFfHFdaFQPEem5zm08DrwirER+DzB+J
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="243859024"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="243859024"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 00:53:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="528214753"
Received: from xpf.sh.intel.com ([10.239.182.112])
  by orsmga006.jf.intel.com with ESMTP; 16 Apr 2022 00:53:19 -0700
Date:   Sat, 16 Apr 2022 15:52:00 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        sandipan@linux.ibm.com, fweimer@redhat.com,
        desnesn@linux.vnet.ibm.com, mingo@kernel.org,
        bauerman@linux.ibm.com, mpe@ellerman.id.au, msuchanek@suse.de,
        linux-mm@kvack.org, chang.seok.bae@intel.com, bp@suse.de,
        tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, luto@kernel.org,
        heng.su@intel.com
Subject: Re: [PATCH V2 1/4] selftests: Provide local define of __cpuid_count()
Message-ID: <Ylp1oFenjgxWpM0D@xpf.sh.intel.com>
References: <cover.1647360971.git.reinette.chatre@intel.com>
 <7c49dbfe5bab04389ed84c516fcbfe31d66df880.1647360971.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c49dbfe5bab04389ed84c516fcbfe31d66df880.1647360971.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022-03-15 at 09:44:25 -0700, Reinette Chatre wrote:
> Some selftests depend on information provided by the CPUID instruction.
> To support this dependency the selftests implement private wrappers for
> CPUID.
> 
> Duplication of the CPUID wrappers should be avoided.
> 
> Both gcc and clang/LLVM provide __cpuid_count() macros but neither
> the macro nor its header file are available in all the compiler
> versions that need to be supported by the selftests. __cpuid_count()
> as provided by gcc is available starting with gcc v4.4, so it is
> not available if the latest tests need to be run in all the
> environments required to support kernels v4.9 and v4.14 that
> have the minimal required gcc v3.2.
> 
> Provide a centrally defined macro for __cpuid_count() to help
> eliminate the duplicate CPUID wrappers while continuing to
> compile in older environments.
> 
> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Note to maintainers:
> - Macro is identical to the one provided by gcc, but not liked by
>   checkpatch.pl with message "Macros with complex values should
>   be enclosed in parentheses". Similar style is used in kernel,
>   for example in arch/x86/kernel/fpu/xstate.h.
> 
>  tools/testing/selftests/kselftest.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index f1180987492c..898d7b2fac6c 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -52,6 +52,21 @@
> + * have __cpuid_count().
> + */
> +#ifndef __cpuid_count
> +#define __cpuid_count(level, count, a, b, c, d)				\
> +	__asm__ __volatile__ ("cpuid\n\t"				\
> +			      : "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
> +			      : "0" (level), "2" (count))
> +#endif
   Linux C check tool "scripts/checkpatch.pl" shows an error:
"
ERROR: Macros with complex values should be enclosed in parentheses
...
+#define __cpuid_count(level, count, a, b, c, d)                        \
+       __asm__ __volatile__ ("cpuid\n\t"                               \
+                             : "=a" (a), "=b" (b), "=c" (c), "=d" (d)  \
+                             : "0" (level), "2" (count))
"
Googling:
https://www.google.com/search?q=Macros+with+complex+values+should+be+enclosed+in+parentheses&rlz=1C1GCEB_enUS884US884&oq=Macros+with+complex+values+should+be+enclosed+in+parentheses&aqs=chrome.0.69i59j0i5i30l2.313j0j7&sourceid=chrome&ie=UTF-8
-> https://stackoverflow.com/questions/8142280/why-do-we-need-parentheses-around-block-macro

Could we fix it as follow, shall we?
"
#ifndef __cpuid_count
#define __cpuid_count(level, count, a, b, c, d) ({			\
	__asm__ __volatile__ ("cpuid\n\t"				\
			      : "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
			      : "0" (level), "2" (count))		\
})
#endif
"
Thanks!
--Pengfei
