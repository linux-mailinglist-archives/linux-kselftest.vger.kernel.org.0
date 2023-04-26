Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FC46EF5E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Apr 2023 15:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDZN7A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 09:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240570AbjDZN67 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 09:58:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4D06A52;
        Wed, 26 Apr 2023 06:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682517537; x=1714053537;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9SgBTnJblGwgDkEyMnQDPGqR7X3brA77OnxVHEByyUU=;
  b=iPko3ZLpPgl9bsAX2itFXhtp/fIrsspk/f9WmqGfxvp5YVop1cCdy7Yg
   a80tnePixVfY+/rwLz5+t5FWeqpwsLHnyUE5VhgpBHRMslAkKuThVfR7c
   Ks2MiqPny6iNNLZLnKQWRyHQnS+4WC5rE0afT0ksTuEMj3ClAKhpp6cLf
   alNVTv5zpGF6loZxN5C1sXsIWgYsooHLdWPWwhnMd2h/ZcmPHMkwUfjCM
   KelKpi1Zhb37xlQlaftM7Vyzr16BG9LlYALtMvufrCXhKWCFBisegTUS7
   vQB+0EayZFzA42chqp81HF9H7nLwpn80UE5TTbHLNdUDjYOxuLHLjwUIs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="410107019"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="410107019"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 06:58:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="940222385"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="940222385"
Received: from dancaspi-mobl1.ger.corp.intel.com ([10.252.60.3])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 06:58:49 -0700
Date:   Wed, 26 Apr 2023 16:58:42 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v2 24/24] selftests/resctrl: Rewrite Cache Allocation
 Technology (CAT) test
In-Reply-To: <eac72c7b-bd01-084e-cf23-ec5e8e0e3cf3@intel.com>
Message-ID: <b2f72637-5c16-d25b-8a0-3fee4ca9ec7e@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com> <20230418114506.46788-25-ilpo.jarvinen@linux.intel.com> <eac72c7b-bd01-084e-cf23-ec5e8e0e3cf3@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-289570517-1682517530=:2068"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-289570517-1682517530=:2068
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 21 Apr 2023, Reinette Chatre wrote:

> Hi Ilpo,
> 
> On 4/18/2023 4:45 AM, Ilpo Järvinen wrote:
> > CAT test spawns two processes into two different control groups with
> > exclusive schemata. Both the processes alloc a buffer from memory
> > matching their allocated LLC block size and flush the entire buffer out
> > of caches. Since the processes are reading through the buffer only once
> > during the measurement and initially all the buffer was flushed, the
> > test isn't testing CAT.
> > 
> > Rewrite the CAT test to allocated a buffer sized to half of LLC. Then
> 
> "allocated a buffer" -> "allocate a buffer" ?
> 
> > perform a sequence of tests with different LLC alloc sizes starting
> > from half of the CBM bits down to 1-bit CBM. Flush the buffer before
> > each test and read the buffer twice. Observe the LLC misses on the
> > second read through the buffer. As the allocated LLC block gets smaller
> > and smaller, the LLC misses will become larger and larger giving a
> > strong signal on CAT working properly.
> 
> Since the changelog starts by describing the CAT test needing two
> processes I think it would help to highlight that this test uses a
> single process. I think it would also help to describing how the cache
> is used by the rest while this test is running.

Sure, good points, I'll add the info.

> > Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  tools/testing/selftests/resctrl/cache.c    |  20 +-
> >  tools/testing/selftests/resctrl/cat_test.c | 204 +++++++++------------
> >  2 files changed, 97 insertions(+), 127 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> > index 7970239413da..64f08ba5edc2 100644
> > --- a/tools/testing/selftests/resctrl/cache.c
> > +++ b/tools/testing/selftests/resctrl/cache.c
> > @@ -224,10 +224,10 @@ int measure_llc_resctrl(struct resctrl_val_param *param, int bm_pid)
> >   */
> >  int cat_val(struct resctrl_val_param *param)
> >  {
> > -	int memflush = 1, operation = 0, ret = 0;
> >  	char *resctrl_val = param->resctrl_val;
> >  	unsigned long llc_perf_miss = 0;
> >  	pid_t bm_pid;
> > +	int ret;
> >  
> >  	if (strcmp(param->filename, "") == 0)
> >  		sprintf(param->filename, "stdio");
> > @@ -245,6 +245,10 @@ int cat_val(struct resctrl_val_param *param)
> >  	if (ret)
> >  		return ret;
> >  
> > +	ret = alloc_buffer(param->span, 1);
> > +	if (ret)
> > +		return ret;
> > +
> >  	initialize_llc_perf();
> >  
> >  	/* Test runs until the callback setup() tells the test to stop. */
> > @@ -256,17 +260,15 @@ int cat_val(struct resctrl_val_param *param)
> >  		}
> >  		if (ret < 0)
> >  			break;
> > +
> > +		flush_buffer(param->span);
> > +		use_buffer(param->span, 0, true);
> > +
> >  		ret = reset_enable_llc_perf(bm_pid, param->cpu_no);
> >  		if (ret)
> >  			break;
> >  
> > -		if (run_fill_buf(param->span, memflush, operation, true)) {
> > -			fprintf(stderr, "Error-running fill buffer\n");
> > -			ret = -1;
> > -			break;
> > -		}
> > -
> > -		sleep(1);
> > +		use_buffer(param->span, 0, true);
> >  
> >  		/* Measure cache miss from perf */
> >  		ret = get_llc_perf(&llc_perf_miss);
> > @@ -279,6 +281,8 @@ int cat_val(struct resctrl_val_param *param)
> >  			break;
> >  	}
> >  
> > +	free_buffer();
> > +
> >  	return ret;
> >  }
> >  
> > diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> > index 4b505fdb35d7..85053829b9c5 100644
> > --- a/tools/testing/selftests/resctrl/cat_test.c
> > +++ b/tools/testing/selftests/resctrl/cat_test.c
> > @@ -11,11 +11,12 @@
> >  #include "resctrl.h"
> >  #include <unistd.h>
> >  
> > -#define RESULT_FILE_NAME1	"result_cat1"
> > -#define RESULT_FILE_NAME2	"result_cat2"
> > -#define NUM_OF_RUNS		5
> > -#define MAX_DIFF_PERCENT	4
> > -#define MAX_DIFF		1000000
> > +#define RESULT_FILE_NAME		"result_cat"
> > +#define NUM_OF_RUNS			5
> > +#define MIN_DIFF_PERCENT_PER_BIT	2
> 
> Could you please start a new trend that adds documentation
> that explains what this constant means and how it was chosen?

