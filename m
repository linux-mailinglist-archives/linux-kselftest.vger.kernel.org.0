Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FEA77DAFA
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 09:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242328AbjHPHOe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 03:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbjHPHOF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 03:14:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8BD2117;
        Wed, 16 Aug 2023 00:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692170043; x=1723706043;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qERvX9euglDUfy6iH414TDACzI4p0vVsxhFl+o8h6yU=;
  b=U4vxWJ6dwB9LiJ0HS/w6wPwEnfsiyctfTXRI+YB6wG2mGYzoM24eJfdf
   mDimV+lTqjn75tkoiBlTP/LsdQnAlWX231HmymFAX1O/408ZCd7nccs1g
   /DwNkiomNxEJxCCRIQwESxMBJQ2a6pJBs7115pknKISBGc0ogE1oXDM4m
   TXEtsCFRTZftWh5wymnXPmgmMhpb4tktwTzYkqjrvcJujo/7XHMSWPaUT
   cXzIpPLs+R/AVLRpWyrqW3IlyB3KrDgF4UoUpumXuJlmajp3g1vTyq9El
   1cwl8LsVg6wgPVnF47LelJeGk2tCzfwtmL/3M1wVFcTbwxAIqMPWNQATY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352788999"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="352788999"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 00:14:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="711011861"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="711011861"
Received: from ilivshiz-mobl.ger.corp.intel.com ([10.251.211.105])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 00:14:00 -0700
Date:   Wed, 16 Aug 2023 10:13:58 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH 5/7] selftests/resctrl: Use pointers to build benchmark
 cmd and make it const
In-Reply-To: <87183b24-f343-2420-9bda-f1012e7195a1@intel.com>
Message-ID: <f22efaf4-d87f-d3c4-b986-7d326c912a18@linux.intel.com>
References: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com> <20230808091625.12760-6-ilpo.jarvinen@linux.intel.com> <f300a52c-d65f-fd74-18ce-7d37e76d144f@intel.com> <dd83f672-b9fc-cd79-10ff-70651d4822af@linux.intel.com>
 <87183b24-f343-2420-9bda-f1012e7195a1@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1877192622-1692170042=:1780"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1877192622-1692170042=:1780
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 15 Aug 2023, Reinette Chatre wrote:
> On 8/15/2023 2:42 AM, Ilpo Järvinen wrote:
> > On Mon, 14 Aug 2023, Reinette Chatre wrote:
> >>
> >> On 8/8/2023 2:16 AM, Ilpo Järvinen wrote:
> >>> Benchmark parameter uses fixed-size buffers in stack which is slightly
> >>> dangerous. As benchmark command is used in multiple tests, it should
> >>
> >> Could you please be specific with issues with current implementation?
> >> The term "slightly dangerous" is vague.
> > 
> > I've reworded this so this fragment no longer remains here because the 
> > earlier patch got changes so the dangerous part is no longer there.
> > 
> >>> not be mutated by the tests. Due to the order of tests, mutating the
> >>> span argument in CMT test does not trigger any real problems currently.
> >>>
> >>> Mark benchmark_cmd strings as const and setup the benchmark command
> >>> using pointers. As span is constant in main(), just provide the default
> >>> span also as string to be used in setting up the default fill_buf
> >>> argument so no malloc() is required for it.
> >>
> >> What is wrong with using malloc()?
> > 
> > Nothing. I think you slightly misunderstood what I meant here.
> > 
> > The main challenge is not malloc() itself but keeping track of what memory 
> > has been dynamically allocated, which is simple if nothing has been 
> > malloc()ed. With the const benchmark command and default span, there's no 
> > need to malloc(), thus I avoid it to keep things simpler on the free() 
> > side.
> 
> Keeping things symmetrical helps.
>
> > I've tried to reword the entire changelog, please check the v2 changelog 
> > once I post it.
> > 
> >>> CMT test has to create a copy of the benchmark command before altering
> >>> the benchmark command.
> >>>
> >>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >>> ---
> >>>  tools/testing/selftests/resctrl/cmt_test.c    | 23 ++++++++++---
> >>>  tools/testing/selftests/resctrl/mba_test.c    |  2 +-
> >>>  tools/testing/selftests/resctrl/mbm_test.c    |  2 +-
> >>>  tools/testing/selftests/resctrl/resctrl.h     | 16 ++++++---
> >>>  .../testing/selftests/resctrl/resctrl_tests.c | 33 ++++++++-----------
> >>>  tools/testing/selftests/resctrl/resctrl_val.c | 10 ++++--
> >>>  6 files changed, 54 insertions(+), 32 deletions(-)
> >>>
> >>> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> >>> index 9d8e38e995ef..a40e12c3b1a7 100644
> >>> --- a/tools/testing/selftests/resctrl/cmt_test.c
> >>> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> >>> @@ -68,14 +68,16 @@ void cmt_test_cleanup(void)
> >>>  	remove(RESULT_FILE_NAME);
> >>>  }
> >>>  
> >>> -int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
> >>> +int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd)
> >>>  {
> >>> +	const char *cmd[BENCHMARK_ARGS];
> >>>  	unsigned long cache_size = 0;
> >>>  	unsigned long long_mask;
> >>> +	char *span_str = NULL;
> >>>  	char cbm_mask[256];
> >>>  	int count_of_bits;
> >>>  	size_t span;
> >>> -	int ret;
> >>> +	int ret, i;
> >>>  
> >>>  	if (!validate_resctrl_feature_request(CMT_STR))
> >>>  		return -1;
> >>> @@ -111,12 +113,22 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
> >>>  	};
> >>>  
> >>>  	span = cache_size * n / count_of_bits;
> >>> -	if (strcmp(benchmark_cmd[0], "fill_buf") == 0)
> >>> -		sprintf(benchmark_cmd[1], "%zu", span);
> >>> +	/* Duplicate the command to be able to replace span in it */
> >>> +	for (i = 0; benchmark_cmd[i]; i++)
> >>> +		cmd[i] = benchmark_cmd[i];
> >>> +	cmd[i] = NULL;
> >>> +
> >>> +	if (strcmp(cmd[0], "fill_buf") == 0) {
> >>> +		span_str = malloc(SIZE_MAX_DECIMAL_SIZE);
> >>> +		if (!span_str)
> >>> +			return -1;
> >>> +		snprintf(span_str, SIZE_MAX_DECIMAL_SIZE, "%zu", span);
> >>
> >> Have you considered asprintf()?
> > 
> > Changed to asprintf() now.
> >  
> >>> +		cmd[1] = span_str;
> >>> +	}
> >>
> >> It looks to me that array only needs to be duplicated if the
> >> default benchmark is used?
> > 
> > While it's true, another aspect is how that affects the code flow. If I 
> > make that change, the benchmark command could come from two different 
> > places which is now avoided. IMHO, the current approach is simpler to 
> > understand even if it does the unnecessary copy of a few pointers.
> 
> cmd provided to resctrl_val() can point to original buffer or modified
> buffer. What is wrong with a pointer possibly pointing to two different
> locations? 

