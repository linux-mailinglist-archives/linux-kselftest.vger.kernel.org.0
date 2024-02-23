Return-Path: <linux-kselftest+bounces-5332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9E0860F96
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 11:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0DA21F25A37
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 10:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23267E581;
	Fri, 23 Feb 2024 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kzd7q8Dt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A256518A;
	Fri, 23 Feb 2024 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684718; cv=none; b=K8HXHF357OgGmA2WkZ5aYR0M38MXUtJsjPvR0KyLD2NljKmjQ6dPodVIk8EWq+oPp5e+wSmijsaRVhdjpZ9P+hrhMca/FNT1CbGAbprRYgK45hGMIeH9JKCXEoAszeE8XUMb3BlKCoPpl3I3+bSw3m/1YBCuXJ32SKUsIAJb5No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684718; c=relaxed/simple;
	bh=JMRg40DCsRBsVkHSpJV3eTn7+lBni66qFPlBAmj0ed0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rRNN2MgJs0+GJ9RgBavNsQIBvCafAJo87KsfkWBh3w9cv/K7EI6uTX8x6gYDpHVd3QM8O66ER5NGMrc6NaBY8PeKzN2/gWpA6Z36XkGnKlCzdt0t1KkouuLGuA7auQy+hmDBsLYq+Jl+Nh26orWUOAuN4OnYF2Sq+cqsG+/icZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kzd7q8Dt; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708684716; x=1740220716;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JMRg40DCsRBsVkHSpJV3eTn7+lBni66qFPlBAmj0ed0=;
  b=Kzd7q8Dt039NcFvMQTXx94TepRYX96rRRIl+xMcxKCvDR5UXH0JSLfL1
   FIw9083KeM7BAQ/9/iPinmUnZ+eyk2T7bJpTexcCmHi32/4B4xYGOPZy1
   3lfVVGVQC6gp8R3RISlkGe3wlXywwxdHLPW8MCE3NOO6RCjYCnDPmc26N
   A3vAg3R+Jg5FDSEgBBzOzK0b3jklyDxhaQuMuyEE/Hua/cEX33JMHIMVo
   /l0aV4aond6JMQz/1zHCfcHq4za/KiNhDP2wODpFhY9WHrsnzpPFrebgS
   IHlnypK7zDguk9rMQoW4cspBe2on4roU9VSEODppI1FIh3XgI/vX+iHIm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2875496"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2875496"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 02:38:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5843470"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.107])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 02:38:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 23 Feb 2024 12:38:18 +0200 (EET)
To: Babu Moger <babu.moger@amd.com>
cc: fenghua.yu@intel.com, Reinette Chatre <reinette.chatre@intel.com>, 
    shuah@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-kselftest@vger.kernel.org, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    peternewman@google.com, eranian@google.com
Subject: Re: [PATCH 1/4] selftests/resctrl: Rename variable imcs and
 num_of_imcs() to generic names
In-Reply-To: <458712890b9ac90b9e027ac1500881aedd58068c.1708637563.git.babu.moger@amd.com>
Message-ID: <8e4badb7-6cc5-61f1-e041-d902209a90d5@linux.intel.com>
References: <cover.1708637563.git.babu.moger@amd.com> <458712890b9ac90b9e027ac1500881aedd58068c.1708637563.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 22 Feb 2024, Babu Moger wrote:

