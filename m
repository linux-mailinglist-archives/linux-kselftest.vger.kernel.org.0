Return-Path: <linux-kselftest+bounces-241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EF07EF315
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 13:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5757D1F22F05
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 12:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733121A596;
	Fri, 17 Nov 2023 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mhxThk4X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EF7D56;
	Fri, 17 Nov 2023 04:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700225759; x=1731761759;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3HMFxHgCTxSVtX8V0rMNslAZUplZ+JhYFy41P4dMRh4=;
  b=mhxThk4Xfizo89moOTza9Tn5ESD8KeUEBOzn6fTV0TF+E+k+AxMiJp2y
   Hez0vCcJVGzaTKJ3NJXgyTIgYPS7juRKNrusxweoImufg4JY9QjChaKuz
   BcHQ8EpY2ktefEpYti9vKEA/W5io9b6xs2F2Vu09gMqClq8Tp1zFOk9+1
   zTc+9VbpiTbssLWTlz2MlE7FnqYTMUM8Ln8HZXyHOJbRrqE31jELPD5DT
   ufGqizpN2cn60xwyRlY7MKEeEkVF7RIwOwSZlESbhvyk21V9sHuREcWAP
   2VPtI+NqSBvfeF6VeP0se1pMVjrSI0iFLfl/PyFlw9CLwiB6pr+lJbXj4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="390153159"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="390153159"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 04:55:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="939142121"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="939142121"
