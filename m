Return-Path: <linux-kselftest+bounces-3564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8636183C260
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 13:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17617B22B71
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 12:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DB945023;
	Thu, 25 Jan 2024 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dfDGjcho"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBC132C91;
	Thu, 25 Jan 2024 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184913; cv=none; b=PSdUbq4nLPRR5UnO3CNKeYB3p7oKZiX9eGj0rP/ylhaUQXYq9kTrtYdo1qvB8jtv7u7A9vWuHGsC6GtCe4NB1nK0TdjKJpXHJ3vF39W/AL5rmgaNpGql0fcakIO12INoKNKslwp6HpaaYlScH+WggjqzpiitORUJByEtoeYG9iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184913; c=relaxed/simple;
	bh=0MQXl5mvTmeLTzTGvou1AzDpV1uX0rJdnRYCdYPetBA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZgNDLykEnakyjR+GoNi43jSz5NURSl22dMC4pOaY76fuGFb6xpPStyllOLtNKgKjNCTBbYOlfzAUVfS/zev/gpX+HlAXmtp8Jc0IXWWlSHZTpFg8AsymEsDy9pcfiEfsDKit9EVllkkesc6R+uMEhuJ669JrB05lVZM+0oOThwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dfDGjcho; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706184912; x=1737720912;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0MQXl5mvTmeLTzTGvou1AzDpV1uX0rJdnRYCdYPetBA=;
  b=dfDGjchoo8hxeH+gCz7+O0njqd6c2XrNz7Pv8yfmr71caUbZeIKPZr5T
   cOEL8UjjmQHDEqUEiiAOUdHyYf4DwyQD2d1qpOuluqaw3W+jGAXezP/ga
   0MIPWGMa+OtwXB156J/qmijXYWOYvoZQP2QVfOSaQSOpbDvOqKHG5OzU9
   l+ZtXK5mpS0U3vgIpY028c8kyYtB289wp+0ObReQ1/MgvD6v0RXuImwLM
   BdMivFFHnMGlEAoB1mu8GqO/4I56zfPwSiaCYTI/c/qHhfGSwk2DfZSLw
   wwXQaa7q9TIUfwKuk3MeEbVVI3Pjh8XrQUi2JsgoyihjQaJT0PleG4Nkj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="433298523"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="433298523"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 04:15:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2232774"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.252.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 04:14:59 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 25 Jan 2024 14:14:55 +0200 (EET)
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc: Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com, 
    shuah@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 2/5] selftests/resctrl: Add helpers for the non-contiguous
 test
In-Reply-To: <85b1efc3ddd698b3ac81aa72a6dc987ee17da3e2.1706180726.git.maciej.wieczor-retman@intel.com>
Message-ID: <ea9b0e06-c07e-eb4b-9e7d-ed20419b677d@linux.intel.com>
References: <cover.1706180726.git.maciej.wieczor-retman@intel.com> <85b1efc3ddd698b3ac81aa72a6dc987ee17da3e2.1706180726.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 25 Jan 2024, Maciej Wieczor-Retman wrote:

> The CAT non-contiguous selftests have to read the file responsible for
> reporting support of non-contiguous CBMs in kernel (resctrl). Then the
> test compares if that information matches what is reported by CPUID
> output.
> 
> Add a generic helper function to read an unsigned number from a file in
> /sys/fs/resctrl/info/<RESOURCE>/<FILE>.
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v3:
> - Rewrite patch message.
> - Add documentation and rewrote the function. (Reinette)
> 
> Changelog v2:
> - Add this patch.
> 
>  tools/testing/selftests/resctrl/resctrl.h   |  1 +
>  tools/testing/selftests/resctrl/resctrlfs.c | 39 +++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index a1462029998e..5116ea082d03 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -162,6 +162,7 @@ unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
>  int get_full_cbm(const char *cache_type, unsigned long *mask);
>  int get_mask_no_shareable(const char *cache_type, unsigned long *mask);
>  int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
> +int resource_info_unsigned_get(const char *resource, const char *filename, unsigned int *val);
>  void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
>  int signal_handler_register(void);
>  void signal_handler_unregister(void);
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 5750662cce57..cb5147c5f9a9 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -249,6 +249,45 @@ static int get_bit_mask(const char *filename, unsigned long *mask)
>  	return 0;
>  }
>  
> +/*
> + * resource_info_unsigned_get - Read an unsigned value from a file in
> + * /sys/fs/resctrl/info/RESOURCE/FILENAME
> + * @resource:	Resource name that matches directory names in
> + *		/sys/fs/resctrl/info
> + * @filename:	Filename of a file located in a directory specified with the
> + *		'resource' variable.
> + * @val:	Variable where the read value is saved on success.
> + *
> + * Return: = 0 on success, < 0 on failure. On success the read value is saved into the 'val'
> + * variable.
> + */
> +int resource_info_unsigned_get(const char *resource, const char *filename,
> +			       unsigned int *val)
> +{
> +	char reason[128], file_path[PATH_MAX];
> +	FILE *fp;
> +
> +	snprintf(file_path, sizeof(file_path), "%s/%s/%s", INFO_PATH, resource,
> +		 filename);
> +
> +	fp = fopen(file_path, "r");
> +	if (!fp) {
> +		snprintf(reason, sizeof(reason), "Error in opening %s file\n", filename);
> +		ksft_perror(reason);

Was this the conclusion of the kstf_perror() discussion with Reinette? I 
expected a bit different outcome when I stopped following it...

In any case, it would be nice though if ksft_perror() (or some kselftest.h 
function yet to be added with a different name) would accept full printf 
interface and just add the errno string into the end of the string so one 
would not need to build constructs like this at all.

It will require a bit of macro trickery into kselftest.h. I don't know how 
it should handle the case where somebody just passes a char pointer to it, 
not a string literal, but I guess it would just throw an error while 
compiling if somebody tries to do that as the macro string literal 
concatenation could not build useful/compilable token.

It would make these prints informative enough to become actually useful 
without needed to resort to preparing the string in advance which seems
to be required almost every single case with the current interface.

> +		return -1;
> +	}
> +
> +	if (fscanf(fp, "%u", val) <= 0) {
> +		snprintf(reason, sizeof(reason), "Could not get %s's contents\n", filename);
> +		ksft_perror(reason);
> +		fclose(fp);
> +		return -1;
> +	}
> +
> +	fclose(fp);
> +	return 0;
> +}
> +
>  /*
>   * create_bit_mask- Create bit mask from start, len pair
>   * @start:	LSB of the mask
> 

-- 
 i.


