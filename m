Return-Path: <linux-kselftest+bounces-5030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB11585BD76
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 14:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FAC2850EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 13:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F77D6A33F;
	Tue, 20 Feb 2024 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A30U9cD9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C7E5B1E6;
	Tue, 20 Feb 2024 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436753; cv=none; b=M3smIV9rvokQVDvf6lOIKxtDMalQrVBM000e+oc8PSuVLZbJsO+LShMs3ApPnKDB9V+0fT9WTsNBLgshI419FaZZGPR+R9ycK7ekBGNvEd/Hfri9mhy4tbJccZWEUdbs7Ti9Et9MU8j/b5V5v4CGh61Eih831Tz1y5G8YIVNpe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436753; c=relaxed/simple;
	bh=0L+oqvPLfVCK7Ieg6wTiU99ZpvE789Oat2RVeiUpHzs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JM5AQK2iefORirx5Tiy+WDFgC9Eo0Q0QOjx9HcHtxL2mIYpysQZsNsvETCAHNqMBsd7eGLcDg8wuv1m1DGiI9LVFz+7ZJ5zxRyKpFtIN+S/6KO9s3eyEJOOYu5UgbhyToWgm0GuBGzhb1oFbgmb/bbY5ampIVmLYn9H8oOxrIFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A30U9cD9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708436752; x=1739972752;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0L+oqvPLfVCK7Ieg6wTiU99ZpvE789Oat2RVeiUpHzs=;
  b=A30U9cD9Zu8Wxg0FdAk+1paS2Pkg/SS9mxPn4NgDrbJ/ic1lrkBShgYQ
   hILBwz4qwlJlBYSZHWuNiq9BGAYGxUUe9IRWzTqwYKbCwYLQ62PWy326w
   0al3gXJy0biHzuN8FpSRkiz+2IqhWwhT64/XHd6vnesQ2i89kCvQp9r3+
   xjNjr8Er5MPArzyDaF5clYkYEZ5k4hHphk4WDFrOcgU0PK9bmaMYcK6Fo
   c0FCvYxToBzjWmixz5uLxVsIMA47woTxghAryinXpf32/pghX1OII84pk
   ZJ/UF+8BqxRYSdKftqh3eQNupiPsG1kNeIqBeu3MUty0G28BLD6+9UUNx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="13095751"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="13095751"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 05:45:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="5016328"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.249.21])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 05:45:28 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 Feb 2024 15:45:23 +0200 (EET)
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc: Fenghua Yu <fenghua.yu@intel.com>, 
    Reinette Chatre <reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] selftests/resctrl: Simplify cleanup in ctrl-c
 handler
In-Reply-To: <8c4fcfb6b4e38a0f0e400be88ecf1af0d20e12e7.1708434017.git.maciej.wieczor-retman@intel.com>
Message-ID: <5f251bcd-a343-bb6e-a947-7605dc59f9ea@linux.intel.com>
References: <cover.1708434017.git.maciej.wieczor-retman@intel.com> <8c4fcfb6b4e38a0f0e400be88ecf1af0d20e12e7.1708434017.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 20 Feb 2024, Maciej Wieczor-Retman wrote:

> Ctrl-c handler isn't aware of what test is currently running. Because of
> that it executes all cleanups even if they aren't necessary. Since the
> ctrl-c handler uses the sigaction system no parameters can be passed
> to it as function arguments.
> 
> Add a global variable to make ctrl-c handler aware of the currently run
> test and only execute the correct cleanup callback.
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
>  tools/testing/selftests/resctrl/resctrl.h     |  2 ++
>  .../testing/selftests/resctrl/resctrl_tests.c | 20 +++++++++----------
>  tools/testing/selftests/resctrl/resctrl_val.c |  2 +-
>  3 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 0f49df4961ea..79b45cbeb628 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -128,6 +128,8 @@ extern pid_t bm_pid, ppid;
>  
>  extern char llc_occup_path[1024];
>  
> +extern struct resctrl_test current_test;

Why this is not just a pointer?

> +
>  int get_vendor(void);
>  bool check_resctrlfs_support(void);
>  int filter_dmesg(void);
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 75fc49ba3efb..b17f7401892c 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -14,6 +14,12 @@
>  static volatile int sink_target;
>  volatile int *value_sink = &sink_target;
>  
> +/*
> + * Set during test preparation for the cleanup function pointer used in
> + * ctrl-c sa_sigaction
> + */
> +struct resctrl_test current_test;
> +
>  static struct resctrl_test *resctrl_tests[] = {
>  	&mbm_test,
>  	&mba_test,
> @@ -75,18 +81,12 @@ static void cmd_help(void)
>  	printf("\t-h: help\n");
>  }
>  
> -void tests_cleanup(void)
> -{
> -	mbm_test_cleanup();
> -	mba_test_cleanup();
> -	cmt_test_cleanup();
> -	cat_test_cleanup();
> -}

This should be removed from resctrl.h too.

> -
> -static int test_prepare(void)
> +static int test_prepare(const struct resctrl_test *test)
>  {
>  	int res;
>  
> +	current_test = *test;

I'd prefer to keep this internal to signal handling functions so that 
either the struct resctrl_test or just the cleanup handler is passed 
to signal_handler_register().

It'd also allow current_test (or the cleanup function ptr) to be static.

-- 
 i.


