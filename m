Return-Path: <linux-kselftest+bounces-16783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2E39660B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 13:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8329628B249
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 11:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8018119993C;
	Fri, 30 Aug 2024 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IlV/X3m9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C4917ADF8;
	Fri, 30 Aug 2024 11:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017137; cv=none; b=k3WRlQoLvKAZdKCs0li/6/zLZTpH/dkvWRJjGCAdxoW7Wu4BiVY0N+MRvEVZ7ZLBcwjkbDyt4hTAoER+uCHXo8SkPRmcWKzp5xhsiKL34BiatOpKz6Hv0lpNEH7USzrM08r8hj8hWWN8kPFiIHmSHLdxJ/FHmeRCq+mwXiyabkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017137; c=relaxed/simple;
	bh=DpoKNE8VO9z3KhuMFEl5oMMY/HQ8tx2ppppVBEBswnQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=C3woPTSkZR47EbUetnQumtglrvGpD7H45F57M/d4IX5HG44JpWt00B+vgYwPLcWn+0G5jIt1HgGxhPs9EhwlH4rgx8VCUNxaqpHR5Uxu3vDxeyNFk0IED8pgk1Q1uhlRdMRTnjteBwC7e6zIfD7W6/qGR6nSwHH1iAm3MaCnB/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IlV/X3m9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725017136; x=1756553136;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DpoKNE8VO9z3KhuMFEl5oMMY/HQ8tx2ppppVBEBswnQ=;
  b=IlV/X3m93kbL8HgKlbrd/RuVW64QbrN9QwzwrbiOndRbZ8/1iAKkuaWQ
   8JCEBY8JeehFin7Ow2ieFzBbYdr2W7eW6lC4Lz+5P1tYuwq2o5MSvGAfs
   VN7OWZaR4G48as9CWCBPKAHcQcgy17xgSBUDIQo44/pfk0rBMUY0nTXk8
   h1Z0OnI2O47rjFDynK79uYQ6Tf6hRd4Q6UC6s6Ikmds8VgGsZ2FO+hymg
   kVVAWfb3xjLXHmeDk+ERgBus5G+7JZZdkhWQTYvNmP8Beo5u63/VEvPQW
   fWHg2X5WMSjaXaE+MHOhpXSdA1coyUx7EcMioUrb3WqgQN3bycmnjkxSZ
   w==;
X-CSE-ConnectionGUID: VdLI0o7ESNGV0r8KYIPLaw==
X-CSE-MsgGUID: ka3ES/ZxRbOWBp9zbIkGOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34320751"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="34320751"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 04:25:35 -0700
X-CSE-ConnectionGUID: dOcyybsVRTSXe3PofZBwKw==
X-CSE-MsgGUID: w6ByEIrZS4K3O5JhKGYiAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="64620172"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.174])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 04:25:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 30 Aug 2024 14:25:25 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] selftests/resctrl: Use cache size to determine
 "fill_buf" buffer size
In-Reply-To: <d357189fe0695b2140fc03efde75edc6fa0c88c6.1724970211.git.reinette.chatre@intel.com>
Message-ID: <4434b263-9049-3d44-6b41-a840b39205cd@linux.intel.com>
References: <cover.1724970211.git.reinette.chatre@intel.com> <d357189fe0695b2140fc03efde75edc6fa0c88c6.1724970211.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 29 Aug 2024, Reinette Chatre wrote:

> By default the MBM and MBA tests use the "fill_buf" benchmark to
> read from a buffer with the goal to measure the memory bandwidth
> generated by this buffer access.
> 
> Care should be taken when sizing the buffer used by the "fill_buf"
> benchmark. If the buffer is small enough to fit in the cache then
> it cannot be expected that the benchmark will generate much memory
> bandwidth. For example, on a system with 320MB L3 cache the existing
> hardcoded default of 250MB is insufficient.
> 
> Use the measured cache size to determine a buffer size that can be
> expected to trigger memory access while keeping the existing default
> as minimum that has been appropriate for testing so far.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  tools/testing/selftests/resctrl/mba_test.c | 8 +++++++-
>  tools/testing/selftests/resctrl/mbm_test.c | 8 +++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> index 8ad433495f61..cad473b81a64 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -170,11 +170,17 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
>  		.setup		= mba_setup,
>  		.measure	= mba_measure,
>  	};
> +	unsigned long cache_total_size = 0;
>  	int ret;
>  
>  	remove(RESULT_FILE_NAME);
>  
> -	param.fill_buf.buf_size = DEFAULT_SPAN;
> +	ret = get_cache_size(uparams->cpu, "L3", &cache_total_size);
> +	if (ret)
> +		return ret;
> +
> +	param.fill_buf.buf_size = cache_total_size > DEFAULT_SPAN ?
> +				  cache_total_size * 2 : DEFAULT_SPAN;

Should the check leave a bit of safeguard so that the buf_size is at 
least 2x (or x1.25 or some other factor)?

In here buf_size immediate jumps from 1x -> 2x when cache_total_size goes 
from DEFAULT_SPAN to DEFAULT_SPAN+1 (obviously L3 size won't be odd like 
that but I think you get my point).

Also, user might want to override this as mentioned in my reply to the 
previous patch.

-- 
 i.

>  	param.fill_buf.memflush = 1;
>  	param.fill_buf.operation = 0;
>  	param.fill_buf.once = false;
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index b6883f274c74..734bfa4f42b3 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -138,11 +138,17 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
>  		.setup		= mbm_setup,
>  		.measure	= mbm_measure,
>  	};
> +	unsigned long cache_total_size = 0;
>  	int ret;
>  
>  	remove(RESULT_FILE_NAME);
>  
> -	param.fill_buf.buf_size = DEFAULT_SPAN;
> +	ret = get_cache_size(uparams->cpu, "L3", &cache_total_size);
> +	if (ret)
> +		return ret;
> +
> +	param.fill_buf.buf_size = cache_total_size > DEFAULT_SPAN ?
> +				  cache_total_size * 2 : DEFAULT_SPAN;
>  	param.fill_buf.memflush = 1;
>  	param.fill_buf.operation = 0;
>  	param.fill_buf.once = false;
> 


