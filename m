Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD157E01D6
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 12:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjKCK5l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 06:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjKCK5j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 06:57:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC85D43;
        Fri,  3 Nov 2023 03:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699009050; x=1730545050;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KIf1i8WL0NmxzYLeG98xi+BQwXJHUy3lMDQbLl4c0Bw=;
  b=D9B1etdFkeZMWMyKmZ/OgnzLzomFvakGQUfivsRzjcZSPyuqiWrtSHrc
   dSD8wuXrMzhzQxKIdRBd8x5tRKbdryUluew9oG4uhYXIp/SI66PMFaiGG
   a8cHlPwGg1UN5g52/57DYx+vmVOOi/23HWG4rcXZa90HuvDN9n5krSOZ+
   8RgNJZbsLFSwnuwM2i4SymsxmTm9p9siuoRh73aDYLy7ND6pegTYp8zwS
   Trw9xqbS1f0kZDMQHj0wmvwweZYwY6cO65lUcIteCdNCZUSZUIQdhf0Bd
   y2trXjcEbBSiFedcrU0bYNmq5sUmmB/iAi3OdsqEa0PV9p8EA1RFxKvVQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="420034844"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="420034844"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 03:57:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="755123616"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="755123616"
Received: from pors-mobl3.ger.corp.intel.com ([10.252.35.38])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 03:57:26 -0700
Date:   Fri, 3 Nov 2023 12:57:24 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/24] selftests/resctrl: Rewrite Cache Allocation
 Technology (CAT) test
