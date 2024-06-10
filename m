Return-Path: <linux-kselftest+bounces-11577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7A1902689
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 18:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C591C21337
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 16:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40962142E7F;
	Mon, 10 Jun 2024 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XnlQn7cc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984CB43146;
	Mon, 10 Jun 2024 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718036465; cv=none; b=OQkE0rca4bWq49ISH8GcxHQiFq7N5QLni1zR2MCy78LhFgM/SKo5iVcxtgju7Wpzv7RZdYQtL9vXKAy5FZ5fmgk7l64Enj/c7h9cPjdU6usDiXsdML2oumzYMyzfqmAiY4DTzIb+nXWXZ43zBxyOdmQfGhx7+Tc8j3AzXG78w2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718036465; c=relaxed/simple;
	bh=25JnKzM0oSveF/yU7V7v0D6gw5AxNyK/vndNnfQoSrU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Zh4PxSCGdmUy9qNAZysqnOcCYLh75KXFfAtTqLekkfmt3T3q2LAeYXouN8qpzVYKroaqOvXJVaQ8rLhyLbNbL6n2zzndewoR/Cpl4A29FlkzeOBDm7wXxT21q7zjLKsouIrwu7d11W/tLY8k3qpqFLYxxSR+9x0ISDhYj7AbHmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XnlQn7cc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718036463; x=1749572463;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=25JnKzM0oSveF/yU7V7v0D6gw5AxNyK/vndNnfQoSrU=;
  b=XnlQn7ccB54t/oSEA5JGo/6LiKG3dyaTLoz1SWkF0ga1XQwbV77MC8od
   CY+EX0RN/Lvmny5jm2AUXqoR81dJJ0hhAv+VM8x3geq+mufKNygtwm+Ii
   Kuz+Co0z8Xd7B4x6aAoor5M9CSkpIoJQrf0Jfc3JW8f6Jl43Fuk18RRY9
   SNp14vmBsbVy3j6ZAC5+L5YB+z2jvRrtnHXGASgh3G/1sPPsX5BBgvNKf
   SgeIdLkma7QNoip/FcnnBPBcNBG/wUHSDawq6OUPV2I7qBJyIfz/4BcWf
   pGVkIRwkId8E2vWj+w/nHhdwBytk94ByYsAGSK10ssGoytVFLqBfoEM4p
   Q==;
X-CSE-ConnectionGUID: AnObiPa7SBm2+07YT3aV0A==
X-CSE-MsgGUID: 3yg7AYAyQXy+U37OR09pYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="12001676"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="12001676"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 09:21:03 -0700
X-CSE-ConnectionGUID: VQzS7yZASHyNN6S6cncpoQ==
X-CSE-MsgGUID: F8rUVy+KQdCCIr86/WK5nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39672367"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.194])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 09:20:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 10 Jun 2024 19:20:55 +0300 (EEST)
To: Babu Moger <babu.moger@amd.com>
cc: fenghua.yu@intel.com, Reinette Chatre <reinette.chatre@intel.com>, 
    shuah@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-kselftest@vger.kernel.org, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    peternewman@google.com, eranian@google.com
Subject: Re: [PATCH v2] selftests/resctrl: Fix noncont_cat_run_test for AMD
In-Reply-To: <7679d70a0ea939db13ae9dac20de56644460d6df.1718035091.git.babu.moger@amd.com>
Message-ID: <91052cec-071b-7cc7-5f85-4fa29ec2aea4@linux.intel.com>
References: <3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com> <7679d70a0ea939db13ae9dac20de56644460d6df.1718035091.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <048478a2-4626-4610-9ef9-7e66f358abf2@linux.intel.com>

On Mon, 10 Jun 2024, Babu Moger wrote:

> The selftest noncont_cat_run_test fails on AMD with the warnings. Reason

noncont_cat_run_test()

(In general, use () when refering to a function, same thing in the 
shortlog).

"the warnings" sounds like I should know about what warning it fails with
but there's no previous context which tells that information. I suggest 
you either use "a warning" or quote the warning it fails with into the 
commit message.

> is, AMD supports non contiguous CBM masks but does not report it via CPUID.

non-contiguous

> Update noncont_cat_run_test to check for the vendor when verifying CPUID.

()

> Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT test")
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v2: Moved the non contiguous verification to a new function
>     arch_supports_noncont_cat.
> 
> v1:
> This was part of the series
> https://lore.kernel.org/lkml/cover.1708637563.git.babu.moger@amd.com/
> Sending this as a separate fix per review comments.
> ---
>  tools/testing/selftests/resctrl/cat_test.c | 32 +++++++++++++++-------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index d4dffc934bc3..742782438ca3 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -288,11 +288,30 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>  	return ret;
>  }
>  
> +static bool arch_supports_noncont_cat(const struct resctrl_test *test)
> +{
> +	unsigned int eax, ebx, ecx, edx;
> +
> +	/* AMD always supports non-contiguous CBM. */
> +	if (get_vendor() == ARCH_AMD)
> +		return true;
> +
> +	/* Intel support for non-contiguous CBM needs to be discovered. */
> +	if (!strcmp(test->resource, "L3"))
> +		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
> +	else if (!strcmp(test->resource, "L2"))
> +		__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
> +	else
> +		return false;
> +
> +	return ((ecx >> 3) & 1);
> +}
> +
>  static int noncont_cat_run_test(const struct resctrl_test *test,
>  				const struct user_params *uparams)
>  {
>  	unsigned long full_cache_mask, cont_mask, noncont_mask;
> -	unsigned int eax, ebx, ecx, edx, sparse_masks;
> +	unsigned int sparse_masks;
>  	int bit_center, ret;
>  	char schemata[64];
>  
> @@ -301,15 +320,8 @@ static int noncont_cat_run_test(const struct resctrl_test *test,
>  	if (ret)
>  		return ret;
>  
> -	if (!strcmp(test->resource, "L3"))
> -		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
> -	else if (!strcmp(test->resource, "L2"))
> -		__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
> -	else
> -		return -EINVAL;
> -
> -	if (sparse_masks != ((ecx >> 3) & 1)) {
> -		ksft_print_msg("CPUID output doesn't match 'sparse_masks' file content!\n");
> +	if (arch_supports_noncont_cat(test) != sparse_masks) {
> +		ksft_print_msg("Hardware and kernel differ on non-contiguous CBM support!\n");
>  		return 1;

This looks better than the previous version, thanks.


-- 
 i.