I'll change to that.

> > But please let me know if you still prefer the other way around so I can 
> > change to that.
> 
> Your motivation for this approach is not clear to me.
> 
> > 
> >>>  	remove(RESULT_FILE_NAME);
> >>>  
> >>> -	ret = resctrl_val(benchmark_cmd, &param);
> >>> +	ret = resctrl_val(cmd, &param);
> >>>  	if (ret)
> >>>  		goto out;
> >>>  
> >>
> >> ...
> >>
> >>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> >>> index bcd0d2060f81..ddb1e83a3a64 100644
> >>> --- a/tools/testing/selftests/resctrl/resctrl.h
> >>> +++ b/tools/testing/selftests/resctrl/resctrl.h
> >>> @@ -6,6 +6,7 @@
> >>>  #include <math.h>
> >>>  #include <errno.h>
> >>>  #include <sched.h>
> >>> +#include <stdint.h>
> >>>  #include <stdlib.h>
> >>>  #include <unistd.h>
> >>>  #include <string.h>
> >>> @@ -38,7 +39,14 @@
> >>>  
> >>>  #define END_OF_TESTS	1
> >>>  
> >>> +#define BENCHMARK_ARGS		64
> >>> +
> >>> +/* Approximate %zu max length */
> >>> +#define SIZE_MAX_DECIMAL_SIZE	(sizeof(SIZE_MAX) * 8 / 3 + 2)
> >>> +
> >>> +/* Define default span both as integer and string, these should match */
> >>>  #define DEFAULT_SPAN		(250 * MB)
> >>> +#define DEFAULT_SPAN_STR	"262144000"
> >>
> >> I think above hardcoding can be eliminated by using asprintf()? This
> >> does allocate memory though so I would like to understand why one
> >> goal is to not dynamically allocate memory.
> > 
> > Because it's simpler on the _free() side_. If there's no allocation, no 
> > free() is needed.
> > 
> > Only challenge that remains is the int -> string conversion for the 
> > default span which can be either done like in the patch or using some 
> > preprocessor trickery to convert the number to string. If you prefer the 
> > latter, I can change to that so it's not hardcoded both as int and string.
> > 
> 
> This manual int->string sounds like the trickery to me and can be avoided
> by just using asprintf(). I understand that no free() is needed when no
> memory is allocated but it looks to me as though these allocations can
> be symmetrical - allocate the memory before the tests are run and free it
> after?

It could be symmetrical but that means I'll be doing unnecessary alloc if 
-b is provided which I assume you're against given your comment on always 
creating copy of cmd in CMT test's case.

I think I'll use similar resolution to this as CMT test does, it has an 
extra variable which is NULL in when -b is provided so free() is no-op
on that path. Then I can use asprintf().

-- 
 i.

--8323329-1877192622-1692170042=:1780--
