Return-Path: <linux-kselftest+bounces-6109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BF4876603
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 15:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24BDFB2274C
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 14:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3DC3FBB8;
	Fri,  8 Mar 2024 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NaRSpBCc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90BE63B8;
	Fri,  8 Mar 2024 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906948; cv=none; b=hFTNxw8YdtNe2/WZWvOVdRfyLSocBNeIBE2PfzPNml/+CLQ9xvtw35HHlwGzckNx8WoGkWA0P7bwV6SjCUcWeEL6hrn9cBnlQM6P2ExMS8dYo8DgOHyrDPuPtG7d+NlgiAJDBWfhMgl9xJEnZ7JcF2+gQOyrjIQNyOPDFflt0oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906948; c=relaxed/simple;
	bh=laXx+w8ApSTKlr0+uxTd3nFWByofVxkALdnTQ9VuY44=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ALp72aOWzdCxx++c+/19t+ik1v+56/nnWoDDOUbiwX/b3qewvWcp9BNzWxr6TlOMxXcx1VTIc/E0+wezRCitrornmP35wU7iuSwEDC9PAyYwx3d+QDlrJPawG3hyBO4qJ4JwRR3QcJ6+CmljTjQG59o7E2gdlF/G7Yo+dW+tXiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NaRSpBCc; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709906947; x=1741442947;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=laXx+w8ApSTKlr0+uxTd3nFWByofVxkALdnTQ9VuY44=;
  b=NaRSpBCcBrV+L5YhlrWbkM8r+krICBM+DWaB/unAe50Vyeclc/S4QYcx
   WYXrMMCJP1jZbnG8KBs7XCKpIBn19Vv8PuvepAT8G15inKJda4uHjWmTr
   s3nOBRP90DDVQXCQ9vZa1068A70cxbO2C34Siy76EmZpFzqwEfEOAxrpl
   O+6yJYhihwXta0mm3z1rOqjg98qvfjoZOkJBdaLXO+F1zLGZHhkLu63yx
   mtSWtpN6QT09YEfmoLwr25+uHB0v/Deky17uXmMNa/i+eXzX90k8T5atP
   0IKXEFYAircqAgX+OEjcT4TD7187U1YE1SZ2orz42JcjpAjjbuzWo0cu8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="22080033"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="22080033"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 06:07:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="33609806"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 06:07:10 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 8 Mar 2024 16:07:05 +0200 (EET)
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc: Fenghua Yu <fenghua.yu@intel.com>, 
    Reinette Chatre <reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>, 
    tony.luck@intel.com, "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>, 
    LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/4] selftests/resctrl: SNC support for MBM
In-Reply-To: <def02de22a4747ed56ddc28f334e55872ba95f13.1709721159.git.maciej.wieczor-retman@intel.com>
Message-ID: <37bd082c-a187-43de-892b-c5fa32a8b3f2@linux.intel.com>
References: <cover.1709721159.git.maciej.wieczor-retman@intel.com> <def02de22a4747ed56ddc28f334e55872ba95f13.1709721159.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 6 Mar 2024, Maciej Wieczor-Retman wrote:

