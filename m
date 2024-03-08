Return-Path: <linux-kselftest+bounces-6107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 222C28765AB
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 14:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C75A1C214B5
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 13:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAAB3BBE0;
	Fri,  8 Mar 2024 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="abQY7zjk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71E038DF9;
	Fri,  8 Mar 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906009; cv=none; b=ufCoFWWe9pnq3lAwv/C0Nampc0r+ctQGorWE2J/Aux9Zt11j9amKP3U8PfODNBrolc6sk3pV8M9Wq9mqRdQuKJlA5dE744HQYpXsKc6whWNKRzVy7B4QuM9vbZ3i+yo+zRJmX8EIF8ayahO1rTZAlLD3SZZ27c5L2NRD5CoPbuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906009; c=relaxed/simple;
	bh=NITzIM94nELtuCjZkBEgy9jlRwa/xY4KvHM838qFBec=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BYrsyZvVsSC5mFOg2/iT47koZ/sXyv+2GImF6zenUvnT45y2orNHcMdFbBOeGWngqBdAFw9Qt4DR9vMeCyCo+sw7MeSCJWAM3IKT6SJZ9vx0wfHCbsatQ9fnqUlebsmwC1/3X3gisNU9O2BK2FRrRRA6m9QNBl11EMGasB6qVtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=abQY7zjk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709906008; x=1741442008;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NITzIM94nELtuCjZkBEgy9jlRwa/xY4KvHM838qFBec=;
  b=abQY7zjkzSJAJHTQ2jyk4Fx8dk5ia6mwX8PDFsMocjCLDwQ0BjdEDCGL
   4zMpgpw57yfo0q5vDDOJg9mAqNJhuY2ZY7x0A3SNKhf8TL0JiMzn/tVmW
   ARua/F/+QJAuaKps5iWOHuRrRDwFhTXbOcJBynocAbDYnuIjQuwg54s/s
   Nnk668oEK7dyzHOswsLDILRep005a95fnPSob+vHBRpPJ94PfwNLV4hW+
   hBIfCXk3HUcdPESKeDMELc0cKfrLaWpKaTfksokb9CrDBB1KfJDQ1/NE/
   SBf4t+wrMYlSwhTytkJXj5P9vlHXs087otb1c210fiVzDp7hT2no7SwUY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4469818"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4469818"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:53:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="41444446"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:53:24 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 8 Mar 2024 15:53:19 +0200 (EET)
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc: Fenghua Yu <fenghua.yu@intel.com>, 
    Reinette Chatre <reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>, 
    tony.luck@intel.com, "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>, 
    LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] selftests/resctrl: SNC support for CMT
In-Reply-To: <75849cb145429798b21c23b6be4abd7ece9df57b.1709721159.git.maciej.wieczor-retman@intel.com>
Message-ID: <6181937a-54b4-8b17-0c24-734764a205d1@linux.intel.com>
References: <cover.1709721159.git.maciej.wieczor-retman@intel.com> <75849cb145429798b21c23b6be4abd7ece9df57b.1709721159.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 6 Mar 2024, Maciej Wieczor-Retman wrote:

> Cache Monitoring Technology (CMT) works by measuring how much data in L3
> cache is occupied by a given process identified by its Resource
> Monitoring ID (RMID).
> 
> On systems with Sub-Numa Clusters (SNC) enabled, a process can occupy
> not only the cache that belongs to its own NUMA node but also pieces of
> other NUMA nodes' caches that lie on the same socket.
> 
> A simple correction to make the CMT selftest NUMA-aware is to sum values
> reported by all nodes on the same socket for a given RMID.
> 
> Reported-by: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
> Closes: https://lore.kernel.org/all/TYAPR01MB6330B9B17686EF426D2C3F308B25A@TYAPR01MB6330.jpnprd01.prod.outlook.com/
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
>  tools/testing/selftests/resctrl/cache.c       | 17 +++++++++++------
>  tools/testing/selftests/resctrl/resctrl.h     |  4 +++-
>  tools/testing/selftests/resctrl/resctrl_val.c |  9 ++++++---
>  3 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> index 1b339d6bbff1..dab81920033b 100644
> --- a/tools/testing/selftests/resctrl/cache.c
> +++ b/tools/testing/selftests/resctrl/cache.c
> @@ -161,16 +161,21 @@ int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
>   *
>   * Return: =0 on success. <0 on failure.
>   */
> -int measure_llc_resctrl(const char *filename, int bm_pid)
> +int measure_llc_resctrl(const char *filename, int bm_pid, const char *ctrlgrp,
> +			const char *mongrp, int res_id)
>  {
> -	unsigned long llc_occu_resc = 0;
> +	unsigned long sum = 0, llc_occu_resc = 0;
>  	int ret;
>  
> -	ret = get_llc_occu_resctrl(&llc_occu_resc);
> -	if (ret < 0)
> -		return ret;
> +	for (int i = 0 ; i < snc_ways() ; i++) {

Spaces as per usual coding style:

	for (int i = 0; i < snc_ways(); i++) {

> +		set_cmt_path(ctrlgrp, mongrp, res_id + i);
> +		ret = get_llc_occu_resctrl(&llc_occu_resc);
> +		if (ret < 0)
> +			return ret;
> +		sum += llc_occu_resc;
> +	}
>  
> -	return print_results_cache(filename, bm_pid, llc_occu_resc);
> +	return print_results_cache(filename, bm_pid, sum);
>  }
>  
>  /*

> @@ -828,6 +828,8 @@ int resctrl_val(const struct resctrl_test *test,
>  	sleep(1);
>  
>  	/* Test runs until the callback setup() tells the test to stop. */
> +	get_domain_id("L3", uparams->cpu, &res_id);

Hardcoding L3 here limits the genericness of this function. You don't even 
need to do it, get_domain_id() does "MB" -> "L3" transformation implicitly 
for you so you can just pass test->resource instead.

Also, I don't understand why you now again make the naming inconsistent 
with "res_id".

If you based this on top of the patches I just posted, resctl_val() 
already the domain_id variable.

-- 
 i.

> +	res_id *= snc_ways();
>  	while (1) {
>  		ret = param->setup(test, uparams, param);
>  		if (ret == END_OF_TESTS) {
> @@ -844,7 +846,8 @@ int resctrl_val(const struct resctrl_test *test,
>  				break;
>  		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
>  			sleep(1);
> -			ret = measure_llc_resctrl(param->filename, bm_pid);
> +			ret = measure_llc_resctrl(param->filename, bm_pid, param->ctrlgrp,
> +						  param->mongrp, res_id);
>  			if (ret)
>  				break;
>  		}
> 


