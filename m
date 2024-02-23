Return-Path: <linux-kselftest+bounces-5333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BC0860FDD
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 11:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8511F23B55
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 10:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15055D485;
	Fri, 23 Feb 2024 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5O3LPt5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF330241F9;
	Fri, 23 Feb 2024 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708685657; cv=none; b=CO7WahbtMJkohuvAR9NCl/lqXQcLJQEiHXXynQlPiG0syrpj6OWi4BnmcvHgzFkVDiA02suYRrZO+yp+cjuH2dveAwUe4NXgzLZwTRcxAnCuZUN8U3uCBiUe6fsnG0TpIk0PyOH5DLvwbd1lN9pbgy7IO24g5MYfQSH9dJiHhjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708685657; c=relaxed/simple;
	bh=fZ9iZdZn/vFcxForWOFbM8kbTQ/bl0dFvRnc9xIMSd8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TmjvoVa9BPQwHde1PO/M1zOSZdTfccHYdFbjLQNj5OC/wfIx86J5qDj5hcYFZKf/8+KbZ2m3PucJ0oF03W8WLT6UzzXOU/dH8lAFhGfWpjMGgoT5wOYLtOJYxLLBmGI564y+WwNlwZeXpI1YuPCrR0lnESXhsMk7w3e6P34SpzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U5O3LPt5; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708685656; x=1740221656;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fZ9iZdZn/vFcxForWOFbM8kbTQ/bl0dFvRnc9xIMSd8=;
  b=U5O3LPt5ywG+eADNL1rhltfwJ84iGzp04qbJVxG/VQXZbyvCWPHg14Ud
   xK2oSkgqoDo8MLPya3f9DO92Ve3+2JYhdfoyPPyq29/UoqV8cnvMwKNsQ
   EBdb+4MyeLnFReEASI6TwXb6NhmmgVrNJMoydS21hxUu0/5raab1HD8pu
   oZquS42JWShkWdhzFLcfx1PQKehw+nct88gakkNNKcyrB6uwdGVmqz4DS
   L5LUW2rks08pkhfCIkWGKUcGkYKFqlg5vH6aN1zrUhphQweNCZjbRnYsM
   vjnzLGfwrZ/8PtHGiAKck+Udc/zMlgMsCX9rYTiJ5ZbxBVzaHzGiFtcBT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3148650"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3148650"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 02:54:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10631455"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.107])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 02:54:12 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 23 Feb 2024 12:53:58 +0200 (EET)
To: Babu Moger <babu.moger@amd.com>
cc: fenghua.yu@intel.com, Reinette Chatre <reinette.chatre@intel.com>, 
    shuah@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-kselftest@vger.kernel.org, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    peternewman@google.com, eranian@google.com
Subject: Re: [PATCH 3/4] selftests/resctrl: Add support for MBM and MBA tests
 on AMD
In-Reply-To: <cc22790173de9978a6485baca5bc96a8ad8e05a4.1708637563.git.babu.moger@amd.com>
Message-ID: <6f611a0a-f2ef-1017-07c0-5d805abb80d4@linux.intel.com>
References: <cover.1708637563.git.babu.moger@amd.com> <cc22790173de9978a6485baca5bc96a8ad8e05a4.1708637563.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 22 Feb 2024, Babu Moger wrote:

> Add support to read UMC (Unified Memory Controller) perf events to compare
> the numbers with QoS monitor for AMD.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  .../testing/selftests/resctrl/resctrl_tests.c |  6 +-
>  tools/testing/selftests/resctrl/resctrl_val.c | 62 +++++++++++++++++--
>  2 files changed, 58 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 2bbe3045a018..231233b8d354 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -104,8 +104,7 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
>  	}
>  
>  	if (!validate_resctrl_feature_request("L3_MON", "mbm_total_bytes") ||
> -	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes") ||
> -	    (get_vendor() != ARCH_INTEL)) {
> +	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes")) {
>  		ksft_test_result_skip("Hardware does not support MBM or MBM is disabled\n");
>  		goto cleanup;
>  	}
> @@ -131,8 +130,7 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
>  	}
>  
>  	if (!validate_resctrl_feature_request("MB", NULL) ||
> -	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes") ||
> -	    (get_vendor() != ARCH_INTEL)) {
> +	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes")) {
>  		ksft_test_result_skip("Hardware does not support MBA or MBA is disabled\n");
>  		goto cleanup;
>  	}

These need to be rebased as this code moved into per test files with the 
generic test framework. The .vendor_specific field is the new way to make 
tests limited to particular vendors.

> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 792116d3565f..c5a4607aa9d9 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -11,6 +11,7 @@
>  #include "resctrl.h"
>  
>  #define UNCORE_IMC		"uncore_imc"
> +#define AMD_UMC			"amd_umc"
>  #define READ_FILE_NAME		"events/cas_count_read"
>  #define WRITE_FILE_NAME		"events/cas_count_write"
>  #define DYN_PMU_PATH		"/sys/bus/event_source/devices"
> @@ -146,6 +147,47 @@ static int open_perf_event(int i, int cpu_no, int j)
>  	return 0;
>  }
>  
> +/* Get type and config (read and write) of an UMC counter */
> +static int read_from_umc_dir(char *umc_dir, int count)
> +{
> +	char umc_counter_type[1024];

PATH_MAX

> +	FILE *fp;
> +
> +	/* Get type of iMC counter */
> +	sprintf(umc_counter_type, "%s%s", umc_dir, "type");
> +	fp = fopen(umc_counter_type, "r");
> +	if (!fp) {
> +		perror("Failed to open imc counter type file");

Please don't add new perror() anymore, I just managed to clean up those
in favor of ksft_perror().

> +

Drop this newline (to slowly move towards more concise error handling 
blocks w/o all those extra newlines).

> +		return -1;


> +	}
> +	if (fscanf(fp, "%u", &imc_counters_config[count][READ].type) <= 0) {
> +		perror("Could not get imc type");

Ditto.

> +		fclose(fp);
> +		return -1;
> +	}
> +
> +	fclose(fp);
> +
> +	imc_counters_config[count][WRITE].type =
> +		imc_counters_config[count][READ].type;
> +
> +	/*
> +	 * Setup the event and umasks for UMC events
> +	 * Number of CAS commands sent for reads:
> +	 * EventCode = 0x0a, umask = 0x1
> +	 * Number of CAS commands sent for writes:
> +	 * EventCode = 0x0a, umask = 0x2
> +	 */
> +	imc_counters_config[count][READ].event = 0xa;
> +	imc_counters_config[count][READ].umask = 0x1;
> +
> +	imc_counters_config[count][WRITE].event = 0xa;
> +	imc_counters_config[count][WRITE].umask = 0x2;
> +
> +	return 0;
> +}
> +
>  /* Get type and config (read and write) of an iMC counter */
>  static int read_from_imc_dir(char *imc_dir, int count)
>  {

-- 
 i.


