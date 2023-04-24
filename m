Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9E56ED274
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Apr 2023 18:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjDXQ2s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Apr 2023 12:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjDXQ2r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Apr 2023 12:28:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2D6103;
        Mon, 24 Apr 2023 09:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682353726; x=1713889726;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LQJamqxquK4Wabk/eIBuqWgvgvN10z8+4pJsstq8F8E=;
  b=VJDaW3IdWTwa67RLkdwTplvus8aY2V1eZaugxMFbjf1Ps/gC4YKDIz3n
   D8oOzKPkHZ17HVJedEfnGPAat9n1X9pVcxt3s8DnchsYdzXuSPYxgE05i
   GyxHiczeJ7465hsWUsiQmiTX81WMWifoR9xGTa08hT4b95PEn7T5k9XNZ
   VE+4VtnCxsp4eVQZxcGHEytoXj5C/OqF3qcOKiUlF9IHpa5v/C/wpYhNI
   XVK63n67jqn2YZnVt5ZT7uYUnmjkEQ5iMKP9O9IpXl0ExfuZhQ3EgV58A
   T3JJmgF8BLfLvKRKI3LOJRYEHiJLwIVeUSMgTR19tWRWatgV0ISvW8fqn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="346521779"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="346521779"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 09:28:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="686918824"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="686918824"
Received: from wlwpo-8.amr.corp.intel.com ([10.251.215.143])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 09:28:43 -0700
Date:   Mon, 24 Apr 2023 19:28:40 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v2 16/24] selftests/resctrl: Create cache_alloc_size()
 helper
In-Reply-To: <287e5f1f-87d5-473a-2bff-271adca8d458@intel.com>
Message-ID: <5db5680-4123-17b8-e657-39ba20356259@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com> <20230418114506.46788-17-ilpo.jarvinen@linux.intel.com> <287e5f1f-87d5-473a-2bff-271adca8d458@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-354780187-1682353725=:2038"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-354780187-1682353725=:2038
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 21 Apr 2023, Reinette Chatre wrote:

> On 4/18/2023 4:44 AM, Ilpo Järvinen wrote:
> > CAT and CMT tests calculate the span size from the n-bits cache
> > allocation on their own.
> > 
> > Add cache_alloc_size() helper which calculates size of the cache
> > allocation for the given number of bits to avoid duplicating code.
> 
> This patch is very heavy on the usage of allocation when I think it
> only refers to the cache size ... how that size is used by the caller
> is independent from this. 
> 
> Compare to how it sounds with some small changes to changelog:
> 
> 	CAT and CMT tests calculate the span size from the capacity
> 	bitmask independently.
> 	
> 	Add cache_size() helper which calculates the size of the
> 	cache for the given number of bits to avoid duplicating code.
> 
> I think removing "alloc" helps to convey what this code actually does.

Does it? Without something to indicate its not the full cache size, 
there's possiblity for confusion. While the tests are mostly interested 
in the allocated size, the full cache size is also collected (solely for 
printing it out, IIRC). Maybe I should rename those variable to 
total_cache_size or something like that to mitigate the confusion?

> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  tools/testing/selftests/resctrl/cache.c    | 27 ++++++++++++++++++++++
> >  tools/testing/selftests/resctrl/cat_test.c |  8 +++++--
> >  tools/testing/selftests/resctrl/cmt_test.c |  4 +++-
> >  tools/testing/selftests/resctrl/resctrl.h  |  2 ++
> >  4 files changed, 38 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> > index 6bc912de38be..b983af394e33 100644
> > --- a/tools/testing/selftests/resctrl/cache.c
> > +++ b/tools/testing/selftests/resctrl/cache.c
> > @@ -15,6 +15,33 @@ static struct read_format rf_cqm;
> >  static int fd_lm;
> >  char llc_occup_path[1024];
> >  
> > +/*
> > + * cache_alloc_size - Calculate alloc size for given cache alloc mask
> 
> "cache_size - Calculate number of bytes represented by bitmask" ?
> Please feel free to improve.
> 
> 
> > + * @cpu_no:		CPU number
> > + * @cache_type:		Cache level L2/L3
> > + * @alloc_mask:		Cache alloc mask
> 
> The description is mostly a rewrite of the variable name. Can it be
> more descriptive?
> 
> > + * @alloc_size:		Alloc size returned on success
> 
> I do not think the utility should assume anything about how
> the value it provides should be used. Instead it should just reflect
> what the value is.

I was just referring to that the value is filled only on success.

> > + * Returns: 0 on success with @alloc_size filled, non-zero on error.
> > + */
> > +int cache_alloc_size(int cpu_no, char *cache_type, unsigned long alloc_mask,
> > +		     unsigned long *alloc_size)
> > +{
> > +	unsigned long cache_size, full_mask;
> > +	int ret;
> > +
> > +	ret = get_cbm_mask(cache_type, &full_mask);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = get_cache_size(cpu_no, cache_type, &cache_size);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*alloc_size = cache_size * count_bits(alloc_mask) / count_bits(full_mask);
> > +	return 0;
> > +}
> > +
> >  static void initialize_perf_event_attr(void)
> >  {
> >  	pea_llc_miss.type = PERF_TYPE_HARDWARE;
> > diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> > index 9bf5d05d9e74..d3fbd4de9f8a 100644
> > --- a/tools/testing/selftests/resctrl/cat_test.c
> > +++ b/tools/testing/selftests/resctrl/cat_test.c
> > @@ -140,7 +140,9 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
> >  	/* Set param values for parent thread which will be allocated bitmask
> >  	 * with (max_bits - n) bits
> >  	 */
> > -	param.span = cache_size * (count_of_bits - n) / count_of_bits;
> > +	ret = cache_alloc_size(cpu_no, cache_type, l_mask, &param.span);
> > +	if (ret)
> > +		return ret;
> >  	strcpy(param.ctrlgrp, "c2");
> >  	strcpy(param.mongrp, "m2");
> >  	strcpy(param.filename, RESULT_FILE_NAME2);
> > @@ -162,7 +164,9 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
> >  		param.mask = l_mask_1;
> >  		strcpy(param.ctrlgrp, "c1");
> >  		strcpy(param.mongrp, "m1");
> > -		param.span = cache_size * n / count_of_bits;
> > +		ret = cache_alloc_size(cpu_no, cache_type, l_mask_1, &param.span);
> > +		if (ret)
> > +			exit(-1);
> >  		strcpy(param.filename, RESULT_FILE_NAME1);
> >  		param.num_of_runs = 0;
> >  		param.cpu_no = sibling_cpu_no;
> 
> Did this change intend to remove the duplicate code mentioned
> in the changelog?

It removes n CBM bits -> cache size calculations by collecting the 
calculation into one place.

cache_alloc_size() takes mask instead of n (CBM bits) as input which makes 
things easier down the line when the new CAT test starts to tweak the 
alloc size. The new CAT test would otherwise need to track both the mask 
and n.

cache_alloc_size() is independent of what caller requires so the full mask 
is not passed from the caller.

> I was expecting the calls to get_cbm_mask() and get_cache_size() within 
> cat_perf_miss_val() to be removed.

I would have wanted to remove get_cache_size() but it would mean removing 
cache size print or moving it to elsewhere.

get_cbm_mask() cannot be removed as it's used by the test to calculate the 
mask the test wants (but it no longer has to determine the size itself but 
uses this new helper instead).

I can try to amend the changelog to explain things better.

> > diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> > index ae54bbabbd91..efe77e0f1d4c 100644
> > --- a/tools/testing/selftests/resctrl/cmt_test.c
> > +++ b/tools/testing/selftests/resctrl/cmt_test.c
> > @@ -105,10 +105,12 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
> >  		.cpu_no		= cpu_no,
> >  		.filename	= RESULT_FILE_NAME,
> >  		.mask		= ~(long_mask << n) & long_mask,
> > -		.span		= cache_size * n / count_of_bits,
> >  		.num_of_runs	= 0,
> >  		.setup		= cmt_setup,
> >  	};
> > +	ret = cache_alloc_size(cpu_no, "L3", param.mask, &param.span);
> > +	if (ret)
> > +		return ret;
> >  
> >  	if (strcmp(benchmark_cmd[0], "fill_buf") == 0)
> >  		sprintf(benchmark_cmd[1], "%lu", param.span);
> 
> Same here regarding removal of code.
> 
> > diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> > index bcc95faa5b4e..65425d92684e 100644
> > --- a/tools/testing/selftests/resctrl/resctrl.h
> > +++ b/tools/testing/selftests/resctrl/resctrl.h
> > @@ -108,6 +108,8 @@ int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd);
> >  void mba_test_cleanup(void);
> >  int get_cbm_mask(char *cache_type, unsigned long *mask);
> >  int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
> > +int cache_alloc_size(int cpu_no, char *cache_type, unsigned long alloc_mask,
> > +		     unsigned long *alloc_size);
> >  void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
> >  int signal_handler_register(void);
> >  void signal_handler_unregister(void);
> 
> 
> Reinette
> 

-- 
 i.

--8323329-354780187-1682353725=:2038--