In-Reply-To: <fe5284f7-c27a-4ec3-b12f-f3556a9bb456@intel.com>
Message-ID: <86c11925-8c3f-3974-7d5d-8df9e6cc1b2c@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com> <20231024092634.7122-17-ilpo.jarvinen@linux.intel.com> <fe5284f7-c27a-4ec3-b12f-f3556a9bb456@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1041348085-1699009049=:1725"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1041348085-1699009049=:1725
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 2 Nov 2023, Reinette Chatre wrote:
> On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
> > CAT test spawns two processes into two different control groups with
> > exclusive schemata. Both the processes alloc a buffer from memory
> > matching their allocated LLC block size and flush the entire buffer out
> > of caches. Since the processes are reading through the buffer only once
> > during the measurement and initially all the buffer was flushed, the
> > test isn't testing CAT.
> > 
> > Rewrite the CAT test to allocate a buffer sized to half of LLC. Then
> > perform a sequence of tests with different LLC alloc sizes starting
> > from half of the CBM bits down to 1-bit CBM. Flush the buffer before
> > each test and read the buffer twice. Observe the LLC misses on the
> > second read through the buffer. As the allocated LLC block gets smaller
> > and smaller, the LLC misses will become larger and larger giving a
> > strong signal on CAT working properly.
> > 
> > The new CAT test is using only a single process because it relies on
> > measured effect against another run of itself rather than another
> > process adding noise. The rest of the system is allocated the CBM bits
> > not used by the CAT test to keep the test isolated.
> > 
> > Replace count_bits() with count_contiguous_bits() to get the first bit
> > position in order to be able to calculate masks based on it.
> > 
> > This change has been tested with a number of systems from different
> > generations.
> 
> Thank you very much for doing this.
> 
> > 
> > Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  tools/testing/selftests/resctrl/cat_test.c  | 286 +++++++++-----------
> >  tools/testing/selftests/resctrl/fill_buf.c  |   6 +-
> >  tools/testing/selftests/resctrl/resctrl.h   |   5 +-
> >  tools/testing/selftests/resctrl/resctrlfs.c |  44 +--
> >  4 files changed, 137 insertions(+), 204 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> > index e71690a9bbb3..7518c520c5cc 100644
> > --- a/tools/testing/selftests/resctrl/cat_test.c
> > +++ b/tools/testing/selftests/resctrl/cat_test.c
> > @@ -11,65 +11,68 @@
> >  #include "resctrl.h"
> >  #include <unistd.h>
> >  
> > -#define RESULT_FILE_NAME1	"result_cat1"
> > -#define RESULT_FILE_NAME2	"result_cat2"
> > +#define RESULT_FILE_NAME	"result_cat"
> >  #define NUM_OF_RUNS		5
> > -#define MAX_DIFF_PERCENT	4
> > -#define MAX_DIFF		1000000
> >  
> >  /*
> > - * Change schemata. Write schemata to specified
> > - * con_mon grp, mon_grp in resctrl FS.
> > - * Run 5 times in order to get average values.
> > + * Minimum difference in LLC misses between a test with n+1 bits CBM mask to
> > + * the test with n bits. With e.g. 5 vs 4 bits in the CBM mask, the minimum
> > + * difference must be at least MIN_DIFF_PERCENT_PER_BIT * (4 - 1) = 3 percent.
> 
> This formula is not clear to me. In the code the formula is always:
> MIN_DIFF_PERCENT_PER_BIT * (bits - 1) ... is the "-1" because it always
> decrements the number of bits tested by one?

No, -1 is not related to decrementing bits by one, but setting a boundary 
which workds for 1 bit masks. In general,  the smaller the number of bits 
in the allocation mask is, less change there will be between n+1 -> n bits
results. When n is 1, the result with some platforms is close to zero so I 
just had to make the min diff to allow it. Thus, n-1 to set the failure 
threshold at 0%.

> So, for example, if testing
> 5 then 3 bits it would be  MIN_DIFF_PERCENT_PER_BIT * (3 - 2)?
> Would above example thus be:
> MIN_DIFF_PERCENT_PER_BIT * (4 - (5 - 4)) = 3 ?

I suspect you're overthinking it here. The CAT selftest currently doesn't 
jump from 5 to 3 bits so I don't know what you're trying to calculate 
here.

> > - * Return:	0 on success. non-zero on failure.
> > + * Return:		0 on success. non-zero on failure.
> 
> Is non-zero specific enough? Does that mean that <0 and >0 are failure?

I suspect it is, after all the cleanups and fixes that have been done.
The wording is from the original though.

> >   */
> > -static int cat_test(struct resctrl_val_param *param, size_t span)
> > +static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long current_mask)
> >  {
> > -	int memflush = 1, operation = 0, ret = 0;
> >  	char *resctrl_val = param->resctrl_val;
> >  	static struct perf_event_read pe_read;
> >  	struct perf_event_attr pea;
> > +	unsigned char *buf;
> > +	char schemata[64];
> > +	int ret, i, pe_fd;
> >  	pid_t bm_pid;
> > -	int pe_fd;
> >  
> >  	if (strcmp(param->filename, "") == 0)
> >  		sprintf(param->filename, "stdio");
> > @@ -143,54 +168,64 @@ static int cat_test(struct resctrl_val_param *param, size_t span)
> >  	if (ret)
> >  		return ret;
> >  
> > +	buf = alloc_buffer(span, 1);
> > +	if (buf == NULL)
> > +		return -1;
> > +
> >  	perf_event_attr_initialize(&pea, PERF_COUNT_HW_CACHE_MISSES);
> >  	perf_event_initialize_read_format(&pe_read);
> >  
> > -	/* Test runs until the callback setup() tells the test to stop. */
> > -	while (1) {
> > -		ret = param->setup(param);
> > -		if (ret == END_OF_TESTS) {
> > -			ret = 0;
> > -			break;
> > -		}
> > -		if (ret < 0)
> > -			break;
> > -		pe_fd = perf_event_reset_enable(&pea, bm_pid, param->cpu_no);
> > -		if (pe_fd < 0) {
> > -			ret = -1;
> > -			break;
> > -		}
> > +	while (current_mask) {
> > +		snprintf(schemata, sizeof(schemata), "%lx", param->mask & ~current_mask);
> > +		ret = write_schemata("", schemata, param->cpu_no, param->resctrl_val);
> > +		if (ret)
> > +			goto free_buf;
> > +		snprintf(schemata, sizeof(schemata), "%lx", current_mask);
> > +		ret = write_schemata(param->ctrlgrp, schemata, param->cpu_no, param->resctrl_val);
> > +		if (ret)
> > +			goto free_buf;
> > +
> > +		for (i = 0; i < NUM_OF_RUNS; i++) {
> > +			mem_flush(buf, span);
> > +			ret = fill_cache_read(buf, span, true);
> > +			if (ret)
> > +				goto free_buf;
> > +
> > +			pe_fd = perf_event_reset_enable(&pea, bm_pid, param->cpu_no);
> > +			if (pe_fd < 0) {
> > +				ret = -1;
> > +				goto free_buf;
> > +			}
> 
> It seems to me that the perf counters are reconfigured at every iteration.
> Can it not just be configured once and then the counters just reset and
> enabled at each iteration? I'd expect this additional work to impact
> values measured.

So you suggest I undo one of the changes made in 10/24 and just call the 
function which does only the ioctl() calls? I don't know why it has been 
done the way it has been, I can try to change it and see what happens.


-- 
 i.

--8323329-1041348085-1699009049=:1725--
