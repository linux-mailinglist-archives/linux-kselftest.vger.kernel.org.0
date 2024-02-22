Return-Path: <linux-kselftest+bounces-5276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E6985F565
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 11:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B837B27198
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 10:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED9B39FC7;
	Thu, 22 Feb 2024 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NrsDV9Hu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC5A39AD7;
	Thu, 22 Feb 2024 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596775; cv=none; b=gr4pmW8+Jg62p463yKmYFJ381F/B9bVCINAYb7fpbPzW/HrEAQbRMmI7jDldy0kT1GnwSV1GltRT+fqUhc0N0yG2U2OM4oqciaSxf67l7A8cXscMSVaF8NAFCxxrVbIkyyyXEKi737f8VshQnA9pilqQIfvjNQKMY6xJ/yH0pbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596775; c=relaxed/simple;
	bh=7mFUgLljD7GD0PBRnkg+TW0k+L5jfdL3EkP9kYG+g2c=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=h0yQfyatX7kMPrS/cbQCKqrFK1fWINJdvcuOXULVt6aYMMqSBFsyM1piTFcZNkXKeoW0XvLJ0UGm+0MVETvrsJw7LqB0xkc2Isah16TA9XMhrLV82Ug4+w5zZm6YfQlckaCO8cc0Noiz1/p39a6cW4eALnH0ffP3z9es2Z29RRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NrsDV9Hu; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708596773; x=1740132773;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7mFUgLljD7GD0PBRnkg+TW0k+L5jfdL3EkP9kYG+g2c=;
  b=NrsDV9Hu18k42iqOZfAzHtbO8UPt8vI/EPuirvqT+Eh7JozW9UF7KSQO
   g6HGym/Qc/ofj0+SjUiG4726TvdgNRm5b0+ANHYyaCMAnHSGBlBqXxLLj
   zc1C33NOk9VXbtrKGSPde5uCGFAJ2rV4r/yd9hr8FcT0ctme9kxoo2356
   QZzTdrfrhVHlBwbLSywphIM7n6loKQNbSHMzUeMR4GA6HcXm5LNfr/nIx
   1XiJFhAfl1Of3979BJp1GWy6CaFLKAcK9RnzRTOVeBbQnz6iYlbBxJ0sQ
   +76EBmKkj0NWwxLJwi1Ky9wrjNqdoxSo+RtqCxDAnetoYBcToueOW22Pq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="28254142"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="28254142"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 02:12:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5386230"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.249.55])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 02:12:49 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 22 Feb 2024 12:12:44 +0200 (EET)
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc: Fenghua Yu <fenghua.yu@intel.com>, 
    Reinette Chatre <reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/3] selftests/resctrl: Simplify cleanup in ctrl-c
 handler
In-Reply-To: <3a6639cd338a706bd2ed341aa6c717e1e79cc1f0.1708596015.git.maciej.wieczor-retman@intel.com>
Message-ID: <c472e478-eaf1-0003-cf2d-c861e620fce2@linux.intel.com>
References: <cover.1708596015.git.maciej.wieczor-retman@intel.com> <3a6639cd338a706bd2ed341aa6c717e1e79cc1f0.1708596015.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 22 Feb 2024, Maciej Wieczor-Retman wrote:

> Ctrl-c handler isn't aware of what test is currently running. Because of
> that it executes all cleanups even if they aren't necessary. Since the
> ctrl-c handler uses the sa_sigaction system no parameters can be passed
> to it as function arguments.
> 
> Add a global variable to make ctrl-c handler aware of the currently run
> test and only execute the correct cleanup callback.
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v2:
> - Remove tests_cleanup() from resctrl.h.
> - Make current_test a const pointer only inside resctrl_val.c. (Ilpo)
> 
>  tools/testing/selftests/resctrl/resctrl.h       |  3 +--
>  tools/testing/selftests/resctrl/resctrl_tests.c | 14 +++-----------
>  tools/testing/selftests/resctrl/resctrl_val.c   |  6 ++++--
>  3 files changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 0f49df4961ea..826783b29c9d 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -153,7 +153,6 @@ int resctrl_val(const struct resctrl_test *test,
>  		const struct user_params *uparams,
>  		const char * const *benchmark_cmd,
>  		struct resctrl_val_param *param);
> -void tests_cleanup(void);
>  void mbm_test_cleanup(void);
>  void mba_test_cleanup(void);
>  unsigned long create_bit_mask(unsigned int start, unsigned int len);
> @@ -162,7 +161,7 @@ int get_full_cbm(const char *cache_type, unsigned long *mask);
>  int get_mask_no_shareable(const char *cache_type, unsigned long *mask);
>  int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
>  void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
> -int signal_handler_register(void);
> +int signal_handler_register(const struct resctrl_test *test);
>  void signal_handler_unregister(void);
>  void cat_test_cleanup(void);
>  unsigned int count_bits(unsigned long n);
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 75fc49ba3efb..161f5365b4f0 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -75,19 +75,11 @@ static void cmd_help(void)
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
> -
> -static int test_prepare(void)
> +static int test_prepare(const struct resctrl_test *test)
>  {
>  	int res;
>  
> -	res = signal_handler_register();
> +	res = signal_handler_register(test);
>  	if (res) {
>  		ksft_print_msg("Failed to register signal handler\n");
>  		return res;
> @@ -130,7 +122,7 @@ static void run_single_test(const struct resctrl_test *test, const struct user_p
>  
>  	ksft_print_msg("Starting %s test ...\n", test->name);
>  
> -	if (test_prepare()) {
> +	if (test_prepare(test)) {
>  		ksft_exit_fail_msg("Abnormal failure when preparing for the test\n");
>  		return;
>  	}
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 5a49f07a6c85..d572815436f3 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -62,6 +62,7 @@ struct imc_counter_config {
>  static char mbm_total_path[1024];
>  static int imcs;
>  static struct imc_counter_config imc_counters_config[MAX_IMCS][2];
> +const struct resctrl_test *current_test;

static const struct

>  void membw_initialize_perf_event_attr(int i, int j)
>  {
> @@ -472,7 +473,7 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
>  	if (bm_pid)
>  		kill(bm_pid, SIGKILL);
>  	umount_resctrlfs();
> -	tests_cleanup();
> +	current_test->cleanup();

These calls should have if (current_test->cleanup()) guard. Isn't the 
non-contiguous already test w/o the cleanup function?

Other than those two, this looked okay.

-- 
 i.


