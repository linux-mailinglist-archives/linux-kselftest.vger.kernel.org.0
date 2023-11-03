Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0C77E012E
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 11:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347309AbjKCJpo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 05:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347166AbjKCJpn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 05:45:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D009D42;
        Fri,  3 Nov 2023 02:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699004737; x=1730540737;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vlF3S9N1W0zguAYvyFDi0DyELIRHNl9kTQEQgEsQL0U=;
  b=Ck1FEVDCFy/FLPoyGhxsCa8vnETcp/6CZOWRpLCE2umvjTNs8sGvG2NP
   Iru2eeVso5lRC+0mmjuU5ccPTvEh/PhwXw9QlMe4VSyFK1TF4AAx0fqqm
   Hw6Kdl7xnda2nFFYkDznu6pgTjMyHPO50ArcjzhaQcKvuiDBmdNMbfuTc
   xg+IiQPfqK14hfDCX4M2iy9Hxtce/GrgUgQiKcR5PMkjo1a9QD50IAgEu
   ZauwusiD4mes7FmDpvQ3r59C149Bg62XHLFzhzChraVcd36wLhLkQgoRN
   ZUc/FBuRNFWpeUUwok1HFuNu97YxmakPhrdYLVwStbIk+u+h18FF8O52K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="373955879"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="373955879"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 02:45:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="790708773"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="790708773"
Received: from pors-mobl3.ger.corp.intel.com ([10.252.35.38])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 02:45:34 -0700
Date:   Fri, 3 Nov 2023 11:45:31 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/24] selftests/resctrl: Remove nested calls in perf
 event handling
In-Reply-To: <93113f94-9663-4cbb-962f-c415bc975f12@intel.com>
Message-ID: <aae1ad6f-4c31-7fb6-255d-7011fb67a784@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com> <20231024092634.7122-11-ilpo.jarvinen@linux.intel.com> <93113f94-9663-4cbb-962f-c415bc975f12@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-935771429-1699004736=:1725"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-935771429-1699004736=:1725
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 2 Nov 2023, Reinette Chatre wrote:

> Hi Ilpo,
> 
> On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
> > Perf event handling has functions that are the sole caller of another
> > perf event handling related function:
> >   - reset_enable_llc_perf() calls perf_event_open_llc_miss()
> >   - reset_enable_llc_perf() calls ioctl_perf_event_ioc_reset_enable()
> >   - measure_llc_perf() calls get_llc_perf()
> > 
> > Remove the extra layer of calls to make the code easier to follow by
> > moving the code into the calling function.
> > 
> > In addition, converts print_results_cache() unsigned long parameter to
> > __u64 that matches the type coming from perf.
> 
> Is this referring to work from previous patch?

Yes, this got split into own patch and it unfortunately lingered on in the 
changelog. I'll remove it.

> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> ---
> >
> >  1 file changed, 25 insertions(+), 61 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> > index d39ef4eebc37..208af1ecae28 100644
> > --- a/tools/testing/selftests/resctrl/cache.c
> > +++ b/tools/testing/selftests/resctrl/cache.c

> > -/*
> > - * get_llc_perf:	llc cache miss through perf events
> > - * @llc_perf_miss:	LLC miss counter that is filled on success
> > - *
> > - * Perf events like HW_CACHE_MISSES could be used to validate number of
> > - * cache lines allocated.
> > - *
> > - * Return: =0 on success.  <0 on failure.
> > - */
> > -static int get_llc_perf(__u64 *llc_perf_miss)
> > -{
> > -	int ret;
> > -
> > -	/* Stop counters after one span to get miss rate */
> > -
> > -	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
> > -
> > -	ret = read(fd_lm, &rf_cqm, sizeof(struct read_format));
> > -	if (ret == -1) {
> > -		perror("Could not get llc misses through perf");
> > +	fd_lm = perf_event_open(&pea_llc_miss, pid, cpu_no, -1, PERF_FLAG_FD_CLOEXEC);
> > +	if (fd_lm == -1) {
> > +		perror("Error opening leader");
> > +		ctrlc_handler(0, NULL, NULL);
> 
> I understand you just copied the code here ... but it is not clear to me
> why this particular error handling deserves a ctrlc_handler().

Good catch! It's first time I even notice this line.

It certainly looks a bit too big hammer for error handling. I'll try to 
create a separate patch which properly removes it (I suspect all error 
handling rollbacks are there already so it can just be removed but I'll 
have to confirm that).

> >  		return -1;
> >  	}
> >  
> > -	*llc_perf_miss = rf_cqm.values[0].value;
> > +	/* Start counters to log values */
> > +	ioctl(fd_lm, PERF_EVENT_IOC_RESET, 0);
> > +	ioctl(fd_lm, PERF_EVENT_IOC_ENABLE, 0);
> >  
> >  	return 0;
> >  }
> > @@ -166,20 +121,29 @@ static int print_results_cache(char *filename, int bm_pid, __u64 llc_value)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * measure_llc_perf:	measure perf events
> > + * @bm_pid:	child pid that runs benchmark
> 
> I expected "bm_pid" to reflect a "benchmark pid" that
> is not unique to the child. Are both parent and child
> not running the benchmark?
> 
> Missing doc of a parameter here.
> 
> > + *
> > + * Measure things like cache misses from perf events.
> 
> "things like cache misses" is vague. The function's name 
> still contains "llc" which makes me think it is not quite
> generic yet.

I suppose I tried to be intentionally vague because I knew I was going to 
use it measure also LLC accesses in the case of L2 CAT test. I'll see if I 
can improve this wording somehow.

> > + *
> > + * Return: =0 on success.  <0 on failure.
> > + */
> >  static int measure_llc_perf(struct resctrl_val_param *param, int bm_pid)
> >  {
> > -	__u64 llc_perf_miss = 0;
> >  	int ret;
> >  
> > -	/*
> > -	 * Measure cache miss from perf.
> > -	 */
> > -	ret = get_llc_perf(&llc_perf_miss);
> > -	if (ret < 0)
> > -		return ret;
> > +	/* Stop counters after one span to get miss rate */
> > +	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
> >  
> > -	ret = print_results_cache(param->filename, bm_pid, llc_perf_miss);
> > -	return ret;
> > +	ret = read(fd_lm, &rf_cqm, sizeof(struct read_format));
> > +	close(fd_lm);
> 
> I am not able to tell where this close() moved from.

Another good catch.

It seems to be a conflict resolution fallout from the time when I changed 
to close() logic in that fix patch related to this fd.

-- 
 i.

--8323329-935771429-1699004736=:1725--
