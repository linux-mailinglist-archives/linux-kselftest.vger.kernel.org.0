Return-Path: <linux-kselftest+bounces-9349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B55E8BA839
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 10:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5AD1C21858
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 08:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9645A1482EC;
	Fri,  3 May 2024 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T9uBq+cA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CEC1482F8;
	Fri,  3 May 2024 08:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723266; cv=none; b=F9YAEtFTf8ZLS7rwa7WXkkYFx3HvhqjLwXt/KQ3Nl0/L0T++nlzjsJudncj5zJHw+yo1jcea5PqCQ/0Dmd5zHJB9Nq6NCLtuVyxfNFPHKCNwQ2I6Fzyc4kSX3y/9TQ9PfnZ7irenCzW6m4QWQKaZc5gJl+wvjBYt36wff5Q9cts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723266; c=relaxed/simple;
	bh=TO5f2lnqO/3Ie6pc6C92Bo2q513ZSZunZDH/5RorKxg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VSEuxDacETjW+3lQb0QUgXCZzIBRpfeA7oPuoMq5Eh3dZouubfCeYPyNJ4EqZjuu2qmqd0tRUhJKaXb3R5bTAv7R5QFry89lYAoq4U2Yry3aFyvVVNlvqmSS1F71wov3XEJZoc7EzCjfWxlgJifZ8IRrqeYob0oTTNIY6lY5yac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T9uBq+cA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714723264; x=1746259264;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TO5f2lnqO/3Ie6pc6C92Bo2q513ZSZunZDH/5RorKxg=;
  b=T9uBq+cA1rmui9crWZLCsB78fVR+z6RqriXCltdSxmWwi+IEOEgzNRon
   mWTNQ6f8+gMM97pufe5VPYb2+4DnITym7qbwCdyDpwl8+0Wf/RXtDZpqJ
   YBw+FV3ndg3EMlshph/yymla31AFGlBe9P3o8ApiMZC1YbaoGMFtgW6n4
   7kC5jMgrWPki9oEjqJzRztEghIgjpvs3ONVDNtwcGLFyVoVnTKptrrbx8
   i9QUFlExw6u0QGgoBqZzwlgPDkzv0HC/z5iL5ADQSrrysxLKNeEYPqBGs
   y/2HeSrvrQ8+5j/K6eBdgzhaS54wdTP0SiS8yjioMElzhFzEQoT9JZ9nw
   g==;
X-CSE-ConnectionGUID: Sylcqrs4QdGf8KqCl/BMAQ==
X-CSE-MsgGUID: 2j1DXgU9ThWpMzd/aHQveA==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10683629"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10683629"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 01:01:04 -0700
X-CSE-ConnectionGUID: IwrodcDXRfODX6qLeczlWw==
X-CSE-MsgGUID: z+a5zPNGTtSwGUSowE6FSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="64836547"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.56])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 01:01:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 3 May 2024 11:00:53 +0300 (EEST)
To: John Hubbard <jhubbard@nvidia.com>
cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
    Nick Desaulniers <ndesaulniers@google.com>, 
    Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
    Fenghua Yu <fenghua.yu@intel.com>, 
    Reinette Chatre <reinette.chatre@intel.com>, 
    Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] selftests/resctrl: fix clang build warnings related to
 abs(), labs() calls
In-Reply-To: <20240503023209.80787-1-jhubbard@nvidia.com>
Message-ID: <793bd068-c3b4-6330-41a4-bea597b1d820@linux.intel.com>
References: <20240503023209.80787-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 2 May 2024, John Hubbard wrote:

> First of all, in order to build with clang at all, one must first apply
> Valentin Obst's build fix for LLVM [1]. Furthermore, for this particular
> resctrl directory, my pending fix [2] must also be applied. Once those
> fixes are in place, then when building with clang, via:
> 
>     make LLVM=1 -C tools/testing/selftests
> 
> ..two types of warnings occur:
> 
>     warning: absolute value function 'abs' given an argument of type
>     'long' but has parameter of type 'int' which may cause truncation of
>     value
> 
>     warning: taking the absolute value of unsigned type 'unsigned long'
>     has no effect
> 
> Fix these by:
> 
> a) using labs() in place of abs(), when long integers are involved, and
> 
> b) don't call labs() unnecessarily.
> 
> [1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/
> [2] https://lore.kernel.org/all/20240503021712.78601-1-jhubbard@nvidia.com/
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  tools/testing/selftests/resctrl/cmt_test.c | 4 ++--
>  tools/testing/selftests/resctrl/mba_test.c | 2 +-
>  tools/testing/selftests/resctrl/mbm_test.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index a81f91222a89..05a241519ae8 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -40,11 +40,11 @@ static int show_results_info(unsigned long sum_llc_val, int no_of_bits,
>  	int ret;
>  
>  	avg_llc_val = sum_llc_val / num_of_runs;
> -	avg_diff = (long)abs(cache_span - avg_llc_val);
> +	avg_diff = (long)(cache_span - avg_llc_val);
>  	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
>  
>  	ret = platform && abs((int)diff_percent) > max_diff_percent &&
> -	      abs(avg_diff) > max_diff;
> +	      labs(avg_diff) > max_diff;
>  
>  	ksft_print_msg("%s Check cache miss rate within %lu%%\n",
>  		       ret ? "Fail:" : "Pass:", max_diff_percent);

This seems fine but...

> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> index 7946e32e85c8..673b2bb800f7 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -77,7 +77,7 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
>  
>  		avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
>  		avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
> -		avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
> +		avg_diff = (float)(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
>  		avg_diff_per = (int)(avg_diff * 100);
>  
>  		ksft_print_msg("%s Check MBA diff within %d%% for schemata %u\n",
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index d67ffa3ec63a..c873793d016d 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -33,7 +33,7 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
>  
>  	avg_bw_imc = sum_bw_imc / 4;
>  	avg_bw_resc = sum_bw_resc / 4;
> -	avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
> +	avg_diff = (float)(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
>  	avg_diff_per = (int)(avg_diff * 100);
>  
>  	ret = avg_diff_per > MAX_DIFF_PERCENT;

But how are these two cases same after your change when you ended up 
removing taking the absolute value entirely?


-- 
 i.