Received: from scoltan-mobl.ger.corp.intel.com ([10.249.46.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 04:55:57 -0800
Date: Fri, 17 Nov 2023 14:55:54 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc: Fenghua Yu <fenghua.yu@intel.com>, 
    Reinette Chatre <reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/resctrl: Add non-contiguous CBMs CAT test
In-Reply-To: <20231109112847.432687-1-maciej.wieczor-retman@intel.com>
Message-ID: <879955f-d2d4-017-6694-5a031ec7f2@linux.intel.com>
References: <20231109112847.432687-1-maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 9 Nov 2023, Maciej Wieczor-Retman wrote:

> Non-contiguous CBM support for Intel CAT has been merged into the kernel
> with Commit 0e3cd31f6e90 ("x86/resctrl: Enable non-contiguous CBMs in
> Intel CAT") but there is no selftest that would validate if this feature
> works correctly.
> 
> The selftest needs to verify if writing non-contiguous CBMs to the
> schemata file behaves as expected in comparison to the information about
> non-contiguous CBMs support.
> 
> Add tests for both L2 and L3 CAT to verify if the return values
> generated by writing non-contiguous CBMs don't contradict the
> reported non-contiguous support information.

"if ... don't" sounds weird to me. Perhaps the "if" could just be dropped 
from it.

> Comparing the return value of write_schemata() with non-contiguous CBMs
> support information can be simplified as a logical XOR operation. In
> other words if non-contiguous CBMs are supported and if non-contiguous
> write succeeds the test should succeed and if the write fails the test
> should also fail. The opposite should happen if non-contiguous CBMs are
> not supported.

To me this sounds a bit verbose given how basic thing it talks about 
(but maybe I'm too old already to have actually come across a few xor
tricks in the past :-)). I'd simplify it to (or simply drop it):

Use a logical XOR to confirm return value of write_schemata() and  
non-contiguous CBMs support information match.

> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> 
> ---
> 
> This patch is based on a rework of resctrl selftests that's currently in
> review [1]. The patch also implements a similiar functionality presented
> in the bash script included in the cover letter to the original
> non-contiguous CBMs in Intel CAT series [2].
> 
> [1] https://lore.kernel.org/all/20231024092634.7122-1-ilpo.jarvinen@linux.intel.com/
> [2] https://lore.kernel.org/all/cover.1696934091.git.maciej.wieczor-retman@intel.com/
> 
>  tools/testing/selftests/resctrl/cat_test.c    | 97 +++++++++++++++++++
>  tools/testing/selftests/resctrl/resctrl.h     |  2 +
>  .../testing/selftests/resctrl/resctrl_tests.c |  2 +
>  3 files changed, 101 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index bc88eb891f35..6a01a5da30b4 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -342,6 +342,87 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>  	return ret;
>  }
>  
> +static int noncont_cat_run_test(const struct resctrl_test *test,
> +				const struct user_params *uparams)
> +{
> +	unsigned long full_cache_mask, cont_mask, noncont_mask;
> +	unsigned int eax, ebx, ecx, edx, ret, sparse_masks;
> +	char res_path[PATH_MAX];
> +	char schemata[64];
> +	int bit_center;
> +	FILE *fp;
> +
> +	/* Check to compare sparse_masks content to cpuid output. */
> +	snprintf(res_path, sizeof(res_path), "%s/%s/%s", INFO_PATH,
> +		 test->resource, "sparse_masks");
> +
> +	fp = fopen(res_path, "r");
> +	if (!fp) {
> +		perror("# Error in opening file\n");
> +		return errno;
> +	}
> +
> +	if (fscanf(fp, "%u", &sparse_masks) <= 0) {
> +		perror("Could not get sparse_masks contents\n");
> +		fclose(fp);
> +		return -1;
> +	}
> +
> +	fclose(fp);

Add a function to do this conversion into resctrlfs.c.

> +
> +	if (!strcmp(test->resource, "L3"))
> +		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
> +	else if (!strcmp(test->resource, "L2"))
> +		__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
> +	else
> +		return -EINVAL;

This would be same as (you need to make the func non-static though):
	level = get_cache_level(test->resource);
	if (level < 0)
		return -EINVAL;
	__cpuid_count(0x10, 4 - level, eax, ebx, ecx, edx);

> +	if (sparse_masks != ((ecx >> 3) & 1))
> +		return -1;
> +
> +	/* Write checks initialization. */
> +	ret = get_cbm_mask(test->resource, &full_cache_mask);
> +	if (ret < 0)
> +		return ret;
> +	bit_center = count_bits(full_cache_mask) / 2;
> +	cont_mask = full_cache_mask >> bit_center;
> +
> +	/* Contiguous mask write check. */
> +	snprintf(schemata, sizeof(schemata), "%lx", cont_mask);
> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Non-contiguous mask write check. CBM has a 0xf hole approximately in the middle.
> +	 * Output is compared with support information to catch any edge case errors.
> +	 */
> +	noncont_mask = ~(full_cache_mask & (0xf << bit_center)) & full_cache_mask;

Why is the full_cache_mask & part needed here? It's not like the second 
and can grow bits outside of full_cache_mask even if that would overflow 
the full_cache_mask (it won't be testing hole then though but that 
problem happens also at the boundary condition one bit prior to 
overflowing the mask).

> +	snprintf(schemata, sizeof(schemata), "%lx", noncont_mask);
> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
> +	if (ret && sparse_masks)
> +		ksft_print_msg("Non-contiguous CBMs supported but write failed\n");
> +	else if (ret && !sparse_masks)
> +		ksft_print_msg("Non-contiguous CBMs not supported and write failed as expected\n");
> +	else if (!ret && !sparse_masks)
> +		ksft_print_msg("Non-contiguous CBMs not supported but write succeeded\n");

Newline.

> +	return !ret == !sparse_masks;
> +}
> +
> +static bool noncont_cat_feature_check(const struct resctrl_test *test)
> +{
> +	char res_path[PATH_MAX];
> +	struct stat statbuf;
> +
> +	snprintf(res_path, sizeof(res_path), "%s/%s/%s", INFO_PATH,
> +		 test->resource, "sparse_masks");
> +
> +	if (stat(res_path, &statbuf))
> +		return false;

This looks generic enough that validate_resctrl_feature_request() should 
be somehow adapted to cover also these cases. Perhaps it would be best to 
just split validate_resctrl_feature_request() into multiple functions.

> +	return test_resource_feature_check(test);
> +}
> +
>  struct resctrl_test l3_cat_test = {
>  	.name = "L3_CAT",
>  	.group = "CAT",
> @@ -357,3 +438,19 @@ struct resctrl_test l2_cat_test = {
>  	.feature_check = test_resource_feature_check,
>  	.run_test = cat_run_test,
>  };
> +
> +struct resctrl_test l3_noncont_cat_test = {
> +	.name = "L3_NONCONT_CAT",
> +	.group = "NONCONT_CAT",

> +struct resctrl_test l2_noncont_cat_test = {
> +	.name = "L2_NONCONT_CAT",
> +	.group = "NONCONT_CAT",

I think these should be grouped among "CAT" group because it well, tests 
CAT functionality. Why you think a separate group for them is needed?

-- 
 i.