I can try although that particular 2 was a bit handwavy that just seems to 
work with the tests I performed.

> > +static unsigned long current_mask;
> > +static long prev_avg_llc_val;
> >  
> >  /*
> >   * Change schemata. Write schemata to specified
> > @@ -28,13 +29,24 @@ static int cat_setup(struct resctrl_val_param *p)
> >  	int ret = 0;
> >  
> >  	/* Run NUM_OF_RUNS times */
> > -	if (p->num_of_runs >= NUM_OF_RUNS)
> > -		return END_OF_TESTS;
> > +	if (p->num_of_runs >= NUM_OF_RUNS) {
> > +		/* Remove one bit from the consecutive block */
> > +		current_mask &= current_mask >> 1;
> > +		if (!current_mask)
> > +			return END_OF_TESTS;
> > +
> > +		p->num_of_runs = 0;
> 
> This seems like a workaround to get the schemata to be written. It is
> problematic since now p->num_of_runs no longer accurately reflects the
> number of test runs.

This is already the case. MBA test works around this very same problem by 
using a custom static variable (runs_per_allocation) which is reset to 0 
every NUM_OF_RUNS tests and not keeping ->num_of_runs at all. If MBA test 
would replace runs_per_allocation with use of ->num_of_runs, it would 
match what the new CAT test does.

Nothing currently relies on ->num_of_runs counting across the different 
"tests" that are run inside CAT and MBA tests. And I don't have anything 
immediately around the corner that would require ->num_of_runs to count 
total number of repetitions that were ran.

I guess it would be possible to attempt to consolidate that second layer
MBA and the rewritten CAT tests need somehow into resctrl_val_param. But 
IMHO that too is low-prio refactor as nothing is broken as is.

> I was expecting this mask manipulation to be
> in cat_val() so that it is clear how test works instead of part
> of the logic handled here.

That seems to be moving into opposite direction from how things are 
currently handled. Doing it in cat_val() would be relying less on 
->setup(). If that's the preferred direction, then the question becomes, 
should CAT test do anything in ->setup() because also the schemata 
writing could be done in directly cat_val().

What I would prefer not to do is to have a rule which says: if there's a 
test-specific function, don't use ->setup() but do any setup directly 
in the test-specific function but, otherwise use ->setup(). Such an
inconsistency would make things hard to track.

> > +	}
> >  
> >  	if (p->num_of_runs == 0) {
> > -		sprintf(schemata, "%lx", p->mask);
> > -		ret = write_schemata(p->ctrlgrp, schemata, p->cpu_no,
> > -				     p->resctrl_val);
> > +		snprintf(schemata, sizeof(schemata), "%lx", p->mask & ~current_mask);
> > +		ret = write_schemata("", schemata, p->cpu_no, p->resctrl_val);
> > +		if (ret)
> > +			return ret;
> > +		snprintf(schemata, sizeof(schemata), "%lx", current_mask);
> > +		ret = write_schemata(p->ctrlgrp, schemata, p->cpu_no, p->resctrl_val);
> > +		if (ret)
> > +			return ret;
> >  	}
> >  	p->num_of_runs++;
> >  
> 
> ...
> 
> > @@ -126,7 +162,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
> >  	ret = get_mask_no_shareable(cache_type, &long_mask);
> >  	if (ret)
> >  		return ret;
> > -	count_of_bits = count_consecutive_bits(long_mask, NULL);
> > +	count_of_bits = count_consecutive_bits(long_mask, &start);
> >  
> >  	/* Get L3/L2 cache size */
> >  	ret = get_cache_size(cpu_no, cache_type, &cache_size);
> > @@ -143,99 +179,29 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
> >  			       count_of_bits - 1);
> >  		return -1;
> >  	}
> > -
> > -	/* Get core id from same socket for running another thread */
> > -	sibling_cpu_no = get_core_sibling(cpu_no);
> 
> Do any users of get_core_sibling() remain after this?

Correct observation, there seems to be no other users after this is 
removed.

-- 
 i.

--8323329-289570517-1682517530=:2068--
