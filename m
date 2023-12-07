Return-Path: <linux-kselftest+bounces-1358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6497C808AA4
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 15:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5F0281660
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 14:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D6D3D0D1;
	Thu,  7 Dec 2023 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vqro6IAH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5034F121;
	Thu,  7 Dec 2023 06:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701959537; x=1733495537;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IMMsqc0K2X/JwCbUNgUXoJZ7VcmenzGdCa/931H1GNA=;
  b=Vqro6IAHJ3j3wBBAfOwhxnjdwz3GyJquzm1k9f9TIhdsqBDOh5yb4UQi
   qMqyT9aqwgLm5Mo8n0HX/ypS9o1oy36YmOZYrSWwwbAPk3TNmGiruDzJP
   UKEmyZbIDHXWjX/m6MIgLhxHNDsIiwMjO9mvPHEISVzyQTAh80LMqN4+g
   NYwHTlbc+2+Zg2hjgZJfDfUcMXDY7MHvB1kjzw59thGHxjux7oyMU8r19
   6AfTn2QkIBy5M6so8mQ6inhWO9KJ6fUugOhs2bNF501YB86TBMuOoIXOj
   qpu9oVHjXq3aaZTCDQsc5x7scrIcuDT+eQudUKowoDkM+bV3t0YwhrstX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="397029637"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="397029637"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 06:32:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="19727735"
Received: from dkrupnov-mobl3.ger.corp.intel.com ([10.249.34.6])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 06:32:15 -0800
Date: Thu, 7 Dec 2023 16:32:12 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
    Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    Fenghua Yu <fenghua.yu@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/26] selftests/resctrl: Split measure_cache_vals()
In-Reply-To: <c303ba1b-d7bd-47cf-9e81-8ea0c60b973c@intel.com>
Message-ID: <e87d8ba-141a-5779-fc6-27e4735fc1bf@linux.intel.com>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com> <20231120111340.7805-9-ilpo.jarvinen@linux.intel.com> <c303ba1b-d7bd-47cf-9e81-8ea0c60b973c@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-683619166-1701959536=:1765"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-683619166-1701959536=:1765
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 28 Nov 2023, Reinette Chatre wrote:

> Hi Ilpo,
> 
> On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> > measure_cache_vals() does a different thing depending on the test case
> > that called it:
> >   - For CAT, it measures LLC misses through perf.
> >   - For CMT, it measures LLC occupancy through resctrl.
> > 
> > Split these two functionalities into own functions the CAT and CMT
> > tests can call directly. Replace passing the struct resctrl_val_param
> > parameter with the filename because it's more generic and all those
> > functions need out of resctrl_val.
> > 
> > Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  tools/testing/selftests/resctrl/cache.c       | 66 ++++++++++++-------
> >  tools/testing/selftests/resctrl/resctrl.h     |  2 +-
> >  tools/testing/selftests/resctrl/resctrl_val.c |  2 +-
> >  3 files changed, 43 insertions(+), 27 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> > index 8aa6d67db978..129d1c293518 100644
> > --- a/tools/testing/selftests/resctrl/cache.c
> > +++ b/tools/testing/selftests/resctrl/cache.c
> > @@ -147,7 +147,7 @@ static int get_llc_occu_resctrl(unsigned long *llc_occupancy)
> >   *
> >   * Return:		0 on success. non-zero on failure.
> >   */
> > -static int print_results_cache(char *filename, int bm_pid,
> > +static int print_results_cache(const char *filename, int bm_pid,
> >  			       unsigned long llc_value)
> >  {
> >  	FILE *fp;
> > @@ -169,35 +169,51 @@ static int print_results_cache(char *filename, int bm_pid,
> >  	return 0;
> >  }
> >  
> > -int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
> > +/*
> > + * perf_event_measure - Measure perf events
> > + * @filename:	Filename for writing the results
> > + * @bm_pid:	PID that runs the benchmark
> > + *
> > + * Measures perf events (e.g., cache misses) and writes the results into
> > + * @filename. @bm_pid is written to the results file along with the measured
> > + * value.
> > + *
> > + * Return: =0 on success. <0 on failure.
> 
> I do not think this is accurate. It looks like this function returns
> the return value of print_results_cache() which returns errno on failure.
> If this is the case then I think this proves that returning a
> positive integer on failure should be avoided since it just creates
> traps.
>
> > + */
> > +static int perf_event_measure(const char *filename, int bm_pid)
> >  {
> > -	unsigned long llc_perf_miss = 0, llc_occu_resc = 0, llc_value = 0;
> > +	unsigned long llc_perf_miss = 0;
> >  	int ret;
> >  
> > -	/*
> > -	 * Measure cache miss from perf.
> > -	 */
> > -	if (!strncmp(param->resctrl_val, CAT_STR, sizeof(CAT_STR))) {
> > -		ret = get_llc_perf(&llc_perf_miss);
> > -		if (ret < 0)
> > -			return ret;
> > -		llc_value = llc_perf_miss;
> > -	}
> > +	ret = get_llc_perf(&llc_perf_miss);
> > +	if (ret < 0)
> > +		return ret;
> >  
> > -	/*
> > -	 * Measure llc occupancy from resctrl.
> > -	 */
> > -	if (!strncmp(param->resctrl_val, CMT_STR, sizeof(CMT_STR))) {
> > -		ret = get_llc_occu_resctrl(&llc_occu_resc);
> > -		if (ret < 0)
> > -			return ret;
> > -		llc_value = llc_occu_resc;
> > -	}
> > -	ret = print_results_cache(param->filename, bm_pid, llc_value);
> > -	if (ret)
> > +	ret = print_results_cache(filename, bm_pid, llc_perf_miss);
> > +	return ret;
> > +}
> 
> Perhaps print_results_cache() can be made to return negative error
> and this just be "return print_results_cache(...)" and the function
> comment be accurate?

I think, I'll just change all "return errno;" to "return -1" before this,
however, one open question which impacts whether this is actually Fixes 
class issue:

It seems that perror()'s manpage doesn't answer one important question, 
whether it ifself can alter errno or not. The resctrl selftest code 
assumes it doesn't but some evidence I came across says otherwise so doing 
return errno; after calling perror() might not even be valid at all.

So I'm tempted to create an additional Fixes patch about the return change 
into the front of the series.

-- 
 i.

--8323329-683619166-1701959536=:1765--

