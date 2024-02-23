Return-Path: <linux-kselftest+bounces-5334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56991860FE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 11:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869EE1C23B2F
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 10:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4400D65189;
	Fri, 23 Feb 2024 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SwfxTpZs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0032222067;
	Fri, 23 Feb 2024 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708685784; cv=none; b=bJPZxb9QCER6yP9tcGnGuTHAmFTtwIcrbWYY4ZuoUCu+sdMzTHSgY55IRr8o3fGqKZmLOCBWOBLby+g1FMKlrkILVvQNuppK51HdlvLGpqSf3+vfH4GlsEF2Ak5szq/cUX7HNUBHxQOIhFDPXA+OVchVQ0WVd7CYpXvK+9M8O8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708685784; c=relaxed/simple;
	bh=qjHLMyWxOQ5rvNVAwfaXdYMBjVnIvVxnsqMTBeaB3j0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YOFiDapB0TYohRBD70e3QxDo/8tdAcGHbhhsKiWsHTrtLI7MEpEFYZ1PqzUXF0YtgdNXqNwopD/fekoQ5ttf96pel4B/8RUYJIKBx6MsHYpGbIi7m0A6XZL2GwSP1cehO3gjq24OiJ/9/2ASpqmPKrhBWxpPsj9XgDxsXnDrkmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SwfxTpZs; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708685782; x=1740221782;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qjHLMyWxOQ5rvNVAwfaXdYMBjVnIvVxnsqMTBeaB3j0=;
  b=SwfxTpZsp1uVf1JsUfajt/VeLRz4YDC6YBnIrkjsqE7e9P1sn6CO2uxA
   HEwWQZ6dmbT1QytrvPGapph9hTeQjxheMe0611s/9IKS6hroVzdvAgUpG
   jmdEtGiUWX6gELWq3tf7esFVQUrdzdw55UD00k9ceg6OSPWdRNmk+i1A1
   o/K/oBy3F4hLFpSdHsluUQGTgkpouF6EbO3Tk/CyM5AlJUo9T1pP1KcQ8
   twarWsl77P/XrBlVVGatoYaHsUPbyDImkjNEwn6O7pKGovg38E4HYbOzd
   vuPEEYZACgnHpzWK2QRX6Ohw3M8mxHhVZcof8L5JACOyHa3zfS5orlUdH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13558218"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13558218"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 02:56:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6350307"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.107])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 02:56:19 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 23 Feb 2024 12:56:04 +0200 (EET)
To: Babu Moger <babu.moger@amd.com>
cc: fenghua.yu@intel.com, Reinette Chatre <reinette.chatre@intel.com>, 
    shuah@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-kselftest@vger.kernel.org, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    peternewman@google.com, eranian@google.com
Subject: Re: [PATCH 4/4] selftests/resctrl: Skip the tests if iMC/UMC counters
 are unavailable
In-Reply-To: <f5c74072d96b57b10a66c01381139de453187327.1708637563.git.babu.moger@amd.com>
Message-ID: <a13f6e21-9929-a16d-bda1-533eaed8f875@linux.intel.com>
References: <cover.1708637563.git.babu.moger@amd.com> <f5c74072d96b57b10a66c01381139de453187327.1708637563.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 22 Feb 2024, Babu Moger wrote:

> Older systems do not support UMC (Unified Memory Controller) perf counters.
> Skip the tests if the system does not support UMC counters.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  tools/testing/selftests/resctrl/resctrl.h       |  1 +
>  tools/testing/selftests/resctrl/resctrl_tests.c | 10 ++++++++++
>  tools/testing/selftests/resctrl/resctrl_val.c   |  4 ++--
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index a33f414f6019..5c2556af0649 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -116,5 +116,6 @@ int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
>  		    size_t cache_span, unsigned long max_diff,
>  		    unsigned long max_diff_percent, unsigned long num_of_runs,
>  		    bool platform, bool cmt);
> +int get_number_of_mem_ctrls(void);
>  
>  #endif /* RESCTRL_H */
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 231233b8d354..5423882529ec 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -98,6 +98,11 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
>  
>  	ksft_print_msg("Starting MBM BW change ...\n");
>  
> +	if (get_number_of_mem_ctrls() < 0) {
> +		ksft_test_result_skip("Unable find iMC/UMC counters!\n");
> +		return;
> +	}
> +
>  	if (test_prepare()) {
>  		ksft_exit_fail_msg("Abnormal failure when preparing for the test\n");
>  		return;
> @@ -124,6 +129,11 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
>  
>  	ksft_print_msg("Starting MBA Schemata change ...\n");
>  
> +	if (get_number_of_mem_ctrls() < 0) {
> +		ksft_test_result_skip("Unable find iMC/UMC counters!\n");
> +		return;
> +	}
> +
>  	if (test_prepare()) {
>  		ksft_exit_fail_msg("Abnormal failure when preparing for the test\n");
>  		return;

This also needs rebasing and adaptation to the generic test framework.

-- 
 i.