> In an effort to support MBM and MBA tests for AMD, renaming for variable
> and functions to generic names. For Intel, the memory controller is called
> Integrated Memory Controllers (IMC). For AMD, it is called Unified
> Memory Controller (UMC). No functional change.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  tools/testing/selftests/resctrl/resctrl_val.c | 25 ++++++++++---------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 88789678917b..52e23a8076d3 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -60,7 +60,7 @@ struct imc_counter_config {
>  };
>  
>  static char mbm_total_path[1024];
> -static int imcs;
> +static int number_of_mem_ctrls;
>  static struct imc_counter_config imc_counters_config[MAX_IMCS][2];
>  
>  void membw_initialize_perf_event_attr(int i, int j)
> @@ -211,15 +211,16 @@ static int read_from_imc_dir(char *imc_dir, int count)
>  }
>  
>  /*
> - * A system can have 'n' number of iMC (Integrated Memory Controller)
> - * counters, get that 'n'. For each iMC counter get it's type and config.
> + * A system can have 'n' number of iMC (Integrated Memory Controller for
> + * Intel) counters, get that 'n'. In case of AMD it is called UMC (Unified
> + * Memory Controller). For each iMC/UMC counter get it's type and config.
>   * Also, each counter has two configs, one for read and the other for write.
>   * A config again has two parts, event and umask.
>   * Enumerate all these details into an array of structures.
>   *
>   * Return: >= 0 on success. < 0 on failure.
>   */
> -static int num_of_imcs(void)
> +static int get_number_of_mem_ctrls(void)

It's a bit odd to shorten "memory" and "controller" but not "number". In 
fact, I'd prefer to use "controllers" in the longer form because ctrls 
is ambiguous ("control" vs "controller").

So perhaps num_of_mem_controllers(void) (or that with get_ prefix if you 
insist).

>  {
>  	char imc_dir[512], *temp;
>  	unsigned int count = 0;
> @@ -279,12 +280,12 @@ static int initialize_mem_bw_imc(void)
>  {
>  	int imc, j;
>  
> -	imcs = num_of_imcs();
> -	if (imcs <= 0)
> -		return imcs;
> +	number_of_mem_ctrls = get_number_of_mem_ctrls();
> +	if (number_of_mem_ctrls <= 0)
> +		return number_of_mem_ctrls;
>  
>  	/* Initialize perf_event_attr structures for all iMC's */
> -	for (imc = 0; imc < imcs; imc++) {
> +	for (imc = 0; imc < number_of_mem_ctrls; imc++) {

So you renamed imcs, but not imc. Perhaps the variable names could just be 
"mc" and "mcs"?

>  		for (j = 0; j < 2; j++)
>  			membw_initialize_perf_event_attr(imc, j);
>  	}
> @@ -309,7 +310,7 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
>  
>  	/* Start all iMC counters to log values (both read and write) */
>  	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
> -	for (imc = 0; imc < imcs; imc++) {
> +	for (imc = 0; imc < number_of_mem_ctrls; imc++) {
>  		for (j = 0; j < 2; j++) {
>  			ret = open_perf_event(imc, cpu_no, j);
>  			if (ret)
> @@ -322,7 +323,7 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
>  	sleep(1);
>  
>  	/* Stop counters after a second to get results (both read and write) */
> -	for (imc = 0; imc < imcs; imc++) {
> +	for (imc = 0; imc < number_of_mem_ctrls; imc++) {
>  		for (j = 0; j < 2; j++)
>  			membw_ioctl_perf_event_ioc_disable(imc, j);
>  	}
> @@ -331,7 +332,7 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
>  	 * Get results which are stored in struct type imc_counter_config
>  	 * Take over flow into consideration before calculating total b/w
>  	 */
> -	for (imc = 0; imc < imcs; imc++) {
> +	for (imc = 0; imc < number_of_mem_ctrls; imc++) {
>  		struct imc_counter_config *r =
>  			&imc_counters_config[imc][READ];
>  		struct imc_counter_config *w =
> @@ -368,7 +369,7 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
>  		writes += w->return_value.value * of_mul_write * SCALE;
>  	}
>  
> -	for (imc = 0; imc < imcs; imc++) {
> +	for (imc = 0; imc < number_of_mem_ctrls; imc++) {
>  		close(imc_counters_config[imc][READ].fd);
>  		close(imc_counters_config[imc][WRITE].fd);

I've a yet submitted patch to convert these close() calls to use the 
loop approach which is consistent with the rest of the code, since you
will end up touching this when you do imc -> mc rename, it would be 
preferrable if you add one patch into your series which converts them to:

		for (j = 0; j < 2; j++)
			close(imc_counters_config[mc][j].fd);

(Given how long kselftest patches tend to linger unapplied, it would 
make things a lot easier since those changes will obviously conflict 
otherwise).

-- 
 i.