> Memory Bandwidth Monitoring (MBM) measures how much data flows between
> cache levels. Only the flow for a process specified with a Resource
> Monitoring ID (RMID) is measured.
> 
> Sub-Numa Clustering (SNC) causes MBM selftest to fail because the
> increased amount of NUMA nodes per socket is not taken into account.
> That in turn makes the test use incorrect values for the start and end
> of the measurement by tracking the wrong node.
> 
> For the MBM selftest to be NUMA-aware it needs to track the start and end
> values of a measurement not for a single node but for all nodes on the
> same socket. Then summing all measured values comes out as the real
> bandwidth used by the process.
> 
> Reported-by: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
> Closes: https://lore.kernel.org/lkml/TYAPR01MB6330A4EB3633B791939EA45E8B39A@TYAPR01MB6330.jpnprd01.prod.outlook.com/
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
>  tools/testing/selftests/resctrl/mba_test.c    |  1 -
>  tools/testing/selftests/resctrl/resctrl_val.c | 37 ++++++++++++-------
>  2 files changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> index 7946e32e85c8..fc31a61dab0c 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -147,7 +147,6 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
>  	struct resctrl_val_param param = {
>  		.resctrl_val	= MBA_STR,
>  		.ctrlgrp	= "c1",
> -		.mongrp		= "m1",
>  		.filename	= RESULT_FILE_NAME,
>  		.bw_report	= "reads",
>  		.setup		= mba_setup
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index e75e3923ebe2..2fe9f8bb4a45 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -595,9 +595,10 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
>  
>  static int measure_vals(const struct user_params *uparams,
>  			struct resctrl_val_param *param,
> -			unsigned long *bw_resc_start)
> +			unsigned long *bw_resc_start,
> +			int res_id)
>  {
> -	unsigned long bw_resc, bw_resc_end;
> +	unsigned long bw_resc = 0, bw_resc_sum = 0, bw_resc_end;
>  	float bw_imc;
>  	int ret;
>  
> @@ -612,17 +613,19 @@ static int measure_vals(const struct user_params *uparams,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = get_mem_bw_resctrl(&bw_resc_end);
> -	if (ret < 0)
> -		return ret;
> +	for (int i = 0 ; i < snc_ways() ; i++) {
> +		set_mbm_path(param->ctrlgrp, strlen(param->mongrp) > 0 ? param->mongrp : NULL,
> +			     res_id + i);
> +		ret = get_mem_bw_resctrl(&bw_resc_end);
> +		bw_resc = (bw_resc_end - bw_resc_start[i]) / MB;
> +		bw_resc_sum += bw_resc;
> +		bw_resc_start[i] = bw_resc_end;
> +	}
>  
> -	bw_resc = (bw_resc_end - *bw_resc_start) / MB;
> -	ret = print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
> +	ret = print_results_bw(param->filename, bm_pid, bw_imc, bw_resc_sum);
>  	if (ret)
>  		return ret;
>  
> -	*bw_resc_start = bw_resc_end;
> -
>  	return 0;
>  }
>  
> @@ -697,12 +700,16 @@ int resctrl_val(const struct resctrl_test *test,
>  		struct resctrl_val_param *param)
>  {
>  	char *resctrl_val = param->resctrl_val;
> -	unsigned long bw_resc_start = 0;
>  	int res_id, ret = 0, pipefd[2];
> +	unsigned long *bw_resc_start;
>  	struct sigaction sigact;
>  	char pipe_message = 0;
>  	union sigval value;
>  
> +	bw_resc_start = calloc(snc_ways(), sizeof(unsigned long));

While correct, this seems a bit overkill given is MAX_SNC = 4, not 
something large or unbounded.

This patch would be be much simpler on top of my resctrl_val() cleanup 
patches because bw_resc_start is only local to the measurement function.

-- 
 i.

> +	if (!bw_resc_start)
> +		return -1;
> +
>  	if (strcmp(param->filename, "") == 0)
>  		sprintf(param->filename, "stdio");
>  
> @@ -710,7 +717,7 @@ int resctrl_val(const struct resctrl_test *test,
>  	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR))) {
>  		ret = validate_bw_report_request(param->bw_report);
>  		if (ret)
> -			return ret;
> +			goto out_free;
>  	}
>  
>  	/*
> @@ -721,7 +728,7 @@ int resctrl_val(const struct resctrl_test *test,
>  
>  	if (pipe(pipefd)) {
>  		ksft_perror("Unable to create pipe");
> -
> +		free(bw_resc_start);
>  		return -1;
>  	}
>  
> @@ -733,7 +740,7 @@ int resctrl_val(const struct resctrl_test *test,
>  	bm_pid = fork();
>  	if (bm_pid == -1) {
>  		ksft_perror("Unable to fork");
> -
> +		free(bw_resc_start);
>  		return -1;
>  	}
>  
> @@ -841,7 +848,7 @@ int resctrl_val(const struct resctrl_test *test,
>  
>  		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
>  		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
> -			ret = measure_vals(uparams, param, &bw_resc_start);
> +			ret = measure_vals(uparams, param, bw_resc_start, res_id);
>  			if (ret)
>  				break;
>  		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
> @@ -855,6 +862,8 @@ int resctrl_val(const struct resctrl_test *test,
>  
>  out:
>  	kill(bm_pid, SIGKILL);
> +out_free:
> +	free(bw_resc_start);
>  
>  	return ret;
>  }


