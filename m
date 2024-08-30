Return-Path: <linux-kselftest+bounces-16786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E849660EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 13:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172102860F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 11:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBF018F2D5;
	Fri, 30 Aug 2024 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DMq02goD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4877017DFF3;
	Fri, 30 Aug 2024 11:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725018173; cv=none; b=Cwoh29jhkc6XE7cznvonFiyF6aY/4ytjurgI7Xl4GMlrYM1qY3mv8Cm0XDBdDm0JmLu8TxbqKY6J6f5etnBJ7PYxIQkVARjR1FHdHkdHlmb6BUDV/2e/MqXyhPigmeWfomDJwuzlOGfgbnJBmBHL9CrcALQUjlYVPyy+k286Ids=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725018173; c=relaxed/simple;
	bh=WuIYl4IzzUEhJPThW6Rr8DirCEnERH0u/EAC7WXNeco=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=j/iY1TczFGr88vN28H/amSmxjZX6YZ5JAYG6H14NFZzowr1vQujuSIbjYyukl2g+PtIuCALKJoseKSFWA3MhbsbTiCMM48XARA/EIfgk6/nXy8dQOiOx4vgPwAAyoAwcAy3iDOw07T/bo9MzMqB8rAPr6GXLS41THPzpAUpJIUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DMq02goD; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725018171; x=1756554171;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WuIYl4IzzUEhJPThW6Rr8DirCEnERH0u/EAC7WXNeco=;
  b=DMq02goD7wMMriwKVU508C1O+b0D6WUcLguKQB5qR9J7o+eDCz2Gnamn
   asCRB1jdcXiaMbQKVU2N25ooxHXg2pf7tgO2VQSHw/6T/pRD5SsQJt0BF
   0LXntHLU+DcRW1bB7+xPwoUATy+n7lGnTYr9viI0HZKeMGG8P0EiWcnnr
   opvHe0bgYU1QzLCR0lNEKLwibwvUPTnIA2V9ws3rfe0mUKPFEXXAQjkfK
   pDIwKqZzhnyc0/J28HguZh2x+U4ISz6u2M3yluA7sZNOGdF5Bov/HmvPV
   xk/tN4Sac9iQHOIhzFJJM6keW4x+8oj5vaCvBdIXGWLQbz7ki4jqdELv9
   g==;
X-CSE-ConnectionGUID: tL4b+EGdR26j1zq86OIzig==
X-CSE-MsgGUID: ++kbsh9tRm+vP8leJobRoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23537401"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="23537401"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 04:42:50 -0700
X-CSE-ConnectionGUID: ffPijyUzS5Crt6QMwc50GQ==
X-CSE-MsgGUID: q4x/+lz5RUafWhiGJ3YDBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="64061133"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.174])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 04:42:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 30 Aug 2024 14:42:43 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] selftests/resctrl: Do not compare performance counters
 and resctrl at low bandwidth
In-Reply-To: <9bbefa3b9a62319698907d10e8b78f1b999c311b.1724970211.git.reinette.chatre@intel.com>
Message-ID: <5d063290-9da4-c9ca-e5c5-cb0083d7483f@linux.intel.com>
References: <cover.1724970211.git.reinette.chatre@intel.com> <9bbefa3b9a62319698907d10e8b78f1b999c311b.1724970211.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 29 Aug 2024, Reinette Chatre wrote:

> The MBA test incrementally throttles memory bandwidth, each time
> followed by a comparison between the memory bandwidth observed
> by the performance counters and resctrl respectively.
> 
> While a comparison between performance counters and resctrl is
> generally appropriate, they do not have an identical view of
> memory bandwidth. For example RAS features or memory performance
> features that generate memory traffic may drive accesses that are
> counted differently by performance counters and MBM respectively,
> for instance generating "overhead" traffic which is not counted
> against any specific RMID. As a ratio, this different view of memory
> bandwidth becomes more apparent at low memory bandwidths.

Interesting.

I did some time back prototype with a change to MBM test such that instead 
of using once=false I changed fill_buf to be able to run N passes through 
the buffer which allowed me to know how many reads were performed by the 
benchmark. This yielded numerical difference between all those 3 values
(# of reads, MBM, perf) which also varied from arch to another so it 
didn't end up making an usable test.

I guess I now have an explanation for at least a part of the differences.

> It is not practical to enable/disable the various features that
> may generate memory bandwidth to give performance counters and
> resctrl an identical view. Instead, do not compare performance
> counters and resctrl view of memory bandwidth when the memory
> bandwidth is low.
> 
> Bandwidth throttling behaves differently across platforms
> so it is not appropriate to drop measurement data simply based
> on the throttling level. Instead, use a threshold of 750MiB
> that has been observed to support adequate comparison between
> performance counters and resctrl.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  tools/testing/selftests/resctrl/mba_test.c | 7 +++++++
>  tools/testing/selftests/resctrl/resctrl.h  | 6 ++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> index cad473b81a64..204b9ac4b108 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -96,6 +96,13 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
>  
>  		avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
>  		avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
> +		if (avg_bw_imc < THROTTLE_THRESHOLD || avg_bw_resc < THROTTLE_THRESHOLD) {
> +			ksft_print_msg("Bandwidth below threshold (%d MiB).  Dropping results from MBA schemata %u.\n",
> +					THROTTLE_THRESHOLD,
> +					ALLOCATION_MAX - ALLOCATION_STEP * allocation);

The second one too should be %d.

-- 
 i.

> +			break;
> +		}
> +
>  		avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
>  		avg_diff_per = (int)(avg_diff * 100);
>  
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 0e5456165a6a..e65c5fb76b17 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -43,6 +43,12 @@
>  
>  #define DEFAULT_SPAN		(250 * MB)
>  
> +/*
> + * Memory bandwidth (in MiB) below which the bandwidth comparisons
> + * between iMC and resctrl are considered unreliable.
> + */
> +#define THROTTLE_THRESHOLD	750
> +
>  /*
>   * user_params:		User supplied parameters
>   * @cpu:		CPU number to which the benchmark will be bound to
> 


