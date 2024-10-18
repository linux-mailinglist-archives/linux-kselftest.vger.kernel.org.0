Return-Path: <linux-kselftest+bounces-20116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C18279A3903
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 10:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3627FB211B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 08:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D53C18EFF9;
	Fri, 18 Oct 2024 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="imkgZeYh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9622A18E02A;
	Fri, 18 Oct 2024 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729241206; cv=none; b=UG8fE8mUJ8luqMCvYmk4Sh9fvUW/a88e72XH0oBGW1cC+sMw/POtI//k5Jf+s5WMbsXjEE0HYKYMzCI8EPVIQmIM0ZIeVTUQ/GL5TKDjoY1dOsJeDQoCGcRo5i4xGhDpltQInTckW2vq6mA0QJDKlWYH2/Yk4wgN1+keV5BrQSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729241206; c=relaxed/simple;
	bh=BmG3pmF+wqE21ChhB3j93ImO3VVkibr0t+QlXetDkQg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IOWRrmvpXWuYcRcFkiBs2GB78OeY+wyVAZrGEMdXo3gQl0IFM5PW1LGXlzgYqvx9+msmpNZR0D3Y751E+CnZUCUPe8wiPrzehL7VZhoIBkUSnQTq+rY29olnV7Rv4C7kQj2iRxyTV+b3UrTeQ0jLrCt3znj7PpLV96/L/+owi3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=imkgZeYh; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729241204; x=1760777204;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BmG3pmF+wqE21ChhB3j93ImO3VVkibr0t+QlXetDkQg=;
  b=imkgZeYhiWIo+dNh0PywJeew4HnLrtkK+DakEGaVekeAfBYKQFKtkXhT
   ZNUG4cCiHrHBESMCGOPX7odBbzc1KowoKUI4P0sQN+ZOl+4mv5yDoRk1I
   jIm+zvXgM3TfefluaqPDaQ1A2HN1NuAnkDbdqIeacUyXP4XNfVQYRY19B
   loB2vLx/xR37CWJcxMoc/85Uk+bHDO1em3pApMnntJHY6O/idW5DXYgui
   RHpGAyI5K912NUsf47Q/sXqbxfJxI2Ch+k1JfCxKaIGyigoHahxOhJ74i
   EPQkXt7gcxy5IvtdyP6FyvFrR4O+hZ3EPSdWNJCH2rBPdXqs3TtyeGoEc
   g==;
X-CSE-ConnectionGUID: K666Z4MiS1yY7hX09qTIRA==
X-CSE-MsgGUID: xFaGO5QtS4W6Z1ISUDCSSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="16380138"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="16380138"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 01:46:43 -0700
X-CSE-ConnectionGUID: IrccAmt4S++RH26u/lFQUw==
X-CSE-MsgGUID: IMCEz9l0SOqvSvg6xwrkWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="109617903"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 01:46:41 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 18 Oct 2024 11:46:37 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 02/15] selftests/resctrl: Print accurate buffer size
 as part of MBM results
In-Reply-To: <f7c200b42bf514e587e88e5be6e866fa797eed66.1729218182.git.reinette.chatre@intel.com>
Message-ID: <68a7ff59-289c-1d50-d454-ab2fcf6baf22@linux.intel.com>
References: <cover.1729218182.git.reinette.chatre@intel.com> <f7c200b42bf514e587e88e5be6e866fa797eed66.1729218182.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 17 Oct 2024, Reinette Chatre wrote:

> By default the MBM test uses the "fill_buf" benchmark to keep reading
> from a buffer with size DEFAULT_SPAN while measuring memory bandwidth.
> User space can provide an alternate benchmark or amend the size of
> the buffer "fill_buf" should use.
> 
> Analysis of the MBM measurements do not require that a buffer be used
> and thus do not require knowing the size of the buffer if it was used
> during testing. Even so, the buffer size is printed as informational
> as part of the MBM test results. What is printed as buffer size is
> hardcoded as DEFAULT_SPAN, even if the test relied on another benchmark
> (that may or may not use a buffer) or if user space amended the buffer
> size.
> 
> Ensure that accurate buffer size is printed when using "fill_buf"
> benchmark and omit the buffer size information if another benchmark
> is used.
> 
> Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Backporting is not recommended. Backporting this fix will be
> a challenge with all the refactoring done since then. This issue
> does not impact default tests and there is no sign that
> folks run these tests with anything but the defaults. This issue is
> also minor since it does not impact actual test runs or results,
> just the information printed during a test run.
> 
> Changes since V2:
> - Make user input checks more robust. (Ilpo)
> 
> Changes since V1:
> - New patch.
> ---
>  tools/testing/selftests/resctrl/mbm_test.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index 6b5a3b52d861..36ae29a03784 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -40,7 +40,8 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
>  	ksft_print_msg("%s Check MBM diff within %d%%\n",
>  		       ret ? "Fail:" : "Pass:", MAX_DIFF_PERCENT);
>  	ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
> -	ksft_print_msg("Span (MB): %zu\n", span / MB);
> +	if (span)
> +		ksft_print_msg("Span (MB): %zu\n", span / MB);
>  	ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
>  	ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
>  
> @@ -138,15 +139,26 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
>  		.setup		= mbm_setup,
>  		.measure	= mbm_measure,
>  	};
> +	char *endptr = NULL;
> +	size_t span = 0;
>  	int ret;
>  
>  	remove(RESULT_FILE_NAME);
>  
> +	if (uparams->benchmark_cmd[0] && strcmp(uparams->benchmark_cmd[0], "fill_buf") == 0) {
> +		if (uparams->benchmark_cmd[1]) {
> +			errno = 0;
> +			span = strtoul(uparams->benchmark_cmd[1], &endptr, 10);
> +			if (errno || *endptr != '\0')

This no longer catches "" string as error. I tested strtoul() with an 
empty string and errno remains at 0.

> +				return -errno;

Another issue is that in cases where errno=0 (both *endptr != '\0' and 
endptr == uparams->benchmark_cmd[1]), this function doesn't return 
a proper error code but -0.

-- 
 i.

> +		}
> +	}
> +
>  	ret = resctrl_val(test, uparams, uparams->benchmark_cmd, &param);
>  	if (ret)
>  		return ret;
>  
> -	ret = check_results(DEFAULT_SPAN);
> +	ret = check_results(span);
>  	if (ret && (get_vendor() == ARCH_INTEL))
>  		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
>  
> 


